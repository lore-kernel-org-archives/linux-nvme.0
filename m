From: keith.busch@intel.com (Keith Busch)
Date: Tue, 1 Jul 2014 11:47:26 -0600 (MDT)
Subject: NVME Kernel Panic due to nvme_free_queue running from call_rcu
In-Reply-To: <CAFJTrDswXgoe5GR9OkryfNFyzgLmpKoVe-QhnwMCUJhA3WjmTA@mail.gmail.com>
References: <CAFJTrDswXgoe5GR9OkryfNFyzgLmpKoVe-QhnwMCUJhA3WjmTA@mail.gmail.com>
Message-ID: <alpine.LRH.2.03.1407011059420.4703@AMR>

On Tue, 1 Jul 2014, Matthew Minter wrote:
> Fixes: 5a92e700af2e ("NVMe: RCU protected access to io queues")
>
> Signed-off-by: matthew_minter <matthew_minter at xyratex.com>
> ---
> drivers/block/nvme-core.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
> index 28aec2d..a3755ea 100644
> --- a/drivers/block/nvme-core.c
> +++ b/drivers/block/nvme-core.c
> @@ -1225,7 +1225,8 @@ static void nvme_free_queues(struct nvme_dev
> *dev, int lowest)
>        for (i = dev->queue_count - 1; i >= lowest; i--) {
>                struct nvme_queue *nvmeq = raw_nvmeq(dev, i);
>                rcu_assign_pointer(dev->queues[i], NULL);
> -               call_rcu(&nvmeq->r_head, nvme_free_queue);
> +               synchronize_rcu();
> +               nvme_free_queue(&nvmeq->r_head);
>                dev->queue_count--;
>        }
> }

Darn, that's my patch you're fixing, so that hurts. :( But thanks for
pointing out the arch differences.

We can have many dozens of queues and that many calls to synchronize_rcu()
can make the unload take a long time. Maybe replace the nvmeq's
rcu_head with a list_head, put the nvmeqs on a remove list after calling
rcu_assign_pointer(), call synchronize_rcu() once, then loop through
the list to free them, kinda like this:

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 02351e2..ccef911 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -90,7 +90,7 @@ struct async_cmd_info {
   * commands and one for I/O commands).
   */
  struct nvme_queue {
-	struct rcu_head r_head;
+	struct list_head r_head;
  	struct device *q_dmadev;
  	struct nvme_dev *dev;
  	char irqname[24];	/* nvme4294967295-65535\0 */
@@ -1172,10 +1172,8 @@ static void nvme_cancel_ios(struct nvme_queue *nvmeq, bool timeout)
  	}
  }

-static void nvme_free_queue(struct rcu_head *r)
+static void nvme_free_queue(struct nvme_queue *nvmeq)
  {
-	struct nvme_queue *nvmeq = container_of(r, struct nvme_queue, r_head);
-
  	spin_lock_irq(&nvmeq->q_lock);
  	while (bio_list_peek(&nvmeq->sq_cong)) {
  		struct bio *bio = bio_list_pop(&nvmeq->sq_cong);
@@ -1206,13 +1204,21 @@ static void nvme_free_queue(struct rcu_head *r)
  static void nvme_free_queues(struct nvme_dev *dev, int lowest)
  {
  	int i;
+	LIST_HEAD(q_list);
+	struct nvme_queue *nvmeq, *next;

  	for (i = dev->queue_count - 1; i >= lowest; i--) {
-		struct nvme_queue *nvmeq = raw_nvmeq(dev, i);
+		nvmeq = raw_nvmeq(dev, i);
  		rcu_assign_pointer(dev->queues[i], NULL);
-		call_rcu(&nvmeq->r_head, nvme_free_queue);
+		list_add_tail(&nvmeq->r_head, &q_list);
  		dev->queue_count--;
  	}
+
+	synchronize_rcu();
+	list_for_each_entry_safe(nvmeq, next, &q_list, r_head) {
+		list_del(&nvmeq->r_head);
+		nvme_free_queue(nvmeq);
+	}
  }

  /**
@@ -2857,7 +2863,6 @@ static void nvme_remove(struct pci_dev *pdev)
  	nvme_dev_remove(dev);
  	nvme_dev_shutdown(dev);
  	nvme_free_queues(dev, 0);
-	rcu_barrier();
  	nvme_release_instance(dev);
  	nvme_release_prp_pools(dev);
  	kref_put(&dev->kref, nvme_free_dev);

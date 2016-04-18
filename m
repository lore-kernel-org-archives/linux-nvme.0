From: mlin@kernel.org (Ming Lin)
Date: Mon, 18 Apr 2016 15:56:18 -0700
Subject: [PATCH] nvme: fix nvme_ns_remove() deadlock
In-Reply-To: <20160418203714.GA6484@lst.de>
References: <1461003703-18950-1-git-send-email-mlin@kernel.org>
 <20160418183214.GC4640@localhost.localdomain>
 <20160418203714.GA6484@lst.de>
Message-ID: <1461020178.1419.2.camel@ssi>

On Mon, 2016-04-18@22:37 +0200, Christoph Hellwig wrote:
> On Mon, Apr 18, 2016@06:32:15PM +0000, Keith Busch wrote:
> > This fixes one deadlock by introducing another.
> > 
> > The reason we don't hold the namespace lock during nvme_ns_remove is
> > because del_gendisk blocks until all IO is flushed. If the controller
> > fails during this, you'll deadlock nvme_dev_disable as it tries to
> > recover. 
> 
> Should we switch to RCU freeing the namespace structure?  If we do
> that nvme_start_queues, nvme_stop_queues and nvme_kill_queues would
> be able to get away with only a RCU read side critical section,
> and Mings should be fine on top of that.

You mean below changes(un-tested)?

 drivers/nvme/host/core.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 97a15e1..6942b04 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1569,7 +1569,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	if (nvme_revalidate_disk(ns->disk))
 		goto out_free_disk;
 
-	list_add_tail(&ns->list, &ctrl->namespaces);
+	list_add_tail_rcu(&ns->list, &ctrl->namespaces);
 	kref_get(&ctrl->kref);
 	if (ns->type == NVME_NS_LIGHTNVM)
 		return;
@@ -1607,6 +1607,7 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 		blk_cleanup_queue(ns->queue);
 	}
 	list_del_init(&ns->list);
+	synchronize_rcu();
 	nvme_put_ns(ns);
 }
 
@@ -1819,8 +1820,8 @@ void nvme_kill_queues(struct nvme_ctrl *ctrl)
 {
 	struct nvme_ns *ns;
 
-	mutex_lock(&ctrl->namespaces_mutex);
-	list_for_each_entry(ns, &ctrl->namespaces, list) {
+	rcu_read_lock();
+	list_for_each_entry_rcu(ns, &ctrl->namespaces, list) {
 		if (!kref_get_unless_zero(&ns->kref))
 			continue;
 
@@ -1837,7 +1838,7 @@ void nvme_kill_queues(struct nvme_ctrl *ctrl)
 
 		nvme_put_ns(ns);
 	}
-	mutex_unlock(&ctrl->namespaces_mutex);
+	rcu_read_unlock();
 }
 EXPORT_SYMBOL_GPL(nvme_kill_queues);
 
@@ -1845,8 +1846,8 @@ void nvme_stop_queues(struct nvme_ctrl *ctrl)
 {
 	struct nvme_ns *ns;
 
-	mutex_lock(&ctrl->namespaces_mutex);
-	list_for_each_entry(ns, &ctrl->namespaces, list) {
+	rcu_read_lock();
+	list_for_each_entry_rcu(ns, &ctrl->namespaces, list) {
 		spin_lock_irq(ns->queue->queue_lock);
 		queue_flag_set(QUEUE_FLAG_STOPPED, ns->queue);
 		spin_unlock_irq(ns->queue->queue_lock);
@@ -1854,7 +1855,7 @@ void nvme_stop_queues(struct nvme_ctrl *ctrl)
 		blk_mq_cancel_requeue_work(ns->queue);
 		blk_mq_stop_hw_queues(ns->queue);
 	}
-	mutex_unlock(&ctrl->namespaces_mutex);
+	rcu_read_unlock();
 }
 EXPORT_SYMBOL_GPL(nvme_stop_queues);
 
@@ -1862,13 +1863,13 @@ void nvme_start_queues(struct nvme_ctrl *ctrl)
 {
 	struct nvme_ns *ns;
 
-	mutex_lock(&ctrl->namespaces_mutex);
-	list_for_each_entry(ns, &ctrl->namespaces, list) {
+	rcu_read_lock();
+	list_for_each_entry_rcu(ns, &ctrl->namespaces, list) {
 		queue_flag_clear_unlocked(QUEUE_FLAG_STOPPED, ns->queue);
 		blk_mq_start_stopped_hw_queues(ns->queue, true);
 		blk_mq_kick_requeue_list(ns->queue);
 	}
-	mutex_unlock(&ctrl->namespaces_mutex);
+	rcu_read_unlock();
 }
 EXPORT_SYMBOL_GPL(nvme_start_queues);
 

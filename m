From: keith.busch@intel.com (Keith Busch)
Date: Mon, 22 Dec 2014 18:42:10 +0000 (UTC)
Subject: [PATCHv2] NVMe: Fix double free irq
In-Reply-To: <1419273081-13080-1-git-send-email-keith.busch@intel.com>
References: <1419273081-13080-1-git-send-email-keith.busch@intel.com>
Message-ID: <alpine.LNX.2.00.1412221840260.4026@localhost.lm.intel.com>

... and Willy reminded me you can't have more than 2k MSI-x vectors, so
int is overkill. We can just change the int to s16 below, and alignment
is still fine.

On Mon, 22 Dec 2014, Keith Busch wrote:
> Sets the vector to an invalid value after it's freed so we don't free
> it twice.
>
> Signed-off-by: Keith Busch <keith.busch at intel.com>
> ---
> Obsoletes this one:
>
>  http://lists.infradead.org/pipermail/linux-nvme/2014-December/001356.html
>
> v1->v2:
>  Fixed struct alignment, verified with 'pahole'.
>  Fixed initial setting of IO queue cq_vector to before creating the cq.
>
> drivers/block/nvme-core.c |   19 +++++++++++++------
> 1 file changed, 13 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
> index aa6be45..6c4c628 100644
> --- a/drivers/block/nvme-core.c
> +++ b/drivers/block/nvme-core.c
> @@ -105,8 +105,8 @@ struct nvme_queue {
> 	dma_addr_t sq_dma_addr;
> 	dma_addr_t cq_dma_addr;
> 	u32 __iomem *q_db;
> +	int cq_vector;
> 	u16 q_depth;
> -	u16 cq_vector;
> 	u16 sq_head;
> 	u16 sq_tail;
> 	u16 cq_head;
> @@ -1131,10 +1131,16 @@ static void nvme_free_queues(struct nvme_dev *dev, int lowest)
>  */
> static int nvme_suspend_queue(struct nvme_queue *nvmeq)
> {
> -	int vector = nvmeq->dev->entry[nvmeq->cq_vector].vector;
> +	int vector;
>
> 	spin_lock_irq(&nvmeq->q_lock);
> +	if (nvmeq->cq_vector == -1) {
> +		spin_unlock_irq(&nvmeq->q_lock);
> +		return 1;
> +	}
> +	vector = nvmeq->dev->entry[nvmeq->cq_vector].vector;
> 	nvmeq->dev->online_queues--;
> +	nvmeq->cq_vector = -1;
> 	spin_unlock_irq(&nvmeq->q_lock);
>
> 	irq_set_affinity_hint(vector, NULL);
> @@ -1173,7 +1179,7 @@ static void nvme_disable_queue(struct nvme_dev *dev, int qid)
> }
>
> static struct nvme_queue *nvme_alloc_queue(struct nvme_dev *dev, int qid,
> -							int depth, int vector)
> +							int depth)
> {
> 	struct device *dmadev = &dev->pci_dev->dev;
> 	struct nvme_queue *nvmeq = kzalloc(sizeof(*nvmeq), GFP_KERNEL);
> @@ -1199,7 +1205,6 @@ static struct nvme_queue *nvme_alloc_queue(struct nvme_dev *dev, int qid,
> 	nvmeq->cq_phase = 1;
> 	nvmeq->q_db = &dev->dbs[qid * 2 * dev->db_stride];
> 	nvmeq->q_depth = depth;
> -	nvmeq->cq_vector = vector;
> 	nvmeq->qid = qid;
> 	dev->queue_count++;
> 	dev->queues[qid] = nvmeq;
> @@ -1244,6 +1249,7 @@ static int nvme_create_queue(struct nvme_queue *nvmeq, int qid)
> 	struct nvme_dev *dev = nvmeq->dev;
> 	int result;
>
> +	nvmeq->cq_vector = qid - 1;
> 	result = adapter_alloc_cq(dev, qid, nvmeq);
> 	if (result < 0)
> 		return result;
> @@ -1416,7 +1422,7 @@ static int nvme_configure_admin_queue(struct nvme_dev *dev)
>
> 	nvmeq = dev->queues[0];
> 	if (!nvmeq) {
> -		nvmeq = nvme_alloc_queue(dev, 0, NVME_AQ_DEPTH, 0);
> +		nvmeq = nvme_alloc_queue(dev, 0, NVME_AQ_DEPTH);
> 		if (!nvmeq)
> 			return -ENOMEM;
> 	}
> @@ -1443,6 +1449,7 @@ static int nvme_configure_admin_queue(struct nvme_dev *dev)
> 	if (result)
> 		goto free_nvmeq;
>
> +	nvmeq->cq_vector = 0;
> 	result = queue_request_irq(dev, nvmeq, nvmeq->irqname);
> 	if (result)
> 		goto free_tags;
> @@ -1944,7 +1951,7 @@ static void nvme_create_io_queues(struct nvme_dev *dev)
> 	unsigned i;
>
> 	for (i = dev->queue_count; i <= dev->max_qid; i++)
> -		if (!nvme_alloc_queue(dev, i, dev->q_depth, i - 1))
> +		if (!nvme_alloc_queue(dev, i, dev->q_depth))
> 			break;
>
> 	for (i = dev->online_queues; i <= dev->queue_count - 1; i++)
> -- 
> 1.7.10.4
>
>

From: jsmart2021@gmail.com (James Smart)
Date: Fri, 15 Mar 2019 09:33:39 -0700
Subject: [PATCH 7/8] nvme: use blk_mq_queue_tag_busy_iter
In-Reply-To: <1552640264-26101-8-git-send-email-jianchao.w.wang@oracle.com>
References: <1552640264-26101-1-git-send-email-jianchao.w.wang@oracle.com>
 <1552640264-26101-8-git-send-email-jianchao.w.wang@oracle.com>
Message-ID: <62de99e8-0d8d-910a-bfdc-649f734b152c@gmail.com>

On 3/15/2019 1:57 AM, Jianchao Wang wrote:
> blk_mq_tagset_busy_iter is not safe that it could get stale request
> in tags->rqs[]. Use blk_mq_queue_tag_busy_iter here. A new helper
> interface nvme_iterate_inflight_rqs is introduced to iterate
> all of the ns under a ctrl.
> 
> Signed-off-by: Jianchao Wang <jianchao.w.wang at oracle.com>
> ---
>   drivers/nvme/host/core.c   | 12 ++++++++++++
>   drivers/nvme/host/fc.c     | 12 ++++++------
>   drivers/nvme/host/nvme.h   |  2 ++
>   drivers/nvme/host/pci.c    |  5 +++--
>   drivers/nvme/host/rdma.c   |  6 +++---
>   drivers/nvme/host/tcp.c    |  5 +++--
>   drivers/nvme/target/loop.c |  6 +++---
>   7 files changed, 32 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 6a9dd68..5760fad 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3816,6 +3816,18 @@ void nvme_start_queues(struct nvme_ctrl *ctrl)
>   }
>   EXPORT_SYMBOL_GPL(nvme_start_queues);
>   
> +void nvme_iterate_inflight_rqs(struct nvme_ctrl *ctrl,
> +		busy_iter_fn *fn, void *data)
> +{
> +	struct nvme_ns *ns;
> +
> +	down_read(&ctrl->namespaces_rwsem);
> +	list_for_each_entry(ns, &ctrl->namespaces, list)
> +		blk_mq_queue_tag_busy_iter(ns->queue, fn, data, true);
> +	up_read(&ctrl->namespaces_rwsem);
> +}
> +EXPORT_SYMBOL_GPL(nvme_iterate_inflight_rqs);

Hmm... so this aborts ios for namespaces. How about ios that aren't for 
a namespace but rather for the controller itself.  For example, anything 
on the admin queue ?   Rather critical for those ios be terminated as well.

-- james

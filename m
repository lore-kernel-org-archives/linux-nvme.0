From: m@bjorling.me (=?UTF-8?Q?Matias_Bj=c3=b8rling?=)
Date: Tue, 9 Feb 2016 13:56:36 +0100
Subject: [PATCH 2/4] nvme: export more symbols
In-Reply-To: <1454970284-29543-3-git-send-email-mlin@kernel.org>
References: <1454970284-29543-1-git-send-email-mlin@kernel.org>
 <1454970284-29543-3-git-send-email-mlin@kernel.org>
Message-ID: <56B9E204.4080702@bjorling.me>

On 02/08/2016 11:24 PM, Ming Lin wrote:
> Signed-off-by: Ming Lin <ming.l at ssi.samsung.com>
> ---
>  drivers/nvme/host/core.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 3faed20..8e4b8ac 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -102,6 +102,7 @@ void nvme_requeue_req(struct request *req)
>  		blk_mq_kick_requeue_list(req->q);
>  	spin_unlock_irqrestore(req->q->queue_lock, flags);
>  }
> +EXPORT_SYMBOL_GPL(nvme_requeue_req);
>  
>  struct request *nvme_alloc_request(struct request_queue *q,
>  		struct nvme_command *cmd, unsigned int flags)
> @@ -125,6 +126,7 @@ struct request *nvme_alloc_request(struct request_queue *q,
>  
>  	return req;
>  }
> +EXPORT_SYMBOL_GPL(nvme_alloc_request);
>  
>  /*
>   * Returns 0 on success.  If the result is negative, it's a Linux error code;
> @@ -162,6 +164,7 @@ int nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
>  {
>  	return __nvme_submit_sync_cmd(q, cmd, buffer, bufflen, NULL, 0);
>  }
> +EXPORT_SYMBOL_GPL(nvme_submit_sync_cmd);
>  
>  int __nvme_submit_user_cmd(struct request_queue *q, struct nvme_command *cmd,
>  		void __user *ubuffer, unsigned bufflen,
> @@ -377,6 +380,7 @@ int nvme_set_queue_count(struct nvme_ctrl *ctrl, int *count)
>  	*count = min(*count, nr_io_queues);
>  	return 0;
>  }
> +EXPORT_SYMBOL_GPL(nvme_set_queue_count);
>  
>  static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
>  {
> @@ -783,6 +787,7 @@ int nvme_disable_ctrl(struct nvme_ctrl *ctrl, u64 cap)
>  		return ret;
>  	return nvme_wait_ready(ctrl, cap, false);
>  }
> +EXPORT_SYMBOL_GPL(nvme_disable_ctrl);
>  
>  int nvme_enable_ctrl(struct nvme_ctrl *ctrl, u64 cap)
>  {
> @@ -814,6 +819,7 @@ int nvme_enable_ctrl(struct nvme_ctrl *ctrl, u64 cap)
>  		return ret;
>  	return nvme_wait_ready(ctrl, cap, true);
>  }
> +EXPORT_SYMBOL_GPL(nvme_enable_ctrl);
>  
>  int nvme_shutdown_ctrl(struct nvme_ctrl *ctrl)
>  {
> @@ -844,6 +850,7 @@ int nvme_shutdown_ctrl(struct nvme_ctrl *ctrl)
>  
>  	return ret;
>  }
> +EXPORT_SYMBOL_GPL(nvme_shutdown_ctrl);
>  
>  /*
>   * Initialize the cached copies of the Identify data and various controller
> @@ -905,6 +912,7 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
>  	kfree(id);
>  	return 0;
>  }
> +EXPORT_SYMBOL_GPL(nvme_init_identify);
>  
>  static int nvme_dev_open(struct inode *inode, struct file *file)
>  {
> @@ -1310,6 +1318,7 @@ void nvme_scan_namespaces(struct nvme_ctrl *ctrl)
>  	mutex_unlock(&ctrl->namespaces_mutex);
>  	kfree(id);
>  }
> +EXPORT_SYMBOL_GPL(nvme_scan_namespaces);
>  
>  void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
>  {
> @@ -1320,6 +1329,7 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
>  		nvme_ns_remove(ns);
>  	mutex_unlock(&ctrl->namespaces_mutex);
>  }
> +EXPORT_SYMBOL_GPL(nvme_remove_namespaces);
>  
>  static DEFINE_IDA(nvme_instance_ida);
>  
> @@ -1351,13 +1361,14 @@ static void nvme_release_instance(struct nvme_ctrl *ctrl)
>  }
>  
>  void nvme_uninit_ctrl(struct nvme_ctrl *ctrl)
> - {
> +{
>  	device_destroy(nvme_class, MKDEV(nvme_char_major, ctrl->instance));
>  
>  	spin_lock(&dev_list_lock);
>  	list_del(&ctrl->node);
>  	spin_unlock(&dev_list_lock);
>  }
> +EXPORT_SYMBOL_GPL(nvme_uninit_ctrl);
>  
>  static void nvme_free_ctrl(struct kref *kref)
>  {
> @@ -1373,6 +1384,7 @@ void nvme_put_ctrl(struct nvme_ctrl *ctrl)
>  {
>  	kref_put(&ctrl->kref, nvme_free_ctrl);
>  }
> +EXPORT_SYMBOL_GPL(nvme_put_ctrl);
>  
>  /*
>   * Initialize a NVMe controller structures.  This needs to be called during
> @@ -1416,6 +1428,7 @@ out_release_instance:
>  out:
>  	return ret;
>  }
> +EXPORT_SYMBOL_GPL(nvme_init_ctrl);
>  
>  void nvme_stop_queues(struct nvme_ctrl *ctrl)
>  {
> @@ -1432,6 +1445,7 @@ void nvme_stop_queues(struct nvme_ctrl *ctrl)
>  	}
>  	mutex_unlock(&ctrl->namespaces_mutex);
>  }
> +EXPORT_SYMBOL_GPL(nvme_stop_queues);
>  
>  void nvme_start_queues(struct nvme_ctrl *ctrl)
>  {
> @@ -1445,6 +1459,7 @@ void nvme_start_queues(struct nvme_ctrl *ctrl)
>  	}
>  	mutex_unlock(&ctrl->namespaces_mutex);
>  }
> +EXPORT_SYMBOL_GPL(nvme_start_queues);
>  
>  int __init nvme_core_init(void)
>  {
> 

Hi Ming,

Can these be exported without _GPL?

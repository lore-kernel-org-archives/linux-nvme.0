From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Sun, 2 Jun 2019 22:49:04 +0000
Subject: [PATCH v2 1/3] nvme: prepare for fault injection into admin
 commands
References: <1559483421-11361-1-git-send-email-akinobu.mita@gmail.com>
 <1559483421-11361-2-git-send-email-akinobu.mita@gmail.com>
Message-ID: <BYAPR04MB57493EBBA22254D3B81EA6B2861B0@BYAPR04MB5749.namprd04.prod.outlook.com>

Looks good to me.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
On 6/2/19 6:51 AM, Akinobu Mita wrote:
> Currenlty fault injection support for nvme only enables to inject errors
> into the commands submitted to I/O queues.
>
> In preparation for fault injection into the admin commands, this makes
> the helper functions independent of struct nvme_ns.
>
> Cc: Thomas Tai <thomas.tai at oracle.com>
> Cc: Keith Busch <kbusch at kernel.org>
> Cc: Jens Axboe <axboe at fb.com>
> Cc: Christoph Hellwig <hch at lst.de>
> Cc: Sagi Grimberg <sagi at grimberg.me>
> Cc: Minwoo Im <minwoo.im.dev at gmail.com>
> Signed-off-by: Akinobu Mita <akinobu.mita at gmail.com>
> Reviewed-by: Minwoo Im <minwoo.im.dev at gmail.com>
> Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
> ---
> * v2
> - rename the argument 'name' to 'dev_name'
> - add Reviewed-by tags
>
>  drivers/nvme/host/core.c         |  4 ++--
>  drivers/nvme/host/fault_inject.c | 34 ++++++++++++++++++----------------
>  drivers/nvme/host/nvme.h         | 20 ++++++++++++--------
>  3 files changed, 32 insertions(+), 26 deletions(-)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 26c8b59..9fca8457 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3698,7 +3698,7 @@ static int nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
>  	device_add_disk(ctrl->device, ns->disk, nvme_ns_id_attr_groups);
>  
>  	nvme_mpath_add_disk(ns, id);
> -	nvme_fault_inject_init(ns);
> +	nvme_fault_inject_init(&ns->fault_inject, ns->disk->disk_name);
>  	kfree(id);
>  
>  	return 0;
> @@ -3723,7 +3723,7 @@ static void nvme_ns_remove(struct nvme_ns *ns)
>  	if (test_and_set_bit(NVME_NS_REMOVING, &ns->flags))
>  		return;
>  
> -	nvme_fault_inject_fini(ns);
> +	nvme_fault_inject_fini(&ns->fault_inject);
>  	if (ns->disk && ns->disk->flags & GENHD_FL_UP) {
>  		del_gendisk(ns->disk);
>  		blk_cleanup_queue(ns->queue);
> diff --git a/drivers/nvme/host/fault_inject.c b/drivers/nvme/host/fault_inject.c
> index 4cfd2c9..18ad983 100644
> --- a/drivers/nvme/host/fault_inject.c
> +++ b/drivers/nvme/host/fault_inject.c
> @@ -15,11 +15,10 @@ static DECLARE_FAULT_ATTR(fail_default_attr);
>  static char *fail_request;
>  module_param(fail_request, charp, 0000);
>  
> -void nvme_fault_inject_init(struct nvme_ns *ns)
> +void nvme_fault_inject_init(struct nvme_fault_inject *fault_inj,
> +			    const char *dev_name)
>  {
>  	struct dentry *dir, *parent;
> -	char *name = ns->disk->disk_name;
> -	struct nvme_fault_inject *fault_inj = &ns->fault_inject;
>  	struct fault_attr *attr = &fault_inj->attr;
>  
>  	/* set default fault injection attribute */
> @@ -27,20 +26,20 @@ void nvme_fault_inject_init(struct nvme_ns *ns)
>  		setup_fault_attr(&fail_default_attr, fail_request);
>  
>  	/* create debugfs directory and attribute */
> -	parent = debugfs_create_dir(name, NULL);
> +	parent = debugfs_create_dir(dev_name, NULL);
>  	if (!parent) {
> -		pr_warn("%s: failed to create debugfs directory\n", name);
> +		pr_warn("%s: failed to create debugfs directory\n", dev_name);
>  		return;
>  	}
>  
>  	*attr = fail_default_attr;
>  	dir = fault_create_debugfs_attr("fault_inject", parent, attr);
>  	if (IS_ERR(dir)) {
> -		pr_warn("%s: failed to create debugfs attr\n", name);
> +		pr_warn("%s: failed to create debugfs attr\n", dev_name);
>  		debugfs_remove_recursive(parent);
>  		return;
>  	}
> -	ns->fault_inject.parent = parent;
> +	fault_inj->parent = parent;
>  
>  	/* create debugfs for status code and dont_retry */
>  	fault_inj->status = NVME_SC_INVALID_OPCODE;
> @@ -49,29 +48,32 @@ void nvme_fault_inject_init(struct nvme_ns *ns)
>  	debugfs_create_bool("dont_retry", 0600, dir, &fault_inj->dont_retry);
>  }
>  
> -void nvme_fault_inject_fini(struct nvme_ns *ns)
> +void nvme_fault_inject_fini(struct nvme_fault_inject *fault_inject)
>  {
>  	/* remove debugfs directories */
> -	debugfs_remove_recursive(ns->fault_inject.parent);
> +	debugfs_remove_recursive(fault_inject->parent);
>  }
>  
>  void nvme_should_fail(struct request *req)
>  {
>  	struct gendisk *disk = req->rq_disk;
> -	struct nvme_ns *ns = NULL;
> +	struct nvme_fault_inject *fault_inject = NULL;
>  	u16 status;
>  
>  	/*
>  	 * make sure this request is coming from a valid namespace
>  	 */
> -	if (!disk)
> -		return;
> +	if (disk) {
> +		struct nvme_ns *ns = disk->private_data;
> +
> +		if (ns)
> +			fault_inject = &ns->fault_inject;
> +	}
>  
> -	ns = disk->private_data;
> -	if (ns && should_fail(&ns->fault_inject.attr, 1)) {
> +	if (fault_inject && should_fail(&fault_inject->attr, 1)) {
>  		/* inject status code and DNR bit */
> -		status = ns->fault_inject.status;
> -		if (ns->fault_inject.dont_retry)
> +		status = fault_inject->status;
> +		if (fault_inject->dont_retry)
>  			status |= NVME_SC_DNR;
>  		nvme_req(req)->status =	status;
>  	}
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 53f0b24..c1658ed 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -323,14 +323,14 @@ struct nvme_ns_head {
>  #endif
>  };
>  
> -#ifdef CONFIG_FAULT_INJECTION_DEBUG_FS
>  struct nvme_fault_inject {
> +#ifdef CONFIG_FAULT_INJECTION_DEBUG_FS
>  	struct fault_attr attr;
>  	struct dentry *parent;
>  	bool dont_retry;	/* DNR, do not retry */
>  	u16 status;		/* status code */
> -};
>  #endif
> +};
>  
>  struct nvme_ns {
>  	struct list_head list;
> @@ -359,9 +359,7 @@ struct nvme_ns {
>  #define NVME_NS_ANA_PENDING	2
>  	u16 noiob;
>  
> -#ifdef CONFIG_FAULT_INJECTION_DEBUG_FS
>  	struct nvme_fault_inject fault_inject;
> -#endif
>  
>  };
>  
> @@ -382,12 +380,18 @@ struct nvme_ctrl_ops {
>  };
>  
>  #ifdef CONFIG_FAULT_INJECTION_DEBUG_FS
> -void nvme_fault_inject_init(struct nvme_ns *ns);
> -void nvme_fault_inject_fini(struct nvme_ns *ns);
> +void nvme_fault_inject_init(struct nvme_fault_inject *fault_inj,
> +			    const char *dev_name);
> +void nvme_fault_inject_fini(struct nvme_fault_inject *fault_inject);
>  void nvme_should_fail(struct request *req);
>  #else
> -static inline void nvme_fault_inject_init(struct nvme_ns *ns) {}
> -static inline void nvme_fault_inject_fini(struct nvme_ns *ns) {}
> +static inline void nvme_fault_inject_init(struct nvme_fault_inject *fault_inj,
> +					  const char *dev_name)
> +{
> +}
> +static inline void nvme_fault_inject_fini(struct nvme_fault_inject *fault_inj)
> +{
> +}
>  static inline void nvme_should_fail(struct request *req) {}
>  #endif
>  

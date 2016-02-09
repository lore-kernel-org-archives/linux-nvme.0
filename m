From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Tue, 9 Feb 2016 13:41:34 +0100
Subject: [PATCH 3/4] nvme: split dev_list_lock
In-Reply-To: <1454970284-29543-4-git-send-email-mlin@kernel.org>
References: <1454970284-29543-1-git-send-email-mlin@kernel.org>
 <1454970284-29543-4-git-send-email-mlin@kernel.org>
Message-ID: <20160209124134.GM27969@c203.arch.suse.de>

On Mon, Feb 08, 2016@02:24:43PM -0800, Ming Lin wrote:
> Split dev_list_lock into one in the core and one in the PCI driver.

The dev_list_lock in core.c doesn't really protect the dev_list, like it does
in pci.c. Wouldn't it be better to rename it to something more appropriate? I
just can't come up with a name, as it seems to be some kind of catch all lock.

Otherwise

Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>
> 
> Signed-off-by: Ming Lin <ming.l at ssi.samsung.com>
> ---
>  drivers/nvme/host/core.c | 2 +-
>  drivers/nvme/host/nvme.h | 2 --
>  drivers/nvme/host/pci.c  | 1 +
>  3 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 8e4b8ac..3928366 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -54,7 +54,7 @@ static int nvme_char_major;
>  module_param(nvme_char_major, int, 0);
>  
>  static LIST_HEAD(nvme_ctrl_list);
> -DEFINE_SPINLOCK(dev_list_lock);
> +static DEFINE_SPINLOCK(dev_list_lock);
>  
>  static struct class *nvme_class;
>  
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 4fb5bb7..3cea0ed 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -265,8 +265,6 @@ int nvme_set_features(struct nvme_ctrl *dev, unsigned fid, unsigned dword11,
>  			dma_addr_t dma_addr, u32 *result);
>  int nvme_set_queue_count(struct nvme_ctrl *ctrl, int *count);
>  
> -extern spinlock_t dev_list_lock;
> -
>  struct sg_io_hdr;
>  
>  int nvme_sg_io(struct nvme_ns *ns, struct sg_io_hdr __user *u_hdr);
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index deba7ac..9797595 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -65,6 +65,7 @@ module_param(use_cmb_sqes, bool, 0644);
>  MODULE_PARM_DESC(use_cmb_sqes, "use controller's memory buffer for I/O SQes");
>  
>  static LIST_HEAD(dev_list);
> +static DEFINE_SPINLOCK(dev_list_lock);
>  static struct task_struct *nvme_thread;
>  static struct workqueue_struct *nvme_workq;
>  static wait_queue_head_t nvme_kthread_wait;
> -- 
> 1.9.1
> 
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850

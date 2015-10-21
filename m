From: james_p_freyensee@linux.intel.com (J Freyensee)
Date: Wed, 21 Oct 2015 16:27:39 -0700
Subject: [PATCH 17/18] nvme: move namespace scanning to common code
In-Reply-To: <1444975128-8768-18-git-send-email-hch@lst.de>
References: <1444975128-8768-1-git-send-email-hch@lst.de>
 <1444975128-8768-18-git-send-email-hch@lst.de>
Message-ID: <1445470059.3307.85.camel@linux.intel.com>

On Fri, 2015-10-16@07:58 +0200, Christoph Hellwig wrote:
> The namespace scanning code has been mostly generic already, we just
> need to store a pointer to the tagset in the nvme_ctrl structure, and
> add a method to check if a controller is I/O incapable.  The latter
> will hopefully be replaced by a proper controller state machine soon.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> ---
>  drivers/nvme/host/core.c | 190 
> +++++++++++++++++++++++++++++++++++++++-
>  drivers/nvme/host/nvme.h |  25 +++++-
>  drivers/nvme/host/pci.c  | 221 +++++++------------------------------
> ----------
>  3 files changed, 239 insertions(+), 197 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 3e88901..a01ab5a 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -17,6 +17,8 @@
>  #include <linux/errno.h>
>  #include <linux/hdreg.h>
>  #include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/list_sort.h>
>  #include <linux/slab.h>
>  #include <linux/types.h>
>  #include <linux/ptrace.h>
> @@ -26,6 +28,9 @@
>  
>  #include "nvme.h"
>  
> +static int nvme_major;
> +module_param(nvme_major, int, 0);
> +
>  DEFINE_SPINLOCK(dev_list_lock);
>  
>  static void nvme_free_ns(struct kref *kref)
> @@ -41,7 +46,7 @@ static void nvme_free_ns(struct kref *kref)
>  	kfree(ns);
>  }
>  
> -void nvme_put_ns(struct nvme_ns *ns)
> +static void nvme_put_ns(struct nvme_ns *ns)
>  {
>  	kref_put(&ns->kref, nvme_free_ns);
>  }
> @@ -503,7 +508,7 @@ static void nvme_config_discard(struct nvme_ns 
> *ns)
>  	queue_flag_set_unlocked(QUEUE_FLAG_DISCARD, ns->queue);
>  }
>  
> -int nvme_revalidate_disk(struct gendisk *disk)
> +static int nvme_revalidate_disk(struct gendisk *disk)
>  {
>  	struct nvme_ns *ns = disk->private_data;
>  	struct nvme_id_ns *id;
> @@ -564,7 +569,7 @@ int nvme_revalidate_disk(struct gendisk *disk)
>  	return 0;
>  }
>  
> -const struct block_device_operations nvme_fops = {
> +static const struct block_device_operations nvme_fops = {
>  	.owner		= THIS_MODULE,
>  	.ioctl		= nvme_ioctl,
>  	.compat_ioctl	= nvme_compat_ioctl,
> @@ -591,6 +596,7 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
>  		return ret;
>  	}
>  	page_shift = NVME_CAP_MPSMIN(cap) + 12;
> +	ctrl->page_size = 1 << page_shift;
>  
>  	ret = nvme_identify_ctrl(ctrl, &id);
>  	if (ret) {
> @@ -636,3 +642,181 @@ void nvme_put_ctrl(struct nvme_ctrl *ctrl)
>  	kref_put(&ctrl->kref, nvme_free_ctrl);
>  }
>  
> +static int ns_cmp(void *priv, struct list_head *a, struct list_head 
> *b)
> +{
> +	struct nvme_ns *nsa = container_of(a, struct nvme_ns, list);
> +	struct nvme_ns *nsb = container_of(b, struct nvme_ns, list);
> +
> +	return nsa->ns_id - nsb->ns_id;
> +}
> +
> +static struct nvme_ns *nvme_find_ns(struct nvme_ctrl *ctrl, unsigned 
> nsid)
> +{
> +	struct nvme_ns *ns;
> +
> +	list_for_each_entry(ns, &ctrl->namespaces, list) {

I know this is basically just a move into core.c, but with the concept
of namespace management in the 1.2 spec, would something like
list_for_each_entry_safe() and/or a spinlock be more appropriate?


> +		if (ns->ns_id == nsid)
> +			return ns;
> +		if (ns->ns_id > nsid)
> +			break;
> +	}
> +	return NULL;
> +}

<snip>

> +
>  static const struct nvme_ctrl_ops nvme_pci_ctrl_ops = {
>  	.reg_read32		= nvme_pci_reg_read32,
>  	.reg_read64		= nvme_pci_reg_read64,
> +	.io_incapable		= nvme_pci_io_incapable,
>  	.free_ctrl		= nvme_pci_free_ctrl,
>  };
>  
> @@ -2645,7 +2486,7 @@ static int nvme_probe(struct pci_dev *pdev, 
> const struct pci_device_id *id)
>  	if (!dev->queues)
>  		goto free;
>  
> -	INIT_LIST_HEAD(&dev->namespaces);
> +	INIT_LIST_HEAD(&dev->ctrl.namespaces);

OK, so I'm looking at your git repo:

http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/nvme
-split.5

and I see:

struct nvme_ctrl {
.
.
	struct list_head namespaces;
.
.
}

So that makes more sense, and I must have missed some code or future
patch.

>  	INIT_WORK(&dev->reset_work, nvme_reset_work);
>  	dev->dev = get_device(&pdev->dev);
>  	pci_set_drvdata(pdev, dev);
> @@ -2664,17 +2505,17 @@ static int nvme_probe(struct pci_dev *pdev, 
> const struct pci_device_id *id)
>  		goto release;
>  
>  	kref_init(&dev->ctrl.kref);
> -	dev->device = device_create(nvme_class, &pdev->dev,
> +	dev->ctrl.device = device_create(nvme_class, &pdev->dev,
>  				MKDEV(nvme_char_major, dev
> ->ctrl.instance),
>  				dev, "nvme%d", dev->ctrl.instance);
> -	if (IS_ERR(dev->device)) {
> -		result = PTR_ERR(dev->device);
> +	if (IS_ERR(dev->ctrl.device)) {
> +		result = PTR_ERR(dev->ctrl.device);
>  		goto release_pools;
>  	}
> -	get_device(dev->device);
> -	dev_set_drvdata(dev->device, dev);
> +	get_device(dev->ctrl.device);
> +	dev_set_drvdata(dev->ctrl.device, dev);
>  
> -	result = device_create_file(dev->device, 
> &dev_attr_reset_controller);
> +	result = device_create_file(dev->ctrl.device, 
> &dev_attr_reset_controller);
>  	if (result)
>  		goto put_dev;
>  
> @@ -2686,7 +2527,7 @@ static int nvme_probe(struct pci_dev *pdev, 
> const struct pci_device_id *id)
>  
>   put_dev:
>  	device_destroy(nvme_class, MKDEV(nvme_char_major, dev
> ->ctrl.instance));
> -	put_device(dev->device);
> +	put_device(dev->ctrl.device);
>   release_pools:
>  	nvme_release_prp_pools(dev);
>   release:
> @@ -2728,8 +2569,8 @@ static void nvme_remove(struct pci_dev *pdev)
>  	flush_work(&dev->probe_work);
>  	flush_work(&dev->reset_work);
>  	flush_work(&dev->scan_work);
> -	device_remove_file(dev->device, &dev_attr_reset_controller);
> -	nvme_dev_remove(dev);
> +	device_remove_file(dev->ctrl.device, 
> &dev_attr_reset_controller);
> +	nvme_remove_namespaces(&dev->ctrl);
>  	nvme_dev_shutdown(dev);
>  	nvme_dev_remove_admin(dev);
>  	device_destroy(nvme_class, MKDEV(nvme_char_major, dev
> ->ctrl.instance));
> @@ -2810,11 +2651,9 @@ static int __init nvme_init(void)
>  	if (!nvme_workq)
>  		return -ENOMEM;
>  
> -	result = register_blkdev(nvme_major, "nvme");
> +	result = nvme_core_init();
>  	if (result < 0)
>  		goto kill_workq;
> -	else if (result > 0)
> -		nvme_major = result;
>  
>  	result = __register_chrdev(nvme_char_major, 0, NVME_MINORS, 
> "nvme",
>  							&nvme_dev_fo
> ps);
> @@ -2839,7 +2678,7 @@ static int __init nvme_init(void)
>   unregister_chrdev:
>  	__unregister_chrdev(nvme_char_major, 0, NVME_MINORS, 
> "nvme");
>   unregister_blkdev:
> -	unregister_blkdev(nvme_major, "nvme");
> +	nvme_core_exit();
>   kill_workq:
>  	destroy_workqueue(nvme_workq);
>  	return result;
> @@ -2848,7 +2687,7 @@ static int __init nvme_init(void)
>  static void __exit nvme_exit(void)
>  {
>  	pci_unregister_driver(&nvme_driver);
> -	unregister_blkdev(nvme_major, "nvme");
> +	nvme_core_exit();
>  	destroy_workqueue(nvme_workq);
>  	class_destroy(nvme_class);
>  	__unregister_chrdev(nvme_char_major, 0, NVME_MINORS, 
> "nvme");

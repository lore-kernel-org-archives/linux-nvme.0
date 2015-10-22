From: james_p_freyensee@linux.intel.com (J Freyensee)
Date: Wed, 21 Oct 2015 17:11:11 -0700
Subject: [PATCH 18/18] nvme: move chardev and sysfs interface to common
 code
In-Reply-To: <1444975128-8768-19-git-send-email-hch@lst.de>
References: <1444975128-8768-1-git-send-email-hch@lst.de>
 <1444975128-8768-19-git-send-email-hch@lst.de>
Message-ID: <1445472671.3307.111.camel@linux.intel.com>

On Fri, 2015-10-16@07:58 +0200, Christoph Hellwig wrote:
> For this we need to add a proper controller init routine and a list 
> of
> all controllers that is in addition to the list of PCIe controllers,
> which stays in pci.c.  Note that we remove the sysfs device when the
> last reference to a controller is dropped now - the old code would 
> have
> kept it around longer, which doesn't make much sense.
> 
> This requires a new ->reset_ctrl operation to implement controleller

Controller got misspelled above.

> resets, and a new ->write_reg32 operation that is required to 
> implement
> subsystem resets.  We also now store caches copied of the NVMe 
> compliance
> version and the flag if a controller is attached to a subsystem or 
> not in
> the generic controller structure now.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> ---
>  drivers/nvme/host/core.c | 217 
> +++++++++++++++++++++++++++++++++++++++++++++--
>  drivers/nvme/host/nvme.h |  20 +++--
>  drivers/nvme/host/pci.c  | 202 +++++--------------------------------
> ------
>  drivers/nvme/host/scsi.c |   9 +-
>  4 files changed, 250 insertions(+), 198 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index a01ab5a..b8c72d2 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -28,11 +28,19 @@
>  
>  #include "nvme.h"
>  
> +#define NVME_MINORS		(1U << MINORBITS)
> +
>  static int nvme_major;
>  module_param(nvme_major, int, 0);
>  
> +static int nvme_char_major;
> +module_param(nvme_char_major, int, 0);
> +
> +static LIST_HEAD(nvme_ctrl_list);
>  DEFINE_SPINLOCK(dev_list_lock);
>  
> +static struct class *nvme_class;
> +
>  static void nvme_free_ns(struct kref *kref)
>  {
>  	struct nvme_ns *ns = container_of(kref, struct nvme_ns, 
> kref);
> @@ -358,7 +366,7 @@ static int nvme_submit_io(struct nvme_ns *ns, 
> struct nvme_user_io __user *uio)
>  			metadata, meta_len, io.slba, NULL, 0);
>  }
>  
> -int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
> +static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
>  			struct nvme_passthru_cmd __user *ucmd)
>  {
>  	struct nvme_passthru_cmd cmd;
> @@ -590,6 +598,12 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
>  	u64 cap;
>  	int ret, page_shift;
>  
> +	ret = ctrl->ops->reg_read32(ctrl, NVME_REG_VS, &ctrl->vs);
> +	if (ret) {
> +		dev_err(ctrl->dev, "Reading VS failed (%d)\n", ret);
> +		return ret;
> +	}
> +
>  	ret = ctrl->ops->reg_read64(ctrl, NVME_REG_CAP, &cap);
>  	if (ret) {
>  		dev_err(ctrl->dev, "Reading CAP failed (%d)\n", 
> ret);
> @@ -598,6 +612,9 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
>  	page_shift = NVME_CAP_MPSMIN(cap) + 12;
>  	ctrl->page_size = 1 << page_shift;
>  
> +	if (ctrl->vs >= NVME_VS(1, 1))
> +		ctrl->subsystem = NVME_CAP_NSSRC(cap);
> +
>  	ret = nvme_identify_ctrl(ctrl, &id);
>  	if (ret) {
>  		dev_err(ctrl->dev, "Identify Controller failed 
> (%d)\n", ret);
> @@ -630,18 +647,85 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
>  	return 0;
>  }
>  
> -static void nvme_free_ctrl(struct kref *kref)
> +static int nvme_dev_open(struct inode *inode, struct file *file)
>  {
> -	struct nvme_ctrl *ctrl = container_of(kref, struct 
> nvme_ctrl, kref);
> +	struct nvme_ctrl *ctrl;
> +	int instance = iminor(inode);
> +	int ret = -ENODEV;
>  
> -	ctrl->ops->free_ctrl(ctrl);
> +	spin_lock(&dev_list_lock);
> +	list_for_each_entry(ctrl, &nvme_ctrl_list, node) {

list_for_each_entry_safe() and/or some type of lock access?

> +		if (ctrl->instance != instance)
> +			continue;
> +
> +		if (!ctrl->admin_q) {
> +			ret = -EWOULDBLOCK;
> +			break;
> +		}
> +		if (!kref_get_unless_zero(&ctrl->kref))
> +			break;
> +		file->private_data = ctrl;
> +		ret = 0;
> +		break;
> +	}
> +	spin_unlock(&dev_list_lock);
> +
> +	return ret;
>  }
>  
> -void nvme_put_ctrl(struct nvme_ctrl *ctrl)
> +static int nvme_dev_release(struct inode *inode, struct file *file)
>  {
> -	kref_put(&ctrl->kref, nvme_free_ctrl);
> +	nvme_put_ctrl(file->private_data);
> +	return 0;
> +}
> +
> +static long nvme_dev_ioctl(struct file *file, unsigned int cmd,
> +		unsigned long arg)
> +{
> +	struct nvme_ctrl *ctrl = file->private_data;
> +	void __user *argp = (void __user *)arg;
> +	struct nvme_ns *ns;
> +
> +	switch (cmd) {
> +	case NVME_IOCTL_ADMIN_CMD:
> +		return nvme_user_cmd(ctrl, NULL, argp);
> +	case NVME_IOCTL_IO_CMD:
> +		if (list_empty(&ctrl->namespaces))
> +			return -ENOTTY;
> +		ns = list_first_entry(&ctrl->namespaces, struct 
> nvme_ns, list);
> +		return nvme_user_cmd(ctrl, ns, argp);
> +	case NVME_IOCTL_RESET:
> +		dev_warn(ctrl->dev, "resetting controller\n");
> +		return ctrl->ops->reset_ctrl(ctrl);
> +	case NVME_IOCTL_SUBSYS_RESET:
> +		return nvme_reset_subsystem(ctrl);
> +	default:
> +		return -ENOTTY;
> +	}
>  }
>  
> +static const struct file_operations nvme_dev_fops = {
> +	.owner		= THIS_MODULE,
> +	.open		= nvme_dev_open,
> +	.release	= nvme_dev_release,
> +	.unlocked_ioctl	= nvme_dev_ioctl,
> +	.compat_ioctl	= nvme_dev_ioctl,
> +};
> +
> +static ssize_t nvme_sysfs_reset(struct device *dev,
> +				struct device_attribute *attr, const 
> char *buf,
> +				size_t count)
> +{
> +	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret = ctrl->ops->reset_ctrl(ctrl);
> +	if (ret < 0)
> +		return ret;
> +	return count;
> +}
> +static DEVICE_ATTR(reset_controller, S_IWUSR, NULL, 
> nvme_sysfs_reset);
> +
>  static int ns_cmp(void *priv, struct list_head *a, struct list_head 
> *b)
>  {
>  	struct nvme_ns *nsa = container_of(a, struct nvme_ns, list);
> @@ -803,6 +887,106 @@ void nvme_remove_namespaces(struct nvme_ctrl 
> *ctrl)
>  		nvme_ns_remove(ns);
>  }
>  
> +static DEFINE_IDA(nvme_instance_ida);
> +
> +static int nvme_set_instance(struct nvme_ctrl *ctrl)
> +{
> +	int instance, error;
> +
> +	do {
> +		if (!ida_pre_get(&nvme_instance_ida, GFP_KERNEL))
> +			return -ENODEV;
> +
> +		spin_lock(&dev_list_lock);
> +		error = ida_get_new(&nvme_instance_ida, &instance);
> +		spin_unlock(&dev_list_lock);
> +	} while (error == -EAGAIN);
> +
> +	if (error)
> +		return -ENODEV;
> +
> +	ctrl->instance = instance;
> +	return 0;
> +}
> +
> +static void nvme_release_instance(struct nvme_ctrl *ctrl)
> +{
> +	spin_lock(&dev_list_lock);
> +	ida_remove(&nvme_instance_ida, ctrl->instance);
> +	spin_unlock(&dev_list_lock);
> +}
> +
> +static void nvme_free_ctrl(struct kref *kref)
> +{
> +	struct nvme_ctrl *ctrl = container_of(kref, struct 
> nvme_ctrl, kref);
> +
> +	spin_lock(&dev_list_lock);
> +	list_del(&ctrl->node);
> +	spin_unlock(&dev_list_lock);
> +
> +	put_device(ctrl->device);
> +	nvme_release_instance(ctrl);
> +	device_destroy(nvme_class, MKDEV(nvme_char_major, ctrl
> ->instance));
> +
> +	ctrl->ops->free_ctrl(ctrl);
> +}
> +
> +void nvme_put_ctrl(struct nvme_ctrl *ctrl)
> +{
> +	kref_put(&ctrl->kref, nvme_free_ctrl);
> +}
> +
> +/*
> + * Initialize a NVMe controller structures.  This needs to be called 
> during
> + * earliest initialization so that we have the initialized 
> structured around
> + * during probing.
> + */
> +int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
> +		const struct nvme_ctrl_ops *ops, u16 vendor,
> +		unsigned long quirks)
> +{
> +	int ret;
> +
> +	INIT_LIST_HEAD(&ctrl->namespaces);
> +	kref_init(&ctrl->kref);
> +	ctrl->dev = dev;
> +	ctrl->ops = ops;
> +	ctrl->vendor = vendor;
> +	ctrl->quirks = quirks;
> +
> +	ret = nvme_set_instance(ctrl);
> +	if (ret)
> +		goto out;
> +
> +	ctrl->device = device_create(nvme_class, ctrl->dev,
> +				MKDEV(nvme_char_major, ctrl
> ->instance),
> +				dev, "nvme%d", ctrl->instance);
> +	if (IS_ERR(ctrl->device)) {
> +		ret = PTR_ERR(ctrl->device);
> +		goto out_release_instance;
> +	}
> +	get_device(ctrl->device);
> +	dev_set_drvdata(ctrl->device, ctrl);
> +
> +	ret = device_create_file(ctrl->device, 
> &dev_attr_reset_controller);
> +	if (ret)
> +		goto out_put_device;
> +
> +	spin_lock(&dev_list_lock);
> +	list_add_tail(&ctrl->node, &nvme_ctrl_list);
> +	spin_unlock(&dev_list_lock);
> +
> +	return 0;
> +
> +out_put_device:
> +	put_device(ctrl->device);
> +	device_destroy(nvme_class, MKDEV(nvme_char_major, ctrl
> ->instance));
> +out_release_instance:
> +	nvme_release_instance(ctrl);
> +out:
> +	return ret;
> +}
> +
>  int __init nvme_core_init(void)
>  {
>  	int result;
> @@ -813,10 +997,31 @@ int __init nvme_core_init(void)
>  	else if (result > 0)
>  		nvme_major = result;
>  
> +	result = __register_chrdev(nvme_char_major, 0, NVME_MINORS, 
> "nvme",
> +							&nvme_dev_fo
> ps);
> +	if (result < 0)
> +		goto unregister_blkdev;
> +	else if (result > 0)
> +		nvme_char_major = result;
> +
> +	nvme_class = class_create(THIS_MODULE, "nvme");

It would be better to have "nvme" as a #define somewhere, probably in
the .h?

> +	if (IS_ERR(nvme_class)) {
> +		result = PTR_ERR(nvme_class);
> +		goto unregister_chrdev;
> +	}
> +
>  	return 0;
> +
> + unregister_chrdev:
> +	__unregister_chrdev(nvme_char_major, 0, NVME_MINORS, 
> "nvme");
> + unregister_blkdev:
> +	unregister_blkdev(nvme_major, "nvme");
> +	return result;
>  }
>  
>  void nvme_core_exit(void)
>  {
>  	unregister_blkdev(nvme_major, "nvme");
> +	class_destroy(nvme_class);
> +	__unregister_chrdev(nvme_char_major, 0, NVME_MINORS, 
> "nvme");
>  }
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 53e82feb..da63835 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -19,8 +19,6 @@
>  #include <linux/kref.h>
>  #include <linux/blk-mq.h>
>  
> -struct nvme_passthru_cmd;
> -
>  extern unsigned char nvme_io_timeout;
>  #define NVME_IO_TIMEOUT	(nvme_io_timeout * HZ)
>  
> @@ -48,6 +46,7 @@ struct nvme_ctrl {
>  	struct blk_mq_tag_set *tagset;
>  	struct list_head namespaces;
>  	struct device *device;	/* char device */
> +	struct list_head node;
>  
>  	char name[12];
>  	char serial[20];
> @@ -60,6 +59,8 @@ struct nvme_ctrl {
>  	u16 abort_limit;
>  	u8 event_limit;
>  	u8 vwc;
> +	u32 vs;
> +	bool subsystem;

OK, so 'bool subsystem' got added back in.  Not sure still how a bool
helps define a controller into a given subsystem.  Isn't the definition
of an NVM subsystem 1 or more controllers?  So every new 'struct
nvme_ctrl' instance is going to set this to 'true'?

Or looking into the future, say if this is on a future fabric
connection, there could be lots of controllers under lots of distinct
subsystems.  Then I don't know how 'bool subsystem' makes sense and
distinguishes a controller in a given NVM subsystem.

>  	u16 vendor;
>  	unsigned long quirks;
>  };
> @@ -87,7 +88,9 @@ struct nvme_ns {
>  struct nvme_ctrl_ops {
>  	int (*reg_read32)(struct nvme_ctrl *ctrl, u32 off, u32 
> *val);
>  	int (*reg_read64)(struct nvme_ctrl *ctrl, u32 off, u64 
> *val);
> +	int (*reg_write32)(struct nvme_ctrl *ctrl, u32 off, u32 
> val);

I don't think they are being used currently, but the ACQ and ASQ 8-byte
registers do have RW fields.  Maybe add "int (*reg_write64)()" as well?

>  	bool (*io_incapable)(struct nvme_ctrl *ctrl);
> +	int (*reset_ctrl)(struct nvme_ctrl *ctrl);

Probably would want a "(*shutdown_ctrl)()" as well?

>  	void (*free_ctrl)(struct nvme_ctrl *ctrl);
>  };
>  
> @@ -111,6 +114,13 @@ static inline bool nvme_io_incapable(struct 
> nvme_ctrl *ctrl)
>  	return val & NVME_CSTS_CFS;
>  }
>  
> +static inline int nvme_reset_subsystem(struct nvme_ctrl *ctrl)
> +{
> +	if (!ctrl->subsystem)
> +		return -ENOTTY;
> +	return ctrl->ops->reg_write32(ctrl, NVME_REG_NSSR, 
> 0x4E564D65);

It would be really good to have the hex value in a #define, most likely
located in the nvme.h file.
 
> +}
> +
>  

Lots of good work Christoph, thanks,
Jay

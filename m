From: willy@linux.intel.com (Matthew Wilcox)
Date: Fri, 27 Jul 2012 16:44:47 -0400
Subject: [PATCH] NVMe: Add a character device for each nvme device
In-Reply-To: <1343407458-29909-1-git-send-email-keith.busch@intel.com>
References: <1343407458-29909-1-git-send-email-keith.busch@intel.com>
Message-ID: <20120727204447.GR22985@linux.intel.com>

On Fri, Jul 27, 2012@10:44:18AM -0600, Keith Busch wrote:
> @@ -1222,6 +1228,35 @@ static const struct block_device_operations nvme_fops = {
>  	.compat_ioctl	= nvme_ioctl,
>  };
>  
> +static long nvme_char_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
> +{
> +	struct nvme_dev *dev;
> +	int instance = iminor(f->f_dentry->d_inode);
> +
> +	spin_lock(&dev_list_lock);
> +	list_for_each_entry(dev, &dev_list, node) {
> +		if (dev->instance == instance)
> +			break;
> +	}
> +	spin_unlock(&dev_list_lock);

So what happens if we get a PCI hotplug event here?  nvme_remove gets
called, we unmap the BAR and kfree the dev.  Now nvme_user_admin_cmd()
is going to dereference a pointer to freed memory, and even if that
happens to work, it's going to end up writing a doorbell that doesn't
exist any more.

I think we need refcounting on the dev to fix this ... urgh.

> +	if (&dev->node == &dev_list)
> +		return -ENOTTY;
> +	
> +	switch (cmd) {
> +	case NVME_IOCTL_ADMIN_CMD:
> +		return nvme_user_admin_cmd(dev, (void __user *)arg);
> +	default:
> +		return -ENOTTY;
> +	}
> +}

From: willy@linux.intel.com (Matthew Wilcox)
Date: Mon, 30 Dec 2013 09:00:51 -0500
Subject: [PATCH RFC 4/5] NVMe: Stale node cleanup based on reference count
In-Reply-To: <1388399240-13828-5-git-send-email-santoshsy@gmail.com>
References: <1388399240-13828-1-git-send-email-santoshsy@gmail.com>
 <1388399240-13828-5-git-send-email-santoshsy@gmail.com>
Message-ID: <20131230140051.GJ4945@linux.intel.com>

On Mon, Dec 30, 2013@03:57:19PM +0530, Santosh Y wrote:
> +#ifdef CONFIG_BLK_DEV_NVME_HP
> +#define NVME_MINORS 64
> +#endif

Why does this need to go back for this patch?

> +static int nvme_bd_open(struct block_device *bdev, fmode_t mode)
> +{
> +	struct nvme_ns *ns;
> +	int err = -ENODEV;
> +
> +	if (!bdev || !bdev->bd_disk ||
> +		!bdev->bd_disk->private_data)
> +		goto out;

!bdev?  Do you really think the core is giong to call you with a NULL bdev?
I can see that bd_disk isn't going to be NULL either.

> @@ -1805,6 +1853,9 @@ static void nvme_resubmit_bios(struct nvme_queue *nvmeq)
>  static int nvme_kthread(void *data)
>  {
>  	struct nvme_dev *dev, *next;
> +#ifdef CONFIG_BLK_DEV_NVME_HP
> +	unsigned long flags  = 0;
> +#endif

You don't need to initialise 'flags' that are used as part of an
irqsave/restore.

> +#ifdef CONFIG_BLK_DEV_NVME_HP
> +				spin_lock_irqsave(&nvmeq->q_lock, flags);
> +#else
>  				spin_lock_irq(&nvmeq->q_lock);
> +#endif

... but *what on earth* is going on here?!  How is the kthread getting
run in interrupt context?

>  static void nvme_free_dev(struct kref *kref)
>  {
>  	struct nvme_dev *dev = container_of(kref, struct nvme_dev, kref);
>  	kfree(dev->queues);
>  	kfree(dev->entry);
> -	kfree(dev);
> +#ifdef CONFIG_BLK_DEV_NVME_HP
> +	if (!test_bit(NVME_STALE_NODE, &dev->hp_flag))
> +#endif
> +		kfree(dev);
>  }
>  
>  static int nvme_dev_open(struct inode *inode, struct file *f)
> @@ -2431,6 +2584,11 @@ static int nvme_dev_open(struct inode *inode, struct file *f)
>  static int nvme_dev_release(struct inode *inode, struct file *f)
>  {
>  	struct nvme_dev *dev = f->private_data;
> +
> +#ifdef CONFIG_BLK_DEV_NVME_HP
> +	if (!dev)
> +		return -ENODEV;
> +#endif
>  	kref_put(&dev->kref, nvme_free_dev);
>  	return 0;
>  }

This seems like you don't understand the kref pattern.  Why do you have
this 'stale' list rather than just incrementing the kref, and delaying
the final kfree until you're done with your usage?

> @@ -2438,6 +2596,11 @@ static int nvme_dev_release(struct inode *inode, struct file *f)
>  static long nvme_dev_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
>  {
>  	struct nvme_dev *dev = f->private_data;
> +
> +#ifdef CONFIG_BLK_DEV_NVME_HP
> +	if (!dev)
> +		return -ENODEV;
> +#endif

How is it that f->private_data can become NULL?

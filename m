From: willy@linux.intel.com (Matthew Wilcox)
Date: Wed, 5 Jun 2013 16:01:02 -0400
Subject: [PATCH] NVMe: Async event request
In-Reply-To: <1370390151-24681-1-git-send-email-keith.busch@intel.com>
References: <1370390151-24681-1-git-send-email-keith.busch@intel.com>
Message-ID: <20130605200102.GI8211@linux.intel.com>

On Tue, Jun 04, 2013@05:55:51PM -0600, Keith Busch wrote:
> Just taking a stab at the async event request... This follows "option 2"
> of the original proposal, so if multiple openers are listening for events,
> they may step on each other's toes where some reader may see an event and
> another reader will miss it.

Nice start ...

> @@ -234,6 +235,19 @@ void put_nvmeq(struct nvme_queue *nvmeq)
>  	put_cpu();
>  }
>  
> +static void nvme_async_completion(struct nvme_dev *dev, void *ctx,
> +						struct nvme_completion *cqe)
> +{
> +	u32 result = le32_to_cpup(&cqe->result);
> +	u16 status = le16_to_cpup(&cqe->status) >> 1;
> +
> +	if (status == NVME_SC_SUCCESS) {
> +		kfifo_in(&dev->aer_kfifo, &result, sizeof(result));
> +		wake_up(&dev->aer_empty);
> +		++dev->aerl;
> +	}
> +}

We don't check here whether the kfifo is full.  So if nobody's reading,
we'll drop later entries on the floor.  My sense is that this is a bad
idea; we should probably drop earlier entries rather than newer entries.
No idea if kfifo lets you do this or not.

>  /**
>   * nvme_submit_cmd() - Copy a command into a queue and ring the doorbell
>   * @nvmeq: The queue to use
> @@ -976,7 +990,8 @@ static void nvme_cancel_ios(struct nvme_queue *nvmeq, bool timeout)
>  			.status = cpu_to_le16(NVME_SC_ABORT_REQ << 1),
>  		};
>  
> -		if (timeout && !time_after(now, info[cmdid].timeout))
> +		if (timeout && (!time_after(now, info[cmdid].timeout) ||
> +				info[cmdid].ctx == CMD_CTX_ASYNC))
>  			continue;
>  		if (info[cmdid].ctx == CMD_CTX_CANCELLED)
>  			continue;

My only concern here is that on shutting down a controller in an orderly
fashion, we'll print 'Cancelling I/O ' to the syslog N times.

> @@ -1473,6 +1488,22 @@ static const struct block_device_operations nvme_fops = {
>  	.compat_ioctl	= nvme_ioctl,
>  };
>  
> +static void nvme_submit_async_req(struct nvme_dev *dev)
> +{
> +	int cmdid;
> +	struct nvme_command c;
> +	struct nvme_queue *nvmeq = dev->queues[0];
> +
> +	memset(&c, 0, sizeof(c));
> +	c.common.opcode = nvme_admin_async_event;
> +	cmdid = alloc_cmdid(nvmeq, CMD_CTX_ASYNC, nvme_async_completion, 0);
> +	if (cmdid < 0)
> +		return;
> +
> +	c.common.command_id = cmdid;
> +	nvme_submit_cmd(dev->queues[0], &c);
> +}

Personally, I'd rearrange like so:

> +	cmdid = alloc_cmdid(nvmeq, CMD_CTX_ASYNC, nvme_async_completion, 0);
> +	if (cmdid < 0)
> +		return;
> +
> +	memset(&c, 0, sizeof(c));
> +	c.common.opcode = nvme_admin_async_event;
> +	c.common.command_id = cmdid;
> +	nvme_submit_cmd(dev->queues[0], &c);

It's a little nicer to see everything in the command initialised together.

>  	dev->oncs = le16_to_cpup(&ctrl->oncs);
> +	dev->aerl = ctrl->aerl + 1;

If the device specifies '255' in the data structure, then we're going
to submit 0 requests instead of 256.  We should probably just make
'aerl' 16-bit.

> @@ -1892,10 +1933,29 @@ static long nvme_dev_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
>  	}
>  }
>  
> +ssize_t nvme_dev_read(struct file *f, char __user *buf, size_t count,
> +								loff_t *off)
> +{
> +	int ret;
> +	unsigned int copied;
> +	struct nvme_dev *dev = f->private_data;
> +
> +	if (count < sizeof(u32))
> +		return -EINVAL;
> +	if (f->f_flags & O_NONBLOCK)
> +		return -EINVAL;
> +	if (wait_event_killable(dev->aer_empty,
> +					!kfifo_is_empty(&dev->aer_kfifo)))
> +		return -EINTR;
> +	ret = kfifo_to_user(&dev->aer_kfifo, buf, sizeof(u32), &copied);
> +	return ret ? ret : copied;
> +}

Now, we're only returning an array of 'result' here.  I think it'd be
better to return a slightly larger record, in case we end up specifying
Dword 1 for something else, or we want to report back information through
'read' that didn't actually come from the device.  I suggested 16 bytes
per entry in my original proposal, formatted in a way that closely
mirrors the CQE.

>  static const struct file_operations nvme_dev_fops = {
>  	.owner		= THIS_MODULE,
>  	.open		= nvme_dev_open,
>  	.release	= nvme_dev_release,
> +	.read		= nvme_dev_read,
>  	.unlocked_ioctl	= nvme_dev_ioctl,
>  	.compat_ioctl	= nvme_dev_ioctl,
>  };

Please also add a 'poll' entry so an app can use poll()/select() to wait
for new records to become available.

> @@ -534,6 +535,8 @@ struct nvme_dev {
>  	struct list_head namespaces;
>  	struct kref kref;
>  	struct miscdevice miscdev;
> +	struct kfifo aer_kfifo;
> +	wait_queue_head_t aer_empty;
>  	char name[12];
>  	char serial[20];
>  	char model[40];

We need to be careful calling things "aer".  That already means Advanced
Error Reporting in PCIe.  Better to call them event_fifo and event_empty,
I think.

> @@ -541,6 +544,7 @@ struct nvme_dev {
>  	u32 max_hw_sectors;
>  	u32 stripe_size;
>  	u16 oncs;
> +	u8 aerl;
>  };
>  
>  /*
> -- 
> 1.7.0.4
> 
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://merlin.infradead.org/mailman/listinfo/linux-nvme

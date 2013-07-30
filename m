From: keith.busch@intel.com (Busch, Keith)
Date: Tue, 30 Jul 2013 16:25:47 +0000
Subject: [PATCHv3] NVMe: Async event requests
In-Reply-To: <1375130252-28795-1-git-send-email-keith.busch@intel.com>
References: <1375130252-28795-1-git-send-email-keith.busch@intel.com>
Message-ID: <B58D82457FDA0744A320A2FC5AC253B93AEE628E@FMSMSX104.amr.corp.intel.com>

On Monday, July 29, 2013 2:38 PM, Keith Busch wrote:
> +ssize_t nvme_dev_read(struct file *f, char __user *buf, size_t count,
> +								loff_t *off)

> +	if (wait_event_killable(dev->event_empty,
> +					!kfifo_is_empty(&dev->event_fifo)))
> +		return -EINTR;
> +

I think need to change "wait_event_killable" to "wait_event_interruptible"
for this sort of read.

> +unsigned int nvme_dev_poll(struct file *f, struct poll_table_struct *wait) {
> +	struct nvme_dev *dev = f->private_data;
> +	unsigned int mask = 0;
> +
> +	poll_wait(f, &dev->event_empty, wait);
> +	if (!kfifo_is_empty(&dev->event_fifo))
> +		mask = POLLIN | POLLRDNORM;
> +
> +	return mask;
> +}

The thing that troubles me most about this is that opening the device
takes a kref so we don't free resources on an open device if it's
hot unplugged. If the device is removed, I'd like to wake up all tasks
waiting on it such that signal_pending returns true so we're not waiting
on an event that never will happen.

If there isn't a way to wake up all tasks on a wait queue head with
a pending signal from in the kernel, the only other thing I can
think is add a flag to struct nvme_dev indicating it's gone, call
wake_up_all(&dev->event_empty), and modify the read and poll as follows:

ssize_t nvme_dev_read(...
        if (wait_event_killable(dev->event_empty,
                        !kfifo_is_empty(&dev->event_fifo) &&
                        !dev->kill_me_now))
        ...
        if (dev->kill_me_now)
                return -EINTR;
        ...

unsigned int nvme_dev_poll(...
        if (dev->kill_me_now)
                mask |= POLLERR;
        ...

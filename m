From: willy@linux.intel.com (Matthew Wilcox)
Date: Fri, 19 Jul 2013 16:41:58 -0400
Subject: [PATCHv2] NVMe: Async event request
In-Reply-To: <1374257615-19201-1-git-send-email-keith.busch@intel.com>
References: <1374257615-19201-1-git-send-email-keith.busch@intel.com>
Message-ID: <20130719204158.GH4855@linux.intel.com>

On Fri, Jul 19, 2013@12:13:35PM -0600, Keith Busch wrote:
> Submits NVMe asynchronous event requests, one event up to the controller
> maximum or number of possible different event types (8), whichever is
> smaller. Events successfully returned by the controller are queued on
> a fifo that is emptied as a user program reads them from the character
> device. Reading events may block the user program if none are available
> or the user may poll completions.

This looks a lot better to me!

> Signed-off-by: Keith Busch <keith.busch at intel.com>
> ---
> v1->v2:
> 
> Drops older events from the queue if it is full as new events come in.
> 
> Limit the maximum number of event requests to have outstanding at the same
> type to 8. We don't necessarilly want to use the maximum the controller
> is capable of as this may exceed the number of admin submission queue
> entries and 8 is the maximum number of possible events that could occur
> without a reading log pages to clear events of that type anyway.
> 
> Don't bother cancelling async event requests on controller shutdown.
> 
> Rearranged code and renamed fields for clarity.
> 
> Added 'poll'.
> 
> The data returned from reading is 16 byte descriptor instead of only the
> 'result'.
> 
> 
> Here's a simple example test program: 
> 
> #include <fcntl.h>
> #include <stdio.h>
> #include <poll.h>
> #include <linux/nvme.h>
> 
> int main(int argc, char **argv)
> {
> 	static const char *perrstr;
> 	struct nvme_async_completion event;
> 	struct pollfd poll_fd;
> 	int err;
> 
> 	if (argc < 2) {
> 		fprintf(stderr, "Usage: %s </dev/nvme#>\n", argv[0]);
> 		return 1;
> 	}

Should set perrstr to argv[1] here

> 	poll_fd.events = POLLIN;
> 	poll_fd.fd = open(argv[1], O_RDONLY);
> 	if (poll_fd.fd < 0)
> 		goto perror;

A nice check to add here is:

	struct stat stat;
...
	err = fstat(poll_fd.fd, &stat);
	if (!S_ISCHR(stat.st_mode)) {
		fprintf(stderr, "%s is not a character device\n", argv[1]);
		return 1;
	}

That dissuades people from running it against one of the block devices
and expecting something useful to happen.

> 	perrstr = "poll";
> 	err = poll(&poll_fd, 1, -1);
> 	if (err < 0)
> 		goto perror;
> 
> 	perrstr = "read";
> 	err = read(poll_fd.fd, &event, sizeof(event));
> 	if (err < 0)
> 		goto perror;
> 
> 	printf("async event result:%x\n", event.result);
> 	close(poll_fd.fd);

This is a good start.  I'd like to see this program extended to also request
the log page if 'more' is set.

> 	return 0;
>  perror:
> 	perror(perrstr);
> 	return 1;
> }
> 
>  drivers/block/nvme-core.c |   87 ++++++++++++++++++++++++++++++++++++++++++++-
>  include/linux/nvme.h      |    4 ++
>  include/uapi/linux/nvme.h |    6 +++
>  3 files changed, 96 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
> index 7439499..0cc9344 100644
> --- a/drivers/block/nvme-core.c
> +++ b/drivers/block/nvme-core.c
> @@ -37,6 +37,7 @@
>  #include <linux/pci.h>
>  #include <linux/poison.h>
>  #include <linux/ptrace.h>
> +#include <linux/poll.h>
>  #include <linux/sched.h>
>  #include <linux/slab.h>
>  #include <linux/types.h>
> @@ -166,6 +167,7 @@ static int alloc_cmdid_killable(struct nvme_queue *nvmeq, void *ctx,
>  #define CMD_CTX_COMPLETED	(0x310 + CMD_CTX_BASE)
>  #define CMD_CTX_INVALID		(0x314 + CMD_CTX_BASE)
>  #define CMD_CTX_FLUSH		(0x318 + CMD_CTX_BASE)
> +#define CMD_CTX_ASYNC		(0x31C + CMD_CTX_BASE)
>  
>  static void special_completion(struct nvme_dev *dev, void *ctx,
>  						struct nvme_completion *cqe)
> @@ -236,6 +238,27 @@ void put_nvmeq(struct nvme_queue *nvmeq)
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
> +		struct nvme_async_completion event;
> +
> +		if (kfifo_is_full(&dev->event_fifo))
> +			kfifo_out(&dev->event_fifo, &event, sizeof(event));
> +
> +		memset(&event, 0, sizeof(event));
> +		event.status = status;

Open question ... should we report the status in the bottom 15 bits of
this field or the top 15 bits of this field?  I kind of like reporting it
in the bottom 15 bits so we can set the top bit and report a completely
different set of status events that way.  On the other hand, it's then
different from an NVMe completion, and we could accomplish the same
effect by setting the bottom bit to indicate a Linux-private event.
I'm not entirely sure that being exactly bit compatible with an NVMe
completion is a desirable goal.

> +		event.result = result;
> +		kfifo_in(&dev->event_fifo, &event, sizeof(event));
> +		wake_up(&dev->event_empty);

Calling the wait queue 'event_empty' initially made me think that we're
waiting for the list of events to be empty ... when really we're being
notified that it's _not_ empty.  I don't have a good alternative name
to suggest at this point.

> +ssize_t nvme_dev_read(struct file *f, char __user *buf, size_t count,
> +								loff_t *off)
> +{
> +	struct nvme_dev *dev = f->private_data;
> +	unsigned int copied;
> +	int ret;
> +
> +	if (count < sizeof(struct nvme_async_completion))
> +		return -EINVAL;
> +	if (f->f_flags & O_NONBLOCK && kfifo_is_empty(&dev->event_fifo))
> +		return -EINVAL;
> +	if (wait_event_killable(dev->event_empty,
> +					!kfifo_is_empty(&dev->event_fifo)))
> +		return -EINTR;
> +
> +	ret = kfifo_to_user(&dev->event_fifo, buf,
> +					sizeof(struct nvme_async_completion),
> +					&copied);
> +	return ret ? ret : copied;
> +}

If I read 32 bytes, and there happen to be two events waiting, shouldn't
it return both of them?

If we have two openers, do we need a mutex?

> +unsigned int nvme_dev_poll(struct file *f, struct poll_table_struct *wait)
> +{
> +	unsigned int mask = 0;
> +	struct nvme_dev *dev = f->private_data;
> +
> +	poll_wait(f, &dev->event_empty, wait);
> +	if (!kfifo_is_empty(&dev->event_fifo))
> +		mask = POLLIN | POLLRDNORM;
> +
> +	return mask;
> +}

I love how simple this routine is.

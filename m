From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 15 Jun 2017 12:41:44 +0300
Subject: [RFC PATCH] nvme: Submit uevents for log page notification
In-Reply-To: <1490388582-10237-1-git-send-email-keith.busch@intel.com>
References: <1490388582-10237-1-git-send-email-keith.busch@intel.com>
Message-ID: <e0536757-4fb7-5d56-24dd-a96de067b48b@grimberg.me>



On 24/03/17 23:49, Keith Busch wrote:
> This is a first attempt at adding uevents to nvme. The concept was
> discussed at LSFMM, so here it is for consideration. :)
> 
> In this implementation, the driver will submit a "change" uevent whenever
> the controller indicates a log page contains pertinent information. This
> happens in response to an Asynchronouse Event Notification, or if a
> command completes with the "MORE" status bit set. If there are other
> events anyone thinks we'd like udev to get a chance to handle, or would
> prefer to see these variables submitted to udev in a different format,
> please let me know.
> 
> Submitting a uevent from the kernel can't be done from an irq context,
> which is the context the driver learns of such event, so this path
> enqueues the log identifier of internest on a FIFO, then has the async
> event work flush the event FIFO to udev. Pretty simple.
> 
> Tested with the following rule to kick an nvme-cli generic get-log to
> clear the log request and append the returned log data to a temporary
> log. This is just an example for testing and not intended for real
> life use.
> 
> ACTION=="change", SUBSYSTEM=="nvme", ENV{NVME_LOG}=="*", \
> 	RUN+="/bin/sh -c '/usr/local/sbin/nvme get-log $env{DEVNAME} --log-id=$env{NVME_LOG} --log-len=4096 >> /tmp/nvme-log'"
> 
> Signed-off-by: Keith Busch <keith.busch at intel.com>
> ---
>   drivers/nvme/host/core.c   | 35 +++++++++++++++++++++++++++++++++--
>   drivers/nvme/host/fc.c     |  2 ++
>   drivers/nvme/host/nvme.h   |  4 ++++
>   drivers/nvme/host/pci.c    |  2 ++
>   drivers/nvme/host/rdma.c   |  2 ++
>   drivers/nvme/target/loop.c |  2 ++
>   include/linux/nvme.h       |  2 ++
>   7 files changed, 47 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 9b3b57f..a757deb 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1879,6 +1879,27 @@ static const struct attribute_group *nvme_dev_attr_groups[] = {
>   	NULL,
>   };
>   
> +void nvme_uevent_work(struct nvme_ctrl *ctrl, int log)
> +{
> +	char buffer[13]; /* NVME_LOG=255\0 */
> +	char *envp[2] = {buffer, NULL};
> +
> +	snprintf(buffer, sizeof(buffer), "NVME_LOG=%d", log);
> +	kobject_uevent_env(&ctrl->device->kobj, KOBJ_CHANGE, envp);
> +}
> +
> +void nvme_uevent(struct nvme_ctrl *ctrl, int log_page)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&ctrl->lock, flags);
> +	kfifo_put(&ctrl->log_event_fifo, log_page);
> +	spin_unlock_irqrestore(&ctrl->lock, flags);
> +

Check kfifo_put rc?

> +	schedule_work(&ctrl->async_event_work);

Can you explain why scheduling async_event_work (again) instead
of having a separate work for it?

Also, we should use the nvme_wq here to avoid a warning on flush
dependency violations on shutdown (see 
dab469a893f40cdd9d41f52515a4ffa745bef655).

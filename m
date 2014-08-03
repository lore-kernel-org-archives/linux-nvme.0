From: keith.busch@intel.com (Keith Busch)
Date: Sun, 3 Aug 2014 11:44:14 -0600 (MDT)
Subject: [PATCH 1/1]  If device hotplug out, controller status become
 0xFFFF_FFFF 1. Controller fatal status become true in nvme_kthread() 2.
 Ready bit will not be reset to 0 in nvme_wait_ready() for controller disable
 above two scenarios controller status dat
In-Reply-To: <04d601cfae72$daba9740$902fc5c0$@samsung.com>
References: <04d601cfae72$daba9740$902fc5c0$@samsung.com>
Message-ID: <alpine.LRH.2.03.1408031127430.5109@AMR>

On Sat, 2 Aug 2014, Indraneel Mukherjee wrote:
>> On Tue, 22 Jul 2014, Mundu wrote:
>>> Signed-off-by: Mundu <mundu2510 at gmail.com>
>>> +	u32 csts;
>>>
>>> 	while (!kthread_should_stop()) {
>>> 		set_current_state(TASK_INTERRUPTIBLE);
>>> 		spin_lock(&dev_list_lock);
>>> 		list_for_each_entry_safe(dev, next, &dev_list, node) {
>>> 			int i;
>>> -			if (readl(&dev->bar->csts) & NVME_CSTS_CFS &&
>>> +			if ((csts = readl(&dev->bar->csts)) & NVME_CSTS_CFS
>>> &&
>>> 							dev->initialized) {
>>> +				/* If device is hot plugout,
>>> +				   csts become 0xFFFFFFFF */
>>> +				if (csts == -1)
>>> +					continue;
>>
>> You definitely want to let the reset work get scheduled here instead of
>> continuing. Some platforms do not support "surprise removal", so this check
>> guards against that by triggering a reset which will bail on the device if it appears
>> gone and remove it from pci.
>
> This one is not very difficult to hit on devices that support hotplug. We
> have seen that even hot-removing an idle device can trigger this issue
> depending on when we hot-remove.

So why is this a problem? The only thing that happens is the device is
scheduled for reset, but the reset handler will recognize the device is
gone. In the case your platform does not support surprise hot removal,
this absolutely necessary. In the case your platform does support it,
this is not doing any harm.

> Why will checking dev->bar->csts for 0xFFFFFFFF cause issues for
> unresponsive devices? The CSTS Register has many fields that are non-zero by
> default.
>
> Even unresponsive devices should return a CSTS value where all the bits are
> not 1s (or have you seen otherwise?) allowing the work to be queued.
>
> Below snippet should ideally work for unresponsive devices too. Can you let
> us know if you have seen otherwise?
>
> diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
> index 28aec2d..61157d1 100644
> --- a/drivers/block/nvme-core.c
> +++ b/drivers/block/nvme-core.c
> @@ -1913,6 +1913,8 @@ static int nvme_kthread(void *data)
> 			int i;
> 			if (readl(&dev->bar->csts) & NVME_CSTS_CFS &&
> 							dev->initialized) {
> +				if (readl(&dev->bar->csts) == -1)
> +					continue;

No, as I mentioned before, you do not want to continue here from reading
-1. You want the reset work to get scheduled which knows how to handle
a removed device. What exactly are you attempting to fix by not letting
this happen?

> 				if (work_busy(&dev->reset_work))
> 					continue;
> 				list_del_init(&dev->node);

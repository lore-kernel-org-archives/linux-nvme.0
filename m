From: javier@javigon.com (=?utf-8?Q?Javier_Gonz=C3=A1lez?=)
Date: Fri, 13 Apr 2018 19:55:55 +0200
Subject: [PATCH] nvme: allow lightnvm to have visibility over AER events
In-Reply-To: <20180413165801.GF6424@localhost.localdomain>
References: <1523619780-10882-1-git-send-email-javier@cnexlabs.com>
 <1523619780-10882-2-git-send-email-javier@cnexlabs.com>
 <20180413165801.GF6424@localhost.localdomain>
Message-ID: <28761F08-1AB9-41FD-BFE2-BBC9779432DA@javigon.com>

> On 13 Apr 2018,@18.58, Keith Busch <keith.busch@intel.com> wrote:
> 
> Hi Javier,
> 
> We currently do have some logic in the core to say which events are
> sent to user space for handling and others that are handled internally.
> There's currently just two events with kernel specifc handling:
> namespace inventory change, and firmware activation.
> 
> The example in your patch looks like one of the scenarios envisioned
> to be handled by a udev rule. Is that not going to work for you here?
> 
> If you do have an event that needs special handling, I think you'd want
> to filter that out of the user space notification and invoke the kernel
> callback specific to it your event.

Can I plug a udev rule to an in-kernel driver? A concrete example of the
events we will handle is pblk having to remap data from a chunk that is
becoming unreliable.

> 
> On Fri, Apr 13, 2018@01:43:00PM +0200, Javier Gonz?lez wrote:
>> +static void nvme_aer_handle_work(struct work_struct *work)
>> +{
>> +	struct nvme_ctrl *ctrl =
>> +		container_of(work, struct nvme_ctrl, aer_handle_work);
>> +
>> +	if (ctrl->aen_result & NVME_AER_NOTICE_LNVM_CHUNK)
>> +		nvme_nvm_aer_handle(ctrl);
> 
> This 'if' will evaluate to true for _any_ VS AEN result, so this doesn't
> look like the right criteria for an LNVM specific.

See the next comment.

> 
>> +	nvme_async_event(ctrl);
>> +}
>> +
>> static bool nvme_ctrl_pp_status(struct nvme_ctrl *ctrl)
>> {
>> 
>> @@ -3362,7 +3378,16 @@ void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
>> 	default:
>> 		dev_warn(ctrl->device, "async event result %08x\n", result);
>> 	}
>> -	queue_work(nvme_wq, &ctrl->async_event_work);
>> +
>> +	/* TODO: Create a flag signaling the events that require kernel handling
>> +	 * to make this treatment generic
>> +	 */
>> +	if (result & NVME_AER_NOTICE_LNVM_CHUNK) {
>> +		ctrl->aen_result = result;
>> +		queue_work(nvme_wq, &ctrl->aer_handle_work);
> 
> If this event needs special kernel handling, you should filter it out
> in the switch statement above this code and directly invoke the special
> callback.

My thought with this is that a driver having to manage the event will
need to send the get log page command, thus it will need a workque or
similar; dealing with such logic in the driver makes it easier to
maintain I think. Then at the nvme_aer_handle_work() level, we would
filter out the events to the specific drivers.

> 
> I'm a bit concerned about special handling on a vendor specific code,
> though. That could easily collide with another vendor's that has an
> entirely different meaning.

Of course. None of the specific bits will be upstreamed until they
become standarized. As I answer to Christoph, at this point I want to
start building the foundation.

Thanks!
Javier


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: Message signed with OpenPGP
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20180413/5a5013aa/attachment.sig>

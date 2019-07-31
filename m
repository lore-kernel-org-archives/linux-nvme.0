From: hare@suse.de (Hannes Reinecke)
Date: Wed, 31 Jul 2019 22:04:17 +0200
Subject: [PATCH rfc 1/2] nvme: don't remove namespace if revalidate failed
 because of controller reset
In-Reply-To: <886831d7-7035-7c38-7b1f-9945c222564e@grimberg.me>
References: <20190729233201.27993-1-sagi@grimberg.me>
 <20190729233201.27993-2-sagi@grimberg.me>
 <993aee4e-9f9e-4af1-07e6-69218a12bc1b@suse.de>
 <886831d7-7035-7c38-7b1f-9945c222564e@grimberg.me>
Message-ID: <695cad74-aaed-d1aa-9381-b4430cd27925@suse.de>

On 7/31/19 8:16 PM, Sagi Grimberg wrote:
> 
>>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>>> index fa31da0762b9..5f6970e7ba73 100644
>>> --- a/drivers/nvme/host/core.c
>>> +++ b/drivers/nvme/host/core.c
>>> @@ -3428,7 +3428,8 @@ static void nvme_validate_ns(struct nvme_ctrl 
>>> *ctrl, unsigned nsid)
>>> ????? ns = nvme_find_get_ns(ctrl, nsid);
>>> ????? if (ns) {
>>> -??????? if (ns->disk && revalidate_disk(ns->disk))
>>> +??????? if (ns->disk && revalidate_disk(ns->disk) &&
>>> +??????????? ctrl->state != NVME_CTRL_LIVE)
>>> ????????????? nvme_ns_remove(ns);
>>> ????????? nvme_put_ns(ns);
>>> ????? } else
>>>
>> The thing I'm worried about here is concurrency (this was also what
>> caused my earlier attempts to be rejected).
>> Thing is, the controller state can be set asynchronously. Which in
>> itself is protected by ctrl->lock, but here we're not taking the lock at
>> all. Hence we might be seeing a stale value, causing us to makt the
>> wrong decision.
> 
> This is why the state check is _after_ the failure, if we failed to do
> I/O because of a reset, it will be reflected in the state.
> 
>> I have a patchset checking 'ctrl->state' under lock; will be posting it
>> later.
> 
> Unless the wraps your actions according the state, the state still
> advisory.
> 
>> And another thing: where's the point in 'revalidate_disk()' to be called
>> if the controller is not live? At best it won't do anything; at worst
>> we'll stall if we have to do more than one I/O (the reset cycle will
>> abort _one_ I/O, but if we have to submit more than one we'll be stuck,
>> too).
> 
> Exactly because of the race that you are indicating. We can't reliably
> know if the controller is resetting (or will be starting a reset soon)
> so we go ahead with the revalidate knowing that if the controller is
> resetting it will fail. That is why the state check is after (this tells
> us if the revalidation failed because of a reset or something else).

Okay, fair enough.

Reviewed-by: Hannes Reinecke <hare at suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare at suse.de                              +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG N?rnberg)

From: james.smart@broadcom.com (James Smart)
Date: Tue, 12 Jun 2018 14:20:47 -0700
Subject: [PATCH 1/3] nvme: also check for RESETTING state in
 nvmf_check_if_ready()
In-Reply-To: <20180607112601.GA10939@lst.de>
References: <20180607083847.51019-1-hare@suse.de>
 <20180607083847.51019-2-hare@suse.de>
 <91d12804-7d49-0109-6c7b-43a902f8c809@grimberg.me>
 <20180607112601.GA10939@lst.de>
Message-ID: <5b659e6e-06dd-7ede-9328-44607a44ec17@broadcom.com>



On 6/7/2018 4:26 AM, Christoph Hellwig wrote:
> On Thu, Jun 07, 2018@11:41:11AM +0300, Sagi Grimberg wrote:
>> Thank you Hannes - just spotted that...
>>
>> On 06/07/2018 11:38 AM, Hannes Reinecke wrote:
>>> When resetting the controller some transports go into 'RESETTING' state
>>> before issuing the actual 'reset' command. So add the 'RESETTING' state
>>> to nvmf_check_if_ready() to give them a chance to submit it.

I disagree with the base patch, as it can let other things through while 
in a reset when there was only 1 command to get through.? I would want 
to see a check for the property_set() command only as writing the 
CC.EN=0 is the only thing that should be sent on the wire if in a 
resetting state.


>>>
>>> Signed-off-by: Hannes Reinecke <hare at suse.com>
>>> ---
>>>    drivers/nvme/host/fabrics.c | 1 +
>>>    1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
>>> index fa32c1216409..909dd337221a 100644
>>> --- a/drivers/nvme/host/fabrics.c
>>> +++ b/drivers/nvme/host/fabrics.c
>>> @@ -548,6 +548,7 @@ blk_status_t nvmf_check_if_ready(struct nvme_ctrl *ctrl, struct request *rq,
>>>    	case NVME_CTRL_NEW:
>>>    	case NVME_CTRL_CONNECTING:
>>>    	case NVME_CTRL_DELETING:
>>> +	case NVME_CTRL_RESETTING:
>> I guess ADMIN_ONLY should also allow commands to pass.
> Only admin commands, though.

Huh - why do you want any commands, beyond a CC.EN=0 write, in a 
resetting state ?

Isn't ADMIN_ONLY just a form of LIVE with no io queues ???? why would 
you lump in this section that's trying to restrict commands to 
initialization things only ?

note: only pci sets things to ADMIN_ONLY. The fabric transports happily 
run with things w/o io queues (discovery controllers) in a LIVE state, 
not ADMIN_ONLY.


>
>>>    		/*
>>>    		 * This is the case of starting a new or deleting an association
>>>    		 * but connectivity was lost before it was fully created or torn
>> Looks like we have almost all the states? Shouldn't we reverse such that
>> we check only for DEAD (and WARN_ON for state NEW)?
> Sounds like an idea.  I'd like to see it in patch form first before
> agreeing..
>

It appears the whole idea of what is being filtered and why, which also 
means we aren't specific for what should be allowed in the different 
states, has been forgotten.? I'll go look at Christoph's reworked patch 
and comment there.

-- james

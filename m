From: james.smart@broadcom.com (James Smart)
Date: Mon, 12 Feb 2018 08:28:25 -0800
Subject: [PATCH 0/2] nvme-fc: io termination cleanup
In-Reply-To: <a09e98ff-04d4-1cd9-3c6d-2a7c32e9f1b6@grimberg.me>
References: <20180206144830.968-1-jsmart2021@gmail.com>
 <a09e98ff-04d4-1cd9-3c6d-2a7c32e9f1b6@grimberg.me>
Message-ID: <d619aea1-d6fc-862a-b6b6-d35a1b6075d5@broadcom.com>

Looks good.? I was more interested in the blk-mq resource busy addition 
that was merged as well. it looks fine too, but I'll need to test it a bit.

Thanks

-- james


On 2/11/2018 12:48 AM, Sagi Grimberg wrote:
>
>> The patches address io termination issues in nvme-fc:
>>
>> The first patch addresses a race condition on io termination vs
>> reset/delete abort paths that allowed an io to complete yet the
>> association termination counted it and is waiting for the completion.
>>
>> The second patch addresses cleanup of the code that was synchronizing
>> io termination between the lldd done path and the blk-mq completion
>> path. the completion path existed because, at the time, the eh_handler
>> could return a successful return status, allowing the complete routine
>> to be called, although the io was still active in the lldd. Since then
>> the eh_handler has been corrected to reschedule the io timer after
>> initiating the abort and this condition is no longer true.
>
> Hi James,
>
> Picked up for 4.16-rc, had a slight conflict due to Max's ctrl state
> change. Please verify its ok.
>
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme

From: jianchao.w.wang@oracle.com (jianchao.wang)
Date: Sat, 10 Feb 2018 10:59:32 +0800
Subject: [PATCH V2 0/6]nvme-pci: fixes on nvme_timeout and nvme_dev_disable
In-Reply-To: <de6fd2ac-fc69-1b3b-c206-7abfce24ac70@oracle.com>
References: <1517822415-11710-1-git-send-email-jianchao.w.wang@oracle.com>
 <073ce416-fd26-b41a-187d-1db9210c48b0@grimberg.me>
 <20180208175606.GD5039@localhost.localdomain>
 <db5fe34b-3ffb-a658-d4d6-a1c619b2d590@oracle.com>
 <20180209171231.GB6970@localhost.localdomain>
 <de6fd2ac-fc69-1b3b-c206-7abfce24ac70@oracle.com>
Message-ID: <1aa130e6-a1ff-bd17-a141-1a52f596dd8b@oracle.com>

Hi Keith

On 02/10/2018 10:32 AM, jianchao.wang wrote:
> Hi Keith
> 
> Thanks for your kindly response here.
> That's really appreciated.
> 
> On 02/10/2018 01:12 AM, Keith Busch wrote:
>> On Fri, Feb 09, 2018@09:50:58AM +0800, jianchao.wang wrote:
>>>
>>> if we set NVME_REQ_CANCELLED and return BLK_EH_HANDLED as the RESETTING case,
>>> nvme_reset_work will hang forever, because no one could complete the entered requests.
>>
>> Except it's no longer in the "RESETTING" case since you added the
>> "CONNECTING" state, so that's already broken for other reasons...
>>
> 
> Yes, but as your patch, we have to fail the IOs and even kill the controller.
> In fact, up to nvme_wait_freeze in nvme_reset_work, the RECONNECTING state has been completed.
> We even could say it is in LIVE state. Maybe we should recover the controller again instead
> of fail the IOs and kill the controller.
> 
> On the other hand, can you share with me why we cannot use blk_set_preempt_only to replace
> blk_freeze_queue ? we just want to gate the new bios out of generic_make_request and we 
> needn't use the preempt requests.
> 
> Looking forward your advice and directive.

Avoid wait_freeze in nvme_reset_work should be a better way to fix this defect.

> 
> Thanks
> Jianchao

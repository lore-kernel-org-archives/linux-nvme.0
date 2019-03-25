From: jianchao.w.wang@oracle.com (jianchao.wang)
Date: Mon, 25 Mar 2019 15:37:04 +0800
Subject: [PATCH V2 8/8] blk-mq: remove blk_mq_tagset_busy_iter
In-Reply-To: <47fe0e2a-f427-0e3e-e15b-a9e2bffb502f@suse.de>
References: <1553492318-1810-1-git-send-email-jianchao.w.wang@oracle.com>
 <1553492318-1810-9-git-send-email-jianchao.w.wang@oracle.com>
 <47fe0e2a-f427-0e3e-e15b-a9e2bffb502f@suse.de>
Message-ID: <f9d22543-65d1-e473-e3ab-deefa2d6e884@oracle.com>

Hi Hannes

On 3/25/19 3:18 PM, Hannes Reinecke wrote:
> On 3/25/19 6:38 AM, Jianchao Wang wrote:
>> As nobody uses blk_mq_tagset_busy_iter, remove it.
>>
>> Signed-off-by: Jianchao Wang <jianchao.w.wang at oracle.com>
>> ---
>> ? block/blk-mq-tag.c???? | 95 --------------------------------------------------
>> ? include/linux/blk-mq.h |? 2 --
>> ? 2 files changed, 97 deletions(-)
>>
> Please, don't.
> 
> I'm currently implementing reserved commands for SCSI and reworking the SCSI error handling where I rely on this interface quite heavily.


blk_mq_tagset_busy_iter could access some stale requests which maybe freed due to io scheduler switching, request_queue cleanup (shared tagset)
when there is someone submits io and gets driver tag. When io scheduler attached, even quiesce request_queue won't work.

If this patchset is accepted, blk_mq_tagset_busy_iter could be replaced with blk_mq_queue_inflight_tag_iter which needs
to be invoked by every request_queue that shares the tagset.

Please go ahead your work.

Thanks
Jianchao

> 
> Cheers,
> 
> Hannes

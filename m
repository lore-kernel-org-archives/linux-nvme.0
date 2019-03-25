From: hare@suse.de (Hannes Reinecke)
Date: Mon, 25 Mar 2019 09:25:20 +0100
Subject: [PATCH V2 8/8] blk-mq: remove blk_mq_tagset_busy_iter
In-Reply-To: <f9d22543-65d1-e473-e3ab-deefa2d6e884@oracle.com>
References: <1553492318-1810-1-git-send-email-jianchao.w.wang@oracle.com>
 <1553492318-1810-9-git-send-email-jianchao.w.wang@oracle.com>
 <47fe0e2a-f427-0e3e-e15b-a9e2bffb502f@suse.de>
 <f9d22543-65d1-e473-e3ab-deefa2d6e884@oracle.com>
Message-ID: <15fa9443-776b-bb75-0e20-538609d34eba@suse.de>

On 3/25/19 8:37 AM, jianchao.wang wrote:
> Hi Hannes
> 
> On 3/25/19 3:18 PM, Hannes Reinecke wrote:
>> On 3/25/19 6:38 AM, Jianchao Wang wrote:
>>> As nobody uses blk_mq_tagset_busy_iter, remove it.
>>>
>>> Signed-off-by: Jianchao Wang <jianchao.w.wang at oracle.com>
>>> ---
>>>  ? block/blk-mq-tag.c???? | 95 --------------------------------------------------
>>>  ? include/linux/blk-mq.h |? 2 --
>>>  ? 2 files changed, 97 deletions(-)
>>>
>> Please, don't.
>>
>> I'm currently implementing reserved commands for SCSI and reworking the SCSI error handling where I rely on
>> this interface quite heavily.
> 
> 
> blk_mq_tagset_busy_iter could access some stale requests which maybe freed due to io scheduler switching,
> request_queue cleanup (shared tagset)
> when there is someone submits io and gets driver tag. When io scheduler attached, even quiesce
> request_queue won't work.
> 
> If this patchset is accepted, blk_mq_tagset_busy_iter could be replaced with blk_mq_queue_inflight_tag_iter
> which needs to be invoked by every request_queue that shares the tagset.
> 
The point is, at that time I do _not_ have a request queue to work with.

Most SCSI drivers have a host-wide shared tagset, which is used by all 
request queues on that host.
Iterating over the shared tagset is far more efficient than to traverse 
over all devices and the attached request queues.

If I had to traverse all request queues I would need to add additional 
locking to ensure this traversal is race-free, making it a really 
cumbersome interface to use.

Plus the tagset iter is understood to be used only in cases where I/O is 
stopped from the upper layers (ie no new I/O will be submitted).
So here we only need to protect against I/O being completed, which is 
not what this patchset is about.

So my objection still stands: Please, don't.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG N?rnberg)

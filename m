From: hare@suse.de (Hannes Reinecke)
Date: Wed, 22 May 2019 16:00:59 +0200
Subject: [PATCH 4/4] nvme-fc: align nvme_fc_delete_association() with exit
 path
In-Reply-To: <20485830-ae6a-eae1-32f3-940ca2cc1bf3@broadcom.com>
References: <20190520063624.50338-1-hare@suse.de>
 <20190520063624.50338-5-hare@suse.de>
 <20485830-ae6a-eae1-32f3-940ca2cc1bf3@broadcom.com>
Message-ID: <6da3909f-cdaa-c6df-81fb-59f71d9f4f30@suse.de>

On 5/21/19 6:25 PM, James Smart wrote:
> 
> 
> On 5/19/2019 11:36 PM, Hannes Reinecke wrote:
>> nvme_fc_delete_association() should align with the exit path in
>> nvme_fc_create_association() to ensure we are able to handle the
>> failure case properly.
>>
>> Signed-off-by: Hannes Reinecke <hare at suse.com>
>> ---
>> ? drivers/nvme/host/fc.c | 10 +++++-----
>> ? 1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
>> index 71b22139e78b..ed9f4affbe10 100644
>> --- a/drivers/nvme/host/fc.c
>> +++ b/drivers/nvme/host/fc.c
>> @@ -2836,6 +2836,11 @@ nvme_fc_delete_association(struct nvme_fc_ctrl 
>> *ctrl)
>> ????? ctrl->flags &= ~FCCTRL_TERMIO;
>> ????? spin_unlock_irq(&ctrl->lock);
>> +??? if (ctrl->ctrl.tagset) {
>> +??????? nvme_fc_delete_hw_io_queues(ctrl);
>> +??????? nvme_fc_free_io_queues(ctrl);
>> +??? }
>> +
>> ????? nvme_fc_term_aen_ops(ctrl);
>> ????? /*
>> @@ -2847,11 +2852,6 @@ nvme_fc_delete_association(struct nvme_fc_ctrl 
>> *ctrl)
>> ????? if (ctrl->association_id)
>> ????????? nvme_fc_xmt_disconnect_assoc(ctrl);
>> -??? if (ctrl->ctrl.tagset) {
>> -??????? nvme_fc_delete_hw_io_queues(ctrl);
>> -??????? nvme_fc_free_io_queues(ctrl);
>> -??? }
>> -
>> ????? __nvme_fc_delete_hw_queue(ctrl, &ctrl->queues[0], 0);
>> ????? nvme_fc_free_queue(&ctrl->queues[0]);
> 
> no.? This is removing the underlying queues while blk-mq is still trying 
> to submit to them - causing yet a different set of issues as the driver 
> will have released contexts but the calldowns are still happening. Yet 
> another different set of issues would likely appear.?? no need for this 
> reorg.
> 
Ah. Hmm. Well, I thought by having both paths identical we can ensure 
that the error path in the first would actually work.
Now it's quite hard to test, lat alone validate.

But if you have objections we can surely drop this patch.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG N?rnberg)

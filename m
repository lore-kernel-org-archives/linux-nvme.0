From: hare@suse.de (Hannes Reinecke)
Date: Thu, 23 May 2019 07:33:20 +0200
Subject: [PATCH 3/4] nvme-fc: fail reconnect if state change fails
In-Reply-To: <alpine.LRH.2.21.9999.1905221035410.9636@mvluser05.qlc.com>
References: <20190520063624.50338-1-hare@suse.de>
 <20190520063624.50338-4-hare@suse.de>
 <alpine.LRH.2.21.9999.1905221035410.9636@mvluser05.qlc.com>
Message-ID: <f59abb21-c3e8-1aa3-9246-f4141862aa69@suse.de>

On 5/22/19 7:43 PM, Arun Easi wrote:
> On Sun, 19 May 2019, 11:36pm, Hannes Reinecke wrote:
> 
>> If the final state change to LIVE in nvme_fc_create_association()
>> fails the controller is not operational as no I/O is possible.
>> So we should be returning an error here to reschedule reconnect.
>> Additionally it should only be called while in CONNECTING state, so
>> add a check for this, too.
>>
>> Signed-off-by: Hannes Reinecke <hare at suse.com>
>> ---
>>  drivers/nvme/host/fc.c | 19 +++++++++++++++++++
>>  1 file changed, 19 insertions(+)
>>
>> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
>> index e5c81ba2b7a1..71b22139e78b 100644
>> --- a/drivers/nvme/host/fc.c
>> +++ b/drivers/nvme/host/fc.c
>> @@ -2624,6 +2624,14 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
>>  
>>  	++ctrl->ctrl.nr_reconnects;
>>  
>> +	if (ctrl->ctrl.state != NVME_CTRL_CONNECTING) {
> 
> Question: There is a path in nvme_fc_resume_controller() that schedules 
> connect_work when controller state is NVME_CTRL_NEW. I am not quite sure 
> when this is exercised; but if it does, it conflicts with this 
> expectation.
> 
To my understanding, the transition from NEW to LIVE is only valid for
PCI; NVMe-oF implementations should always move to CONNECTING first, ie
they should have a transition NEW -> CONNECTING -> LIVE.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)

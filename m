From: hare@suse.de (Hannes Reinecke)
Date: Fri, 17 May 2019 20:34:24 +0200
Subject: [PATCH 3/3] nvme-fc: fail reconnect if state change fails
In-Reply-To: <12b86c1a-9e83-f3b7-d72b-20eef528ab06@broadcom.com>
References: <20190517064254.95561-1-hare@suse.de>
 <20190517064254.95561-4-hare@suse.de>
 <12b86c1a-9e83-f3b7-d72b-20eef528ab06@broadcom.com>
Message-ID: <69ca35ef-1c40-03bd-b116-09dc3eb655aa@suse.de>

On 5/17/19 6:10 PM, James Smart wrote:
> On 5/16/2019 11:42 PM, Hannes Reinecke wrote:
>> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
>> index e5c81ba2b7a1..a8ef62512d9a 100644
>> --- a/drivers/nvme/host/fc.c
>> +++ b/drivers/nvme/host/fc.c
>> @@ -2726,6 +2734,13 @@ nvme_fc_create_association(struct nvme_fc_ctrl 
>> *ctrl)
>> ????? }
>> ????? changed = nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_LIVE);
>> +??? if (!changed && ctrl->ctrl.state != NVME_CTRL_DELETING) {
>> +??????? dev_err(ctrl->ctrl.device,
>> +??????????? "NVME-FC{%d}: error_recovery: Couldn't change "
>> +??????????? "state from %s to LIVE\n", ctrl->cnum,
>> +??????????? nvme_ctrl_state_name(&ctrl->ctrl));
>> +??????? return -EAGAIN;
>> +??? }
>> ????? ctrl->ctrl.nr_reconnects = 0;
> 
> Sorry, I should have spotted this last time.?? We shouldn't be exiting 
> in the bad case - we should be setting ret=-EAGAIN then have a goto 
> out_term_aen_ops so that whatever was built up for the association is 
> torn down.
> 
I _actually_ did do that on purpose; I did ask me the very same question.
Reasoning was that this is the final step, and reverting this would 
amount to a full reset. Hence we could just return an error, and let the 
reset handle things. Especially as we do not clear the reconnect counter 
here.
Am I wrong?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare at suse.de                              +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG N?rnberg)

From: hare@suse.de (Hannes Reinecke)
Date: Fri, 24 May 2019 09:35:39 +0200
Subject: [PATCH 2/4] nvme-fc: track state change failures during reconnect
In-Reply-To: <ddf3f233-263d-288a-aedd-8d1ee3989709@grimberg.me>
References: <20190520063624.50338-1-hare@suse.de>
 <20190520063624.50338-3-hare@suse.de>
 <ddf3f233-263d-288a-aedd-8d1ee3989709@grimberg.me>
Message-ID: <5dcb50ea-28d8-16b0-c7c7-3bc581717cbc@suse.de>

On 5/24/19 8:51 AM, Sagi Grimberg wrote:
> 
>> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
>> index 0c9e036afd09..e5c81ba2b7a1 100644
>> --- a/drivers/nvme/host/fc.c
>> +++ b/drivers/nvme/host/fc.c
>> @@ -2867,8 +2867,12 @@ nvme_fc_reconnect_or_delete(struct nvme_fc_ctrl 
>> *ctrl, int status)
>> ????? unsigned long recon_delay = ctrl->ctrl.opts->reconnect_delay * HZ;
>> ????? bool recon = true;
>> -??? if (ctrl->ctrl.state != NVME_CTRL_CONNECTING)
>> +??? if (ctrl->ctrl.state != NVME_CTRL_CONNECTING) {
>> +??????? dev_info(ctrl->ctrl.device,
>> +???????????? "NVME-FC{%d}: couldn't reconnect in state %s\n",
>> +???????????? ctrl->cnum, nvme_ctrl_state_name(&ctrl->ctrl));
> 
> Is this always "couldn't"? Is this expected?
> 
Surely not expected; this is pretty much the error path.

>> ????????? return;
>> +??? }
>> ????? if (portptr->port_state == FC_OBJSTATE_ONLINE)
>> ????????? dev_info(ctrl->ctrl.device,
>> @@ -2914,7 +2918,8 @@ __nvme_fc_terminate_io(struct nvme_fc_ctrl *ctrl)
>> ????????? !nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING))
>> ????????? dev_err(ctrl->ctrl.device,
>> ????????????? "NVME-FC{%d}: error_recovery: Couldn't change state "
>> -??????????? "to CONNECTING\n", ctrl->cnum);
>> +??????????? "from %s to CONNECTING\n", ctrl->cnum,
>> +??????????? nvme_ctrl_state_name(&ctrl->ctrl));
> 
> Doesn't this present an unnecessary combination of a lower-case state
> and all-caps CONNECTING?
Hmm. Indeed. I'll be using the same notation for the next version.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG N?rnberg)

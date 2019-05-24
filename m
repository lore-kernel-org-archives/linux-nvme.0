From: hare@suse.de (Hannes Reinecke)
Date: Fri, 24 May 2019 09:33:44 +0200
Subject: [PATCH 1/4] nvme: separate out nvme_ctrl_state_name()
In-Reply-To: <58613917-e96b-a325-7de4-75eaf8a2a138@grimberg.me>
References: <20190520063624.50338-1-hare@suse.de>
 <20190520063624.50338-2-hare@suse.de>
 <58613917-e96b-a325-7de4-75eaf8a2a138@grimberg.me>
Message-ID: <b6932c29-9f69-a372-9a31-f0c465fad78f@suse.de>

On 5/24/19 8:46 AM, Sagi Grimberg wrote:
> 
>> +const char *nvme_ctrl_state_name(struct nvme_ctrl *ctrl)
>> +{
>> +??? if ((unsigned)ctrl->state < ARRAY_SIZE(nvme_ctrl_state_names) &&
>> +??????? nvme_ctrl_state_names[ctrl->state])
>> +??????? return nvme_ctrl_state_names[ctrl->state];
>> +??? return "unknown state";
> 
> Maybe just "unknown"?
> 
> Otherwise looks fine..

Well, the original code had 'unknown state'.
So I thought to keep this behaviour.
But yeah, I like the 'unknown' better, too.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG N?rnberg)

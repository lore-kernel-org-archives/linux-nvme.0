From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 2 Oct 2018 09:17:12 -0700
Subject: [PATCH rfc 4/4] nvme: Ask for fabrics SQ flow control disable by
 default
In-Reply-To: <5adcc26b-a82c-31e9-5e95-55adeb40f9c0@suse.de>
References: <20181002001422.9111-1-sagi@grimberg.me>
 <20181002001422.9111-5-sagi@grimberg.me>
 <5adcc26b-a82c-31e9-5e95-55adeb40f9c0@suse.de>
Message-ID: <a0eea856-909c-699a-57b6-db6e12a9344f@grimberg.me>


>> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
>> index 38cf9d371953..ce61c3e1c22b 100644
>> --- a/drivers/nvme/host/fabrics.c
>> +++ b/drivers/nvme/host/fabrics.c
>> @@ -392,6 +392,9 @@ int nvmf_connect_admin_queue(struct nvme_ctrl *ctrl)
>> ????? cmd.connect.kato = ctrl->opts->discovery_nqn ? 0 :
>> ????????? cpu_to_le32((ctrl->kato + NVME_KATO_GRACE) * 1000);
>> +??? /* Ask to disable SQ head pointer updates */
>> +??? cmd.connect.cattr |= NVME_CONNECT_SQ_FC_DISABLED;
>> +
>> ????? data = kzalloc(sizeof(*data), GFP_KERNEL);
>> ????? if (!data)
>> ????????? return -ENOMEM;
>> @@ -451,6 +454,9 @@ int nvmf_connect_io_queue(struct nvme_ctrl *ctrl, 
>> u16 qid)
>> ????? cmd.connect.qid = cpu_to_le16(qid);
>> ????? cmd.connect.sqsize = cpu_to_le16(ctrl->sqsize);
>> +??? /* Ask to disable SQ head pointer updates */
>> +??? cmd.connect.cattr |= NVME_CONNECT_SQ_FC_DISABLED;
>> +
>> ????? data = kzalloc(sizeof(*data), GFP_KERNEL);
>> ????? if (!data)
>> ????????? return -ENOMEM;
>>
> There are two issues with that:
> - as the bit was reserved initially any target is free to reject the 
> connect command on the grounds that some undefined bits are set.

Yea... I guess we can't do it by default...

> - As per SQ flow control specification any target might _legitimately_ 
> reject the connect command, namely if the target doesn't allow to 
> disable SQ flow control. With this change we would never be able to 
> connect to these targets.

The TP does says that if the controller disallows disabling flow control
by sending sq_head that is not 0xffff to the connect command, _not_
reject the connect.

> Hence I would prefer to have an option '--disable-sqflow' for the 'nvme 
> connect' command, allowing us to manually disable SQ Flow control.
> That would not modify existing behaviour, and we can properly support 
> arrays requiring SQ flow control.

We could do that, and hook it to connect-all (btw, another reason why
adding a kernel discovery parser in addition to userspace is not a good
idea..)

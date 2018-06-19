From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 19 Jun 2018 17:00:30 +0300
Subject: [PATCH resend 2/2] nvme: start keep alive timer when enabling the
 controller
In-Reply-To: <99c7c07f-efca-e1e2-d163-043701b0d001@mellanox.com>
References: <20180619123850.25659-1-sagi@grimberg.me>
 <20180619123850.25659-2-sagi@grimberg.me>
 <99c7c07f-efca-e1e2-d163-043701b0d001@mellanox.com>
Message-ID: <bb89a63f-12ff-45f6-404b-ab3097c8ee8d@grimberg.me>


>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index 3ba4232d114e..8673b7816e9a 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -1761,7 +1761,14 @@ int nvme_enable_ctrl(struct nvme_ctrl *ctrl, 
>> u64 cap)
>> ????? ret = ctrl->ops->reg_write32(ctrl, NVME_REG_CC, ctrl->ctrl_config);
>> ????? if (ret)
>> ????????? return ret;
>> -??? return nvme_wait_ready(ctrl, cap, true);
>> +
>> +??? ret = nvme_wait_ready(ctrl, cap, true);
>> +??? if (ret)
>> +??????? return ret;
>> +
>> +??? nvme_start_keep_alive(ctrl);
>> +
>> +??? return 0;
>> ? }
>> ? EXPORT_SYMBOL_GPL(nvme_enable_ctrl);
> 
> We have an issue here with stopping the keep-alive in error flows.

Ugh..

Then lets disregard this patch (1/2 should be fine though) and return
to the sketch board.

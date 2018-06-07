From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 7 Jun 2018 18:23:20 +0300
Subject: [PATCH 08/17] nvme: limit integrity segments to be <= data
 segments
In-Reply-To: <f7bf4e84-f403-7576-299f-63b0c4aa6f1b@mellanox.com>
References: <1527436222-15494-1-git-send-email-maxg@mellanox.com>
 <1527436222-15494-9-git-send-email-maxg@mellanox.com>
 <19c8562a-8478-196c-c9f5-385d2076448e@grimberg.me>
 <f7bf4e84-f403-7576-299f-63b0c4aa6f1b@mellanox.com>
Message-ID: <48221c3e-833e-5ac0-cf25-2c61baaff120@grimberg.me>


>>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>>> index 197208a..e81e898 100644
>>> --- a/drivers/nvme/host/core.c
>>> +++ b/drivers/nvme/host/core.c
>>> @@ -1795,6 +1795,10 @@ static void nvme_set_queue_limits(struct 
>>> nvme_ctrl *ctrl,
>>> ????????? u32 max_segments =
>>> ????????????? (ctrl->max_hw_sectors / (ctrl->page_size >> 9)) + 1;
>>> +??????? if (ctrl->max_integrity_segments)
>>> +??????????? ctrl->max_integrity_segments = 
>>> min(ctrl->max_integrity_segments,
>>> +?????????????????????????????? max_segments);
>>> +
>>
>> What is this protecting against?
> 
> This is for good practice, I don't think the block layer will/can send 
> us more integrity_segments than data_segments. but seems weird to have 
> more max_integrity_segments than max_data_segments, isn't it ?

drivers are not responsible to cover for upper layer bugs. If there is a
bug, it needs to be fixed, not hide behind a driver protection.

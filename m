From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 25 Feb 2019 13:24:48 -0800
Subject: [PATCH 2/3 rfc] nvme: enable aen also for discovery controllers
In-Reply-To: <5873c894-ab14-b012-a0be-6fb80a41b24a@mellanox.com>
References: <20190223023117.20517-1-sagi@grimberg.me>
 <20190223023117.20517-3-sagi@grimberg.me>
 <5873c894-ab14-b012-a0be-6fb80a41b24a@mellanox.com>
Message-ID: <345747f6-9b12-de58-107b-93004afbfc80@grimberg.me>


>> @@ -3662,10 +3664,13 @@ void nvme_start_ctrl(struct nvme_ctrl *ctrl)
>> ????? if (ctrl->kato)
>> ????????? nvme_start_keep_alive(ctrl);
>> +??? if (ctrl->queue_count > 1 ||
>> +??????? (ctrl->ops->flags & NVME_F_FABRICS &&
>> +???????? ctrl->opts->discovery_nqn))
>> +??????? nvme_enable_aen(ctrl);
>> +
> 
> why queue_count > 1 is a condition to enable AEN ?

I just pulled the below code up, but it seems you are right
regardless of this patch. The AER should be independent of
having I/O queues.

> Sounds more like an admin related action...
> 
>> ????? if (ctrl->queue_count > 1) {
>> ????????? nvme_queue_scan(ctrl);
>> -??????? nvme_enable_aen(ctrl);
>> -??????? queue_work(nvme_wq, &ctrl->async_event_work);
>> ????????? nvme_start_queues(ctrl);
>> ????? }
>> ? }

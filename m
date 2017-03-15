From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 15 Mar 2017 04:03:44 +0200
Subject: [PATCH 1/3] nvme-rdma: handle cpu unplug when re-establishing the
 controller
In-Reply-To: <20170313195818.GB9648@lst.de>
References: <1489413740-29085-1-git-send-email-sagi@grimberg.me>
 <20170313195818.GB9648@lst.de>
Message-ID: <f42a5371-e54a-426d-6e4d-5d8def4ea546@grimberg.me>


>> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
>> index 779f516e7a4e..47a479f26e5d 100644
>> --- a/drivers/nvme/host/rdma.c
>> +++ b/drivers/nvme/host/rdma.c
>> @@ -343,8 +343,6 @@ static int __nvme_rdma_init_request(struct nvme_rdma_ctrl *ctrl,
>>  	struct ib_device *ibdev = dev->dev;
>>  	int ret;
>>
>> -	BUG_ON(queue_idx >= ctrl->queue_count);
>
> This makes me a bit nervous, shouldn't we ensure that queue_count
> is accurate even with the fix?

I don't think this is true anymore given that we allocate the
tagset with X nr_hw_queues and if we unplug a cpu when we reset
or reconnect a controller we take the minimum of initial nr_io_queues
(X) and online cpus.

I can change this to be:

BUG_ON(queue_idx >= ctrl->opts->nr_io_queues);

instead if we want to keep the check...

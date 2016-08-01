From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 1 Aug 2016 14:17:37 +0300
Subject: [PATCH 3/5] nvme-rdma: Make sure to shutdown the controller if we
 can
In-Reply-To: <20160801110446.GD16141@lst.de>
References: <1469822242-3477-1-git-send-email-sagi@grimberg.me>
 <1469822242-3477-4-git-send-email-sagi@grimberg.me>
 <20160801110446.GD16141@lst.de>
Message-ID: <63b33585-3fd2-a497-94a1-34dc9484da99@grimberg.me>


>> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
>> index a70eb3cbf656..641ab7f91899 100644
>> --- a/drivers/nvme/host/rdma.c
>> +++ b/drivers/nvme/host/rdma.c
>> @@ -1644,7 +1644,7 @@ static void nvme_rdma_shutdown_ctrl(struct nvme_rdma_ctrl *ctrl)
>>  		nvme_rdma_free_io_queues(ctrl);
>>  	}
>>
>> -	if (ctrl->ctrl.state == NVME_CTRL_LIVE)
>> +	if (test_bit(NVME_RDMA_Q_CONNECTED, &ctrl->queues[0].flags))
>>  		nvme_shutdown_ctrl(&ctrl->ctrl);
>>
>>  	blk_mq_stop_hw_queues(ctrl->ctrl.admin_q);
>
> Maybe the right way to handle this is to unconditionally call
> nvme_shutdown_ctrl and make sure we return an early error
> on the register write?

As I wrote on patch 2/5 reply, I'd like to avoid depending on
queue_rq to fail early peeking at the ctrl state. This dependency
can grow in the future and I think we should at least try not to
go there...

From: hch@lst.de (Christoph Hellwig)
Date: Tue, 6 Jun 2017 17:33:26 +0200
Subject: [PATCH for-4.12-rc] nvme-rdma: fast fail incoming requests
 while we reconnect
In-Reply-To: <9e629028-98df-8165-6826-82fd497d7521@mellanox.com>
References: <1496684156-32335-1-git-send-email-sagi@grimberg.me>
 <9e629028-98df-8165-6826-82fd497d7521@mellanox.com>
Message-ID: <20170606153326.GA13763@lst.de>

On Tue, Jun 06, 2017@04:46:52PM +0300, Max Gurtovoy wrote:
> hi,
>
>> -static inline bool nvme_rdma_queue_is_ready(struct nvme_rdma_queue *queue,
>> +static inline int nvme_rdma_queue_is_ready(struct nvme_rdma_queue *queue,
>>  		struct request *rq)
>>  {
>>  	if (unlikely(!test_bit(NVME_RDMA_Q_LIVE, &queue->flags))) {
>> @@ -1441,11 +1443,22 @@ static inline bool nvme_rdma_queue_is_ready(struct nvme_rdma_queue *queue,
>>
>>  		if (!blk_rq_is_passthrough(rq) ||
>>  		    cmd->common.opcode != nvme_fabrics_command ||
>> -		    cmd->fabrics.fctype != nvme_fabrics_type_connect)
>> -			return false;
>> +		    cmd->fabrics.fctype != nvme_fabrics_type_connect) {
>> +			/*
>> +			 * reconnecting state means transport disruption, which
>> +			 * can take a long time and even might fail permanently,
>> +			 * so we can't let incoming I/O be requeued forever.
>> +			 * fail it fast to allow upper layers a chance to
>> +			 * failover.
>> +			 */
>> +			if (queue->ctrl->ctrl->state == NVME_CTRL_RECONNECTING)
>
> Sagi/Christoph,
> It should be queue->ctrl->ctrl.state.
>
> we are testing this patch also now.

I've fixed this up already.  Especially as the earlier version got it
right :)

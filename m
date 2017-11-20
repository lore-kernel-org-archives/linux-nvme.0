From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 20 Nov 2017 13:32:49 +0200
Subject: [PATCH v2] nvme-rdma: Use mr pool
In-Reply-To: <20171120080951.GA27552@lst.de>
References: <1510674794-3800-1-git-send-email-israelr@mellanox.com>
 <20171120080951.GA27552@lst.de>
Message-ID: <70dfeed6-303f-23e6-4278-344ce62d7cb4@grimberg.me>

>> @@ -495,8 +457,26 @@ static int nvme_rdma_create_queue_ib(struct nvme_rdma_queue *queue)
>>   		goto out_destroy_qp;
>>   	}
>>   
>> +	if (idx == 0)
>> +		queue->ctrl->max_fr_pages = min_t(u32, NVME_RDMA_MAX_SEGMENTS,
>> +				ibdev->attrs.max_fast_reg_page_list_len);
>> +
> 
> Hmm.  Why is this code moved here from nvme_rdma_configure_admin_queue?
> I really don't like per-controller initialization in per-queue functions
> but if there is no good way around it it needs a very good explanation,
> and that explanation should be in a comment place next to the code.

I agree, I'd even prefer it calculated here locally for the mr pool and
set it in its original place (perhaps add a simple helper for it).

>> +	req->mr = ib_mr_pool_get(queue->qp, &queue->qp->rdma_mrs);
>> +	if (unlikely(!req->mr))
>> +		return -EAGAIN;
>> +
> 
> Shouldn't the MR pool be sized that this always succeeds?  If so a
> WARN_ON_ONCE() here might be useful.

Agree.

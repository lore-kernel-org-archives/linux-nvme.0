From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 22 Nov 2017 16:31:35 +0200
Subject: [Suspected-Phishing]Re: [PATCH v2 1/1] nvme-rdma: Fix memory leak
 during queue allocation
In-Reply-To: <d4588577-4be1-e233-51ac-b9d06d546e84@mellanox.com>
References: <1510481554-28106-1-git-send-email-maxg@mellanox.com>
 <9b3b8587-ae00-fff6-cf0d-7e02e091a143@grimberg.me>
 <2b93f67a-4422-0c48-7fd7-416e0dbc6220@mellanox.com>
 <d4588577-4be1-e233-51ac-b9d06d546e84@mellanox.com>
Message-ID: <ed394821-3024-9c93-c4d7-83ae6d6f2b11@grimberg.me>


>> In order to destroy QP using 1 API instead of 2.
>> We can leave it "rdma_destroy_qp(queue->cm_id);", here it's safe.
>>
> 
> should I leave it rdma_destroy_qp(queue->cm_id) or modify it to 
> ib_destroy_qp(queue->qp) ?

Yes

>>>> @@ -563,8 +573,8 @@ static void nvme_rdma_free_queue(struct 
>>>> nvme_rdma_queue *queue)
>>>> ????? if (!test_and_clear_bit(NVME_RDMA_Q_ALLOCATED, &queue->flags))
>>>> ????????? return;
>>>> -??? nvme_rdma_destroy_queue_ib(queue);
>>>> ????? rdma_destroy_id(queue->cm_id);
>>>> +??? nvme_rdma_destroy_queue_ib(queue);
>>>
>>> Why was this changed? What race are you preventing here?
>>
>> No race here, just wanted to align the order of destruction and make 
>> sure we don't get any rdma_cm events during queue_ib destruction as we 
>> did above.
>>
>> Do you prefer leaving these 2 lines "as is" and add comments in the 
>> code ?
> 
> what is prefered here ?

Keep it as is

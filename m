From: maxg@mellanox.com (Max Gurtovoy)
Date: Wed, 22 Nov 2017 15:48:46 +0200
Subject: [Suspected-Phishing]Re: [PATCH v2 1/1] nvme-rdma: Fix memory leak
 during queue allocation
In-Reply-To: <2b93f67a-4422-0c48-7fd7-416e0dbc6220@mellanox.com>
References: <1510481554-28106-1-git-send-email-maxg@mellanox.com>
 <9b3b8587-ae00-fff6-cf0d-7e02e091a143@grimberg.me>
 <2b93f67a-4422-0c48-7fd7-416e0dbc6220@mellanox.com>
Message-ID: <d4588577-4be1-e233-51ac-b9d06d546e84@mellanox.com>

Hi Sagi/Christoph,

On 11/14/2017 10:57 AM, Max Gurtovoy wrote:
> 
> 
> On 11/13/2017 9:31 PM, Sagi Grimberg wrote:
>> Hi Max,
>>
>>> ? out_destroy_qp:
>>> -??? rdma_destroy_qp(queue->cm_id);
>>> +??? ib_destroy_qp(queue->qp);
>>
>> Why was this changed? Any specific reason?>
>>
> 
> In order to destroy QP using 1 API instead of 2.
> We can leave it "rdma_destroy_qp(queue->cm_id);", here it's safe.
> 

should I leave it rdma_destroy_qp(queue->cm_id) or modify it to 
ib_destroy_qp(queue->qp) ?

>>> ? out_destroy_ib_cq:
>>> ????? ib_free_cq(queue->ib_cq);
>>> ? out_put_dev:
>>> @@ -546,6 +555,7 @@ static int nvme_rdma_alloc_queue(struct 
>>> nvme_rdma_ctrl *ctrl,
>>> ? out_destroy_cm_id:
>>> ????? rdma_destroy_id(queue->cm_id);
>>> +??? nvme_rdma_destroy_queue_ib(queue);
>>> ????? return ret;
>>> ? }
>>> @@ -563,8 +573,8 @@ static void nvme_rdma_free_queue(struct 
>>> nvme_rdma_queue *queue)
>>> ????? if (!test_and_clear_bit(NVME_RDMA_Q_ALLOCATED, &queue->flags))
>>> ????????? return;
>>> -??? nvme_rdma_destroy_queue_ib(queue);
>>> ????? rdma_destroy_id(queue->cm_id);
>>> +??? nvme_rdma_destroy_queue_ib(queue);
>>
>> Why was this changed? What race are you preventing here?
> 
> No race here, just wanted to align the order of destruction and make 
> sure we don't get any rdma_cm events during queue_ib destruction as we 
> did above.
> 
> Do you prefer leaving these 2 lines "as is" and add comments in the code ?

what is prefered here ?

> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> https://emea01.safelinks.protection.outlook.com/?url=http%3A%2F%2Flists.infradead.org%2Fmailman%2Flistinfo%2Flinux-nvme&data=02%7C01%7Cmaxg%40mellanox.com%7C82f0b9595a1848503fa608d52b3de82c%7Ca652971c7d2e4d9ba6a4d149256f461b%7C0%7C0%7C636462467259217932&sdata=kCIR9j%2FJZxm8NN72rqaOg%2BC9METO6XicAkoIYAY%2BQio%3D&reserved=0 
> 

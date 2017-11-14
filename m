From: maxg@mellanox.com (Max Gurtovoy)
Date: Tue, 14 Nov 2017 10:57:57 +0200
Subject: [PATCH v2 1/1] nvme-rdma: Fix memory leak during queue allocation
In-Reply-To: <9b3b8587-ae00-fff6-cf0d-7e02e091a143@grimberg.me>
References: <1510481554-28106-1-git-send-email-maxg@mellanox.com>
 <9b3b8587-ae00-fff6-cf0d-7e02e091a143@grimberg.me>
Message-ID: <2b93f67a-4422-0c48-7fd7-416e0dbc6220@mellanox.com>



On 11/13/2017 9:31 PM, Sagi Grimberg wrote:
> Hi Max,
> 
>> ? out_destroy_qp:
>> -??? rdma_destroy_qp(queue->cm_id);
>> +??? ib_destroy_qp(queue->qp);
> 
> Why was this changed? Any specific reason?>
> 

In order to destroy QP using 1 API instead of 2.
We can leave it "rdma_destroy_qp(queue->cm_id);", here it's safe.

>> ? out_destroy_ib_cq:
>> ????? ib_free_cq(queue->ib_cq);
>> ? out_put_dev:
>> @@ -546,6 +555,7 @@ static int nvme_rdma_alloc_queue(struct 
>> nvme_rdma_ctrl *ctrl,
>> ? out_destroy_cm_id:
>> ????? rdma_destroy_id(queue->cm_id);
>> +??? nvme_rdma_destroy_queue_ib(queue);
>> ????? return ret;
>> ? }
>> @@ -563,8 +573,8 @@ static void nvme_rdma_free_queue(struct 
>> nvme_rdma_queue *queue)
>> ????? if (!test_and_clear_bit(NVME_RDMA_Q_ALLOCATED, &queue->flags))
>> ????????? return;
>> -??? nvme_rdma_destroy_queue_ib(queue);
>> ????? rdma_destroy_id(queue->cm_id);
>> +??? nvme_rdma_destroy_queue_ib(queue);
> 
> Why was this changed? What race are you preventing here?

No race here, just wanted to align the order of destruction and make 
sure we don't get any rdma_cm events during queue_ib destruction as we 
did above.

Do you prefer leaving these 2 lines "as is" and add comments in the code ?

From: maxg@mellanox.com (Max Gurtovoy)
Date: Sun, 5 Nov 2017 18:35:33 +0200
Subject: [PATCH v2 1/1] nvme-rdma: Introduce nvme_rdma_destroy_qp
In-Reply-To: <99ae0d5e-5ccf-a4f2-4e1c-d6e1f0e10016@grimberg.me>
References: <1509804987-656-1-git-send-email-maxg@mellanox.com>
 <99ae0d5e-5ccf-a4f2-4e1c-d6e1f0e10016@grimberg.me>
Message-ID: <d1bf1913-115c-fb07-2b4e-1d5322872f2b@mellanox.com>



On 11/5/2017 4:00 PM, Sagi Grimberg wrote:
> 
>> +static void nvme_rdma_destroy_qp(struct nvme_rdma_queue *queue)
>> +{
>> +??? rdma_destroy_qp(queue->cm_id);
>> +??? queue->qp = NULL;
> 
> Why is setting the qp to NULL needed here?
> 
> I'd rather not do this if we don't have a good reason reason for it.

Currently it's there for symmetry.
Do you prefer to point to freed memory ? I can resend it if needed.

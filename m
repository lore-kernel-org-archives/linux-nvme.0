From: maxg@mellanox.com (Max Gurtovoy)
Date: Sun, 24 Jun 2018 13:40:54 +0300
Subject: [Suspected-Phishing]Re: [PATCH 2/7] nvme-rdma: fix possible free
 non-allocated async event buffer
In-Reply-To: <479f91be-2a8c-ae01-fee1-71fa2e18372f@mellanox.com>
References: <20180619123415.25077-1-sagi@grimberg.me>
 <20180619123415.25077-3-sagi@grimberg.me> <20180620083159.GB3284@lst.de>
 <479f91be-2a8c-ae01-fee1-71fa2e18372f@mellanox.com>
Message-ID: <91bc7b1a-6fb1-e1e0-3437-dc8e46cc6d58@mellanox.com>

Hi all,

On 6/20/2018 3:02 PM, Max Gurtovoy wrote:
> 
> 
> On 6/20/2018 11:31 AM, Christoph Hellwig wrote:
>> On Tue, Jun 19, 2018@03:34:10PM +0300, Sagi Grimberg wrote:
>>> If nvme_rdma_configure_admin_queue fails before we allocated
>>> the async event buffer, we will falsly free it because 
>>> nvme_rdma_free_queue
>>> is freeing it. Fix it by allocating the buffer right after 
>>> nvme_rdma_alloc_queue
>>> and free it right before nvme_rdma_queue_free to maintain orderly 
>>> reverse cleanup
>>> sequence.
>>
>> This looks much nicer indeed.
>>
> 
> Looks good,
> 
> Reviewed-by: Max Gurtovoy <maxg at mellanox.com>

this fix still doesn't fix the issue that V1 from Israel did.
we still can call nvme_rdma_destroy_admin_queue few times (as I 
mentioned nvme_rdma_free_queue is safe by NVME_RDMA_Q_ALLOCATED bit but 
nvme_rdma_destroy_admin_queue isn't).

I added this check but I think this is not enough since things can run 
concurrently (I still need to make some testing and review):

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 5194568..e99ff80 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -168,8 +168,11 @@ static inline size_t 
nvme_rdma_inline_data_size(struct nvme_rdma_queue *queue)
  static void nvme_rdma_free_qe(struct ib_device *ibdev, struct 
nvme_rdma_qe *qe,
                 size_t capsule_size, enum dma_data_direction dir)
  {
-       ib_dma_unmap_single(ibdev, qe->dma, capsule_size, dir);
-       kfree(qe->data);
+       if (qe->data) {
+               ib_dma_unmap_single(ibdev, qe->dma, capsule_size, dir);
+               kfree(qe->data);
+               qe->data = NULL;
+       }
  }





> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> https://emea01.safelinks.protection.outlook.com/?url=http%3A%2F%2Flists.infradead.org%2Fmailman%2Flistinfo%2Flinux-nvme&data=02%7C01%7Cmaxg%40mellanox.com%7Ce2bebd0648f74427466408d5d6a5b1ab%7Ca652971c7d2e4d9ba6a4d149256f461b%7C0%7C0%7C636650929500779816&sdata=Qss9K8ON2dKd%2FQPLIcJG7voRuH4dVffx5Sjr7D7GNzc%3D&reserved=0 
> 

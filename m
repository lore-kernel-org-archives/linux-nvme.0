From: maxg@mellanox.com (Max Gurtovoy)
Date: Tue, 19 Jun 2018 14:57:07 +0300
Subject: [PATCH] nvme: Fix error flow at nvme_rdma_configure_admin_queue()
In-Reply-To: <20180619054157.GC23184@lst.de>
References: <1528979864-3109-1-git-send-email-israelr@mellanox.com>
 <20180615080154.GA19525@lst.de>
 <a760d739-f88b-99bf-27ca-4dee113b5b49@mellanox.com>
 <20180619054157.GC23184@lst.de>
Message-ID: <59bc24d2-1e73-b2c8-14f3-0f17b4df6189@mellanox.com>



On 6/19/2018 8:41 AM, Christoph Hellwig wrote:
> On Sun, Jun 17, 2018@01:52:55PM +0300, Max Gurtovoy wrote:
>>> back instead and have a different double free protection.  E.g.
>>> in nvme_rdma_free_qe just check if qe->data is set first,
>>> and the NULL it out when freeing.
>>>
>>
>> I guess we can but this is not enough since we'll need to move the call to
>> nvme_rdma_free_qe to be after stopping the queue. I actually think that
>> making it symetrical is the right way to go (we also have a flag
>> NVME_RDMA_Q_ALLOCATED that helps here) but I guess reverting Sagi's commit
>> + some fix will work too.
> 
> Yes, it should be symetrical either way.  What is the story with
> NVME_RDMA_Q_ALLOCATED?
> 

No real story, just saying that this patch will guarenty that 
allocating/releasing the qe will be guarded by the NVME_RDMA_Q_ALLOCATED 
bit.

In order to make it symetrical and right in the second way, we'll need 
to allocate it before nvme_rdma_start_queue and free it after 
nvme_rdma_stop_queue.

since we have some issues and WIP regarding the location of 
nvme_rdma_stop_queue I think we should take the first way for now (the 
way that proposed in this patch).

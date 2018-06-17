From: maxg@mellanox.com (Max Gurtovoy)
Date: Sun, 17 Jun 2018 13:52:55 +0300
Subject: [PATCH] nvme: Fix error flow at nvme_rdma_configure_admin_queue()
In-Reply-To: <20180615080154.GA19525@lst.de>
References: <1528979864-3109-1-git-send-email-israelr@mellanox.com>
 <20180615080154.GA19525@lst.de>
Message-ID: <a760d739-f88b-99bf-27ca-4dee113b5b49@mellanox.com>



On 6/15/2018 11:01 AM, Christoph Hellwig wrote:
> On Thu, Jun 14, 2018@12:37:44PM +0000, Israel Rukshin wrote:
>> On error calling to nvme_rdma_free_queue() with admin queue
>> frees the QE before it was allocated.
>>
>> Signed-off-by: Israel Rukshin <israelr at mellanox.com>
>> Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
> 
> This certainly matches what we do in nvme_rdma_free_queue, but it
> looks like a little too much special casing vodoo to me.
> 
> The nvme_rdma_free_queue was added by Sagi last October to fix
> a reconnect double free.  But I wonder if we just need to move it
> back instead and have a different double free protection.  E.g.
> in nvme_rdma_free_qe just check if qe->data is set first,
> and the NULL it out when freeing.
> 

I guess we can but this is not enough since we'll need to move the call 
to nvme_rdma_free_qe to be after stopping the queue. I actually think 
that making it symetrical is the right way to go (we also have a flag 
NVME_RDMA_Q_ALLOCATED that helps here) but I guess reverting Sagi's 
commit + some fix will work too.

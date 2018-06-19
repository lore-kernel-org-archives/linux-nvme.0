From: maxg@mellanox.com (Max Gurtovoy)
Date: Tue, 19 Jun 2018 15:09:16 +0300
Subject: [PATCH] nvme: Fix error flow at nvme_rdma_configure_admin_queue()
In-Reply-To: <b26fe840-8521-82f6-39c4-e5976e37c4a8@grimberg.me>
References: <1528979864-3109-1-git-send-email-israelr@mellanox.com>
 <20180615080154.GA19525@lst.de>
 <a760d739-f88b-99bf-27ca-4dee113b5b49@mellanox.com>
 <20180619054157.GC23184@lst.de>
 <b26fe840-8521-82f6-39c4-e5976e37c4a8@grimberg.me>
Message-ID: <a75ce20c-e217-e2f8-6015-b6e2987499db@mellanox.com>



On 6/19/2018 1:36 PM, Sagi Grimberg wrote:
> 
>>>> back instead and have a different double free protection.? E.g.
>>>> in nvme_rdma_free_qe just check if qe->data is set first,
>>>> and the NULL it out when freeing.
>>>>
>>>
>>> I guess we can but this is not enough since we'll need to move the 
>>> call to
>>> nvme_rdma_free_qe to be after stopping the queue. I actually think that
>>> making it symetrical is the right way to go (we also have a flag
>>> NVME_RDMA_Q_ALLOCATED that helps here) but I guess reverting Sagi's 
>>> commit
>>> + some fix will work too.
> 
> I don't think this is the way to go. And I don't think that reverting it
> is either the way to go.
> 
> The commit message said:
> -- 
>  ??? nvme-rdma: Fix possible double free in reconnect flow
> 
>  ??? The fact that we free the async event buffer in
>  ??? nvme_rdma_destroy_admin_queue can cause us to free it
>  ??? more than once because this happens in every reconnect
>  ??? attempt since commit 31fdf1840170. we rely on the queue
>  ??? state flags DELETING to avoid this for other resources.
> 
>  ??? A more complete fix is to not destroy the admin/io queues
>  ??? unconditionally on every reconnect attempt, but its a bit
>  ??? more extensive and will go in the next release.
> -- 
> 
> Today, we don't destroy the admin queue on every reconnect so
> I think we are OK with restoring it back, but looking at the code
> some more is needed.
> 
> I think that the async buffer needs to be allocated right after
> nvme_alloc_rdma_queue and to be free right before nvme_rdma_free_queue.

why ? we call nvme_start_ctrl after configuring the admin queue. and we 
free the async buffer after we drain the QP.

am I missing something ?

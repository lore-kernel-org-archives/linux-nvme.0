From: maxg@mellanox.com (Max Gurtovoy)
Date: Tue, 19 Jun 2018 19:08:37 +0300
Subject: [PATCH] nvme: Fix error flow at nvme_rdma_configure_admin_queue()
In-Reply-To: <ecedcef1-0025-6848-1276-f143e9707a32@grimberg.me>
References: <1528979864-3109-1-git-send-email-israelr@mellanox.com>
 <20180615080154.GA19525@lst.de>
 <a760d739-f88b-99bf-27ca-4dee113b5b49@mellanox.com>
 <20180619054157.GC23184@lst.de>
 <b26fe840-8521-82f6-39c4-e5976e37c4a8@grimberg.me>
 <a75ce20c-e217-e2f8-6015-b6e2987499db@mellanox.com>
 <ecedcef1-0025-6848-1276-f143e9707a32@grimberg.me>
Message-ID: <15c4c281-cea1-1a97-e5dd-41e0ef49fdd9@mellanox.com>



On 6/19/2018 3:30 PM, Sagi Grimberg wrote:
> 
>>> I think that the async buffer needs to be allocated right after
>>> nvme_alloc_rdma_queue and to be free right before nvme_rdma_free_queue.
>>
>> why ? we call nvme_start_ctrl after configuring the admin queue. and 
>> we free the async buffer after we drain the QP.
>>
>> am I missing something ?
> 
> If I'm not mistaken (as the change log wasn't clear enough), the issue
> was that in reset we fail to to configure the admin queue? (before async
> event buffer was allocated) and then call reconnect_or_remove which will
> eventually call nvme_rdma_destroy_admin_queue (freeing the async event
> buffer).
> 

No this is no the issue. The issue is that in case of failure during 
nvme_rdma_configure_admin_queue we go to error flow that frees the non 
allocated buffer. This is happening because the allocation/free are not 
symetrical.
The patch fixes that.

> Allocatning the async event buffer before nvme_rdma_start_queue should
> guarantee that if we failed in nvme_rdma_start_queue we won't free the
> buffer, and if we failed after, we will.

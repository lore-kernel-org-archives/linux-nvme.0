From: maxg@mellanox.com (Max Gurtovoy)
Date: Wed, 16 May 2018 14:48:12 +0300
Subject: [PATCH] nvme-rdma: clear NVME_RDMA_Q_LIVE before free the queue
In-Reply-To: <8bba6171-cfe8-3442-7b03-693e34dc096d@oracle.com>
References: <1525420958-9537-1-git-send-email-jianchao.w.wang@oracle.com>
 <7096b02a-956a-6765-7839-227c154d8336@grimberg.me>
 <8bba6171-cfe8-3442-7b03-693e34dc096d@oracle.com>
Message-ID: <37b59af3-61ae-626e-0fd6-4012a9c7c31f@mellanox.com>

Hi Jianchao,

On 5/16/2018 12:49 PM, jianchao.wang wrote:
> Hi Sagi
> 
> On 05/09/2018 11:06 PM, Sagi Grimberg wrote:
>> The correct fix would be to add a tag for stop_queue and call
>> nvme_rdma_stop_queue() in all the failure cases after
>> nvme_rdma_start_queue.
> 
> Would you please look at the V2 in following link ?
> http://lists.infradead.org/pipermail/linux-nvme/2018-May/017330.html

I missed this email for some reason but this patch looks good for me.
Can you bump it in the mailing list and I'll add my signature for review 
there ?

-Max.

> 
> Thanks in advance
> Jianchao
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
> 

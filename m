From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 8 Feb 2017 20:18:20 +0200
Subject: [PATCH] nvmet: Avoid writing fabric_ops, queue pointers on every
 request.
In-Reply-To: <VI1PR0502MB3008C2598C5492B2EB4D1E55D1420@VI1PR0502MB3008.eurprd05.prod.outlook.com>
References: <1486507066-23168-1-git-send-email-parav@mellanox.com>
 <5bcb5982-36a6-67f5-8416-45e321235fa9@grimberg.me>
 <VI1PR0502MB3008C2598C5492B2EB4D1E55D1420@VI1PR0502MB3008.eurprd05.prod.outlook.com>
Message-ID: <700fde5d-3b84-2279-4176-c871364d4b97@grimberg.me>


>>> Additionally this patch further avoid nvme cq and sq pointer
>>> initialization for every request during every request processing for
>>> rdma because nvme queue linking occurs during queue allocation time
>>> for AQ and IOQ.
>>
>> This breaks SRQ mode where every nvmet_rdma_cmd serves different
>> queues in it's lifetime..
>
> I fail to understand that.
> nvmet_rdma_create_queue_ib() is call for as many QPs as we create; not based on number of SRQs we create.

Correct.

> nvmet_rdma_queue stores cq and sq.

Correct.

> So there are as many cq and sq on the fabric side as QPs for fabric_connect command is called.
> queue is pulled out of cq context on which we received the command.
> SRQ is just a place shared among this nvme queues to share the RQ buffer, right?

Correct too, but we then assign the queue to the command, which is the
context of the received SQE (maybe with in-capsule data). For the SRQ
case we allocate the commands and pre-post them (before we have any
queues), they are absolutely not bound to a given queue, they can't
actually.

So for each new recv completion, the command context is now bound to
the queue that it completed on, so it can be bound to different queues
in its life-time.

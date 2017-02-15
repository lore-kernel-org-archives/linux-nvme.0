From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 15 Feb 2017 10:58:32 +0200
Subject: [PATCH] nvmet: Avoid writing fabric_ops, queue pointers on every
 request.
In-Reply-To: <VI1PR0502MB3008753C22DDAD6B5C20FC57D1590@VI1PR0502MB3008.eurprd05.prod.outlook.com>
References: <1486507066-23168-1-git-send-email-parav@mellanox.com>
 <5bcb5982-36a6-67f5-8416-45e321235fa9@grimberg.me>
 <VI1PR0502MB3008C2598C5492B2EB4D1E55D1420@VI1PR0502MB3008.eurprd05.prod.outlook.com>
 <700fde5d-3b84-2279-4176-c871364d4b97@grimberg.me>
 <VI1PR0502MB3008753C22DDAD6B5C20FC57D1590@VI1PR0502MB3008.eurprd05.prod.outlook.com>
Message-ID: <fbe16be7-ed21-d231-471e-cdffe346264b@grimberg.me>


> Hi Sagi,

Hi Parav,

>> Sorry, I am still not getting it.
>> nvmet_rdma_rsp structure contains nvmet_req.
>> nvmet_rdma_rsp (and so nvmet_req) are per QP allocations.
>> cq and sq pointers are initialized inside nvmet_req.
>>
>> nvmet_rdma_cmd is per RQ/SRQ allocation.
>> When we do recv_done(), we bind rsp structure to cmd (cmd can be from RQ
>> or SRQ).
>> So I believe this is still good.
>> If we have cq and sq pointer inside the nvmet_rdma_cmd than I can
>> understand that it can break.
>>
>> On a side note: I tested the patch with use_srq flag (but didn't publish its
>> performance numbers as they awaiting your per core SRQ fixes to match
>> regular RQ numbers :-) ).

Yep, forgot that the sq/cq are referenced from the rsp which is
per-queue.

Christoph, James, can I get an ack from you guys?

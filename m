From: maxg@mellanox.com (Max Gurtovoy)
Date: Fri, 5 Jul 2019 15:17:56 +0300
Subject: [PATCH v2 1/2] nvmet: Fix use-after-free bug when a port is
 removed
In-Reply-To: <d79a4c2d-9326-2805-b2a2-ca265ab2a717@deltatee.com>
References: <20190703230304.22905-1-logang@deltatee.com>
 <20190703230304.22905-2-logang@deltatee.com>
 <786259e6-ffed-8db3-74d0-71ed5a760079@mellanox.com>
 <d79a4c2d-9326-2805-b2a2-ca265ab2a717@deltatee.com>
Message-ID: <731bd412-2e44-c027-726e-d73a42c5f773@mellanox.com>


On 7/5/2019 12:01 AM, Logan Gunthorpe wrote:
>
> On 2019-07-04 3:00 p.m., Max Gurtovoy wrote:
>> Hi Logan,
>>
>> On 7/4/2019 2:03 AM, Logan Gunthorpe wrote:
>>> When a port is removed through configfs, any connected controllers
>>> are still active and can still send commands. This causes a
>>> use-after-free bug which is detected by KASAN for any admin command
>>> that dereferences req->port (like in nvmet_execute_identify_ctrl).
>>>
>>> To fix this, disconnect all active controllers when a subsystem is
>>> removed from a port. This ensures there are no active controllers
>>> when the port is eventually removed.
>> so now we are enforcing controller existence with port configfs, right ?
>> sounds reasonable.
> Correct.
>
>> Did you run your patches with other transport (RDMA/TCP/FC) ?
> Just RDMA and loop. I suppose I could test with TCP but I don't have FC
> hardware.

Great.

the code looks good:

Reviewed-by: Max Gurtovoy <maxg at mellanox.com>

>
> Logan

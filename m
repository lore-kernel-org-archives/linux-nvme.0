From: maxg@mellanox.com (Max Gurtovoy)
Date: Fri, 5 Jul 2019 00:00:26 +0300
Subject: [PATCH v2 1/2] nvmet: Fix use-after-free bug when a port is
 removed
In-Reply-To: <20190703230304.22905-2-logang@deltatee.com>
References: <20190703230304.22905-1-logang@deltatee.com>
 <20190703230304.22905-2-logang@deltatee.com>
Message-ID: <786259e6-ffed-8db3-74d0-71ed5a760079@mellanox.com>

Hi Logan,

On 7/4/2019 2:03 AM, Logan Gunthorpe wrote:
> When a port is removed through configfs, any connected controllers
> are still active and can still send commands. This causes a
> use-after-free bug which is detected by KASAN for any admin command
> that dereferences req->port (like in nvmet_execute_identify_ctrl).
>
> To fix this, disconnect all active controllers when a subsystem is
> removed from a port. This ensures there are no active controllers
> when the port is eventually removed.

so now we are enforcing controller existence with port configfs, right ? 
sounds reasonable.

Did you run your patches with other transport (RDMA/TCP/FC) ?

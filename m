From: maxg@mellanox.com (Max Gurtovoy)
Date: Tue, 26 Dec 2017 10:32:56 +0200
Subject: [PATCH v2] nvme-fabrics: Protect against module unload during
 create_ctrl
In-Reply-To: <20171225121830.30275-1-sagi@grimberg.me>
References: <20171225121830.30275-1-sagi@grimberg.me>
Message-ID: <75242846-29f5-c11c-276c-0574bb1a9b85@mellanox.com>



On 12/25/2017 2:18 PM, Sagi Grimberg wrote:
> From: Roy Shterman <roys at lightbitslabs.com>
> 
> nvme transport driver module unload may (and usually does) trigger iteration
> over the active controllers and delete them all (sometimes under a mutex).
> However, a controller can be created concurrently with module unload
> which can lead to leakage of resources (most important char device node
> leakage) in case the controller creation occured after the unload delete and drain
> sequence. To protect against this, we take a module reference to guarantee that
> the nvme transport driver is not unloaded while creating a controller.
> 
> Signed-off-by: roy shterman <roys at lightbitslabs.com>
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> ---
> Changes from v1:
> - restored missing module ref put is success flow
> 
>   drivers/nvme/host/fabrics.c | 17 +++++++++++++----
>   drivers/nvme/host/fabrics.h |  2 ++
>   drivers/nvme/host/fc.c      |  1 +
>   drivers/nvme/host/rdma.c    |  1 +
>   drivers/nvme/target/loop.c  |  1 +
>   5 files changed, 18 insertions(+), 4 deletions(-)
> 

Looks good,

Reviewed-by: Max Gurtovoy <maxg at mellanox.com>

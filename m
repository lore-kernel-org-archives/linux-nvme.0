From: maxg@mellanox.com (Max Gurtovoy)
Date: Wed, 22 Nov 2017 17:37:57 +0200
Subject: [PATCH v4 1/4] nvme-rdma: don't suppress send completions
In-Reply-To: <20171120113101.8292-2-sagi@grimberg.me>
References: <20171120113101.8292-1-sagi@grimberg.me>
 <20171120113101.8292-2-sagi@grimberg.me>
Message-ID: <7ff1ea5a-111a-f914-afe2-3f341cbc8c58@mellanox.com>



On 11/20/2017 1:30 PM, Sagi Grimberg wrote:
> The entire completions suppress mechanism is currently
> broken because the HCA might retry a send operation
> (due to dropped ack) after the nvme transaction has completed.
> 
> In order to handle this, we signal all send completions (besides
> async event which is not racing anything).
> 
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> ---
>   drivers/nvme/host/rdma.c | 46 +++++++++-------------------------------------
>   1 file changed, 9 insertions(+), 37 deletions(-)
> 

Looks good,

Reviewed-by: Max Gurtovoy <maxg at mellanox.com>

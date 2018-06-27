From: james.smart@broadcom.com (James Smart)
Date: Wed, 27 Jun 2018 09:40:29 -0700
Subject: [PATCH v5 1/2] nvme: cache struct nvme_ctrl reference to struct
 nvme_request
In-Reply-To: <20180627125324.22064-2-jthumshirn@suse.de>
References: <20180627125324.22064-1-jthumshirn@suse.de>
 <20180627125324.22064-2-jthumshirn@suse.de>
Message-ID: <7233e4f1-eee9-9849-be44-604aa11fffb3@broadcom.com>



On 6/27/2018 5:53 AM, Johannes Thumshirn wrote:
> From: Sagi Grimberg <sagi at grimberg.me>
>
> We will need to reference the controller in the setup and completion
> time for tracing and future traffic based keep alive support.
>
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
>
> ---
> Changes to v4:
> - Move caching from nvme_setup_cmd to .init_request (Keith)
> ---
>   drivers/nvme/host/core.c   | 1 +
>   drivers/nvme/host/fc.c     | 1 +
>   drivers/nvme/host/nvme.h   | 1 +
>   drivers/nvme/host/pci.c    | 2 ++
>   drivers/nvme/host/rdma.c   | 1 +
>   drivers/nvme/target/loop.c | 1 +
>   6 files changed, 7 insertions(+)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index e541fe268bcf..99dd62c1076c 100644
>

good for the fc side...

Reviewed-by:? James Smart? <james.smart at broadcom.com>

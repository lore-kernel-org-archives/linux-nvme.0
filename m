From: maxg@mellanox.com (Max Gurtovoy)
Date: Sun, 18 Nov 2018 00:38:29 +0200
Subject: [PATCH 06/11] nvmet: allow configfs tcp trtype configuration
In-Reply-To: <20181115171626.9306-7-sagi@lightbitslabs.com>
References: <20181115171626.9306-1-sagi@lightbitslabs.com>
 <20181115171626.9306-7-sagi@lightbitslabs.com>
Message-ID: <12c83c06-4839-734d-15bf-6225b38938b6@mellanox.com>


On 11/15/2018 7:16 PM, Sagi Grimberg wrote:
> Signed-off-by: Sagi Grimberg <sagi at lightbitslabs.com>
> ---
>   drivers/nvme/target/configfs.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
> index c2df205096ec..4d28c4d78850 100644
> --- a/drivers/nvme/target/configfs.c
> +++ b/drivers/nvme/target/configfs.c
> @@ -34,6 +34,7 @@ static const struct nvmet_transport_name {
>   } nvmet_transport_names[] = {
>   	{ NVMF_TRTYPE_RDMA,	"rdma" },
>   	{ NVMF_TRTYPE_FC,	"fc" },
> +	{ NVMF_TRTYPE_TCP,	"tcp" },
>   	{ NVMF_TRTYPE_LOOP,	"loop" },
>   };
>   

looks good,

Reviewed-by: Max Gurtovoy <maxg at mellanox.com>

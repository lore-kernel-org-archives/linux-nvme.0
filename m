From: keith.busch@intel.com (Keith Busch)
Date: Thu, 26 Jan 2017 12:08:21 -0500
Subject: [PATCH 1/2] nvme: add semicolon in nvme_command setting
In-Reply-To: <1485443848-29478-1-git-send-email-maxg@mellanox.com>
References: <1485443848-29478-1-git-send-email-maxg@mellanox.com>
Message-ID: <20170126170821.GA1048@localhost.localdomain>

On Thu, Jan 26, 2017@05:17:27PM +0200, Max Gurtovoy wrote:
> Reviewed-by: Parav Pandit <parav at mellanox.com>
> Signed-off-by: Max Gurtovoy <maxg at mellanox.com>

Reviewed-by: Keith Busch <keith.busch at intel.com>

> ---
>  drivers/nvme/host/core.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 8a3c3e3..4300f88 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -568,8 +568,8 @@ int nvme_identify_ns(struct nvme_ctrl *dev, unsigned nsid,
>  	int error;
>  
>  	/* gcc-4.4.4 (at least) has issues with initializers and anon unions */
> -	c.identify.opcode = nvme_admin_identify,
> -	c.identify.nsid = cpu_to_le32(nsid),
> +	c.identify.opcode = nvme_admin_identify;
> +	c.identify.nsid = cpu_to_le32(nsid);
>  
>  	*id = kmalloc(sizeof(struct nvme_id_ns), GFP_KERNEL);
>  	if (!*id)
> -- 
> 1.7.1
> 

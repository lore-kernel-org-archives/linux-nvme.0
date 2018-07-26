From: hch@lst.de (Christoph Hellwig)
Date: Thu, 26 Jul 2018 11:19:33 +0200
Subject: [PATCH] nvmet: use Retain Async Event bit to clear AEN
In-Reply-To: <20180726030520.2603-1-chaitanya.kulkarni@wdc.com>
References: <20180726030520.2603-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20180726091933.GA24335@lst.de>

On Wed, Jul 25, 2018@08:05:20PM -0700, Chaitanya Kulkarni wrote:
> In the current implementation, we clear the AEN bit when we get the
> "get log page" command if given log page is associated with AEN.
> This patch allows optionally retaining the AEN for the ctrl
> under consideration when Retain Asynchronous Event (RAE) bit is set
> as a part of "get log page" command.
> 
> This allows the host to read the Log page and optionally retaining the
> AEN associated with this log page when using userspace tools like
> nvme-cli.
> 
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
> ---
>  drivers/nvme/target/admin-cmd.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
> index 16a9b24270f9..de60dd6bd78c 100644
> --- a/drivers/nvme/target/admin-cmd.c
> +++ b/drivers/nvme/target/admin-cmd.c
> @@ -19,6 +19,19 @@
>  #include <asm/unaligned.h>
>  #include "nvmet.h"
>  
> +/*
> + * This helper allows us to clear the AEN based on the RAE bit,
> + * Please use this helper when processing the log pages which are
> + * associated with the AEN.
> + */
> +static inline void nvmet_clear_aen(struct nvmet_req *req)
> +{
> +	int rae = le32_to_cpu(req->cmd->common.cdw10[0]) & 1 << 15;
> +
> +	if (!rae)
> +		clear_bit(NVME_AEN_CFG_NS_ATTR, &req->sq->ctrl->aen_masked);
> +}

I think this will need the bit for the aen passed in so that we can
reuse it for other log pages (e.g. the upcoming ANA one).

Otherwise it looks fine to me.

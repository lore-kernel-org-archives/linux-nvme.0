From: hch@infradead.org (Christoph Hellwig)
Date: Sun, 28 Apr 2019 05:09:55 -0700
Subject: [PATCH 2/2] nvme-multipath: improve logging
In-Reply-To: <20190425024041.17657-3-chaitanya.kulkarni@wdc.com>
References: <20190425024041.17657-1-chaitanya.kulkarni@wdc.com>
 <20190425024041.17657-3-chaitanya.kulkarni@wdc.com>
Message-ID: <20190428120955.GC9759@infradead.org>

On Wed, Apr 24, 2019@07:40:41PM -0700, Chaitanya Kulkarni wrote:
> This patch improves the logging for nvme-multipath code.
> 
> Signed-off-by: Hannes Reinecke <hare at suse.com>
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
> ---
>  drivers/nvme/host/multipath.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index f0716f6ce41f..721aa2ea4363 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -81,6 +81,9 @@ void nvme_failover_req(struct request *req)
>  		 * Reset the controller for any non-ANA error as we don't know
>  		 * what caused the error.
>  		 */
> +		dev_info(ns->ctrl->device,
> +			"nvme status 0x%04x, resetting controller\n",
> +			status);

Do we need something ind?cating this is the multipath driver failing
over?

> -	dev_info(ctrl->device, "ANA group %d: %s.\n",
> +	if (desc->state < ARRAY_SIZE(nvme_ana_state_names))
> +		dev_dbg(ctrl->device, "ANA group %d: %s.\n",
>  			le32_to_cpu(desc->grpid),
>  			nvme_ana_state_names[desc->state]);
> +	else
> +		dev_dbg(ctrl->device, "ANA group %d: unknown.\n",
> +			le32_to_cpu(desc->grpid));

I don't think we need the unknown case here as nvme_parse_ana_log
rejects invalid states already.

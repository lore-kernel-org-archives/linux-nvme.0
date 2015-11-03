From: keith.busch@intel.com (Busch, Keith)
Date: Tue, 3 Nov 2015 22:45:48 +0000
Subject: [patch] nvme: lightnvm: clean up a data type
In-Reply-To: <20151103223731.GE19280@mwanda>
References: <20151103223731.GE19280@mwanda>
Message-ID: <B58D82457FDA0744A320A2FC5AC253B93CD3C236@fmsmsx104.amr.corp.intel.com>

Looks right to me. Adding Matias for the last word.

On Tue, Nov 3, 2015, Dan Carpentar wrote:
> "nlb_pr_rq" can't be more than u32 because "len" is a u32.  Later we
> truncate it to u32 anyway when we calculate min_t().
> 
> Signed-off-by: Dan Carpenter <dan.carpenter at oracle.com>
> 
> diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
> index 133c839..e0b7b95 100644
> --- a/drivers/nvme/host/lightnvm.c
> +++ b/drivers/nvme/host/lightnvm.c
> @@ -282,7 +282,7 @@ static int nvme_nvm_get_l2p_tbl(struct request_queue *q, u64 slba, u32 nlb,
>  	struct nvme_dev *dev = ns->dev;
>  	struct nvme_nvm_command c = {};
>  	u32 len = queue_max_hw_sectors(q) << 9;
> -	u64 nlb_pr_rq = len / sizeof(u64);
> +	u32 nlb_pr_rq = len / sizeof(u64);
>  	u64 cmd_slba = slba;
>  	void *entries;
>  	int ret = 0;
> @@ -294,7 +294,7 @@ static int nvme_nvm_get_l2p_tbl(struct request_queue *q, u64 slba, u32 nlb,
>  		return -ENOMEM;
> 
>  	while (nlb) {
> -		u32 cmd_nlb = min_t(u32, nlb_pr_rq, nlb);
> +		u32 cmd_nlb = min(nlb_pr_rq, nlb);
> 
>  		c.l2p.slba = cpu_to_le64(cmd_slba);
>  		c.l2p.nlb = cpu_to_le32(cmd_nlb);

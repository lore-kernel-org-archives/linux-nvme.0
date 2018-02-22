From: mb@lightnvm.io (=?UTF-8?Q?Matias_Bj=c3=b8rling?=)
Date: Thu, 22 Feb 2018 08:45:31 +0100
Subject: [PATCH 08/20] lightnvm: complete geo structure with maxoc*
In-Reply-To: <1519205218-26994-9-git-send-email-javier@cnexlabs.com>
References: <1519205218-26994-1-git-send-email-javier@cnexlabs.com>
 <1519205218-26994-9-git-send-email-javier@cnexlabs.com>
Message-ID: <5e2948ed-19a8-7bd5-6c50-df37a1454d16@lightnvm.io>

On 02/21/2018 10:26 AM, Javier Gonz?lez wrote:
> Complete the generic geometry structure with the maxoc and maxocpu
> felds, present in the 2.0 spec.
> 
> Signed-off-by: Javier Gonz?lez <javier at cnexlabs.com>
> ---
>   drivers/nvme/host/lightnvm.c | 4 ++++
>   include/linux/lightnvm.h     | 2 ++
>   2 files changed, 6 insertions(+)
> 
> diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
> index cca32da05316..9c1f8225c4e1 100644
> --- a/drivers/nvme/host/lightnvm.c
> +++ b/drivers/nvme/host/lightnvm.c
> @@ -318,6 +318,8 @@ static int nvme_nvm_setup_12(struct nvme_nvm_id12 *id,
>   	dev_geo->c.ws_min = sec_per_pg;
>   	dev_geo->c.ws_opt = sec_per_pg;
>   	dev_geo->c.mw_cunits = 8;		/* default to MLC safe values */
> +	dev_geo->c.maxoc = dev_geo->all_luns;	/* default to 1 chunk per LUN */
> +	dev_geo->c.maxocpu = 1;			/* default to 1 chunk per LUN */

One can't assume that it is 1 open chunk per lun. If you need this for 
specific hardware, make a quirk for it.

>   
>   	dev_geo->c.mccap = le32_to_cpu(src->mccap);
>   
> @@ -405,6 +407,8 @@ static int nvme_nvm_setup_20(struct nvme_nvm_id20 *id,
>   	dev_geo->c.ws_min = le32_to_cpu(id->ws_min);
>   	dev_geo->c.ws_opt = le32_to_cpu(id->ws_opt);
>   	dev_geo->c.mw_cunits = le32_to_cpu(id->mw_cunits);
> +	dev_geo->c.maxoc = le32_to_cpu(id->maxoc);
> +	dev_geo->c.maxocpu = le32_to_cpu(id->maxocpu);
>   
>   	dev_geo->c.mccap = le32_to_cpu(id->mccap);
>   
> diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
> index ccc5faa63cb7..e1c4292ea33d 100644
> --- a/include/linux/lightnvm.h
> +++ b/include/linux/lightnvm.h
> @@ -215,6 +215,8 @@ struct nvm_common_geo {
>   	u32	ws_min;		/* minimum write size */
>   	u32	ws_opt;		/* optimal write size */
>   	u32	mw_cunits;	/* distance required for successful read */
> +	u32	maxoc;		/* maximum open chunks */
> +	u32	maxocpu;	/* maximum open chunks per parallel unit */
>   
>   	/* device capabilities */
>   	u32	mccap;
> 

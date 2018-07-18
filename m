From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 18 Jul 2018 15:25:18 +0300
Subject: [PATCH rfc 2/2] nvmet: add nvmet ctrl logging helpers
In-Reply-To: <BYAPR04MB4502D84E243118923DD7493F865D0@BYAPR04MB4502.namprd04.prod.outlook.com>
References: <20180716105343.29699-1-sagi@grimberg.me>
 <20180716105343.29699-3-sagi@grimberg.me>
 <BYAPR04MB4502D84E243118923DD7493F865D0@BYAPR04MB4502.namprd04.prod.outlook.com>
Message-ID: <d804c6d8-ba28-a3ea-8c1f-242b9aa5b18f@grimberg.me>


> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
> index 6811258ab8ff..73751ded2174 100644
> --- a/drivers/nvme/target/nvmet.h
> +++ b/drivers/nvme/target/nvmet.h
> @@ -280,6 +280,13 @@ struct nvmet_req {
>  ???????? printk(KERN_WARNING "nvmet port%d: " fmt, \
>  ???????????????? le32_to_cpu((port)->disc_addr.portid), ##a)
>   
> +#define ctrl_err(ctrl, fmt, a...)????????????? \
> +?????? printk(KERN_ERR "nvmet ctrl%d: " fmt, (ctrl)->cntlid, ##a)
> +#define ctrl_info(ctrl, fmt, a...)???????????? \
> +?????? printk(KERN_INFO "nvmet ctrl%d: " fmt, (ctrl)->cntlid, ##a)
> +#define ctrl_warn(ctrl, fmt, a...)???????????? \
> +?????? printk(KERN_WARNING "nvmet ctrl%d: " fmt, (ctrl)->cntlid, ##a)
> +
> 
> [CK] Can we use pr_XXX for above helpers instead of printk()?

This would add pr_fmt() to the print which would look like:
"nvme-loop: nvmet ctrl1: XXX". Wanted to clean it up like
dev_XXX logging.

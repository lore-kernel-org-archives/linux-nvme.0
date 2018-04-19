From: james.smart@broadcom.com (James Smart)
Date: Thu, 19 Apr 2018 14:20:43 -0700
Subject: [PATCH] nvme: fc: provide a descriptive error
In-Reply-To: <20180419174342.27307-1-jthumshirn@suse.de>
References: <20180419174342.27307-1-jthumshirn@suse.de>
Message-ID: <6341b630-ce66-90b5-bd80-cc2dcd2cfb71@broadcom.com>

On 4/19/2018 10:43 AM, Johannes Thumshirn wrote:
> Provide a descriptive error in case an lport to rport association
> isn't found when creating the FC-NVME controller.
>
> Currently it's very hard to debug the reason for a failed connect
> attempt without a look at the source.
>
> Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>
>
> ---
> This actually happened to Hannes and me becuase of a typo in a
> customer demo today, so yes things like this happen unitl we have a
> proper way to do auto-connect.
> ---
>   drivers/nvme/host/fc.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index 6cb26bcf6ec0..8b66879b4ebf 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -3284,6 +3284,8 @@ nvme_fc_create_ctrl(struct device *dev, struct nvmf_ctrl_options *opts)
>   	}
>   	spin_unlock_irqrestore(&nvme_fc_lock, flags);
>   
> +	pr_warn("%s: %s - %s combination not found\n",
> +		__func__, opts->traddr, opts->host_traddr);
>   	return ERR_PTR(-ENOENT);
>   }
>   

Signed-off-by:? James Smart? <james.smart at broadcom.com>

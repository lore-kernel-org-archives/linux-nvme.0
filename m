From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 28 Aug 2017 19:41:44 +0300
Subject: [PATCH] nvme-fabrics: Allow 0 as KATO value
In-Reply-To: <20170828141032.800-1-gpiccoli@linux.vnet.ibm.com>
References: <20170828141032.800-1-gpiccoli@linux.vnet.ibm.com>
Message-ID: <29c5954d-eda6-4a6f-1e50-95399c32a917@grimberg.me>


> Currently, driver code allows user to set 0 as KATO
> (Keep Alive TimeOut), but it's not being respected.
> This patch enforces the expected behavior.

It was originally possible to set it to zero, but I guess
somewhere down the road the restriction was added.

> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
> index 2e582a240943..d734ae852e1a 100644
> --- a/drivers/nvme/host/fabrics.c
> +++ b/drivers/nvme/host/fabrics.c
> @@ -556,6 +556,7 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
>   {
>   	substring_t args[MAX_OPT_ARGS];
>   	char *options, *o, *p;
> +	bool set_kato = true;
>   	int token, ret = 0;
>   	size_t nqnlen  = 0;
>   	int ctrl_loss_tmo = NVMF_DEF_CTRL_LOSS_TMO;
> @@ -668,6 +669,7 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
>   			} else if (token == 0) {
>   				/* Allowed for debug */
>   				pr_warn("keep_alive_tmo 0 won't execute keep alives!!!\n");
> +				set_kato = false;
>   			}
>   			opts->kato = token;
>   			break;
> @@ -761,7 +763,7 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
>   	uuid_copy(&opts->host->id, &hostid);
>   
>   out:
> -	if (!opts->discovery_nqn && !opts->kato)
> +	if (set_kato && !opts->discovery_nqn && !opts->kato)
>   		opts->kato = NVME_DEFAULT_KATO;
>   	kfree(options);
>   	return ret;
> 

How about simply setting opts->kato = NVME_DEFAULT_KATO as a default
at the beginning and remove this condition instead..

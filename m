From: hch@lst.de (Christoph Hellwig)
Date: Tue, 17 Jul 2018 15:34:08 +0200
Subject: [RFC PATCH] nvmet: add support for ns write protect feature
In-Reply-To: <20180710035424.29088-1-chaitanya.kulkarni@wdc.com>
References: <20180710035424.29088-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20180717133408.GB15079@lst.de>


> +int nvmet_ns_is_wp(struct nvmet_ns *ns)
> +{
> +	switch (ns->wp_state) {
> +	case NVME_NS_NO_WRITE_PROTECT:
> +		return 0;
> +	case NVME_NS_WRITE_PROTECT:
> +		return 1;
> +	}
> +	WARN_ON("invalid ns write protect state");
> +	return -1;

I'd much rather have a

	'bool		readonly'

flag in nvmet_ns and then we don't need this helper.

> +bool nvmet_ns_wp_cmd_allow(struct nvmet_req *req)
> +{
> +	bool ret = false;
> +
> +	switch (req->cmd->common.opcode) {
> +	case nvme_cmd_dsm: /* allow DSM ? */

don't think so, at least for discards.

> +	case nvme_cmd_read:
> +	case nvme_cmd_flush:
> +		/* fall thru */
> +		ret = true;
> +		goto out;
> +	}

I think we need separate helpers here for the I/O vs admin queues
as the opcodes can theoretically overlap.  

Also instead of the goto you can just return directly here.

>  {
>  	u32 len = le16_to_cpu(cmd->get_log_page.numdu);
> @@ -140,7 +198,7 @@ static void nvmet_execute_get_log_cmd_effects_ns(struct nvmet_req *req)
>  	log->acs[nvme_admin_get_log_page]	= cpu_to_le32(1 << 0);
>  	log->acs[nvme_admin_identify]		= cpu_to_le32(1 << 0);
>  	log->acs[nvme_admin_abort_cmd]		= cpu_to_le32(1 << 0);
> -	log->acs[nvme_admin_set_features]	= cpu_to_le32(1 << 0);
> +	log->acs[nvme_admin_set_features]	= cpu_to_le32(1 << 16 | 1 << 0);

This looks unrelated?

> @@ -342,6 +402,8 @@ static void nvmet_execute_identify_ns(struct nvmet_req *req)
>  
>  	id->lbaf[0].ds = ns->blksize_shift;
>  
> +	id->nsattr = nvmet_ns_is_wp(ns);

Please do something like:

	if (ns->readonly)
		id->nsattr |= (1 << 0);

to make the code a little more obvious.

> +	if (nvmet_ns_is_wp(req->ns) && !nvmet_ns_wp_cmd_allow(req))
> +		return NVME_SC_NS_WRITE_PROTECTED;

I think this wants an unlikely annotation.

Btw, a patch for the host to look at nsattr and set the linux gendisk
readonly would also be very helpful!

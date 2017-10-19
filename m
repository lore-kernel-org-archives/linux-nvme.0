From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 19 Oct 2017 08:23:17 -0700
Subject: [PATCH 2/3] nvme_fc: add support for duplicate_connect option
In-Reply-To: <20171011003512.5946-3-jsmart2021@gmail.com>
References: <20171011003512.5946-1-jsmart2021@gmail.com>
 <20171011003512.5946-3-jsmart2021@gmail.com>
Message-ID: <20171019152317.GB4239@infradead.org>

> +static inline bool
> +__nvme_fc_options_match(struct nvmf_ctrl_options *opts,
> +			struct nvme_fc_ctrl *ctrl)
> +{
> +	if (strcmp(opts->subsysnqn, ctrl->ctrl.opts->subsysnqn) ||
> +	    strcmp(opts->host->nqn, ctrl->ctrl.opts->host->nqn) ||
> +	    memcmp(&opts->host->id, &ctrl->ctrl.opts->host->id,
> +				sizeof(uuid_t)))
> +		return false;

This just checks generic options and isn't FC specific.  As a properly
named helper it might make sense in common code.

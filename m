From: hch@lst.de (Christoph Hellwig)
Date: Mon, 2 Jul 2018 15:15:30 +0200
Subject: [PATCH] nvme: don't enable AEN if not supported
In-Reply-To: <20180701130815.GA36597@bogon.didichuxing.com>
References: <20180701130815.GA36597@bogon.didichuxing.com>
Message-ID: <20180702131530.GE4624@lst.de>

> +	if (!(ctrl->oaes & NVME_AEN_SUPPORTED))
> +		return;
> +
>  	status = nvme_set_features(ctrl, NVME_FEAT_ASYNC_EVENT,
>  			ctrl->oaes & NVME_AEN_SUPPORTED, NULL, 0, &result);

Can you introduce do something like:

	u32 supported_aens = ctrl->oaes & NVME_AEN_SUPPORTED;

	if (!supported_aens)
		return;

	status = nvme_set_features(ctrl, NVME_FEAT_ASYNC_EVENT, supported_aens,
	...

to make the code more obvious?  Otherwise looks fine:

Reviewed-by: Christoph Hellwig <hch at lst.de>

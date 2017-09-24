From: hch@infradead.org (Christoph Hellwig)
Date: Sun, 24 Sep 2017 05:55:08 -0700
Subject: [PATCH rfc] nvme-fabrics: request transport module
In-Reply-To: <1506257125-15257-1-git-send-email-sagi@grimberg.me>
References: <1506257125-15257-1-git-send-email-sagi@grimberg.me>
Message-ID: <20170924125507.GA11632@infradead.org>

> +
> +	if (!strcmp(opts->transport, "rdma"))
> +		mod_name = "nvme-rdma";
> +	else if (!strcmp(opts->transport, "fc"))
> +		mod_name = "nvme-fc";
> +	else if (!strcmp(opts->transport, "loop"))
> +		mod_name = "nvme-loop";
> +	else
> +		return -EINVAL;
> +
> +	ret = request_module(mod_name) < 0;

You can replace this whole function with:

	request_module("nvme-%d", opts->transport);

Also if I remember correctly request_module returns an error if the
driver is built-in, thus most callers either don't check the return
value or just print a warning (I personally hate the warning, so I think
we should just do the simple request_module call).

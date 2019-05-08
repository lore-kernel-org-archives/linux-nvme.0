From: hch@lst.de (Christoph Hellwig)
Date: Wed, 8 May 2019 09:25:31 +0200
Subject: [PATCH V2 2/2] nvme-trace: Add support to trace fabrics command
In-Reply-To: <20190506194644.11109-3-minwoo.im.dev@gmail.com>
References: <20190506194644.11109-1-minwoo.im.dev@gmail.com>
 <20190506194644.11109-3-minwoo.im.dev@gmail.com>
Message-ID: <20190508072531.GD21823@lst.de>

> +	if (likely(!nvme_is_fabrics(cmd)))
> +		trace_nvme_setup_cmd(req, cmd);
> +	else
> +		trace_nvme_setup_fabrics_cmd(req, cmd);
> +

I wonder if we really need this.  My idea would have been to just
branch out to the fabrics command parser from parse_nvme_cmd().  Or did
I miss something why that might not work?

The benefit is that we don't have an additional branch in the
non-tracing fast path (and also make it look a little nicer).

> +#define show_fabric_type_name(type)					\
> +	show_nvm_fabrics_type_name(type)

Why do we need this #define to the same name/signature?

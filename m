From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 19 Oct 2017 08:20:24 -0700
Subject: [PATCH 1/3] nvme: add duplicate_connect option
In-Reply-To: <20171011003512.5946-2-jsmart2021@gmail.com>
References: <20171011003512.5946-1-jsmart2021@gmail.com>
 <20171011003512.5946-2-jsmart2021@gmail.com>
Message-ID: <20171019152024.GA4239@infradead.org>

> +	{ NVMF_OPT_DUP_CONNECT,		"duplicate_connect=%d"	},

This is a boolean parameter, so please drop the "=%d here".

> +		case NVMF_OPT_DUP_CONNECT:
> +			if (match_int(args, &token)) {
> +				ret = -EINVAL;
> +				goto out;
> +			}
> +			if (token == 0)
> +				opts->duplicate_connect = false;
> +			else if (token == 1)
> +				opts->duplicate_connect = true;
> +			else {
> +				pr_err("Invalid duplicate_connect %d\n", token);
> +				ret = -EINVAL;
> +				goto out;
> +			}
> +			break;

And replace all this code by:

	case NVMF_OPT_DUP_CONNECT:
		opts->duplicate_connect = true;
		break;

That being said I'd be tempted to keep the existing behavior as
the default, and make noduplicates the option.

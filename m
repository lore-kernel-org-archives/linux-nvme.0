From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 13 Aug 2019 09:40:04 -0700
Subject: [PATCH 1/5] nvme-fabrics: Add type of service (TOS) configuration
In-Reply-To: <1565702251-17198-3-git-send-email-israelr@mellanox.com>
References: <1565702251-17198-1-git-send-email-israelr@mellanox.com>
 <1565702251-17198-3-git-send-email-israelr@mellanox.com>
Message-ID: <7054c205-5490-9329-8dc9-8c0bbb78e4d7@grimberg.me>


> TOS is user-defined and needs to be configured via nvme-cli.
> It must be set before initiating any traffic and once set the TOS
> cannot be changed.
> 
> Signed-off-by: Israel Rukshin <israelr at mellanox.com>
> Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
> ---
>   drivers/nvme/host/fabrics.c | 16 +++++++++++++++-
>   drivers/nvme/host/fabrics.h |  3 +++
>   2 files changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
> index 1994d5b..9e9ee07 100644
> --- a/drivers/nvme/host/fabrics.c
> +++ b/drivers/nvme/host/fabrics.c
> @@ -611,6 +611,7 @@ bool __nvmf_check_ready(struct nvme_ctrl *ctrl, struct request *rq,
>   	{ NVMF_OPT_DATA_DIGEST,		"data_digest"		},
>   	{ NVMF_OPT_NR_WRITE_QUEUES,	"nr_write_queues=%d"	},
>   	{ NVMF_OPT_NR_POLL_QUEUES,	"nr_poll_queues=%d"	},
> +	{ NVMF_OPT_TOS,			"tos=%d"		},
>   	{ NVMF_OPT_ERR,			NULL			}
>   };
>   
> @@ -632,6 +633,7 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
>   	opts->duplicate_connect = false;
>   	opts->hdr_digest = false;
>   	opts->data_digest = false;
> +	opts->tos = -1; /* < 0 == use transport default */
>   
>   	options = o = kstrdup(buf, GFP_KERNEL);
>   	if (!options)
> @@ -856,6 +858,18 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
>   			}
>   			opts->nr_poll_queues = token;
>   			break;
> +		case NVMF_OPT_TOS:
> +			if (match_int(args, &token)) {
> +				ret = -EINVAL;
> +				goto out;
> +			}
> +			if (token < 0 || token > 255) {
> +				pr_err("Invalid type of service %d\n", token);
> +				ret = -EINVAL;
> +				goto out;
> +			}
> +			opts->tos = token;
> +			break;

If we treat it like a transport agnostic parameter, we should handle
these limits in the individual transports. Also I think we can simply
clamp down tos>255 (we can still fail negative tos here though).

James, Christoph, Keith,

What do you think, do we want to start individual transport parameters
support like James suggested?

From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 14 Aug 2019 10:06:41 -0700
Subject: [PATCH 1/5] nvme-fabrics: Add type of service (TOS) configuration
In-Reply-To: <1565777981-18755-3-git-send-email-israelr@mellanox.com>
References: <1565777981-18755-1-git-send-email-israelr@mellanox.com>
 <1565777981-18755-3-git-send-email-israelr@mellanox.com>
Message-ID: <6dc92c98-146e-206b-d3cb-127e5c7c3ac9@grimberg.me>



On 8/14/19 3:19 AM, Israel Rukshin wrote:
> TOS is user-defined and needs to be configured via nvme-cli.
> It must be set before initiating any traffic and once set the TOS
> cannot be changed.
> 
> Signed-off-by: Israel Rukshin <israelr at mellanox.com>
> Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
> ---
>   drivers/nvme/host/fabrics.c | 20 +++++++++++++++++++-
>   drivers/nvme/host/fabrics.h |  3 +++
>   2 files changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
> index 1994d5b..d343c22 100644
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
> @@ -856,6 +858,22 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
>   			}
>   			opts->nr_poll_queues = token;
>   			break;
> +		case NVMF_OPT_TOS:
> +			if (match_int(args, &token)) {
> +				ret = -EINVAL;
> +				goto out;
> +			}
> +			if (token < 0) {
> +				pr_err("Invalid type of service %d\n", token);
> +				ret = -EINVAL;
> +				goto out;
> +			}
> +			if (token > 255) {
> +				pr_warn("Clamping type of service to 255\n");
> +				token = 255;
> +			}

Again, if tos is an abstract opaque, this needs to happen in the
individual transports, not in the generic part.

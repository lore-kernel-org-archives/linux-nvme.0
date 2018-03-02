From: james.smart@broadcom.com (James Smart)
Date: Fri, 2 Mar 2018 10:02:22 -0800
Subject: [PATCH] nvme-fabrics: Ignore nr_io_queues option for discovery
 controllers
In-Reply-To: <20180302174501.31228-1-roland@kernel.org>
References: <20180302174501.31228-1-roland@kernel.org>
Message-ID: <fe33ec1c-1425-fd63-65bb-e583eb123b81@broadcom.com>

On 3/2/2018 9:45 AM, Roland Dreier wrote:
> @@ -650,6 +650,11 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
>   				ret = -EINVAL;
>   				goto out;
>   			}
> +			if (opts->discovery_nqn) {
> +				pr_warn("Ignoring nr_io_queues value for discovery controller\n");
> +				break;
> +			}
> +
>   			opts->nr_io_queues = min_t(unsigned int,
>   					num_online_cpus(), token);
>   			break;

a pr_warn is a bit verbose. even a pr_warn is. I'd prefer no message at 
all as it's normal for a discovery controller.

-- james

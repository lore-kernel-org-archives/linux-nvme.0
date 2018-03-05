From: james.smart@broadcom.com (James Smart)
Date: Mon, 5 Mar 2018 12:55:55 -0800
Subject: [PATCH v2] nvme-fabrics: Ignore nr_io_queues option for discovery
 controllers
In-Reply-To: <20180305195953.14428-1-roland@kernel.org>
References: <20180305195953.14428-1-roland@kernel.org>
Message-ID: <d6f0f56d-b860-5f00-f8ac-a8e8686e8d30@broadcom.com>

On 3/5/2018 11:59 AM, Roland Dreier wrote:
> From: Roland Dreier <roland at purestorage.com>
>
> This removes a dependency on the order options are passed when creating
> a fabrics controller.  With the old code, if "nr_io_queues" appears before
> an "nqn" option specifying the discovery controller, then nr_io_queues
> is overridden with zero.  If "nr_io_queues" appears after specifying the
> discovery controller, then the nr_io_queues option is used to set the
> number of queues, and the driver attempts to establish IO connections
> to the discovery controller (which doesn't work).
>
> It seems better to ignore (and warn about) the "nr_io_queues" option
> if userspace has already asked to connect to the discovery controller.
>
> Signed-off-by: Roland Dreier <roland at purestorage.com>
> ---
>   drivers/nvme/host/fabrics.c | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
> index 5dd4ceefed8f..6ec6b13fa582 100644
> --- a/drivers/nvme/host/fabrics.c
> +++ b/drivers/nvme/host/fabrics.c
> @@ -650,6 +650,11 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
>   				ret = -EINVAL;
>   				goto out;
>   			}
> +			if (opts->discovery_nqn) {
> +				pr_debug("Ignoring nr_io_queues value for discovery controller\n");
> +				break;
> +			}
> +
>   			opts->nr_io_queues = min_t(unsigned int,
>   					num_online_cpus(), token);
>   			break;

Reviewed-by: James Smart <james.smart at broadcom.com>

-- james

From: maxg@mellanox.com (Max Gurtovoy)
Date: Tue, 7 May 2019 12:35:32 +0300
Subject: [PATCH nvme-cli rfc 4/6] fabrics: add --quiet option
In-Reply-To: <20190223023257.21227-5-sagi@grimberg.me>
References: <20190223023257.21227-1-sagi@grimberg.me>
 <20190223023257.21227-5-sagi@grimberg.me>
Message-ID: <58b674a5-a40e-c0b1-2b89-2fdc89d8efa0@mellanox.com>


On 2/23/2019 4:32 AM, Sagi Grimberg wrote:
> Now we are going to have discovery log change events, so
> instead of trying to figure out which NVM subsystem ports
> are already connected, we let the driver do that and
> only suppress the failure messages.
>
> This option will be used by the discovery log change corresponding
> udev rule.
>
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> ---
>   fabrics.c | 14 +++++++++++---
>   1 file changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/fabrics.c b/fabrics.c
> index 702f928cd8ed..f08fe3f9a0be 100644
> --- a/fabrics.c
> +++ b/fabrics.c
> @@ -66,6 +66,7 @@ static struct config {
>   	int  hdr_digest;
>   	int  data_digest;
>   	bool persistent;
> +	bool quiet;
>   } cfg = { NULL };
>   
>   #define BUF_SIZE		4096
> @@ -216,9 +217,11 @@ static int add_ctrl(const char *argstr)
>   		goto out;
>   	}
>   
> -	if (write(fd, argstr, len) != len) {
> -		fprintf(stderr, "Failed to write to %s: %s\n",
> -			 PATH_NVME_FABRICS, strerror(errno));
> +	ret = write(fd, argstr, len);
> +	if (ret != len) {
> +		if (errno != EALREADY || !cfg.quiet)
> +			fprintf(stderr, "Failed to write to %s: %s\n",
> +				 PATH_NVME_FABRICS, strerror(errno));
>   		ret = -errno;
>   		goto out_close;
>   	}
> @@ -840,6 +843,10 @@ static int connect_ctrls(struct nvmf_disc_rsp_page_hdr *log, int numrec)
>   		/* already connected print message	*/
>   		if (instance == -EALREADY) {
>   			const char *traddr = log->entries[i].traddr;
> +
> +			if (cfg.quiet)
> +				continue;
> +

maybe if(!cfg.quiet) do a fprintf() instead of continue.

(and also example can be added to commit message :) )


>   			fprintf(stderr,
>   				"traddr=%.*s is already connected\n",
>   				space_strip_len(NVMF_TRADDR_SIZE, traddr),
> @@ -996,6 +1003,7 @@ int discover(const char *desc, int argc, char **argv, bool connect)
>   		{"nr-poll-queues",  'P', "LIST", CFG_INT, &cfg.nr_poll_queues,    required_argument, "number of poll queues to use (default 0)" },
>   		{"queue-size",      'Q', "LIST", CFG_INT, &cfg.queue_size,      required_argument, "number of io queue elements to use (default 128)" },
>   		{"persistent",  'p', "LIST", CFG_NONE, &cfg.persistent,  no_argument, "persistent discovery connection" },
> +		{"quiet",       'Q', "LIST", CFG_NONE, &cfg.quiet,  no_argument, "suppress already connected errors" },
>   		{NULL},
>   	};
>   

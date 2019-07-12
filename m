From: sagi@grimberg.me (Sagi Grimberg)
Date: Fri, 12 Jul 2019 10:35:57 -0700
Subject: [PATCH rfc v2 09/10] nvme-cli: add --quiet option
In-Reply-To: <20190712003140.16221-10-jsmart2021@gmail.com>
References: <20190712003140.16221-1-jsmart2021@gmail.com>
 <20190712003140.16221-10-jsmart2021@gmail.com>
Message-ID: <46dcab64-c4f9-74dc-b75c-4f4b8926051d@grimberg.me>


> From: Sagi Grimberg <sagi at grimberg.me>
> 
> Now we are going to have discovery log change events, so
> instead of trying to figure out which NVM subsystem ports
> are already connected, we let the driver do that and
> only suppress the failure messages.
> 
> Example:
>    nvme connect-all ... --quiet
> 
> This option will be used by the discovery log change corresponding
> udev rule.
> 
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> Reviewed-by: James Smart <jsmart2021 at gmail.com>
> Reviewed-by: Hannes Reinecke <hare at suse.com>
> Reviewed-by: Minwoo Im <minwoo.im.dev at gmail.com>
> ---
>   fabrics.c | 21 ++++++++++++++-------
>   1 file changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/fabrics.c b/fabrics.c
> index e101ead..13e2cf8 100644
> --- a/fabrics.c
> +++ b/fabrics.c
> @@ -67,6 +67,7 @@ static struct config {
>   	int  hdr_digest;
>   	int  data_digest;
>   	bool persistent;
> +	bool quiet;
>   } cfg = { NULL };
>   
>   #define BUF_SIZE		4096
> @@ -219,9 +220,11 @@ static int add_ctrl(const char *argstr)
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
> @@ -855,10 +858,13 @@ static int connect_ctrls(struct nvmf_disc_rsp_page_hdr *log, int numrec)
>   		/* already connected print message	*/
>   		if (instance == -EALREADY) {
>   			const char *traddr = log->entries[i].traddr;
> -			fprintf(stderr,
> -				"traddr=%.*s is already connected\n",
> -				space_strip_len(NVMF_TRADDR_SIZE, traddr),
> -				traddr);
> +
> +			if (!cfg.quiet)
> +				fprintf(stderr,
> +					"traddr=%.*s is already connected\n",
> +					space_strip_len(NVMF_TRADDR_SIZE,
> +							traddr),
> +					traddr);
>   			continue;
>   		}
>   
> @@ -1063,6 +1069,7 @@ int discover(const char *desc, int argc, char **argv, bool connect)
>   		{"nr-poll-queues",  'P', "LIST", CFG_INT, &cfg.nr_poll_queues,    required_argument, "number of poll queues to use (default 0)" },
>   		{"queue-size",      'Q', "LIST", CFG_INT, &cfg.queue_size,      required_argument, "number of io queue elements to use (default 128)" },
>   		{"persistent",  'p', "LIST", CFG_NONE, &cfg.persistent,  no_argument, "persistent discovery connection" },
> +		{"quiet",       'Q', "LIST", CFG_NONE, &cfg.quiet,  no_argument, "suppress already connected errors" },

Q is already a short-arg (queue-size). Lets have it 'S' (stand for 
Suppress). Also, when I tested it locally for some reason it did not
take:
--
Jul 12 17:30:00 nvmc systemd[1]: Started NVMf auto-connect scan upon 
nvme discovery controller Events.
Jul 12 17:30:00 nvmc sh[2767]: Failed to write to /dev/nvme-fabrics: 
Operation already in progress
Jul 12 17:30:00 nvmc sh[2767]: traddr=192.168.123.1 is already connected
Jul 12 17:30:00 nvmc kernel: nvme nvme2: creating 4 I/O queues.
Jul 12 17:30:00 nvmc kernel: nvme nvme2: mapped 4/0/0 default/read/poll 
queues.
Jul 12 17:30:00 nvmc kernel: nvme nvme2: new ctrl: NQN "testnqn2", addr 
192.168.123.1:8009
--

Adding print to add_ctrl:
Jul 12 17:30:00 nvmc sh[2767]: errno 114 quiet 0

When I pass it manually it works, but not from udev... Not sure what
is going on...

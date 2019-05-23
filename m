From: minwoo.im@samsung.com (Minwoo Im)
Date: Thu, 23 May 2019 13:14:00 +0900
Subject: [PATCH 1/9] nvme: update list-ns nsid option
In-Reply-To: <1558543193-24752-2-git-send-email-maxg@mellanox.com>
References: <1558543193-24752-2-git-send-email-maxg@mellanox.com>
 <1558543193-24752-1-git-send-email-maxg@mellanox.com>
 <CGME20190522164022epcas4p14ccd01e368a20456b4e2d0cf06644adb@epcms2p3>
Message-ID: <20190523041400epcms2p3e31eb5a97973c434607c55b0c31dd8c1@epcms2p3>

> Subject: [PATCH 1/9] nvme: update list-ns nsid option
> 
> This commit updates the optional nsid argument to define the wanted
> nsid for start, instead of starting from nsid + 1. E.g. in case we've
> wanted to get the list of namespaces starting from 1, before this
> commit, we used the "--namespace-id=0" option. Nsid 0 is not valid in
> NVMe spec, thus change it to start counting from the given nsid.
> 
> Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
> ---
>  nvme.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/nvme.c b/nvme.c
> index 9819fcb..de77956 100644
> --- a/nvme.c
> +++ b/nvme.c
> @@ -950,9 +950,9 @@ close_fd:
> 
>  static int list_ns(int argc, char **argv, struct command *cmd, struct plugin
> *plugin)
>  {
> -	const char *desc = "For the specified device, show the "\
> -		"namespace list in a NVMe subsystem, optionally starting
> with a given namespace";
> -	const char *namespace_id = "namespace number returned list
> should to start after";
> +	const char *desc = "For the specified controller handle, show the "\
> +		"namespace list in the associated NVMe subsystem,
> optionally starting with a given nsid.";
> +	const char *namespace_id = "first nsid returned list should start
> from";
>  	const char *all = "show all namespaces in the subsystem, whether
> attached or inactive";
>  	int err, i, fd;
>  	__u32 ns_list[1024];
> @@ -963,7 +963,7 @@ static int list_ns(int argc, char **argv, struct command
> *cmd, struct plugin *pl
>  	};
> 
>  	struct config cfg = {
> -		.namespace_id = 0,
> +		.namespace_id = 1,
>  	};
> 
>  	const struct argconfig_commandline_options
> command_line_options[] = {
> @@ -976,7 +976,8 @@ static int list_ns(int argc, char **argv, struct command
> *cmd, struct plugin *pl
>  	if (fd < 0)
>  		return fd;
> 

Can we have invalid --namespace-id check here?

if (!cfg.namespace_id)
	return -EINVAL;

Otherwise, It looks good to me.

Reviewed-by: Minwoo Im <minwoo.im at samsung.com>

> -	err = nvme_identify_ns_list(fd, cfg.namespace_id, !!cfg.all, ns_list);
> +	err = nvme_identify_ns_list(fd, cfg.namespace_id - 1, !!cfg.all,
> +				    ns_list);
>  	if (!err) {
>  		for (i = 0; i < 1024; i++)
>  			if (ns_list[i])
> --
> 1.8.3.1
> 
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme

From: kenneth.heitke@intel.com (Heitke, Kenneth)
Date: Thu, 23 May 2019 11:27:27 -0600
Subject: [PATCH 1/9] nvme: update list-ns nsid option
In-Reply-To: <1558602058-29434-2-git-send-email-maxg@mellanox.com>
References: <1558602058-29434-1-git-send-email-maxg@mellanox.com>
 <1558602058-29434-2-git-send-email-maxg@mellanox.com>
Message-ID: <587b0f6b-d1eb-08d3-1219-63b5144351d0@intel.com>



On 5/23/2019 3:00 AM, Max Gurtovoy wrote:
> This commit updates the optional nsid argument to define the wanted
> nsid for start, instead of starting from nsid + 1. E.g. in case we've
> wanted to get the list of namespaces starting from 1, before this
> commit, we used the "--namespace-id=0" option. Nsid 0 is not valid in
> NVMe spec, thus change it to start counting from the given nsid.
> 
> Reviewed-by: Minwoo Im <minwoo.im at samsung.com>
> Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
> ---
>   nvme.c | 14 +++++++++-----
>   1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/nvme.c b/nvme.c
> index 9819fcb..3c1bcb1 100644
> --- a/nvme.c
> +++ b/nvme.c
> @@ -950,9 +950,9 @@ close_fd:
>   
>   static int list_ns(int argc, char **argv, struct command *cmd, struct plugin *plugin)
>   {
> -	const char *desc = "For the specified device, show the "\
> -		"namespace list in a NVMe subsystem, optionally starting with a given namespace";
> -	const char *namespace_id = "namespace number returned list should to start after";
> +	const char *desc = "For the specified controller handle, show the "\
> +		"namespace list in the associated NVMe subsystem, optionally starting with a given nsid.";
> +	const char *namespace_id = "first nsid returned list should start from";
>   	const char *all = "show all namespaces in the subsystem, whether attached or inactive";
>   	int err, i, fd;
>   	__u32 ns_list[1024];
> @@ -963,7 +963,7 @@ static int list_ns(int argc, char **argv, struct command *cmd, struct plugin *pl
>   	};
>   
>   	struct config cfg = {
> -		.namespace_id = 0,
> +		.namespace_id = 1,
>   	};
>   
>   	const struct argconfig_commandline_options command_line_options[] = {
> @@ -976,7 +976,11 @@ static int list_ns(int argc, char **argv, struct command *cmd, struct plugin *pl
>   	if (fd < 0)
>   		return fd;
>   
> -	err = nvme_identify_ns_list(fd, cfg.namespace_id, !!cfg.all, ns_list);
> +	if (!cfg.namespace_id)
> +		return -EINVAL;

Would it be useful to include an error message here? I don't like
playing the guessing game about what I did wrong when I just get the
help message back.

> +
> +	err = nvme_identify_ns_list(fd, cfg.namespace_id - 1, !!cfg.all,
> +				    ns_list);
>   	if (!err) {
>   		for (i = 0; i < 1024; i++)
>   			if (ns_list[i])
> 

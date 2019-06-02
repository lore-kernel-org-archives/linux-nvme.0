From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Sun, 2 Jun 2019 23:08:21 +0000
Subject: [PATCH V5 2/6] fabrics: Do not return in the middle of the
 subcommand
References: <20190523145750.27425-1-minwoo.im.dev@gmail.com>
 <20190523145750.27425-3-minwoo.im.dev@gmail.com>
Message-ID: <BYAPR04MB5749D2AD58284C2F5F859527861B0@BYAPR04MB5749.namprd04.prod.outlook.com>

This patch overall looks good to me. Some code level consistency is needed.

On 5/23/19 7:58 AM, Minwoo Im wrote:
> This patch also makes fabrics module to not return the internal error
> status in the middle of the subcommands to support uniformed mapped
> error value which will be introduced in the next patches.
>
> Cc: Keith Busch <kbusch at kernel.org>
> Cc: Chaitanya Kulkarni <chaitanya.Kulkarni at wdc.com>
> Signed-off-by: Minwoo Im <minwoo.im.dev at gmail.com>
> ---
>  fabrics.c | 31 +++++++++++++++++++------------
>  1 file changed, 19 insertions(+), 12 deletions(-)
>
> diff --git a/fabrics.c b/fabrics.c
> index 511de06..469b4a1 100644
> --- a/fabrics.c
> +++ b/fabrics.c
> @@ -984,20 +984,23 @@ int discover(const char *desc, int argc, char **argv, bool connect)
>  	ret = argconfig_parse(argc, argv, desc, command_line_options, &cfg,
>  			sizeof(cfg));
>  	if (ret)
> -		return ret;
> +		goto ret;
>  
>  	cfg.nqn = NVME_DISC_SUBSYS_NAME;
>  
>  	if (!cfg.transport && !cfg.traddr) {
> -		return discover_from_conf_file(desc, argstr,
> +		ret = discover_from_conf_file(desc, argstr,
>  				command_line_options, connect);
>  	} else {
>  		ret = build_options(argstr, BUF_SIZE);
>  		if (ret)
> -			return ret;
> +			goto ret;
>  
> -		return do_discover(argstr, connect);
> +		ret = do_discover(argstr, connect);
>  	}
> +
> + ret:

Particularly in this file you can see label named "out"  being used and
is also prefixed.

Can we make sure this change is consistent with the rest of the code?

> +	return ret;
>  }
>  
>  int connect(const char *desc, int argc, char **argv)
> @@ -1029,21 +1032,23 @@ int connect(const char *desc, int argc, char **argv)
>  	ret = argconfig_parse(argc, argv, desc, command_line_options, &cfg,
>  			sizeof(cfg));
>  	if (ret)
> -		return ret;
> +		goto ret;
>  
>  	ret = build_options(argstr, BUF_SIZE);
>  	if (ret)
> -		return ret;
> +		goto ret;
>  
>  	if (!cfg.nqn) {
>  		fprintf(stderr, "need a -n argument\n");
> -		return -EINVAL;
> +		ret = -EINVAL;
> +		goto ret;
>  	}
>  
>  	instance = add_ctrl(argstr);
>  	if (instance < 0)
> -		return instance;
> -	return 0;
> +		ret = instance;
> + ret:
Same here.
> +	return ret;
>  }
>  
>  static int scan_sys_nvme_filter(const struct dirent *d)
> @@ -1148,11 +1153,12 @@ int disconnect(const char *desc, int argc, char **argv)
>  	ret = argconfig_parse(argc, argv, desc, command_line_options, &cfg,
>  			sizeof(cfg));
>  	if (ret)
> -		return ret;
> +		goto ret;
>  
>  	if (!cfg.nqn && !cfg.device) {
>  		fprintf(stderr, "need a -n or -d argument\n");
> -		return -EINVAL;
> +		ret = -EINVAL;
> +		goto ret;
>  	}
>  
>  	if (cfg.nqn) {
> @@ -1174,6 +1180,7 @@ int disconnect(const char *desc, int argc, char **argv)
>  				cfg.device);
>  	}
>  
> + ret:
>  	
Same here.
> return ret;
>  }
>  
> @@ -1188,7 +1195,7 @@ int disconnect_all(const char *desc, int argc, char **argv)
>  	ret = argconfig_parse(argc, argv, desc, command_line_options, &cfg,
>  			sizeof(cfg));
>  	if (ret)
> -		return ret;
> +		goto out;
>  
>  	slist = get_subsys_list(&subcnt, NULL, NVME_NSID_ALL);
>  	for (i = 0; i < subcnt; i++) {

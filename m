From: minwoo.im@samsung.com (Minwoo Im)
Date: Tue, 30 Apr 2019 08:47:05 +0900
Subject: [PATCH nvme-cli rfc] fabrics: support default connect/discover
 args
In-Reply-To: <20190429225338.6866-1-sagi@grimberg.me>
References: <20190429225338.6866-1-sagi@grimberg.me>
 <CGME20190429225354epcas4p3d772e0abb1a7ec23c9babd7065844058@epcms2p8>
Message-ID: <20190429234705epcms2p87119b48a152a4aec44a3083443afdd65@epcms2p8>

Hi, Sagi.

> -----Original Message-----
> From: Linux-nvme [mailto:linux-nvme-bounces at lists.infradead.org] On
> Behalf Of Sagi Grimberg
> Sent: Tuesday, April 30, 2019 7:54 AM
> To: linux-nvme at lists.infradead.org
> Cc: Keith Busch; Hannes Reinecke; Johannes Thumshirn; Christoph Hellwig;
> James Smart
> Subject: [PATCH nvme-cli rfc] fabrics: support default connect/discover args
> 
> Introduce /etc/nvme/defargs.conf where we allow the user to
> specify connect/discover parameters once and not for every
> controller. The cli will always ingest the content of this
> file before parsing cmdline args such that the user can
> override them.
> 
> The format is simply writing the arguments into the file as
> if they were appended to the execution command.
> 
> Also, properly install this file with some minimal documentation.
> 
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> ---
> This was raised before in the past that we don't have some place
> to store default connect args.
> 
> For example, when handling automatic discovery change log events
> this can be a way for the user to set global default arguments.
> 
> Feedback is welcome.
> 
>  Makefile            |  3 +++
>  etc/defargs.conf.in |  5 ++++
>  fabrics.c           | 63
> +++++++++++++++++++++++++++++++++++++++++++++
>  nvme.spec.in        |  1 +
>  4 files changed, 72 insertions(+)
>  create mode 100644 etc/defargs.conf.in
> 
> diff --git a/Makefile b/Makefile
> index 4bfbebbd156a..6f11941b5d3e 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -105,6 +105,9 @@ install-etc:
>  	if [ ! -f $(DESTDIR)$(SBINDIR)/nvme/discovery.conf ]; then \
>  		$(INSTALL) -m 644 -T ./etc/discovery.conf.in
> $(DESTDIR)$(SYSCONFDIR)/nvme/discovery.conf; \
>  	fi
> +	if [ ! -f $(DESTDIR)$(SBINDIR)/nvme/defargs.conf ]; then \
> +		$(INSTALL) -m 644 -T ./etc/defargs.conf.in
> $(DESTDIR)$(SYSCONFDIR)/nvme/defargs.conf; \
> +	fi
> 
>  install-spec: install-bin install-man install-bash-completion install-zsh-
> completion install-etc
>  install: install-spec install-hostparams
> diff --git a/etc/defargs.conf.in b/etc/defargs.conf.in
> new file mode 100644
> index 000000000000..e91106bf5bbf
> --- /dev/null
> +++ b/etc/defargs.conf.in
> @@ -0,0 +1,5 @@
> +# Used for extracting default controller connect parameters
> +#
> +# Example:
> +# --keep-alive-tmo=<x> --reconnect-delay=<y> --ctrl-loss-tmo=<z> --nr-io-
> queues=<u>
> +# --queue-size=<v>
> diff --git a/fabrics.c b/fabrics.c
> index 511de06aec97..e609e679c832 100644
> --- a/fabrics.c
> +++ b/fabrics.c
> @@ -72,8 +72,10 @@ static struct config {
>  #define PATH_NVMF_DISC		"/etc/nvme/discovery.conf"
>  #define PATH_NVMF_HOSTNQN	"/etc/nvme/hostnqn"
>  #define PATH_NVMF_HOSTID	"/etc/nvme/hostid"
> +#define PATH_NVMF_DEFARGS	"/etc/nvme/defargs.conf"
>  #define SYS_NVME		"/sys/class/nvme"
>  #define MAX_DISC_ARGS		10
> +#define MAX_DEF_ARGS		10
>  #define MAX_DISC_RETRIES	10
> 
>  enum {
> @@ -894,6 +896,59 @@ static int do_discover(char *argstr, bool connect)
>  	return ret;
>  }
> 
> +static int nvmf_parse_defargs(const char *desc,
> +		const struct argconfig_commandline_options *opts)
> +{
> +	FILE *f;
> +	char line[256], *ptr, *args, **argv;
> +	int argc = 0, ret = 0;

Nit here: we don't need initialize 'argc' here because it will be zero before
getting used below.

This looks good to me, by the way.
Reviewed-by: Minwoo Im <minwoo.im at samsung.com>

Thanks,

> +
> +	f = fopen(PATH_NVMF_DEFARGS, "r");
> +	if (f == NULL)
> +		return 0;
> +
> +	while (fgets(line, sizeof(line), f) != NULL) {
> +		if (line[0] == '#' || line[0] == '\n')
> +			continue;
> +
> +		args = strdup(line);
> +		if (!args) {
> +			fprintf(stderr, "failed to strdup args\n");
> +			ret = -ENOMEM;
> +			goto out;
> +		}
> +
> +		argv = calloc(MAX_DEF_ARGS, BUF_SIZE);
> +		if (!argv) {
> +			fprintf(stderr, "failed to allocate argv vector\n");
> +			free(args);
> +			ret = -ENOMEM;
> +			goto out;
> +		}
> +
> +		argc = 0;
> +		argv[argc++] = "dummy";
> +		while ((ptr = strsep(&args, " =\n")) != NULL)
> +			argv[argc++] = ptr;
> +
> +		ret = argconfig_parse(argc, argv, desc, opts, &cfg, sizeof(cfg));
> +		free(args);
> +		free(argv);
> +		if (ret)
> +			goto out;
> +
> +		if (cfg.transport || cfg.traddr || cfg.trsvcid || cfg.nqn) {
> +			fprintf(stderr, "args transport, traddr, trsvcid, nqn "
> +				"cannot have a default\n");
> +			ret = -EINVAL;
> +			goto out;
> +		}
> +	}
> +out:
> +	fclose(f);
> +	return ret;
> +}
> +
>  static int discover_from_conf_file(const char *desc, char *argstr,
>  		const struct argconfig_commandline_options *opts, bool
> connect)
>  {
> @@ -981,6 +1036,10 @@ int discover(const char *desc, int argc, char **argv,
> bool connect)
>  		{NULL},
>  	};
> 
> +	ret = nvmf_parse_defargs(desc, command_line_options);
> +	if (ret)
> +		return ret;
> +
>  	ret = argconfig_parse(argc, argv, desc, command_line_options, &cfg,
>  			sizeof(cfg));
>  	if (ret)
> @@ -1026,6 +1085,10 @@ int connect(const char *desc, int argc, char **argv)
>  		{NULL},
>  	};
> 
> +	ret = nvmf_parse_defargs(desc, command_line_options);
> +	if (ret)
> +		return ret;
> +
>  	ret = argconfig_parse(argc, argv, desc, command_line_options, &cfg,
>  			sizeof(cfg));
>  	if (ret)
> diff --git a/nvme.spec.in b/nvme.spec.in
> index 6934f8fd605b..e2240b61d79e 100644
> --- a/nvme.spec.in
> +++ b/nvme.spec.in
> @@ -35,6 +35,7 @@ make install-spec DESTDIR=%{buildroot} PREFIX=/usr
>  %{_sysconfdir}/nvme/hostnqn
>  %{_sysconfdir}/nvme/hostid
>  %{_sysconfdir}/nvme/discovery.conf
> +%{_sysconfdir}/nvme/defargs.conf
> 
>  %clean
>  rm -rf $RPM_BUILD_ROOT
> --
> 2.17.1
> 
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme

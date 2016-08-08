From: james_p_freyensee@linux.intel.com (J Freyensee)
Date: Mon, 08 Aug 2016 14:51:14 -0700
Subject: [PATCH v2 nvme-cli 3/4] fabrics: Allow discover params to come
 from a conf file
In-Reply-To: <1470657480-5868-4-git-send-email-sagi@grimberg.me>
References: <1470657480-5868-1-git-send-email-sagi@grimberg.me>
 <1470657480-5868-4-git-send-email-sagi@grimberg.me>
Message-ID: <1470693074.4368.44.camel@linux.intel.com>

I missed some things on this patch.

> ?
> ?#define BUF_SIZE		4096
> ?#define PATH_NVME_FABRICS	"/dev/nvme-fabrics"
> +#define PATH_NVMF_DISC		"/etc/nvme/nvmf_disc"
> +#define MAX_DISC_ARGS		10
> ?
> ?enum {
> ?	OPT_INSTANCE,
> @@ -575,6 +577,62 @@ static int do_discover(char *argstr, bool
> connect)
> ?	return ret;
> ?}
> ?
> +static int discover_from_conf_file(const char *desc, char *argstr,
> +	const struct argconfig_commandline_options *opts, bool
> connect)
> +{
> +	FILE *f;
> +	char line[255], *ptr, *args, **argv;

Why is line 255 and not 256? ?Maybe want it a #define?

> +	int argc, err, ret = 0;
> +
> +	f = fopen(PATH_NVMF_DISC, "r");
> +	if (f == NULL) {
> +		fprintf(stderr, "No discover params given and no %s
> conf\n", PATH_NVMF_DISC);
> +		return -EINVAL;
> +	}
> +
> +	while (fgets(line, sizeof(line), f) != NULL) {
> +		if (line[0] == '#' || line[0] == '\n')
> +			continue;
> +
> +		args = strdup(line);
> +		if (!args) {
> +			fprintf(stderr, "failed to strdup args\n");

Be useful to print out the line so you know where you failed.

> +			return -ENOMEM;
> +		}
> +
> +		argv = calloc(MAX_DISC_ARGS, BUF_SIZE);
> +		if (!argv) {
> +			fprintf(stderr, "failed to allocate args
> vector\n");

memory leak from not free'ing args in this case???

Also fprintf() says 'args' not 'argv'. ?And again may be useful to
print out the line of where you failed.


> +			return -ENOMEM;
> +		}
> +
> +		argc = 0;
> +		argv[argc++] = "discover";
> +		while ((ptr = strsep(&args, " =\n")) != NULL)
> +			argv[argc++] = ptr;
> +
> +		argconfig_parse(argc, argv, desc, opts, &cfg,
> sizeof(cfg));
> +
> +		err = build_options(argstr, BUF_SIZE);
> +		if (err) {
> +			ret = err;

Again mentioned by Christoph, probably need some diagnostics on why err
didn't get set to 0.

> +			continue;
> +		}
> +
> +		err = do_discover(argstr, connect);
> +		if (err) {
> +			ret = err;

Same here.

> +			continue;
> +		}
> +
> +		free(args);
> +		free(argv);
> +	}
> +
> +	fclose(f);
> +	return ret;
> +}
> +
> ?int discover(const char *desc, int argc, char **argv, bool connect)
> ?{
> ?	char argstr[BUF_SIZE];
> @@ -597,11 +655,16 @@ int discover(const char *desc, int argc, char
> **argv, bool connect)
> ?
> ?	cfg.nqn = NVME_DISC_SUBSYS_NAME;
> ?
> -	ret = build_options(argstr, BUF_SIZE);
> -	if (ret)
> -		return ret;
> +	if (!cfg.transport && !cfg.traddr) {
> +		return discover_from_conf_file(desc, argstr,
> +				command_line_options, connect);
> +	} else {
> +		ret = build_options(argstr, BUF_SIZE);
> +		if (ret)

same here.

> +			return ret;
> ?
> -	return do_discover(argstr, connect);
> +		return do_discover(argstr, connect);
> +	}
> ?}
> ?
> ?int connect(const char *desc, int argc, char **argv)

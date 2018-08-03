From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Fri, 03 Aug 2018 20:59:24 +0900
Subject: [PATCH V3 1/2] nvme-cli: add minimal ana-log page support
In-Reply-To: <20180802032819.6558-2-chaitanya.kulkarni@wdc.com>
References: <20180802032819.6558-1-chaitanya.kulkarni@wdc.com>
 <20180802032819.6558-2-chaitanya.kulkarni@wdc.com>
Message-ID: <1533297564.2982.11.camel@gmail.com>

Hi Chaitanya,

One more trivial comment on this patch.

On 18-08-01 20:28:18, Chaitanya Kulkarni wrote:
> This patch adds a new command to retrieve the ANA Log page.
> We update identify ctrl/ns data structure to support this command.
> We also add ana based error codes and different identifiers to the
> linux/nvme.h header file in order to support this command.
>?
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
> Signed-off-by: Hannes Reinecke <hare at suse.com>
> ---

> +static int get_ana_log(int argc, char **argv, struct command *cmd,
> +		struct plugin *plugin)
> +{
> +	const char *desc = "Retrieve ANA log for the given device" \
> +			"in either decoded format "\
> +			"(default) or binary.";
> +	const char *raw = "output in binary format";
> +	void *ana_log;
> +	int err, fmt, fd;
> +	int groups = 0; /* Right now get all the per ANA group NSIDS */
> +	size_t ana_log_len;
> +	struct nvme_id_ctrl ctrl;
> +
> +	struct config {
> +		int???raw_binary;
> +		char *output_format;
> +	};
> +
> +	struct config cfg = {
> +		.output_format = "normal",
> +	};
> +
> +	const struct argconfig_commandline_options command_line_options[] = {
> +		{"output-format", 'o', "FMT", CFG_STRING,???&cfg.output_format, required_argument, output_format },
> +		{"raw-binary",????'b', "",????CFG_NONE,?????&cfg.raw_binary,????no_argument,???????raw},
> +		{NULL}
> +	};
> +

There was a discussion about the '--raw-binary' option to deprecate it because
'--output-format=binary' or '-o binary' will make a same result.

You can find the discussion on the Github PR #342 in following link:
????https://github.com/linux-nvme/nvme-cli/pull/342

For the newly added subcommand, it doesn't need to support the '--raw-binary'
option anymore.

Thanks,

	Minwoo Im

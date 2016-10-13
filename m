From: keith.busch@intel.com (Keith Busch)
Date: Thu, 13 Oct 2016 12:10:06 -0400
Subject: [PATCH nvme-cli] argconfig: Rewind optind before looping on
 getopt_long
In-Reply-To: <1476373205-30860-1-git-send-email-sagi@grimberg.me>
References: <1476373205-30860-1-git-send-email-sagi@grimberg.me>
Message-ID: <20161013161005.GD17823@localhost.localdomain>

On Thu, Oct 13, 2016@06:40:05PM +0300, Sagi Grimberg wrote:
> In conf file based discovery we can call argconfig_parse
> multiple times.

Jay beat you to it. :)

  https://github.com/linux-nvme/nvme-cli/commit/2da2440f1e5e98df61b192446be7c68a170dcda6

> Reported-by: Jay Freyensee <james_p_freyensee at linux.intel.com>
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> ---
>  argconfig.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/argconfig.c b/argconfig.c
> index e2bb7ab26446..bda8b03c1cbd 100644
> --- a/argconfig.c
> +++ b/argconfig.c
> @@ -193,6 +193,7 @@ int argconfig_parse(int argc, char *argv[], const char *program_desc,
>  	short_opts[short_index++] = 'h';
>  	short_opts[short_index] = 0;
>  
> +	optind = 0;
>  	while ((c = getopt_long_only(argc, argv, short_opts, long_opts,
>  				&option_index)) != -1) {
>  		if (c != 0) {

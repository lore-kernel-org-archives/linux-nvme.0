From: osandov@osandov.com (Omar Sandoval)
Date: Mon, 21 May 2018 11:29:04 -0700
Subject: [PATCH blktests] Documentation: document prerequisite scriptlets
In-Reply-To: <20180514114042.12082-1-jthumshirn@suse.de>
References: <20180514114042.12082-1-jthumshirn@suse.de>
Message-ID: <20180521182904.GA14774@vader>

On Mon, May 14, 2018@01:40:42PM +0200, Johannes Thumshirn wrote:
> The config file is bash and it gets sourced, so all bash magic is
> doable in there as well. Document it so others don't have to
> re-discover this gem as well.

I'm supportive of this...

> Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>
> ---
>  Documentation/running-tests.md | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/Documentation/running-tests.md b/Documentation/running-tests.md
> index a479d5e94c5e..b477c0679683 100644
> --- a/Documentation/running-tests.md
> +++ b/Documentation/running-tests.md
> @@ -66,3 +66,15 @@ command line option.
>  QUICK_RUN=1
>  TIMEOUT=30
>  ```
> +
> +### Pre-test setups
> +
> +Some tests, may need special prerequisites, like configfs being
> +mounted for NVMe over Fabrics tests. You can add your custom bash
> +scriptlets to `config` to get this done, e.g.:
> +
> +```sh
> +if ! test $(grep -q configfs /proc/mounts) ; then
> +        mount -t configfs none /sys/kernel/config
> +fi
> +```

But I'm curious about this specific example. Is this not mounted for you
automatically? I'm guessing systemd does it for me on my setup.

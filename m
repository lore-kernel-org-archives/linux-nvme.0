From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 17 Nov 2016 05:36:06 -0800
Subject: [PATCH nvme-cli v2 2/2] nvme.spec/debian: Auto generate host nqn
 as part of install
In-Reply-To: <1479387288-13367-3-git-send-email-sagi@grimberg.me>
References: <1479387288-13367-1-git-send-email-sagi@grimberg.me>
 <1479387288-13367-3-git-send-email-sagi@grimberg.me>
Message-ID: <20161117133606.GB13756@infradead.org>

On Thu, Nov 17, 2016@02:54:48PM +0200, Sagi Grimberg wrote:
> The installation will generate a hostnqn and store it in
> /etc/nvme/hostnqn file (in case it doesn't exist).
> This file will be removed upon uninstallation (purge on for debian).
> 
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> ---
>  debian/postinst | 20 ++++++++++++++++++++
>  debian/postrm   | 10 ++++++++++
>  nvme.spec.in    | 17 +++++++++++++++++
>  3 files changed, 47 insertions(+)
>  create mode 100644 debian/postinst
>  create mode 100644 debian/postrm
> 
> diff --git a/debian/postinst b/debian/postinst
> new file mode 100644
> index 000000000000..b258cf569c3e
> --- /dev/null
> +++ b/debian/postinst
> @@ -0,0 +1,20 @@
> +#!/bin/sh
> +
> +set -e
> +
> +case "$1" in
> +    configure|install)
> +	if [ ! -f /etc/nvme/hostnqn ]; then
> +		install -D /dev/null /etc/nvme/hostnqn
> +		echo $(nvme gen-hostnqn) > /etc/nvme/hostnqn

The $() syntax is a bash-ish.  To work with a traditional bourne shell
it needs to be `nvme gen-hostnqn`

> +		if [ ! -n "$(ls -A /etc/nvme)" ]; then

Same here.

> +			rm -rf /etc/nvme
> +		fi

But maybe you should just do a

		rmdir /etc/nvme >/dev/null

instead?

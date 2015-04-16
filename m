From: pebolle@tiscali.nl (Paul Bolle)
Date: Thu, 16 Apr 2015 11:12:39 +0200
Subject: [PATCH 3/5 v2] lightnvm: RRPC target
In-Reply-To: <1429101284-19490-4-git-send-email-m@bjorling.me>
References: <1429101284-19490-1-git-send-email-m@bjorling.me>
 <1429101284-19490-4-git-send-email-m@bjorling.me>
Message-ID: <1429175559.16771.47.camel@x220>

On Wed, 2015-04-15@14:34 +0200, Matias Bj?rling wrote:
> --- /dev/null
> +++ b/drivers/lightnvm/Kconfig

> +menuconfig NVM
> +	bool "Open-Channel SSD target support"
> +	depends on BLK_DEV_NVM
> +	help
> +	  Say Y here to get to enable Open-channel SSDs.
> +
> +	  Open-Channel SSDs implement a set of extension to SSDs, that
> +	  exposes direct access to the underlying non-volatile memory.
> +
> +	  If you say N, all options in this submenu will be skipped and disabled
> +	  only do this if you know what you are doing.
> +
> +if NVM
> +
> +config NVM_RRPC
> +	tristate "Round-robin Hybrid Open-Channel SSD"
> +	depends on BLK_DEV_NVM

NVM implies BLK_DEV_NVM so this dependency isn't really needed.

> +	---help---
> +	Allows an open-channel SSD to be exposed as a block device to the
> +	host. The target is implemented using a linear mapping table and
> +	cost-based garbage collection. It is optimized for 4K IO sizes.
> +
> +	See Documentation/nvm-rrpc.txt for details.

This file isn't part of this series, is it?

> +
> +endif # NVM
> diff --git a/drivers/lightnvm/Makefile b/drivers/lightnvm/Makefile
> new file mode 100644
> index 0000000..80d75a8
> --- /dev/null
> +++ b/drivers/lightnvm/Makefile
> @@ -0,0 +1,5 @@
> +#
> +# Makefile for Open-Channel SSDs.
> +#
> +
> +obj-$(CONFIG_NVM)		+= rrpc.o

I suppose you meant to use
    obj-$(CONFIG_NVM_RRPC)		+= rrpc.o

because otherwise setting NVM_RRPC has no effect. 

> --- /dev/null
> +++ b/drivers/lightnvm/rrpc.c

> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License version
> + * 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * General Public License for more details.

This states the license is GPL v2.

> +MODULE_LICENSE("GPL");

And (according to include/linux/module.h) the license ident "GPL" states
the license is GPL v2 or later. So either the comment at the top of this
file or the license ident needs to change.

Thanks,


Paul Bolle

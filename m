From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 2 Feb 2017 23:54:55 -0800
Subject: [PATCH v5 1/4] Include: Uapi: Add user ABI for Sed/Opal
In-Reply-To: <1485857844-15130-2-git-send-email-scott.bauer@intel.com>
References: <1485857844-15130-1-git-send-email-scott.bauer@intel.com>
 <1485857844-15130-2-git-send-email-scott.bauer@intel.com>
Message-ID: <20170203075455.GB25892@infradead.org>

On Tue, Jan 31, 2017@03:17:21AM -0700, Scott Bauer wrote:
> Signed-off-by: Scott Bauer <scott.bauer at intel.com>
> Signed-off-by: Rafael Antognolli <Rafael.Antognolli at intel.com>
> ---
>  include/uapi/linux/sed-opal.h | 115 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 115 insertions(+)
>  create mode 100644 include/uapi/linux/sed-opal.h
> 
> diff --git a/include/uapi/linux/sed-opal.h b/include/uapi/linux/sed-opal.h
> new file mode 100644
> index 0000000..723ad89
> --- /dev/null
> +++ b/include/uapi/linux/sed-opal.h
> @@ -0,0 +1,115 @@
> +/*
> + * Copyright ? 2016 Intel Corporation
> + *
> + * Authors:
> + *    Rafael Antognolli <rafael.antognolli at intel.com>
> + *    Scott  Bauer      <scott.bauer at intel.com>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + */
> +
> +#ifndef _UAPI_SED_OPAL_H
> +#define _UAPI_SED_OPAL_H
> +
> +#include <linux/types.h>
> +
> +#define OPAL_KEY_MAX 256
> +#define OPAL_MAX_LRS 9
> +
> +enum opal_mbr {
> +	OPAL_MBR_ENABLE,
> +	OPAL_MBR_DISABLE,

For all user ABIs please always use explicitly assigned values.  There
is a religious fight going on if these should be enmums or #defines,
but at least I don't care about that part.

> +	OPAL_RW = 0x02, /* 0010 */
> +	OPAL_LK = 0x04, /* 0100 */
> +};
> +
> +struct opal_key {
> +	uint8_t	lr;
> +	uint8_t	key_len;
> +	char 	key[OPAL_KEY_MAX];
> +};
> +
> +struct opal_lr_act {
> +	int sum;
> +	uint8_t num_lrs;
> +	uint8_t lr[OPAL_MAX_LRS];
> +	struct opal_key key;
> +};

Can you go over all theses types and make sure that the structs
are nicely aligned and all holes in the layout are explicitly
padded with reserved values?

From: hare@suse.de (Hannes Reinecke)
Date: Thu, 10 Jan 2019 09:11:39 +0100
Subject: [PATCH] nvme-cli: Fixup compilation with user-defined CFLAGS
In-Reply-To: <20190110081006.35288-1-hare@suse.de>
References: <20190110081006.35288-1-hare@suse.de>
Message-ID: <9ab4060e-9559-00ef-bdb3-35446d9ca6b5@suse.de>

On 1/10/19 9:10 AM, Hannes Reinecke wrote:
> Calling 'make CFLAGS="-Wall"' breaks compilation as the include
> statement will be overwritten.
> 
> Signed-off-by: Hannes Reinecke <hare at suse.com>
> ---
>   Makefile | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 525616a..4ea19dd 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1,5 +1,5 @@
> -CFLAGS ?= -O2 -g -Wall -Werror -I.
> -CFLAGS += -std=gnu99
> +CFLAGS ?= -O2 -g -Wall -Werror
> +CFLAGS += -I. -std=gnu99
>   CPPFLAGS += -D_GNU_SOURCE -D__CHECK_ENDIAN__
>   LIBUUID = $(shell $(LD) -o /dev/null -luuid >/dev/null 2>&1; echo $$?)
>   NVME = nvme
> 
Please disregard. This patch doesn't fix it :-(

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)

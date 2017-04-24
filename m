From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 24 Apr 2017 00:19:55 -0700
Subject: [PATCH] nvme-cli: Fix build on aarch64-linux-android-4.9
In-Reply-To: <20170423174741.GA4812@hercules.tuxera.com>
References: <20170423174741.GA4812@hercules.tuxera.com>
Message-ID: <20170424071955.GA29119@infradead.org>

>  #ifndef _COMMON_H
>  #define _COMMON_H
>  
> +#ifndef offsetof
>  #define offsetof(x, y)	__builtin_offsetof(x, y)
> +#endif

Please just remove the defintion entirely and make sure we always
have <stddef.h> included for the offsetoff definition.

From: joe@perches.com (Joe Perches)
Date: Wed, 09 Dec 2015 11:06:31 -0800
Subject: [PATCHv2 1/2] Print: Add print format for 8-byte EUI-64 type
In-Reply-To: <1449686577-6319-2-git-send-email-keith.busch@intel.com>
References: <1449686577-6319-1-git-send-email-keith.busch@intel.com>
 <1449686577-6319-2-git-send-email-keith.busch@intel.com>
Message-ID: <1449687991.25389.23.camel@perches.com>

On Wed, 2015-12-09@11:42 -0700, Keith Busch wrote:
> MAC addresses may be formed using rules based on EUI-64, which is 2 bytes
> longer than a typical 6-byte MAC. This patch adds a long specifier to
> the %pM format to support the extended unique identifier.
[]
> diff --git a/Documentation/printk-formats.txt b/Documentation/printk-formats.txt
[]
> @@ -136,14 +136,21 @@ Raw buffer as a hex string:
> ?MAC/FDDI addresses:
> ?
> ?	%pM	00:01:02:03:04:05
> +	%pMl	00:01:02:03:04:05:06:07
> ?	%pMR	05:04:03:02:01:00
> +	%pMRl	07:06:05:04:03:02:01:00
> ?	%pMF	00-01-02-03-04-05
> +	%pMFl	00-01-02-03-04-05-06-07
> ?	%pm	000102030405
> +	%pml	0001020304050607
> ?	%pmR	050403020100
> +	%pmRl	0706050403020100
[]
> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
[]
> @@ -908,14 +908,21 @@ char *mac_address_string(char *buf, char *end, u8 *addr,
> ?		separator = ':';
> ?		break;
> ?	}
> +	switch (fmt[2]) {
> +	case 'l':
> +		bytes = 8;
> +		break;
> +	default:
> +		break;
> +	}

This doesn't work for formats without pmR or pmF.
like "%pml" or "%pMl" as fmt[2] can be anything.

From: joe@perches.com (Joe Perches)
Date: Wed, 09 Dec 2015 13:16:26 -0800
Subject: [PATCHv2] printf: Add format for 8-byte EUI-64 type
In-Reply-To: <1449695357-22163-1-git-send-email-keith.busch@intel.com>
References: <1449695357-22163-1-git-send-email-keith.busch@intel.com>
Message-ID: <1449695786.25389.67.camel@perches.com>

On Wed, 2015-12-09@14:09 -0700, Keith Busch wrote:
> MAC addresses may be formed using rules based on EUI-64, which is 2 bytes
> longer than a typical 6-byte MAC. This patch adds a long specifier to
> the %pM format to support the extended unique identifier.
> 
> Since there are now two cases that use the default ':' separator, this
> initializes the separator during its declaration, and removes the switch
> fall through case.
> 
> Signed-off-by: Keith Busch <keith.busch at intel.com>
> ---
> Changed from previos version:
> 
> ? Fixed checks for the 'l' specifier. This can be in fmt[1] or fmt[2],
> ? pointed out by Joe Perches from original review (thanks!).
[]
> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
[]
> @@ -902,20 +902,33 @@ char *mac_address_string(char *buf, char *end, u8 *addr,
> ?
> ?	case 'R':
> ?		reversed = true;
> -		/* fall through */
> +		break;
> +
> +	case 'l':
> +		bytes = 8;
> +		break;
> ?
> ?	default:
> -		separator = ':';
> ?		break;
> ?	}
> +	if (separator == '-' || reversed) {
> +		/* 'F' and 'R' may take additional length specifier */
> +		switch (fmt[2]) {
> +		case 'l':
> +			bytes = 8;
> +			break;
> +		default:
> +			break;
> +		}
> +	}
> 

Using a while (isalpha(*++fmt)) loop like ip6_addr_string_sa
would probably be simpler.

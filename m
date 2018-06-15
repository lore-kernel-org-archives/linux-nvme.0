From: hch@infradead.org (Christoph Hellwig)
Date: Fri, 15 Jun 2018 02:35:00 -0700
Subject: [PATCH] nvme-cli: Implement printing the get host controlled
 thermal management feature.
In-Reply-To: <20180613201531.12027-1-revanth.rajashekar@intel.com>
References: <20180613201531.12027-1-revanth.rajashekar@intel.com>
Message-ID: <20180615093500.GB10928@infradead.org>

> --- a/linux/nvme.h
> +++ b/linux/nvme.h
> @@ -857,6 +857,7 @@ enum {
>  	NVME_FEAT_HOST_MEM_BUF	= 0x0d,
>  	NVME_FEAT_TIMESTAMP	= 0x0e,
>  	NVME_FEAT_KATO		= 0x0f,
> +	NVME_FEAT_HCTM		= 0X10,
>  	NVME_FEAT_RRL		= 0x12,
>  	NVME_FEAT_PLM_CONFIG	= 0x13,
>  	NVME_FEAT_PLM_WINDOW	= 0x14,

Please also send any uptdates to this file to the kernel.

>  	case NVME_FEAT_RESV_PERSIST:
>  		printf("\tPersist Through Power Loss (PTPL): %s\n", (result & 0x00000001) ? "True":"False");
>  		break;
> +	case NVME_FEAT_HCTM:
> +		printf("\tThermal Management Temperature 1 (TMT1) : %u Kelvin\n", (result >> 16));
> +		printf("\tThermal Management Temperature 2 (TMT2) : %u Kelvin\n", (result & 0x0000ffff));
> +		break;
>  	}

Please use a new line for the argument after the format string.

Also both pairs of inner braces are not required.

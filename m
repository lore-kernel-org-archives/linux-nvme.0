From: hch@lst.de (Christoph Hellwig)
Date: Thu, 9 Nov 2017 10:23:38 +0100
Subject: [PATCHv3 1/5] nvme: Centralize AEN defines
In-Reply-To: <20171107221314.27822-2-keith.busch@intel.com>
References: <20171107221314.27822-1-keith.busch@intel.com>
 <20171107221314.27822-2-keith.busch@intel.com>
Message-ID: <20171109092338.GA17120@lst.de>

Looks fine:

Reviewed-by: Christoph Hellwig <hch at lst.de>

> diff --git a/include/linux/nvme.h b/include/linux/nvme.h
> index fd1d4508a612..89ffa7eed2fd 100644
> --- a/include/linux/nvme.h
> +++ b/include/linux/nvme.h
> @@ -90,6 +90,14 @@ enum {
>  };
>  
>  #define NVME_AQ_DEPTH		32
> +#define NVME_NR_AEN_COMMANDS	1
> +#define NVME_AQ_BLK_MQ_DEPTH	(NVME_AQ_DEPTH - NVME_NR_AEN_COMMANDS)
> +
> +/*
> + * Subtract one to leave an empty queue entry for 'Full Queue' condition. See
> + * NVM-Express 1.2 specification, section 4.1.2.
> + */
> +#define NVME_AQ_MQ_TAG_DEPTH	(NVME_AQ_BLK_MQ_DEPTH - 1)

But none of these (including NVME_AQ_DEPTH) really is a protocol
constant, so this should probably move to drivers/nvme/host/nvme.h.

No need to do that in this patchseries, though.

From: hch@lst.de (Christoph Hellwig)
Date: Mon, 2 Jul 2018 15:11:08 +0200
Subject: [PATCHv4 2/4] nvme: use hw qid in trace events
In-Reply-To: <20180629225003.16567-3-keith.busch@intel.com>
References: <20180629225003.16567-1-keith.busch@intel.com>
 <20180629225003.16567-3-keith.busch@intel.com>
Message-ID: <20180702131107.GB4624@lst.de>

> diff --git a/drivers/nvme/host/trace.h b/drivers/nvme/host/trace.h
> index 01390f0e1671..6f9ee5fe5e09 100644
> --- a/drivers/nvme/host/trace.h
> +++ b/drivers/nvme/host/trace.h
> @@ -24,6 +24,15 @@
>  
>  #include "nvme.h"
>  
> +#define __assign_nvme_qid(req, qid)					\
> +	do {								\
> +		if (req->rq_disk)					\
> +			qid = 1 + blk_mq_unique_tag_to_hwq(		\
> +					blk_mq_unique_tag(req));	\
> +		else							\
> +			qid = 0;					\
> +	} while (0)

Why can't we use an inline function for this?

Relying on assining to macro paramters is a good way to generate
unreadable code.

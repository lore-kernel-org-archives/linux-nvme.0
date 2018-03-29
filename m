From: james.smart@broadcom.com (James Smart)
Date: Thu, 29 Mar 2018 09:34:29 -0700
Subject: [PATCH 3/4] nvmet-fc: Don't use the count returned by the
 dma_map_sg call
In-Reply-To: <5ba62675-39b4-6409-5628-c59d8ae048de@deltatee.com>
References: <20180329160721.4691-1-logang@deltatee.com>
 <20180329160721.4691-4-logang@deltatee.com>
 <03cb3610-8ec7-9dc4-9e0a-82f4c30de578@broadcom.com>
 <5ba62675-39b4-6409-5628-c59d8ae048de@deltatee.com>
Message-ID: <5a5ab779-c949-8caa-abff-88063e885cd5@broadcom.com>

On 3/29/2018 9:30 AM, Logan Gunthorpe wrote:
> Can you elaborate? The 'data_sg_cnt' member was in 'struct
> nvmet_fc_fcp_iod' which is declared in fc.c so it doesn't seem sane for
> lower driver to access it... In fact the next patch in the series
> removes it completely.
>
> Logan

actually, I do think it's ok. about to post review on the next patch

-- james

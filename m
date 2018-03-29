From: logang@deltatee.com (Logan Gunthorpe)
Date: Thu, 29 Mar 2018 10:30:34 -0600
Subject: [PATCH 3/4] nvmet-fc: Don't use the count returned by the
 dma_map_sg call
In-Reply-To: <03cb3610-8ec7-9dc4-9e0a-82f4c30de578@broadcom.com>
References: <20180329160721.4691-1-logang@deltatee.com>
 <20180329160721.4691-4-logang@deltatee.com>
 <03cb3610-8ec7-9dc4-9e0a-82f4c30de578@broadcom.com>
Message-ID: <5ba62675-39b4-6409-5628-c59d8ae048de@deltatee.com>



On 29/03/18 10:24 AM, James Smart wrote:
> Signed-off-by: James Smart? <james.smart at broadcom.com>

Thanks James.

> As for "not used anywhere", be careful as the structure being prepped is 
> passed from the nvme-fc transport to an underlying lldd. So the 
> references would likely be in the lldd.

Can you elaborate? The 'data_sg_cnt' member was in 'struct
nvmet_fc_fcp_iod' which is declared in fc.c so it doesn't seem sane for
lower driver to access it... In fact the next patch in the series
removes it completely.

Logan

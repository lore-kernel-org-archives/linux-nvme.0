From: himanshu.madhani@cavium.com (Himanshu Madhani)
Date: Thu, 9 Nov 2017 21:01:20 -0800 (PST)
Subject: [PATCH v2 1/4] qla2xxx_nvmet: Add files for FC-NVMe Target support
In-Reply-To: <3cf657ee-67a7-1b33-9a79-a0415d7a651b@broadcom.com>
References: <20171109031754.10270-1-himanshu.madhani@cavium.com>
 <20171109031754.10270-2-himanshu.madhani@cavium.com>
 <3cf657ee-67a7-1b33-9a79-a0415d7a651b@broadcom.com>
Message-ID: <alpine.OSX.2.21.1711092053130.44710@n5102mv83lvdv1.qlogic.org>

Hi James,

On Thu, 9 Nov 2017, 7:36am, James Smart wrote:

> On 11/8/2017 7:17 PM, Himanshu Madhani wrote:
> > +static struct nvmet_fc_target_template qla_nvmet_fc_transport = {
> > +	.targetport_delete	= qla_nvmet_targetport_delete,
> > +	.xmt_ls_rsp		= qla_nvmet_ls_rsp,
> > +	.fcp_op			= qla_nvmet_fcp_op,
> > +	.fcp_abort		= qla_nvmet_fcp_abort,
> > +	.fcp_req_release	= qla_nvmet_fcp_req_release,
> > +	.max_hw_queues		= 8,
> > +	.max_sgl_segments	= 128,
> > +	.max_dif_sgl_segments	= 64,
> > +	.dma_boundary		= 0xFFFFFFFF,
> > +	.target_features	= NVMET_FCTGTFEAT_READDATA_RSP |
> > +					NVMET_FCTGTFEAT_CMD_IN_ISR |
> > +					NVMET_FCTGTFEAT_OPDONE_IN_ISR,
> > +	.target_priv_sz	= sizeof(struct nvme_private),
> > +};
> > 
> 
> From the patch set prior:
> > Agree we do nvme_fc* callbacks in deferred context, but without the
> xxx_IN_ISR flag during NVMe Target template registration, we were running into
> crash due to recursive spin_lock held as part of CTIO response in our driver.
> 
> Can you look into removing this recursive spin lock ? ?? I don't think it's a
> good idea to be holding a spin lock when upcalling the transport.
> 

Yes, Will work on removing spin lock. 

> -- james
> 
> 

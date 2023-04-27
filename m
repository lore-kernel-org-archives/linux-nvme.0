Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFA38C77B61
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Apr 2023 21:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=E0Yx9k5q5NTOu2qdJcZNkH6UsRo0NfrqIr1z0uuzdug=; b=TNfXjVo1VX+XU0FuWSwwnNpJsC
	kvx4XN4P9Ea3foOH/B51zBCMvdq9tB+gldqjye34ZUN2js73fm+tnWGLKSmq9bPzHcx9cGFkUomGr
	9CV/FO44YWv+Rip4gKAT1IdpjZ2OSlIcyK0eLGlZO0/6PNvB2V8V09hOPkRaYaK45AuQ3/P5EpDto
	bo6dnSnNCpbXU/SXekuZY7+XANYi826Updx2jMJJj+dB+46XZ6dWK18qe+9JRU9MepViENhDVqryd
	ET7fU3iaWHzFYL3rlWq6qfas9X+1hN43l5Y2s7v9dZ++Mlwuphk5brvApBhw50aWPPFD4hkq5ETli
	hs7CeORg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ps99v-007b8b-1P;
	Thu, 27 Apr 2023 21:28:11 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ps99r-007b7w-3A
	for linux-nvme@lists.infradead.org;
	Thu, 27 Apr 2023 21:28:09 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 3C988639CE;
	Thu, 27 Apr 2023 21:28:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29E0BC433D2;
	Thu, 27 Apr 2023 21:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1682630886;
	bh=VSOfMYWDmzyIMp3ASY9qpW2WmMvAJOHUsKD2HtMBCiA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i7C2YW25aIAKT/LztAW8qz9CGK73ZprUA0bb0cD87QKYSMj4ofzsogJRPZ45JQAcL
	 X8e9J/60c2NtVfeSGCS4BETAveCiELHAMqXH1N9B5jFzQZY2+Shl2CNoc31HcAc2ZE
	 xbb7guHm7Jf1jAWzVcm2yQyA7XN3k92+4ovUpkubpaORpS31jPfrZtZ+49hmk4eyUO
	 QWEzZrVWiJKqdj6WVDg3dzNYZ6H0z2nw/QW1ajhHarWQfqCgRS3gSRtBWFuyr2pKpd
	 264g9QASzsXRJSAB4PVHJwQhkZM/SEKHqbTptneWDzNgNVbMnrwZamlJCfUGD0+M78
	 h5vAEfWjcpV5g==
Date: Thu, 27 Apr 2023 15:28:03 -0600
From: Keith Busch <kbusch@kernel.org>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, kbusch@meta.com, kch@nvidia.com
Subject: Re: [PATCHv2] nvme-fabrics: add queue setup helpers
Message-ID: <ZEro44hLZOiEuOgf@kbusch-mbp.dhcp.thefacebook.com>
References: <20230426150441.595318-1-kbusch@meta.com>
 <dfc32a79-5789-eff9-335f-10373eb05e8c@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dfc32a79-5789-eff9-335f-10373eb05e8c@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230427_142808_098642_0D4C5CCF 
X-CRM114-Status: GOOD (  31.46  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Apr 27, 2023 at 02:05:29AM +0300, Max Gurtovoy wrote:
> 
> 
> On 26/04/2023 18:04, Keith Busch wrote:
> > From: Keith Busch <kbusch@kernel.org>
> > 
> > tcp and rdma transports have lots of duplicate code setting up the
> > different queue mappings. Add common helpers.
> > 
> > Cc: Chaitanya Kulkarni <kch@nvidia.com>
> > Signed-off-by: Keith Busch <kbusch@kernel.org>
> > ---
> > v1->v2:
> > 
> >    Merged up to latest that doesn't have the RDMA specifics
> > 
> >    Simplified io queue count function (Christoph)
> > 
> >    Use 'nvmf_' prefix for function names.
> > 
> >   drivers/nvme/host/fabrics.c | 76 ++++++++++++++++++++++++++++++
> >   drivers/nvme/host/fabrics.h | 11 +++++
> >   drivers/nvme/host/rdma.c    | 79 ++-----------------------------
> >   drivers/nvme/host/tcp.c     | 92 ++-----------------------------------
> >   4 files changed, 96 insertions(+), 162 deletions(-)
> > 
> > diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
> > index bbaa04a0c502b..3ff5030562088 100644
> > --- a/drivers/nvme/host/fabrics.c
> > +++ b/drivers/nvme/host/fabrics.c
> > @@ -957,6 +957,82 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
> >   	return ret;
> >   }
> > +void nvmf_set_io_queues(struct nvmf_ctrl_options *opts, u32 nr_io_queues,
> > +			u32 io_queues[HCTX_MAX_TYPES])
> > +{
> > +	if (opts->nr_write_queues && opts->nr_io_queues < nr_io_queues) {
> > +		/*
> > +		 * separate read/write queues
> > +		 * hand out dedicated default queues only after we have
> > +		 * sufficient read queues.
> > +		 */
> > +		io_queues[HCTX_TYPE_READ] = opts->nr_io_queues;
> > +		nr_io_queues -= io_queues[HCTX_TYPE_READ];
> > +		io_queues[HCTX_TYPE_DEFAULT] =
> > +			min(opts->nr_write_queues, nr_io_queues);
> > +		nr_io_queues -= io_queues[HCTX_TYPE_DEFAULT];
> > +	} else {
> > +		/*
> > +		 * shared read/write queues
> > +		 * either no write queues were requested, or we don't have
> > +		 * sufficient queue count to have dedicated default queues.
> > +		 */
> > +		io_queues[HCTX_TYPE_DEFAULT] =
> > +			min(opts->nr_io_queues, nr_io_queues);
> > +		nr_io_queues -= io_queues[HCTX_TYPE_DEFAULT];
> > +	}
> > +
> > +	if (opts->nr_poll_queues && nr_io_queues) {
> > +		/* map dedicated poll queues only if we have queues left */
> > +		io_queues[HCTX_TYPE_POLL] =
> > +			min(opts->nr_poll_queues, nr_io_queues);
> > +	}
> > +}
> > +EXPORT_SYMBOL_GPL(nvmf_set_io_queues);
> > +
> > +void nvmf_map_queues(struct blk_mq_tag_set *set, struct nvme_ctrl *ctrl,
> > +		     u32 io_queues[HCTX_MAX_TYPES])
> > +{
> > +	struct nvmf_ctrl_options *opts = ctrl->opts;
> > +
> > +	if (opts->nr_write_queues && io_queues[HCTX_TYPE_READ]) {
> > +		/* separate read/write queues */
> > +		set->map[HCTX_TYPE_DEFAULT].nr_queues =
> > +			io_queues[HCTX_TYPE_DEFAULT];
> > +		set->map[HCTX_TYPE_DEFAULT].queue_offset = 0;
> > +		set->map[HCTX_TYPE_READ].nr_queues =
> > +			io_queues[HCTX_TYPE_READ];
> > +		set->map[HCTX_TYPE_READ].queue_offset =
> > +			io_queues[HCTX_TYPE_DEFAULT];
> > +	} else {
> > +		/* shared read/write queues */
> > +		set->map[HCTX_TYPE_DEFAULT].nr_queues =
> > +			io_queues[HCTX_TYPE_DEFAULT];
> > +		set->map[HCTX_TYPE_DEFAULT].queue_offset = 0;
> > +		set->map[HCTX_TYPE_READ].nr_queues =
> > +			io_queues[HCTX_TYPE_DEFAULT];
> > +		set->map[HCTX_TYPE_READ].queue_offset = 0;
> > +	}
> > +
> > +	blk_mq_map_queues(&set->map[HCTX_TYPE_DEFAULT]);
> > +	blk_mq_map_queues(&set->map[HCTX_TYPE_READ]);
> > +	if (opts->nr_poll_queues && io_queues[HCTX_TYPE_POLL]) {
> > +		/* map dedicated poll queues only if we have queues left */
> > +		set->map[HCTX_TYPE_POLL].nr_queues = io_queues[HCTX_TYPE_POLL];
> > +		set->map[HCTX_TYPE_POLL].queue_offset =
> > +			io_queues[HCTX_TYPE_DEFAULT] +
> > +			io_queues[HCTX_TYPE_READ];
> > +		blk_mq_map_queues(&set->map[HCTX_TYPE_POLL]);
> > +	}
> > +
> > +	dev_info(ctrl->device,
> > +		"mapped %d/%d/%d default/read/poll queues.\n",
> > +		io_queues[HCTX_TYPE_DEFAULT],
> > +		io_queues[HCTX_TYPE_READ],
> > +		io_queues[HCTX_TYPE_POLL]);
> > +}
> > +EXPORT_SYMBOL_GPL(nvmf_map_queues);
> > +
> >   static int nvmf_check_required_opts(struct nvmf_ctrl_options *opts,
> >   		unsigned int required_opts)
> >   {
> > diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
> > index dcac3df8a5f76..e438d67a319b5 100644
> > --- a/drivers/nvme/host/fabrics.h
> > +++ b/drivers/nvme/host/fabrics.h
> > @@ -203,6 +203,13 @@ static inline void nvmf_complete_timed_out_request(struct request *rq)
> >   	}
> >   }
> > +static inline unsigned int nvmf_nr_io_queues(struct nvmf_ctrl_options *opts)
> > +{
> > +	return min(opts->nr_io_queues, num_online_cpus()) +
> > +		min(opts->nr_write_queues, num_online_cpus()) +
> > +		min(opts->nr_poll_queues, num_online_cpus());
> > +}
> > +
> >   int nvmf_reg_read32(struct nvme_ctrl *ctrl, u32 off, u32 *val);
> >   int nvmf_reg_read64(struct nvme_ctrl *ctrl, u32 off, u64 *val);
> >   int nvmf_reg_write32(struct nvme_ctrl *ctrl, u32 off, u32 val);
> > @@ -215,5 +222,9 @@ int nvmf_get_address(struct nvme_ctrl *ctrl, char *buf, int size);
> >   bool nvmf_should_reconnect(struct nvme_ctrl *ctrl);
> >   bool nvmf_ip_options_match(struct nvme_ctrl *ctrl,
> >   		struct nvmf_ctrl_options *opts);
> > +void nvmf_set_io_queues(struct nvmf_ctrl_options *opts, u32 nr_io_queues,
> > +			u32 io_queues[HCTX_MAX_TYPES]);
> > +void nvmf_map_queues(struct blk_mq_tag_set *set, struct nvme_ctrl *ctrl,
> > +		     u32 io_queues[HCTX_MAX_TYPES]);
> >   #endif /* _NVME_FABRICS_H */
> > diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> > index 0eb79696fb736..168fdf5e11113 100644
> > --- a/drivers/nvme/host/rdma.c
> > +++ b/drivers/nvme/host/rdma.c
> > @@ -713,18 +713,10 @@ static int nvme_rdma_start_io_queues(struct nvme_rdma_ctrl *ctrl,
> >   static int nvme_rdma_alloc_io_queues(struct nvme_rdma_ctrl *ctrl)
> >   {
> >   	struct nvmf_ctrl_options *opts = ctrl->ctrl.opts;
> > -	struct ib_device *ibdev = ctrl->device->dev;
> > -	unsigned int nr_io_queues, nr_default_queues;
> > -	unsigned int nr_read_queues, nr_poll_queues;
> > +	unsigned int nr_io_queues;
> >   	int i, ret;
> > -	nr_read_queues = min_t(unsigned int, ibdev->num_comp_vectors,
> > -				min(opts->nr_io_queues, num_online_cpus()));
> 
> what about the logic of ibdev->num_comp_vectors in the common code ?

Good catch. This may have more submission contexts that share a
completion vector, and that usually works out better. The existing
code already handles this, but I shouldn't have mixed that functional
change into this patch.

> > -		ctrl->io_queues[HCTX_TYPE_READ] = nr_read_queues;
> > -		nr_io_queues -= ctrl->io_queues[HCTX_TYPE_READ];
> > -		ctrl->io_queues[HCTX_TYPE_DEFAULT] =
> > -			min(nr_default_queues, nr_io_queues);
> > -		nr_io_queues -= ctrl->io_queues[HCTX_TYPE_DEFAULT];
> > -	} else {
> > -		/*
> > -		 * shared read/write queues
> > -		 * either no write queues were requested, or we don't have
> > -		 * sufficient queue count to have dedicated default queues.
> > -		 */
> > -		ctrl->io_queues[HCTX_TYPE_DEFAULT] =
> > -			min(nr_read_queues, nr_io_queues);
> > -		nr_io_queues -= ctrl->io_queues[HCTX_TYPE_DEFAULT];
> 
> I wonder if this is the right time to move io_queues[HCTX_MAX_TYPES] from
> the rdma/pci/tcp controllers to common nvme_ctrl structure and save more
> code.
> I know that fc and loop ctrl don't use it so we can allocate it dynamically.
> WDYT ?

Less duplication is preferred! The pci transport was just harder
to unify with the other two, but it's a good idea.


Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35359CDB466
	for <linux-nvme@archiver.kernel.org>; Sat, 20 Jun 2026 08:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=m2uMxxexDXuJiyEDGdvQW8jMxy4JG/jFpxhsKw2zxso=; b=QYFFPB/muJFreXcGL+nla/5KS2
	Z6gaU9//+scByVP6IoTglwd4Itas1XzEJCXk8bZaOWm5ZGblY/bpwY1LXYmMQlgJWm1+Go+IzdrsL
	5VBfxHahwK0bhoMss3upx71gvPvwUsb25LT08CnF+IR8P0zc0fZxEQ1Ty9HJrpPiQhhs1n5+xxqcY
	3CvKsOa76BhFxx9Z4hCaexcBuF4HyvvLXW9lq58MqIqf+aAzs7YPurBRScWjIO9rxfdndeLLV3z8W
	uhD+APCoE74eZ3ijPV/+SWGaca+Uwq+10ebO3w4vCSHsLc/aFnMmzHpb6oySBZAYnycBqaBuHoBKj
	pBITkKBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1war0w-00000003FI6-2w1P;
	Sat, 20 Jun 2026 08:25:18 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1waexD-00000002v8a-0id1
	for linux-nvme@lists.infradead.org;
	Fri, 19 Jun 2026 19:32:40 +0000
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id 3C65C20B7168; Fri, 19 Jun 2026 12:32:34 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3C65C20B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1781897554;
	bh=m2uMxxexDXuJiyEDGdvQW8jMxy4JG/jFpxhsKw2zxso=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=axv1ytRKW9J9dLaykB85E5RKw778VJTsAnGBgDm54K5ccP6TuM1idVXo84/+eHuA0
	 rEC8iInJgqFqMKMf6s7++kxm8T936/8OoShGjH6mw/Xl4Bb8B3sMcaXsLnzJw+eHpX
	 ZxXYnk/scEgxxjar87N3D8G9YDGhrBnCnlT+j+lw=
Date: Fri, 19 Jun 2026 12:32:34 -0700
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: mkalderon@marvell.com, Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>, zyjzyj2000@gmail.com,
	sagi@grimberg.me, mgurtovoy@nvidia.com, haris.iqbal@ionos.com,
	jinpu.wang@ionos.com, bvanassche@acm.org, kbusch@kernel.org,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	kch@nvidia.com, smfrench@gmail.com, linkinjeon@kernel.org,
	metze@samba.org, tom@talpey.com, trondmy@kernel.org,
	anna@kernel.org, chuck.lever@oracle.com, jlayton@kernel.org,
	neil@brown.name, okorniev@redhat.com, Dai.Ngo@oracle.com,
	achender@kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	kees@kernel.org, ebadger@purestorage.com,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	target-devel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
	linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
	rds-devel@oss.oracle.com, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH rdma-next v7] RDMA: Change capability fields in
 ib_device_attr from int to u32
Message-ID: <ajWZUjSoUCTe0Pb7@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260606070735.2163063-1-ernis@linux.microsoft.com>
 <aigwONAwxQx6rLef@ashevche-desk.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aigwONAwxQx6rLef@ashevche-desk.local>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260619_123239_268085_E4D88E39 
X-CRM114-Status: GOOD (  28.07  )
X-Mailman-Approved-At: Sat, 20 Jun 2026 01:25:13 -0700
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

Hi Andy,

Sorry for delayed response.

> >  	attr->max_qp_init_rd_atom =
> >  	    1 << (fls(qattr->max_qp_req_rd_atomic_resc) - 1);
> 
> FWIW, this one and below looks like reinvention of rounddown_pow_of_two().

Acked.
> 
> >  	attr->max_qp_rd_atom =
> > -	    min(1 << (fls(qattr->max_qp_resp_rd_atomic_resc) - 1),
> > +	    min(1U << (fls(qattr->max_qp_resp_rd_atomic_resc) - 1),
> >  		attr->max_qp_init_rd_atom);
> 
> ...
> 
> >  int ipoib_cm_dev_init(struct net_device *dev)
> >  {
> >  	struct ipoib_dev_priv *priv = ipoib_priv(dev);
> > -	int max_srq_sge, i;
> > +	int i;
> > +	u32 max_srq_sge;
> >  	u8 addr;
> 
> It seems the order is reversed xmas tree, why not preserving it?
> 
Right. I'll fix it in the next version.
> ...
> 
> > --- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> > +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> 
> >  		max_send_wr =
> > -			min_t(int, wr_limit, SERVICE_CON_QUEUE_DEPTH * 2 + 2);
> > +			min(wr_limit, SERVICE_CON_QUEUE_DEPTH * 2 + 2);
> 
> Now perfectly a single line
> 
> 		max_send_wr = min(wr_limit, SERVICE_CON_QUEUE_DEPTH * 2 + 2);
> 
> >  		max_recv_wr = max_send_wr;
> 
> ...
> 
> > -		max_send_wr = min_t(int, wr_limit,
> > -			      /* QD * (REQ + RSP + FR REGS or INVS) + drain */
> > -			      clt_path->queue_depth * 4 + 1);
> > -		max_recv_wr = min_t(int, wr_limit,
> > -			      clt_path->queue_depth * 3 + 1);
> > +		max_send_wr = min_t(u32, wr_limit,
> > +				    /* QD * (REQ + RSP + FR REGS or INVS) + drain */
> > +				    clt_path->queue_depth * 4 + 1);
> > +		max_recv_wr = min_t(u32, wr_limit,
> > +				    clt_path->queue_depth * 3 + 1);
> 
> Can we rather update the type of one of them and use min() instead?
> 
I'll remove all the min_t usages in the next version.
> ...
> 
> > --- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> 
> Ditto.
> 
> ...
> 
> > -static int srpt_srq_size = DEFAULT_SRPT_SRQ_SIZE;
> > -module_param(srpt_srq_size, int, 0444);
> > +static unsigned int srpt_srq_size = DEFAULT_SRPT_SRQ_SIZE;
> > +module_param(srpt_srq_size, uint, 0444);
> 
> Theoretically this might break ABI (if somebody uses negative values for
> anything. I don't think it's the case, but just be informed.
> 
Okay. Thankyou for the information. 

> >  MODULE_PARM_DESC(srpt_srq_size,
> >  		 "Shared receive queue (SRQ) size.");
> 
> ...
> 
> > --- a/drivers/nvme/target/rdma.c
> > +++ b/drivers/nvme/target/rdma.c
> 
> > -	ndev->srq_size = min(ndev->device->attrs.max_srq_wr,
> > -			     nvmet_rdma_srq_size);
> > -	ndev->srq_count = min(ndev->device->num_comp_vectors,
> > -			      ndev->device->attrs.max_srq);
> > +	ndev->srq_size = min_t(u32, ndev->device->attrs.max_srq_wr,
> > +			       nvmet_rdma_srq_size);
> > +	ndev->srq_count = min_t(u32, ndev->device->num_comp_vectors,
> > +				ndev->device->attrs.max_srq);
> 
> Same question, can we change type type of variables instead?
>
Yes. I'll be doing it in the next version.
 
> >  	mutex_lock(&device_list_mutex);
> 
> ...
> 
> >  	inline_page_count = num_pages(nport->inline_data_size);
> >  	inline_sge_count = max(cm_id->device->attrs.max_sge_rd,
> > -				cm_id->device->attrs.max_recv_sge) - 1;
> > +				cm_id->device->attrs.max_recv_sge);
> > +	inline_sge_count = inline_sge_count ? inline_sge_count - 1 : 0;
> 
> Simple conditional might be better
> 
> 	if (inline_sge_count)
> 		inline_sge_count--;
> 	OR
> 		inline_sge_count -= 1;
Okay. I'll update all such instances.

> 
> ...
> 
> > +++ b/include/rdma/ib_verbs.h
> 
> > -	int			max_qp;
> > -	int			max_qp_wr;
> > +	u32			max_qp;
> > +	u32			max_qp_wr;
> 
> Nice, but please check that none of these (and beyond) were not used in signed
> multiplication or (which is more disasterous) division. Otherwise it might be
> subtle issues that will be hard to debug.
Yes I have checked that for all the variables I updated.

> 
> ...
> 
> >  	conn_param->responder_resources =
> > -		min_t(u32, rds_ibdev->max_responder_resources, max_responder_resources);
> > +		min3(rds_ibdev->max_responder_resources,
> > +		     max_responder_resources, U8_MAX);
> >  	conn_param->initiator_depth =
> > -		min_t(u32, rds_ibdev->max_initiator_depth, max_initiator_depth);
> > +		min3(rds_ibdev->max_initiator_depth,
> > +		     max_initiator_depth, U8_MAX);
> 
> I believe we can go a few characters over and leave them to be single lines.
> 
Okay.

> >  	conn_param->retry_count = min_t(unsigned int, rds_ib_retry_count, 7);
> 
> What about this one?
Sorry. I missed this one, I'll update it.

> 
> >  	conn_param->rnr_retry_count = 7;
> 
> ...
> 
> >  int frwr_query_device(struct rpcrdma_ep *ep, const struct ib_device *device)
> >  {
> >  	const struct ib_device_attr *attrs = &device->attrs;
> > -	int max_qp_wr, depth, delta;
> > +	u32 max_qp_wr;
> > +	int depth, delta;
> >  	unsigned int max_sge;
> 
> Reversed xmas tree order.
Okay

Thankyou for all your suggestions.
The next version will be incorporated with all these changes.

- Vennela
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 


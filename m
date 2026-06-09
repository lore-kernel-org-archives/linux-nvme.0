Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E86A9CD8CB9
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Jun 2026 15:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=X5TMfAA7V17x9U/1nN0/lFxbm0dyS/yHCkB0RPgUlno=; b=IwOJarNROarcX2Ub/x1VXrex3R
	CHsFWB8bU9RTDPfrD/6L2wTroYjWTSys6Y0sjR7TNDbaM5DTsKT7+rf/qUnk3tSNrLOv5BuHLRaZZ
	7BvGR8NDSNwHoSaLclNIAwghJPx6TOmU2Qp2H4EOVcmNBM6eT+iEjEZ5q9kg5Kt/6KWxbGQTkj49G
	mX2vwmDxtaJKu5v/RuNjlzh11CsTCd5WvQXVs7oXY7ZGvYXjhrbE+/2d4gTKB+DdANXgVn8YwNRb+
	4AJqmuBrRZjCLjIMS1h3aZyMzV4QZpdksAn+7Ql74P5E4/QkPnmSvTLL25GSQ9E1+dL8IOn6mAYZc
	zz0OMJ2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWyps-00000005z1I-1O4a;
	Tue, 09 Jun 2026 15:57:52 +0000
Received: from mgamail.intel.com ([192.198.163.13])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWyJw-00000005uJZ-1bzD
	for linux-nvme@lists.infradead.org;
	Tue, 09 Jun 2026 15:24:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781018692; x=1812554692;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HBoPFGOXGybi9zPjNvhBs4GVWkRnbZRL7P47phF5uJE=;
  b=O2FJgSr/+ovNW0pT4PHJD2nPi+koS1+JUt5eWEc/eY49lToABTOUEbyC
   9yRPH4SY7qUhwayGnaq5KVjXZ/tkmGnYJ5nvKKO0iv5S2HK8nG89t+HXj
   4kgpCkz0fWOpDKmBuboy7lhUwcOFS8m5Q/Z9WBU/TeLwJPTvDxDPx60r7
   vZTd9EvVZbSxW9Z/4jibTXJ8e76D10iDrzSwfDzqks4DyM4KENmK3NUAy
   xSAlEatRXXP6Qd01aKWxe/O3IML8Zrusd4aAS8vRojN7JHALwBfL6ulfT
   RS5HibDFjvQc9kL/GnBFQXZvjtu129i5Bz9l8XT9LBp7kd2ncc+FtRXRn
   w==;
X-CSE-ConnectionGUID: Ijs/wHGEQp+t+U1pYryQhA==
X-CSE-MsgGUID: SxXLhZehQFWfTP3F19FDBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="84352289"
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="84352289"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 08:24:51 -0700
X-CSE-ConnectionGUID: SIFLfa6ORfeM1YV6G9lz1g==
X-CSE-MsgGUID: 6n6rabJGS8qCw/q/3/ezcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="247759332"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.162])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 08:24:42 -0700
Date: Tue, 9 Jun 2026 18:24:40 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
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
Message-ID: <aigwONAwxQx6rLef@ashevche-desk.local>
References: <20260606070735.2163063-1-ernis@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260606070735.2163063-1-ernis@linux.microsoft.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260609_082452_440474_50BDAA48 
X-CRM114-Status: GOOD (  21.56  )
X-Mailman-Approved-At: Tue, 09 Jun 2026 08:57:50 -0700
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

On Sat, Jun 06, 2026 at 12:07:15AM -0700, Erni Sri Satya Vennela wrote:
> The capability counter fields in struct ib_device_attr are declared
> as signed int, but these values are inherently non-negative. Drivers
> maintain their cached caps as u32 and assign them directly into these
> int fields; if a cap exceeds INT_MAX the implicit narrowing yields a
> negative value visible to the IB core.
> 
> Change the signed int capability fields to u32 to match the
> underlying nature of the data. Also update consumers across the IB
> core, ULPs, NVMe-oF target, RDS, and NFS/RDMA so the new u32 values
> are not forced back through signed int or u8 via min()/min_t() or
> narrowing local variables.

...

>  	attr->max_qp_init_rd_atom =
>  	    1 << (fls(qattr->max_qp_req_rd_atomic_resc) - 1);

FWIW, this one and below looks like reinvention of rounddown_pow_of_two().

>  	attr->max_qp_rd_atom =
> -	    min(1 << (fls(qattr->max_qp_resp_rd_atomic_resc) - 1),
> +	    min(1U << (fls(qattr->max_qp_resp_rd_atomic_resc) - 1),
>  		attr->max_qp_init_rd_atom);

...

>  int ipoib_cm_dev_init(struct net_device *dev)
>  {
>  	struct ipoib_dev_priv *priv = ipoib_priv(dev);
> -	int max_srq_sge, i;
> +	int i;
> +	u32 max_srq_sge;
>  	u8 addr;

It seems the order is reversed xmas tree, why not preserving it?

...

> --- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c

>  		max_send_wr =
> -			min_t(int, wr_limit, SERVICE_CON_QUEUE_DEPTH * 2 + 2);
> +			min(wr_limit, SERVICE_CON_QUEUE_DEPTH * 2 + 2);

Now perfectly a single line

		max_send_wr = min(wr_limit, SERVICE_CON_QUEUE_DEPTH * 2 + 2);

>  		max_recv_wr = max_send_wr;

...

> -		max_send_wr = min_t(int, wr_limit,
> -			      /* QD * (REQ + RSP + FR REGS or INVS) + drain */
> -			      clt_path->queue_depth * 4 + 1);
> -		max_recv_wr = min_t(int, wr_limit,
> -			      clt_path->queue_depth * 3 + 1);
> +		max_send_wr = min_t(u32, wr_limit,
> +				    /* QD * (REQ + RSP + FR REGS or INVS) + drain */
> +				    clt_path->queue_depth * 4 + 1);
> +		max_recv_wr = min_t(u32, wr_limit,
> +				    clt_path->queue_depth * 3 + 1);

Can we rather update the type of one of them and use min() instead?

...

> --- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c

Ditto.

...

> -static int srpt_srq_size = DEFAULT_SRPT_SRQ_SIZE;
> -module_param(srpt_srq_size, int, 0444);
> +static unsigned int srpt_srq_size = DEFAULT_SRPT_SRQ_SIZE;
> +module_param(srpt_srq_size, uint, 0444);

Theoretically this might break ABI (if somebody uses negative values for
anything. I don't think it's the case, but just be informed.

>  MODULE_PARM_DESC(srpt_srq_size,
>  		 "Shared receive queue (SRQ) size.");

...

> --- a/drivers/nvme/target/rdma.c
> +++ b/drivers/nvme/target/rdma.c

> -	ndev->srq_size = min(ndev->device->attrs.max_srq_wr,
> -			     nvmet_rdma_srq_size);
> -	ndev->srq_count = min(ndev->device->num_comp_vectors,
> -			      ndev->device->attrs.max_srq);
> +	ndev->srq_size = min_t(u32, ndev->device->attrs.max_srq_wr,
> +			       nvmet_rdma_srq_size);
> +	ndev->srq_count = min_t(u32, ndev->device->num_comp_vectors,
> +				ndev->device->attrs.max_srq);

Same question, can we change type type of variables instead?

>  	mutex_lock(&device_list_mutex);

...

>  	inline_page_count = num_pages(nport->inline_data_size);
>  	inline_sge_count = max(cm_id->device->attrs.max_sge_rd,
> -				cm_id->device->attrs.max_recv_sge) - 1;
> +				cm_id->device->attrs.max_recv_sge);
> +	inline_sge_count = inline_sge_count ? inline_sge_count - 1 : 0;

Simple conditional might be better

	if (inline_sge_count)
		inline_sge_count--;
	OR
		inline_sge_count -= 1;

...

> +++ b/include/rdma/ib_verbs.h

> -	int			max_qp;
> -	int			max_qp_wr;
> +	u32			max_qp;
> +	u32			max_qp_wr;

Nice, but please check that none of these (and beyond) were not used in signed
multiplication or (which is more disasterous) division. Otherwise it might be
subtle issues that will be hard to debug.

...

>  	conn_param->responder_resources =
> -		min_t(u32, rds_ibdev->max_responder_resources, max_responder_resources);
> +		min3(rds_ibdev->max_responder_resources,
> +		     max_responder_resources, U8_MAX);
>  	conn_param->initiator_depth =
> -		min_t(u32, rds_ibdev->max_initiator_depth, max_initiator_depth);
> +		min3(rds_ibdev->max_initiator_depth,
> +		     max_initiator_depth, U8_MAX);

I believe we can go a few characters over and leave them to be single lines.

>  	conn_param->retry_count = min_t(unsigned int, rds_ib_retry_count, 7);

What about this one?

>  	conn_param->rnr_retry_count = 7;

...

>  int frwr_query_device(struct rpcrdma_ep *ep, const struct ib_device *device)
>  {
>  	const struct ib_device_attr *attrs = &device->attrs;
> -	int max_qp_wr, depth, delta;
> +	u32 max_qp_wr;
> +	int depth, delta;
>  	unsigned int max_sge;

Reversed xmas tree order.

-- 
With Best Regards,
Andy Shevchenko




Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 538F1C678D4
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Jan 2023 12:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4w4GrNcMLeNevgVDWRB70raMzwdSCZGmUe0GbeDFnys=; b=c2ai+G3Zyhmbal/Y2IutAJxDOU
	WWm5a9+WskuySct42c+RsqCWR9nvceD/fxEFnuskPc1bhCEDDJBRpxrUPrOK+dg+hiRxc6jVcnqfB
	lAXftqMZBLVXpBwZcwN0koyug+aQ9ZA5D8akm72Pj884VouUUQp2bTvAIFisaTJwWFqAgW2OCOYcQ
	I3DdyhdIatw8yqYwz4UOybB6I04gV9X48GNa0/EZqUN2TNpt9iV4k0zRfHwBnnQXiBqup0s8QCgHQ
	uaY1QKjJE8QtDlaiaG0XxMbqGaW68miJD33Tqagxy+dJoAc9fF2ZArh6ukSCLfHgjsJmdJ9/lt/3u
	DNzkjjww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pHkgR-00E7Pg-7O; Tue, 17 Jan 2023 12:03:19 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pHkgO-00E7P2-NC
	for linux-nvme@lists.infradead.org; Tue, 17 Jan 2023 12:03:18 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.source.kernel.org (Postfix) with ESMTPS id B4A8DCE1360;
	Tue, 17 Jan 2023 12:03:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E677C433D2;
	Tue, 17 Jan 2023 12:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1673956993;
	bh=93tzp+RSOFf3+k4VJuc6vDivUrGEcUxrSIufHOvJ2kk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=of5w9Xji5VNt/i6LxdxPZcYFz/Uw2hYN4b1Dd1rF2g8GNW0eiNQDJ+Y8y1aEEeE/a
	 NYxCsYslSsLRlIH33cntH+tV20HVHqrJQC/0Q1VBorj/mqOH7yHvAPVNLBD4TnP8bX
	 kSdSUi++Jh+XfjjAEcozg0vsEg+6lVk8BcOg+BxODigDLV6JzXKuIWJpSrNS1ZvgsF
	 0kfgA+p4Oo3b3+EprhLqWQjlKdQwvR4bGaaB6nGu9tfws4+mG4rXxdh75g16JMVJtM
	 FEt2NMAXwJ6dD8alBSLP5SfCNjN1jeHTEg7dJD/Bz3ND9ClbQIwMvdb/UolK6yOVRb
	 LFVB1lvT2qqdw==
Date: Tue, 17 Jan 2023 14:03:07 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Israel Rukshin <israelr@nvidia.com>, Bryan Tan <bryantan@vmware.com>,
	Christoph Hellwig <hch@lst.de>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Jens Axboe <axboe@fb.com>,
	Keith Busch <kbusch@kernel.org>, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Max Gurtovoy <mgurtovoy@nvidia.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Vishnu Dasa <vdasa@vmware.com>, Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH rdma-next 03/13] RDMA: Split kernel-only create QP flags
 from uverbs create QP flags
Message-ID: <Y8aOe68Q49lvsjv8@unreal>
References: <cover.1673873422.git.leon@kernel.org>
 <6e46859a58645d9f16a63ff76592487aabc9971d.1673873422.git.leon@kernel.org>
 <Y8WL2gQqqeZdMvr6@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8WL2gQqqeZdMvr6@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230117_040317_114696_557C6E9F 
X-CRM114-Status: GOOD (  20.20  )
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

On Mon, Jan 16, 2023 at 01:39:38PM -0400, Jason Gunthorpe wrote:
> On Mon, Jan 16, 2023 at 03:05:50PM +0200, Leon Romanovsky wrote:
> 
> > diff --git a/drivers/infiniband/hw/mlx4/mlx4_ib.h b/drivers/infiniband/hw/mlx4/mlx4_ib.h
> > index 17fee1e73a45..c553bf0eb257 100644
> > --- a/drivers/infiniband/hw/mlx4/mlx4_ib.h
> > +++ b/drivers/infiniband/hw/mlx4/mlx4_ib.h
> > @@ -184,7 +184,7 @@ enum mlx4_ib_qp_flags {
> >  	/* Mellanox specific flags start from IB_QP_CREATE_RESERVED_START */
> >  	MLX4_IB_ROCE_V2_GSI_QP = MLX4_IB_QP_CREATE_ROCE_V2_GSI,
> >  	MLX4_IB_SRIOV_TUNNEL_QP = 1 << 30,
> > -	MLX4_IB_SRIOV_SQP = 1 << 31,
> > +	MLX4_IB_SRIOV_SQP = 1ULL << 31,
> >  };
> 
> These should be moved to a uapi if we are saying they are userspace
> available
> 
> But I'm not sure they are?

I don't think so.

> 
> 
> > diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
> > index 949cf4ffc536..cc2ddd4e6c12 100644
> > --- a/include/rdma/ib_verbs.h
> > +++ b/include/rdma/ib_verbs.h
> > @@ -1140,16 +1140,15 @@ enum ib_qp_type {
> >  	IB_QPT_RESERVED10,
> >  };
> >  
> > +/*
> > + * bits 0, 5, 6 and 7 may be set by old kernels and should not be used.
> > + */
> 
> This is backwards "bits 0 5 6 7 were understood by older kernels and
> should not be used"

will change

> 
> >  enum ib_qp_create_flags {
> > -	IB_QP_CREATE_IPOIB_UD_LSO		= 1 << 0,
> >  	IB_QP_CREATE_BLOCK_MULTICAST_LOOPBACK	=
> >  		IB_UVERBS_QP_CREATE_BLOCK_MULTICAST_LOOPBACK,
> >  	IB_QP_CREATE_CROSS_CHANNEL              = 1 << 2,
> >  	IB_QP_CREATE_MANAGED_SEND               = 1 << 3,
> >  	IB_QP_CREATE_MANAGED_RECV               = 1 << 4,
> > -	IB_QP_CREATE_NETIF_QP			= 1 << 5,
> > -	IB_QP_CREATE_INTEGRITY_EN		= 1 << 6,
> > -	IB_QP_CREATE_NETDEV_USE			= 1 << 7,
> >  	IB_QP_CREATE_SCATTER_FCS		=
> >  		IB_UVERBS_QP_CREATE_SCATTER_FCS,
> >  	IB_QP_CREATE_CVLAN_STRIPPING		=
> > @@ -1159,7 +1158,18 @@ enum ib_qp_create_flags {
> >  		IB_UVERBS_QP_CREATE_PCI_WRITE_END_PADDING,
> >  	/* reserve bits 26-31 for low level drivers' internal use */
> >  	IB_QP_CREATE_RESERVED_START		= 1 << 26,
> > -	IB_QP_CREATE_RESERVED_END		= 1 << 31,
> > +	IB_QP_CREATE_RESERVED_END		= 1ULL << 31,
> 
> And these should be shifted to the uapi header

No problem.

> 
> Jason


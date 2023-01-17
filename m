Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9210AC3DA78
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Jan 2023 14:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9G04BlsRTvWBD3WDr4oHUNL5pxIkJYG4Kt9INTqGLQI=; b=oflc16p2i8bYAVx92BIPsLwhpk
	ILnrSl40TB+qv93Hjf6bciPJEIYZ+qRHwd3FeEqAfv3Osf74EEtKl1Js0jACgkoT+uAyHjcBZMnc/
	tuAlV74Xep+7KZM8QWbKYvfnOFwOIOwsFV+eultRR4+67Xr4J1z5KxBmCpX10KtZbZ4YiD/zm90dH
	/+T8CjIgtkrm/7o0xpOuNta6wpmBPkpCKonBujbImoreti0RGIozf3IqxAkc3rad7+SKtEW8Y8NtX
	LsDEQIgydgXCHYkBDYjhIiFxUFkSa/w1GpD1Am5jilSRAUXiOyb4+hVReWZMqetSGotvt6MqAUe7L
	a5VKk1TA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pHn2e-00Edqe-Bv; Tue, 17 Jan 2023 14:34:24 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pHn2c-00Edph-6z
	for linux-nvme@lists.infradead.org; Tue, 17 Jan 2023 14:34:23 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id B720E6147C;
	Tue, 17 Jan 2023 14:34:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86555C433EF;
	Tue, 17 Jan 2023 14:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1673966061;
	bh=Fz/P1XZDGupDtqAJSEnp0rEfUZAKbWxcCPbBc58E86o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zd/8A4ZSHTYkosiDKj1TO0FVHt7VXMMtyD28nA+OIKNWV0uToO4VZUsV04f+85zsK
	 NPAqR1E4a1Q0CqivGIOi81y5puPNQKSjGzt83iuk9+arxT2fS1FYGXhGrqyY0pos+Z
	 OcLCxPp7ys9ubCVCxeMxzYmYNy77ccvTqq24OSgfB3I1ANleDm9EcAC5SJFVPc92BV
	 82ZrOmcDrcd12x/w57ND2bTpnoX2P/SLRY7hVBHhu05Shda5VwcyAjC1oJ0Zq2EiV+
	 jmFS5CVk+gGXWQSHF1NbuqizTD6yrXxEWa4GU13nqxj7Wk2j8qhBhnUxjl4nGJ/QXE
	 mk7N0mBa6Ynxg==
Date: Tue, 17 Jan 2023 16:34:17 +0200
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
Message-ID: <Y8ax6ZD6hhyD41pA@unreal>
References: <cover.1673873422.git.leon@kernel.org>
 <6e46859a58645d9f16a63ff76592487aabc9971d.1673873422.git.leon@kernel.org>
 <Y8WL2gQqqeZdMvr6@nvidia.com>
 <Y8aOe68Q49lvsjv8@unreal>
 <Y8anaBBZDOGF471q@nvidia.com>
 <Y8atPjQ1x75tBdib@unreal>
 <Y8au3ni8NVBPI5hu@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8au3ni8NVBPI5hu@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230117_063422_347179_4A89C980 
X-CRM114-Status: GOOD (  25.38  )
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

On Tue, Jan 17, 2023 at 10:21:18AM -0400, Jason Gunthorpe wrote:
> On Tue, Jan 17, 2023 at 04:14:22PM +0200, Leon Romanovsky wrote:
> > On Tue, Jan 17, 2023 at 09:49:28AM -0400, Jason Gunthorpe wrote:
> > > On Tue, Jan 17, 2023 at 02:03:07PM +0200, Leon Romanovsky wrote:
> > > > On Mon, Jan 16, 2023 at 01:39:38PM -0400, Jason Gunthorpe wrote:
> > > > > On Mon, Jan 16, 2023 at 03:05:50PM +0200, Leon Romanovsky wrote:
> > > > > 
> > > > > > diff --git a/drivers/infiniband/hw/mlx4/mlx4_ib.h b/drivers/infiniband/hw/mlx4/mlx4_ib.h
> > > > > > index 17fee1e73a45..c553bf0eb257 100644
> > > > > > --- a/drivers/infiniband/hw/mlx4/mlx4_ib.h
> > > > > > +++ b/drivers/infiniband/hw/mlx4/mlx4_ib.h
> > > > > > @@ -184,7 +184,7 @@ enum mlx4_ib_qp_flags {
> > > > > >  	/* Mellanox specific flags start from IB_QP_CREATE_RESERVED_START */
> > > > > >  	MLX4_IB_ROCE_V2_GSI_QP = MLX4_IB_QP_CREATE_ROCE_V2_GSI,
> > > > > >  	MLX4_IB_SRIOV_TUNNEL_QP = 1 << 30,
> > > > > > -	MLX4_IB_SRIOV_SQP = 1 << 31,
> > > > > > +	MLX4_IB_SRIOV_SQP = 1ULL << 31,
> > > > > >  };
> > > > > 
> > > > > These should be moved to a uapi if we are saying they are userspace
> > > > > available
> > > > > 
> > > > > But I'm not sure they are?
> > > > 
> > > > I don't think so.
> > > 
> > > Then they should be > 32 bits right?
> > 
> > Right now, they are in reserved range:
> >         /* reserve bits 26-31 for low level drivers' internal use */
> >         IB_QP_CREATE_RESERVED_START             = 1 << 26,
> >         IB_QP_CREATE_RESERVED_END               = 1ULL << 31,
> > 
> > If we move them to kernel part, we will need to define reserved range
> > there too. So we just "burn" extra bits just for mlx4, also I don't see
> > any reason to promote mlx4 bits to be general ones.
> 
> Is the reserved range kernel only? It would be nice to clarify that
> detail
> 
> If yes we should move it so that userspace cannot set it. Do we have a
> bug here already?

No, we always checked that users can't provide these bits and fail create QP.

It means that we can safely move that range too.

Thanks

> 
> Jason


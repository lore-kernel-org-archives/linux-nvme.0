Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E9DCC3DA78
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Jan 2023 14:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dPFvhUAmz0OtjCyEF/VFygEs8x9aA6iulMlgM06Ia84=; b=MXL/1FyzZtdL2zkXLF7czZWSA5
	wIbKzLPnC16Q2vINKvU9y4grjobFd6g3fUbVgAYHiu2cvtxJuN/dtv77GL7aVjFSgmrWqXwTsdG+J
	Dso6Rzfv9jVOn0R2Nnj78apUh4Fiszq4gG95UQOttGBz77aB1FjOpeOku4aC5gNpUp86b9yW+UdU0
	s//xjtw7txLEkWph6ZfUwNxjF4kg0fl+TqGANje475yz7TOn/5gomOzmKEJ94K/+hs1bbLOjlBWMU
	DIJTE7pQNEY2iejQXaLvmw4FFjZFkJvMxqCtNlrueXOxG6MH3Bi/A0JlsrwEcJcWfRXyEZiBthrQE
	+ERrHyZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pHmjQ-00EZVf-4k; Tue, 17 Jan 2023 14:14:32 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pHmjN-00EZUT-M1
	for linux-nvme@lists.infradead.org; Tue, 17 Jan 2023 14:14:31 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.source.kernel.org (Postfix) with ESMTPS id F256CCE1392;
	Tue, 17 Jan 2023 14:14:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2B4BC433D2;
	Tue, 17 Jan 2023 14:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1673964866;
	bh=oO6yTThzMkNKYiBtaWdm5Lzb8UxNpLOg1Jp0NdlEpAY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H7za2Vaq0l6xcNEV0SarMt/DnMBLCzeBWWHimgfSvI2ImwcbagaDOKiGoYjIiVBn2
	 Z5/XYNfZU0JPPb5lQk9Fyqx3urt7Z2rVUrJIrDl3SwLQ675XBE66cmf/6EaOs2Bfwy
	 YDS/ocT+Z2a0yNJKgZyHAD1NwgcBptZIwjtCrGqY0QlxkBtjqN+NVcWibOoDKYrV21
	 HO3Fy2Oxv8suZVnjpwcLAzWp+8wz57WX6dw1iyjFG+85UVZpuAi+TwcjOte50kjEDw
	 I1qmrajJrx7UtP5YnXQFOm2l/gT5fh0RLuTYHRhbhKshd1vTmU43lOWdH+f/4/6aHs
	 g78xEoge90KtQ==
Date: Tue, 17 Jan 2023 16:14:22 +0200
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
Message-ID: <Y8atPjQ1x75tBdib@unreal>
References: <cover.1673873422.git.leon@kernel.org>
 <6e46859a58645d9f16a63ff76592487aabc9971d.1673873422.git.leon@kernel.org>
 <Y8WL2gQqqeZdMvr6@nvidia.com>
 <Y8aOe68Q49lvsjv8@unreal>
 <Y8anaBBZDOGF471q@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8anaBBZDOGF471q@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230117_061429_926496_126ABD34 
X-CRM114-Status: GOOD (  20.06  )
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

On Tue, Jan 17, 2023 at 09:49:28AM -0400, Jason Gunthorpe wrote:
> On Tue, Jan 17, 2023 at 02:03:07PM +0200, Leon Romanovsky wrote:
> > On Mon, Jan 16, 2023 at 01:39:38PM -0400, Jason Gunthorpe wrote:
> > > On Mon, Jan 16, 2023 at 03:05:50PM +0200, Leon Romanovsky wrote:
> > > 
> > > > diff --git a/drivers/infiniband/hw/mlx4/mlx4_ib.h b/drivers/infiniband/hw/mlx4/mlx4_ib.h
> > > > index 17fee1e73a45..c553bf0eb257 100644
> > > > --- a/drivers/infiniband/hw/mlx4/mlx4_ib.h
> > > > +++ b/drivers/infiniband/hw/mlx4/mlx4_ib.h
> > > > @@ -184,7 +184,7 @@ enum mlx4_ib_qp_flags {
> > > >  	/* Mellanox specific flags start from IB_QP_CREATE_RESERVED_START */
> > > >  	MLX4_IB_ROCE_V2_GSI_QP = MLX4_IB_QP_CREATE_ROCE_V2_GSI,
> > > >  	MLX4_IB_SRIOV_TUNNEL_QP = 1 << 30,
> > > > -	MLX4_IB_SRIOV_SQP = 1 << 31,
> > > > +	MLX4_IB_SRIOV_SQP = 1ULL << 31,
> > > >  };
> > > 
> > > These should be moved to a uapi if we are saying they are userspace
> > > available
> > > 
> > > But I'm not sure they are?
> > 
> > I don't think so.
> 
> Then they should be > 32 bits right?

Right now, they are in reserved range:
        /* reserve bits 26-31 for low level drivers' internal use */
        IB_QP_CREATE_RESERVED_START             = 1 << 26,
        IB_QP_CREATE_RESERVED_END               = 1ULL << 31,

If we move them to kernel part, we will need to define reserved range
there too. So we just "burn" extra bits just for mlx4, also I don't see
any reason to promote mlx4 bits to be general ones.

Thanks

> 
> Jason


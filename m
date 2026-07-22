Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66F08C44533
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Jul 2026 08:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kTGdLX16bo8iVm3g9g7XqDAnJcp6Rzf7D/QzQvQy9bY=; b=4ujy/wBvzHkEXx4BUzzH4mZB1A
	MYCzO4QIojuzvIHm6YcmgzDp0fHBQXFIA+R23U7ceqwZW0wsHIa0izb0OMFX2NUNbuk5gx000j9UK
	FqDjT7jn6DC1JDeto4mxkqmSyv+0Nf590wSqgaitgvkWdwnkcTE/fkyMvnBxlRASu5gD4758Mo83q
	zWprxHNNWqpUe3Ln3t5hBBn22F8uYyBcELROho66fYGnS3uj/H0NcjpQBkGZk2DFMzoBO+1A/kk6n
	X5h/fuBNMyBsNbRPvWnw0o4gFCiiomLzN1t65MmdLs/rBJMcpyoA8KtopW1KsZbkIG6WeRxBPZmGD
	s23CCKjQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmSLQ-0000000BFyU-1Iij;
	Wed, 22 Jul 2026 08:30:24 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmSLP-0000000BFyO-0pRT
	for linux-nvme@lists.infradead.org;
	Wed, 22 Jul 2026 08:30:23 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 8F44C60A65;
	Wed, 22 Jul 2026 08:30:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 492961F000E9;
	Wed, 22 Jul 2026 08:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784709022;
	bh=kTGdLX16bo8iVm3g9g7XqDAnJcp6Rzf7D/QzQvQy9bY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=c3U4Dn6FXm6Z2/Xe+nb6iDzx39x6EF1Mw6cmVB7YcbX/pInD9l+x3M0fFblcDpZDA
	 RbXy35YTvnUK+vac9p1wMIKLwdLlgEMJfl+RQXzIqzL5VGi3Dpoqq5lonbiHoEHjb5
	 Nj7RyuQ4B+aFJHkpGEnv/eXddDGKOAoHGE6fIZzl/rKsOvljJCFZ2Uztre88YxLimp
	 rHdo/AJxTYpo/5VQXbvtARB2HHr/MZinjUCXJxody7h1a+LZuJ92cLWNLPbTbxJz9Y
	 7rk11xNdjm56wPPR0CMXi2re6Ib3H+OpKmNKfVjaBD7rLWfwzXyog2xtGtAXoUGiwJ
	 1ZD1muz4BbEGg==
Date: Wed, 22 Jul 2026 11:30:15 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Mykola Marzhan <mykola@meshstor.io>, Jens Axboe <axboe@kernel.dk>,
	Song Liu <song@kernel.org>, Yu Kuai <yukuai@fygo.io>,
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
	linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org,
	Li Nan <magiclinan@didiglobal.com>, Xiao Ni <xiao@kernel.org>,
	Guoqing Jiang <guoqing.jiang@linux.dev>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kiran Kumar Modukuri <kmodukuri@nvidia.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shivaji Kant <shivajikant@google.com>,
	Pranjal Shrivastava <praan@google.com>,
	Henrique Carvalho <henrique.carvalho@suse.com>,
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 6/7] md/raid1,raid10: skip futile retries on P2PDMA
 mapping failures
Message-ID: <20260722083015.GU110966@unreal>
References: <20260719105327.864949-1-mykola@meshstor.io>
 <20260719105327.864949-7-mykola@meshstor.io>
 <ee312bcb-92f4-4884-91cd-3bd56180c8c7@deltatee.com>
 <CAPzsNDsLr_BABgizujN0CgnLNfzS3S37vQ133fjbJzFMvRs7CQ@mail.gmail.com>
 <9f846c85-f427-433a-b87d-8e9e3a4406e7@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f846c85-f427-433a-b87d-8e9e3a4406e7@deltatee.com>
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

On Tue, Jul 21, 2026 at 05:38:53PM -0600, Logan Gunthorpe wrote:
> 
> 
> On 2026-07-21 11:50, Mykola Marzhan wrote:
> > I have split it in v3 into a raid1 patch and a raid10 patch.
> > I am not sure about separate "introduce the bit" patches.
> > R1BIO_P2PDMA and R10BIO_P2PDMA are entries in the two personalities'
> > with own r*bio state enums.
> > The commit messages are shorter now.
> 
> That helps a bit, thanks.
> 
> 
> > An early return doesn't work here: on a mapping failure the
> > function must still fall through to set R1BIO_WriteError, so the
> > completion path runs the (single, whole-range) retry and records
> > the bad range -- only WantReplacement and the FailFast md_error()
> > are skipped.  v3 folds the two tests into one branch now,
> > which reads better and keeps the fall-through. Please check v3.
> 
> The early return works if you create a helper.
> 
> > I compared the two sides after splitting: the P2PDMA handling is
> > symmetric, and the remaining differences are pre-existing
> > personality differences rather than missed fixes.
> > A shared helper would be heavier than the two open-coded branches,
> > so I kept it per-personality.
> 
> Yeah, I still think it's a bit of a mess so I dug into it a bit more
> myself.
> 
> I realized the real problem in this patch set was reusing
> BLK_STS_TARGET. I think I may have used that a long time ago and those
> paths have since been removed. Using it here doesn't quite make sense
> because we end up with those awkward checks (is P2PDMA enabled *and* the
> error is a BLK_STS_TARGET). I don't think that can ever really be
> correct here seeing something could, in theory return BLK_STS_TARGET for
> another reason even when P2PDMA is enabled. So that should be cleaned up.

I had thoughts about this series too. It seems best to avoid
the P2P path entirely unless all legs support P2P.

Can the md/raid code determine P2P support in advance?

Thanks


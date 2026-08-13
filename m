Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FA1DC5B572
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Aug 2026 20:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fpjKFUTyvoJnippaDtIHnMWPEsucTsOfc8ALB5IHmJU=; b=xI9vy3App0EChDGDShiBxVrFhp
	xheqSh4kLEm5UFN3xmXwn20pTEvysF/UJ1pEgQeYajZkbA22vECX1csA6QzQG+oh2PJ+TYGtxMuty
	3aH0yuqFZQdfl0e5FNbZku2evdlGyfk9mB1/lGHE14ELrg1Lblc/+sq46OULJPMKY4sjCgwzDnuh7
	PMS9wsMDziihiDOpQpxwopYc2Bzyu+pGduJ1oPbjGTqXALkZZ6v2GOe50fgwjyqYXSExp29tL9guG
	kOachxbTD/KIkVCxqQiCQ47Yu8SU3e15M8Zp59NcKzvHKBOb7rqX5m0/MLa76vS9C6/IictnFZEO8
	NAquIE+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuc1c-00000001VfI-2VLd;
	Thu, 13 Aug 2026 20:27:40 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuc1b-00000001Vex-2Xhh
	for linux-nvme@lists.infradead.org;
	Thu, 13 Aug 2026 20:27:39 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id CC4B2600B0;
	Thu, 13 Aug 2026 20:27:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 572B01F000E9;
	Thu, 13 Aug 2026 20:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786652858;
	bh=fpjKFUTyvoJnippaDtIHnMWPEsucTsOfc8ALB5IHmJU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BVRX0yzPKB4r8WNrDxxc45wZPDEAPH0QWSTrMLjtVo6gaEnIFSKS8IXw1A1Kflyhr
	 CQNATrDC5TlWHu2UzeKp6ymUy66QCE0bCf3K2wtkLNOS03ZKYBWWCAKaeWX0pEXw9S
	 RtLYpo0sL2pozpW4YMkRru2/+ID2yrDs5Fd8Qp9898ARqTtM2ZUP2PZ2H+zA8Vjc3g
	 XIco2ARR+IpV/seiwD4C/nb17ercmDUz6aHBFEydCPLdxztUa1c1y+v5gt6t+kdVlr
	 LK4CjGFJ7Ucyc6BrZ9THS3Ilt5z3eovk+xa0tJbJCJLPMc9III1+hWPCsNkVBQ6mtd
	 nTkEgl5PXtjCA==
Date: Thu, 13 Aug 2026 14:27:36 -0600
From: Keith Busch <kbusch@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
	kch@nvidia.com
Subject: Re: [GIT PULL] nvme updates for Linux 7.3
Message-ID: <an4ouLiJRHmsP3wv@kbusch-mbp>
References: <an4C5I9K70UhVBpN@kbusch-mbp>
 <c5f8232a-1e52-464d-93c6-f2c91a403f97@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5f8232a-1e52-464d-93c6-f2c91a403f97@kernel.dk>
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

On Thu, Aug 13, 2026 at 12:36:32PM -0600, Jens Axboe wrote:
> On 8/13/26 11:46 AM, Keith Busch wrote:
> > The following changes since commit f01f5275feb77bac9fefbbf7cc584fe0b3850a92:
> > 
> >   ublk: snapshot batch commands before preparing I/O (2026-07-02 06:25:21 -0600)
> > 
> > are available in the Git repository at:
> > 
> >   git://git.infradead.org/nvme.git tags/nvme-7.3-2026-08-13
> > 
> > for you to fetch changes up to f1a8846e06388113dfdbb89dee005083fa9afdf9:
> > 
> >   nvmet: fix max_qid race between configfs and controller allocation (2026-08-13 09:26:44 -0700)
> > 
> > ----------------------------------------------------------------
> > nvme updates for Linux 7.3
> 
> I think we deserve a better summary than that... What's in this PR?

Sure, I'll push a new tag.

The bulk of this is a collection of bug fixes largely found through
fuzzers and AI for both host and target mode. Many of these address
conditions after receiving protocol invalid payloads that could have
caused the driver to access out-of-bounds memory. The remaining
fixes properly handle cleanups in error paths that may either leak
resources or trigger a use-after-free.

The other large chunk from Nilay adds context annotations for compile
time checks.


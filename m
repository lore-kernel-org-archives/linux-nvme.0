Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B05AEECD983
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Feb 2026 15:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9riQzIZ7LitBCAvIi1HAKLt6C/FzFFKUCDlI3Ry/gss=; b=f9Lx1FBXkvTS6pQKjZRm91wGZ9
	SPPG9pXUc+1uRTq20CsbBYqjiYVM6H2KGSHCq+bxewXnJ9ZLytU/rYKlB4Vc1iTlxag3Xe8UFTmcH
	uZ8wA3YwFVzluwbrCkW9YxfWREKYNMLr1h2J7H+vN0RyrhUAWgqqMJztmKDp+n3bp24dKovvo2Sp/
	ZA28M2F3Crk31QzqUlxvlrBO4acg+N08uVyB8RHoEMAwT28oX9QzGk3bbsS9FQNq2rZ335yoTN6ME
	LEOKdme+AWKvHgpe2id86JlUB/8lR5ayRHjmas+HOzXuzN8JTKkNlqqzBXSkqFyeYAql6RlvHsQ50
	SXaLynaA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vo1gT-0000000ABFf-3fjO;
	Thu, 05 Feb 2026 15:54:21 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vo1gS-0000000ABFW-0kUZ
	for linux-nvme@lists.infradead.org;
	Thu, 05 Feb 2026 15:54:20 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 51D2660010;
	Thu,  5 Feb 2026 15:54:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5E10C4CEF7;
	Thu,  5 Feb 2026 15:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770306859;
	bh=meA/eQMCek5VLdG83C2daqCnNVz00sYX3PBQYi+wVEQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D4teAPfAKZhIAJK5QFgSTSzDuEQGgVxC9eMUIqX25GPMe6Q3ez2yFapfab10vQh+O
	 QHyzcfmcwEh2N3ig2FaDvfg/SbloC+a6OER0cRvhK5vaf9i+YYMsVTqiL39cvaRRoU
	 6upfkpoEMcnm9VIvDQcOrhgyu0l/3z6glX8XZC3G+wFeoialq2PqZp+CRsHy//D/b1
	 BVfcVdcoDHp6DjJhYsc9xyvgkjUSeiC+7scv5wCu0hPM3YKdwRRKErZdEMSTtmlEG5
	 VnFMKlRikjH7TbNfxFvg32o9gSGwPQDurse233Piudmqe+k7SeioNzYDpMSP7rCexI
	 HYRthmSJ8MORg==
Date: Thu, 5 Feb 2026 08:54:17 -0700
From: Keith Busch <kbusch@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, linux-block@vger.kernel.org
Subject: Re: [GIT PULL] nvme fixes for 6.19, final
Message-ID: <aYS9KeAYcTh9GIaJ@kbusch-mbp>
References: <aYS5ZlwruxpNCdTL@kbusch-mbp>
 <d114450b-2405-4ed0-bcda-03e08f48ba1d@kernel.dk>
 <ded8f99f-2d4a-48fc-9cff-02aa317a1c25@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ded8f99f-2d4a-48fc-9cff-02aa317a1c25@kernel.dk>
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

On Thu, Feb 05, 2026 at 08:49:35AM -0700, Jens Axboe wrote:
> On 2/5/26 8:47 AM, Jens Axboe wrote:
> > On 2/5/26 8:38 AM, Keith Busch wrote:
> >> Hi Jens,
> >>
> >> Some late fixes for nvme that should go in this release. One for a pci
> >> regression that causes a kernel panic during certain dma conditions. The
> >> other fixes a vulnerability in the tcp target.
> >>
> >> The following changes since commit 4da7c5c3ec34d839bba6e035c3d05c447a2f9d4f:
> >>
> >>   bcache: fix I/O accounting leak in detached_dev_do_request (2026-01-28 19:06:55 -0700)
> >>
> >> are available in the Git repository at:
> >>
> >>   git://git.infradead.org/nvme.git tags/nvme-6.19-2026-02-05
> >>
> >> for you to fetch changes up to 52a0a98549344ca20ad81a4176d68d28e3c05a5c:
> >>
> >>   nvmet-tcp: add bounds checks in nvmet_tcp_build_pdu_iovec (2026-02-05 07:29:10 -0800)
> >>
> >> ----------------------------------------------------------------
> >> nvme fixes for Linux 6.19
> >>
> >>  - Fix NULL pointer access setting up dma mappings (Keith)
> >>  - Fix invalid memory access from malformed TCP PDU (YunJe)
> >>
> >> ----------------------------------------------------------------
> >> Keith Busch (1):
> >>       nvme-pci: handle changing device dma map requirements
> > 
> > After this one, iod in nvme_pci_prp_iter_next() is now unused, which
> > will trigger a compiler warning...
> 
> Actually this is only true in the 7.0 based branches. Should be fine
> for 6.19, I'll add a commit for the 7.0 merge.

Yeah, I initially applied this to 7.0 with it removed, but we decided
this was a nasty and easy to hit bug that 6.19 is better of having fixed
on release. I had to leave the 'iod' in for the 6.19 port, so looks like
we'll have a merge conflict for the next cycle.


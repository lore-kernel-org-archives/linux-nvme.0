Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66420CC6B38
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Oct 2026 17:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KBEGJr9zQZy95V5Zr1A1ig2Oaq2yE9CW2KUEvun7wpA=; b=4lRSkb0vjjxHS2ie0VhU/e5olA
	hgFwfN4TqNNrTf6kB710B9b2HN6K7RiIfYoIHeTgjboO1IG5QbH3bAG3DjxN1zJi6PWbry4+401CL
	uGX1Ekcc5WYIJU34aXzvTeYz+e2AGbcRwkceaCiIHP0FLbM4cQnH5NblWdQYFgckz99Elve+zN0AD
	OoaeCrShS6yFf2WHxRLDYgo0hXYCmARY8TG1Ol9Lc1dj7TzZ+EMkcicPVRCg6KmonfV8xooaSRa4k
	DUUjle+2zkv3+GUvYNtPg/zrUEGKk8s3igpq/bonLlDovc6pAQH+lqR3vgvepyMdcAzffonYwzlcK
	qk0FdOjw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHli3-00000003YXL-1JKC;
	Fri, 16 Oct 2026 17:27:11 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHli2-00000003YXF-0HIj
	for linux-nvme@lists.infradead.org;
	Fri, 16 Oct 2026 17:27:10 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 8C98E43715;
	Fri, 16 Oct 2026 17:27:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 315231F000C5;
	Fri, 16 Oct 2026 17:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792171629;
	bh=KBEGJr9zQZy95V5Zr1A1ig2Oaq2yE9CW2KUEvun7wpA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KnyCjP78vlFuxveebZ9MofPRrsYmdol4uKYwfMmoiuiHuM+wbJ8/YceLl6b6b4r1s
	 XP59RMcjHLCO9sACz7vfhn0nAqdRgKm15yCQ1Oakt5D7Zy4w64V5ETAUN/JeNOe0uQ
	 KNMZCR/vVn4+BSVbHFGy3EqlEb+YKal89csVJTirWnfnBDxB/c8cAqX4SUEGigostS
	 ifGzr+0u/3HODTylWhsY4UmgLfx+TWMQr83gjwI5ihsnPNC/2oqlxtyMOos5yYHsnD
	 wrduJ4vdPCS5itMFeKxZvM2xSykFoY4tkVSWMOlI1BIzYAreDsUzXN0WwmK21W8D9C
	 i1Dok6Nf1el1g==
Date: Fri, 16 Oct 2026 11:27:07 -0600
From: Keith Busch <kbusch@kernel.org>
To: Erwan Velu <erwanaliasr1@gmail.com>
Cc: linux-nvme@lists.infradead.org, axboe@kernel.dk, hch@lst.de,
	sagi@grimberg.me, linux-kernel@vger.kernel.org,
	Erwan Velu <e.velu@criteo.com>
Subject: Re: [PATCH] nvme: honor the volatile write cache enable state
Message-ID: <atJeazM_rJ0uj3vt@kbusch-mbp>
References: <20261016141208.2641974-1-e.velu@criteo.com>
 <atJXYHJa4jkUWJmP@kbusch-mbp>
 <CAL2Jzuz1qFwLSA=iivp5qLCTL6-4rvKmvFzJbOQzjPu6j_7Y2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL2Jzuz1qFwLSA=iivp5qLCTL6-4rvKmvFzJbOQzjPu6j_7Y2A@mail.gmail.com>
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

On Fri, Oct 16, 2026 at 07:15:20PM +0200, Erwan Velu wrote:
> Le ven. 16 oct. 2026 à 18:57, Keith Busch <kbusch@kernel.org> a écrit :
> >
> > On Fri, Oct 16, 2026 at 04:12:08PM +0200, Erwan Velu wrote:
> > >   job                   | cache   |   IOPS | fsync avg | flushes |  gain
> > >   ----------------------+---------+--------+-----------+---------+------
> > >   psync buffered, QD1   | back    |   3885 |   247.6us |  116552 |
> > >                         | through |  48325 |    15.7us |       0 | x12.4
> > >   ----------------------+---------+--------+-----------+---------+------
> > >   io_uring direct, QD1  | back    |   3886 |   238.2us |  116593 |
> > >                         | through |  41924 |     5.7us |       0 | x10.8
> > >   ----------------------+---------+--------+-----------+---------+------
> > >   io_uring direct, QD32 | back    |   5088 |  6173.5us |  117793 |
> > >                         | through | 140196 |   107.0us |       0 | x27.6
> > >
> > > From NVMe 1.4c (sections 5.21.1.6 and 6.8) up to the NVMe Base
> > > Specification 2.4 (sections 5.2.30.1.4 and 7.2), a Flush command has no
> > > effect if the volatile write cache is not enabled.
> >
> > Yeah, the NVMe Flush operation should be a no-op in the device, so the
> > dramatic performance difference is a bit alarming. Surely the block
> > stack's flush machinery is not the reason for the difference, right?
> >
> > If the device's flush handling is this bad when VWC is disabled, what
> > happens when you have it enabled? Can you re-run the same test with that
> > setting?
> >
> > I'm not necessarily against what you're proposing here, but your numbers
> > are unexpected.
> 
> Maybe my table here isn't probably clear enough.
> The numbers shown in the  "write back" mode were done with VWC enabled.

But you said the table came from tests "with WCE cleared" in the VWC
feature. ?


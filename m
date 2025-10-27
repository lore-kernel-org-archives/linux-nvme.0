Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40A4ECCF9EB
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Oct 2025 16:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=s0NAMJbgz2XKMJ3TsTW+O6FmmH6wsyo2o1sqgeqL8wU=; b=JK0faKj/wKUSNoY64/bT7PBHo2
	YJBdNRkIgN+16VChBp5sYJrJIOgujqyrDaHTRahD0ox/s3rbr7OAnC3QPQgMpOzu+fkAHFBfoCfGq
	8qe07iUrIHxWP5LpDyA2EoWlrcVg/gcQZZxiGHqUUHFlFKUqMKZ1ALyYdCKkc5TErqKshgsgxCly7
	EmXj0VcR7Cg9/Q2Twz+9LMgynbNsBK4cyYFukXgaPFUkqFuNRJU7a/QQc7s42H12wRqsy/dnfmoOJ
	NWO6vrgh5Gpo+tAk5LfbsujcBZK38GcSnUr/FECNswiLCqHfsR8GBQPypUcLmcOueM0TeM5cAyW7g
	aBhApYBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDPme-0000000EHfa-2tma;
	Mon, 27 Oct 2025 16:09:24 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDPmd-0000000EHfP-43gj
	for linux-nvme@lists.infradead.org;
	Mon, 27 Oct 2025 16:09:24 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 19236603C3;
	Mon, 27 Oct 2025 16:09:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84C38C4CEFD;
	Mon, 27 Oct 2025 16:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761581362;
	bh=PwGL0FdkTDfKpb61RrIyKJxfpVGR24FtiSgYofPOYq0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EGss5I344KqTA87L5w+GqCL1Uri3FFGcrv2uYA03ZcFqRIZW4enecD9ba1Uxx7lvU
	 d/efqgZZ6RP72E27AbJ/y8nAUXIxTeO8bHoHb1ABOS2KmB/TZLWMUxO6gq+bPJJYL+
	 ZRFAiq+0r302prnMS9koroWOWKGLHD+k60VhfLaJTEt+njvt1uCXZReiycZACVTt3p
	 DN+t/A8R1XMXYNg2x0eDC4V7udFxNQgDKU2e417rbavg0VcZX0gYzSowcF1P67CxwO
	 60TBoX68dr2BR+hhTRYiXhZu0kXtschfqn2+ID8tutokw0TJtE2OHvOhGTnrio39Yz
	 SA44bmoUuCnAw==
Date: Mon, 27 Oct 2025 10:09:20 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Leon Romanovsky <leon@kernel.org>, Keith Busch <kbusch@meta.com>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-pci: always use blk_map_iter for metadata
Message-ID: <aP-ZMNfFh_zps4ri@kbusch-mbp>
References: <20251020182444.2587155-1-kbusch@meta.com>
 <20251021071935.GA31479@lst.de>
 <aPebvnv3u6HWcqdX@kbusch-mbp>
 <20251026072551.GB12554@unreal>
 <20251027071353.GA13854@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027071353.GA13854@lst.de>
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

On Mon, Oct 27, 2025 at 08:13:53AM +0100, Christoph Hellwig wrote:
> On Sun, Oct 26, 2025 at 09:25:51AM +0200, Leon Romanovsky wrote:
> > > Maybe the data path should only use blk_dma_iter too. Is dma_map_bvec
> > > that much faster for the single vector case? I'm going to test both on
> > > real hardware and see if there's a difference in CPU utilization or
> > > latency.
> > 
> > We tried that path (remove special case for single segment), but for
> > very performance oriented case: direct mode without IOMMU, no p2p and
> > extremely powerful RAID (~94M IOPS), Jens and Kanchan saw performance
> > drop. On consumer grade HW (~2M IOPS), the performance change was not
> > noticed.
> 
> Yes.  Sorry, I wanted to reply something like this to Keith earlier but
> managed to drop the ball.

Yeah, no problem. I was reaching the same conclusion anyway and moved on.


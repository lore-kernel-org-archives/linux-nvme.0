Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7CD0C83F25
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Jul 2025 02:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lQgG8qiw8RC2/8PsZRNkuG7NNUeypiqvSv2W5Tt3JqU=; b=0ks6aUDPTLB3/G8v/UFaw0Qxij
	NXeB7JWBiXQCkwi2bJh1dRSHA4cZOOjVwMUbKyBAlMXhQssFqCnosOdpLho213h3Kowt2iWEVQk4P
	NnkZ+IudQK4T8bMQURZbYWcgFTCNYs/Xc3bShn6o07C0cS/cu84zT32GrJX7g2AJygC3dkLgd0LXV
	FsGu5618viHzHJQIKL/ZCNxBy2TbnH7y86gGRnAdmhyMx/NOkO+oKqox/X0YOynKjsYSiTnx6RAl+
	gZBCqn7WAG5X9BwwLWL/rR59sJQn/uhsnicdyRRFtjcy0sdZJFDHUafXv9x+G4yOwRHlxn1tQcIqu
	5FphFc+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ue2ob-000000016OR-002N;
	Tue, 22 Jul 2025 02:33:13 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ue2oU-000000016Nq-2T45
	for linux-nvme@lists.infradead.org;
	Tue, 22 Jul 2025 02:33:07 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id A633244C8F;
	Tue, 22 Jul 2025 02:33:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CA92C4CEF1;
	Tue, 22 Jul 2025 02:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753151584;
	bh=TEe3mFQIdyGZDoil88eRKQyvmUBczLUnUFXLEbOKD8o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rZfJQw0IyPq3vwpupgh9Rkox4dqUgUzeOKGNTdrWW3PbH/+8L3HmVeohL9SosLRal
	 blhoZqpf+PLezaKbivB+p86PMpt/vDheA/fRrZdNr6xBxZU08nus9wQ7U3fhVnvswQ
	 xylXbj4SnJ97Mxlqo3aJGIzO7ne9ZG/XWuT1eDc1MeccvRPd7vf4IduS4FvgfFGXTR
	 ZNEjSWA5vHWjwL2Pe0DcNljRLECL9vGNEn+28DkiySog/9a1O2UKIkcEayZ1XECjAi
	 7GdqlwEKiLdZA3eBcsP4ZMgY+9WQ2JH/uJUkO/Qz8A2nGsXARyd8mVQBwN+CPiybOl
	 rlwTh42wxBp9w==
Date: Mon, 21 Jul 2025 20:33:02 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, axboe@kernel.dk, leonro@nvidia.com
Subject: Re: [PATCHv2 1/7] blk-mq-dma: move the bio and bvec_iter to
 blk_dma_iter
Message-ID: <aH74XluC0BnerBaQ@kbusch-mbp>
References: <20250720184040.2402790-1-kbusch@meta.com>
 <20250720184040.2402790-2-kbusch@meta.com>
 <20250721074223.GF32034@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250721074223.GF32034@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250721_193306_656106_86F43DA4 
X-CRM114-Status: GOOD (  14.25  )
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

On Mon, Jul 21, 2025 at 09:42:23AM +0200, Christoph Hellwig wrote:
> On Sun, Jul 20, 2025 at 11:40:34AM -0700, Keith Busch wrote:
> > From: Keith Busch <kbusch@kernel.org>
> > 
> > The req_iterator just happens to have a similar fields to what the dma
> > iterator needs, but we're not necessarily iterating a bio_vec here. Have
> > the dma iterator define its private fields directly. It also helps to
> > remove eyesores like "iter->iter.iter".
> 
> Going back to this after looking at the later patches.  The level
> for which this iter exists is only called blk_map_* as there is
> nothing dma specific about, just mapping to physical addresses.
> 
> So maybe call it blk_map_iter instead?

But the structure yields "dma_addr_t" type values to the consumer.
Whether those are physical addresses or remapped io virtual addresses,
they're still used for direct memory access, so I think the name as-is
is a pretty good fit.


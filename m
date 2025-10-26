Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6A3FCCF9E5
	for <linux-nvme@archiver.kernel.org>; Sun, 26 Oct 2025 07:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=opwz5odNOrNrhFygXof+p4/NjQLR0aKJ0k0tC+IiZSk=; b=F9XepJ6eIyDhedinfQRymTnq7Z
	dd63cQH8GfJCkXk+DNvHNKjbJKiJEWbdNa63beRuqk9wwvfdOL7qwKbOPINFsvpouj7Gz2o0dJH76
	nMMvq7VTrpDAfykE5T9Caajp0W/gR1Od0iGkq1CaUhPbTO5xqiOYmooQ1l1XgyfRvlqeu89nrtwMw
	H+4F9AGgOhAK0hJnrkOmUAe9eo4R4SuSGamRM++LJjmw/Wt5IYCL+emYNKakgajRGz7Hwm1iY7ImH
	bzrQrARQE/cafy1cWVECFqgZ64T8GFfRcfojoJ951/W3Dp5G3VQqY/2a0T2E6C3y1kKKzyc7c5/rK
	//BFJ1gw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vCv8Y-0000000C7y0-1CMv;
	Sun, 26 Oct 2025 07:25:58 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vCv8X-0000000C7xR-18Ea
	for linux-nvme@lists.infradead.org;
	Sun, 26 Oct 2025 07:25:57 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 556636025D;
	Sun, 26 Oct 2025 07:25:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 399A8C4CEE7;
	Sun, 26 Oct 2025 07:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761463555;
	bh=NqCgzSVRnJ3+v6lzRloQ7xMIv24W/CP4UYdwRoNotYE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P5N7VbDQu0yCgU7PfXqR+NB4+SDtsh0bJtbXFQ7GF+zRtidIHKSdInljjzOg1xBz1
	 XJNBWaXouijdfDo+4zQroYtS4GdEGGc8sFTIevZUoh8DuC7h2k2ke9WDI7GwZCI0O1
	 TFg+v1kEmJfQTk4Am12Yvm/ThGHosnH6RJ92Bv4AMHQsJu2K3OZ8mHxRx/HXEk6rYM
	 Rkej2jEIbpMmL+uMCd8LAQW7HQM2/EA4FyRID7VAn0tzhuBZrW/FdXUWS5YmCEfQmA
	 Q055Z2FMZVQzJ/tjZYZPGWG+q10HXKlMZZHwo7SzspXMiZ9YG3e+TJI1tMJ/jcXWlR
	 tqG90qHpVNo/w==
Date: Sun, 26 Oct 2025 09:25:51 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-pci: always use blk_map_iter for metadata
Message-ID: <20251026072551.GB12554@unreal>
References: <20251020182444.2587155-1-kbusch@meta.com>
 <20251021071935.GA31479@lst.de>
 <aPebvnv3u6HWcqdX@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPebvnv3u6HWcqdX@kbusch-mbp>
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

On Tue, Oct 21, 2025 at 08:42:06AM -0600, Keith Busch wrote:
> On Tue, Oct 21, 2025 at 09:19:35AM +0200, Christoph Hellwig wrote:
> > On Mon, Oct 20, 2025 at 11:24:44AM -0700, Keith Busch wrote:
> > > From: Keith Busch <kbusch@kernel.org>
> > > 
> > > The dma_map_bvec helper doesn't work for p2p data. Rather than special
> > > case it, just use the same mapping logic so that the driver doesn't need
> > > to consider memory types.
> > 
> > We already consider the memory types for the data path, so treating the
> > metadasta path where p2p is even more unlikely sounds like the wrong
> > tradeoff.  
> 
> Maybe the data path should only use blk_dma_iter too. Is dma_map_bvec
> that much faster for the single vector case? I'm going to test both on
> real hardware and see if there's a difference in CPU utilization or
> latency.

We tried that path (remove special case for single segment), but for
very performance oriented case: direct mode without IOMMU, no p2p and
extremely powerful RAID (~94M IOPS), Jens and Kanchan saw performance
drop. On consumer grade HW (~2M IOPS), the performance change was not
noticed.

Thanks


Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A071C87FC5
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Jul 2025 07:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aw/qaAQyJasjFE3u6qcsH8D64bKmg+uxDFWrEcO182k=; b=GeR699ecobMVrLAVV6Wre2k3Jy
	kJmtaheQXbxz24egMKyelHIUZKZz3+SWq3zaena5AHZFKbpBhLNuRzvk6+4a/uhkRB/9gnxwoiNcB
	x1aOcZlVRojsjyUwZjLOGq3JEq9pU2lSdHH/4TYUegf61d3AUZGrLNT276HL7s5vg8PmugNdTmP0B
	2GxYeVBjZPBfqjJyRKxIjyLsp8yy3vOzQZbcUpaXqwW/CD4xmxvt9S24m/2khlsT33I8pwF0B95gv
	Ey+PLhJzOknZ/QNh5Cq8MnL8cV/eYcKaS3mjH9aX1uDIfTiZd9sL+lJ2VF0DMVzb01QNvP/vNHxAf
	pPQFQYYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1udlCj-0000000GXGa-2cqa;
	Mon, 21 Jul 2025 07:44:57 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1udlAL-0000000GWm7-0r43
	for linux-nvme@lists.infradead.org;
	Mon, 21 Jul 2025 07:42:33 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1C69068B05; Mon, 21 Jul 2025 09:42:24 +0200 (CEST)
Date: Mon, 21 Jul 2025 09:42:23 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, hch@lst.de,
	axboe@kernel.dk, leonro@nvidia.com, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2 1/7] blk-mq-dma: move the bio and bvec_iter to
 blk_dma_iter
Message-ID: <20250721074223.GF32034@lst.de>
References: <20250720184040.2402790-1-kbusch@meta.com> <20250720184040.2402790-2-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250720184040.2402790-2-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250721_004229_447573_C96AC87F 
X-CRM114-Status: GOOD (  10.92  )
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

On Sun, Jul 20, 2025 at 11:40:34AM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> The req_iterator just happens to have a similar fields to what the dma
> iterator needs, but we're not necessarily iterating a bio_vec here. Have
> the dma iterator define its private fields directly. It also helps to
> remove eyesores like "iter->iter.iter".

Going back to this after looking at the later patches.  The level
for which this iter exists is only called blk_map_* as there is
nothing dma specific about, just mapping to physical addresses.

So maybe call it blk_map_iter instead?


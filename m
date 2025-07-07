Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D270C8303C
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Jul 2025 15:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Oakt1wXcS0vVs1Snix6yYIYpLvjK7axLGCP/3B6vHcs=; b=e6wEjYCb0vewE15FYCScmSqu4b
	2CWxbt34rs0GKyIMfV1jnmPb7y4Ofo+O9CIYK+vNINA9GBNmp/Qa88fsr1tW+VCo6KeQTT35jxUHY
	WfjFirnq6S9X/bIYduGoxJWsazWmtV5jdyX/K88e5V+9ooFu8Ta1YRCPB1F9Qh53SZT+fOuSOJR3d
	kYvatQQnNVptv1MHSm4CWo5SeqjQzHzTQNfLCGoLbnIh9KhiFo2948dOQumlBtWC35qXrnpi2ZN6s
	CHFoPvl6PVv/HfjeLklHZL7sr6MLqAubDHY1StgUJhQ1ONLJY5j/iLK5eHTcZgd+aEMgcYfSnnx0I
	BKZh7yPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uYngr-00000002qNu-3Hxg;
	Mon, 07 Jul 2025 15:23:33 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uYnXJ-00000002pGF-2X6A
	for linux-nvme@lists.infradead.org;
	Mon, 07 Jul 2025 15:13:42 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 294D55C5698;
	Mon,  7 Jul 2025 15:13:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7752BC4CEE3;
	Mon,  7 Jul 2025 15:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751901220;
	bh=2NVZxjr92+sQKDR41ncVJhGFd6vWuk+6KzB7YIEW2f4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l55wWOT26aAcfqKiPwk6nodQ/u2UdoRXI02XVWZ/PrMmmp7hK7fKuAb9Da0DB0yjs
	 vaI5eH3dopkcKc7tql7C16MGAsiExw0IXU8OgCmkX6dImHvydB2SPOYg9Npa9Y/qL1
	 n1HN+0iFS3btUDTziZCHmFeCSAC4Sn0xP6G2RTuzZ1RinmIYoyb1oKErGxuEYD+o7e
	 MfCnK03CMKBz69k3MXzKZcJwoyFhdp2E4fq2kLHVXm/cCd4jTl/8SBhH70KExdoRzK
	 QKn5vBMZXZZphnkUXCQ9fJXzfT6arvT4mDQRp2liEm5hg/t28Y21xRhz6PjC+N1WsO
	 k0hPm1EynpaHg==
Date: Mon, 7 Jul 2025 09:13:38 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, sagi@grimberg.me, ben.copeland@linaro.org,
	leon@kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: fix dma unmapping when using PRPs and not
 using the IOVA mapping
Message-ID: <aGvkIt-j_QNo250Y@kbusch-mbp>
References: <20250707125223.3022531-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250707125223.3022531-1-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250707_081341_678278_6AA0AC9B 
X-CRM114-Status: GOOD (  17.64  )
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

On Mon, Jul 07, 2025 at 02:52:23PM +0200, Christoph Hellwig wrote:
> The current version of the blk_rq_dma_map support in nvme-pci tries to
> reconstruct the DMA mappings from the on the wire descriptors if they
> are needed for unmapping.  While this is not the case for the direct
> mapping fast path and the IOVA path, it is needed for the non-IOVA slow
> path, e.g. when using the interconnect is not dma coherent, when using
> swiotlb bounce buffering, or a IOMMU mapping that can't coalesce.
> 
> While the reconstruction is easy and works fine for the SGL path, where
> the on the wire representation maps 1:1 to DMA mappings, the code to
> reconstruct the DMA mapping ranges from PRPs can't always work, as a
> given PRP layout can come from different DMA mappings, and the current
> code doesn't even always get that right.
> 
> Give up on this approach and track the actual DMA mapping when actually
> needed again.

Looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>


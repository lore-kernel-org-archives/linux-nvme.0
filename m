Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B092ACCD193
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Oct 2025 07:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/erILj6ZQiMeDmUXfQ4GB7wCPEckDs+AXKgOzBHGlPM=; b=o8Suxwt4FnstsR/B2rw08kUpBS
	vvczi8CWSuScZvNWcOhgbiqTUZZqf6GJSxKpUDv94jNZupLJqyjWpz3CFX8XCRlT4HB4PC1R554wL
	ThpFJtAGYdhojYzpjNZFLn9a9kXCiGV5r9VevVTtNdp1rfmsZ0/IAENDAsnnpTqGVUMrsmGgu8oo+
	isoxKC2gL9o7UkPIxaJbSozhmHQuynDe3pGIs5BXiNzFhwgnAQgYLtYEzw7299sbNFvI910WuMmBS
	3Stcij6YDth+B8A+Cx5qmjlFu8wMr03qaXExHKSDD16D51i8cyXjDtY25Y3gF1uSF4PHw81n1oDFP
	fHolpvNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAkhf-0000000CGop-19Cr;
	Mon, 20 Oct 2025 07:53:15 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAkhc-0000000CGnR-3IOf
	for linux-nvme@lists.infradead.org;
	Mon, 20 Oct 2025 07:53:13 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 78BBD45920;
	Mon, 20 Oct 2025 07:53:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 647EBC4CEF9;
	Mon, 20 Oct 2025 07:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760946792;
	bh=S1V3jsImf5h8yqSk61EYpNQyrAvY2nfUa59BmY7SvuE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DWOAPF4w2M5bFzPRH91Jscb0ku1Tp+vIsX2LezRP1KXfSDXDiF0i/t717XDy0r9wG
	 PlYgmnfThQWc9FJXU5zaOCHro4tA2EzTNUrh2GF+29ECi2CUvMWQrRFRASfeSZg/AH
	 PGpu5flxWg+6eMfBveDm4qdsJ4wtbOvEsXI8rkCJIsJbhfVaz2UkYLQ4H6G6CB+LSb
	 xM+DdDI4YwK6avFSvGr+Rbhi8bOLG9ooEPpIiAYzFe0Y0EiZCE3ag4D07jn1xG9MZj
	 zJQmo60urfKRv5f7p6j0ByJJ8z/OPO8YplY3pK+xtacxk9cNIWwxwsPvegH2hjOjt4
	 G3MZH55D/h8Zw==
Date: Mon, 20 Oct 2025 10:53:05 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/3] nvme-pci: unmap MMIO pages with appropriate interface
Message-ID: <20251020075305.GL6199@unreal>
References: <20251017-block-with-mmio-v1-0-3f486904db5e@nvidia.com>
 <20251017-block-with-mmio-v1-2-3f486904db5e@nvidia.com>
 <20251017062008.GB402@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017062008.GB402@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251020_005312_849541_8E03E12F 
X-CRM114-Status: GOOD (  15.17  )
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

On Fri, Oct 17, 2025 at 08:20:08AM +0200, Christoph Hellwig wrote:
> On Fri, Oct 17, 2025 at 08:31:59AM +0300, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@nvidia.com>
> > 
> > Block layer maps MMIO memory through dma_map_phys() interface
> > with help of DMA_ATTR_MMIO attribute. There is a need to unmap
> > that memory with the appropriate unmap function, something which
> > wasn't possible before adding new REQ attribute to block layer in
> > previous patch.
> 
> DMA_ATTR_MMIO only gets set in the following patch as far as I can
> tell.
> 
> The more logical way would be to simply convert to dma_unmap_phys
> here and then add the flag in one go as suggested last round.

Done, thanks


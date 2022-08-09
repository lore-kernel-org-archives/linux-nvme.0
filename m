Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FE7CC19F2D
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Aug 2022 06:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=asYNAL3JiRnd7iiR7H/KUx19nKuMFDpCIeoIv02enf4=; b=MnRZy2BCpZ7tgeaMwPvsAsmoxd
	Dagl8wZvpCaMw258/NmvMh/QJQeN7bPWPJ0ta0ZQr62AD3ITCZHxLqMONEq9uTREm9WxyzCFHkl4C
	GL5Hx4z+0ZnFic9FjHnX+hDgqcqfyF2TwhEKRw6cbCdIhpnZ7d/QKb05YFymd1Q0yXihtbErYu4aW
	pZieLv21f7kxMW/otoqJ1hWTE8Di4cWLkEqjMG98UcjAeOYpySOHTVCETeWoJl+A+4G12RvogE7xE
	r/8XJh7ZtJ+HQaA/2dTnasYikIoH59dVNHmSZKRZa4PzQyOoab87NluH9JiuHFn/iKxc0DiygpkAU
	qBTLMEiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oLJ0X-0024OA-Sl; Tue, 09 Aug 2022 06:46:29 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oLJ0R-0024Kc-E8
	for linux-nvme@lists.infradead.org; Tue, 09 Aug 2022 06:46:25 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id BCD3D68AA6; Tue,  9 Aug 2022 08:46:13 +0200 (CEST)
Date: Tue, 9 Aug 2022 08:46:13 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@fb.com>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	axboe@kernel.dk, hch@lst.de,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Kernel Team <Kernel-team@fb.com>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv3 0/7] dma mapping optimisations
Message-ID: <20220809064613.GA9040@lst.de>
References: <20220805162444.3985535-1-kbusch@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220805162444.3985535-1-kbusch@fb.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220808_234623_693305_BD28A25D 
X-CRM114-Status: GOOD (  14.93  )
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

I finally found some time to look over this, and I have some
very high level problems with the implementations:

 - the DMA streaming ops (dma_map_*) are only intended for short term
   mappings, not for long living ones that can lead to starvation.
   Especially with swiotlb, but also with some IOMMUs.  I think this
   needs to be changed to an API that can allocate DMA mapped memory
   using dma_alloc_noncoherent/dma_alloc_noncontigious for the device
   and then give access to that to the user instead
 - I really do not like the special casing in the bio.  Did you try
   to just stash away the DMA mapping information in an efficient
   lookup data structure (e.g. rthashtable, but details might need
   analysis and benchmarking) and thus touch very little code outside
   of the driver I/O path and the place that performs the mapping?
 - the design seems to ignore DMA ownership.  Every time data in
   transfered data needs to be transferred to and from the device,
   take a look at Documentation/core-api/dma-api.rst and
   Documentation/core-api/dma-api-howto.rst.

As for the multiple devices discussion:  mapping memory for multiple
devices is possible, but nontrivial to get right, mostly due to the
ownership.  So unless we have a really good reason I'd suggest to
not support this initially.


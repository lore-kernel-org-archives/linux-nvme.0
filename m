Return-Path: <SRS0=8iPx=CM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B69C1C433E2
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Sep 2020 08:44:34 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E8B92065E
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Sep 2020 08:44:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BJp27ukP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E8B92065E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=wGor/EC/W7YFqnG92AWvz//HMy4ANI49qDxWku2dZD4=; b=BJp27ukP/n6RlSjVXz1S73RBI
	F0Xr0IjthrNtu/B2TIhejxvd/ZI8gXNDc7XKBShtqMzppNSDt7NxVo8ETgrQlI2DtLeJQfb/onkBm
	3QZwaBZ3+qVLFUVwMMicIkkBoyU+q5aJh57ViI/9hO1U/idyPOmbEfuPeSmAI2NMwtQTS8qzqk8Ts
	9K2vnH4iTJv19PbM8MO+QrDmK6vi8CE2GHuOxaolqA8wm8lPVgfnmEhPQf0Hog2RluVmc2Crpmlid
	ArFM071gVGXP0YbRG7oyAue4b7T4Bk+ryYZl0u6fGwNM/sCMIe0P2Ys42mRRdLUP8jBaKBLhe8xh0
	UGBQIOJEw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kDkr2-00079R-U4; Thu, 03 Sep 2020 08:44:25 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kDkpD-0006H3-K2; Thu, 03 Sep 2020 08:42:51 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 2B13F68BEB; Thu,  3 Sep 2020 10:42:27 +0200 (CEST)
Date: Thu, 3 Sep 2020 10:42:26 +0200
From: Christoph Hellwig <hch@lst.de>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: Re: [PATCH 22/28] sgiseeq: convert from dma_cache_sync to
 dma_sync_single_for_device
Message-ID: <20200903084226.GA24410@lst.de>
References: <20200819065555.1802761-1-hch@lst.de>
 <20200819065555.1802761-23-hch@lst.de>
 <20200901152209.GA14288@alpha.franken.de>
 <20200901171241.GA20685@alpha.franken.de> <20200901171627.GA8255@lst.de>
 <20200901173810.GA25282@alpha.franken.de>
 <20200902213809.GA7998@alpha.franken.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200902213809.GA7998@alpha.franken.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200903_044231_795416_7DFC3905 
X-CRM114-Status: GOOD (  14.15  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: alsa-devel@alsa-project.org, linux-ia64@vger.kernel.org,
 linux-doc@vger.kernel.org, nouveau@lists.freedesktop.org,
 linux-nvme@lists.infradead.org, linux-mips@vger.kernel.org,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 linux-mm@kvack.org, Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>, linux-samsung-soc@vger.kernel.org,
 Joonyoung Shim <jy0922.shim@samsung.com>, linux-scsi@vger.kernel.org,
 iommu@lists.linux-foundation.org, Ben Skeggs <bskeggs@redhat.com>,
 Matt Porter <mporter@kernel.crashing.org>, linux-media@vger.kernel.org,
 Tom Lendacky <thomas.lendacky@amd.com>, Pawel Osciak <pawel@osciak.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org,
 netdev@vger.kernel.org, Seung-Woo Kim <sw0312.kim@samsung.com>,
 linux-kernel@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Sep 02, 2020 at 11:38:09PM +0200, Thomas Bogendoerfer wrote:
> the patch below fixes the problem.

But is very wrong unfortunately.

>  static inline void dma_sync_desc_cpu(struct net_device *dev, void *addr)
>  {
> -       dma_cache_sync(dev->dev.parent, addr, sizeof(struct sgiseeq_rx_desc),
> -                      DMA_FROM_DEVICE);
> +       struct sgiseeq_private *sp = netdev_priv(dev);
> +
> +       dma_sync_single_for_device(dev->dev.parent, VIRT_TO_DMA(sp, addr),
> +                       sizeof(struct sgiseeq_rx_desc), DMA_FROM_DEVICE);
>  }
>  
>  static inline void dma_sync_desc_dev(struct net_device *dev, void *addr)
>  {
> -       dma_cache_sync(dev->dev.parent, addr, sizeof(struct sgiseeq_rx_desc),
> -                      DMA_TO_DEVICE);
> +       struct sgiseeq_private *sp = netdev_priv(dev);
> +
> +       dma_sync_single_for_device(dev->dev.parent, VIRT_TO_DMA(sp, addr),
> +                       sizeof(struct sgiseeq_rx_desc), DMA_TO_DEVICE);

This is not how the DMA API works.  You can only call
dma_sync_single_for_{device,cpu} with the direction that the memory
was mapped.  It then transfer ownership to the device or the cpu,
and the ownership of the memory is a fundamental concept that allows
for reasoning about the caching interaction.

>  }
>  
> -- 
> Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
> good idea.                                                [ RFC1925, 2.3 ]
---end quoted text---

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

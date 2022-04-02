Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06888C433F5
	for <linux-nvme@archiver.kernel.org>; Sat,  2 Apr 2022 12:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Subject:Cc:To:
	From:Date:References:In-Reply-To:Message-Id:Mime-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UxpE6QuX00X/HUxMRxKCgBvn/5U8Qx/FUyad3eii1Ig=; b=JkcLSdIqtKS3BccnCeTM8PbbO/
	HzEXwdIvFHOCuQ+ONC7miNDcFm1gc1AAL0vVz1f3FmewqGTApoVrCVvEn3PSNMMZWgzQpg0QaA7LT
	uWTZz/ry8keimV8gzEplvJl5pngvKYdhnW7elrmvLS7wAKFoZzNifV+L8Da0zgpNk6Ep5wxg7Dgqv
	zcJfAGM7urxg4kcFu8OY/dil0EcW1ynYkOZ3DuCH1B1Qd0OxcS0zdKWi6ij7ml804u+2y1VQhUfFi
	bstVyYExrCkj/DPLmDx+sDoXKWyaRsno15vl4pltTstDF4KezQbWbflRiBTeEoEBPqZyPHmz6sExq
	WIfpVamg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nad3t-008jcE-9i; Sat, 02 Apr 2022 12:41:01 +0000
Received: from out2-smtp.messagingengine.com ([66.111.4.26])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nad3h-008jYU-1B; Sat, 02 Apr 2022 12:40:50 +0000
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
 by mailout.nyi.internal (Postfix) with ESMTP id 6998C5C006C;
 Sat,  2 Apr 2022 08:40:47 -0400 (EDT)
Received: from imap47 ([10.202.2.97])
 by compute2.internal (MEProxy); Sat, 02 Apr 2022 08:40:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
 h=cc:cc:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:sender
 :subject:subject:to:to; s=fm1; bh=UxpE6QuX00X/HUxMRxKCgBvn/5U8Qx
 /FUyad3eii1Ig=; b=NRVaLuof6uXRM33NFhGt86CNu67E3U7Tmp05Ss1kibfRPQ
 o7vjPCayxeTRKdkN6IegAgrFzL1r2RZOoWdBSPSt/WCrQusS3vx4ny3IodNnn+58
 wvYVkBcNDEvvuJAaEb8mk7e0WCtrb9WgipkqttFflPbsmSk9fNoLoRS289Nqy+j/
 R9qmo3RKD35w/CAcA2udmBhtAvAoQERqk+a3qZ+Pd1YAShKdqost+CEEu2jA+FK8
 reBv3WsEaB/NKvF8rLN5cu3zAbfEZi12MZ4A1wYyLu0NzNdWGwoC0ey/B+v3izBi
 QYavYt3rRoXl27qNuYn3tuTii7Q6ls/G/1du5MQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=UxpE6QuX00X/HUxMR
 xKCgBvn/5U8Qx/FUyad3eii1Ig=; b=MwFajUTbCnEhaI5WHuhUuCjqstP5km4TS
 Y7vKUfHF8gt0RRwWqmkuuQTcrVsaOxAj2gqe1FjLkDYT2D9CL3Zi2KKL11e/Bunc
 /tqVSZyhX/Hm5dwccbPC89GB34FIIrkvckdY7KO9eldWtVT69PRQlUrBJZK/hA3T
 glggM8C1licbSFTKb/kl+WTbeuuXtlSCYaKR53mK9zTyqcIwj3pb0JTxICPM7aP6
 U/I3OOD4J3mw/JgiTQiTN1UwYdiBdaIXSz5GrjSplrJkP8CeKs53qg2An2k+QOyI
 TJAO+WdJd9RzgdJoQHllHtU1VJrY006eQWKybfVY4kEkcK3/06mLA==
X-ME-Sender: <xms:TkRIYlv6xAWTabureovStGwqHInBpCq4jjgmIAaJeVPUTny7UosoqQ>
 <xme:TkRIYud2pmt-tdHwLc-Eirmc91Yc5_Eq_aRfj2eQ6XjMT39gmr6PtmPy26x1b30rO
 xTBdpagd4Inu4AmUYQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudeikedgheeiucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdfuvhgv
 nhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrg
 htthgvrhhnpefgieegieffuefhtedtjefgteejteefleefgfefgfdvvddtgffhffduhedv
 feekffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
 hsvhgvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:TkRIYoyCCEvMq3fAXadMPPND5NExvudoj8crmjy4Q7XKwonCAYnlyQ>
 <xmx:TkRIYsPJ3J1Nx6pDfhoFJWqhUjpc3E2IF4uZJkqbSV19a7BkMvWhPg>
 <xmx:TkRIYl_eTurcwYY9nBx3CJiKP0McWYXOt0qeJH9BXJhUNFm8PdGSqQ>
 <xmx:T0RIYm3GNQ_eyr4PL74CxwXS79A_e-c8-MXriHm6Ac4rbztDiAodkQ>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id A654D2740558; Sat,  2 Apr 2022 08:40:46 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-382-g88b93171a9-fm-20220330.001-g88b93171
Mime-Version: 1.0
Message-Id: <28ed16fd-84db-427c-bba0-7f2669f50517@www.fastmail.com>
In-Reply-To: <YjizGmjlAhyU6bC6@rosenzweig.io>
References: <20220321165049.35985-1-sven@svenpeter.dev>
 <20220321165049.35985-5-sven@svenpeter.dev> <YjizGmjlAhyU6bC6@rosenzweig.io>
Date: Sat, 02 Apr 2022 14:40:06 +0200
From: "Sven Peter" <sven@svenpeter.dev>
To: "Alyssa Rosenzweig" <alyssa@rosenzweig.io>
Cc: "Hector Martin" <marcan@marcan.st>, "Rob Herring" <robh+dt@kernel.org>,
 "Arnd Bergmann" <arnd@arndb.de>, "Keith Busch" <kbusch@kernel.org>,
 "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
 "sagi@grimberg.me" <sagi@grimberg.me>, "Marc Zyngier" <maz@kernel.org>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 4/9] soc: apple: Add SART driver
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220402_054049_187792_9183E3F5 
X-CRM114-Status: GOOD (  13.07  )
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

On Mon, Mar 21, 2022, at 18:17, Alyssa Rosenzweig wrote:
>> +/*
>> + * Adds the region [paddr, paddr+size] to the DMA allow list.
>> + *
>> + * @sart: SART reference
>> + * @paddr: Start address of the region to be used for DMA
>> + * @size: Size of the region to be used for DMA.
>> + */
>> +int apple_sart_add_allowed_region(struct apple_sart *sart, phys_addr_t paddr,
>> +				  size_t size);
>> +
>> +/*
>> + * Removes the region [paddr, paddr+size] from the DMA allow list.
>> + *
>> + * Note that exact same paddr and size used for apple_sart_add_allowed_region
>> + * have to be passed.
>> + *
>> + * @sart: SART reference
>> + * @paddr: Start address of the region no longer used for DMA
>> + * @size: Size of the region no longer used for DMA.
>> + */
>> +int apple_sart_remove_allowed_region(struct apple_sart *sart, phys_addr_t paddr,
>> +				     size_t size);
>
> Might it be simpler for add_allowed_region to return a handle that
> remove_allowed_region takes instead of paddr+size? Then
> remove_allowed_region doesn't have to walk anything, and the requirement
> to use the same paddr/size is implicit.

I liked that idea and just prototyped it and them remembered why I have
the API like it is:

In a perfect world this would be an IOMMU and just implement the IOMMU device ops.
In a slightly less perfect world this would implement dma_map_ops and transparently
allow using the normal DMA API inside the NVMe driver.
In Apple's world the NVMe driver needs two separate IOMMU-like filters and you can't
have two separate dma_map_ops without ugly hacks.

This will usually be used just next to dma_map_coherent and dma_free_coherent and
for those you need to keep track of phys_addr, dma_addr and size anyway,
e.g. (with the error handling removed here)

	bfr->buffer = dma_alloc_coherent(anv->dev, size, &iova, GFP_KERNEL);
	ret = apple_sart_add_allowed_region(anv->sart, iova, size);

and later then

	apple_sart_remove_allowed_region(anv->sart, bfr->iova, bfr->size);
	dma_free_coherent(anv->dev, bfr->size, bfr->buffer, bfr->iova);



Best,

Sven


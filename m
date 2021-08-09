Return-Path: <SRS0=jKil=NA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70E56C4338F
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Aug 2021 20:12:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 204F561004
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Aug 2021 20:12:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 204F561004
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=svenpeter.dev
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Subject:Cc:To:From:Date:References:
	In-Reply-To:Message-Id:Mime-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OIVDCJwHFZpedCDDmMUH/Of5lHu16pv7FuMtV7LFYns=; b=ZxH2n0JgX+r7Ua
	n+59NN26O6p70bQMQSequadc6G4YgyU+0WUK974+5DX05w91CFU8+cUsXpdN4/So7KVZVxjLD5NAl
	6YfX10I60DcG+yIVj1EuBe/jAdUQdEelrJRMz1d4iqnbYuP2FEU9hgALo+xLg2LZSDzfcfX4yz6Ti
	FJPlV1hcYI483D1qeHe/gsxCEUMx2AtsVLfVOmG+JMS4pFqV0qkguMStWxbcBkbYLzTassf5eXuB+
	hoxB3H1I4lVdSuQvEpaCpJ8d+HbEKrrX4PgmCXSOD4EJTpQLGatGoTFuR+sNo5PaaFC/JJ/dZ8AmY
	0Z/MzJlANbuyn78QiBfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mDBdF-001utH-OT; Mon, 09 Aug 2021 20:12:21 +0000
Received: from wout4-smtp.messagingengine.com ([64.147.123.20])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mDBdA-001usH-5Q
 for linux-nvme@lists.infradead.org; Mon, 09 Aug 2021 20:12:20 +0000
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailout.west.internal (Postfix) with ESMTP id 578CF3200929;
 Mon,  9 Aug 2021 16:12:10 -0400 (EDT)
Received: from imap21 ([10.202.2.71])
 by compute1.internal (MEProxy); Mon, 09 Aug 2021 16:12:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
 h=mime-version:message-id:in-reply-to:references:date:from:to
 :cc:subject:content-type; s=fm2; bh=6s8fzbIUygledkvuZBDFYHokFGeN
 Wt4DmRTQ57Sn9/E=; b=bmhd6YI5OdZh6QmPr2lxJp8vHmbfBatDJ3lvqH2aCyps
 kuXGbapQ3nn2qPxnqoYJnMqEaa4zALK9NLdwCl3sfriGMFgtynXY/J+XxuWMSCtu
 vIexTEKnLQKbT9Pt+4eYSyI4qKtpvc1Cskdots14c2wAQjKjiGdgLlRhGAhCGItY
 TA1MHoLGlKQcnvuMlp1lR7pQuYzzx6szVuZc/k75XaWVpe2x3+zjhSoWb/dr9+0P
 CQxl3iJ4HvCAM36pVc1gnDakwiGvTgYTq1CL26W4JABgG/3WXlJGcFUiSEYGRZoM
 pOcDFqcXIjnDoI5vy5HPIsxobTCOJHgmMBViyxLPJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=6s8fzb
 IUygledkvuZBDFYHokFGeNWt4DmRTQ57Sn9/E=; b=VeLDZbWNY1q8x2sYgsTIs2
 47YT5oO6CYiCwJO2sDedVkh+0/peWXiBVL18brxHV7wai8ZgKqbmi+AwjXYgkdLE
 qI3HyOtydmIa4sRNxdTLvW9oXN5KGMl0TWlImhfZuA4/piqQRFcS2vFY9G5BYlwQ
 wQ8iiwfwFtU4zVTEH4Oe8PHDKXUsdB6I+ymnFoWMk3VUz4p1GyPX2w6mE+VCdZh/
 /7mSwmUX0w3ASdTADI9/mu3YtsDPke9O+LHLhhBWcexEod0zUHlmNXdNhkMa/ikH
 CYMIoDU0WeWotucfbT8VIcNNMzo6Q0KheO3agxQdeAj2mSACIpYIPxcTa8QVZiEw
 ==
X-ME-Sender: <xms:GIwRYTUfsnZnXsMdcarsuAnsjPwY04tWw6h-PItx8a3tMxJtXCssCQ>
 <xme:GIwRYbkDs5SlTJL43pieyytr4RW6KpKU85LFqN4D4T4Ssf9gZO7OKRu6goLya6n6G
 plnsP6l0E9cdiZhefo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrjeejgddugeeiucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepofgfggfkjghffffhvffutgesthdtredtreerjeenucfhrhhomhepfdfuvhgv
 nhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrg
 htthgvrhhnpeehjefgtddtfeelfeetjeeifeduueehleektdegtdejheeiteeuleehuefh
 geehgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
 hsvhgvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:GIwRYfYjffmojJo-Yez-e5l7qm8O0Kg84goIAlKDvyH3OVKco_Rxtw>
 <xmx:GIwRYeW_QmikIv_pHrHwNdqtgaTbiC1yMGHDEa4HuOYUQ-uO7qeCSQ>
 <xmx:GIwRYdk2MxYu33-LXjMCJMUX2c37CreBxJBIfbM4M30RjOJce5--lA>
 <xmx:GYwRYcuJUgfXN9SncU9dGYttX6jIlMuI2d4ve3ZWTlAGz47Qv_41zw>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 8FC5151C0060; Mon,  9 Aug 2021 16:12:08 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-552-g2afffd2709-fm-20210805.001-g2afffd27
Mime-Version: 1.0
Message-Id: <05dfa9d8-7cee-4431-abe3-4cc583985773@www.fastmail.com>
In-Reply-To: <CAK8P3a1bDeJ56uk74qWxPjyuZwaDf-0mCsH3D5bP+yXWLKLGtA@mail.gmail.com>
References: <202108051646.vdMMUBea-lkp@intel.com>
 <YQ7GVu1TqpqbHZOb@infradead.org>
 <CAK8P3a2t8qAr1q6uf-wuer6rpZnmOmZ1LytO6vOGXKT1DR2OmA@mail.gmail.com>
 <YRE7vCyn9d1ClhRm@infradead.org>
 <CAK8P3a1bDeJ56uk74qWxPjyuZwaDf-0mCsH3D5bP+yXWLKLGtA@mail.gmail.com>
Date: Mon, 09 Aug 2021 22:11:19 +0200
From: "Sven Peter" <sven@svenpeter.dev>
To: "Arnd Bergmann" <arnd@arndb.de>, "Christoph Hellwig" <hch@infradead.org>
Cc: linux-nvme@lists.infradead.org
Subject: =?UTF-8?Q?Re:_[asahilinux:nvme/dev_13/17]_drivers/nvme/host/pci.c:2249:2?=
 =?UTF-8?Q?-3:_Unneeded_semicolon?=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210809_131216_270802_AD129A5A 
X-CRM114-Status: GOOD (  13.13  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On Mon, Aug 9, 2021, at 17:53, Arnd Bergmann wrote:
> On Mon, Aug 9, 2021 at 4:29 PM Christoph Hellwig <hch@infradead.org> wrote:
> > Also can one of you look how PRPs are actually used by MacOS?  Given
> > that this device always seems to be behind a IOMMU creating one entry
> > per page seems rather weird given that the apple_nvmmu_tcb structure
> > already contains the full length.  Maybe it actually ignores all but
> > the first PRP?
> 
> I'll leave this up to Sven to answer. He also wrote the iommu driver,
> so he probably has a good idea of what is going on here already.
> 
>       Arnd
> 

Not yet, but figuring out how this NVMe-IOMMU works in detail was
already on my TODO list :-)

Some background - the M1 has at least four different IOMMU-like
HW blocks:
DART (for which I wrote a driver and where I'd actually know what's going
on in detail), SART (simple DMA address filter required by the NVMe
co-processor for non-nvme transactions), this weird NVMe IOMMU (that
also seems to be somehow related to disk encryption) and GART for their GPU.



Sven

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

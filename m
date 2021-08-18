Return-Path: <SRS0=/QSy=NJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 901EBC4338F
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Aug 2021 06:27:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51E2660FDA
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Aug 2021 06:27:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 51E2660FDA
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=svenpeter.dev
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Subject:Cc:To:From:Date:References:
	In-Reply-To:Message-Id:Mime-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ftpKh6jqtg1azumcRuiB+2vNy7vsDyX2jzycEuX7ef8=; b=d16I36uUgXNzLo
	dMEiNAGSqiZDGYRUZd6Fk3en9sDFXSXsSx6uos9d0vCp41L/+y6c5R6ovgEk26mNBsgvY78kUnpiN
	3vTPOccZduimhX4kEYd2/oh+wODrQ8lA8N/msxp9cIB2bTtl5Hn7xqWZW1HW482Yctj25Bl+hxddJ
	OJa+Lkrm/O3c1Do7ZWkdjuklgrutDvJNZlYma8x2q6BEE7zRPy0Crp/3OPCJWZcm31U3iyz1b6SRy
	m6twwtCg5xZcQ9q2HzC+PwrFFCY3TRJlzI5nWQlPOuVKp16KBYJZstrDjWP0KQ4K0hMX190c+RQy/
	EJMm/f5C/zbjbCc/jkPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mGF3L-004N5p-4x; Wed, 18 Aug 2021 06:27:55 +0000
Received: from wout4-smtp.messagingengine.com ([64.147.123.20])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mGF3D-004N0v-5Y
 for linux-nvme@lists.infradead.org; Wed, 18 Aug 2021 06:27:54 +0000
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailout.west.internal (Postfix) with ESMTP id 836A1320093B;
 Wed, 18 Aug 2021 02:27:43 -0400 (EDT)
Received: from imap21 ([10.202.2.71])
 by compute1.internal (MEProxy); Wed, 18 Aug 2021 02:27:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
 h=mime-version:message-id:in-reply-to:references:date:from:to
 :cc:subject:content-type; s=fm2; bh=mNUlq2pHuxK8EC2gEBCm34DwI6OG
 w6io6wRkQVP+uiQ=; b=hq21U8wd56/BtfmrKggx9tzXcwufIqqvZG+qSTjvencP
 ee0rfsEXoqAyO4WTUHXAz1tAWaTCh/Cvnnw9fLhWjspGk2LJfOKQ/tu9FqeLeX1O
 t9rVFQWBmkX5t9T2/uRi+ARkluYAsKk+04BsgbNQtt3w76dLqomxppIk8PxXON7m
 eJauJVyFj3ZeN9veVXgi5j0dXEGPK5+tBZAFZzHZ6mMKQwFmQASaNotFsco1B6+b
 B9pZMoF8Z+HdGdy50uGTT60YcePImPQNay0zlrISSYaXdH+FppZb+PRYzPNzLJBD
 l7oTRW4a/ANpFm/8LqiSVjEYfiVKuiXlO7m3sUTH2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=mNUlq2
 pHuxK8EC2gEBCm34DwI6OGw6io6wRkQVP+uiQ=; b=qYLvF42BdaHqSI9sFmkfTw
 /8Gj3ldVnq110Cat3YrlLo9KUrzUPDSMRmcwfhc1oeiEu90Slpq9NwZyJUT+RPKb
 51WTabUUQZvTqPUZqK1lyD45YPTx131RP+7xqy0im0rVfoAZgB0b0LM6Cpx3FC51
 K46ImhGwu30n9m7km37TQSifWHK9J53N2Y2X5MzaG+PwqzyWrlzJlfBayXke/tvf
 9IbCAb9SQeOohvf191PMFFqdId3OcP7nf+kf5IOEHFHQCmmXxuFQ+5dCKX7ceCts
 lhUAnOC0mI4m6R5jI/pqeS11/O5SdNV9Y8HSNL3cFALqMubIxr0hjbs6SoYrTkww
 ==
X-ME-Sender: <xms:XagcYXtk57Xxs5mRXPwOL4MZXf7iwHsNaWx6_dFJKmYzUnM4SS0Y9Q>
 <xme:XagcYYdmJuvXs3uRkEOkqO7ptXaBE4Njnc6sJhM55f1NQEBL0aSTI75z2oRNzUP8J
 wOM3Aq0d_QJ66AQWDs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrleeggddutdegucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 goufhushhpvggtthffohhmrghinhculdegledmnecujfgurhepofgfggfkjghffffhvffu
 tgesthdtredtreerjeenucfhrhhomhepfdfuvhgvnhcurfgvthgvrhdfuceoshhvvghnse
 hsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrghtthgvrhhnpefgfeelgeekhffhkeej
 geelhfevkeeiffeftdfhieejtddtkeetveevteevhedtvdenucffohhmrghinhepnhgvfi
 hoshigsghoohhkrdgtohhmpdhgihhthhhusgdrihhopdhsvhgvnhhpvghtvghrrdguvghv
 necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshhvvg
 hnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:XagcYaxJSy1d1AV7dZpq0O6ZQv7UQ-2FZdb8w0ngeH3yT9fD8wd5eQ>
 <xmx:XagcYWNSskQlqwb97qDzJbV-FYWXPlPq3yO3ng91QxCQrnzLgWUzhw>
 <xmx:XagcYX_KeX-irOxuHCWNfcq5XXP2F03-s8dbeV9y29dBeLkqGAEcKw>
 <xmx:X6gcYUFwnzvkjXf2xAfXZeOCWKeoCso4OfYL-B1jrPSynH-EwMv1gw>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id B4B0D51C0060; Wed, 18 Aug 2021 02:27:41 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1118-g75eff666e5-fm-20210816.002-g75eff666
Mime-Version: 1.0
Message-Id: <d133c3f0-1805-4f23-9710-45b31ed5fb64@www.fastmail.com>
In-Reply-To: <05dfa9d8-7cee-4431-abe3-4cc583985773@www.fastmail.com>
References: <202108051646.vdMMUBea-lkp@intel.com>
 <YQ7GVu1TqpqbHZOb@infradead.org>
 <CAK8P3a2t8qAr1q6uf-wuer6rpZnmOmZ1LytO6vOGXKT1DR2OmA@mail.gmail.com>
 <YRE7vCyn9d1ClhRm@infradead.org>
 <CAK8P3a1bDeJ56uk74qWxPjyuZwaDf-0mCsH3D5bP+yXWLKLGtA@mail.gmail.com>
 <05dfa9d8-7cee-4431-abe3-4cc583985773@www.fastmail.com>
Date: Wed, 18 Aug 2021 08:26:29 +0200
From: "Sven Peter" <sven@svenpeter.dev>
To: "Arnd Bergmann" <arnd@arndb.de>, "Christoph Hellwig" <hch@infradead.org>
Cc: linux-nvme@lists.infradead.org
Subject: =?UTF-8?Q?Re:_[asahilinux:nvme/dev_13/17]_drivers/nvme/host/pci.c:2249:2?=
 =?UTF-8?Q?-3:_Unneeded_semicolon?=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210817_232747_372020_2A401951 
X-CRM114-Status: GOOD (  26.42  )
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

Alright, I've observed what macOS does by using the simple hypervisor we
built and tracing its MMIO access. There actually is a single entry per page
in both the TCB struct and the command queue and all entries are used.

The reason for that needs a little more background around XNU and it's
security architecture works:

On these machines, XNU is split into two parts: The main kernel with all its
extensions and hardware drivers, and a small section called "Page Protection Layer"
or PPL.
These machines have CPU extensions that allow them to prevent the normal kernel
from writing to pagetables or accessing any MMIO related to IOMMUs. Switching to
the PPL section is done with a custom instruction ("genter") which changes memory
permissions, such that PPL is then able to modify pagetables and configures the 
IOMMUs. It kinda works like a low-overhead hypervisor that controls pagetables.
There are some writeups available about this if you are curious about
the details [1][2][3].

The TCB structs and the NVMMU MMIO registers cannot be accessed by the part of the
kernel that contains the NVME driver. The NVME driver can only prepare the
command structure and fill the PRP list with entries for the DMA buffers.
It then calls out to PPL, which verifies all the pages listed inside the PRP
are allowed for DMA and then constructs the same structure again inside
protected memory that can no longer be touched by the regular kernel.

Then the NVMMU is configured with this secondary PRP list from inside PPL
before it returns back control to the NVME driver. Effectively,
this prevents someone from breaking into the normal kernel to just DMA
over any buffer they want.

For Linux we can ignore all this and just point the NVMMU and the
queue entry to the same PRP list.



Sven


[1] Jonathan Levin's writeup about the Page Protection Layer http://newosxbook.com/articles/CasaDePPL.html
[2] siguza's writeup about how this was done on iOS https://siguza.github.io/APRR/
[3] my writeup about the CPU extensions https://blog.svenpeter.dev/posts/m1_sprr_gxf/


On Mon, Aug 9, 2021, at 22:11, Sven Peter wrote:
> 
> 
> On Mon, Aug 9, 2021, at 17:53, Arnd Bergmann wrote:
> > On Mon, Aug 9, 2021 at 4:29 PM Christoph Hellwig <hch@infradead.org> wrote:
> > > Also can one of you look how PRPs are actually used by MacOS?  Given
> > > that this device always seems to be behind a IOMMU creating one entry
> > > per page seems rather weird given that the apple_nvmmu_tcb structure
> > > already contains the full length.  Maybe it actually ignores all but
> > > the first PRP?
> > 
> > I'll leave this up to Sven to answer. He also wrote the iommu driver,
> > so he probably has a good idea of what is going on here already.
> > 
> >       Arnd
> > 
> 
> Not yet, but figuring out how this NVMe-IOMMU works in detail was
> already on my TODO list :-)
> 
> Some background - the M1 has at least four different IOMMU-like
> HW blocks:
> DART (for which I wrote a driver and where I'd actually know what's going
> on in detail), SART (simple DMA address filter required by the NVMe
> co-processor for non-nvme transactions), this weird NVMe IOMMU (that
> also seems to be somehow related to disk encryption) and GART for their GPU.
> 
> 
> 
> Sven
> 


-- 
Sven Peter

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

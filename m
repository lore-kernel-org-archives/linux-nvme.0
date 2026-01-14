Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77FF5D39016
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Jan 2026 20:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wZI4xumaE0NsrSqiHiS7XKAxRVJRr8wEGvfxp6B62tk=; b=Wcqd7tSqQMLR5Y0d1gcwB2uZsi
	RFQOokfnIXnXW3unaZYznC6MpQBcIZVjHiXwIMscwO+EF52MMhzyY/hyuu0fYjsVPA2Rud8ovD+yv
	TXMf1SNVijCUFB32aJ609cQMXV2uGPKIlWQ6LRDg/3W3THkxJVpZd14Mx9g9QyImXxNjZjx92/OPe
	853HeWXagUYVdehuzU8ztBkyF2Ry+xd38y82B+vFLvv9E3ikUyhL/MNdyC2ffpSTZQTkNZYKexe1O
	VKaHnVnNAiUACtbCcttOmIuECNkGQQ/lgDUrBbOrLID7nmhG2S2WFh+A/JZTzTJor+79mN5HeDR3d
	kxJ+eWSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vg7Xy-0000000AdY8-1lDx;
	Wed, 14 Jan 2026 20:32:54 +0000
Received: from fout-a5-smtp.messagingengine.com ([103.168.172.148])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vg7Xt-0000000AdV1-0p9G
	for linux-nvme@lists.infradead.org;
	Wed, 14 Jan 2026 20:32:51 +0000
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 4C925EC0087;
	Wed, 14 Jan 2026 15:32:45 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Wed, 14 Jan 2026 15:32:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1768422765;
	 x=1768509165; bh=wZI4xumaE0NsrSqiHiS7XKAxRVJRr8wEGvfxp6B62tk=; b=
	NuwK2ScwOVhjA68Kfl8o/VVEA8tx4E/tEGoZoGkP4eBe870f4IMf9v5RX7QYxUhw
	zn4oPoI9dPCrTfEvWTb8uvs+b3olr1zZmzca3iGATEepFp7I2gwRGg2ECSYkytlW
	gyleFc9M2ZMDxx1nSWjTLPCN5PoptyD9+n5ah7CFG4eLTkvr4TdS2e2kjxABf8Gq
	ZqFFsnIPp9lhMEwxlBrol2yMX6GmvXH5n1aASsxxUUaf9rWbsGyu7t4LL4bhP4yp
	+wjU630BUTOj4LKr6KQZARwxTitCIw+dczS5jrfUxzoMPLgS2fFMKu6SQgU3SzPf
	uyFQsqFTlU2tMe2aQ+5ESg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768422765; x=
	1768509165; bh=wZI4xumaE0NsrSqiHiS7XKAxRVJRr8wEGvfxp6B62tk=; b=a
	UN8y58APlGQNXA1knW8QeZUl9PgTYjoQ+j5PcfDuTszPfiWwVk2uSFxW28aAF/JA
	Bdfr/+RnhpphsRmmGH2tGYCfzI6iGFEnexlZF4jUDfNXj4yw7PRXqS6s0VphAtVT
	DVcZLQ5zY+aYIwPiEwv937cX01JGBjiIrw+bif72PeED0JPxiIIGs9oOiiq6UxnW
	GQSZkeAeBxKcdRVO7k2JpTJ5932AAvMPOnmWLlKMVCYqegf6+gNJHkMoVPhijMSo
	YRu395fk6NMDP2Dz890Fp0DuRGB2w9xTfurHnMem0jSapNuNaGBaLITpiJozAj4K
	XPZiBm9OE6vmrt9c5N9vA==
X-ME-Sender: <xms:bP1nadvDvq9pmpDf6I7WD9TKrWR4iCmHMLcE3C_dbMFT6EuzgQknMw>
    <xme:bP1naW7ctcFRgHaXFBvlR_5xHh2-rjwp6H2au6hUHnN3tK0uiGtn3WVTpWlsHRnmu
    26LHO12LJjA3vEL1rb3NBn35QT8PzZvom5kVc5wAuTt-ucWDJ9T>
X-ME-Received: <xmr:bP1naRer6ECFm8MPOiMQ3zToKxH5f1w55Cg72q2twrnMZJ0gf7jvwllwRbg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdegudegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpeetlhgvgicu
    hghilhhlihgrmhhsohhnuceorghlvgigsehshhgriigsohhtrdhorhhgqeenucggtffrrg
    htthgvrhhnpeejkeeileeuhffgfeeivdeileejkeeuueevkefghfettdejjedvtdevuddu
    fffgleenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhmshhgihgurdhlihhnkhenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhgvgies
    shhhrgiisghothdrohhrghdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtoheprgigsghovgeskhgvrhhnvghlrdgukhdprhgtphhtthhopehksghu
    shgthheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhgthheslhhsthdruggvpdhrtg
    hpthhtohepshgrghhisehgrhhimhgsvghrghdrmhgvpdhrtghpthhtoheplhgvohhnsehk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgslhhotghksehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqnhhvmhgvsehlihhsthhsrd
    hinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepkhgthhesnhhvihguihgrrdgtohhm
X-ME-Proxy: <xmx:bP1nabxpx8_BwEUHbA8-RycygxG0e2sUWQCqd-0WsKXXxvuHnsEEbw>
    <xmx:bP1nae8l3ZVN_HLGbTulWd9f6lU20sRQdCZ0kPPyWhZxMnx_mHqhIQ>
    <xmx:bP1naRziBur5OppeBjXeoNU-wKwfg093ofpGMH2GgqHk-28BccOZ8Q>
    <xmx:bP1naepFAeo_Iw3SldfcmC5GtGB--qBF6qDqtKmg_yEC3aooYLbk9Q>
    <xmx:bf1naRSUFaSv7y_mf8kwe_nr4MLv7sM--tLAum1olFS_iiGpmUo9q706>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Jan 2026 15:32:43 -0500 (EST)
Date: Wed, 14 Jan 2026 13:32:41 -0700
From: Alex Williamson <alex@shazbot.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi
 Grimberg <sagi@grimberg.me>, Leon Romanovsky <leon@kernel.org>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH v3 0/2] block: Generalize physical entry definition
Message-ID: <20260114133241.5b876b40@shazbot.org>
In-Reply-To: <176775184639.14145.18318539882421290236.b4-ty@kernel.dk>
References: <20251217-nvme-phys-types-v3-0-f27fd1608f48@nvidia.com>
	<176775184639.14145.18318539882421290236.b4-ty@kernel.dk>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260114_123249_812790_84EDBB23 
X-CRM114-Status: GOOD (  15.36  )
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

On Tue, 06 Jan 2026 19:10:46 -0700
Jens Axboe <axboe@kernel.dk> wrote:

> On Wed, 17 Dec 2025 11:41:22 +0200, Leon Romanovsky wrote:
> > Jens,
> > 
> > I would like to ask you to put these patches on some shared branch based
> > on v6.19-rcX tag, so I will be able to reuse this general type in VFIO
> > and DMABUF code.
> > 
> > --------------------------------------------------------------------------------
> > Changelog:
> > v3:
> >  * Rebased on top v6.19-rc1
> >  * Added note that memory size is not changed despite change in the
> >    variable type.
> > v2: https://lore.kernel.org/linux-nvme/20251117-nvme-phys-types-v2-0-c75a60a2c468@nvidia.com/
> >  * Added Chaitanya's Reviewed-by tags.
> >  * Removed explicit casting from size_t to unsigned int.
> > v1: https://patch.msgid.link/20251115-nvme-phys-types-v1-0-c0f2e5e9163d@kernel.org
> > 
> > [...]  
> 
> Applied, thanks!
> 
> [1/2] nvme-pci: Use size_t for length fields to handle larger sizes
>       commit: 073b9bf9af463d32555c5ebaf7e28c3a44c715d0
> [2/2] types: move phys_vec definition to common header
>       commit: fcf463b92a08686d1aeb1e66674a72eb7a8bfb9b

Hi Jens,

I see this is currently on your for-7.0/blk-pvec branch, thanks for
splitting it out.  I haven't seen this merged into your for-next branch
though, which gives me some pause merging it for a dependent series
from Leon.  Is there anything blocking that merge?  Thanks,

Alex


Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE17FCA1009
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Sep 2025 10:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jNNb+nr/hFKdcw+MyWg50Siwcv+G2MEA1WmLkk6R+24=; b=IRIbql3cqDD7aIgFoH0m6mk0/R
	jpZVsnQo7DjfmHUk+CipgtLnUov7AvXvbLxGUWO+8EuFvvBTYycq/nnmYK5fwwQjjpR1ONSpMQCXb
	d1DWUGYeIA+CfJYWifmQaFCUllhs74q2VtU12QbdXE1bNc47DVOztxxcbEn54U8xBCtlLl4DxbMyC
	xE5i0grjoz21z+r1ZTXOOXWM/NFEWn84iC427SAKezwAkulNSEHPk4nTGjjgYHwqNu8V9ESPrxfTt
	H4ZUEIMEhH9lpM7aFc2xWO4IAltPSDrGUJ0A/vAqif1XSo8awLqot+wfbkzUTdXGLnrFmAu7xaZMq
	5Pq2ziRg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utl6f-0000000693R-495J;
	Wed, 03 Sep 2025 10:52:49 +0000
Received: from fout-a5-smtp.messagingengine.com ([103.168.172.148])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utkBI-0000000606i-322b;
	Wed, 03 Sep 2025 09:53:34 +0000
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 6A797EC0336;
	Wed,  3 Sep 2025 05:53:29 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Wed, 03 Sep 2025 05:53:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1756893209; x=1756979609; bh=jNNb+nr/hF
	Kdcw+MyWg50Siwcv+G2MEA1WmLkk6R+24=; b=pXoYO4uNcVZuUx9Lb0lz/ceknJ
	VORA4T5rp/2utYlvIq/8FCigI1G2XxgMf2/f0gtvW20zmDflVKBUbuQwcjlkcLGk
	BCBXtv6OZjTs5CfVP9rBI8gloI+8kHsKA9iEfm5urKuWjK1c+XqnsFtzhGkYzac1
	pWC7Yb0rtiuvSSP5uBzlClipQA4dQOHtWxvF0MmcWEfXTvTPyulpJaKlcVDnKk69
	VExqh/IB8N0UeSYuyS36M33Vm3i/3xIheVXth8eCbUL4/WNPzcV9A8goig4tda9B
	fXwyxnIMZNQFS260aPWVPGC4abO/ls7C3t7XP52RQDLFd/OPdEgZA0wgpkxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756893209; x=1756979609; bh=jNNb+nr/hFKdcw+MyWg50Siwcv+G2MEA1Wm
	Lkk6R+24=; b=WZpPJKSuPdSVvsUz8WkC51Yhv7zyC3tkBUR6DeoxnRR3wM8R/mi
	3DDfpSWxr3nlfbv4g1zYSnehh4MZndgr4D/T6Phn3PuuYCDuujxHzDtPXGo08t9/
	YRY1yeyVra9XZAvf4FGa6FaFLh8GvPKz0mDJllwn9HF+dRT2rPPx4OpeRWbWsWFM
	aszLMJzSK/sL0BQ2ClWVNiDONcYJYTyHYu0VlEus2PoMhWJGsrxU1skSV1i9g+tl
	8X5FRWtFicWL4gI87JsUbgGh/s3PpjmN5mkhdLIAX1T31j1KdUD3NqEvrjyighzB
	mJiXM4iFrlJJDXrYnOnWJ8ElIL7ktYkMv8g==
X-ME-Sender: <xms:FxC4aG1qr09vvHwIJ4hRbt7dkIQxbA0fvsqT7xu7-Qa-EuI1Y0SAtg>
    <xme:FxC4aMkjjJBlZaG1qNx88mBDxwo_Xhu75G-jqvsAUqKkRP9XRf8eRjyuRp5rPUJ8r
    n4Wt8-hhISP1shtCe0>
X-ME-Received: <xmr:FxC4aHZ5L4UDCpYxS4iPuJ2jp77oF68P09_Bh3agX1CIy18Cb4gvlewcgjaINc4RmuJVrWjOvYwkXbvqBUJgZ6aLOCp95D_yeWw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomheplfgrnhhnvgcuifhr
    uhhnrghuuceojhesjhgrnhhnrghurdhnvghtqeenucggtffrrghtthgvrhhnpefgvdffve
    elgedujeeffeehheekheelheefgfejffeftedugeethfeuudefheefteenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjsehjrghnnhgruhdrnh
    gvthdpnhgspghrtghpthhtohepvddvpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehhtghhsehlshhtrdguvgdprhgtphhtthhopehsvhgvnheskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepthhofihinhgthhgvnhhmihesghhmrghilhdrtghomhdprhgtphhtthho
    pegrlhihshhsrgesrhhoshgvnhiifigvihhgrdhiohdprhgtphhtthhopehnvggrlhesgh
    homhhprgdruggvvhdprhgtphhtthhopehjrghsshhishhinhhghhgsrhgrrhesghhmrghi
    lhdrtghomhdprhgtphhtthhopehrohgshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epkhhriihkodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghonhhorhdought
    sehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:FxC4aKpXGXfqNRJtXU3bKWXf82Z1HtC8gg6cm1QSI4juZ64CPJpJvA>
    <xmx:FxC4aNgClrkAVGxrPUSoA5iIA9dD-IuPEqmWHNN_kwc6d3MH4dldvg>
    <xmx:FxC4aMxWuRIbQ_rTseCZMo3e5lePw_bkoEo1iX_61QGtyH-FqaYTug>
    <xmx:FxC4aL8MmHW_zqynwVULmAhwl-4ii_YK6UIH_NVlSD4x8Q_GitvppA>
    <xmx:GRC4aNXiqaEM5KtsXta-J8fDubHw9ulAUXUwLhYT3ONsidDAlYyK2-Ol>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Sep 2025 05:53:27 -0400 (EDT)
Date: Wed, 3 Sep 2025 11:53:25 +0200
From: Janne Grunau <j@jannau.net>
To: Christoph Hellwig <hch@lst.de>
Cc: Sven Peter <sven@kernel.org>, Nick Chan <towinchenmi@gmail.com>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Neal Gompa <neal@gompa.dev>, Jassi Brar <jassisinghbrar@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Hector Martin <marcan@marcan.st>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, iommu@lists.linux.dev,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3 7/9] nvme: apple: Add Apple A11 support
Message-ID: <20250903095325.GA89417@robin.jannau.net>
References: <20250821-t8015-nvme-v3-0-14a4178adf68@gmail.com>
 <20250821-t8015-nvme-v3-7-14a4178adf68@gmail.com>
 <20250825080710.GA23193@lst.de>
 <89251134-9685-439e-b220-92717663f038@kernel.org>
 <20250902052646.GA11139@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250902052646.GA11139@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250903_025332_978628_6CD72197 
X-CRM114-Status: GOOD (  17.84  )
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

On Tue, Sep 02, 2025 at 07:26:46AM +0200, Christoph Hellwig wrote:
> On Wed, Aug 27, 2025 at 05:56:33PM +0200, Sven Peter wrote:
> >> Do you want to merge this through the apple SOC tree?  If so:
> >>
> >> Acked-by: Christoph Hellwig <hch@lst.de>
> >>
> >>
> >
> > I don't think that's necessary since there are no build time dependencies 
> > but if you want to I can take it through there.
> 
> Merging it through nvme sounds fine as well, I just through up
> grabbing everything together would be easier.  I also noticed there's
> another Apple hw enablement series that touches nvme, so I guess both
> should go through the same tree?

yes, they should go through the same tree if they go in the same cycle.
They conflict in dt-bindings and possibly the driver. We should avoid
burden someone else with this conflict resolution.

Janne


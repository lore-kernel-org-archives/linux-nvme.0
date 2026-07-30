Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A693C55162
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Jul 2026 14:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CsVyAHTj9KASWm8xPmBrjQBBsW9y/NmxPWYlZm9qQ8k=; b=ribE2y8clx3iwzugqmclfjQuKc
	dZ2npUoO3TSJtyt2XoSAvDofCbLcsiRMl8sf2yoxYP1JcO5/+V4wQRu6P+IBShfv3Id/i1EvmF8Zm
	LImkJ5WtPCvXiHLj6wKGF8VI23UToaJkFo56ZEGKPDLCHrpogDcrj4RIOYOQ2Feu/uG5AAUH4OWh5
	AovyjkzvyAf+EdW4MOhcVSh1mQR5o2cx3EWl/arMt4CEFSd16T5I63uG4ElhbibG7wuuKsw3XGeEb
	6K5ZFz5DPXYikJQ1kvRZN/a13U1Fhoa5V2TYnSJUTnnjowawCXmcK/fLZ4NMiKjMOHBBWtNVqzGJ3
	OvwnO2zw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpRj6-0000000Ak93-08cW;
	Thu, 30 Jul 2026 14:27:12 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpRj4-0000000Ak8t-0zgF
	for linux-nvme@lists.infradead.org;
	Thu, 30 Jul 2026 14:27:10 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id C851243E03;
	Thu, 30 Jul 2026 14:27:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 535DC1F00A3A;
	Thu, 30 Jul 2026 14:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785421629;
	bh=CsVyAHTj9KASWm8xPmBrjQBBsW9y/NmxPWYlZm9qQ8k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=e/7nxGKuYCKRYoG7zYuAOV0k8zgwH3+x+keQXSDvu3NEfarYOsSm+u+W5fKMZPlr2
	 ImEqmPTEJHlRbnnJL+BK5ZZ90r4Qwu75B6hga3f3eWfSGb4huaizZBHwaavpbDvxly
	 tvBZQ8nKdamQp/iS9uxs9zk4wPwnaKvEvQkKTOFoQCAoigR9sRKXMHnVwMwof9mLcF
	 DUxyFjzl+teAgXICm9xXcXPGdLRAj2qX1m2c2/mDwVMmYqx2Qtj8FhAoZArkwmYl50
	 seEtsP2wWTrMPGc7rqiHH5TMN/+4hhyTTIPEnGvHdZjDV5Un2XOwoX6IFN+mZkp2mL
	 ozNN0T5FrNmhw==
Date: Thu, 30 Jul 2026 08:27:07 -0600
From: Keith Busch <kbusch@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Christoph Hellwig <hch@lst.de>, Hari Mishal <harimishal1@gmail.com>,
	Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>, Kanchan Joshi <joshi.k@samsung.com>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] nvme: drop WARN_ON_ONCE on write_stream bounds check
Message-ID: <amtfOzqITuEbYL3g@kbusch-mbp>
References: <amdqKEI44SKwq-K2@kbusch-mbp>
 <2026072748-unpopular-onlooker-4a2b@gregkh>
 <amfg_OFiyDadWb3v@kbusch-mbp>
 <2026072849-uproar-aqua-07c3@gregkh>
 <20260728051838.GA20593@lst.de>
 <2026072834-buffoon-entwine-ed16@gregkh>
 <20260730114123.GB25956@lst.de>
 <2026073003-primp-granular-c176@gregkh>
 <20260730133726.GA2983@lst.de>
 <2026073049-improper-paparazzi-6be7@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026073049-improper-paparazzi-6be7@gregkh>
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

On Thu, Jul 30, 2026 at 04:04:03PM +0200, Greg Kroah-Hartman wrote:
> It's only the systems that have panic-on-warn enabled that need to worry
> about user-triggered calls to that macro, and those systems know what
> they are getting themselves into, including the huge number of CVE fixes
> they then need to be responsible for backporting :)

This is a bit of a rug pull. We've long held the pattern that WARN is an
appropriate macro for conditions that should never happen, but don't
leave the system in an unrecoverable or compromised state. For
unrecoverable conditions, use BUG. It has been a valuable tool for
debugging and bug reporting.

If this is the new way, can we get a WARN_NO_PANIC so that we can
replace every instance of WARN with it? Then we can delete WARN and
lighten the CVE load.

I'm not advocating for WARN's in paths triggered by buggy or malicious
users, but we don't need panic-on-warn to justify removing those cases
either.


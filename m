Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAC9BC5CFCF
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2026 22:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jsU+x82WmlajkDCJyuwvAb1ngGFbDbQuk3q0k9VNyK8=; b=Iehf98duYyHhiz8uqZcvRH+C2G
	WNycglpb6UeizStjR6eYT1/ZGhn8iTT1El/b6QsQ+TySrmiJyE6aMvJJJsvQTZDjYoYuxsG9sRAL2
	wYYVDYI5EH3rkGVcP8hcYx1AIcb9rjeRpIp5se7gbYPV2K07qo9io4HCqSvivXV5hhiIEJAs5jWLI
	T7yx4WLwg4s/O7fnZEi4iRWv3zx9Ox6EpEYZ9o54WFvP7sq8JEans91MMjjQDkDaWBveXvimWKUs9
	FoxU6eW7KdeyZHj0GYX628dYAkBOr9BLWK2G3HouxTfHN7fWg03UxkutSEDaMpIIEd13Gp5jxrbBi
	yfB34lMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wv0Cd-00000003FtW-0GHv;
	Fri, 14 Aug 2026 22:16:39 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wv0Cb-00000003FtJ-03dp
	for linux-nvme@lists.infradead.org;
	Fri, 14 Aug 2026 22:16:37 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id C072140964;
	Fri, 14 Aug 2026 22:16:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51E8C1F000E9;
	Fri, 14 Aug 2026 22:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786745795;
	bh=jsU+x82WmlajkDCJyuwvAb1ngGFbDbQuk3q0k9VNyK8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=af8HbGgthUZ+fERKOMj72iKEQoh04Cs4ok0rdxM7e7rQ4qbi4xCicToTQwNONSf3F
	 6HvxA5Rt/5kF8+zh9L7DRYe/v1PfYhVZn1ofXvaDF8SwXXurFMWmKaPPutSBmAhan8
	 SB41xegzOG5PGGn9WqJna1lVBeOv7+xt2l5RF8jSoOU/LFJguWQDZFZ6krDL6yopZW
	 0hSLCuZgkU3ON9GMXokQDqzX4AkvgAEXW57aM8FwJBP3CtmlzR2ITxm8kbC2NE9bsU
	 TQRAYYA2Wmt7imHRbZM7rvmuu9/ikH+mG4NSQWttYzTaRwzAeJGJzLaMOdRjF5dzIa
	 0TMGOg28SwO1g==
Date: Fri, 14 Aug 2026 16:16:33 -0600
From: Keith Busch <kbusch@kernel.org>
To: Anuj Gupta <anuj1072538@gmail.com>
Cc: changfengnan <changfengnan@bytedance.com>, axboe@kernel.dk, hch@lst.de,
	sagi@grimberg.me, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, Guzebing <guzebing@bytedance.com>,
	anuj20.g@samsung.com
Subject: Re: [RESEND RFC PATCH v2] nvme-pci: add adaptive interrupt polling
Message-ID: <an-TwefeWQTSM1ZH@kbusch-mbp>
References: <20260806031058.40176-1-changfengnan@bytedance.com>
 <ano6o6i4Yr2JfMgu@kbusch-mbp>
 <d9210bcdf73fbe1ac8b6ec132865609a3ed68688.9f189e7a.e65a.4eb9.b86b.c83b70bebfb9@bytedance.com>
 <anuGRKqdCFG9381L@kbusch-mbp>
 <d9210bcdf73fbe1ac8b6ec132865609a3ed68688.0698c0c0.7344.4eb9.96f0.08703e79ece6@bytedance.com>
 <mxcthoo4vrlki7smlaqwh64hdyjkuovjrfzsyzdma4ktcrrc4k@g4dph2ouwnbv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mxcthoo4vrlki7smlaqwh64hdyjkuovjrfzsyzdma4ktcrrc4k@g4dph2ouwnbv>
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

On Thu, Aug 13, 2026 at 09:15:31AM +0530, Anuj Gupta wrote:
> 
> I also had a similar assesment on DIM. Emperically, with Keith's POC
> interrupts per IO drop from ~1.0 to ~0.29 but with a small performance
> regression (572K -> 557K IOPS). With your original approach they drop to
> ~0.03 with a 23% performance gain. The DIM machinery overhead maybe
> outweighing the partial interrupt reduction.

I may ultimately adandon this suggestion, but it looks like a major
factor in performance loss was from using IRQ_WAKE_THREAD with sleep
cycles instead of the softirq hrtimer. Just changing that is getting me
back to performance parity, but since it's not any better, perhaps the
hill climb is a worse algorithm than trying to reason out the delayed
poll time directly.


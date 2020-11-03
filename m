Return-Path: <SRS0=7iC9=EJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55D92C2D0A3
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Nov 2020 09:23:36 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2DF122384
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Nov 2020 09:23:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cpPMmHII"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2DF122384
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=HtrmRJfp5q+CLpo4mtgB438BqQPrk/whlPqN2V9iMgQ=; b=cpPMmHIIUAT5P55yppQODrZSF
	Xi7P48T4uvSDDGOmBNUgJDiO7cKUHH3PvrUV3eLrL/kOCXmu9XH9MA1Yi8hKFJj0EZA/cI+I/JqpK
	pCPA4q8gadP7wDayXJnWqHbdxjFV74lYWgrm/LlW7K6iXR8NHoNqapO5nSWzGCgqxHfnCKt6oDGQG
	jFYyR9wVboHXJw6+G4g/jByktM3Pl0XBlqa8yWm4TLG4ZVxEv7VDBZT8iELrPT9YKtmtz/YJncRv7
	XReDBkKGCTSqTwKpINrYcpPhK1F7XUjIjn5y6OPqRRFrLGx1JToGJpktyBdshwwphqTa+6VKF2fKs
	WnNYs1s8w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kZsXF-0005Rp-G7; Tue, 03 Nov 2020 09:23:25 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kZsXB-0005Qw-Cs
 for linux-nvme@lists.infradead.org; Tue, 03 Nov 2020 09:23:23 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id D53A768B02; Tue,  3 Nov 2020 10:23:18 +0100 (CET)
Date: Tue, 3 Nov 2020 10:23:18 +0100
From: Christoph Hellwig <hch@lst.de>
To: Gloria Tsai <Gloria.Tsai@ssstc.com>
Subject: Re: [PATCH V3 1/1] nvme: Add quirk for LiteON CL1 devices running
 FW 220TQ,22001
Message-ID: <20201103092318.GA16071@lst.de>
References: <20201028091421.GA667673@image-900X5T-900X5U>
 <20201029145529.GA19011@lst.de> <20201102181327.GD20182@lst.de>
 <HK2PR02MB4004EE20977D0B14516B030AEE110@HK2PR02MB4004.apcprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <HK2PR02MB4004EE20977D0B14516B030AEE110@HK2PR02MB4004.apcprd02.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201103_042322_038029_A37C181E 
X-CRM114-Status: GOOD (  14.16  )
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
Cc: Jongpil Jung <jongpuls@gmail.com>, Sagi Grimberg <sagi@grimberg.me>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Jens Axboe <axboe@fb.com>,
 "jongpil19.jung@samsung.com" <jongpil19.jung@samsung.com>,
 "dj54.sohn@samsung.com" <dj54.sohn@samsung.com>,
 Keith Busch <kbusch@kernel.org>,
 "jongheony.kim@samsung.com" <jongheony.kim@samsung.com>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Nov 03, 2020 at 02:21:16AM +0000, Gloria Tsai wrote:
> When host issue shutdown + D3hot in suspend, NVMe drive might have
> chance choosing wrong pointer which has already been used by GC then
> cause over program.
> Do GC before shutdown -> delete IO Q -> shutdown from host -> breakup GC -> D3hot -> enter PS4 -> have a chance swap block -> use wrong pointer on device SRAM -> over program

Aka there is data corruption?

> The issue only happens in simple suspend (shutdown+D3hot) with specific FW on Kahoku board.

Kahoku is a specific LiteOn controller?  Or it is the host system?

Maybe main issue with this patch is that it mixes up two axis:

 - use power states for suspend despite HMB on specific host systems
   identified by the DMI ids.  This kinda makes sense to me, as
   the power state based suspends has lots of advantages, so having
   a whitelist when to use it seem ok, despite the clutter that this
   causes.
 - then tie this to specific NVMe devices that don't work without this
   quirk, which leaves open the issue what we do when we encounter such
   a device in a different host system.  If shutdown + D3hot causes
   problems there is seems like for the case where the above quirk doesn't
   apply we should just skip the shutdown and let the D3hot do a surprise
   power removal?  That's mean recovery when coming back from the suspend,
   but would cause less corruption?

In other words I think this needs to be two patches:

 1) quirk based on the DMI table and allow power state based
    suspend on given host systems even when a HMB is enabled
 2) quirk based on the nvme device (and if possible use the PCI IDs)
    to disable shutdown before suspend (possibly with a warning printk
    when this happens)

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

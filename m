Return-Path: <SRS0=1rws=HL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C43A1C433E9
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Feb 2021 03:13:06 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57AD264E75
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Feb 2021 03:13:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57AD264E75
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=1vHfLOLBwqTyP4O3ljCjRL+zUN5E57IhjyURadSTYek=; b=sgeIddV8+Nz7NLaKPd0MZb90K
	gP0Qr5WqWJl5M9N6NOQjK0fvG5RXLgvRQMBQWtR2tr78ng77oJBzbytKxHnJ3eWukbuEWslfUA3aj
	DnoVIKDw/9ptaCeV1HCHBVijIBKA42v7nZENg3GbMfmDZExeh+S6AJEiY8I3BvFTxZUlJfx2SKpWf
	ibDTdvZYo6LJIJV0qqNoqm/8g0KXIbx8IfoAIpfHLGdaHRH7+xDhm4lW8JTYwDBmuMTq2dBv5Ku1r
	0yC0dvP29Zatmx8EmjFoUNNoOErR4/hjaz5fodsFimisFK1PvDyzG1T+YMEE4rOJ6hi0wzy5daVk0
	6kGgPaYVw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l9JSU-00088U-Vg; Tue, 09 Feb 2021 03:12:59 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l9JSS-000886-3Q
 for linux-nvme@lists.infradead.org; Tue, 09 Feb 2021 03:12:56 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id AE3F964E75;
 Tue,  9 Feb 2021 03:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1612840375;
 bh=4r4s2M3Tg85hHPI0KIImG880VSxEf9nXbsVtCyXtwOU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=FccHP4jtg3NatGDMzzwdwubllVWy0QW73odfJxSYizBU1Im4D9pfXiujt+ziy8QZa
 DNO4GvXnfHz3ezE8G2O38CTbe9UQWc+VBRU+c2T/1O13m68UGJl5ZVghuhr6zdl5SM
 PMyWUt33k7MAf2aXucX/CbDSKWxb+awpdPSd3fYTtb7R9zlyi+N2ZhIq6nQb/l6Cuz
 5Z0pxthjz5c5+owfGPHaAUDywM/cQGk3yCB+FIp0R/JlT7R+Rw0ieGOJ3SrHiLmMX4
 3yLC+QcTINh0gIXtzezHSMJ7Bv8JzCCH43uq0Fs/gI+gSeCdjWNLr9bkuEpCvqNOxG
 oTMvaBGdY/vRQ==
Date: Mon, 8 Feb 2021 20:12:52 -0700
From: Keith Busch <kbusch@kernel.org>
To: Clay Mayers <Clay.Mayers@kioxia.com>
Subject: Re: [PATCH V2 0/2] nvme: Support for fused NVME_IOCTL_SUBMIT_IO
Message-ID: <20210209031252.GA97526@C02WT3WMHTD6>
References: <20210105224939.1336-2-clay.mayers@kioxia.com>
 <20210125195844.1390581-1-clay.mayers@kioxia.com>
 <BYAPR04MB49650B6342C736B5268F833686BC9@BYAPR04MB4965.namprd04.prod.outlook.com>
 <b5c179e3eb904800931712d6b92cfbeb@kioxia.com>
 <BYAPR04MB49652EA8F4CF06D41C708E2386BC9@BYAPR04MB4965.namprd04.prod.outlook.com>
 <b2a0593cd1fc4f239bbd44f3f43d4bcd@kioxia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b2a0593cd1fc4f239bbd44f3f43d4bcd@kioxia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210208_221256_294987_6AAEFD98 
X-CRM114-Status: GOOD (  17.73  )
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
Cc: Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Feb 09, 2021 at 12:53:17AM +0000, Clay Mayers wrote:
> Is there any other feedback on V2?
> 
> My main concern I have about my implementation is how fused requests
> are tunneled through the mq request layer.  The 1st request is marked as
> started but it won't be in the device until the 2nd command is queued.  As
> Keith pointed out, a device reset can split the two so care must be taken to
> correctly handle this case.  Despite this, I thought this was a better approach
> than modifying mq requests to be fused.  Especially given Christoph's 
> concern of cost vs value.  This is the lightest touch I could come up with.
> 
> Further consideration of this patch may need a more compelling use case.
> I've worked on a proprietary storage systems that relied on fused NVMeOF
> support so it seems compelling to me.  There's a comment in target/core.c
> that there is "no support for fused commands yet" implying it's been
> considered.  Is pci only support for fused too soon or too little?  What would
> make it more compelling?

The complications it introduces to the IO path and error handling for an
archaic feature has me on the "Nak" side. NVMeOF was introduced well after the
spec define Reservations, and the kernel has supported that capability for many
years. I'm not aware of any other use case for fused commands, so it appears to
be dead weight in the spec.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

Return-Path: <SRS0=9U1b=CX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAEBFC43461
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Sep 2020 22:10:07 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A409C208DB
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Sep 2020 22:10:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="saaZch9a";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="iG3sbmf+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A409C208DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=KowWDCOHSYPDjrRvD8A8E1G4UdKFrE8O4zAg93vS+ow=; b=saaZch9aiDECfQMwe1VxnjxQG
	lbZgNy4keCupXozUoeLjE9RDjzyu/Z4eabQLnekuO2xeGhHloKk9/tNVzqGCesMAT7ismSILfKTIJ
	Y86N1biavSTLFxdCQFIBUjkhzAeg9cI65koPhPyf83TeOgBrT1v5ic4RZkqkBqNR7RT6hHmyWiREY
	SNhrpVm9SaGe1gbfibsRUmDL/XfFfxNd2XmZTAzetJQ9aPDR+giVEThTIVQ4adTyTv6Pp2SEFlvXd
	RNvBAHFDa4S9rOiS3PxI/7BTrmAUQhMz08btlixmpv58/aMgTtquzdJe0JTL8F5uQ4AWcAzcloUC7
	IzZ2SB/UQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kHwfk-0000KL-8M; Mon, 14 Sep 2020 22:10:04 +0000
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kHwfb-0000JE-Lm
 for linux-nvme@lists.infradead.org; Mon, 14 Sep 2020 22:09:56 +0000
Received: by mail-pg1-x541.google.com with SMTP id 7so841559pgm.11
 for <linux-nvme@lists.infradead.org>; Mon, 14 Sep 2020 15:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=osandov-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=ZfVGsGkC0J6kcceXBBtlfVrTqXHCrQSdzH/zUBV3UYs=;
 b=iG3sbmf+Brl3OB8FA+CIDCGs3/JYZPLq9vZsEUqwbkFd1uwxWWwKOxxm5Vr9T7jV77
 L3z7RzbM7d1SOONNFC+xUuj8UGcybsJib0IKsExz5Ob5qwV3lnmua1be1GYZm5NLL0sD
 67A7R4XsKM1enP/xfmzXb93lWezNZjm7dbqlJ4RXnuJC7EcxBeDNskP1slQsi7WpEmS1
 EzP9pbmcJDdZcP6WkermSd2LRv2VBnVNKW/eV5wmGBjEg6PSJybQkFj9l+yRb/nCWZWG
 h0LAvblHiFhBA8XgG6Q3ka/FaYUl8e6PrOXbzNO8MF+dlw5SDd51JCGV2WNPxJlYav7M
 d9kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ZfVGsGkC0J6kcceXBBtlfVrTqXHCrQSdzH/zUBV3UYs=;
 b=bqjQDF4GpbUN84J3l0X1r0jyEwtROthTPpECRpn6JZqmyjM+7kj1/Qf9CRQBCrd4MP
 ICLBPvLfZG1okgU59+IoRdJycE1aYzPxHFL2snqw8u2eVsfheIeyYjeScSkn7LvkWCoa
 R7ITtVypHH60OCHKBOkO/R2gZsTdPGdzCb2PRPHQ+SAEooZHSKAagtE1jhb3HM6k8o8P
 Rt2KdYqS7w/jXSwMOHeNtbQOo3WsAZ/3G4YtpIQit+cEaF3xUpv5IfKLuAURaw/ZDBGr
 LPVAA17aXosujorxeovLUH0zOiz1+Ab1rCXh0Wu6L0OcGQ6rKcIcvoNINiA9BxZf2eX+
 O5GA==
X-Gm-Message-State: AOAM530ix+7OJ0XoISXopl1tQh5cw88kSqk60SBOCpHNEBsny4TMaOhj
 ALtormJ/Z19so0rsRrymhZX3qw==
X-Google-Smtp-Source: ABdhPJxGwlTZm+BIixV7cmsgTx+x9TRaDRYz1Y2lOLY3Om9AzrCD6hb0aN3F5BWDySxpvtfKtlyGfw==
X-Received: by 2002:a63:f53:: with SMTP id 19mr12492667pgp.26.1600121393447;
 Mon, 14 Sep 2020 15:09:53 -0700 (PDT)
Received: from relinquished.localdomain ([2620:10d:c090:400::5:1687])
 by smtp.gmail.com with ESMTPSA id 64sm11297529pfd.7.2020.09.14.15.09.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2020 15:09:52 -0700 (PDT)
Date: Mon, 14 Sep 2020 15:09:51 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH v7 1/7] nvme: consolidate nvme requirements based on
 transport type
Message-ID: <20200914220951.GD148663@relinquished.localdomain>
References: <20200903235337.527880-1-sagi@grimberg.me>
 <20200903235337.527880-2-sagi@grimberg.me>
 <20200914215145.GA148663@relinquished.localdomain>
 <1c502865-5ac1-9952-1b79-fef0f61749c6@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1c502865-5ac1-9952-1b79-fef0f61749c6@deltatee.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200914_180956_066317_518A37A0 
X-CRM114-Status: GOOD (  21.93  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Sep 14, 2020 at 04:04:59PM -0600, Logan Gunthorpe wrote:
> 
> 
> On 2020-09-14 3:51 p.m., Omar Sandoval wrote:
> >> diff --git a/tests/nvme/002 b/tests/nvme/002
> >> index 07b7fdae2d39..aaa5ec4d729a 100755
> >> --- a/tests/nvme/002
> >> +++ b/tests/nvme/002
> >> @@ -10,7 +10,8 @@
> >>  DESCRIPTION="create many subsystems and test discovery"
> >>  
> >>  requires() {
> >> -	_have_program nvme && _have_modules loop nvme-loop nvmet && _have_configfs
> >> +	_nvme_requires
> >> +	_have_modules loop
> > 
> > Bash functions return the status of the last executed command, and the
> > requires function needs to return 0 on success and 1 on failure. So,
> > this is losing the return value of _nvme_requires. Just chain multiple
> > checks with && to fix this (here and the other places _nvme_requires was
> > added with other checks):
> > 
> > requires() {
> > 	_nvme_requires && _have_modules loop
> > }
> 
> I noticed this too during my review, but based on my read of the current
> blktest code, the return value of the requires() function is not
> actually used. It seems to only check if SKIP_REASON is set.
> 
> If we want to ensure the return value of requires() is correct, perhaps
> we should check it after we call it and then consult SKIP_REASON? And
> WARN or fail if SKIP_REASON is set when requires() didn't return 1.
> 
> Also, we need to do more than adding &&s... _nvme_requires() will need
> to be fixed up as it calls other _have_x() functions and ignores their
> return value.
> 
> Logan

Oops, you're right, I actually changed this a few months ago in
4824ac3f5c4a ("Skip tests based on SKIP_REASON, not return value").
Totally forgot about that :) IMO it's still cleaner to chain them
together.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

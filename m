Return-Path: <SRS0=FbzM=CZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EA04C433E2
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Sep 2020 23:52:00 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF82522209
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Sep 2020 23:51:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="or0LphBT";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TPOdR/4t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF82522209
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=lzIuZNhWYKiRV+A9uoefURDxzdbKKAVfCouqCAioRl8=; b=or0LphBTvt4SBaTmZKirpa8w4
	d4/CVRZ/FK4RqzDMXDGuI5MpXqQF6gf2OpLq1O/RhVLTWNstH34sq2lsxky1UC+ZUNR0SjIarvXfg
	r8sZ2LO0KVczvAlUmIlwDl1WDxulNN3mbkxp7L1qE/jPlcgdnFtJsCFfnhvyEYx2t+N6d6gF0KwBt
	X5xaeevTMv7cRaXy37gMZUnD0cyL0cIcD5nRC/Fbw2WEbAaSF0Rk80d9ttGVFM9vGYH7k/QNSK7wR
	Lba0WX30cALqMXxIWw/XTbiY3ZDgJna/Fm/X3r1ZYGxzinK1CDC59C0DRmlV9xo/HW124mmkmeqDr
	zCej8jLsw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kIhDP-0005qt-9Z; Wed, 16 Sep 2020 23:51:55 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kIhDL-0005qX-TH
 for linux-nvme@lists.infradead.org; Wed, 16 Sep 2020 23:51:52 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 69A6322209;
 Wed, 16 Sep 2020 23:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1600300310;
 bh=KX7DrWhzcMCg29KoONJqAfjqJUPrtFLZmCBF18Qc7j4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=TPOdR/4tcmi2Jfd4r63bEXlfGQV0pFO2DF1+oob0Mx72bza1P7Y228VU+JxCoP93B
 E5MItm7l+hKP0xMHUt/5WnDzfqt7FUQhLdbhK+k9IMpI+ebrkDUNYFLLtouxfj49YE
 sbRfupzj6ZWgLPoZXzyiEFSmf91Z6GM0qudoY9/I=
Date: Wed, 16 Sep 2020 16:51:48 -0700
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH] nvme-loop: allow ctrl-loss-tmo for nvme-loop
Message-ID: <20200916235148.GC3676296@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200915230456.13159-1-chaitanya.kulkarni@wdc.com>
 <9aaecc8f-7eda-b792-2e5f-a8cc8f8178f2@grimberg.me>
 <BYAPR04MB49658A3CB5BA3AB70434551E86210@BYAPR04MB4965.namprd04.prod.outlook.com>
 <9ae2644e-73e4-768f-965e-ff1d41c19c6c@grimberg.me>
 <BYAPR04MB49655525AAD3191DF31E2B9286210@BYAPR04MB4965.namprd04.prod.outlook.com>
 <b9851360-0087-adb0-a355-62700d4fe047@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b9851360-0087-adb0-a355-62700d4fe047@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200916_195152_018802_7A463BAC 
X-CRM114-Status: GOOD (  20.36  )
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
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>, "hch@lst.de" <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Sep 16, 2020 at 04:30:47PM -0700, Sagi Grimberg wrote:
> 
> > > I'd say we need to fix nvme-cli not passing optional parameters by
> > > default...
> > 
> > I assume that we changed the nvme-cli to fix the issue and default
> > behavior (i.e. expecting and setting the ctrl_loss_tmo).
> > 
> > Changing now again will break the fix in nvme-cli which requires this
> > default behavior ?
> > 
> > I think it is easier fix with right comment documentation so we don't
> > have to rely on the tools, plus it is only for nvme-loop which we use
> > for development and testing but not in production.
> 
> Its going to keep breaking if nvme-cli keeps sending optional params
> by default.
> 
> Don't care all that much, but it just seems backwards to me.

Regardless of what userspace does, I don't think we want anything in the
kernel to break.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

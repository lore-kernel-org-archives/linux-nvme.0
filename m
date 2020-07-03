Return-Path: <SRS0=BHMv=AO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4393C433DF
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Jul 2020 20:17:08 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D49120772
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Jul 2020 20:17:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Hvd2RUUZ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kwjzXsqv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D49120772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=SB0EgTQFE2FEUW4csq2cRffNENR5kvKGSYBvJZwXJIQ=; b=Hvd2RUUZFdP9p4ilthM3AWMR2
	qs1cHzhsKOCKvZqv+hBRlIBH05CKp7SKrEI7PFpQzDnzpsrqiFpuO+TuVMqV0mAzn8xdyV96JfzXR
	5NgchCNBm3+xtNQkU/4SSHBD78yAMND0nhwzdCXi/KB4IUs7m2qOF5iiKxwLm40b0xL92CO5X9tYy
	398t5iQldQc16hEc3eATkLpiy4Dyl9DHTGXjKzDl5xURAF2YlyZX3ElKSbnVI5I0uZmjsV00RLtnK
	x3mqvgSjuiVpHo5HvQqwmpVpsXvIjnXJf5jRwFCiT+QYjX0LCG5pRRoa6gAnhdcwzcWhGwDvc5igN
	HPX8JCG/Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jrS7H-00089O-LW; Fri, 03 Jul 2020 20:16:59 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jrS7F-000894-Q8
 for linux-nvme@lists.infradead.org; Fri, 03 Jul 2020 20:16:58 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 695FF20772;
 Fri,  3 Jul 2020 20:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1593807416;
 bh=EJsD2I2QaTI5ogFKVXUGkw7b6cvzSjZ/w9fPntycDxc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=kwjzXsqvmmu/cjfpwvb8v5P/vgiYPeyY3EwyaCiveqFfy946FZJO6SDIvpw97nmWD
 vV37Gy9YnuQldvqOxeFEAUSr0q5cGlZ6J07xUVda2s5/pEbAUvsxeOT1/0d8dol5je
 cvqcKnMwfzGo/GmZUx548GU4/8RPgxAHRz5KKbn8=
Date: Fri, 3 Jul 2020 13:16:54 -0700
From: Keith Busch <kbusch@kernel.org>
To: David Fugate <david.fugate@linux.intel.com>
Subject: Re: [PATCH] nvme: associate stripe size quirk with D4512
Message-ID: <20200703201654.GA1991931@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200611033836.45701-1-david.fugate@linux.intel.com>
 <20200611054156.GB3518@lst.de>
 <e2c46dfec9e779d945088b025f833bcd4e29cc1e.camel@linux.intel.com>
 <20200615072031.GA21903@lst.de>
 <43c990124bf8b0cb20434e78fb455302fe3b8c52.camel@linux.intel.com>
 <20200702214830.GB1990925@dhcp-10-100-145-180.wdl.wdc.com>
 <50b54887cbd5944cd3a24a57e806f2d2f694339c.camel@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <50b54887cbd5944cd3a24a57e806f2d2f694339c.camel@linux.intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200703_161657_996550_C077C29D 
X-CRM114-Status: GOOD (  16.48  )
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
Cc: axboe@fb.com, david.fugate@intel.com, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Jul 02, 2020 at 04:26:21PM -0600, David Fugate wrote:
> On Thu, 2020-07-02 at 14:48 -0700, Keith Busch wrote:
> > On Thu, Jul 02, 2020 at 03:16:04PM -0600, David Fugate wrote:
> > > Did hear from our D4512 team there are concerns with this drive
> > > advertising itself as NVMe 1.2 compliant while also implementing
> > > aspects of NVMe 1.3 such as NOIOB. Of course the Linux NVMe driver
> > > does the right thing in terms of ignoring the drive-reported spec
> > > compliance value in favor of feature detection. Can't be certain
> > > that's the case with all other OSes and closed-source drivers
> > > in particular.
> > 
> > I don't understand this concern. If a driver fails to detect a
> > feature,
> > then they're in the exact same situation as if the controller didn't
> > implement it.
> 
> Imagine a less-enlightened NVMe driver which guards enablement of
> features based *both* on the NVMe spec version the controller reports
> as well as feature detection. In such cases, it wouldn't matter if a
> drive implemented NOIOB (NVMe 1.3) if the controller advertises itself
> as 1.2. 

That's exactly my point. It doesn't matter for these theoretical drivers
whether you implement the feature or not. Meanwhile, 5 years worth of
existing drivers can readily use it. You stand to gain something by
implementing it, and nothing to lose.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

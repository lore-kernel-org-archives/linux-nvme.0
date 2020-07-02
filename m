Return-Path: <SRS0=dOZ+=AN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC8CAC433E0
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Jul 2020 22:26:38 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87C9F20780
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Jul 2020 22:26:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ULpV2iv6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87C9F20780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:Reply-To:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:Date:To:From:
	Subject:Message-ID:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sabAWKXuGU+xJNVZ8uURGi30dwuDH5gnhjjRyHKlx6A=; b=ULpV2iv6XS8z7b0J6d3pGNZtZR
	YHzEISU7hs6pYhCxwon4btOzdiBx0DSI2vpE0nZUc6cTg804L+0Nf2OjmGeS6PvM00kCyl4x0rLE6
	KJN7cJpBOGbzBagYJmhAqzP5zRVdGvCPR0dMKWmY3Yy3sqMumopaI1x0pyCW0KFHLt+We7VFIPlEd
	G9E88JVKv8V8UmBpNu+RIj2OEcyw/lR8muflS8O65KXf1PK65hj2QhtOdrOWkHWFTB5xKveUQSyVg
	huFXr/vA5pWBPiM90lwbZkZ58O3PPR/A+uIb4RDqKo8KYtvN5NdeD4WCGA77fe6CsZFcezUE2AdEA
	8+gcgNww==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jr7f3-0001z7-O3; Thu, 02 Jul 2020 22:26:29 +0000
Received: from mga02.intel.com ([134.134.136.20])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jr7f1-0001ym-6M
 for linux-nvme@lists.infradead.org; Thu, 02 Jul 2020 22:26:28 +0000
IronPort-SDR: xLEHBL2/+gc3R+sfWSerL+rTfkMZ3C8QY8mBLn7sMnz+kLD+hQDJqNsg9QcKLlhnwP1jSLAanv
 Rq3o+4E3WFWQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9670"; a="135325353"
X-IronPort-AV: E=Sophos;i="5.75,305,1589266800"; d="scan'208";a="135325353"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2020 15:26:22 -0700
IronPort-SDR: z3Xo80IBCcLQAwew4Q+QIHoi5oMM87QkYetc37zFgoOY72Sd2xGUvEatbl45bCEB70j4/nQcVf
 AqzgBtpsrwBQ==
X-IronPort-AV: E=Sophos;i="5.75,305,1589266800"; d="scan'208";a="455677584"
Received: from unknown (HELO dwf-u18040) ([10.232.115.11])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2020 15:26:21 -0700
Message-ID: <50b54887cbd5944cd3a24a57e806f2d2f694339c.camel@linux.intel.com>
Subject: Re: [PATCH] nvme: associate stripe size quirk with D4512
From: David Fugate <david.fugate@linux.intel.com>
To: Keith Busch <kbusch@kernel.org>
Date: Thu, 02 Jul 2020 16:26:21 -0600
In-Reply-To: <20200702214830.GB1990925@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200611033836.45701-1-david.fugate@linux.intel.com>
 <20200611054156.GB3518@lst.de>
 <e2c46dfec9e779d945088b025f833bcd4e29cc1e.camel@linux.intel.com>
 <20200615072031.GA21903@lst.de>
 <43c990124bf8b0cb20434e78fb455302fe3b8c52.camel@linux.intel.com>
 <20200702214830.GB1990925@dhcp-10-100-145-180.wdl.wdc.com>
Organization: Intel
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200702_182627_399475_DCD3537B 
X-CRM114-Status: GOOD (  16.65  )
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
Reply-To: david.fugate@linux.intel.com
Cc: axboe@fb.com, david.fugate@intel.com, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, 2020-07-02 at 14:48 -0700, Keith Busch wrote:
> On Thu, Jul 02, 2020 at 03:16:04PM -0600, David Fugate wrote:
> > Did hear from our D4512 team there are concerns with this drive
> > advertising itself as NVMe 1.2 compliant while also implementing
> > aspects of NVMe 1.3 such as NOIOB. Of course the Linux NVMe driver
> > does the right thing in terms of ignoring the drive-reported spec
> > compliance value in favor of feature detection. Can't be certain
> > that's the case with all other OSes and closed-source drivers
> > in particular.
> 
> I don't understand this concern. If a driver fails to detect a
> feature,
> then they're in the exact same situation as if the controller didn't
> implement it.

Imagine a less-enlightened NVMe driver which guards enablement of
features based *both* on the NVMe spec version the controller reports
as well as feature detection. In such cases, it wouldn't matter if a
drive implemented NOIOB (NVMe 1.3) if the controller advertises itself
as 1.2. E.g., same general type of version-checking logic as
implemented by nvme_report_ns_ids, but expanded to something that
actually *is* detectable as a feature. Linux does the right thing as
well as Intel-authored NVMe drivers I'm familiar with. Can't say this
for closed-source drivers though, and that was the concern given.


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

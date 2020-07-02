Return-Path: <SRS0=dOZ+=AN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA8BDC433E0
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Jul 2020 21:16:21 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3C0C2070C
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Jul 2020 21:16:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aFFpO0Al"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3C0C2070C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:Reply-To:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:Date:To:From:
	Subject:Message-ID:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SkT4bDiYswkxZfRf7oC7abhlXoFx1L6ZCUV5RQNos5k=; b=aFFpO0AlrzHL+jV39KvCq6vYab
	XZTCyX0f91RZMoGTcBwbP3ag+Z4ehfVB+dWEzmZrI7tzokXh50k10zUGcd1E0a/zL1a7pYF0wuxan
	oGk5TXh/rgcxhppwIilgmhZX96vOinS9rO2Me6y9aeJd5Utak08zEniu/uKtwzjbC+1yyydf5Zgj8
	xS3zdDJdKRVC0CvTsUWoV5th34nnGAM6/k2vhzzh3XeuTKnA+dVRVlki4Um1WPUFfQs01HldoTeu2
	J4vh51cta4VxodkEqfzPkpgkmApTQi9lojnbOzcZzp8MIDaGGYdu9PefG6tvaa09wYI4crCmmDjh0
	jVpls6zQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jr6Z3-0003sx-2C; Thu, 02 Jul 2020 21:16:13 +0000
Received: from mga04.intel.com ([192.55.52.120])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jr6Yz-0003sd-91
 for linux-nvme@lists.infradead.org; Thu, 02 Jul 2020 21:16:10 +0000
IronPort-SDR: TH6JEnto2+9SUWIY37Pb1TqPnmebDlZN8wnynv4zV4IERrCCKE+AYV0ghJfbVaZO2qjIX2g3LP
 58sxBd9OaZ7w==
X-IronPort-AV: E=McAfee;i="6000,8403,9670"; a="144544564"
X-IronPort-AV: E=Sophos;i="5.75,305,1589266800"; d="scan'208";a="144544564"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2020 14:16:05 -0700
IronPort-SDR: wsQFa2NK579pL9M5e0PkzD3Hi9g61ZDI5hINBzb44A5ycpw6gvGzn/wSrHE8n3xFCY1eht69/J
 1mXm2HL23+GA==
X-IronPort-AV: E=Sophos;i="5.75,305,1589266800"; d="scan'208";a="455661062"
Received: from unknown (HELO dwf-u18040) ([10.232.115.11])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2020 14:16:04 -0700
Message-ID: <43c990124bf8b0cb20434e78fb455302fe3b8c52.camel@linux.intel.com>
Subject: Re: [PATCH] nvme: associate stripe size quirk with D4512
From: David Fugate <david.fugate@linux.intel.com>
To: Christoph Hellwig <hch@lst.de>
Date: Thu, 02 Jul 2020 15:16:04 -0600
In-Reply-To: <20200615072031.GA21903@lst.de>
References: <20200611033836.45701-1-david.fugate@linux.intel.com>
 <20200611054156.GB3518@lst.de>
 <e2c46dfec9e779d945088b025f833bcd4e29cc1e.camel@linux.intel.com>
 <20200615072031.GA21903@lst.de>
Organization: Intel
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200702_171609_517450_A34A679C 
X-CRM114-Status: GOOD (  26.17  )
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
Cc: kbusch@kernel.org, axboe@fb.com, sagi@grimberg.me,
 linux-nvme@lists.infradead.org, david.fugate@intel.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, 2020-06-15 at 09:20 +0200, Christoph Hellwig wrote:
> On Fri, Jun 12, 2020 at 08:43:15AM -0600, David Fugate wrote:
> > On Thu, 2020-06-11 at 07:41 +0200, Christoph Hellwig wrote:
> > > On Wed, Jun 10, 2020 at 09:38:36PM -0600, David Fugate wrote:
> > > > Intel's D4512 dual-port SSD is based on the older Intel P4500
> > > > SSDs
> > > > whose development predated the NOIOB feature. Based on a
> > > > customer
> > > > request, the D4512's device ID was changed from the P4500s'.
> > > > This
> > > > patch associates D4512's device ID with the stripe size quirk
> > > > to
> > > > improve its performance.
> > > 
> > > NAK.  We've been told Intel forever that we need a standard
> > > quirk,
> > > and we actually do have way to expose this information in
> > > Identify
> > > now.
> > > Just kick your firmware engineers in the but to set the trivial
> > > field
> > > in Identify.
> > 
> > Thanks for the feedback Christoph. Our FW engineer for this product
> > is
> > currently on vacation, but I'll relay your suggestion to see if
> > it's
> > viable.
> > 
> > In the meantime, I'm hearing your rejection for this is simply
> > Intel
> > standardized the driver-assisted striping feature as NOIOB and
> > failed
> > to realize it in any Intel product. Other than this, was there a
> > technical reason for rejecting this patch?
> 
> If you look back in the archives we have been unhappy with this quirk
> for
> years and thus helped to standardize it.  So we very much expect
> Intel to
> use the standard way to any new product instead of adding more and
> more
> quirks.

That's fair feedback. Did hear from our D4512 team there are concerns
with this drive advertising itself as NVMe 1.2 compliant while also
implementing aspects of NVMe 1.3 such as NOIOB. Of course the Linux
NVMe driver does the right thing in terms of ignoring the drive-
reported spec compliance value in favor of feature detection. Can't be
certain that's the case with all other OSes and closed-source drivers
in particular. No final word from that FW team yet. In the meantime,
I've submitted a separate patch to document marketing names of Intel
drives requiring these quirks.

BTW - Intel's recently announced P5500/P5600 product line implements
NOIOB per the spec. It's just these old controllers we're having
problems with.


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

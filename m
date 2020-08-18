Return-Path: <SRS0=NqxM=B4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BE08C433E1
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Aug 2020 06:36:35 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19CC02067C
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Aug 2020 06:36:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NPe84r12";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SCuSZeGZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19CC02067C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ymYAwJ7jVNGp/wHjZ6EwUKk23zzNLYJNzmcrbWPLABY=; b=NPe84r12CUTXM4ptHiAWpzVEB
	RqC1UkTaqSr8fmdyrg05ydKY6oizC+U+dGb9ooJUVp+AAKwuNQsJm98KufHw6+6ngOWX9IWQIuPG8
	mSRnB4zFRfr6xbBdIYZeWfCg4/myr4NV1Dec2jFuDv/ThGbC4Wbf2P57J1Ib4zZaSdPf9w3UoOUmf
	HsK97GZaE8waePP6tcUtOHBLWFn34dXIcE9pC1sFIqnZEC0DjGLhDB3gy+XaeVeM/GRN3yw4z71/A
	dp/epMMhxRyEnNhNKIBo7lko2OxUuv3EO1WlhHMfkHySET8PI/l5pr+ScUbuyEVTXZhz6dv9xncRY
	V5k2Wq/RA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k7vES-0004Wn-HH; Tue, 18 Aug 2020 06:36:28 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k7vER-0004WV-CP
 for linux-nvme@merlin.infradead.org; Tue, 18 Aug 2020 06:36:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=8vYIBJGBXU1Wf1xvhyqVIcRUnFm2y/tYWcpiG02fXZg=; b=SCuSZeGZM5341Z9idGQ+Wm4AVk
 HkkBTBDUmRcaUQY/DkKfBmG1sIq8atKr3AQe8IJpQRaJra5AqAigE7FGiiGLFIV1TO68ddXN5LVku
 +2pD/FmCU9j1zon08jxOB5QMA7Q4WeTHU9yrf3qeD/kkZMr6rr2M5eu4S8hgaLGhtHv1OdHXAv4Ev
 U+XkaOanLT6BV8bb3WVCvQV0zAhKilCDgj8G0JCUypjmtqEtuyOXIczMlO8/3+5fpZ2O1nKpTmEbW
 EFdNDIDeqgsD6O7/hcbCmK/Mkkp2SHLiuP+oJbUjnp4ujqVyO29LFvVW+TNHF165h0wDh3lSU5Og/
 lRJmfT3w==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat
 Linux)) id 1k7vEP-0002WR-5E; Tue, 18 Aug 2020 06:36:25 +0000
Date: Tue, 18 Aug 2020 07:36:25 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: nvme reservation commands during controller reset
Message-ID: <20200818063625.GA9206@infradead.org>
References: <MN2PR19MB3005A46208EE2B65E5F9B330EE440@MN2PR19MB3005.namprd19.prod.outlook.com>
 <20200810154846.GB4159317@dhcp-10-100-145-180.wdl.wdc.com>
 <462babf2-7cde-af4a-8bf9-a5b230e282b7@grimberg.me>
 <20200814082015.GB18371@infradead.org>
 <20200814100911.GA9975@infradead.org>
 <83dbae6f-01a0-a9a4-9271-de8c1cf06c66@grimberg.me>
 <20200815070134.GB20460@infradead.org>
 <e312ae98-5b40-d0ee-c13e-b65db1f3acd7@grimberg.me>
 <20200817081227.GA12680@infradead.org>
 <29359e09-f386-8004-7369-c8fc055e2c38@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <29359e09-f386-8004-7369-c8fc055e2c38@grimberg.me>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: Christoph Hellwig <hch@infradead.org>, Keith Busch <kbusch@kernel.org>,
 "Engel, Amit" <Amit.Engel@dell.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "Anner,
 Ran" <Ran.Anner@dell.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Aug 17, 2020 at 12:29:49PM -0700, Sagi Grimberg wrote:
> So what is the semantics we want to provide? a best-effort one? not very
> different than what we have today. We could, if we choose to, have the
> pr context to wait for a path_map_changed completion and have
> nvme_mpath_set_live and nvme_mpath_check_last_path do complete_all on
> this completion.
> 
> But the question is what the semantics we want to provide...

But it might never change..  We could give it the default max_retries
based retries for any reasons if we want to be fancy.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

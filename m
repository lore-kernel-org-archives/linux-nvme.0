Return-Path: <SRS0=73dC=AL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C54C433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Jun 2020 13:34:50 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 782562074F
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Jun 2020 13:34:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qYUQkTCJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 782562074F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=mEOtYYjbwN1WpbR3p2dik2HBs+pGLgECmiq43cRdmWI=; b=qYUQkTCJb9pqWG/Pm058mu4d4
	2NDA/eSmZ1WIzlCPbEI8SYPD3mNeLotbXslMYtKLOVl7OS/c06lV8zkdwWMIQrTQsSnjYBvC7v0Yn
	6VGrikU5fUupwCCuq8X8X8bcsYZ/cfBtpnI/modw0u5jkOcDHepmKpiBFJx9BqmJfC1WW6SGOT3Tf
	ru+f+loHOwe05BsfyDQWHi2OS/XDS7knny2tK8WLTcYK9Wbr0akCsGuvuy3PO+vPl5kBeuQ5/ny44
	daVCjT/pAYhWWRJ3mbKDhgXy2RBEPilo16To7P04B6r2w07aHVuhZTmzSls//wT1fsyYqPAR5wXUA
	g0d4sxU2w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jqGPM-0004X4-Op; Tue, 30 Jun 2020 13:34:44 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jqGOj-0004Fi-Ro
 for linux-nvme@lists.infradead.org; Tue, 30 Jun 2020 13:34:06 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 21A1A68B05; Tue, 30 Jun 2020 15:33:59 +0200 (CEST)
Date: Tue, 30 Jun 2020 15:33:58 +0200
From: Christoph Hellwig <hch@lst.de>
To: Maximilian Heyne <mheyne@amazon.de>
Subject: Re: [PATCH] nvme: validate cntlid's only for nvme >= 1.1.0
Message-ID: <20200630133358.GA20602@lst.de>
References: <20200630122923.70282-1-mheyne@amazon.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200630122923.70282-1-mheyne@amazon.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
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
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Jens Axboe <axboe@fb.com>,
 linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Amit Shah <aams@amazon.de>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Jun 30, 2020 at 12:29:23PM +0000, Maximilian Heyne wrote:
> Controller ID's (cntlid) for NVMe devices were introduced in version
> 1.1.0 of the specification. Controllers that follow the older 1.0.0 spec
> don't set this field so it doesn't make sense to validate it. On the
> contrary, when using SR-IOV this check breaks VFs as they are all part
> of the same NVMe subsystem.
> 
> Signed-off-by: Maximilian Heyne <mheyne@amazon.de>
> Cc: <stable@vger.kernel.org> # 5.4+

The first hunk looks ok, the second doesn't make sense as fabrics
was only added with NVMe 1.2.2.  I can fix it up when applying if you
are ok with that.

But you guys really shouldn't be doing SR-IOV with 1.0 controllers
independent of this..

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

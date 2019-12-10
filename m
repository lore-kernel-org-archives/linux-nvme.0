Return-Path: <SRS0=hdrt=2A=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83BB8C43603
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Dec 2019 17:11:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59CCE2073B
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Dec 2019 17:11:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rakMOssi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59CCE2073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kTMmui45OBLWN2ourT31DOApMn39mNxxbBNVA6+SDGQ=; b=rakMOssi1mspzC
	YBQxV1bPopz7yJ2x+0SwAMj8COTL6AtCyFy9w7Q7kMlHJNYzPpZJbaRg2xuUn+lFOVvQXYh4FP/fq
	uWqSwqPfR3GLr81CunUWgQQ4t/w9u7mrXQPEv4TIpw4RVlCGkqnl/k5u4U2SHcgKjXX0z463BWni6
	kceaXs1tgZLJSgT5vG9cbyUFfdrOLqT1bFpFb38K1k1wnCSRwxMffYcX20V37z38zWJFIuL/Hoeva
	S2nuGCZ6ceTyKo/EqU6k/SLm8NrAIGdPcTEZgwEXN77gQKieAeRsErmX+07Dilw48KILJRCOHsBWa
	BFeai0KnhCCNt/o55s3Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iej2x-0001NP-Ao; Tue, 10 Dec 2019 17:11:39 +0000
Received: from mx2.suse.de ([195.135.220.15] helo=mx1.suse.de)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iej2u-0001Mn-Kz
 for linux-nvme@lists.infradead.org; Tue, 10 Dec 2019 17:11:38 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 27EC9AE57;
 Tue, 10 Dec 2019 17:11:35 +0000 (UTC)
Date: Tue, 10 Dec 2019 18:11:34 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv3 1/4] nvme/pci: Disable interrupts for threaded handler
Message-ID: <20191210171134.mpuegw5ainp5kmgg@beryllium.lan>
References: <20191209175622.1964-1-kbusch@kernel.org>
 <20191209175622.1964-2-kbusch@kernel.org>
 <20191210151257.2a36ny3yy5tdohda@beryllium.lan>
 <20191210152840.xgpibkzex6mhnmne@linutronix.de>
 <20191210155433.GA4424@redsun51.ssa.fujisawa.hgst.com>
 <20191210164456.mdeff7xepsnw532j@beryllium.lan>
 <20191210165704.GB4424@redsun51.ssa.fujisawa.hgst.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191210165704.GB4424@redsun51.ssa.fujisawa.hgst.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191210_091136_831458_38F06102 
X-CRM114-Status: GOOD (  10.44  )
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
Cc: sagi@grimberg.me, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-nvme@lists.infradead.org, ming.lei@redhat.com, tglx@linutronix.de,
 hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Dec 11, 2019 at 01:57:04AM +0900, Keith Busch wrote:
> On Tue, Dec 10, 2019 at 05:44:56PM +0100, Daniel Wagner wrote:
> > Sure, I am just a bit confused how IRQ_NONE is used. The comment on
> > nvme_cqe_pending says "We read the CQE phase first to check if the
> > rest of the entry is valid", which I read as "check if we have
> > anything to do" and not "this irq doesn't belong to this queue".
> 
> Those two interpretations sound like the same thing to me. :)

:)

I was confused why 'nothing to do' is then interpreted as IRQ was
routed wrongly.

> The interrupt notifies the driver it has something to do, and reading
> the CQE phase confirms whether or not that's true.

I think the thing I am missing the design idea behind it. I suppose the
IRQ on only fires when previously work was posted.

Sorry for the noise.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

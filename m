Return-Path: <SRS0=ysN4=ZZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D743C432C0
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Dec 2019 11:50:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E85F2073C
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Dec 2019 11:50:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rTLILhLf";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="llxNGju3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E85F2073C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cqbxTHOfJ4hXErkuYcte8cz3bNczFsSS1hkvTuMmi1k=; b=rTLILhLfVGMbsG
	qRWXEmpM2ogWRAOEK5NECsMb+2302O/9vu+nQzvyKWvF3x3x/6Ic6f3XI3vRGc+aGFogJtmzrAaZx
	mvUgl0CSBWFdmgSbbGWqJPGtb1SMmourOIp+T6iiPvm1x/iTaLW22yAqqp2Rx10gG0cP4jYaYep7r
	RTNrimlERD7j8aspKp8DRjYljTLjstJBE8skZn1JOkffuIDKP12sdQsJuePD4Ai0/whZKOcZyk9Nu
	wkn+ByRTlLRYnmwT6BvYUhlDsVr0iZdihYyePT/LXbV/jDoEG4eJd7bIvjkvk57H7XWpYpmIsim6e
	Gj59CxEFFJjGRsCUR/ew==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ic6hP-0004Sn-Fs; Tue, 03 Dec 2019 11:50:35 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ic6h4-00043t-Oy
 for linux-nvme@lists.infradead.org; Tue, 03 Dec 2019 11:50:18 +0000
Received: from C02WT3WMHTD6.lpcnextlight.net (rap-us.hgst.com [199.255.44.250])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7AD3620684;
 Tue,  3 Dec 2019 11:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1575373814;
 bh=XS++FmgaW2NMEKh9y3FRpOPiq7KQ/LeEF1ki4nUG4VE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=llxNGju3r2ofZlhck7zId16xJjiAHuuDyy0AukkIYJ88MtcmAAGl9T1vqZu4WL66k
 D3ZMLwrXUpNLbyp/Ofhqzy9WYaOWe6PoOqxxV/ZyuHCJZRIR1DL02sGENNLLH9Z/Ph
 vbUuqXrRk7HNk8nlJZWMWuMJpfh0OupdD2DCZAbM=
Date: Tue, 3 Dec 2019 04:50:06 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [RFC PATCH 1/3] nvme/pci: Poll the cq in the primary irq handler
Message-ID: <20191203115006.GB86476@C02WT3WMHTD6.lpcnextlight.net>
References: <20191202222206.2225-1-kbusch@kernel.org>
 <20191202222206.2225-2-kbusch@kernel.org>
 <20191203075046.GF23881@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191203075046.GF23881@lst.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191203_035014_918690_9AE20C41 
X-CRM114-Status: GOOD (  18.05  )
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
Cc: bigeasy@linutronix.de, tglx@linutronix.de, sagi@grimberg.me,
 linux-nvme@lists.infradead.org, ming.lei@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Dec 03, 2019 at 08:50:46AM +0100, Christoph Hellwig wrote:
> On Tue, Dec 03, 2019 at 07:22:04AM +0900, Keith Busch wrote:
> > The nvme threaded interrupt handler reduces CPU time spent in hard irq
> > context, but waking it increases latency for low queue depth workloads.
> > 
> > Poll the completion queue once from the primary handler and wake the
> > thread only if more completions remain after.
> 
> How is this going to work with -rt, which wants to run all actual
> interrupt work in the irq thread?

That just has the primary and the bottom half run as threads. This
patch just avoids a context switch for shallow workloads whether
use -rt or not.
 
> > Since there is a window
> > of time where the threaded and primary handlers may run simultaneously,
> > add a new nvmeq flag so that the two can synchronize which owns processing
> > the queue.
> 
> If the above scheme is something that the irq subsystem maintainers are
> fine with I think we need to lift that synchronization into the core
> irq code instead of open coding it in drivers.

It's not generally applicable to all drivers, so it'd have to be
an opt-in. I think IRQF_ONESHOT pretty much captures the same idea,
though.

> But I'd love to understand what kind of performance this split scheme
> gives us to start with.  Do you have any numbers?

I do have a little bit of data. On a queue-depth 1 test, returning
IRQ_WAKE_THREAD adds just under 1usec latency compared to completing
in the primary handler. That's about 10% for some of the faster
devices out there.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

Return-Path: <SRS0=ysN4=ZZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75BDBC432C0
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Dec 2019 07:50:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44FCA2053B
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Dec 2019 07:50:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YzmAbKPt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44FCA2053B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2QF9KaVT4rOQNGjVmAXSiMzU32n3L/aN1UOyhXexMbg=; b=YzmAbKPtrmZs4N
	+lAEA1fj9XNCiBNRQpOyFN5yl7k9yX7KCuXEi/E3nKXESFduTccO74pBSemEmZOi0ReTHL6xTIBkA
	hdSlJDrdbSVS3PUDyfRlQM8YMCmjY/o3ggsG9Q0PtQj+Iv7C9Gh0dvxqJh6SZr05we14yBi23i7Xp
	KQSHUolfg5jtl5v4TP/XDEtdXrYmze/5M2bKGMqgbXyRG2zHaRVX2ownRXWzQXEu7tK9dCVbKeqF2
	cgnkxXUt3X5xktQ1YvsPxR61dRcJdSvB218XfO1dQ30NqJD3oLKYjNejd4FQJl7/MkWYoBWuuFoai
	qYMUTW0/q+51iyRokuOQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ic2xP-0003QY-41; Tue, 03 Dec 2019 07:50:51 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ic2xN-0003Q9-8Z
 for linux-nvme@lists.infradead.org; Tue, 03 Dec 2019 07:50:50 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id A3CF368BFE; Tue,  3 Dec 2019 08:50:46 +0100 (CET)
Date: Tue, 3 Dec 2019 08:50:46 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [RFC PATCH 1/3] nvme/pci: Poll the cq in the primary irq handler
Message-ID: <20191203075046.GF23881@lst.de>
References: <20191202222206.2225-1-kbusch@kernel.org>
 <20191202222206.2225-2-kbusch@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191202222206.2225-2-kbusch@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191202_235049_456670_3FE7B613 
X-CRM114-Status: GOOD (  10.41  )
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
Cc: sagi@grimberg.me, bigeasy@linutronix.de, linux-nvme@lists.infradead.org,
 ming.lei@redhat.com, tglx@linutronix.de, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Dec 03, 2019 at 07:22:04AM +0900, Keith Busch wrote:
> The nvme threaded interrupt handler reduces CPU time spent in hard irq
> context, but waking it increases latency for low queue depth workloads.
> 
> Poll the completion queue once from the primary handler and wake the
> thread only if more completions remain after.

How is this going to work with -rt, which wants to run all actual
interrupt work in the irq thread?

> Since there is a window
> of time where the threaded and primary handlers may run simultaneously,
> add a new nvmeq flag so that the two can synchronize which owns processing
> the queue.

If the above scheme is something that the irq subsystem maintainers are
fine with I think we need to lift that synchronization into the core
irq code instead of open coding it in drivers.

But I'd love to understand what kind of performance this split scheme
gives us to start with.  Do you have any numbers?

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

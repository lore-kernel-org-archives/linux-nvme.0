Return-Path: <SRS0=ysN4=ZZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFEAAC432C0
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Dec 2019 12:08:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92BE3206EC
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Dec 2019 12:08:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iW2kXRJF";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="g7X/tWG1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92BE3206EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZE+G/O/iD6XnG2JM9MfZIEH02FTIAK407KyzAoFLocY=; b=iW2kXRJFSi+vkM
	hx1xqBTHzgPQe0RR5mSjXEeIGysSD5kbdJQeA6VwD4LXFpNLHvBAiWdHYyXugxNEXTRerTuoOCBTQ
	gOr8wBAExtOFNHgTUJj3O3ywdlKE0mHPI7tkzFhhIWIG3CTP6GPK4NmdUEhhzSz+vycnlmPI1hw1Z
	nYG31Nc+0At+NPJTCFeP/V9VWl5UxpLckc4m35FQCTA+GJQPnompczy9ZKL4fbgQIz+h/TWhXG7dW
	g4Z3yNxVhw3Pmnu9xi/9UfbQMm+YoEjtEVX7A8BU9B3UuejGwCJaC7yjQZVpYNbY9I6saKSEgDs1O
	7wnJge5knVXO4vNS6X6w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ic6yV-0006eh-7C; Tue, 03 Dec 2019 12:08:15 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ic6xU-0005il-QA
 for linux-nvme@lists.infradead.org; Tue, 03 Dec 2019 12:07:14 +0000
Received: from C02WT3WMHTD6.lpcnextlight.net (rap-us.hgst.com [199.255.44.250])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 34CF2206EC;
 Tue,  3 Dec 2019 12:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1575374831;
 bh=1Kzcopz5M2/Y5MpxyztId93uGcvWJMpOlFINWUUFHQw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=g7X/tWG1tax5PmfMx5PuCQTp3Ih5+24VLpEYUREsL1IzP5h/za45jVjUpS0NWcQKk
 g0W1srLx9o9koBzg2BhH1NnJqakxpsqnLb9ekcqMqcmKPlAtK2VJ4aG8hFG1Y6MSwE
 nQ1/mSJKbLqzJrkvQ0YgcCXZY5H/SUUEOlWD/0Wc=
Date: Tue, 3 Dec 2019 05:07:05 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCHv2 2/2] nvme/pci: Mask device interrupts for threaded
 handlers
Message-ID: <20191203120705.GC86476@C02WT3WMHTD6.lpcnextlight.net>
References: <20191202222058.2096-1-kbusch@kernel.org>
 <20191202222058.2096-3-kbusch@kernel.org>
 <20191203074723.GE23881@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191203074723.GE23881@lst.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191203_040712_892689_DAF750FF 
X-CRM114-Status: GOOD (  16.25  )
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
 ming.lei@redhat.com, helgaas@kernel.org, tglx@linutronix.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Dec 03, 2019 at 08:47:23AM +0100, Christoph Hellwig wrote:
> On Tue, Dec 03, 2019 at 07:20:58AM +0900, Keith Busch wrote:
> > +static irqreturn_t nvme_irq_thread(int irq, void *data)
> > +{
> > +	struct nvme_queue *nvmeq = data;
> > +
> > +	nvme_irq(irq, data);
> > +	if (to_pci_dev(nvmeq->dev->dev)->msix_enabled)
> > +		__pci_msix_desc_mask_irq(irq_get_msi_desc(irq), 0);
> > +	else
> > +		writel(1 << nvmeq->cq_vector, nvmeq->dev->bar + NVME_REG_INTMC);
> 
> So independent of the indirection issue can we have a theory of operation
> on why not using a read to flush the posted writes to disable/enable the
> interrupt (either variant) here is fine?  Let's assume we have a worse
> case implementation where no write ever gets delivered to the device
> until we do a read neither of them will ever hit the device as we don't
> really do MMIO reads in nvme during normal operation.

Sure.

First, if the masking MMIO write is stalled, the read back doesn't
make it complete any faster. It just means the flush takes that
much longer.

Also note that the write can't be reordered with other writes to
that device. You'd have to use writel_relaxed() for that.

We notify the nvme controller of new commands using doorbell writes.
If all writes are stalled, then the device doesn't have new commands
to complete, so there won't be any interrupts for the driver to
handle.

If we want to craft a worst case scenario where the device was aware
of the maximum possible commands on a queue (1023 for this driver),
we could theoretically observe that many MSIs for exactly 1 IRQ_HANDLED
return. This is below the 0.01% threshold for "nobody cared".
Subsequent new commands would be stuck behind the MSI mask write,
so there can't possibly be new IO while that mask write is
stuck.

So, I think if the device never sees the MSI masking while the
thread is reaping the completion queue, we'll just spend CPU time
in an unnecessary irq handler that would have otherwise been consumed
on a flushing readl().

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

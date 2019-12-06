Return-Path: <SRS0=+LKq=Z4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27E89C43603
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Dec 2019 21:18:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED54424676
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Dec 2019 21:18:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sCoOuOi7";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="DYkhF7K5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED54424676
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DitvA8olegBB4zPJSgrVbCG3lSbjTkD4cTBXpZZ5Qdk=; b=sCoOuOi7U3A+qp
	mTOo5SbWDOz1KQJXh1Jp0E1PKSy/dOzNNBycQ3PzGW2VCAzSHJIyHCEyqi6sLbGaQQkGxVadl6VYU
	NvyUhq9rGdnavQCgksqK9al0Eh6aIvNYI3osjx5D6eK8Klxkf2nQfnOAa0KSrOh6Wk6u1CYDFLab6
	NHu55haoQfNz6lAXHqsIL28QDOCljFuAqPMhjuX6q3AqCZepOC1BW3o7URJfIUoldbu8lBQcY4Sek
	C80zeJf9OD+rX+4PLbCKOYCJV1bIWI/ZwhyA3ElNL+e4xlQLvUul8x1hdAHQ4gsW042UIObAif1CH
	uj5+hol0qayeGTQPSZQw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1idKzh-0005Ye-P0; Fri, 06 Dec 2019 21:18:33 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1idKze-0005Y4-DA
 for linux-nvme@lists.infradead.org; Fri, 06 Dec 2019 21:18:31 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id AA6B3206C3;
 Fri,  6 Dec 2019 21:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1575667109;
 bh=5mPOStsfnN3nsdPvCHN24Ml2Ugt/kfEP2UAPJdNi4JE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=DYkhF7K52nHRQfJfz0pMtqWlbzBIBqMmnKOE5l9SBgJvOZjIbQGKQ/04Pvh8bGV4g
 7bWR7vspaUdn3wSZ+QmbUUgWznxaJatv9r4ZV4fBTLgXc7GMdr7S2WBLSt7tTe9uSz
 kR3JaFwQyQx25Zk3//mIoI85/kNgud1tEtH4WQF4=
Date: Sat, 7 Dec 2019 06:18:21 +0900
From: Keith Busch <kbusch@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCHv2 1/2] PCI/MSI: Export __pci_msix_desc_mask_irq
Message-ID: <20191206211821.GA1709@redsun51.ssa.fujisawa.hgst.com>
References: <20191202222058.2096-1-kbusch@kernel.org>
 <20191202222058.2096-2-kbusch@kernel.org>
 <20191202224603.GA14770@lst.de>
 <20191203090454.ftfu6pyz2ubxg7fk@linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191203090454.ftfu6pyz2ubxg7fk@linutronix.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191206_131830_466838_99C618CD 
X-CRM114-Status: GOOD (  18.67  )
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
Cc: sagi@grimberg.me, linux-nvme@lists.infradead.org, ming.lei@redhat.com,
 helgaas@kernel.org, tglx@linutronix.de, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Dec 03, 2019 at 10:04:54AM +0100, Sebastian Andrzej Siewior wrote:
> On 2019-12-02 23:46:03 [+0100], Christoph Hellwig wrote:
> > On Tue, Dec 03, 2019 at 07:20:57AM +0900, Keith Busch wrote:
> > > Export the fast msix mask for drivers to use when the read-back is
> > > undesired.
> > 
> > As said last time calling this seems wrong as it breaks the irq_chip
> > abstraction.  But looking at the disable_irq_nosync semantics I think
> > that function should do a non-pasted disable disable for MSI(-X)
> > interrupts.  Can you look into that?
> 
> Using disable_irq_nosync() would be the same as using IRQF_ONESHOT which
> is the preferred way.
> Keith complained about this as slow and avoiding the read-back as
> noticeable.
> 
> The generic way would be pci_msi_mask_irq() and the difference
> 
> |                 msix_mask_irq(desc, flag);
> |                 readl(desc->mask_base);         /* Flush write to device */
> 
> would be that flush.

Right, so the solution should be simply to remove the readl(). I'm pretty
sure that's safe to do: if mask_irq() returns before the device happens
to see the mask is set and generates an undesired interrupt, the irq
flow handler will observe irqd_irq_disabled() and return early. We have
to deal with that anyway because the device may have sent an interrupt
message at the same time the CPU was masking it. These would look
like the same thing from the CPU perspective.

I can't be completely sure it's safe for everyone though, so I'll try to
quantify the impact of the read back on nvme with some real hardware,
because I'm starting to wonder if this is really as important as I
initially thought.

If we do two readl()'s per IO, that's pretty noticable. It looks like
it's adding about 1usec to the completion latency (plus or minus, it
depends on the platform and if switches are involved).

But we certainly don't need this for each IO. For low depth workloads,
we can just handle all completions in the primary handler and never
mask interrupts.

In case there are lots of completions that are better handled in the
nvme_irq_thread(), then we can call disable_irq_nosync(). That doesn't
immediately mask MSIx because we didn't set IRQ_DISABLE_UNLAZY. The mask
won't happen until we see another interrupt, which means the thread
is going to be handling a lot of completions. The ratio of commands
processed to msix masking would be quite low. As far as I can tell,
the overhead seems pretty negligible.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

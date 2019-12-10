Return-Path: <SRS0=hdrt=2A=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98D73C43603
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Dec 2019 15:54:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68B7A207FF
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Dec 2019 15:54:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Q/VGdkwv";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="oE1zI6H6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68B7A207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Naz35b73xuy054ClqfCQgGEdkUX4IXhMGE7lgpLRPrY=; b=Q/VGdkwvqwO+GM
	eYWYZa9Qur82LE6+miRza00+LjZVWDYGNmVhLJQYuXVGrGmRAvFgZY9rSWGc/w8oPBMnL6lDdtAvx
	D/C14ORqeFVTXE60vKlQ3MM+n32aOXuJVMWUA3nCebTZPqkA2OvXJZTYYBCkmcMMUjLiKSiwsXKUF
	VeuZBUbLDKw1pTj//CE7fD4uVMAvACvCj4U+4eoPVWyiqOM6/pO0IpPXoxV5Y3FJSKMS16DGCuY1D
	Lpa0khmmEnmBqJQvkKYVnzXcWbBf97hUX/fzyoTlSAqZONLpneOmwRNUOL0Esm3AKaFiXJuEQnhwT
	Y3KcceZRYMk8ZvP93ctw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iehqX-00029G-PL; Tue, 10 Dec 2019 15:54:45 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iehqV-00028b-FN
 for linux-nvme@lists.infradead.org; Tue, 10 Dec 2019 15:54:44 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1349F2053B;
 Tue, 10 Dec 2019 15:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1575993280;
 bh=/+p3Tztf78dRSbLjfhQnde5blotWSCCY4TjvS9IOjyM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=oE1zI6H6sdm2nKfbVFhLWV+eLWPmvp7ElJ2KVYLBNr+kDm9PulTIvx3jCudFMjRQZ
 YfLnzMls0QDaVdMc/9guSp0xD6ylfW6et9iLZaSeVVMGYgc9painFz28cFO2aU1neQ
 2My/zq5vuI65iAv2pWNq0k+wRaPSHidjMjVyTcnw=
Date: Wed, 11 Dec 2019 00:54:33 +0900
From: Keith Busch <kbusch@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCHv3 1/4] nvme/pci: Disable interrupts for threaded handler
Message-ID: <20191210155433.GA4424@redsun51.ssa.fujisawa.hgst.com>
References: <20191209175622.1964-1-kbusch@kernel.org>
 <20191209175622.1964-2-kbusch@kernel.org>
 <20191210151257.2a36ny3yy5tdohda@beryllium.lan>
 <20191210152840.xgpibkzex6mhnmne@linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191210152840.xgpibkzex6mhnmne@linutronix.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191210_075443_536683_24C779E1 
X-CRM114-Status: GOOD (  12.68  )
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
Cc: sagi@grimberg.me, Daniel Wagner <dwagner@suse.de>,
 linux-nvme@lists.infradead.org, ming.lei@redhat.com, tglx@linutronix.de,
 hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Dec 10, 2019 at 04:28:40PM +0100, Sebastian Andrzej Siewior wrote:
> On 2019-12-10 16:12:57 [+0100], Daniel Wagner wrote:
> > On Tue, Dec 10, 2019 at 02:56:19AM +0900, Keith Busch wrote:
> > >  static irqreturn_t nvme_irq_check(int irq, void *data)
> > >  {
> > >  	struct nvme_queue *nvmeq = data;
> > > -	if (nvme_cqe_pending(nvmeq))
> > > -		return IRQ_WAKE_THREAD;
> > > -	return IRQ_NONE;
> > > +
> > > +	if (!nvme_cqe_pending(nvmeq))
> > > +		return IRQ_NONE;
> > 
> > IIRC, returning IRQ_NONE tells the irq core code that this is
> > an unhandled IRQ. If the core sees too many of them it will print
> > 'spurious irq' message. See __handle_irq_event_percpu,
> > handle_irq_event_percpu and note_interrupt
> 
> This is okay / intended. If nvme_cqe_pending() does not recognise that
> this interrupt belongs to that device then it should return IRQ_NONE.

Also note this patch doesn't change the condition when IRQ_NONE is
returned. We've been doing that since nvme's beginning, as it really is
a spurious interrupt from a likely malfunctioning device.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

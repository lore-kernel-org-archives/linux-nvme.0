Return-Path: <SRS0=mBQh=ZU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 048D7C432C0
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Nov 2019 04:14:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3E1E215F1
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Nov 2019 04:14:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AeuTFK9W";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QuIYfAST"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3E1E215F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5ace7r20shPfrI9SX1Mw0DeDBG5el602UqhIZzzOIpU=; b=AeuTFK9W8vG5Rh
	MQl2XLKSORfMIfUINfQnsmKCo2PgczgSy/hMV6lRr6W3wHqXePOMu2NDT3/M8OTHeIQ/Rvo334nwb
	Y0ElHZLRaRf1vGSe8QSo9NvMsdAFgjWAtbbDzkzkGvmnyOoG519fy3ZO34Jlfg5+KzX2p9iy6WrH9
	l9DeWrINsEVxBp7Z7vqrV9EPn5Jj5qmPDc3Bcbdvd/e51uWy1lxN1tuzODVsVGQ4T4XToWnoXqnXL
	xQLB8L5xHXStSklepLIKaiuzJOhrnNZrEUkLRo9DX8Th3zaQEhsbyv86YNFx4CrpkBvLxlLo0Fbc5
	69R/0YcYeG7rv2sGE8NQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iaBC2-0003LH-67; Thu, 28 Nov 2019 04:14:14 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iaBBz-0003Kr-JF
 for linux-nvme@lists.infradead.org; Thu, 28 Nov 2019 04:14:12 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 3C0C621569;
 Thu, 28 Nov 2019 04:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1574914451;
 bh=ZJ3hO4wjBPnDHSQbNVomh5d6uSP9lPxK1KevAolIUaQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=QuIYfASTYkiXIdT0FHVENxDwpbZ/j1vKAe7gngv+PTLXfBsx0sYE8RPQ3VU5xdaKp
 RKYBnReN5wC0WMsjZebclUo3R48PCaR9VN22L5skCUj1oqtswmwmKj+EnQ3Cy6XL6v
 U/DFkyULNJ2PCf2fc61rLU9HB3A3OcF1+trJuuRQ=
Date: Thu, 28 Nov 2019 13:14:04 +0900
From: Keith Busch <kbusch@kernel.org>
To: Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH 2/4] nvme/pci: Mask legacy and MSI in threaded handler
Message-ID: <20191128041404.GB1947@redsun51.ssa.fujisawa.hgst.com>
References: <20191127175824.1929-1-kbusch@kernel.org>
 <20191127175824.1929-3-kbusch@kernel.org>
 <20191128033956.GD3277@ming.t460p>
 <20191128034817.GC1738@redsun51.ssa.fujisawa.hgst.com>
 <20191128035853.GF3277@ming.t460p>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191128035853.GF3277@ming.t460p>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191127_201411_656044_FFEF11E6 
X-CRM114-Status: GOOD (  12.90  )
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
 helgaas@kernel.org, Thomas Gleixner <tglx@linutronix.de>, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Nov 28, 2019 at 11:58:53AM +0800, Ming Lei wrote:
> On Thu, Nov 28, 2019 at 12:48:17PM +0900, Keith Busch wrote:
> > On Thu, Nov 28, 2019 at 11:39:56AM +0800, Ming Lei wrote:
> > > 923aa4c378f9("PCI/MSI: Set IRQCHIP_ONESHOT_SAFE for PCI-MSI irqchips"),
> > > then the question is that if interrupt mask is needed.
> > 
> > We don't want to use IRQF_ONESHOT for our MSI interrupts because that
> > will write to the MSI mask config register, which is a costly non-posted
> > transaction. The NVMe specific way uses much faster posted writes.
> 
> What I meant is that IRQF_ONESHOT isn't needed in case of IRQCHIP_ONESHOT_SAFE.
> 
> So it is reasonable to understand that interrupt mask isn't needed in the
> hard interrupt handler in case of IRQCHIP_ONESHOT_SAFE. That is
> basically what commit dc9b229a58dc("genirq: Allow irq chips to mark themself
> oneshot safe") does.

Hmm, it doesn't look like it's always safe. We have to stop the device
from generating MSIs for new completions somehow while the threaded
handler is running, otherwise those MSIs will be considered spurious
when the thread never gets a chance to increment desc->threads_handled.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

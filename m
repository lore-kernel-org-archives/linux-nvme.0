Return-Path: <SRS0=ysN4=ZZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC880C432C0
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Dec 2019 09:05:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 712E420661
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Dec 2019 09:05:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="skwAPl6r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 712E420661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qCNwutcEsmgg9QNWF3cRJVxbKYTVE7VsPbSptXZ+OoY=; b=skwAPl6r026y7Z
	iJGrriJ93bIgPaItSFN3tnAh5lwTLyGR6KiTRzRLTqahsNYGGQWliKh9YZqOiRqUKN+buzumsuP0a
	LpZEWkVSr4ZfHpxbJF3nSwCoVHV/uBszeOqmHC+DSt4uy6fir8t8yX3Bn1nc65CntHcZ2xBdpOj2L
	E7wuH+C6pabEmEKO5uWSNQzyzrnqI4ZTz09OS1OdCbxsNsU+wgefP1pfI3/Afl6YM5sUcnEr5z5ke
	3RhN2ozqQlItwzlJweJBm2QAsl7s64kYXlsoxyY8EypVNiiqYvgAdo1tpK2b+2eCtnVMgeF0gz75u
	QZ9Di7wUt7mDXHo2Pwbg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ic47A-0005a3-Mr; Tue, 03 Dec 2019 09:05:00 +0000
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ic478-0005Zk-Ef
 for linux-nvme@lists.infradead.org; Tue, 03 Dec 2019 09:05:00 +0000
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
 (envelope-from <bigeasy@linutronix.de>)
 id 1ic474-0007Ao-NO; Tue, 03 Dec 2019 10:04:54 +0100
Date: Tue, 3 Dec 2019 10:04:54 +0100
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCHv2 1/2] PCI/MSI: Export __pci_msix_desc_mask_irq
Message-ID: <20191203090454.ftfu6pyz2ubxg7fk@linutronix.de>
References: <20191202222058.2096-1-kbusch@kernel.org>
 <20191202222058.2096-2-kbusch@kernel.org>
 <20191202224603.GA14770@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191202224603.GA14770@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191203_010458_631663_2101EBB0 
X-CRM114-Status: UNSURE (   9.76  )
X-CRM114-Notice: Please train this message.
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
 helgaas@kernel.org, Keith Busch <kbusch@kernel.org>, tglx@linutronix.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2019-12-02 23:46:03 [+0100], Christoph Hellwig wrote:
> On Tue, Dec 03, 2019 at 07:20:57AM +0900, Keith Busch wrote:
> > Export the fast msix mask for drivers to use when the read-back is
> > undesired.
> 
> As said last time calling this seems wrong as it breaks the irq_chip
> abstraction.  But looking at the disable_irq_nosync semantics I think
> that function should do a non-pasted disable disable for MSI(-X)
> interrupts.  Can you look into that?

Using disable_irq_nosync() would be the same as using IRQF_ONESHOT which
is the preferred way.
Keith complained about this as slow and avoiding the read-back as
noticeable.

The generic way would be pci_msi_mask_irq() and the difference

|                 msix_mask_irq(desc, flag);
|                 readl(desc->mask_base);         /* Flush write to device */

would be that flush.

Sebastian

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

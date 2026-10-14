Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C242CC6B2E
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Oct 2026 21:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YzOf4as3xcc/aJg449jLYSJvevuNpDDTzET/P5gVLqc=; b=yVZkZnlwWs+tWRvn4V0hNzw37d
	PpQQgv9tpJrlXeL8W/iGLdGLPaPkzuHdoH9vAMdVT2rM8rStglFFBv80L1QXhTKEMw/H7lbuNKiS2
	+OyA8rcnFTJLEAs+2llIlGgi+bw/dkvtFUaZi2pWXSSJssB6vhrBrZ84cgd0QU95aNh+CxrfR+wy8
	RzgDGHe4OIYuSUO9JTvZ/0dQytRzKvVCxIsz423SULWhwfz8nWXaFE3ZAZl0eAKZywQ16Mo751GXr
	3KjBVn+NfOjQ3+kH9iu0A0rQKqoZeaTjYppwJ5uO1UO9Au0/2iSmJ5YoQfdfvYIAOSj2X+XUSRXGx
	/zou8Wng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xH6FU-0000000GJhT-05qp;
	Wed, 14 Oct 2026 21:10:56 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xH6FO-0000000GJhN-1XFP
	for linux-nvme@lists.infradead.org;
	Wed, 14 Oct 2026 21:10:50 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id BFD6943A31;
	Wed, 14 Oct 2026 21:10:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFD6D1F000C4;
	Wed, 14 Oct 2026 21:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792012249;
	bh=YzOf4as3xcc/aJg449jLYSJvevuNpDDTzET/P5gVLqc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=THdSvAj2ug728bKHtN8XjBGKhIVEFgsQwZejw9fKomGwgkJ+Co8zcl0N5HkgWeJb3
	 59useXHf5IBZgN3p+/J+Cq69M9ToMeDUuzHdpIRf/6fYu56YzWFvkjzwXp2IG10iGc
	 Qfzk2ol2AhCeO5LOiCPtLIFe2tMHz1mPlBwY32vkSi4p/CoVD8GpiWG4btScqI2Vud
	 a8qeRCjg5WbB35dTTxK6szaTXTINxAYsXRAmXFWdkb3UGDD4HvBDW6xR7qte8I3ViH
	 KtjWfvj7aPzzDdRBuRAnC+zjGWjHNUQQPsqy79qRw3k5j8fG/Jh6eMg6caFWhBmQTn
	 TnHdugnLkNHmg==
From: Thomas Gleixner <tglx@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>, Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, changfengnan@bytedance.com,
 linux-pci@vger.kernel.org, namjain@linux.microsoft.com, Keith Busch
 <kbusch@kernel.org>, Luigi Rizzo <lrizzo@google.com>
Subject: Re: [RFC PATCH 2/3] PCI/MSI: Implement irq_mask_nowait() for MSI-x
In-Reply-To: <20261014173106.GA1643226@bhelgaas>
References: <20261014173106.GA1643226@bhelgaas>
Date: Wed, 14 Oct 2026 23:10:45 +0200
Message-ID: <878q40f0oa.ffs@fw13>
MIME-Version: 1.0
Content-Type: text/plain
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Oct 14 2026 at 12:31, Bjorn Helgaas wrote:
>> Skip the read-back that flushes the MSI-x mask write. Parent domains
>> that mask on behalf of PCI/MSI continue using their own irq_mask().
>> 
>> Signed-off-by: Keith Busch <kbusch@kernel.org>
>
> I assume Thomas will review/ack the pci/msi/ parts.

Yes. I actually suggested that "nowait" mechanism to Keith at LPC.

Though I hate the name of that callback because irq_mask() does not
really wait. It guarantees that the mask store has reached the device
which means that after that point no further interrupts will be sent by
the device (assuming sane hardware). That means it's a synchronous
operation which involves flushing the store, so maybe irq_mask_noflush()
or irq_mask_async() might be more accurate and descriptive.

> Cc'd Luigi since I know he's interested in interrupt moderation in
> general.

Correct. I'm curious whether the interrupt frequency based moderation
mechanism Luigi is proposing does solve the NVME issues as well or can
be combined with some device specific hint mechanism.

That said, Luigi's approach should benefit from the "nowait" mechanism
as well.

Luigi?

Thanks,

        tglx


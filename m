Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFA60CC6B2D
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Oct 2026 21:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yfZ/FsY5Zh5zIE98xQp6NV9qIckj8O0+XPOxXg+eC7s=; b=o043TrDtFZq6lclu5Ye+tVrrwS
	sbBMcFKExDbK/3vanLfC1JJZBodCbkuE0wTi+qlCSXeUcOB9ZqgE9n1wE5obU3P6dV3+0op0F555v
	aB4W1Z2uhwu+Z1yNiIDeGcBAykwiMjYFdq6r8ECL6LTDGcl4MNCn1Lh6zS15M4xHQWD0oBpzPhQgM
	FwWdl4m6zOV7Qygi/SBNEjlbeznKg/FyvZx5rhog6v2Y1Ezl3CsaZKm6Xc7Vw5K18B74YmvNproqQ
	tuG266prgJUI0gjRI8oIcaUxbYSjIfBkyk50OW00XOpAsDqGCfEd0pNwRCj8xYIWtSES/7+ACwL8F
	22eUHCQQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xH6h3-0000000GMFh-0yyZ;
	Wed, 14 Oct 2026 21:39:25 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xH6gz-0000000GMF2-1xsf
	for linux-nvme@lists.infradead.org;
	Wed, 14 Oct 2026 21:39:23 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id EE20443D66;
	Wed, 14 Oct 2026 21:39:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CD451F000C4;
	Wed, 14 Oct 2026 21:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792013960;
	bh=yfZ/FsY5Zh5zIE98xQp6NV9qIckj8O0+XPOxXg+eC7s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HRCHauSgwJ/+0LsfAw1SACphQ9Kn9zODj961nCBEGV3/bMZDtKsi2rGRhU7tDMSC4
	 zXjZTwx6P3bv7dM2sLbW2w2Eu4X7AWVVRSN70mffrQhpCfaBRUhmzmrBnnq1UT3Ad+
	 sdFqv9lK/4YPubDzF1ZBrTc4iBwKBQVkEhtitkdWCDGeWsoygSExU1/8B8ATIw7fi2
	 OcjPxIKmVDBMwpeteOneHvhiUVdJcfLqy/A0HC+I0GH7C01JiQvD52c9C2IldfJ8DF
	 0gK1udx+3M2MAvlbMnvEQqvlFvz68IgsgdXakWqQqMasBApPcyiFKfRnEYjFQvAYVT
	 g1auJ3Fe/9Uow==
Date: Wed, 14 Oct 2026 15:39:18 -0600
From: Keith Busch <kbusch@kernel.org>
To: Thomas Gleixner <tglx@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Keith Busch <kbusch@meta.com>,
	linux-nvme@lists.infradead.org, hch@lst.de,
	changfengnan@bytedance.com, linux-pci@vger.kernel.org,
	namjain@linux.microsoft.com, Luigi Rizzo <lrizzo@google.com>
Subject: Re: [RFC PATCH 2/3] PCI/MSI: Implement irq_mask_nowait() for MSI-x
Message-ID: <as_2hlWSsMciwCT1@kbusch-mbp>
References: <20261014173106.GA1643226@bhelgaas>
 <878q40f0oa.ffs@fw13>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878q40f0oa.ffs@fw13>
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

On Wed, Oct 14, 2026 at 11:10:45PM +0200, Thomas Gleixner wrote:
> On Wed, Oct 14 2026 at 12:31, Bjorn Helgaas wrote:
> >> Skip the read-back that flushes the MSI-x mask write. Parent domains
> >> that mask on behalf of PCI/MSI continue using their own irq_mask().
> >> 
> >> Signed-off-by: Keith Busch <kbusch@kernel.org>
> >
> > I assume Thomas will review/ack the pci/msi/ parts.
> 
> Yes. I actually suggested that "nowait" mechanism to Keith at LPC.
> 
> Though I hate the name of that callback because irq_mask() does not
> really wait. It guarantees that the mask store has reached the device
> which means that after that point no further interrupts will be sent by
> the device (assuming sane hardware). That means it's a synchronous
> operation which involves flushing the store, so maybe irq_mask_noflush()
> or irq_mask_async() might be more accurate and descriptive.

Right thank you, I misremembered your suggested name. I am totally fine
with "noflush", and I've made that change in my local branch. I'll just
wait a bit for any other feedback before the next version.

> > Cc'd Luigi since I know he's interested in interrupt moderation in
> > general.
> 
> Correct. I'm curious whether the interrupt frequency based moderation
> mechanism Luigi is proposing does solve the NVME issues as well or can
> be combined with some device specific hint mechanism.
> 
> That said, Luigi's approach should benefit from the "nowait" mechanism
> as well.
> 
> Luigi?
> 
> Thanks,
> 
>         tglx


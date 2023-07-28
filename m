Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85A53C001DE
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Jul 2023 19:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fR+1Ln/VcvVHWAwZyFEWuwdn/SQKZI7/b06t3zJQLos=; b=HtaQMPw3QBZJWLd+NMM8PUZx4H
	DoDf+tUkFd87FpH73U5k4AYu7R16of+O0JzKIgsU0cGcy62vCFjhkhRLmFBSy//1lnFCwaEGizlEW
	DJxIH8EIzBhPC65zn+EVbYLNQdlU4evNyHGXvAhxc/+pZZRn+APX/1ZF938+SrZfouCYaE/arROUr
	pUn2Jjy11JLFwT8HFQwYPYczNuyOMVsc1CENdWu+J5aAxhkDHk+v68gQZhtC7J520of4DKREQqbXz
	Q8+hjpevOzaYz2C6YrIDAiAY7nM7a7gA/PNOhfKfONZk9zmDwv5NxToFknBAHfzxACqrf0OoPo9QZ
	2oc0Hclg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qPTEe-004muf-31;
	Fri, 28 Jul 2023 19:34:48 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qPTEc-004muC-0G
	for linux-nvme@lists.infradead.org;
	Fri, 28 Jul 2023 19:34:47 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id D0AE8621B1;
	Fri, 28 Jul 2023 19:34:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB423C433C7;
	Fri, 28 Jul 2023 19:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690572884;
	bh=j8jNcmTYYntq9pAVo2UzJdRoU3x1ihUFJCes2YsaF/E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jJtVHE1oCeKXFQ2YOPpEvTEVZW6WSuvjT+4P7eaX6T5Uf5dTTbHVJFaiA9BFwPTaS
	 H9IMeFpMevEQQKjqRFGvrvkwAtQC+gb4b3p5ee3vHF+fiIwycWYCCjDsoXzYgH9xBm
	 63X7w/U3dkPG09uiHZUbwMxBo0v+ySrscND2ZbTGFMN3kx4P+kbpXEm6Zu8jsqt8pW
	 rFXgI97jdb/6sEFGxM14NkB1Dgnge/dDvmuoqKndSuOE7w0n1d6pRGBzIWC3lWdIMd
	 m99opBLE4qgS7OJaJ/Ea+s1YVPCTZl3zpC86thlNo0TmUaUe9PsMMj4zETHc+Gs1S0
	 qkeA6dhtaxEmQ==
Date: Fri, 28 Jul 2023 13:34:41 -0600
From: Keith Busch <kbusch@kernel.org>
To: Pratyush Yadav <ptyadav@amazon.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: do not set the NUMA node of device if it has
 none
Message-ID: <ZMQYURrKPqIyTkG7@kbusch-mbp.dhcp.thefacebook.com>
References: <20230725110622.129361-1-ptyadav@amazon.de>
 <ZL/dphk/MJMRskX8@kbusch-mbp.dhcp.thefacebook.com>
 <50a125da-95c8-3b9b-543a-016c165c745d@grimberg.me>
 <20230726131408.GA15909@lst.de>
 <mafs0cz0e8zc6.fsf_-_@amazon.de>
 <ZMFHEK95WGwtYbid@kbusch-mbp.dhcp.thefacebook.com>
 <mafs08rb28o4u.fsf_-_@amazon.de>
 <ZMGddjINDt10BSvf@kbusch-mbp.dhcp.thefacebook.com>
 <mafs0tttn7vs3.fsf_-_@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mafs0tttn7vs3.fsf_-_@amazon.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230728_123446_180977_1D426503 
X-CRM114-Status: GOOD (  26.30  )
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

On Fri, Jul 28, 2023 at 08:09:32PM +0200, Pratyush Yadav wrote:
> 
> I am guessing you are looking at irq_create_affinity_masks(). Yeah, It
> does not take into account the NUMA information. In fact, even if it
> did, the NUMA node associated with the IRQ is NUMA_NO_NODE
> (/proc/$irq/node == -1).
> 
> I did some more digging over the week to figure out what is going on. It
> seems like the kernel _does_ in fact allow all CPUs in the affinity. I
> added some prints in set_affinity_irq() in
> drivers/xen/events/events_base.c (since that is the irqchip for the
> interrupt). I see it being called with mask: ffffffff,ffffffff.
> 
> But I later see the function being called again with a different mask:
> 00000000,00008000. The stack trace shows the call is coming from
> ksys_write(). The process doing the write is irqbalance.
> 
> So I think your earlier statement was incorrect. irqbalance does in fact
> balance these interrupts and it probably looks at the NUMA information
> of the device to make that decision. My original reasoning holds and
> irqbalance is the one picking the affinity.
> 
> With this explanation, do you think the patch is good to go?

irqbalance still writes to the /proc/<irq>/smp_affinity to change it,
right? That's just getting I/O errors on my machines because it fails
irq_can_set_affinity_usr() for nvme's kernel managed interrupts (except
the first vector, but that one is not used for I/O). Is there another
path irqbalance is using that's somehow getting past the appropriate
checks? Or perhaps is your xen irq_chip somehow bypassing the managed
irq property?


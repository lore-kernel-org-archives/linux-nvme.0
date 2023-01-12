Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 546C9C54EBE
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Jan 2023 17:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4vAAA2QSJ6EDWG3q4r6bLl8AKe1mlgcIIAvaNMiDPeQ=; b=YNPyvovlNuNxcKYOwaFgFRJWzZ
	YIpGQx+JRs2RoXO1xOHIW2O0xi7AqJ44hK2TUEVnDF0TdKFjAV1a0vJwOV27DSwd42T0DuCgseoiZ
	uxgWKUAX/XBgpMiu6CLZiV7+7PmhFai4HjnFVL0N5qq80jawhmWV7pVwtZXN/8zhsoXQ3zKwq0GJ9
	Hj4OgWdu7JzurSpTMICyG/tuBCU3rE4o1HyZngR9BXITPrR2B+VhaLMVwbNJOedKIVFBvlGqmdRs5
	QZJYMWMVehjFH2rqFw1JorX6HmBGizSLZhs3hA6ut467Lqca6T4Dsfx29dyy3jcrJ0b6I3nPaQgls
	9WI3K20w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pG1kh-00G7Jl-Dl; Thu, 12 Jan 2023 17:52:35 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pG1jf-00G6jH-Cm
	for linux-nvme@lists.infradead.org; Thu, 12 Jan 2023 17:51:35 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 0D3BAB81F02;
	Thu, 12 Jan 2023 17:51:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EB40C433EF;
	Thu, 12 Jan 2023 17:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1673545888;
	bh=fuiP92JrsZ2s4CQJRIqi0YU5hv63kZVBIj5+5NdGYTk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TXLpQFrnceqVIM+7XQk+kAOTakBcGvoWzaAJOwutzWIyftrjlGDC80VxMXLLygLBY
	 7sDHz4gnOIpbnmLTgxUr/yXdM3cDEX2scDXdGARXVwOumXKWYaE/G/XxYevlh4yriH
	 6iSWmWjFGqsh/ZNwA9tZFrfHPGQkSqLo8LPCAiAHO6kQ02pf0FFV6sUzgOWYoHzayM
	 Ed9yaet3cVqfo/lFkVwSSKUKNFfzkQgozUJEIL1hNo8wN5yGO0GOCuK5KUk/Xi5Ocp
	 xXoVmHwBj3y4zP5FCOoEM2V1+DEgIu3pr+DZy9J564aMEO3mjIeDJV7KoANbsD746l
	 009/IeJvJNEFQ==
Date: Thu, 12 Jan 2023 10:51:25 -0700
From: Keith Busch <kbusch@kernel.org>
To: Klaus Jensen <its@irrelevant.dk>
Cc: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	qemu-block@nongnu.org, qemu-devel@nongnu.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: Re: completion timeouts with pin-based interrupts in QEMU hw/nvme
Message-ID: <Y8BInYMhWZ/IuW4+@kbusch-mbp.dhcp.thefacebook.com>
References: <Y8AG21o/9/3eUMIg@cormorant.local>
 <Y8A2qdbDZPicuZfL@kbusch-mbp.dhcp.thefacebook.com>
 <Y8BHUzcbdQ/SFBY9@cormorant.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8BHUzcbdQ/SFBY9@cormorant.local>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230112_095133_355513_47B27793 
X-CRM114-Status: GOOD (  27.20  )
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

On Thu, Jan 12, 2023 at 06:45:55PM +0100, Klaus Jensen wrote:
> On Jan 12 09:34, Keith Busch wrote:
> > On Thu, Jan 12, 2023 at 02:10:51PM +0100, Klaus Jensen wrote:
> > > 
> > > The pin-based interrupt logic in hw/nvme seems sound enough to me, so I
> > > am wondering if there is something going on with the kernel driver (but
> > > I certainly do not rule out that hw/nvme is at fault here, since
> > > pin-based interrupts has also been a source of several issues in the
> > > past).
> > 
> > Does it work if you change the pci_irq_assert() back to pci_irq_pulse()?
> > While probably not the "correct" thing to do, it has better results in
> > my testing.
> > 
> 
> A simple s/pci_irq_assert/pci_irq_pulse broke the device. However,
> 
> 	diff --git i/hw/nvme/ctrl.c w/hw/nvme/ctrl.c
> 	index 03760ddeae8c..0fc46dcb9ec4 100644
> 	--- i/hw/nvme/ctrl.c
> 	+++ w/hw/nvme/ctrl.c
> 	@@ -477,6 +477,7 @@ static void nvme_irq_check(NvmeCtrl *n)
> 		 return;
> 	     }
> 	     if (~intms & n->irq_status) {
> 	+        pci_irq_deassert(&n->parent_obj);
> 		 pci_irq_assert(&n->parent_obj);
> 	     } else {
> 		 pci_irq_deassert(&n->parent_obj);
> 
> 
> seems to do the trick (pulse is the other way around, assert, then
> deassert).
> 
> Probably not the "correct" thing to do, but I'll take it since it seems
> to fix it. On a simple boot loop I got the timeout about 1 out of 5. I'm
> on ~20 runs now and have not encountered it.

Yep, that looks good. It's sounding like something with the CPU irq
handling is treating the level interrupt as edge triggered.


Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34CC4C38147
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Jan 2023 23:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dm8XtrBJJtsQBR8lRdHUJneZaxjxHz06v+g1b/Ud6ow=; b=iBb+G78vrCD2iUgkEHLSWaFztC
	WM3Z/YHhLmvJx4xiAiE2DFVqwVE/fH0ptDd52kRnTOISccv86658pQbM9JKalN+ArgaaPPe9kmGgZ
	MALDVt1K/vcAIxP0ECE//zsmhpU5S/dFepDWALoNtzujCS11Pq3r+v1h46RVirebgDeroWuattE+d
	G146T+89hYG2ALc0C8FkSvOX0HU8U2tCNOUgQrDigtrQZxr8BLBH8EzA+hy5vdRVWCW/VBQLnLGRP
	aezG0rvaw/hv5TMB2dHM63pksrDj5qqUxcn7xpdlXkzzW/Fi3ef+fam/4wwjNut9sVAmm8ct3aQaf
	cBSMZ+ug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pIHVn-002vdd-6L; Wed, 18 Jan 2023 23:06:31 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pIHVj-002vcN-3x
	for linux-nvme@lists.infradead.org; Wed, 18 Jan 2023 23:06:29 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.source.kernel.org (Postfix) with ESMTPS id 6BC3FCE1BDD;
	Wed, 18 Jan 2023 23:06:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDC18C433D2;
	Wed, 18 Jan 2023 23:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1674083179;
	bh=lcb6GuRijycbENkRa5NSzL13WIRCluuTeRxRDSMoH70=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GUs/RS0YfEksCw/lMycxmQD8QBJcOIEewwLUJn18ThIi5l6sbs2/PLfDzq5Jux59B
	 kupEKhhbateTuZVedVk/dlRNgTZmkgLuPmA8UDaPholhxb/CkGdhhTgsEpxesrnK12
	 0ZoMWsMz/SViA+CQfj1b7oEfQxaKw4eV/cjh1jBvlKXU54bbc2Pcnxp4ZsmDXZbxNf
	 kdD2mr+njM1zyEBC34ZkL+ErzAW/lwajXdWTexKYNaOc+np8D9eSlhnuLSGGWPUxZR
	 uj1VVkqsB6ddtWtBhKpS9XuclnzPMTvWYJpmN6930tcqt+MmGiO6SGm6N9Z4S8ysr/
	 x4wQOK0iqpxag==
Date: Wed, 18 Jan 2023 16:06:16 -0700
From: Keith Busch <kbusch@kernel.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Guenter Roeck <linux@roeck-us.net>, Klaus Jensen <its@irrelevant.dk>,
	Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	qemu-block@nongnu.org, qemu-devel@nongnu.org
Subject: Re: completion timeouts with pin-based interrupts in QEMU hw/nvme
Message-ID: <Y8h7aOuVfCb+RsAP@kbusch-mbp>
References: <Y8AG21o/9/3eUMIg@cormorant.local>
 <Y8W+H6T9DOZ08SoF@cormorant.local>
 <Y8Yq5faCjAKzMa9O@kbusch-mbp>
 <20230117160933.GB3091262@roeck-us.net>
 <CAFEAcA9pS7P=SvKsOtRHPtkrNAD8LF2ZpFJ870G3B-rhWYap4g@mail.gmail.com>
 <20230117192115.GA2958104@roeck-us.net>
 <CAFEAcA_T8QqSg4SzszP+wR3pR1P1WTZg4f7mHHBGRw4UrTw+DQ@mail.gmail.com>
 <Y8gfQXPYdHKd1v4I@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8gfQXPYdHKd1v4I@kbusch-mbp>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230118_150627_539878_6FB9DAFC 
X-CRM114-Status: GOOD (  34.13  )
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

On Wed, Jan 18, 2023 at 09:33:05AM -0700, Keith Busch wrote:
> On Wed, Jan 18, 2023 at 03:04:06PM +0000, Peter Maydell wrote:
> > On Tue, 17 Jan 2023 at 19:21, Guenter Roeck <linux@roeck-us.net> wrote:
> > > Anyway - any idea what to do to help figuring out what is happening ?
> > > Add tracing support to pci interrupt handling, maybe ?
> > 
> > For intermittent bugs, I like recording the QEMU session under
> > rr (using its chaos mode to provoke the failure if necessary) to
> > get a recording that I can debug and re-debug at leisure. Usually
> > you want to turn on/add tracing to help with this, and if the
> > failure doesn't hit early in bootup then you might need to
> > do a QEMU snapshot just before point-of-failure so you can
> > run rr only on the short snapshot-to-failure segment.
> > 
> > https://translatedcode.wordpress.com/2015/05/30/tricks-for-debugging-qemu-rr/
> > https://translatedcode.wordpress.com/2015/07/06/tricks-for-debugging-qemu-savevm-snapshots/
> > 
> > This gives you a debugging session from the QEMU side's perspective,
> > of course -- assuming you know what the hardware is supposed to do
> > you hopefully wind up with either "the guest software did X,Y,Z
> > and we incorrectly did A" or else "the guest software did X,Y,Z,
> > the spec says A is the right/a permitted thing but the guest got confused".
> > If it's the latter then you have to look at the guest as a separate
> > code analysis/debug problem.
> 
> Here's what I got, though I'm way out of my depth here.
> 
> It looks like Linux kernel's fasteoi for RISC-V's PLIC claims the
> interrupt after its first handling, which I think is expected. After
> claiming, QEMU masks the pending interrupt, lowering the level, though
> the device that raised it never deasserted.

I'm not sure if this is correct, but this is what I'm coming up with and
appears to fix the problem on my setup. The hardware that sets the
pending interrupt is going clear it, so I don't see why the interrupt
controller is automatically clearing it when the host claims it.

---
diff --git a/hw/intc/sifive_plic.c b/hw/intc/sifive_plic.c
index c2dfacf028..f8f7af08dc 100644
--- a/hw/intc/sifive_plic.c
+++ b/hw/intc/sifive_plic.c
@@ -157,7 +157,6 @@ static uint64_t sifive_plic_read(void *opaque, hwaddr addr, unsigned size)
             uint32_t max_irq = sifive_plic_claimed(plic, addrid);
 
             if (max_irq) {
-                sifive_plic_set_pending(plic, max_irq, false);
                 sifive_plic_set_claimed(plic, max_irq, true);
             }
 
--


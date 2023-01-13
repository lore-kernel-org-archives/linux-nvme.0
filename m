Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9666C54EBE
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Jan 2023 16:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=p7U/aXoo3ZYdqsi3GD+YEW//C5NznQBNgE1XA9LXzoQ=; b=tjkGBNJTP/mJdVJwaoDom32VfR
	PkpT1z49cE1JVY9Y4quH85+5GSE1PqNif6S8AY/e/AiDBu2yfTnU1uUOrei5Dn3mNZYPlkng2A33j
	9CJDHm/yofuvFuXJg9Ra8iTd56XbrUMLed3wa/hb90yPx9Sb+Eug0VHtgkvpRF0872Hyf63uTCMVs
	t0mPXvvZ6SXXmpPtV7pExME5fHHC6CMnv7yjEsvWNRrDZDJcfb+My8rBkaxP8T+D25vqb7vAbKaEF
	OU/buxork3DivT57MrF4CRHPmxqOnQjGhXjqfr4zQtyTpb1P1ScWeGM8g6yiygvoYy6It2D7Sf7dd
	/A2d2XnQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pGNIW-003WgJ-8e; Fri, 13 Jan 2023 16:52:56 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pGNIT-003Wf6-Tb
	for linux-nvme@lists.infradead.org; Fri, 13 Jan 2023 16:52:55 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id BF22BB82195;
	Fri, 13 Jan 2023 16:52:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5B2BC433EF;
	Fri, 13 Jan 2023 16:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1673628769;
	bh=lkY+RTiBNroZSdLRO5ccPrGIEH7+n5ZCrjWpwDr4vwE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o9kya8BuRUuHs77LU8jN0tJopo+1SPCfEuyc5lEK7+RVlLx4iG8PiEIFKXcU8gBDG
	 t2a+cVsKVdGV9ycaZT1S5ih1JvQ5dh6cOFJuxrvlYYpx+RIqxeEeBjrrW28qNXVisZ
	 YjzXWy4CvlnvJ9IydUiZo/igAWzMbf8neK0X6BLfFbRP7FhYxQgxBhnp0MZXdbQO+K
	 CD+w/NaeSI93tyy7mnnErpEXNFG8by/wXCwcn2LcQh5An+5JLQbCcy3y8fUSnVj9yv
	 WKIvnPP1OssnKPeR0h8qklIDp78ikyEENNEJwu8JQb/wuef7M8RuIxq2yrSCArTv/T
	 SzPGexlnF+mUg==
Date: Fri, 13 Jan 2023 09:52:46 -0700
From: Keith Busch <kbusch@kernel.org>
To: Peter Maydell <peter.maydell@linaro.org>,
	t@kbusch-mbp.dhcp.thefacebook.com
Cc: Klaus Jensen <its@irrelevant.dk>, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, qemu-block@nongnu.org,
	qemu-devel@nongnu.org, Guenter Roeck <linux@roeck-us.net>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: completion timeouts with pin-based interrupts in QEMU hw/nvme
Message-ID: <Y8GMXpVZRqoHiTOi@kbusch-mbp.dhcp.thefacebook.com>
References: <Y8AG21o/9/3eUMIg@cormorant.local>
 <Y8EcOFE52X5KbzO7@cormorant.local>
 <CAFEAcA9y0E=EZwmetyvymvt64BpQxAnKMHs0E=BBH9_3OfMwFA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA9y0E=EZwmetyvymvt64BpQxAnKMHs0E=BBH9_3OfMwFA@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230113_085254_140646_86545371 
X-CRM114-Status: GOOD (  20.10  )
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

On Fri, Jan 13, 2023 at 12:32:29PM +0000, Peter Maydell wrote:
> On Fri, 13 Jan 2023 at 08:55, Klaus Jensen <its@irrelevant.dk> wrote:
> >
> > +CC qemu pci maintainers
> >
> > Michael, Marcel,
> >
> > Do you have any comments on this thread? As you can see one solution is
> > to simply deassert prior to asserting, the other is to reintroduce a
> > pci_irq_pulse(). Both seem to solve the issue.
> 
> Both seem to be missing any analysis of "this is what is
> happening, this is where we differ from hardware, this
> is why this is the correct fix". We shouldn't put in
> random "this seems to happen to cause the guest to boot"
> fixes, please.

It looks like these are being treated as edge instead of level
interrupts so the work-around is to create more edges. I would
definitely prefer a real fix, whether that's in the kernel or CPU
emulation or somewhere else, but I'm not sure I'll have time to see it
to completion.

FWIW, x86 seems to handle legacy IRQs with NVMe as expected. It's
actually easy enough for the DEASSERT to take so long that kernel
reports the irq as "spurious" because it's spinning too often on the
level.


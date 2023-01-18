Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8880CC32793
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Jan 2023 16:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Gkqjq8AgZbN785pvRoD7Q3q89t1BbNnKsQ2GquFXTcg=; b=x5C8njljO752HJB9Ooc9Gy/+9R
	S8GDZW1vEbqUJKrJ333RKkWRuVgItnCB5Z55G/p/iCf9dfvdlhLtdY2pTc8GX2/p8vIomR6HWJoMP
	rNg7IsLIoo+ODidw7gVj6kOTqgp7UU00RJ+eCGOlzCzXUxemZyGneL7CU8PCJ+2DSHPSDm2G1ImEm
	fGzVy4CWCK4v9g39HWhvNKFy3QPJIHwVMy0Kb7vgK8/Xv3LQ7QyR2MpUu3TkoQqXx1pgXzLLKlgjr
	PtNndQ3ATXvT/68lp1EhXg+mKOOngwxNuFVx0AvYFx0/ef/5lyCB2+2Y3dOcBT8s32fiW5QWzG3/a
	lZXsQxmQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pIBNB-001qat-3B; Wed, 18 Jan 2023 16:33:13 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pIBN7-001qZt-Qm
	for linux-nvme@lists.infradead.org; Wed, 18 Jan 2023 16:33:11 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 04915618B9;
	Wed, 18 Jan 2023 16:33:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFF45C433D2;
	Wed, 18 Jan 2023 16:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1674059588;
	bh=EvloRG3EpfE933ID5KKedUR5tkgFonAHLOduo6HbtG4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=abtW4dQI+3LDjGvw6JeLEt2l4OVehlfTuATrnFUwBWaRLZ9EKrPA/GbEXCkt+EIa0
	 FBDab+1gwIkHMUs4vimUQfxJk60llHIE+1qEyHTcn1ZPXBJea/K43+Qzgnz8DIyDJJ
	 lnySsJi8M8SrPvpzSScNL1X4BOIBpuoTvpWj2oI5fflJ65Q4LbMCZJjKvorPurNFSI
	 nLBf904KFVmekKYUDEfjo8hScVKEaqVD1230jWH9Vf4Tyu5W7P8MR6qmEJbhOwGZET
	 uF57Pg/4FZkAFJGXe0g+yQxWqCH55Djp4DwvXh9ojUJLM36N/r/zvdGoYZbwW0Du4f
	 lj8AF3Hf4QUnA==
Date: Wed, 18 Jan 2023 09:33:05 -0700
From: Keith Busch <kbusch@kernel.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Guenter Roeck <linux@roeck-us.net>, Klaus Jensen <its@irrelevant.dk>,
	Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	qemu-block@nongnu.org, qemu-devel@nongnu.org
Subject: Re: completion timeouts with pin-based interrupts in QEMU hw/nvme
Message-ID: <Y8gfQXPYdHKd1v4I@kbusch-mbp>
References: <Y8AG21o/9/3eUMIg@cormorant.local>
 <Y8W+H6T9DOZ08SoF@cormorant.local>
 <Y8Yq5faCjAKzMa9O@kbusch-mbp>
 <20230117160933.GB3091262@roeck-us.net>
 <CAFEAcA9pS7P=SvKsOtRHPtkrNAD8LF2ZpFJ870G3B-rhWYap4g@mail.gmail.com>
 <20230117192115.GA2958104@roeck-us.net>
 <CAFEAcA_T8QqSg4SzszP+wR3pR1P1WTZg4f7mHHBGRw4UrTw+DQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA_T8QqSg4SzszP+wR3pR1P1WTZg4f7mHHBGRw4UrTw+DQ@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230118_083309_936208_8DF85737 
X-CRM114-Status: GOOD (  23.45  )
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

On Wed, Jan 18, 2023 at 03:04:06PM +0000, Peter Maydell wrote:
> On Tue, 17 Jan 2023 at 19:21, Guenter Roeck <linux@roeck-us.net> wrote:
> > Anyway - any idea what to do to help figuring out what is happening ?
> > Add tracing support to pci interrupt handling, maybe ?
> 
> For intermittent bugs, I like recording the QEMU session under
> rr (using its chaos mode to provoke the failure if necessary) to
> get a recording that I can debug and re-debug at leisure. Usually
> you want to turn on/add tracing to help with this, and if the
> failure doesn't hit early in bootup then you might need to
> do a QEMU snapshot just before point-of-failure so you can
> run rr only on the short snapshot-to-failure segment.
> 
> https://translatedcode.wordpress.com/2015/05/30/tricks-for-debugging-qemu-rr/
> https://translatedcode.wordpress.com/2015/07/06/tricks-for-debugging-qemu-savevm-snapshots/
> 
> This gives you a debugging session from the QEMU side's perspective,
> of course -- assuming you know what the hardware is supposed to do
> you hopefully wind up with either "the guest software did X,Y,Z
> and we incorrectly did A" or else "the guest software did X,Y,Z,
> the spec says A is the right/a permitted thing but the guest got confused".
> If it's the latter then you have to look at the guest as a separate
> code analysis/debug problem.

Here's what I got, though I'm way out of my depth here.

It looks like Linux kernel's fasteoi for RISC-V's PLIC claims the
interrupt after its first handling, which I think is expected. After
claiming, QEMU masks the pending interrupt, lowering the level, though
the device that raised it never deasserted.


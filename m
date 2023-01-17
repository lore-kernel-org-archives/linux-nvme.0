Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31C93C3DA78
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Jan 2023 19:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=D4twTMKb3JyjqbVoT7/O+DFX4BsAdZj9XTMyT83V8Jk=; b=bZAxcBegXpuBeeIBXtnBUQrC/r
	vLsG/MWT8uVCxIMepxhURWjSCo/wiu1mmE5KcgIw2TMHonmRB2kDCjpohTtcp6Vmz7+qbWlA7K5yy
	TjVTMngs6Dfp/9X5es2XYpDaxamQytmjAfJXQCI/DlEUBdVN/GvevATbhtzSij6E1vx8IwceQsW8+
	qogNiarP8qa6dPnl5t76yPDQCxOyBXC8xmss1ZtwQAhysxOFUMVkbZJCeYLJOh9IeN8L4Pf+bJZZx
	Q5tQgJJ/nShS1PrJFBymuwO0wdWxG3+QsnL0wVwLUrfxgrquu4/OxQUxt/Vrq4KyZ/o9tE0VoEFA6
	4vpH1KvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pHrX6-00Fc7L-5V; Tue, 17 Jan 2023 19:22:08 +0000
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pHrWJ-00FbnR-77
	for linux-nvme@lists.infradead.org; Tue, 17 Jan 2023 19:21:20 +0000
Received: by mail-ot1-x32e.google.com with SMTP id a1-20020a056830008100b006864df3b1f8so1015155oto.3
        for <linux-nvme@lists.infradead.org>; Tue, 17 Jan 2023 11:21:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D4twTMKb3JyjqbVoT7/O+DFX4BsAdZj9XTMyT83V8Jk=;
        b=X+DXPzDQc0Unc9wFYrNJ2OaUxSth/qztTLqKgTvPLgeLIxR5mg4JWXtvIzkggT3cXh
         IoRoU3PHopCG1qDHgAwKjQk4n53fc7uiYv+xYVnBTPn8frps37ohFLBjL9HnxYBvXvS/
         /qSHIksxB1ALttDc6Yp0ML2qLv8+r+cOccK8C0hy+Jeah3KXfHveaVqB26CC/BGmI1gh
         uKe4cLdXJJAjcEQptIJdHKfpV1eXgekko56VxLqski/ramUo7+zUuCdzvI0gKG6AUFKd
         DiwBFtdirJWVJN7fYCql40I+bPAAy+9IJWDTp+VrtXtmKfCmun2g2raAvQg4Hr/oGHDI
         sRGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D4twTMKb3JyjqbVoT7/O+DFX4BsAdZj9XTMyT83V8Jk=;
        b=KlXX9qha9VQ22yGmd1NJ+ttqL9dnbFQFNqFEFDRPZeSV8Ayzknak+IbB+b3cZYFnkL
         7YompwFwDwkVqtknF4/Da0mYq3Etq/EpZ7Mt4Gz0EKI2lLvlwZsph5RNOmy0PTm09Ipc
         mdsoaTyei7A1Fe+toTOebc9l2u7K6yNaYKj8GbxPOujlu+l2XE7ivHbvd/TcIiMrhWwd
         oa9vA81AqpZsoifJDKbwTCW8hp3tERHIrF0NPC9p7HNjMgVzXOCSkN2D3UlSftwIuu9d
         O0tnoCDKqi8ssA39v7i3QuZeGawqnyXbandLqx8KVTYe957UY0rJPnTMbeuy2PZiZJwR
         WOmA==
X-Gm-Message-State: AFqh2koe2Z2WEgzAWgp68z/s+3zjMQNl3zkCcTvUscD/QVl3ZhDSVAMn
	mmQgAuEH7F01QbUM/mVUC10=
X-Google-Smtp-Source: AMrXdXslZVdiS3b9jmQugdSudYkYZ9aDkDx/D+mpUI6H5/Ezhv209ZXjIPOuZvACYh51OpaAGPTTFw==
X-Received: by 2002:a05:6830:39c4:b0:684:e745:6304 with SMTP id bt4-20020a05683039c400b00684e7456304mr2170896otb.9.1673983277987;
        Tue, 17 Jan 2023 11:21:17 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a18-20020a544e12000000b00363760f96dcsm14785685oiy.42.2023.01.17.11.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 11:21:17 -0800 (PST)
Date: Tue, 17 Jan 2023 11:21:15 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
	Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	qemu-block@nongnu.org, qemu-devel@nongnu.org
Subject: Re: completion timeouts with pin-based interrupts in QEMU hw/nvme
Message-ID: <20230117192115.GA2958104@roeck-us.net>
References: <Y8AG21o/9/3eUMIg@cormorant.local>
 <Y8W+H6T9DOZ08SoF@cormorant.local>
 <Y8Yq5faCjAKzMa9O@kbusch-mbp>
 <20230117160933.GB3091262@roeck-us.net>
 <CAFEAcA9pS7P=SvKsOtRHPtkrNAD8LF2ZpFJ870G3B-rhWYap4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA9pS7P=SvKsOtRHPtkrNAD8LF2ZpFJ870G3B-rhWYap4g@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230117_112119_300851_3AFBFF81 
X-CRM114-Status: GOOD (  37.19  )
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

On Tue, Jan 17, 2023 at 04:18:14PM +0000, Peter Maydell wrote:
> On Tue, 17 Jan 2023 at 16:10, Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > On Mon, Jan 16, 2023 at 09:58:13PM -0700, Keith Busch wrote:
> > > On Mon, Jan 16, 2023 at 10:14:07PM +0100, Klaus Jensen wrote:
> > > > I noticed that the Linux driver does not use the INTMS/INTMC registers
> > > > to mask interrupts on the controller while processing CQEs. While not
> > > > required by the spec, it is *recommended* in setups not using MSI-X to
> > > > reduce the risk of spurious and/or missed interrupts.
> > >
> > > That's assuming completions are deferred to a bottom half. We don't do
> > > that by default in Linux nvme, though you can ask the driver to do that
> > > if you want.
> > >
> > > > With the patch below, running 100 boot iterations, no timeouts were
> > > > observed on QEMU emulated riscv64 or mips64.
> > > >
> > > > No changes are required in the QEMU hw/nvme interrupt logic.
> > >
> > > Yeah, I can see why: it forces the irq line to deassert then assert,
> > > just like we had forced to happen within the device side patches. Still,
> > > none of that is supposed to be necessary, but this idea of using these
> > > registers is probably fine.
> >
> > There is still no answer why this would be necessary in the first place,
> > on either side. In my opinion, unless someone can confirm that the problem
> > is seen with real hardware, we should assume that it happens on the qemu
> > side and address it there.
> 
> Sure, but that means identifying what the divergence
> between QEMU's implementation and the hardware is first. I don't
> want a fudged fix in QEMU's code any more than you want one in
> the kernel's driver code :-)
> 

I actually prefer it in qemu because that means I can test nvme support
on all active LTS releases of the Linux kernel, but that is POV and
secondary. This has been broken ever since I started testing nvme
support with qemu, so it doesn't make much of a difference if fixing
the problem for good takes a bit longer. Plus, I run my own version
of qemu anyway, so carrying the fix (hack) in qemu doesn't make much
of a difference for me.

Anyway - any idea what to do to help figuring out what is happening ?
Add tracing support to pci interrupt handling, maybe ?

Guenter


Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 329B8C38159
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Jan 2023 00:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=os8ISr1qekJC2Kdy31xqUE3rwuUYjA10vSUZ0febqKY=; b=Ou5UJXHgxXnR99uaKGbmKoXwZy
	qKfi9qq2WRG5GaqYgOwexscHTPfR8Pc7eucf6FVtLww4/1hEUWYAHiTzCtS5tIafC0z+vKcIbBXqR
	gc/iqcSBcDwqjB/qMt5f9rO+spIovxhQRJ5AlIcdgiGVrdyujIFYme8QsLhB4pWCLz8lMDacXd3q0
	6JBFAaZAxOaZX3LB1OVVHZZgodn7hutqCzmV1bJRXp6fKI8Afvs8Y0XiXO+GFWdMEO/9trJ0IigiO
	4F2xdW7Yp7fKPJQLY+uZAtG0jV0zpFRv6CX0s6pekNSLpVaqrfZ8//RwjOtc3UpnXkrFVtP0FWjI+
	qbH1puqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pIJ0Q-00345Y-R3; Thu, 19 Jan 2023 00:42:14 +0000
Received: from mail-ua1-x92e.google.com ([2607:f8b0:4864:20::92e])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pIJ0N-00344g-C4
	for linux-nvme@lists.infradead.org; Thu, 19 Jan 2023 00:42:13 +0000
Received: by mail-ua1-x92e.google.com with SMTP id u3so144727uae.0
        for <linux-nvme@lists.infradead.org>; Wed, 18 Jan 2023 16:42:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=os8ISr1qekJC2Kdy31xqUE3rwuUYjA10vSUZ0febqKY=;
        b=E0nsc45ogFDvyQBMJqIt8nMR72wcQ/qvJZ/34T19dV1/US79uTaDKbsdvqyBtRUAxm
         T7ghRoNhrajyyPxOFSduoU8I+bzB1KZB7ciBh0aqFvNEx1DAhbuwLeA8r3N3fpyFLaVX
         TUpeiVfQRAp/1glIPeQUEXZwQr99BVG5LDyAc+LG9C8Fjgy7NR1f/PWF0pgqse6Cu4Bk
         pxNGkzgwv76FlPerzGNDHtXGf9vhIY2XqLDz89xah8rCwQ6uD3ZVudyO1t55+1LTh22y
         a7RxTzn2Fr/ZOGZZ9gHRX0CmCbBHgd3dbU2QsCA40S0V7VaPcWpKcY8ZUz3K0HCLRq6I
         oyXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=os8ISr1qekJC2Kdy31xqUE3rwuUYjA10vSUZ0febqKY=;
        b=seUBEZNd8oG910iyPvQN7XJVK6629SDM6NhBBGZqiis+S7steddWm0td3vMgrkOIBS
         fgOHA1/IyJ8PEOPX/UI2uTxwuQgHI8Ii4YZ9IsmEs6LStpMLN9UCJHh8fRPsywyly7Cx
         qMp4AX94i1CQKgB++DOy1NqlchTUGcuHCA8VGMCbDlcOes+lFzOLipVLzP0o4XyE4wfa
         TPBJ1H7cF4B8Gv8G1931Gpciy48qI3LWN+FEevOVWVPI/1UToO8x67cAulTlxpachH0N
         hHuYSGZW7VmEAHfyu+Chdqrc1DyZX+iUqRuW/EARsRPanUZVA7pQwsHTsje5yCKVyK+6
         S6MA==
X-Gm-Message-State: AFqh2krtjbtmtJqQRJg2fZAVUyRZ2TLem3sLJiGXuCDhx7Wcambenl3j
	z0xp+Suskpqhgb+ZMOTVX1ANTCoqO+RtdnUIgO0=
X-Google-Smtp-Source: AMrXdXupiWHmErhf/AtP1UQ1VxxIcyiGHH227P3x4dyqKu23FG5DEBpEqzuV0ErADpRUCEOTDoiOqXLBazU8ceX3DXM=
X-Received: by 2002:ab0:3b8d:0:b0:419:2865:3ae7 with SMTP id
 p13-20020ab03b8d000000b0041928653ae7mr1072202uaw.70.1674088928508; Wed, 18
 Jan 2023 16:42:08 -0800 (PST)
MIME-Version: 1.0
References: <Y8AG21o/9/3eUMIg@cormorant.local> <Y8W+H6T9DOZ08SoF@cormorant.local>
 <Y8Yq5faCjAKzMa9O@kbusch-mbp> <20230117160933.GB3091262@roeck-us.net>
 <CAFEAcA9pS7P=SvKsOtRHPtkrNAD8LF2ZpFJ870G3B-rhWYap4g@mail.gmail.com>
 <20230117192115.GA2958104@roeck-us.net> <CAFEAcA_T8QqSg4SzszP+wR3pR1P1WTZg4f7mHHBGRw4UrTw+DQ@mail.gmail.com>
 <Y8gfQXPYdHKd1v4I@kbusch-mbp> <Y8h7aOuVfCb+RsAP@kbusch-mbp>
In-Reply-To: <Y8h7aOuVfCb+RsAP@kbusch-mbp>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 19 Jan 2023 10:41:42 +1000
Message-ID: <CAKmqyKMHs_-RgagMDYE7vn3MHEP2caBc+RERjaK0DNJw4hFYiA@mail.gmail.com>
Subject: Re: completion timeouts with pin-based interrupts in QEMU hw/nvme
To: Keith Busch <kbusch@kernel.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Guenter Roeck <linux@roeck-us.net>, 
	Klaus Jensen <its@irrelevant.dk>, Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org, qemu-block@nongnu.org, 
	qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230118_164211_431691_58D78294 
X-CRM114-Status: GOOD (  38.71  )
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

On Thu, Jan 19, 2023 at 9:07 AM Keith Busch <kbusch@kernel.org> wrote:
>
> On Wed, Jan 18, 2023 at 09:33:05AM -0700, Keith Busch wrote:
> > On Wed, Jan 18, 2023 at 03:04:06PM +0000, Peter Maydell wrote:
> > > On Tue, 17 Jan 2023 at 19:21, Guenter Roeck <linux@roeck-us.net> wrot=
e:
> > > > Anyway - any idea what to do to help figuring out what is happening=
 ?
> > > > Add tracing support to pci interrupt handling, maybe ?
> > >
> > > For intermittent bugs, I like recording the QEMU session under
> > > rr (using its chaos mode to provoke the failure if necessary) to
> > > get a recording that I can debug and re-debug at leisure. Usually
> > > you want to turn on/add tracing to help with this, and if the
> > > failure doesn't hit early in bootup then you might need to
> > > do a QEMU snapshot just before point-of-failure so you can
> > > run rr only on the short snapshot-to-failure segment.
> > >
> > > https://translatedcode.wordpress.com/2015/05/30/tricks-for-debugging-=
qemu-rr/
> > > https://translatedcode.wordpress.com/2015/07/06/tricks-for-debugging-=
qemu-savevm-snapshots/
> > >
> > > This gives you a debugging session from the QEMU side's perspective,
> > > of course -- assuming you know what the hardware is supposed to do
> > > you hopefully wind up with either "the guest software did X,Y,Z
> > > and we incorrectly did A" or else "the guest software did X,Y,Z,
> > > the spec says A is the right/a permitted thing but the guest got conf=
used".
> > > If it's the latter then you have to look at the guest as a separate
> > > code analysis/debug problem.
> >
> > Here's what I got, though I'm way out of my depth here.
> >
> > It looks like Linux kernel's fasteoi for RISC-V's PLIC claims the
> > interrupt after its first handling, which I think is expected. After
> > claiming, QEMU masks the pending interrupt, lowering the level, though
> > the device that raised it never deasserted.
>
> I'm not sure if this is correct, but this is what I'm coming up with and
> appears to fix the problem on my setup. The hardware that sets the
> pending interrupt is going clear it, so I don't see why the interrupt
> controller is automatically clearing it when the host claims it.
>
> ---
> diff --git a/hw/intc/sifive_plic.c b/hw/intc/sifive_plic.c
> index c2dfacf028..f8f7af08dc 100644
> --- a/hw/intc/sifive_plic.c
> +++ b/hw/intc/sifive_plic.c
> @@ -157,7 +157,6 @@ static uint64_t sifive_plic_read(void *opaque, hwaddr=
 addr, unsigned size)
>              uint32_t max_irq =3D sifive_plic_claimed(plic, addrid);
>
>              if (max_irq) {
> -                sifive_plic_set_pending(plic, max_irq, false);
>                  sifive_plic_set_claimed(plic, max_irq, true);
>              }
>

This change isn't correct. The PLIC spec
(https://github.com/riscv/riscv-plic-spec/releases/download/1.0.0_rc5/riscv=
-plic-1.0.0_rc5.pdf)
states:

"""
On receiving a claim message, the PLIC core will atomically determine
the ID of the highest-priority pending interrupt for the target and
then clear down the corresponding source=E2=80=99s IP bit
"""

which is what we are doing here. We are clearing the pending interrupt
inside the PLIC

Alistair


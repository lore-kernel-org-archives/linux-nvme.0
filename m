Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95412E7717F
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Dec 2024 19:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qmPtgTp0uWnBLkuQLorEouQf2MBrr6p4pzJFNoT2zvY=; b=UWShcXxJX0KC9RR1lZH7dh8Wuo
	tCfEgohhxWX5MRuLPHXdJ1bZLaoLQEjr0gXCG7ztDwlBh5rdmZNRNMFsVKo5B8GnwuHiLIxg2T1Fr
	p0MMGr47kiTfd4Qca/B3yJC9MwuBC5LGlQkeFBu3m25E/3HC5MGGKSyYbwwoJgQ04wR9mOyPmnuoH
	Rn5CTEJinwSHXJ1BuSacF4uzjwfRvMMWfDbS23APxpkaPWkDsyuR3PZx2NYbFOlvfu02vor7r45fO
	QsM3GMVJcZZNvtwVV90DO4x4wkwgUEDAL93ocAk/stuyH9ZBaNKsNIWsPYvpogfrMwDbc/xnea37V
	tmCgFzFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tNGU4-0000000B3JM-3ev7;
	Mon, 16 Dec 2024 19:10:24 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tNGU2-0000000B3Iv-0m3Y
	for linux-nvme@lists.infradead.org;
	Mon, 16 Dec 2024 19:10:23 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 8F7FBA419F3
	for <linux-nvme@lists.infradead.org>; Mon, 16 Dec 2024 19:08:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 108D1C4CED4
	for <linux-nvme@lists.infradead.org>; Mon, 16 Dec 2024 19:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734376221;
	bh=qeYHwULuvIS8IOi5OkxWsi2QR2qYDfzPIJmQKUyh6FM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=evCvRQpTS0zks6AjRvM+fshukuAwu5HI4Xyg5uISYDIcRm669qGpnazk5HWkd4ClL
	 yQHsbIu/Xlzpd3Acmm4N0WyDJY8OhnMWwG2IKgSR0YtmntaPa0H31ELwm31jb4HGXy
	 JNuL4hBMIw6ufvawmu7gn47NYuEzbD4SEGoIGoi/ZIpbYe18VlkQUxZNOHmyxEeZ5k
	 Dg+l8u/pCkeBzf4/B0mb/pRUXbfj1ab/O3dFESxNJmFlPkuYsDPPFwamiOTLgSCcax
	 xbrClSp+dY/EXqrxCol8MmDEX0fz7aaV/X54M8TX43F+1rMmrWFSkrtOQjG6vDN1Rr
	 kooxsSqWfecFQ==
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3ea55a2a38bso2402349b6e.1
        for <linux-nvme@lists.infradead.org>; Mon, 16 Dec 2024 11:10:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVkKhKV5QITRnzvBbDOBvYy0t7kUifAfoWUaQK1BmvOGAAJe/ruq6wcZY1rU+SyAU6IuQDKqlp2nh2N@lists.infradead.org
X-Gm-Message-State: AOJu0YwfojV/t2rCGX4O9VZMWbcdOj3vYRhrEoEGjKPFOqzu5zukVhoB
	7O6sauWLzLDpu7CfJgavX+9rTlpKuo+sZSnGsUogaafOTTh9H/69LzzhOLcx/K9LTYHcf+Isa4h
	v/Qe9MTd+4u/Nz1pna+HxRWkT9Zo=
X-Google-Smtp-Source: AGHT+IEtKuUcyShfRdoQ6ZVPEaQjiY5/nPcB9LIM8bKSgRsRQ5zSt7I5tDEKwVaMyBFzeZP4GURKyXnod0Il+Bz/kOQ=
X-Received: by 2002:a05:6808:2384:b0:3ea:431c:4f70 with SMTP id
 5614622812f47-3eba65cb9e1mr7328003b6e.0.1734376220324; Mon, 16 Dec 2024
 11:10:20 -0800 (PST)
MIME-Version: 1.0
References: <20241212055920.GB4825@lst.de> <13662231.uLZWGnKmhe@rjwysocki.net>
 <CAPDyKFrxEjHFB6B2r7JbryYY6=E4CxX_xTmLDqO6+26E+ULz6A@mail.gmail.com>
 <20241212151354.GA7708@lst.de> <CAJZ5v0gUpDw_NjTDtHGCUnKK0C+x0nrW6mP0tHQoXsgwR2RH8g@mail.gmail.com>
 <20241214063023.4tdvjbqd2lrylb7o@thinkpad> <20241216162303.GA26434@lst.de>
 <CAJZ5v0g8CdGgWA7e6TXpUjYNkU1zX46Rz3ELiun42MayoN0osA@mail.gmail.com>
 <20241216164830.36lpu6gfnapsdar4@thinkpad> <CAJZ5v0hxnYere19wXbua6zWEDRDgSPeJgSECugtwfgTP-UN8Bw@mail.gmail.com>
 <20241216173945.s5y4dsyzhi5fo4ey@thinkpad>
In-Reply-To: <20241216173945.s5y4dsyzhi5fo4ey@thinkpad>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 16 Dec 2024 20:10:09 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hhruAS_b739FTo_63=h=U5zbH5M5jWco8pq+KwVY5UcA@mail.gmail.com>
Message-ID: <CAJZ5v0hhruAS_b739FTo_63=h=U5zbH5M5jWco8pq+KwVY5UcA@mail.gmail.com>
Subject: Re: [PATCH] nvme-pci: Shutdown the device if D3Cold is allowed by the user
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Christoph Hellwig <hch@lst.de>, Ulf Hansson <ulf.hansson@linaro.org>, 
	"Rafael J. Wysocki" <rjw@rjwysocki.net>, Bjorn Helgaas <helgaas@kernel.org>, kbusch@kernel.org, 
	axboe@kernel.dk, sagi@grimberg.me, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, andersson@kernel.org, 
	konradybcio@kernel.org, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241216_111022_356589_726BD73C 
X-CRM114-Status: GOOD (  36.59  )
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

On Mon, Dec 16, 2024 at 6:39=E2=80=AFPM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> On Mon, Dec 16, 2024 at 06:28:55PM +0100, Rafael J. Wysocki wrote:
> > On Mon, Dec 16, 2024 at 5:48=E2=80=AFPM Manivannan Sadhasivam
> > <manivannan.sadhasivam@linaro.org> wrote:
> > >
> > > On Mon, Dec 16, 2024 at 05:42:30PM +0100, Rafael J. Wysocki wrote:
> > > > On Mon, Dec 16, 2024 at 5:23=E2=80=AFPM Christoph Hellwig <hch@lst.=
de> wrote:
> > > > >
> > > > > On Sat, Dec 14, 2024 at 12:00:23PM +0530, Manivannan Sadhasivam w=
rote:
> > > > > > We need a PM core API that tells the device drivers when it is =
safe to powerdown
> > > > > > the devices. The usecase here is with PCIe based NVMe devices b=
ut the problem is
> > > > > > applicable to other devices as well.
> > > > >
> > > > > Maybe I'm misunderstanding things, but I think the important part=
 is
> > > > > to indicate when a suspend actually MUST put the device into D3. =
 Because
> > > > > doing that should always be safe, but not always optimal.
> > > >
> > > > I'm not aware of any cases when a device must be put into D3cold
> > > > (which I think is what you mean) during system-wide suspend.
> > > >
> > > > Suspend-to-idle on x86 doesn't require this, at least not for
> > > > correctness.  I don't think any platforms using DT require it eithe=
r.
> > > >
> > >
> > > On suspend-to-idle, yes D3Cold doesn't make sense,
> >
> > Why?
> >
>
> Because there is no requirement to remove power during S2Idle, isn't it?

There is no requirement, but there is a reason that I've already
mentioned: A device in D3cold causes a system in s2idle use less
energy.

I think this reason is good enough.

> From Documentation/admin-guide/pm/sleep-states.rst:
>
> 'This is a generic, pure software, light-weight variant of system suspend=
'.

Sure.  Which basically means that platform firmware is not involved
(at least not as much as in the ACPI S3 case) and CPUs are managed in
a more lightweight way.

The power states of devices are what they are.

Moreover, the whole idea of suspend-to-idle is to re-use the
suspend-to-RAM (ACPI S3, basically) control flow, along with the
handling of devices.  The devices handled differently are exceptions,
not a rule.

> > > but on suspend-to-ram it is pretty much required.
> >
> > Well, I know for a fact that on x86 platforms ACPI S3 does not require
> > putting devices into D3cold in general.
> >
> > Why is it required for NVMe?
> >
>
> But ACPI code currently calls pm_set_suspend_via_firmware() for S3 suspen=
d. And
> that causes NVMe to be powered down because of pm_suspend_via_firmware() =
check.

That's how the driver is designed, but is it actually required to be
designed this way?

> > > That applies to DT as well.
> >
> > Again, why?
>
> On DT systems if firmware supports both S2Idle and S2R, devices can be ke=
pt in
> low power state during S2Idle and powered down during S2R.
>
> The problem comes if the firmware only supports the former state.

I don't get it, sorry.

Firmware support for suspend-to-idle is not required, at least in
principle, so I'm not sure what you mean by firmware support for it.
I'm also not sure how S2R is supported by firmware on DT systems, so
care to explain?

In any case, I don't see why in principle devices need to be handled
differently depending on what flavor of system suspend in used at any
given time.


Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90854E77184
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Dec 2024 19:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=B8qDHbplZj9GYWQDaxSwZdHxa9pPQEc/Ol2yq3N71o4=; b=ykEfJYp2GQe/VYKVzgBt0RoQFi
	QY/V7PR8enfkhrwEiSYTNO2iPFELToaFdl/NjHTvljsVgpl3YBKQ+L7QqYqTiE9r73fJ36KdT8YJT
	bw8DADB4T8KpB93c6nS807yf5hLZnIh0CNWnBo0HxzQuETLG3nUsw4E4/7bMKX7xEru8y4M1aXqxV
	ITJop/dLDKB4AXSK+lDpIOTbJiQ/TsXpyrnOVo8up3Y8jZ+XFVr5ebo5h1Q4kBc39q3CkD5axOY1i
	4ARXkA0MhLg5CFQZ6/FcwTuXsuCyfNu9mEai0qgvlknJtJUa+wegjZb80a6hHKBSaS+3qrEPX1sMn
	QP03YTRg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tNdYA-0000000Efrj-3oH8;
	Tue, 17 Dec 2024 19:48:10 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tNdWC-0000000EfWT-3xHz
	for linux-nvme@lists.infradead.org;
	Tue, 17 Dec 2024 19:46:10 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 1B26BA41F74
	for <linux-nvme@lists.infradead.org>; Tue, 17 Dec 2024 19:44:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 760E7C4CEDE
	for <linux-nvme@lists.infradead.org>; Tue, 17 Dec 2024 19:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734464767;
	bh=wyJiG/rLnKAPw4CMoQ49S9+BlufEkKww1bk1cRGlQgc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nz9aU/21W2PnkUQQf6L9uWtVyRD+Mvw7yeG+vWC61KvhO08g7eNSiDMDUb3wU1RUa
	 IqQ/Mw6EmU/ifaqTLQ8GeATycTqsfPiuV3tZ8LJNOyBjPmut7M7Ar4uejqAjM61Gi8
	 +wX1yC5n+k+P2cZ6PjHAMwWW887hfb9ANnKpE3V1t4nNR/uAjWq38tn+sICcodwqbp
	 hhWfbZovz1S0ir0FoZsOFRtvyk1IaegmlElV4MI9qjeva3+yot1pNwgwbZN88YZirN
	 yOq3BAfurMud0MUx+YvH6YTji4sg0d/L/lPEdKItVKfOMlbhvXKUP1Rc1sFcfq2Ucb
	 pesNTi7eDaqfA==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-29fbba47ca4so2444430fac.3
        for <linux-nvme@lists.infradead.org>; Tue, 17 Dec 2024 11:46:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWFGXytXXIwmLtt2c1McXRyfrwHbU+AX02PBFm+s/ZjNFYFazGK+5ps2qJ0YQzHKOsgh+RFThEV9Ig2@lists.infradead.org
X-Gm-Message-State: AOJu0Ywn4XlYdiZLJ3QOEZmAHoWdy75dVIzO/ZWAy8ho3tT3i/xiSo9Q
	BSp/3KyDNGoUXgkAwXvQvmqgg4eM1f4RjINOXG8/lXtyt8TZ8zaPrXK2G9xVQbmq3sF2E4pmbRu
	aLabS3aWbwXNoMcq6iWtcJoiv5eA=
X-Google-Smtp-Source: AGHT+IEJN65jnqoUm5qKhxy6agNk8T9r7w4H2Q+RaZ1R8d53sbh1tSUPnZ90YzUfvrdsz7qclSKbPLHvNXiMBqJfdSA=
X-Received: by 2002:a05:6871:5b2a:b0:287:471:41eb with SMTP id
 586e51a60fabf-2a7b2ff375bmr54024fac.6.1734464766657; Tue, 17 Dec 2024
 11:46:06 -0800 (PST)
MIME-Version: 1.0
References: <13662231.uLZWGnKmhe@rjwysocki.net> <CAPDyKFrxEjHFB6B2r7JbryYY6=E4CxX_xTmLDqO6+26E+ULz6A@mail.gmail.com>
 <20241212151354.GA7708@lst.de> <CAJZ5v0gUpDw_NjTDtHGCUnKK0C+x0nrW6mP0tHQoXsgwR2RH8g@mail.gmail.com>
 <20241214063023.4tdvjbqd2lrylb7o@thinkpad> <CAJZ5v0gLMx+tBo+MA3AQZ7qP28Z91d04oVBHVeTNcd-QD=kJZg@mail.gmail.com>
 <20241216171108.6ssulem3276rkycb@thinkpad> <CAJZ5v0j+4xjSOOy8TYE0pBuqd_GdQa683Qq0GEyJ9WAFad9Z=A@mail.gmail.com>
 <20241216175210.mnc5kp6646sq7vzm@thinkpad> <CAJZ5v0grRdTYaamSnKSF-HyMmCHDEZ4haLo+ziSBxhDg1PbjRQ@mail.gmail.com>
 <20241217052632.lbncjto5xibdkc4c@thinkpad>
In-Reply-To: <20241217052632.lbncjto5xibdkc4c@thinkpad>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 17 Dec 2024 20:45:55 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gjrBUgejwBz1vv6P83oZiYu8AuDMs47ZAFJoNhMaMdpQ@mail.gmail.com>
Message-ID: <CAJZ5v0gjrBUgejwBz1vv6P83oZiYu8AuDMs47ZAFJoNhMaMdpQ@mail.gmail.com>
Subject: Re: [PATCH] nvme-pci: Shutdown the device if D3Cold is allowed by the user
To: manivannan.sadhasivam@linaro.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Christoph Hellwig <hch@lst.de>, Ulf Hansson <ulf.hansson@linaro.org>, 
	"Rafael J. Wysocki" <rjw@rjwysocki.net>, Bjorn Helgaas <helgaas@kernel.org>, kbusch@kernel.org, 
	axboe@kernel.dk, sagi@grimberg.me, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, andersson@kernel.org, 
	konradybcio@kernel.org, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241217_114609_111383_1E72BA08 
X-CRM114-Status: GOOD (  72.73  )
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

On Tue, Dec 17, 2024 at 6:26=E2=80=AFAM <manivannan.sadhasivam@linaro.org> =
wrote:
>
> On Mon, Dec 16, 2024 at 08:34:24PM +0100, Rafael J. Wysocki wrote:
>
> [...]
>
> > > There is also a case where some devices like
> > > (Laptops made out of Qcom SCX Gen3 SoCs) require all the PCIe devices=
 to be
> > > powered down in order for the SoC to reach its low power state (CX po=
wer
> > > collapse in Qcom terms). If not, the SoC would continue to draw more =
power
> > > leading to battery draining quickly. This platform is supported in up=
stream and
> > > we keep the PCIe interconnect voted during suspend as the NVMe driver=
 is
> > > expecting the device to retain its state during resume. Because of th=
is
> > > requirement, this platform is not reaching SoC level low power state =
with
> > > upstream kernel.
> >
> > OK, now all of this makes sense and that's why you really want NVMe
> > devices to end up in some form of PCI D3 in suspend-to-idle.
> >
> > Would D3hot be sufficient for this platform or does it need to be
> > D3cold?  If the latter, what exactly is the method by which they are
> > put into D3cold?
> >
>
> D3Cold is what preferred. Earlier the controller driver used to transitio=
n the
> device into D3Cold by sending PME_Turn_Off, turning off refclk, regulator=
s
> etc... Now we have a new framework called 'pwrctrl' that handles the
> clock/regulators supplied to the device. So both controller and pwrctrl d=
rivers
> need to work in a tandem to put the device into D3Cold.
>
> Once the PCIe client driver (NVMe in this case) powers down the device, t=
hen
> controller/pwrctrl drivers will check the PCIe device state and transitio=
n the
> device into D3Cold. This is a TODO btw.
>
> But right now there is no generic D3Cold handling available for DT platfo=
rms. I
> am hoping to fix that too once this NVMe issue is handled.

There's no generic D3cold handling for PCIe devices at all AFAICS.  At
least, I'm not aware of any standard way to do it.  Yes, there are
vendor-specific conventions that may even be followed by multiple
vendors, but not much beyond that.

> > > > > > > If the platform is using DT, then there is no entity setting
> > > > > > > pm_set_suspend_via_firmware().
> > > > > >
> > > > > > That's true and so the assumption is that in this case the hand=
ling of
> > > > > > all devices will always be the same regardless of which flavor =
of
> > > > > > system suspend is chosen by user space.
> > > > > >
> > > > >
> > > > > Right and that's why the above concern is raised.
> > > >
> > > > And it is still unclear to me what the problem with it is.
> > > >
> > > > What exactly can go wrong?
> > > >
> > > > > > > So NVMe will be kept in low power state all the
> > > > > > > time (still draining the battery).
> > > > > >
> > > > > > So what would be the problem with powering it down unconditiona=
lly?
> > > > > >
> > > > >
> > > > > I'm not sure how would you do that (by checking dev_of_node()?). =
Even so, it
> > > > > will wear out the NVMe devices if used in Android tablets etc...
> > > >
> > > > I understand the wear-out concern.
> > > >
> > > > Is there anything else?
> > > >
> > >
> > > No, that's the only concern.
> >
> > OK
> >
> > I think we're getting to the bottom of the issue.
> >
> > First off, there really is no requirement to avoid putting PCI devices
> > into D3hot or D3cold during suspend-to-idle.  On all modern Intel
> > platforms, PCIe devices are put into D3(hot or cold) during
> > suspend-to-idle and I don't see why this should be any different on
> > platforms from any other vendors.
> >
> > The NVMe driver is an exception and it avoids D3(hot or cold) during
> > suspend-to-idle because of problems with some hardware or platforms.
> > It might in principle allow devices to go into D3(hot or cold) during
> > suspend-to-idle, so long as it knows that this is going to work.
> >
>
> Slight correction here.
>
> NVMe driver avoids PCI PM _only_ when it wants to handle the NVMe power
> state on its own, not all the time. It has some checks [1] in the suspend=
 path
> and if the platform/device passes one of the checks, it will power down t=
he
> device.

Yes, there is a comment in that code explaining what's going on and
that is basically "if key ingredients are missing or the firmware is
going to do its thing anyway, don't bother".

> DT platforms doesn't pass any of the checks, so the NVMe driver always ma=
nages
> the power state on its own. Unfortunately, the resultant power saving is =
not
> enough, so the vendors (Laptop/Automotive) using DT want NVMe to be power=
ed down
> all the time. This is the first problem we are trying to solve.
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/drivers/nvme/host/pci.c#n3448

I see.

This cannot be done by the driver itself, though, at least not in
general.  The PCI layer needs to be involved and, if we are talking
about D3cold, the platform firmware needs to be involved either.

As a rule, the PCI layer reaches out to the platform firmware for help
as needed and drivers don't take part in this directly.

The NVMe driver would need to let the PCI layer take over and set the
PCI power state of the device if it wanted to get any deeper than NVMe
protocol specific power states.

In principle, this can be addressed with some kind of a driver opt-in.
That is, the NVMe driver would continue to work the way it does, but
instead of completely preventing the PCI layer from taking over, it
would opt in (the exact opt-in mechanism is TBD) for D3cold if (a) the
platform firmware provides a mechanism to do so and (b) the DT
indicates that this mechanism should be used for the given device.

> > However, there is an additional concern that putting an NVMe device
> > into D3cold every time during system suspend on Android might cause it
> > to wear out more quickly.
> >
>
> Right, this is the second problem.

Let's set this one somewhat aside for now.  We'll get back to it when
we have clarity in the above.

> > Is there anything else?
>
> We also need to consider the fact that the firmware in some platforms doe=
sn't
> support S2R. So we cannot take a decision based on S2I/S2R alone.

Right, the S2I/S2R thing is ACPI-specific.

On platforms using ACPI, pm_suspend_via_firmware() means that the
firmware is at least likely to power down the whole platform, so the
PCI layer may as well be allowed to do what it wants with the device.

> I think there are atleast a couple of ways to solve above mentioned probl=
ems:
>
> 1. Go extra mile, take account of all issues/limitations mentioned above =
and
> come up with an API. This API will provide a sane default suspend behavio=
r to
> drivers (fixing first problem) and will also allow changing the behavior
> dynamically (to fix the second problem where kernel cannot distinguish An=
droid
> vs other OS).

I don't quite follow TBH.

A "default suspend behavior" is there already and it is to allow the
PCI layer to set the device's power state (in collaboration with the
platform firmware).  Thing is, the NVMe driver doesn't always want to
rely on it.

> 2. Allow DT platforms to call pm_set_suspend_via_firmware() and make use =
of the
> existing behavior in the NVMe driver. This would only solve the first pro=
blem
> though. But would be a good start.

That would mean just letting the PCI layer always take over on the
platforms that would call pm_set_suspend_via_firmware().

There is a potential issue with doing it, which is that everybody
calling pm_suspend_via_firmware() would then assume that the platform
would be powered down by the firmware.  I'm not sure how much of an
issue that would be in practice, though.


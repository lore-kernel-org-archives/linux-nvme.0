Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A11CCE7717F
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Dec 2024 17:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ISvw1N2ibH9sMgoeLcsmVDc77NiEi+toxzIYR5vdCos=; b=x3pm2I2s716Eg6GcbFNwW4ck6K
	+N7tCYNY9tweR8fD/S8BepiM9ZcH8mAT7Eb1ebko1gMzHvDhOIrDWA/esTGBSDY3pm27FCiKeSXBd
	cPnVIdIjwwBv9/4WfMmTj8T2ACrUOf/2tplYAdXI0kcIZzzrIiJe9dgctKIPbRV8ppis72NBAjx3v
	KtHB3UUzWmqPTKv8W6mUcYnCN+xOM7VMutuzixKQ/iCmgB3z7omI/P433JNGotRPIFvlYaaz34E7t
	b94888mDIdZtB4QSGHYQ3OeW/n2SKmxPmU3KMKntSJ3eIGCx/8nJyoC36TG/Ya6ES0HcyMetN8oWk
	jMn7Wvnw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tNF0r-0000000An39-1TZE;
	Mon, 16 Dec 2024 17:36:09 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tNF0o-0000000An27-37lh
	for linux-nvme@lists.infradead.org;
	Mon, 16 Dec 2024 17:36:07 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 1FCC6A41968
	for <linux-nvme@lists.infradead.org>; Mon, 16 Dec 2024 17:34:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9517CC4CEE2
	for <linux-nvme@lists.infradead.org>; Mon, 16 Dec 2024 17:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734370565;
	bh=mtdBMr7tNhTm5tnQKnSJQk8KV/APMU7FqSKGdW2EF1Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=J6DYUyFKwFmSuCeZ1G2ig/QZuqQ+PAsVvEhZV1Wqw9dbYvlrwOPoBkWMJmSV6Tlho
	 KL6iLGXsqaFMhlWwlhsWAfTS4CK7IO/d7rjlP9sy7GgsiUN1J5yI/IF0Tdt9ushVk+
	 GtewzCeIkSeroyFcxki/ia8oBoxFqJFVvW/33z0Xxk6shB5czkgtGu2CYoffjD6oIw
	 oepAktQRSBWLXws4R/Amjv1Lsw/WnJgPeD0Fyn2TFm88NBnfKLR9O8AFkiizzjrTWJ
	 dVJnev+an2Nr1TxmpJiwU+pfIkxpCrU3WALmCenn1NdZYiAflGtQOlmolO5XI5CC+1
	 veP3ALgWrnjmA==
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3eb7ca55c3bso2342324b6e.3
        for <linux-nvme@lists.infradead.org>; Mon, 16 Dec 2024 09:36:05 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUZHnwBtHRe1c6cinpVmuIhIENE54aHkfViUqRLqZj/mwoCK7F5vHx/OtY2g4toNNI8j3MnPQ1p7D0V@lists.infradead.org
X-Gm-Message-State: AOJu0YyZYHhZ2grTOgSiFJZDrdPwiEbo2GttVRlKV9j5Av3JPYbNZ9Vg
	Z0kVywisUNpyEALx/in39aum+NSOmWGrMRzLzD8YLg53ktXD5YrZVCYx84o5rzY0QL4hlMer7M6
	h/cieZLs7CXbUDHPudJ5TvqhHxmY=
X-Google-Smtp-Source: AGHT+IEbVrASnafFcVFMGA0wT8oALyCI8rLtv4AL+WE3KAycZh/58Ko9EcvLePanwDOjC2JGlwrk2XQ8h15EvvUChSg=
X-Received: by 2002:a05:6808:201e:b0:3ea:f809:5c25 with SMTP id
 5614622812f47-3ebc9ef2cacmr383027b6e.43.1734370564848; Mon, 16 Dec 2024
 09:36:04 -0800 (PST)
MIME-Version: 1.0
References: <20241205232900.GA3072557@bhelgaas> <20241209143821.m4dahsaqeydluyf3@thinkpad>
 <20241212055920.GB4825@lst.de> <13662231.uLZWGnKmhe@rjwysocki.net>
 <CAPDyKFrxEjHFB6B2r7JbryYY6=E4CxX_xTmLDqO6+26E+ULz6A@mail.gmail.com>
 <20241212151354.GA7708@lst.de> <CAJZ5v0gUpDw_NjTDtHGCUnKK0C+x0nrW6mP0tHQoXsgwR2RH8g@mail.gmail.com>
 <20241214063023.4tdvjbqd2lrylb7o@thinkpad> <CAJZ5v0gLMx+tBo+MA3AQZ7qP28Z91d04oVBHVeTNcd-QD=kJZg@mail.gmail.com>
 <20241216171108.6ssulem3276rkycb@thinkpad>
In-Reply-To: <20241216171108.6ssulem3276rkycb@thinkpad>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 16 Dec 2024 18:35:52 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0j+4xjSOOy8TYE0pBuqd_GdQa683Qq0GEyJ9WAFad9Z=A@mail.gmail.com>
Message-ID: <CAJZ5v0j+4xjSOOy8TYE0pBuqd_GdQa683Qq0GEyJ9WAFad9Z=A@mail.gmail.com>
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
X-CRM114-CacheID: sfid-20241216_093606_918898_9A4B2BF2 
X-CRM114-Status: GOOD (  69.13  )
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

On Mon, Dec 16, 2024 at 6:11=E2=80=AFPM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> On Mon, Dec 16, 2024 at 05:24:40PM +0100, Rafael J. Wysocki wrote:
> > On Sat, Dec 14, 2024 at 7:30=E2=80=AFAM Manivannan Sadhasivam
> > <manivannan.sadhasivam@linaro.org> wrote:
> > >
> > > On Fri, Dec 13, 2024 at 03:35:15PM +0100, Rafael J. Wysocki wrote:
> > > > On Thu, Dec 12, 2024 at 4:14=E2=80=AFPM Christoph Hellwig <hch@lst.=
de> wrote:
> > > > >
> > > > > On Thu, Dec 12, 2024 at 01:49:15PM +0100, Ulf Hansson wrote:
> > > > > > Right. This seems to somewhat work for ACPI types of systems, b=
ecause
> > > > > > ACPI is controlling the low power state for all the devices. Ba=
sed on
> > > > > > the requested system wide low power state, ACPI can then decide=
 to
> > > > > > call pm_set_suspend_via_firmware() or not.
> > > > > >
> > > > > > Still there is a problem with this for ACPI too.
> > > > > >
> > > > > > How does ACPI know whether it's actually a good idea to keep th=
e NVMe
> > > > > > storage powered in s2idle (ACPI calls pm_set_suspend_via_firmwa=
re()
> > > > > > only for S2R and S2disk!?)? Especially when my laptop only supp=
orts
> > > > > > s2idle and that's what I will use when I close the lid. In this=
 way,
> > > > > > the NMVe storage will certainly contribute to draining the batt=
ery,
> > > > > > especially when I won't be using my laptop for a couple of days=
.
> > > > > >
> > > > > > In my opinion, we need a better approach that is both flexible =
and
> > > > > > that dynamically adjusts based upon the use case.
> > > > >
> > > > > Agreed.  I'd be happy to work with the PM maintainers to do this,
> > > > > but I don't really know enough about the PM core to drive it
> > > > > (as the reply from Rafael to my mail makes pretty clear :))
> > > >
> > > > I'm here to help.
> > > >
> > > > Let me know what exactly you want to achieve and we'll see how to m=
ake it work.
> > >
> > > I'll try to summarize the requirement here since I started this threa=
d:
> > >
> > > Problem statement
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >
> > > We need a PM core API that tells the device drivers when it is safe t=
o powerdown
> > > the devices. The usecase here is with PCIe based NVMe devices but the=
 problem is
> > > applicable to other devices as well.
> > >
> > > Drivers are relying on couple of options now:
> > >
> > > 1. If pm_suspend_via_firmware() returns true, then drivers will shutd=
own the
> > > device assuming that the firmware is going to handle the suspend. But=
 this API
> > > is currently used only by ACPI. Even there, ACPI relies on S2R being =
supported
> > > by the platform and it sets pm_set_suspend_via_firmware() only when t=
he suspend
> > > is S2R. But if the platform doesn't support S2R (current case of most=
 of the
> > > Qcom SoCs), then pm_suspend_via_firmware() will return false and NVMe=
 won't be
> > > powered down draining the battery.
> >
> > So my question here would be why is it not powered down always during
> > system-wide suspend?
> >
> > Why exactly is it necessary to distinguish one case from the other
> > (assuming that we are talking about system-wide suspend only)?
> >
>
> To support Android like usecase with firmware that only supports
> suspend-to-idle (Qcom platforms). This usecase is not applicable right no=
w, but
> one can't just rule out the possibility in the near future.

This doesn't explain anything to me, sorry.

> And the problem is that we need to support both Android and non-Android s=
ystems
> with same firmware :/

So what technically is the problem?

> > There are drivers that use pm_suspend_via_firmware() to check whether
> > or not something special needs to be done to the device because if
> > "false" is returned, the platform firmware is not going to remove
> > power from it.
> >
> > However, you seem to be talking about the opposite, so doing something
> > special to the device if "true" is returned.  I'm not sure why this is
> > necessary.
> >
>
> Because, since 'false' is returned, drivers like NVMe are assuming that t=
he
> platform won't remove power on all DT systems and they just keep the devi=
ces in
> low power state (not powering them down). But why would I want my NVMe in=
 DT
> based laptop to be always powered in system suspend?

Because it causes the system to use less energy when suspended.

> > > If the platform is using DT, then there is no entity setting
> > > pm_set_suspend_via_firmware().
> >
> > That's true and so the assumption is that in this case the handling of
> > all devices will always be the same regardless of which flavor of
> > system suspend is chosen by user space.
> >
>
> Right and that's why the above concern is raised.

And it is still unclear to me what the problem with it is.

What exactly can go wrong?

> > > So NVMe will be kept in low power state all the
> > > time (still draining the battery).
> >
> > So what would be the problem with powering it down unconditionally?
> >
>
> I'm not sure how would you do that (by checking dev_of_node()?). Even so,=
 it
> will wear out the NVMe devices if used in Android tablets etc...

I understand the wear-out concern.

Is there anything else?

> > > There were attempts to set this flag from
> > > PSCI [1], but there were objections on setting this flag when PSCI_SU=
SPEND is
> > > not supported by the platform (again, the case with Qcom SoCs). Even =
if this
> > > approach succeeds, then there are concerns that if the platform is us=
ed in an
> > > OS like Android where the S2Idle cycle is far more high, NVMe will we=
ar out
> > > very quickly.
> >
> > I see.
> >
> > > So this is where the forthcoming API need to "dynamically adjusts
> > > based upon the use case" as quoted by Ulf in his previous reply. One =
way to
> > > achieve would be by giving the flexibility to the userspace to choose=
 the
> > > suspend state (if platform has options to select). UFS does something=
 similar
> > > with 'spm_lvl' [2] sysfs attribute that I believe Android userspace i=
tself makes
> > > use of.
> >
> > Before we're talking about APIs, let's talk about the desired behavior.
> >
> > It looks like there are cases in which you'd want to turn the device
> > off completely (say put it into D3cold in the PCI terminology) and
> > there are cases in which you'd want it to stay in a somewhat-powered
> > low-power state.
> >
> > It is unclear to me what they are at this point.
> >
>
> I hope that my above explanation clarifies.

Sorry, but not really.

> Here is the short version of the suspend requirement across platforms:
>
> 1. D3Cold (power down) - Laptops/Automotive
> 2. D3hot (low power) - Android Tablets

Where do the above requirements come from?

> FWIW, I did receive feedback from people asking to just ignore the Androi=
d
> usecase and always power down the devices for DT platforms. But I happen =
to
> disagree with them. Let me know if I was wrong and I should not worry abo=
ut
> Android usecase as it is for the future.

I'm not sure what you mean by the "Android usecase" TBH.  Do you mean
the wear-out concern in the Android usage scenario or is there more to
it?


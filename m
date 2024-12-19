Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBF87E77184
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Dec 2024 16:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aN9R4Ho7CMfSjQSJU3b8ryQQC0vctVzUU9BCCfcwEmE=; b=AYgwqHMsAR/ixRpeBL41M1P45k
	IZTkjcpfCa2LVxIsxWq28uTtqM58SRC5obJ6m0hYxr9FmVEr3A1Tj/KIGIgTxkQ0ygEJoxFynewD/
	ee00rACxQFdvyO0/7GPyS3kIIkGoln55tqngllkItkj768EKB7tgJdQ85pGeD2s6STUDAlk/0n7Gj
	EyZkvaXRxsxa4YDNCkA+kgZ6b/imzQoqTbNnz2VgSGDzjBHrAX5JiK7nGwEsnsV9OW0P7ZY8SjHC/
	bwuMlUeQM+HPQDNZHFyZWf/TNxGMeMC04RiEE04m38xGyukglRx7VyYmWe655MYWPqhs9+Th4vkGE
	0qvgjVow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tOJbh-00000002OjD-43yi;
	Thu, 19 Dec 2024 16:42:37 +0000
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tOJbf-00000002OiY-0wSr
	for linux-nvme@lists.infradead.org;
	Thu, 19 Dec 2024 16:42:36 +0000
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-6ef66a7ac14so21141417b3.0
        for <linux-nvme@lists.infradead.org>; Thu, 19 Dec 2024 08:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734626553; x=1735231353; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aN9R4Ho7CMfSjQSJU3b8ryQQC0vctVzUU9BCCfcwEmE=;
        b=DAkhcB2a/I03RYGkCraKCE0Ch04OnCW25l/yGw/iDnDc9gB+9TNsxP635XzlsAhHCY
         YnC1p82gONJLToByVx6az7bC5AD4v7L9q1nBBx1fakuIllmSmml6lA4Y9D76QH5G0oAN
         aoMFUy+/f0cfkQsuhC8lMJtogkA3wzomLEDUx8ev+ZR4tHfl6SzliisB7WOUVtcomf7U
         +GNxRtCuZHEnG2+zZ3QAecgC8ELQSFzzFzY+9tyFsuSmZqHgelyiukEAZx9uFx2s9/MZ
         VxtVj0sMWToyvD3WZ3SbAShV8gTP8sqfz5QVcJ9QeGGe6M5tCwj9woaKvzV8IZSetUDJ
         nqdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734626553; x=1735231353;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aN9R4Ho7CMfSjQSJU3b8ryQQC0vctVzUU9BCCfcwEmE=;
        b=c6yL39WRGHekl4Q578KNIznv1eIBKm2KWbG441zFgVRDvrn8oLIEK6tvTfWUQFNbyu
         dHZVDciMHslXUue2T//9wOorO4ESuuW5V9Dz0Rrj24WgtHQtuwFs92oZlyMRXDwOguzH
         jhEYR7e+tKv20FhrU87/cujVO/LwhSOCDoqWHR2ywFRcfVPoNjhYk7jpMLZCsB9NEksi
         qYSCNbSfRW9DBWL/19KiBwEUV26xZIRW4Q9omlPaan0IAk3OUjzwCQS78yFwzonRUdlQ
         FwNoAgksLpEHcybZs3rLF+53CQx+TfgFWHCMFFdLv4V4TGsO0N92H+OMMk5pwJobR/Pa
         4xcw==
X-Forwarded-Encrypted: i=1; AJvYcCWj6x+SvXGuIsC24m6zGrmckmAk7MGTFJ9IcKLjvxTDgr7zh8dDNZ0RrGhyn2mYIZ4f8GjImQ9I2Zjk@lists.infradead.org
X-Gm-Message-State: AOJu0YxTh7gPDXiJD3SM4I+IsdouTnMvWE05G4wViP7DTgt/HCxlihzU
	8DbdBkPSPT8MFTqQDT9l4qCmqgBFmu4NtbtXeGInQuW6wKhdAopg6bTg1iaCnIq/5MJxj6/ii89
	V1LzY9wwX2gR0kxe4aIreT5quVYGOhZ5a3gVPvw==
X-Gm-Gg: ASbGncsIQey+X6DN+C5Sg74cde1QMsOvXpynEVv9SXx3zPWuvvGMsLCRx83icw5ci+e
	uVg0bKm0qVzGjR/hhPzECEL9nYKICE2OZHU7BCPA=
X-Google-Smtp-Source: AGHT+IF5KATZAWGgPbMMAlYzdkenHUmfZ1YjUynCYtdBojAeGI8W4V/K3rTvXEVrPfIYBteiodOM2DMDyTh9CidFkHs=
X-Received: by 2002:a05:690c:9a8b:b0:6ef:e572:cd6f with SMTP id
 00721157ae682-6f3e2a87259mr35303837b3.7.1734626552569; Thu, 19 Dec 2024
 08:42:32 -0800 (PST)
MIME-Version: 1.0
References: <20241212151354.GA7708@lst.de> <CAJZ5v0gUpDw_NjTDtHGCUnKK0C+x0nrW6mP0tHQoXsgwR2RH8g@mail.gmail.com>
 <20241214063023.4tdvjbqd2lrylb7o@thinkpad> <CAJZ5v0gLMx+tBo+MA3AQZ7qP28Z91d04oVBHVeTNcd-QD=kJZg@mail.gmail.com>
 <20241216171108.6ssulem3276rkycb@thinkpad> <CAJZ5v0j+4xjSOOy8TYE0pBuqd_GdQa683Qq0GEyJ9WAFad9Z=A@mail.gmail.com>
 <20241216175210.mnc5kp6646sq7vzm@thinkpad> <CAJZ5v0grRdTYaamSnKSF-HyMmCHDEZ4haLo+ziSBxhDg1PbjRQ@mail.gmail.com>
 <20241217052632.lbncjto5xibdkc4c@thinkpad> <CAJZ5v0gjrBUgejwBz1vv6P83oZiYu8AuDMs47ZAFJoNhMaMdpQ@mail.gmail.com>
 <20241219080217.fr2ukr7sk4a7hfmo@thinkpad> <CAJZ5v0hByaAAaYGhAvstwtfa-JP6JRQCbWCZrTsRGWEHHyRKdA@mail.gmail.com>
In-Reply-To: <CAJZ5v0hByaAAaYGhAvstwtfa-JP6JRQCbWCZrTsRGWEHHyRKdA@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 19 Dec 2024 17:41:56 +0100
Message-ID: <CAPDyKFqc+YuAyV-120Vvg7HOkhgnJ=wM53LAHTkJ6Gg5=rJumA@mail.gmail.com>
Subject: Re: [PATCH] nvme-pci: Shutdown the device if D3Cold is allowed by the user
To: Christoph Hellwig <hch@lst.de>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Bjorn Helgaas <helgaas@kernel.org>, kbusch@kernel.org, 
	axboe@kernel.dk, sagi@grimberg.me, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, andersson@kernel.org, 
	konradybcio@kernel.org, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241219_084235_278947_0A8CCC92 
X-CRM114-Status: GOOD (  92.82  )
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

On Thu, 19 Dec 2024 at 13:45, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, Dec 19, 2024 at 9:02=E2=80=AFAM Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> >
> > On Tue, Dec 17, 2024 at 08:45:55PM +0100, Rafael J. Wysocki wrote:
> > > On Tue, Dec 17, 2024 at 6:26=E2=80=AFAM <manivannan.sadhasivam@linaro=
.org> wrote:
> > > >
> > > > On Mon, Dec 16, 2024 at 08:34:24PM +0100, Rafael J. Wysocki wrote:
> > > >
> > > > [...]
> > > >
> > > > > > There is also a case where some devices like
> > > > > > (Laptops made out of Qcom SCX Gen3 SoCs) require all the PCIe d=
evices to be
> > > > > > powered down in order for the SoC to reach its low power state =
(CX power
> > > > > > collapse in Qcom terms). If not, the SoC would continue to draw=
 more power
> > > > > > leading to battery draining quickly. This platform is supported=
 in upstream and
> > > > > > we keep the PCIe interconnect voted during suspend as the NVMe =
driver is
> > > > > > expecting the device to retain its state during resume. Because=
 of this
> > > > > > requirement, this platform is not reaching SoC level low power =
state with
> > > > > > upstream kernel.
> > > > >
> > > > > OK, now all of this makes sense and that's why you really want NV=
Me
> > > > > devices to end up in some form of PCI D3 in suspend-to-idle.
> > > > >
> > > > > Would D3hot be sufficient for this platform or does it need to be
> > > > > D3cold?  If the latter, what exactly is the method by which they =
are
> > > > > put into D3cold?
> > > > >
> > > >
> > > > D3Cold is what preferred. Earlier the controller driver used to tra=
nsition the
> > > > device into D3Cold by sending PME_Turn_Off, turning off refclk, reg=
ulators
> > > > etc... Now we have a new framework called 'pwrctrl' that handles th=
e
> > > > clock/regulators supplied to the device. So both controller and pwr=
ctrl drivers
> > > > need to work in a tandem to put the device into D3Cold.
> > > >
> > > > Once the PCIe client driver (NVMe in this case) powers down the dev=
ice, then
> > > > controller/pwrctrl drivers will check the PCIe device state and tra=
nsition the
> > > > device into D3Cold. This is a TODO btw.
> > > >
> > > > But right now there is no generic D3Cold handling available for DT =
platforms. I
> > > > am hoping to fix that too once this NVMe issue is handled.
> > >
> > > There's no generic D3cold handling for PCIe devices at all AFAICS.  A=
t
> > > least, I'm not aware of any standard way to do it.  Yes, there are
> > > vendor-specific conventions that may even be followed by multiple
> > > vendors, but not much beyond that.
> > >
> >
> > Yeah, right. Atleast ACPI has its own way of handling D3Cold and that's=
 what I
> > meant.
>
> Well, not so simple.
>
> ACPI has a way to put devices into D3cold, but it is based on power
> resources: If all of the ACPI power resources for state D3hot of the
> given device are turned off, the device is assumed to have no power
> which effectively means D3cold.
>
> Now, this basically works for platform devices, but it doesn't work
> particularly well for PCIe devices that get their power from the bus.
>
> This is addressed by using a conventional approach that has not been
> codified as a standard so far AFAICS.  The convention is to define a
> D3hot power resource for the parent PCIe port of the device in
> question and turn that power resource off when both the device and its
> parent port have been programmed to go into D3hot (via PMCSR).  So the
> flow is that the device goes into D3hot first.  Later, its parent port
> goes into D3hot and then the D3hot power resource of the port is
> turned off.  It usually doesn't really remove power from the port
> (especially if this is a root port), but it turns down the PCIe link
> from it to the device (in a platform-specific way) which effectively
> cuts power from the device.
>
> On the way back, the D3hot power resource of the port is turned on
> first and this turns the PCIe link between the port and the device up.
>
> > There is no such option available for DT right now. I was shoping that
> > once this NVMe issue is resolved, then I could look into D3Cold for DT
> > platforms.
>
> Well, consider the above.
>
> [cut]
>
> > > > >
> > > > > I think we're getting to the bottom of the issue.
> > > > >
> > > > > First off, there really is no requirement to avoid putting PCI de=
vices
> > > > > into D3hot or D3cold during suspend-to-idle.  On all modern Intel
> > > > > platforms, PCIe devices are put into D3(hot or cold) during
> > > > > suspend-to-idle and I don't see why this should be any different =
on
> > > > > platforms from any other vendors.
> > > > >
> > > > > The NVMe driver is an exception and it avoids D3(hot or cold) dur=
ing
> > > > > suspend-to-idle because of problems with some hardware or platfor=
ms.
> > > > > It might in principle allow devices to go into D3(hot or cold) du=
ring
> > > > > suspend-to-idle, so long as it knows that this is going to work.
> > > > >
> > > >
> > > > Slight correction here.
> > > >
> > > > NVMe driver avoids PCI PM _only_ when it wants to handle the NVMe p=
ower
> > > > state on its own, not all the time. It has some checks [1] in the s=
uspend path
> > > > and if the platform/device passes one of the checks, it will power =
down the
> > > > device.
> > >
> > > Yes, there is a comment in that code explaining what's going on and
> > > that is basically "if key ingredients are missing or the firmware is
> > > going to do its thing anyway, don't bother".
> > >
> > > > DT platforms doesn't pass any of the checks, so the NVMe driver alw=
ays manages
> > > > the power state on its own. Unfortunately, the resultant power savi=
ng is not
> > > > enough, so the vendors (Laptop/Automotive) using DT want NVMe to be=
 powered down
> > > > all the time. This is the first problem we are trying to solve.
> > > >
> > > > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.=
git/tree/drivers/nvme/host/pci.c#n3448
> > >
> > > I see.
> > >
> > > This cannot be done by the driver itself, though, at least not in
> > > general.  The PCI layer needs to be involved and, if we are talking
> > > about D3cold, the platform firmware needs to be involved either.
> > >
> >
> > Right, but the device driver needs to have some idea about what state P=
CI core
> > is going to choose for the device. I believe that's the purpose of
> > pci_choose_state() API. More below...
>
> This is not really straightforward as per the above.
>
> The driver would effectively need to know if the device's parent port
> would be put into D3cold and pci_choose_state() is only about the
> device itself.
>
> > > As a rule, the PCI layer reaches out to the platform firmware for hel=
p
> > > as needed and drivers don't take part in this directly.
> > >
> > > The NVMe driver would need to let the PCI layer take over and set the
> > > PCI power state of the device if it wanted to get any deeper than NVM=
e
> > > protocol specific power states.
> > >
> > > In principle, this can be addressed with some kind of a driver opt-in=
.
> > > That is, the NVMe driver would continue to work the way it does, but
> > > instead of completely preventing the PCI layer from taking over, it
> > > would opt in (the exact opt-in mechanism is TBD) for D3cold if (a) th=
e
> > > platform firmware provides a mechanism to do so and (b) the DT
> > > indicates that this mechanism should be used for the given device.
> > >
> >
> > Ok, IIUC you are talking about something like this?
> >
> >         static int nvme_suspend(struct device *dev)
> >         {
> >                 ...
> >
> >                 if (pm_suspend_via_firmware() || !ctrl->npss || ... ||
> >                     pci_choose_state(pdev, PMSG_SUSPEND) =3D=3D PCI_D3c=
old)
> >                         return nvme_disable_prepare_reset(ndev, true);
> >
> >                 /* continue using protocol specific low power state */
> >
> >                 ...
> >         }
> >
> > Here, pci_choose_state() should tell the driver if the device should en=
ter
> > D3Cold. ACPI already supports this API, now I need to add DT support (w=
hich is
> > not straightforward, but doable). Since this API is already exported, I=
 think it
> > makes perfect sense to use it here (and other drivers for similar useca=
se).
>
> I didn't really think about using pci_choose_state() here, but it is
> not unreasonable IMV.  It may in principle be extended to cover the
> "port + device combo" approach described above.  I'd rather avoid
> calling pci_choose_state() twice for the same device during one
> transition (once in the driver and then in the PCI layer), but that
> could be addressed by rearranging the code.
>
> However, I thought about adding a way for the driver to effectively
> say "I'm fine with putting this device into power state X so long as
> you have an indication from the platform firmware that this is OK",
> where X would be the deepest power state allowed by the driver.
>
> The drawback of this is that the driver would not know whether or not
> the device would go into state X upfront, so it would need to do its
> own thing in case this doesn't happen.  In the NVMe driver case, this
> would mean putting the device into a protocol low-power state before
> returning from the suspend callback which may not be a bad idea
> overall.
>
> BTW, I'm wondering what could go wrong if the
> pm_suspend_via_firmware() check were dropped from nvme_suspend()?  The
> driver would do some extra work on systems with ACPI S3 support, but
> would it actually break anything?  Does anybody know?  May be worth
> trying ...
>
> > > > > However, there is an additional concern that putting an NVMe devi=
ce
> > > > > into D3cold every time during system suspend on Android might cau=
se it
> > > > > to wear out more quickly.
> > > > >
> > > >
> > > > Right, this is the second problem.
> > >
> > > Let's set this one somewhat aside for now.  We'll get back to it when
> > > we have clarity in the above.
> > >
> >
> > Ok. I believe this could be addressed in pci_choose_state() itself if r=
equired.
>
> Possibly.
>
> Unrelated notice: I will be mostly offline starting tomorrow through
> Jan 6, 2025 and responses may be slow during that time.

I didn't really find a good thread to reply to, but just decided to
pick the current latest email to share some of my additional thoughts.
Sorry, if it becomes confusing.

I think a lot of the requirements that have been discussed need to be
considered together (and there are possibly even more requirements
that have not been highlighted yet), to be able to find a proper good
solution. For example, if we just decide to always enter the deepest
low-power state that is available, that may hurt the internal storage
device, for *some* use cases.

That said, we really need to find a good step-by-step approach, to
avoid damaging storage devices along the road.

For example, we have reported issues on (e)MMC/SD where we could end
up too frequently powering-on/off the card during system
suspend/resume, to potentially damage it. For eMMC (or in-fact
non-removable cards), we have tried to mitigate the problem by
deferring the power-on of the card during system resume, until there
is actual I/O being requested for the card.

Kind regards
Uffe


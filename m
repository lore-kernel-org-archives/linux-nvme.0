Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DAB7E77184
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Dec 2024 08:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FiIXhUgGXRHUKYompmzT3WtYs6AwRDjwCP4avnbaXXs=; b=gRXsL7cTTFqoCYwPh+T2cOY/cM
	Zrz/MHVmFaesTfrGsF3g73v8xKHuHYi8wuRwH13ht1K9DYhEK+IFSWHXQHcRlocpu3INOgjz0cBvQ
	QftlJeq4W959Y6Oihwxjl6l0eHAG3Mz2aTNaNtkgRmXJFfhc7gRBqJDIYjZOfOXLuv/dKDpZ+QA4P
	VCtD4D5BIwH56RZkrTETTMavb+xqeuaC6U8MHX42MVTRC5CGVi73AYoZ0Ekzikrji0M+OyglMSjWE
	RFtDeMNRYKf5FpcWx7h68y7JnhzMCdH0mTa4ynyhJuI1sj0TYc6hDsJQWM4yQ1ZHe4joIubkpIUot
	QNnbacLA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tOBUL-00000001CGx-1DfZ;
	Thu, 19 Dec 2024 08:02:29 +0000
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tOBUH-00000001CGG-3gQC
	for linux-nvme@lists.infradead.org;
	Thu, 19 Dec 2024 08:02:27 +0000
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-725dac69699so438620b3a.0
        for <linux-nvme@lists.infradead.org>; Thu, 19 Dec 2024 00:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734595345; x=1735200145; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FiIXhUgGXRHUKYompmzT3WtYs6AwRDjwCP4avnbaXXs=;
        b=sJ7RdEt2aOgrXJcH6X9RGiqcvHBphlrBMs/MCt2v5cswkhM2jok0owlPxkZyd/BrGX
         F7vdaGLz9EAzyLVOT2dpXqKhU5Auefk7RiA7I8ZlVutEEBdC58nBAHYn43w8fAOHoD5X
         YHkt1KEgnSpqh/S8YVNxt0Std1r++G4j86vUfYdaeL3/bFpqgnTC7gmjN31qp0ycghKe
         IeqKTOeHWT5h1M0/bq3yCF+fNVZUQ2RYSaGR5QtKWo+v97GtUbv7ikqaCcBEUeyWXLvM
         m/cewMCHGPQDdM4EpBf6Q4SjYMgSErhOp7U6968RGXsXJDnGj2AcJm6qEt+F8tjkBxvA
         uJVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734595345; x=1735200145;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FiIXhUgGXRHUKYompmzT3WtYs6AwRDjwCP4avnbaXXs=;
        b=R7D6CvQKqSh0uhHbf+O7IDlwhTv05psD6xO4U6vkVsmNsUxJRpgkZmLx00WVAgk2+0
         A8EpE8inwHIpDo5O0RdmtoJwEEu5yQZwO/3mmOcxnh6QDxG9WMAhtI00FhP38hrh/TYx
         GMWGn9l53rJHrByqm+FlrzuwBONCf7Rf/KzKykgdjKfhFrPNVUwnFXoGxZyQ0bPKPd6F
         orOV+Clg48U0zgfAWQq8mwJXbe4cdl/zCJ1299xiY9wscU2dVbCe1BmO8uip35VquAzl
         4Mn87NlqevZKd3zMdZRjOMn1sCBZ9LCvoazDXPf3hv1zS3YL/8t6SJvgMJ8Ggoeh+YVj
         SFMg==
X-Forwarded-Encrypted: i=1; AJvYcCVip1lNajkJHAtjIHz8oAhskhOMyIYOqBvnfj9WBWZzaXzb0Mi5yw/G2/RVnx9wkL2NStbdk5fyTTDr@lists.infradead.org
X-Gm-Message-State: AOJu0YxutgZI5/ccNxb9yvwsvgegHsomXAFeJFz1PeG4nsDOLQX8Zb6z
	SqOBxSwU51uIwTaJ/FmVFLqDBj/b7O5KP3a1NFmtgN9I9CVPHbO4V9JKzcvMAA==
X-Gm-Gg: ASbGnctfeG1qCATqjdKztlEnGhQ1/VybIjxzm9wuCYpe2lFokt51HZeO/iDfL2F+r9/
	Lwc9QtP+C98jJ1lU8YWhcBkO12feyick3pX66VMiWkHbYQEA2Aw3xC+JdfxE6RIraU+kv8Mw5Zd
	Nmfy1Dc7UCjh3LT4ODMHHMFr1gFtdLWRvf8JHGhtgOKwhaDeVuUQNppGEk3uS2BqC+TGEqSFhsf
	Qh90D5aqmdJWDEEgbQRlzeTKTgRpNJ7GZazWTPBivcLJye6C9Ey+9YM39az3/q8Xxwd
X-Google-Smtp-Source: AGHT+IFll0irdbwM+RUdhMNn+L6WxoWJUa0AF8tiMBuXb8vjLzgtKTa5XtyI18qRm8PKkIbtuUs9zg==
X-Received: by 2002:a05:6a20:6a25:b0:1e1:afa9:d38a with SMTP id adf61e73a8af0-1e5c74f2fafmr4032467637.1.1734595345080;
        Thu, 19 Dec 2024 00:02:25 -0800 (PST)
Received: from thinkpad ([117.213.97.217])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-842b1ce01d3sm627161a12.23.2024.12.19.00.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 00:02:24 -0800 (PST)
Date: Thu, 19 Dec 2024 13:32:17 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Ulf Hansson <ulf.hansson@linaro.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Bjorn Helgaas <helgaas@kernel.org>, kbusch@kernel.org,
	axboe@kernel.dk, sagi@grimberg.me, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	andersson@kernel.org, konradybcio@kernel.org,
	Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: Shutdown the device if D3Cold is allowed by
 the user
Message-ID: <20241219080217.fr2ukr7sk4a7hfmo@thinkpad>
References: <20241212151354.GA7708@lst.de>
 <CAJZ5v0gUpDw_NjTDtHGCUnKK0C+x0nrW6mP0tHQoXsgwR2RH8g@mail.gmail.com>
 <20241214063023.4tdvjbqd2lrylb7o@thinkpad>
 <CAJZ5v0gLMx+tBo+MA3AQZ7qP28Z91d04oVBHVeTNcd-QD=kJZg@mail.gmail.com>
 <20241216171108.6ssulem3276rkycb@thinkpad>
 <CAJZ5v0j+4xjSOOy8TYE0pBuqd_GdQa683Qq0GEyJ9WAFad9Z=A@mail.gmail.com>
 <20241216175210.mnc5kp6646sq7vzm@thinkpad>
 <CAJZ5v0grRdTYaamSnKSF-HyMmCHDEZ4haLo+ziSBxhDg1PbjRQ@mail.gmail.com>
 <20241217052632.lbncjto5xibdkc4c@thinkpad>
 <CAJZ5v0gjrBUgejwBz1vv6P83oZiYu8AuDMs47ZAFJoNhMaMdpQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0gjrBUgejwBz1vv6P83oZiYu8AuDMs47ZAFJoNhMaMdpQ@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241219_000225_934778_29254D9A 
X-CRM114-Status: GOOD (  84.33  )
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

On Tue, Dec 17, 2024 at 08:45:55PM +0100, Rafael J. Wysocki wrote:
> On Tue, Dec 17, 2024 at 6:26 AM <manivannan.sadhasivam@linaro.org> wrote:
> >
> > On Mon, Dec 16, 2024 at 08:34:24PM +0100, Rafael J. Wysocki wrote:
> >
> > [...]
> >
> > > > There is also a case where some devices like
> > > > (Laptops made out of Qcom SCX Gen3 SoCs) require all the PCIe devices to be
> > > > powered down in order for the SoC to reach its low power state (CX power
> > > > collapse in Qcom terms). If not, the SoC would continue to draw more power
> > > > leading to battery draining quickly. This platform is supported in upstream and
> > > > we keep the PCIe interconnect voted during suspend as the NVMe driver is
> > > > expecting the device to retain its state during resume. Because of this
> > > > requirement, this platform is not reaching SoC level low power state with
> > > > upstream kernel.
> > >
> > > OK, now all of this makes sense and that's why you really want NVMe
> > > devices to end up in some form of PCI D3 in suspend-to-idle.
> > >
> > > Would D3hot be sufficient for this platform or does it need to be
> > > D3cold?  If the latter, what exactly is the method by which they are
> > > put into D3cold?
> > >
> >
> > D3Cold is what preferred. Earlier the controller driver used to transition the
> > device into D3Cold by sending PME_Turn_Off, turning off refclk, regulators
> > etc... Now we have a new framework called 'pwrctrl' that handles the
> > clock/regulators supplied to the device. So both controller and pwrctrl drivers
> > need to work in a tandem to put the device into D3Cold.
> >
> > Once the PCIe client driver (NVMe in this case) powers down the device, then
> > controller/pwrctrl drivers will check the PCIe device state and transition the
> > device into D3Cold. This is a TODO btw.
> >
> > But right now there is no generic D3Cold handling available for DT platforms. I
> > am hoping to fix that too once this NVMe issue is handled.
> 
> There's no generic D3cold handling for PCIe devices at all AFAICS.  At
> least, I'm not aware of any standard way to do it.  Yes, there are
> vendor-specific conventions that may even be followed by multiple
> vendors, but not much beyond that.
> 

Yeah, right. Atleast ACPI has its own way of handling D3Cold and that's what I
meant. There is no such option available for DT right now. I was shoping that
once this NVMe issue is resolved, then I could look into D3Cold for DT
platforms.

> > > > > > > > If the platform is using DT, then there is no entity setting
> > > > > > > > pm_set_suspend_via_firmware().
> > > > > > >
> > > > > > > That's true and so the assumption is that in this case the handling of
> > > > > > > all devices will always be the same regardless of which flavor of
> > > > > > > system suspend is chosen by user space.
> > > > > > >
> > > > > >
> > > > > > Right and that's why the above concern is raised.
> > > > >
> > > > > And it is still unclear to me what the problem with it is.
> > > > >
> > > > > What exactly can go wrong?
> > > > >
> > > > > > > > So NVMe will be kept in low power state all the
> > > > > > > > time (still draining the battery).
> > > > > > >
> > > > > > > So what would be the problem with powering it down unconditionally?
> > > > > > >
> > > > > >
> > > > > > I'm not sure how would you do that (by checking dev_of_node()?). Even so, it
> > > > > > will wear out the NVMe devices if used in Android tablets etc...
> > > > >
> > > > > I understand the wear-out concern.
> > > > >
> > > > > Is there anything else?
> > > > >
> > > >
> > > > No, that's the only concern.
> > >
> > > OK
> > >
> > > I think we're getting to the bottom of the issue.
> > >
> > > First off, there really is no requirement to avoid putting PCI devices
> > > into D3hot or D3cold during suspend-to-idle.  On all modern Intel
> > > platforms, PCIe devices are put into D3(hot or cold) during
> > > suspend-to-idle and I don't see why this should be any different on
> > > platforms from any other vendors.
> > >
> > > The NVMe driver is an exception and it avoids D3(hot or cold) during
> > > suspend-to-idle because of problems with some hardware or platforms.
> > > It might in principle allow devices to go into D3(hot or cold) during
> > > suspend-to-idle, so long as it knows that this is going to work.
> > >
> >
> > Slight correction here.
> >
> > NVMe driver avoids PCI PM _only_ when it wants to handle the NVMe power
> > state on its own, not all the time. It has some checks [1] in the suspend path
> > and if the platform/device passes one of the checks, it will power down the
> > device.
> 
> Yes, there is a comment in that code explaining what's going on and
> that is basically "if key ingredients are missing or the firmware is
> going to do its thing anyway, don't bother".
> 
> > DT platforms doesn't pass any of the checks, so the NVMe driver always manages
> > the power state on its own. Unfortunately, the resultant power saving is not
> > enough, so the vendors (Laptop/Automotive) using DT want NVMe to be powered down
> > all the time. This is the first problem we are trying to solve.
> >
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/nvme/host/pci.c#n3448
> 
> I see.
> 
> This cannot be done by the driver itself, though, at least not in
> general.  The PCI layer needs to be involved and, if we are talking
> about D3cold, the platform firmware needs to be involved either.
> 

Right, but the device driver needs to have some idea about what state PCI core
is going to choose for the device. I believe that's the purpose of
pci_choose_state() API. More below...

> As a rule, the PCI layer reaches out to the platform firmware for help
> as needed and drivers don't take part in this directly.
> 
> The NVMe driver would need to let the PCI layer take over and set the
> PCI power state of the device if it wanted to get any deeper than NVMe
> protocol specific power states.
> 
> In principle, this can be addressed with some kind of a driver opt-in.
> That is, the NVMe driver would continue to work the way it does, but
> instead of completely preventing the PCI layer from taking over, it
> would opt in (the exact opt-in mechanism is TBD) for D3cold if (a) the
> platform firmware provides a mechanism to do so and (b) the DT
> indicates that this mechanism should be used for the given device.
> 

Ok, IIUC you are talking about something like this?

	static int nvme_suspend(struct device *dev)
	{
		...

		if (pm_suspend_via_firmware() || !ctrl->npss || ... ||
		    pci_choose_state(pdev, PMSG_SUSPEND) == PCI_D3cold)
			return nvme_disable_prepare_reset(ndev, true);

		/* continue using protocol specific low power state */

		...
	}

Here, pci_choose_state() should tell the driver if the device should enter
D3Cold. ACPI already supports this API, now I need to add DT support (which is
not straightforward, but doable). Since this API is already exported, I think it
makes perfect sense to use it here (and other drivers for similar usecase).

> > > However, there is an additional concern that putting an NVMe device
> > > into D3cold every time during system suspend on Android might cause it
> > > to wear out more quickly.
> > >
> >
> > Right, this is the second problem.
> 
> Let's set this one somewhat aside for now.  We'll get back to it when
> we have clarity in the above.
> 

Ok. I believe this could be addressed in pci_choose_state() itself if required.

> > > Is there anything else?
> >
> > We also need to consider the fact that the firmware in some platforms doesn't
> > support S2R. So we cannot take a decision based on S2I/S2R alone.
> 
> Right, the S2I/S2R thing is ACPI-specific.
> 
> On platforms using ACPI, pm_suspend_via_firmware() means that the
> firmware is at least likely to power down the whole platform, so the
> PCI layer may as well be allowed to do what it wants with the device.
> 
> > I think there are atleast a couple of ways to solve above mentioned problems:
> >
> > 1. Go extra mile, take account of all issues/limitations mentioned above and
> > come up with an API. This API will provide a sane default suspend behavior to
> > drivers (fixing first problem) and will also allow changing the behavior
> > dynamically (to fix the second problem where kernel cannot distinguish Android
> > vs other OS).
> 
> I don't quite follow TBH.
> 
> A "default suspend behavior" is there already and it is to allow the
> PCI layer to set the device's power state (in collaboration with the
> platform firmware).  Thing is, the NVMe driver doesn't always want to
> rely on it.
> 
> > 2. Allow DT platforms to call pm_set_suspend_via_firmware() and make use of the
> > existing behavior in the NVMe driver. This would only solve the first problem
> > though. But would be a good start.
> 
> That would mean just letting the PCI layer always take over on the
> platforms that would call pm_set_suspend_via_firmware().
> 
> There is a potential issue with doing it, which is that everybody
> calling pm_suspend_via_firmware() would then assume that the platform
> would be powered down by the firmware.  I'm not sure how much of an
> issue that would be in practice, though.

Yeah, that would be a concern.

- Mani

-- 
மணிவண்ணன் சதாசிவம்


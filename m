Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D4F4D609A0
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Nov 2024 05:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7OijkGc9t43pKOFifLDtLZS3bjZeB1kYn3D1cmE3MDM=; b=pWGgCRiqX7OAoL+rs+VPewau3e
	nDZMoqjh9xlY3Y178lgM5sYkutaWpW/dKkh21woY4F6Ao0qDLt5CxYSSdtwa/f4ufjzuSXT+tiXqy
	+jU/f5jYpLAWY/FwihwrL6l71xa7BCN9H5aFNOR+8AoAuqg96e07QEcVA9r9ndLiAOA3V4LGaOa/i
	8debeu4pScCqDezsHdz+G1RsmH8qZRl8XsJKGlzJ4B2DNIlSWfOPoy0NFg+GTSqLNBZ0SycgwAypd
	goQrNtGM+is/IjsX+TqWkiCsJeeDN9k1gyhNdW7rzn79gkmH9AUmfCilRsj6o+l5Idk4uoJUfmaJz
	WPgppWPA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tGAvn-0000000CHb3-2rht;
	Wed, 27 Nov 2024 05:49:43 +0000
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tGAvk-0000000CHac-3pez
	for linux-nvme@lists.infradead.org;
	Wed, 27 Nov 2024 05:49:42 +0000
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-724e7d5d5b2so4787440b3a.2
        for <linux-nvme@lists.infradead.org>; Tue, 26 Nov 2024 21:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732686579; x=1733291379; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7OijkGc9t43pKOFifLDtLZS3bjZeB1kYn3D1cmE3MDM=;
        b=pAZkuZoYSe/ApxPevy8wDAiNbm1jnYNu8obmXg7bKBvzSwaz4lS6iqc2wG6KY6tKHG
         Xmkd4RGZZ/4yGxXFeDxKXAL/1EsvplYaBNmC7VuUrvpFMLT7T1rpmShxQ3w1RRyqNxoZ
         C1OnQOMYYOttjCjCld/ywJQPp2kVgWiL3GfrrAUFeCmPGtk4Z/1zF6V42MixBVUg6+6f
         MVUxC05DczQ4ykvT5G801ax0VfvyJHe/LRN2Jxuqm+zvCl5btGhXwT5SiM6sjQ7LBcG6
         /9RYWM2R5rb0jb77DzxRCZPiF2cwn+xTMsLY9uIkLZf1YGzPAbVRCbwy29ad5rXDgfwY
         8+sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732686579; x=1733291379;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7OijkGc9t43pKOFifLDtLZS3bjZeB1kYn3D1cmE3MDM=;
        b=WBeuQwJYoSST2HHZehZUk8m5gUtrPaicAJdTIHD5DiEYZqHUZXUFLLABf1Asm5GobG
         gWUOygxBtfJWLwt/l9gBYZ12fMHy/4cLCfV1SzhFZvZ3bUm0QtIBUuzAuwR7FwNn1d12
         9++frH2K93IAHQZ/n0uZg8KZ1NMHgaZtHt45hXFRTIMrRJyVD04VbSyjZzbS9z8C127Q
         7RFPFtQG0xZNFO1rtsnknyw7gsTFYcjq9egXDCBJgHxznAxIHSb3ECHuqGrZPR33MRml
         q2Ef9BIvZRmUusANCOpLFptSGdP79bljsdB3G2oeo5lFVTETB/p5etRzekcuxX0NiY74
         cwHg==
X-Forwarded-Encrypted: i=1; AJvYcCW439PQYEuXi/pqf3qrouQoswnR6OZNlqHRSbOoSgBFOVbj9WzUp24mGM9prt2zF0OueNN7sO5tfY0y@lists.infradead.org
X-Gm-Message-State: AOJu0Yyr6kmkUg0EiZDwff7EwgFvEipHccHamDwLe9c5HdSgmKy79dV3
	+ZdZwC5A2IHWyPBq9CJ7F29yQW61qnUbP9CUckDujwprkdgPpx5Td9bc8jXghw==
X-Gm-Gg: ASbGnctOq7fSUNZHh5HW7q9OV6YixnI1vjnqC6I4QPsJJx/GrYfNP5+axUqevPLQYcb
	Py4STYsglSEMLdWODwbvaSigxZCEk3wv2wV6w0Gna73IXqP4rfI/GZY1efOfWtCV+W5UxofpGHY
	tL7rvR7zDIUZ9PhpqkSMeM6krSURdW5VC1OI3tpHs85M6i4RgQ69sAXRSCPdM4KFlrndxyHD06B
	YaDrLyq1tCkvseIShfo5paVBVE90bhmMZO6r83GpXAKZ881O/FSib3lplKY
X-Google-Smtp-Source: AGHT+IFczRjEFE93AgEq4hJlwmfhnwAw0fnbiv9RRLxapdAANTc4eJxpreRJb4Ay/eM8ARb6SczqRQ==
X-Received: by 2002:a05:6a00:b47:b0:725:99f:9732 with SMTP id d2e1a72fcca58-72530041cd1mr2628285b3a.13.1732686579329;
        Tue, 26 Nov 2024 21:49:39 -0800 (PST)
Received: from thinkpad ([120.60.136.64])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724de532da6sm9688543b3a.105.2024.11.26.21.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 21:49:38 -0800 (PST)
Date: Wed, 27 Nov 2024 11:19:31 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, kbusch@kernel.org, axboe@kernel.dk,
	hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	konradybcio@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] nvme-pci: Shutdown the device if D3Cold is allowed by
 the user
Message-ID: <20241127054931.6crzyoq57g56rs3f@thinkpad>
References: <20241118082344.8146-1-manivannan.sadhasivam@linaro.org>
 <20241122222050.GA2444028@bhelgaas>
 <20241123090113.semecglxaqjvlmzp@thinkpad>
 <2f4rkilknak7xj3lyv7jx2yi7qyuw72pjwy67tkouqcvjmyn7l@scmdo34xnkuj>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2f4rkilknak7xj3lyv7jx2yi7qyuw72pjwy67tkouqcvjmyn7l@scmdo34xnkuj>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241126_214941_012052_BDE6779E 
X-CRM114-Status: GOOD (  71.51  )
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

On Tue, Nov 26, 2024 at 11:11:38AM -0600, Bjorn Andersson wrote:
> On Sat, Nov 23, 2024 at 02:31:13PM +0530, Manivannan Sadhasivam wrote:
> > + Ulf (also interested in this topic)
> > 
> > On Fri, Nov 22, 2024 at 04:20:50PM -0600, Bjorn Helgaas wrote:
> > > [+cc Rafael]
> > > 
> > > On Mon, Nov 18, 2024 at 01:53:44PM +0530, Manivannan Sadhasivam wrote:
> > > > PCI core allows users to configure the D3Cold state for each PCI device
> > > > through the sysfs attribute '/sys/bus/pci/devices/.../d3cold_allowed'. This
> > > > attribute sets the 'pci_dev:d3cold_allowed' flag and could be used by users
> > > > to allow/disallow the PCI devices to enter D3Cold during system suspend.
> > > >
> > > > So make use of this flag in the NVMe driver to shutdown the NVMe device
> > > > during system suspend if the user has allowed D3Cold for the device.
> > > > Existing checks in the NVMe driver decide whether to shut down the device
> > > > (based on platform/device limitations), so use this flag as the last resort
> > > > to keep the existing behavior.
> > > > 
> > > > The default behavior of the 'pci_dev:d3cold_allowed' flag is to allow
> > > > D3Cold and the users can disallow it through sysfs if they want.
> > > 
> > > What problem does this solve?  I guess there must be a case where
> > > suspend leaves NVMe in a higher power state than you want?
> > > 
> > 
> > Yeah, this is the case for all systems that doesn't fit into the existing checks
> > in the NVMe suspend path:
> > 
> > 1. ACPI based platforms
> > 2. Controller doesn't support NPSS (hardware issue/limitation)
> > 3. ASPM not enabled
> > 4. Devices/systems setting NVME_QUIRK_SIMPLE_SUSPEND flag
> > 
> > In my case, all the Qualcomm SoCs using Devicetree doesn't fall into the above
> > checks. Hence, they were not fully powered down during system suspend and always
> > in low power state. This means, I cannot achieve 'CX power collapse', a Qualcomm
> > specific SoC powered down state that consumes just enough power to wake up the
> > SoC. Since the controller driver keeps the PCI resource vote because of NVMe,
> > the firmware in the Qualcomm SoCs cannot put the SoC into above mentioned low
> > power state.
> > 
> 
> Per our previous discussions, I think we concluded that we have two
> cases:
> a) of_machine_is_compatible("qcom,sc8280xp")
> b) Everything else
> 
> In #a we have to power down NVMe as the link doesn't survive the CX
> collapse, is this your #2?. For #b it's primarily a policy decision
> about the tradeoff between battery and flash life (and in some cases, as
> already seen in the nvme driver, some device-specific policy).
> 

With this proposed usage of the 'd3cold_allowed' sysfs attribute, all devices
will enter D3Cold by default, unless overridden by userspace. So #a will be
covered by default, and #b is left to userspace.

> > > What does it mean that this is the "last resort to keep the existing
> > > behavior"?  All the checks are OR'd together and none have side
> > > effects, so the order doesn't really matter.  It changes the existing
> > > behavior *unless* the user has explicitly cleared d3cold_allowed via
> > > sysfs.
> > > 
> > 
> > Since the checks are ORed, this new check is not going to change the existing
> > behavior for systems satisfying above checks i.e., even if the user changes the
> > flag to forbid D3Cold, it won't affect them and it *shoudn't*.
> > 
> > > pdev->d3cold_allowed is set by default, so I guess this change means
> > > that unless the user clears d3cold_allowed, we let the PCI core decide
> > > the suspend state instead of managing it directly in nvme_suspend()?
> > > 
> > 
> > If 'pdev->d3cold_allowed' is set, then NVMe driver will shutdown the device and
> > the PCI controller driver can turn off all bus specific resources. Otherwise,
> > NVMe driver will put the device into low power mode and the controller driver
> > has to do something similar to retain the device power.
> > 
> > > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > > ---
> > > >  drivers/nvme/host/pci.c | 3 ++-
> > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> > > > index 4b9fda0b1d9a..a4d4687854bf 100644
> > > > --- a/drivers/nvme/host/pci.c
> > > > +++ b/drivers/nvme/host/pci.c
> > > > @@ -3287,7 +3287,8 @@ static int nvme_suspend(struct device *dev)
> > > >  	 */
> > > >  	if (pm_suspend_via_firmware() || !ctrl->npss ||
> > > >  	    !pcie_aspm_enabled(pdev) ||
> > > > -	    (ndev->ctrl.quirks & NVME_QUIRK_SIMPLE_SUSPEND))
> > > > +	    (ndev->ctrl.quirks & NVME_QUIRK_SIMPLE_SUSPEND) ||
> > > > +	    pdev->d3cold_allowed)
> > > >  		return nvme_disable_prepare_reset(ndev, true);
> > > 
> > > I guess your intent is that if users prevent use of D3cold via sysfs,
> > > we'll use the NVMe-specific power states, and otherwise, the PCI core
> > > will decide?
> > > 
> > 
> > Not PCI core, but the controller drivers actually which takes care of powering
> > down the PCI bus resources.
> > 
> > > I think returning 0 here means the PCI core decides what state to use
> > > in the pci_pm_suspend_noirq() -> pci_prepare_to_sleep() path.  This
> > > could be any state from D0 to D3cold depending on platform support and
> > > wakeup considerations (see pci_target_state()).
> > > 
> > > I'm not sure the use of pdev->d3cold_allowed here really expresses
> > > your underlying intent.  It suggests that you're really hoping for
> > > D3cold, but that's only a possibility if firmware supports it, and we
> > > have no visibility into that here.
> > > 
> > 
> > I'm not relying on firmware to do anything here. If firmware has to decide the
> > suspend state, it should already satisfy the pm_suspend_via_firmware() check in
> > nvme_suspend(). Here, the controller driver takes care of putting the device
> > into D3Cold. Currently, the controller drivers cannot do it (on DT platforms)
> > because of NVMe driver's behavior.
> > 
> > > It also seems contrary to the earlier comment that suggests we prefer
> > > host managed nvme power settings:
> > > 
> > >   * The platform does not remove power for a kernel managed suspend so
> > >   * use host managed nvme power settings for lowest idle power if
> > >   * possible. This should have quicker resume latency than a full device
> > >   * shutdown.  But if the firmware is involved after the suspend or the
> > >   * device does not support any non-default power states, shut down the
> > >   * device fully.
> > 
> > This above comment satisfies the ACPI platforms as the firmware controls the
> > suspend state. On DT platforms, even though the firmware takes care of suspend
> > state, it still relies on the controller driver to relinquish the votes for PCI
> > resources. Only then, the firmware will put the whole SoC in power down mode
> > a.k.a CX power collapse mode in Qcom SoCs.
> > 
> > We did attempt so solve this problem in multiple ways, but the lesson learned
> > was, kernel cannot decide the power mode without help from userspace. That's the
> > reason I wanted to make use of this 'd3cold_allowed' sysfs attribute to allow
> > userspace to override the D3Cold if it wants based on platform requirement.
> > 
> 
> What do you mean "without help from userspace". Which entity in
> userspace is going to help make this decision?
> 

The entities controlling the similar UFS 'spm_lvl' attributes (Android userspace
is one such example). Right now, most of the platforms (not just Qcom) require
the PCIe devices to be powered down during system suspend. So no userspace
intervention is required. But if someone puts the same chipsets on Android
form factor devices, then they need to teach the Android userspace to control
this attribute similar to how it is done for UFS.

> > This is similar to how UFS allows users to configure power states of both the
> > device and controller:
> > 
> 
> "Allow users to configure" is an optimization, is the purpose of this
> patch to allow similar kind of optimization? Or is it supposed to allow
> userspace to help solve case #a above (hardware doesn't survive CX
> collapse)?
> 

Both as explained above.

- Mani

-- 
மணிவண்ணன் சதாசிவம்


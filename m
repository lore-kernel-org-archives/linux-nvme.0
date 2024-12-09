Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 581DDE7717D
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Dec 2024 14:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KljjciUYKRtZe6TTkB3fwVscfzXvlqDm8f0xGw53hKc=; b=WD9SZJox9/9wNUlHcYTd4QsMH4
	jGpUyTd1PhzGcjyizs8bVcUbgJO6G9k0fEF13P2ooyMdMdz9ZavS/PXSiVZ3YJlLXpGxUkCz9Johs
	sVOnDIvhPbrDgy0W4JFDn/sQ6Fw/4ht9Y1iABywrbE1N0D6r+aIBp+cPw34/W18prRXhGH6AY5YMs
	NJGcHk3zm4jS2odwcO596vVaT5GtVkBdNphJfSEkL4Ve53fdMl7fBqH2beuVSiQFMGRG4UFDNC0O2
	K95Kvp/k8bB2j8DM9porD0AILSCjiuwWj+VARfcmKF+w8+6vOix42uGLWG06Dwl0UvZLQJJ5hfNhW
	dn8bOqcw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tKfCa-00000008IAp-2n97;
	Mon, 09 Dec 2024 14:57:36 +0000
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tKfCX-00000008I8j-0rtr
	for linux-nvme@lists.infradead.org;
	Mon, 09 Dec 2024 14:57:34 +0000
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-2ee9a780de4so3486948a91.3
        for <linux-nvme@lists.infradead.org>; Mon, 09 Dec 2024 06:57:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733756252; x=1734361052; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KljjciUYKRtZe6TTkB3fwVscfzXvlqDm8f0xGw53hKc=;
        b=xrpI1v7WpFNTMNcimdkdCn6JK4O4rq3HVTgL31LFLG5em6h9nr8nnqJgk8taGnXMpp
         Kfz5h9/FzsYWDTIPnUCsHEizfaJ+rkYRYWb8z8UuZZz6kGMnewxIxYpOmW+u8DgcQo6M
         vLwRN+R751laE2LLe5RAMfKN8a19duwAVGq7BWS/qzU1QClbqJGHdI+sidkD73DKhjl3
         evd+GOcoFOdpikjpQ+w2RuBCCpwK0kFJCZqL4OIAGyOnljN/yuKj/wz2gtkl6zNaMkCy
         RwqAk1Rd2bsQSWVrz9v9ecEn+iF1d+c2gew2HOtWargPOpnqKeczrH5tjq2YOpOsDOuB
         oNTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733756252; x=1734361052;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KljjciUYKRtZe6TTkB3fwVscfzXvlqDm8f0xGw53hKc=;
        b=I+sfxMYsHCtEPDkrENYCOoPU4AkqqYIV/Rhaph954nhserepj1mRq3CP2Pl+LEPlbb
         TACnp/obk+vYd6tApTcu62Tu9nqG47uzt3jKeQHxkKVhjSBbu01EUx4TDtV1IU56kNP+
         3UWjTno202ogjsXOBHAGoGkJkHUKegPzv7+QxNH3NX20ynw1RM3U0+lmjYf4476NIQlP
         Y+O2Yz+h4BlhFfv2fHFMdCUr0Y0ydqaNCiZaBLw8i6Vm5nmIffjfQ1MXlwKJBjaNcxgs
         0znApMFrhEO6/vN7pidwzFA5b1R9wnjZb0Bwm8G0s8Q/Z50nW/rQ6qB1ZC3Fjc7mBhGw
         tEkg==
X-Forwarded-Encrypted: i=1; AJvYcCWWTSzfdOrJFQlKQZ1qaBzbsjPt7rgUbnf3O9mfeZEUNBQVqvxx0hbV3TsdWiWfZhvOeTIBvrVNu9+1@lists.infradead.org
X-Gm-Message-State: AOJu0Yxl0zuUaVxnNOcpbZYJUrzePksneBV8c+tps7mjTKlSFCh8yOFr
	UYoG1sXHweS4hQbffzGL1v591G1FQ8Ph5Ju8VAVjkQHthoVJpZxTbW6ClptSnw==
X-Gm-Gg: ASbGncsvX9ShD8ki8JOO7tMYNR7i7Szq8+Eg8PAxmqQfFKMY4azVXGLYzoqGu8pAHG2
	Gvqn8jU6jJh9vacvkc6VAlJECAbv3++hHGztPyvG+3pRDBcXpzWCDM5OPJKhOTiT+01dNAmqBCT
	ayuQbrUUTkWOV+D7hlHKsWpiFpg6TCxhaz3fM/0aKvi222LnR3TDCMsZgGaAVT4Zo8gzeYAIJHg
	IQwXY1rBIJqtfDOdsgQ8pqU8ZzFScvpAY1xnujU56HQJ8/z0YpbmwWgyjyV
X-Google-Smtp-Source: AGHT+IGGIf0rHxIHQpm9+Q2TsNvz9dCMkcSWu+SbDwmZXMCAJqjPZpdwwKQe51sDJmLUG3RC2vpb1w==
X-Received: by 2002:a17:90b:4f4c:b0:2ee:5bc9:75b5 with SMTP id 98e67ed59e1d1-2ef696546efmr17506292a91.4.1733756251914;
        Mon, 09 Dec 2024 06:57:31 -0800 (PST)
Received: from thinkpad ([120.60.142.39])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd157d79e5sm7545519a12.75.2024.12.09.06.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 06:57:31 -0800 (PST)
Date: Mon, 9 Dec 2024 20:27:24 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, andersson@kernel.org,
	konradybcio@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] nvme-pci: Shutdown the device if D3Cold is allowed by
 the user
Message-ID: <20241209145724.5ibst4frsiap4s4r@thinkpad>
References: <20241123090113.semecglxaqjvlmzp@thinkpad>
 <20241205232900.GA3072557@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241205232900.GA3072557@bhelgaas>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241209_065733_256617_40219A50 
X-CRM114-Status: GOOD (  50.26  )
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

On Thu, Dec 05, 2024 at 05:29:00PM -0600, Bjorn Helgaas wrote:
> On Sat, Nov 23, 2024 at 02:31:13PM +0530, Manivannan Sadhasivam wrote:
> > On Fri, Nov 22, 2024 at 04:20:50PM -0600, Bjorn Helgaas wrote:
> > > On Mon, Nov 18, 2024 at 01:53:44PM +0530, Manivannan Sadhasivam wrote:
> > > > PCI core allows users to configure the D3Cold state for each PCI
> > > > device through the sysfs attribute
> > > > '/sys/bus/pci/devices/.../d3cold_allowed'. This attribute sets
> > > > the 'pci_dev:d3cold_allowed' flag and could be used by users to
> > > > allow/disallow the PCI devices to enter D3Cold during system
> > > > suspend.
> > > >
> > > > So make use of this flag in the NVMe driver to shutdown the NVMe
> > > > device during system suspend if the user has allowed D3Cold for
> > > > the device.  Existing checks in the NVMe driver decide whether
> > > > to shut down the device (based on platform/device limitations),
> > > > so use this flag as the last resort to keep the existing
> > > > behavior.
> > > > 
> > > > The default behavior of the 'pci_dev:d3cold_allowed' flag is to
> > > > allow D3Cold and the users can disallow it through sysfs if they
> > > > want.
> > > 
> > > What problem does this solve?  I guess there must be a case where
> > > suspend leaves NVMe in a higher power state than you want?
> > 
> > Yeah, this is the case for all systems that doesn't fit into the
> > existing checks in the NVMe suspend path:
> > 
> > 1. ACPI based platforms
> > 2. Controller doesn't support NPSS (hardware issue/limitation)
> > 3. ASPM not enabled
> > 4. Devices/systems setting NVME_QUIRK_SIMPLE_SUSPEND flag
> > 
> > In my case, all the Qualcomm SoCs using Devicetree doesn't fall into
> > the above checks. Hence, they were not fully powered down during
> > system suspend and always in low power state. This means, I cannot
> > achieve 'CX power collapse', a Qualcomm specific SoC powered down
> > state that consumes just enough power to wake up the SoC. Since the
> > controller driver keeps the PCI resource vote because of NVMe, the
> > firmware in the Qualcomm SoCs cannot put the SoC into above
> > mentioned low power state.
> 
> IIUC nvme_suspend() has two paths:
> 
>   - Do nvme_disable_prepare_reset() without calling pci_save_state(),
>     so the PCI core chooses and sets the low-power state.
> 
>   - Put the device in an NVMe-specific low-power state and call
>     pci_save_state(), which prevents the PCI core from putting the
>     device in a low-power state.
> 
>     (The PCI core part is in pci_pm_suspend_noirq(),
>     pci_pm_poweroff_noirq(), pci_pm_runtime_suspend())
> 
> And I guess you want the first path for basically all systems?  The
> only systems that would use the NVMe-specific path are those where:
> 
>   - !pm_suspend_via_firmware() (not an ACPI system), AND
> 
>   - ctrl->npss (device supports NVMe power states), AND
> 
>   - pcie_aspm_enabled(), AND
> 
>   - !NVME_QUIRK_SIMPLE_SUSPEND (it's not something with a weird
>     quirk), AND
> 
>   - !pdev->d3cold_allowed (user has cleared it via sysfs)
> 
> This frankly seems almost unintelligible to me, so I'm glad I'm not
> responsible for nvme :)
> 

I agree that using the attribute is not a great idea in the NVMe driver where
there are already a handful of quirks/checks, but that seems unavoidable.

> > > I'm not sure the use of pdev->d3cold_allowed here really expresses
> > > your underlying intent.  It suggests that you're really hoping for
> > > D3cold, but that's only a possibility if firmware supports it, and
> > > we have no visibility into that here.
> > 
> > I'm not relying on firmware to do anything here. If firmware has to
> > decide the suspend state, it should already satisfy the
> > pm_suspend_via_firmware() check in nvme_suspend(). ...
> 
> I'm confused about this because we want to use PCI core power
> management, which chooses the new state with pci_target_state(),
> which looks like it will choose D3hot unless we're on an ACPI system
> and acpi_pci_choose_state() returns D3cold.
> 
> But your system is not an ACPI system, so we should get D3hot, but yet
> you decide based on D3*cold* being allowed?
> 

This is an existing ungliness of DT platforms. D3Cold is not tied to the PCI
core, but the controller drivers decide on their own.

> > Here, the controller driver takes care of putting the device into
> > D3Cold.  Currently, the controller drivers cannot do it (on DT
> > platforms) because of NVMe driver's behavior.
> 
> I'm missing the connection to the controller driver (I assume you mean
> qcom-pcie?).  Maybe it's that having the NVMe device in a PCI
> low-power state allows qcom_pcie_suspend_noirq() to reduce the ICC
> bandwidth vote and do other power-saving things?  And it can't do
> those things if we're using the NVMe low-power state because that
> state is not visible to qcom-pcie?
> 

Yes. In DT platforms, peripheral power state is not controlled by the firmware
to some extent. For PCIe, the controller driver is responsible for handling the
endpoint devices power state. As you referred qcom-pcie driver, it currently has
the 1 Kbps ICC vote in qcom_pcie_suspend_noirq() just because we cannot fully
remove the ICC vote due to NVMe. Because of this, even if NVMe is in its optimal
low power state, the SoC cannot enter its own low power state. Plus it doesn't
make a lot of sense to keep NVMe in low power mode even if you suspend your DT
based laptop for hours.

- Mani

-- 
மணிவண்ணன் சதாசிவம்


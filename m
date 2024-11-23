Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C620AE6ADE8
	for <linux-nvme@archiver.kernel.org>; Sat, 23 Nov 2024 09:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BBiKB3fBf+Bk4u52dSdkKE7lx9s1dAcTEPhof51kEoU=; b=miO+Il6ujHaFZY9nRyk8hqiJbp
	ptW6i1ZmBe0Nixu9YsfKPOQaPuZdoUrXwe4i3LoLj6sKE8WGBRk4s6iZFIZJyT68SzvaYn3QmBdcY
	gmogsTZFDtI02dhZR80qVPeJg8E/7BvYv6ZxEU8zfJQZfuCAxV/th+DQHfbKkqfHHSwDkSjBjwee+
	pKgTxpWTYNz3uFnJVJuomHJiDwnieAf/5hqseIfz0AibV0tzxuxvhmZLqY3mUQ8PhHIrlCfG5+K3G
	eMKOfpWTXltWOkMLkOAswZCnGOOZOCcKg+D23I8w11jLr/fHRi/zqjUKZTc7VljQKpL1TajQ1Y+RI
	J8QtVkLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tEm18-00000003ynY-1oMz;
	Sat, 23 Nov 2024 09:01:26 +0000
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tEm14-00000003ymU-1c4M
	for linux-nvme@lists.infradead.org;
	Sat, 23 Nov 2024 09:01:24 +0000
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-720c286bcd6so2684609b3a.3
        for <linux-nvme@lists.infradead.org>; Sat, 23 Nov 2024 01:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732352481; x=1732957281; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BBiKB3fBf+Bk4u52dSdkKE7lx9s1dAcTEPhof51kEoU=;
        b=wejOa3Vq1JP8r4E25dc+3+yY3K7sAhffxldGIhponszMwUh3mhIh3KR4asBRSCtVBb
         xAnkQmhzoAGyfgg0KC7rdSWvExwSkE4kO+FH3fh9brBnJYJaU4SVOe/75aMd4bk+nzBU
         3woKCB8e/oIDRzXikVUAEMmie3oE6tv5+AWCPAF2X05av2Tw2BV/WNU1E9XckP/y3mc3
         /5MhpFlqVmFQEWZuc8aaXQMa1gkWO9vaCMXbNCN3qN0zONvt7QhO9dCSFQXHpdk1fdGW
         NYyWR6D3kCmiP14YD4azLaHUI/xLaI/TsHcdweR1YsjFtcAKPgcTG9gCMlcm2hjol02Y
         v1NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732352481; x=1732957281;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BBiKB3fBf+Bk4u52dSdkKE7lx9s1dAcTEPhof51kEoU=;
        b=hDaN5xTybShwY77hQgAPy0+Um1tJLEcct301UFjAUFxGmbO/JDTy10XxpSPsO5NWbp
         hKBlroOjoMw9WXCY/1CMe5MXt0/yVFVwBpYAEVL1ushHiZx5MCDU6UMwSE4cy+OrOk0J
         fbcuYNTlmrnUBugbLsl7bNc2uzMy+ehSAyvoQLBCswt+YBNLVstGMsDdR+g1J/ybgX01
         4o9OZh3di+BhbCOtmKwIwar6GDW8oAOC1pv7P0IQrb5za9pnp/xIjSG01EfaFJjMNgiy
         6efeJzaU7Fs9jwickGFxyBnlEjh6nQXntRU/8164REWr+4nk4Jb36b5U18L3phDV2Onl
         Jz/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXb6Fpf1EAYv3GcCK37BPCnnh6rO4SErjjwN1uluAtgRdHMW1/nTt5kCkEhaJLQU4eM58QXW4woIsDd@lists.infradead.org
X-Gm-Message-State: AOJu0YyK1rjvI4HX1UWqMFwnb1KsnrIi6SXIicC/QGHddFCWcSjbnmCJ
	M9wUiXzp1me3Eh6rEqElmvDJo49vNj4pmcnAFaMnKnuNMRzFVavxmMppJ5pVJLIWi6A4Tyje9MQ
	=
X-Gm-Gg: ASbGnctvFc7G0pt06MS+cUoXzTMP09lDnZAQzufu2bugtZjJ6sEi8zfqgPkFsAh6Wia
	kcVXPiDdW2I/iub6zYtjlRTmdokIJV4bfIu8b4BppYFB8pGpaga4k9JRjkQFuIbIzf1kTzXsVdD
	zzRkodYGGT4e872zpgQjranzJDHO4pzI4BtzV8PWI2YwOtOOTYGasHAxGD1tCvx1L3JFzYJI74j
	0+WUzy9JrUtdEmAoDIx7nUIgWyFbM5bq+pkc88Xx8lD5X8sAKhGwDIrLcD0KsTV9w==
X-Google-Smtp-Source: AGHT+IEXRKK5p3elatN9Cx1SAW9h5XDRG6j63BDSg8WgjcTkcpjwRut8X2gGXXHIdFCTSsoB7yX7Yg==
X-Received: by 2002:a17:902:d2c5:b0:212:4751:ad7e with SMTP id d9443c01a7336-2129f7315dfmr69743785ad.8.1732352481266;
        Sat, 23 Nov 2024 01:01:21 -0800 (PST)
Received: from thinkpad ([2409:40f2:101e:13d7:85cf:a1c4:6490:6f75])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dbff380sm28769635ad.114.2024.11.23.01.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Nov 2024 01:01:20 -0800 (PST)
Date: Sat, 23 Nov 2024 14:31:13 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, andersson@kernel.org,
	konradybcio@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] nvme-pci: Shutdown the device if D3Cold is allowed by
 the user
Message-ID: <20241123090113.semecglxaqjvlmzp@thinkpad>
References: <20241118082344.8146-1-manivannan.sadhasivam@linaro.org>
 <20241122222050.GA2444028@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241122222050.GA2444028@bhelgaas>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241123_010122_499405_1FF148DF 
X-CRM114-Status: GOOD (  52.58  )
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

+ Ulf (also interested in this topic)

On Fri, Nov 22, 2024 at 04:20:50PM -0600, Bjorn Helgaas wrote:
> [+cc Rafael]
> 
> On Mon, Nov 18, 2024 at 01:53:44PM +0530, Manivannan Sadhasivam wrote:
> > PCI core allows users to configure the D3Cold state for each PCI device
> > through the sysfs attribute '/sys/bus/pci/devices/.../d3cold_allowed'. This
> > attribute sets the 'pci_dev:d3cold_allowed' flag and could be used by users
> > to allow/disallow the PCI devices to enter D3Cold during system suspend.
> >
> > So make use of this flag in the NVMe driver to shutdown the NVMe device
> > during system suspend if the user has allowed D3Cold for the device.
> > Existing checks in the NVMe driver decide whether to shut down the device
> > (based on platform/device limitations), so use this flag as the last resort
> > to keep the existing behavior.
> > 
> > The default behavior of the 'pci_dev:d3cold_allowed' flag is to allow
> > D3Cold and the users can disallow it through sysfs if they want.
> 
> What problem does this solve?  I guess there must be a case where
> suspend leaves NVMe in a higher power state than you want?
> 

Yeah, this is the case for all systems that doesn't fit into the existing checks
in the NVMe suspend path:

1. ACPI based platforms
2. Controller doesn't support NPSS (hardware issue/limitation)
3. ASPM not enabled
4. Devices/systems setting NVME_QUIRK_SIMPLE_SUSPEND flag

In my case, all the Qualcomm SoCs using Devicetree doesn't fall into the above
checks. Hence, they were not fully powered down during system suspend and always
in low power state. This means, I cannot achieve 'CX power collapse', a Qualcomm
specific SoC powered down state that consumes just enough power to wake up the
SoC. Since the controller driver keeps the PCI resource vote because of NVMe,
the firmware in the Qualcomm SoCs cannot put the SoC into above mentioned low
power state.

> What does it mean that this is the "last resort to keep the existing
> behavior"?  All the checks are OR'd together and none have side
> effects, so the order doesn't really matter.  It changes the existing
> behavior *unless* the user has explicitly cleared d3cold_allowed via
> sysfs.
> 

Since the checks are ORed, this new check is not going to change the existing
behavior for systems satisfying above checks i.e., even if the user changes the
flag to forbid D3Cold, it won't affect them and it *shoudn't*.

> pdev->d3cold_allowed is set by default, so I guess this change means
> that unless the user clears d3cold_allowed, we let the PCI core decide
> the suspend state instead of managing it directly in nvme_suspend()?
> 

If 'pdev->d3cold_allowed' is set, then NVMe driver will shutdown the device and
the PCI controller driver can turn off all bus specific resources. Otherwise,
NVMe driver will put the device into low power mode and the controller driver
has to do something similar to retain the device power.

> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  drivers/nvme/host/pci.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> > index 4b9fda0b1d9a..a4d4687854bf 100644
> > --- a/drivers/nvme/host/pci.c
> > +++ b/drivers/nvme/host/pci.c
> > @@ -3287,7 +3287,8 @@ static int nvme_suspend(struct device *dev)
> >  	 */
> >  	if (pm_suspend_via_firmware() || !ctrl->npss ||
> >  	    !pcie_aspm_enabled(pdev) ||
> > -	    (ndev->ctrl.quirks & NVME_QUIRK_SIMPLE_SUSPEND))
> > +	    (ndev->ctrl.quirks & NVME_QUIRK_SIMPLE_SUSPEND) ||
> > +	    pdev->d3cold_allowed)
> >  		return nvme_disable_prepare_reset(ndev, true);
> 
> I guess your intent is that if users prevent use of D3cold via sysfs,
> we'll use the NVMe-specific power states, and otherwise, the PCI core
> will decide?
> 

Not PCI core, but the controller drivers actually which takes care of powering
down the PCI bus resources.

> I think returning 0 here means the PCI core decides what state to use
> in the pci_pm_suspend_noirq() -> pci_prepare_to_sleep() path.  This
> could be any state from D0 to D3cold depending on platform support and
> wakeup considerations (see pci_target_state()).
> 
> I'm not sure the use of pdev->d3cold_allowed here really expresses
> your underlying intent.  It suggests that you're really hoping for
> D3cold, but that's only a possibility if firmware supports it, and we
> have no visibility into that here.
> 

I'm not relying on firmware to do anything here. If firmware has to decide the
suspend state, it should already satisfy the pm_suspend_via_firmware() check in
nvme_suspend(). Here, the controller driver takes care of putting the device
into D3Cold. Currently, the controller drivers cannot do it (on DT platforms)
because of NVMe driver's behavior.

> It also seems contrary to the earlier comment that suggests we prefer
> host managed nvme power settings:
> 
>   * The platform does not remove power for a kernel managed suspend so
>   * use host managed nvme power settings for lowest idle power if
>   * possible. This should have quicker resume latency than a full device
>   * shutdown.  But if the firmware is involved after the suspend or the
>   * device does not support any non-default power states, shut down the
>   * device fully.

This above comment satisfies the ACPI platforms as the firmware controls the
suspend state. On DT platforms, even though the firmware takes care of suspend
state, it still relies on the controller driver to relinquish the votes for PCI
resources. Only then, the firmware will put the whole SoC in power down mode
a.k.a CX power collapse mode in Qcom SoCs.

We did attempt so solve this problem in multiple ways, but the lesson learned
was, kernel cannot decide the power mode without help from userspace. That's the
reason I wanted to make use of this 'd3cold_allowed' sysfs attribute to allow
userspace to override the D3Cold if it wants based on platform requirement.

This is similar to how UFS allows users to configure power states of both the
device and controller:

/sys/bus/platform/drivers/ufshcd/*/spm_lvl
/sys/bus/platform/devices/*.ufs/spm_lvl

If the 'd3cold_allowed' attribute is not a good fit for this usecase, then I'd
like to introduce a new attribute similar to UFS.

- Mani

-- 
மணிவண்ணன் சதாசிவம்


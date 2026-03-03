Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2CC8EDA694
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Mar 2026 16:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Snjn4s+P6wmBLZ73LdUf0dGDsuXvTetanPghlnx9ewE=; b=ltDKHHEShYMj/pL5WezaTBEdgm
	Z6pEH32YjyJru8pud8fl1N1U28H0zX1KONdkms74ZMOWSGtBymOinT+zScqnka1mThY5ywmIUAWEX
	Km6j6x6tCVINHyyXBE3mcrFfRiDCUroLCzUT+xiyzYALP9FXrTM+XyK+vKhhZ0iiKhLW6yxvvaAMJ
	OdQfWDqgwnkSsPuuxy88zKfr+dBpnsUY04v76IKOFT5LI9Pdb9OO4nmjn3ysONDzRig0pKMLhRRTU
	ox5/i+FFwzljoWizCoWjEN4R9yZ3ybljwUHpf8nvS8XauwnFvW3kHlvpi4gte6gJbnS2uCWPCfTOB
	E2KPh52w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxSRm-0000000FXxC-1wLf;
	Tue, 03 Mar 2026 16:18:10 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxSRk-0000000FXw2-0x5C
	for linux-nvme@lists.infradead.org;
	Tue, 03 Mar 2026 16:18:09 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 1E8BA40BD8;
	Tue,  3 Mar 2026 16:18:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C9A1C2BCAF;
	Tue,  3 Mar 2026 16:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772554687;
	bh=HKrZ9fFGSSlpC4H/YmdsdQhTkBYdI7OCy2dmmG6ClUI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qQeNMC+8TjYaXqWmi1Z5AsSI76NbaOZ40hNtAsZ6GNJQBq79GgyQkmnX039B+sNcP
	 bDM2JTflnRZD6UVXAC8yjCXqWOSp30wGcd/GLC8km7VHOlR7xLAc31ecTyNeBlJvvX
	 v+sikuYUYseEEddP2Bl7O2IQ/PyUbkNc24/NiWz3T9MyITRBthI73rba5QYcelnShE
	 VWivcYQZyOs+RY4Cv5CJ4Za+E+SGMB2D1FhQXjtptQbcNNMA0oYpLceyhY1t48OE7l
	 EoDm8+Oxtx3GK+n4WcAE1O5RoaMuje7me2Ytjty1HK7bQDh4zgNRAQMsTwCsd6j+Rl
	 jHWze/5tHPx1g==
Date: Tue, 3 Mar 2026 21:47:50 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Manikanta Maddireddy <mmaddireddy@nvidia.com>, 
	krishna.chundru@oss.qualcomm.com, Bjorn Helgaas <helgaas@kernel.org>, 
	manivannan.sadhasivam@oss.qualcomm.com, Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, "David E. Box" <david.e.box@linux.intel.com>, 
	Kai-Heng Feng <kai.heng.feng@canonical.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Chia-Lin Kao <acelan.kao@canonical.com>, 
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2 1/2] PCI/ASPM: Override the ASPM and Clock PM states
 set by BIOS for devicetree platforms
Message-ID: <kkly3z4durpagtenadvmzdpojlctachgfgi2fdapt6zthdl2gx@n2qhmlud2zb7>
References: <5z7c25nkb35prvax6vq6ud7eaeuhzsswbf7fqvmlgys3xftgwb@odocboejrdrv>
 <e44c330b-778b-4fa1-b678-fa909cc05b03@nvidia.com>
 <bf37b6a5-268d-4c07-a536-a826b3d5953b@nvidia.com>
 <unc5zefwndgcv7wufaezz3gkg3qtaymkjlmymhyqdqwzn3wybl@ow2rhbyt772h>
 <f9ac8c8f-8959-416b-ba90-14f0886c5bc0@nvidia.com>
 <a5m4pqtiaxsq5lmq64roro633ganbeq7mypa5ojuuqy4npkvok@wcogdbzaq6xe>
 <7157c68e-97f3-43b0-bfb5-e271a8f2a4b8@nvidia.com>
 <cf1e685a-a1cb-45ec-bdc3-1ef1a3d1044e@nvidia.com>
 <npt2cgwksulq5375dzlhszqaqrurgdvlkz6fdczer6shglqfg5@gp6a6xymymww>
 <26ad62ff-4972-4b29-8f9e-1868cd20ee00@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <26ad62ff-4972-4b29-8f9e-1868cd20ee00@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260303_081808_317255_F2D4F8DB 
X-CRM114-Status: GOOD (  27.21  )
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

On Thu, Feb 26, 2026 at 04:52:57PM +0000, Jon Hunter wrote:
> 
> On 26/02/2026 11:16, Manivannan Sadhasivam wrote:
> 
> ...
> 
> > I can't certainly know what is going wrong. If controller driver suspend is
> > skipped, then ideally the controller and the NVMe device should stay powered ON
> > during suspend. But if the platform pulls the plug at the end of suspend
> > (firmware, gdsc or some other entity), then all the context would be lost and
> > that might explain the failure because both the controller driver and NVMe
> > driver would expect the RC and NVMe to be active.
> > 
> > You can try commenting out the whole PM callbacks:
> > 		// .pm = &tegra_pcie_dw_pm_ops
> > 
> > If the host itself doesn't resume, then it confirms that some other entity is
> > pulling the plug (which is common in ARM platforms). In that case, we have to
> > let the NVMe driver know about it so that it can shutdown the controller.
> 
> For Tegra, we enter a deep low power state known as SC7 on suspend which
> does involve firmware. Nonetheless I tried for fun, but this breaks suspend
> completely.
> 

Ah, this explains the problem. We also have a similar problem on our Qcom Auto
boards where the firmware completely shuts down the SoC and puts the DRAM in
self refresh mode. So NVMe driver never resumes properly. We tried multiple ways
to address this issue in the NVMe driver, but the NVMe maintainers rejected
every single one of them and asking for some API in the PCI or PM core to tell
the NVMe driver when to shutdown the device during suspend. But this turned out
to be not so trivial.

Another way to workaround this issue would be by calling
pm_set_suspend_via_firmware() from the driver that controls the entity doing
power management of the SoC (firmware). In your case, it is
drivers/soc/tegra/pmc.c?

In that case, you can use this patch as a reference:
https://lore.kernel.org/all/20251231162126.7728-1-manivannan.sadhasivam@oss.qualcomm.com

When pm_set_suspend_via_firmware() is set, NVMe driver assumes that the firmware
might pull the plug during suspend, so it shutdowns the controller completely
and brings it back from reset during resume.

- Mani

-- 
மணிவண்ணன் சதாசிவம்


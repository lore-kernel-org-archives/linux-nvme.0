Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB1F4FC592C
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Feb 2026 11:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hsV864K9VqOLeWRQibEnKgbFMuT7XyTvbOFxjZeoSpE=; b=FAEK9UKAscSzlDNI4NsR99+e4e
	/jyEenKfhDzdF/35DIKrM5xJFanLd7xSUJae5QY9S4WbbMOQRR6Nuzt0GaZaQOl/hcSacxKP+gbKN
	MYNXVsQYKsgHBTy+A709cVfpjLdnAkRaYFL1s28cPImREC3B/Ncd3tVYGH5O961xSkZvaUzkApELa
	az8kATzE5cfEU7z36q7KSM/fGLTcXjDDgtYZGvf2kO4WZZ+YJ8eA6wPDJCqjvr6Mvkh75jOrDxSl7
	hjKUtjEl2X6dBVIm1LExBuYts0fugg0m6QC8TOXJ7hSZJuq+DgyMGVysPyUaYCCeWGoSFrcrEFQyl
	b4t+lSHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvZMi-00000006118-3t92;
	Thu, 26 Feb 2026 11:17:08 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvZMh-00000006111-2KBZ
	for linux-nvme@lists.infradead.org;
	Thu, 26 Feb 2026 11:17:07 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 02E5B600AA;
	Thu, 26 Feb 2026 11:17:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE4D3C116C6;
	Thu, 26 Feb 2026 11:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772104626;
	bh=EBm164YdJF64MvzWiqTVH2bhb4BY80EhzoyHTGgW/3A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ce4wdFn61ewLsnyosxoI+FVPWXeyqhMsd7SX2CPw+LmoCsmu6eIOeriSAU/xeX/o/
	 HcL4uc9RwB1CWjegvwKQr1W03ZMSkUamL5ZK2l9m+ljoASbLcyoHlK+GJQoNMrwtju
	 QzKgKZp+lwjpY2BQqXgcePx+73MEm0mGUfdD7/VgOFhwhKmGsf+/UWqa1V0F/j0dQ7
	 THtcA6jVEjtTQTy387Wx3KAIBaLP6P6tyLcIfpREYefY/HnuA/hGfblLQ4rv/JtuEZ
	 jUbceZhL8zlBjUwXYge33JMrlGpZoW8JHeG5iTSDsN1uWL4eyC80pEBsj8BbJ+CmOg
	 +/EzqLIP1okcw==
Date: Thu, 26 Feb 2026 16:46:52 +0530
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
Message-ID: <npt2cgwksulq5375dzlhszqaqrurgdvlkz6fdczer6shglqfg5@gp6a6xymymww>
References: <7306256a-b380-489b-8248-b774e6d3d80e@nvidia.com>
 <20260122152903.GA1247682@bhelgaas>
 <5z7c25nkb35prvax6vq6ud7eaeuhzsswbf7fqvmlgys3xftgwb@odocboejrdrv>
 <e44c330b-778b-4fa1-b678-fa909cc05b03@nvidia.com>
 <bf37b6a5-268d-4c07-a536-a826b3d5953b@nvidia.com>
 <unc5zefwndgcv7wufaezz3gkg3qtaymkjlmymhyqdqwzn3wybl@ow2rhbyt772h>
 <f9ac8c8f-8959-416b-ba90-14f0886c5bc0@nvidia.com>
 <a5m4pqtiaxsq5lmq64roro633ganbeq7mypa5ojuuqy4npkvok@wcogdbzaq6xe>
 <7157c68e-97f3-43b0-bfb5-e271a8f2a4b8@nvidia.com>
 <cf1e685a-a1cb-45ec-bdc3-1ef1a3d1044e@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cf1e685a-a1cb-45ec-bdc3-1ef1a3d1044e@nvidia.com>
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

On Thu, Feb 19, 2026 at 05:42:37PM +0000, Jon Hunter wrote:
> Hi Mani,
> 
> On 16/02/2026 14:35, Jon Hunter wrote:
> 
> ...
> 
> > > Krishna posted the series a couple of weeks before but forgot to CC you:
> > > https://lore.kernel.org/linux-pci/20260128-d3cold-v1-0-
> > > dd8f3f0ce824@oss.qualcomm.com/
> > > 
> > > You are expected to use the helper
> > > pci_host_common_can_enter_d3cold() in the
> > > suspend path.
> 
> 
> I have been playing around with this, but so far I have not got anything
> to work. Right now I have just made the following change (note that this
> is based upon Manikanta's fixes series [0]) ...
> 
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index 9883d14f7f97..9f88e4c1db08 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -2311,6 +2311,7 @@ static int tegra_pcie_dw_suspend_late(struct device *dev)
>  static int tegra_pcie_dw_suspend_noirq(struct device *dev)
>  {
>         struct tegra_pcie_dw *pcie = dev_get_drvdata(dev);
> +       struct dw_pcie *pci = &pcie->pci;
>         if (pcie->of_data->mode == DW_PCIE_EP_TYPE)
>                 return 0;
> @@ -2318,6 +2319,9 @@ static int tegra_pcie_dw_suspend_noirq(struct device *dev)
>         if (!pcie->link_state)
>                 return 0;
> +       if (!pci_host_common_can_enter_d3cold(pci->pp.bridge))
> +               return 0;
> +
>         tegra_pcie_dw_pme_turnoff(pcie);
>         tegra_pcie_unconfig_controller(pcie);
> 
> 
> At first I was thinking that is we are not actually suspending the
> controller we can skip the configuration of the controller in the
> resume. However, if we skip configuring the controller in the resume
> then the device does not resume at all.

Device mean the 'host' here?

> So right now I have the
> above, but clearly this is not sufficient. The device resumes but
> the NVMe is not working ...
> 
>  nvme nvme0: ctrl state 1 is not RESETTING
>  nvme nvme0: Disabling device after reset failure: -19
>  nvme nvme0: Ignoring bogus Namespace Identifiers
>  Aborting journal on device nvme0n1p1-8.
>  nvme0n1: detected capacity change from 0 to 976773168
>  EXT4-fs error (device nvme0n1p1): __ext4_find_entry:1613: inode #18622533: comm (t-helper): reading directory lblock 0
>  Buffer I/O error on dev nvme0n1p1, logical block 60850176, lost sync page write
>  Buffer I/O error on dev nvme0n1p1, logical block 0, lost sync page write
>  JBD2: I/O error when updating journal superblock for nvme0n1p1-8.
>  EXT4-fs (nvme0n1p1): I/O error while writing superblock
>  EXT4-fs error (device nvme0n1p1): ext4_journal_check_start:86: comm rs:main Q:Reg: Detected aborted journal
>  Buffer I/O error on dev nvme0n1p1, logical block 0, lost sync page write
>  EXT4-fs (nvme0n1p1): I/O error while writing superblock
>  EXT4-fs (nvme0n1p1): Remounting filesystem read-only
>  EXT4-fs (nvme0n1p1): shut down requested (2)
> 
> Is the above what you were thinking? Anything else I am missing?
> 

I can't certainly know what is going wrong. If controller driver suspend is
skipped, then ideally the controller and the NVMe device should stay powered ON
during suspend. But if the platform pulls the plug at the end of suspend
(firmware, gdsc or some other entity), then all the context would be lost and
that might explain the failure because both the controller driver and NVMe
driver would expect the RC and NVMe to be active.

You can try commenting out the whole PM callbacks:
		// .pm = &tegra_pcie_dw_pm_ops

If the host itself doesn't resume, then it confirms that some other entity is
pulling the plug (which is common in ARM platforms). In that case, we have to
let the NVMe driver know about it so that it can shutdown the controller.

- Mani

-- 
மணிவண்ணன் சதாசிவம்


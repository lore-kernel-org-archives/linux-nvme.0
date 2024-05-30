Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 480B2C27C44
	for <linux-nvme@archiver.kernel.org>; Thu, 30 May 2024 17:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=NnH8P2tVnslrl6i0fyAZbuWEbxxq4Q0t9QNmo5xWFsE=; b=leHunKAglzxUYK
	N7TbMnpg+Ayt/r6seXb7LoNcE80DMSuiqUNhJL191Vp1BQXTIND4n0XR47WAgZPfH5dmfSzk12642
	Hf/FzCvl+QMwwTNtXidbY8iHu0MfisBA6Jlx2ASAHKpn7bkQ4eqh1BIDDutaPCl/Ac9LuXkt1HAcY
	illo0ygX8lyR2fmKkGDeWFn2grqgEZvWwnnIkIsITiJLg3SlObli9TH9wuLtW4YuK2MSGJ0eiH+MB
	9hq444OgLigFvYZdvLNkUkNFXFFtBmGGO4Bf1dNVF2ay4cmOL6cYKODIWNQZbruuycr1qK2yTf72s
	G65XJfEC1B0oKe554i1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCjQs-00000007yFv-1oBH;
	Thu, 30 May 2024 17:19:18 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCjQp-00000007yFY-27TI
	for linux-nvme@lists.infradead.org;
	Thu, 30 May 2024 17:19:17 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id C88F762910;
	Thu, 30 May 2024 17:19:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F1A1C2BBFC;
	Thu, 30 May 2024 17:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717089554;
	bh=LwjVNxRt17uivAZmnV0QPDf6umgqSn9p4kRd+nlUQfQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=YnbZy+D5DfuqcVeg5aEI9+K3t2YGEgCp5PMR/m+dcoSoBySJJgm7Hpie6n2RRKliU
	 0cxqnOLjdtr49z5rXY+1/3RSIFTmgiau/oS0qioBJVtOqDHK+zAXcZUrmg17h8tG7M
	 GWTgIFoiQkXZfADB6Az8eC0Vg8THclQb6IwK8umR7gbdAXh7ADih60xHRg8HaYW/TC
	 HtVBCqGqLMweWBboyNBlPacyH1R9+PPTd5g3TQGb25Tat4pEDg8mSO2IDdjo+WFC8O
	 p+sqrv6ERnhWGmiPFUL/1/QjoqcgHJRvfWBKiMkWSKgoVxGJoNxz7IxUQGIw0K8RiT
	 Kx9Ba30moy99Q==
Date: Thu, 30 May 2024 12:19:12 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Ricky Wu <ricky_wu@realtek.com>, Scott Murray <scott@spiteful.org>,
	Keith Busch <kbusch@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Aapo Vienamo <aapo.vienamo@linux.intel.com>,
	linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] PCI: pciehp: Detect device replacement during system
 sleep
Message-ID: <20240530171912.GA552281@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1afaa12f341d146ecbea27c1743661c71683833.1716992815.git.lukas@wunner.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240530_101915_780471_70249A94 
X-CRM114-Status: GOOD (  32.49  )
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

On Wed, May 29, 2024 at 04:32:09PM +0200, Lukas Wunner wrote:
> Ricky reports that replacing a device in a hotplug slot during ACPI
> sleep state S3 does not cause re-enumeration on resume, as one would
> expect.  Instead, the new device is treated as if it was the old one.
> 
> There is no bulletproof way to detect device replacement, but as a
> heuristic, check whether the device identity in config space matches
> cached data in struct pci_dev (Vendor ID, Device ID, Class Code,
> Revision ID, Subsystem Vendor ID, Subsystem ID).  Additionally, cache
> and compare the Device Serial Number (PCIe r6.2 sec 7.9.3).  If a
> mismatch is detected, mark the old device disconnected (to prevent its
> driver from accessing the new device) and synthesize a Presence Detect
> Changed event.
> 
> The device identity in config space which is compared here is the same
> as the one included in the signed Subject Alternative Name per PCIe r6.1
> sec 6.31.3.  Thus, the present commit prevents attacks where a valid
> device is replaced with a malicious device during system sleep and the
> valid device's driver obliviously accesses the malicious device.
> 
> This is about as much as can be done at the PCI layer.  Drivers may have
> additional ways to identify devices (such as reading a WWID from some
> register) and may trigger re-enumeration when detecting an identity
> change on resume.
> 
> Reported-by: Ricky Wu <ricky_wu@realtek.com>
> Closes: https://lore.kernel.org/r/a608b5930d0a48f092f717c0e137454b@realtek.com
> Tested-by: Ricky Wu <ricky_wu@realtek.com>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>

Applied to pci/hotplug for v6.11, thanks, Lukas!

> ---
>  drivers/pci/hotplug/pciehp.h      |  4 ++++
>  drivers/pci/hotplug/pciehp_core.c | 42 ++++++++++++++++++++++++++++++++++++++-
>  drivers/pci/hotplug/pciehp_hpc.c  |  5 +++++
>  drivers/pci/hotplug/pciehp_pci.c  |  4 ++++
>  4 files changed, 54 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
> index e0a614a..273dd8c 100644
> --- a/drivers/pci/hotplug/pciehp.h
> +++ b/drivers/pci/hotplug/pciehp.h
> @@ -46,6 +46,9 @@
>  /**
>   * struct controller - PCIe hotplug controller
>   * @pcie: pointer to the controller's PCIe port service device
> + * @dsn: cached copy of Device Serial Number of Function 0 in the hotplug slot
> + *	(PCIe r6.2 sec 7.9.3); used to determine whether a hotplugged device
> + *	was replaced with a different one during system sleep
>   * @slot_cap: cached copy of the Slot Capabilities register
>   * @inband_presence_disabled: In-Band Presence Detect Disable supported by
>   *	controller and disabled per spec recommendation (PCIe r5.0, appendix I
> @@ -87,6 +90,7 @@
>   */
>  struct controller {
>  	struct pcie_device *pcie;
> +	u64 dsn;
>  
>  	u32 slot_cap;				/* capabilities and quirks */
>  	unsigned int inband_presence_disabled:1;
> diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
> index ddd55ad..ff458e6 100644
> --- a/drivers/pci/hotplug/pciehp_core.c
> +++ b/drivers/pci/hotplug/pciehp_core.c
> @@ -284,6 +284,32 @@ static int pciehp_suspend(struct pcie_device *dev)
>  	return 0;
>  }
>  
> +static bool pciehp_device_replaced(struct controller *ctrl)
> +{
> +	struct pci_dev *pdev __free(pci_dev_put);
> +	u32 reg;
> +
> +	pdev = pci_get_slot(ctrl->pcie->port->subordinate, PCI_DEVFN(0, 0));
> +	if (!pdev)
> +		return true;
> +
> +	if (pci_read_config_dword(pdev, PCI_VENDOR_ID, &reg) ||
> +	    reg != (pdev->vendor | (pdev->device << 16)) ||
> +	    pci_read_config_dword(pdev, PCI_CLASS_REVISION, &reg) ||
> +	    reg != (pdev->revision | (pdev->class << 8)))
> +		return true;
> +
> +	if (pdev->hdr_type == PCI_HEADER_TYPE_NORMAL &&
> +	    (pci_read_config_dword(pdev, PCI_SUBSYSTEM_VENDOR_ID, &reg) ||
> +	     reg != (pdev->subsystem_vendor | (pdev->subsystem_device << 16))))
> +		return true;
> +
> +	if (pci_get_dsn(pdev) != ctrl->dsn)
> +		return true;
> +
> +	return false;
> +}
> +
>  static int pciehp_resume_noirq(struct pcie_device *dev)
>  {
>  	struct controller *ctrl = get_service_data(dev);
> @@ -293,9 +319,23 @@ static int pciehp_resume_noirq(struct pcie_device *dev)
>  	ctrl->cmd_busy = true;
>  
>  	/* clear spurious events from rediscovery of inserted card */
> -	if (ctrl->state == ON_STATE || ctrl->state == BLINKINGOFF_STATE)
> +	if (ctrl->state == ON_STATE || ctrl->state == BLINKINGOFF_STATE) {
>  		pcie_clear_hotplug_events(ctrl);
>  
> +		/*
> +		 * If hotplugged device was replaced with a different one
> +		 * during system sleep, mark the old device disconnected
> +		 * (to prevent its driver from accessing the new device)
> +		 * and synthesize a Presence Detect Changed event.
> +		 */
> +		if (pciehp_device_replaced(ctrl)) {
> +			ctrl_dbg(ctrl, "device replaced during system sleep\n");
> +			pci_walk_bus(ctrl->pcie->port->subordinate,
> +				     pci_dev_set_disconnected, NULL);
> +			pciehp_request(ctrl, PCI_EXP_SLTSTA_PDC);
> +		}
> +	}
> +
>  	return 0;
>  }
>  #endif
> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
> index b1d0a1b3..061f01f 100644
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -1055,6 +1055,11 @@ struct controller *pcie_init(struct pcie_device *dev)
>  		}
>  	}
>  
> +	pdev = pci_get_slot(subordinate, PCI_DEVFN(0, 0));
> +	if (pdev)
> +		ctrl->dsn = pci_get_dsn(pdev);
> +	pci_dev_put(pdev);
> +
>  	return ctrl;
>  }
>  
> diff --git a/drivers/pci/hotplug/pciehp_pci.c b/drivers/pci/hotplug/pciehp_pci.c
> index ad12515..65e50be 100644
> --- a/drivers/pci/hotplug/pciehp_pci.c
> +++ b/drivers/pci/hotplug/pciehp_pci.c
> @@ -72,6 +72,10 @@ int pciehp_configure_device(struct controller *ctrl)
>  	pci_bus_add_devices(parent);
>  	down_read_nested(&ctrl->reset_lock, ctrl->depth);
>  
> +	dev = pci_get_slot(parent, PCI_DEVFN(0, 0));
> +	ctrl->dsn = pci_get_dsn(dev);
> +	pci_dev_put(dev);
> +
>   out:
>  	pci_unlock_rescan_remove();
>  	return ret;
> -- 
> 2.43.0
> 


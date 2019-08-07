From: kbusch@kernel.org (Keith Busch)
Date: Wed, 7 Aug 2019 08:37:34 -0600
Subject: [PATCH] nvme-pci: Do not prevent PCI bus-level PM from being used
In-Reply-To: <1893355.EP2830DdO9@kreacher>
References: <47415939.KV5G6iaeJG@kreacher>
 <20190730144134.GA12844@localhost.localdomain>
 <100ba4aff1c6434a81e47774ab4acddc@AUSX13MPC105.AMER.DELL.COM>
 <8246360B-F7D9-42EB-94FC-82995A769E28@canonical.com>
 <20190730191934.GD13948@localhost.localdomain>
 <7d3e0b8ba1444194a153c93faa1cabb3@AUSX13MPC105.AMER.DELL.COM>
 <20190730213114.GK13948@localhost.localdomain>
 <CAJZ5v0gxfeMN8eCNRjcXmUOkReVsdozb3EccaYMpnmSHu3771g@mail.gmail.com>
 <20190731221956.GB15795@localhost.localdomain>
 <1893355.EP2830DdO9@kreacher>
Message-ID: <20190807143733.GA25621@localhost.localdomain>

On Wed, Aug 07, 2019@02:53:44AM -0700, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki at intel.com>
> 
> One of the modifications made by commit d916b1be94b6 ("nvme-pci: use
> host managed power state for suspend") was adding a pci_save_state()
> call to nvme_suspend() in order to prevent the PCI bus-level PM from
> being applied to the suspended NVMe devices, but if ASPM is not
> enabled for the target NVMe device, that causes its PCIe link to stay
> up and the platform may not be able to get into its optimum low-power
> state because of that.
> 
> For example, if ASPM is disabled for the NVMe drive (PC401 NVMe SK
> hynix 256GB) in my Dell XPS13 9380, leaving it in D0 during
> suspend-to-idle prevents the SoC from reaching package idle states
> deeper than PC3, which is way insufficient for system suspend.
> 
> To address this shortcoming, make nvme_suspend() check if ASPM is
> enabled for the target device and fall back to full device shutdown
> and PCI bus-level PM if that is not the case.
> 
> Fixes: d916b1be94b6 ("nvme-pci: use host managed power state for suspend")
> Link: https://lore.kernel.org/linux-pm/2763495.NmdaWeg79L at kreacher/T/#t
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki at intel.com>

Thanks for tracking down the cause. Sounds like your earlier assumption
on ASPM's involvement was spot on.

> +/*
> + * pcie_aspm_enabled - Return the mask of enabled ASPM link states.
> + * @pci_device: Target device.
> + */
> +u32 pcie_aspm_enabled(struct pci_dev *pci_device)
> +{
> +	struct pci_dev *bridge = pci_device->bus->self;

You may want use pci_upstream_bridge() instead, just in case someone
calls this on a virtual function's pci_dev.

> +	u32 aspm_enabled;
> +
> +	mutex_lock(&aspm_lock);
> +	aspm_enabled = bridge->link_state ? bridge->link_state->aspm_enabled : 0;
> +	mutex_unlock(&aspm_lock);
> +
> +	return aspm_enabled;
> +}

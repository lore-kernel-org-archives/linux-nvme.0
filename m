From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Wed, 07 Aug 2019 12:14:08 +0200
Subject: [PATCH] nvme-pci: Do not prevent PCI bus-level PM from being used
In-Reply-To: <1893355.EP2830DdO9@kreacher>
References: <4323ed84dd07474eab65699b4d007aaf@AUSX13MPC105.AMER.DELL.COM>
 <20190731221956.GB15795@localhost.localdomain> <1893355.EP2830DdO9@kreacher>
Message-ID: <2081634.8PS0KMhuBW@kreacher>

On Wednesday, August 7, 2019 11:53:44 AM CEST Rafael J. Wysocki wrote:
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
> ---

I should have used a better subject for this patch.

I'll resend it with a changed subject later, but for now I would like to collect
opinions about it (if any).

Cheers!

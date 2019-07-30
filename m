From: kbusch@kernel.org (Keith Busch)
Date: Tue, 30 Jul 2019 08:41:35 -0600
Subject: [Regression] Commit "nvme/pci: Use host managed power state for
 suspend" has problems
In-Reply-To: <47415939.KV5G6iaeJG@kreacher>
References: <2332799.izEFUvJP67@kreacher>
 <4323ed84dd07474eab65699b4d007aaf@AUSX13MPC105.AMER.DELL.COM>
 <CAJZ5v0iDQ4=kTUgW94tKGt7oJzA_3uVU_M6HAMbNCRXwp_do8A@mail.gmail.com>
 <47415939.KV5G6iaeJG@kreacher>
Message-ID: <20190730144134.GA12844@localhost.localdomain>

On Tue, Jul 30, 2019@03:45:31AM -0700, Rafael J. Wysocki wrote:
> So I can reproduce this problem with plain 5.3-rc1 and the patch below fixes it.
> 
> Also Mario reports that the same patch needs to be applied for his 9380 to reach
> SLP_S0 after some additional changes under testing/review now, so here it goes.
> 
> [The changes mentioned above are in the pm-s2idle-testing branch in the
>  linux-pm.git tree at kernel.org.]
> 
> ---
> From: Rafael J. Wysocki <rafael.j.wysocki at intel.com>
> Subject: [PATCH] nvme-pci: Do not prevent PCI bus-level PM from being used
> 
> One of the modifications made by commit d916b1be94b6 ("nvme-pci: use
> host managed power state for suspend") was adding a pci_save_state()
> call to nvme_suspend() in order to prevent the PCI bus-level PM from
> being applied to the suspended NVMe devices, but that causes the NVMe
> drive (PC401 NVMe SK hynix 256GB) in my Dell XPS13 9380 to prevent
> the SoC from reaching package idle states deeper than PC3, which is
> way insufficient for system suspend.
> 
> Fix this issue by removing the pci_save_state() call in question.

I'm okay with the patch if we can get confirmation this doesn't break
any previously tested devices. I recall we add the pci_save_state() in
the first place specifically to prevent PCI D3 since that was reported
to break some devices' low power settings. Kai-Heng or Mario, any input
here?


 
> Fixes: d916b1be94b6 ("nvme-pci: use host managed power state for suspend")
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki at intel.com>
> ---
>  drivers/nvme/host/pci.c |    8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> Index: linux-pm/drivers/nvme/host/pci.c
> ===================================================================
> --- linux-pm.orig/drivers/nvme/host/pci.c
> +++ linux-pm/drivers/nvme/host/pci.c
> @@ -2897,14 +2897,8 @@ static int nvme_suspend(struct device *d
>  		nvme_dev_disable(ndev, true);
>  		ctrl->npss = 0;
>  		ret = 0;
> -		goto unfreeze;
>  	}
> -	/*
> -	 * A saved state prevents pci pm from generically controlling the
> -	 * device's power. If we're using protocol specific settings, we don't
> -	 * want pci interfering.
> -	 */
> -	pci_save_state(pdev);
> +
>  unfreeze:
>  	nvme_unfreeze(ctrl);
>  	return ret;

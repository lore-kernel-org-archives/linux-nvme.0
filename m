From: mr.nuke.me@gmail.com (Alex G.)
Date: Thu, 10 May 2018 13:56:56 -0500
Subject: [PATCH] nvme/pci: Sync controller reset for AER slot_reset
In-Reply-To: <20180510160113.4432-1-keith.busch@intel.com>
References: <20180510160113.4432-1-keith.busch@intel.com>
Message-ID: <93d528ce-043a-5118-02b3-986d151b37cf@gmail.com>



On 05/10/2018 11:01 AM, Keith Busch wrote:
> AER handling expects a successful return from slot_reset means the
> driver made the device functional again. The nvme driver had been using
> an asynchronous reset to recover the device, so the device
> may still be initializing after control is returned to the
> AER handler. This creates problems for subsequent event handling,
> causing the initializion to fail.
> 
> This patch fixes that by syncing the controller reset before returning
> to the AER driver, and reporting the true state of the reset.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=199657
> Reported-by: Alex Gagniuc <mr.nuke.me at gmail.com>

Tested-by: Alex Gagniuc <mr.nuke.me at gmail.com>

Sponsored-by: DellEMC
You know I had to add that plug somewhere :p

> Cc: Sinan Kaya <okaya at codeaurora.org>
> Cc: Bjorn Helgaas <bhelgaas at google.com>
> Cc: <stable at vger.kernel.org>
> Signed-off-by: Keith Busch <keith.busch at intel.com>
> ---
>  drivers/nvme/host/pci.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index b542dce45927..2e221796257a 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2681,8 +2681,15 @@ static pci_ers_result_t nvme_slot_reset(struct pci_dev *pdev)
>  
>  	dev_info(dev->ctrl.device, "restart after slot reset\n");
>  	pci_restore_state(pdev);
> -	nvme_reset_ctrl(&dev->ctrl);
> -	return PCI_ERS_RESULT_RECOVERED;
> +	nvme_reset_ctrl_sync(&dev->ctrl);

This does wonders when nvme_reset_ctrl_sync() returns in a timely
manner. I was also able to get the nvme drive in a state where
nvme_reset_ctrl_sync() does not return. Then we end up with the device
lock in report_slot_reset, which, as you may imagine, is not a great thing.

I think this step is a move in the better direction, but we still have
problems.

Alex

> +	switch (dev->ctrl.state) {
> +	case NVME_CTRL_LIVE:
> +	case NVME_CTRL_ADMIN_ONLY:
> +		return PCI_ERS_RESULT_RECOVERED;
> +	default:
> +		return PCI_ERS_RESULT_DISCONNECT;
> +	}
>  }
>  
>  static void nvme_error_resume(struct pci_dev *pdev)
> 

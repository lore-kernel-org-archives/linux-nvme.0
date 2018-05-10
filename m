From: keith.busch@linux.intel.com (Keith Busch)
Date: Thu, 10 May 2018 13:14:17 -0600
Subject: [PATCH] nvme/pci: Sync controller reset for AER slot_reset
In-Reply-To: <93d528ce-043a-5118-02b3-986d151b37cf@gmail.com>
References: <20180510160113.4432-1-keith.busch@intel.com>
 <93d528ce-043a-5118-02b3-986d151b37cf@gmail.com>
Message-ID: <20180510191417.GA4787@localhost.localdomain>

On Thu, May 10, 2018@01:56:56PM -0500, Alex G. wrote:
> > @@ -2681,8 +2681,15 @@ static pci_ers_result_t nvme_slot_reset(struct pci_dev *pdev)
> >  
> >  	dev_info(dev->ctrl.device, "restart after slot reset\n");
> >  	pci_restore_state(pdev);
> > -	nvme_reset_ctrl(&dev->ctrl);
> > -	return PCI_ERS_RESULT_RECOVERED;
> > +	nvme_reset_ctrl_sync(&dev->ctrl);
> 
> This does wonders when nvme_reset_ctrl_sync() returns in a timely
> manner. I was also able to get the nvme drive in a state where
> nvme_reset_ctrl_sync() does not return. Then we end up with the device
> lock in report_slot_reset, which, as you may imagine, is not a great thing.

It never returns? That shouldn't happen. There are cases where it may take
a very long time, depending on what the controller reports in CAP.TO. The
only other case it may stall is if the controller never responds to the
initialization admin commands, but that should delay by 60 seconds under
default parameters.

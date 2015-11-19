From: keith.busch@intel.com (Keith Busch)
Date: Thu, 19 Nov 2015 22:55:25 +0000
Subject: [RESEND PATCH] NVMe: Add pci error handlers
In-Reply-To: <20151119223439.GA17172@infradead.org>
References: <1447966729-23141-1-git-send-email-keith.busch@intel.com>
 <20151119223439.GA17172@infradead.org>
Message-ID: <20151119225524.GC22690@localhost.localdomain>

On Thu, Nov 19, 2015@02:34:39PM -0800, Christoph Hellwig wrote:
> > +static pci_ers_result_t nvme_error_detected(struct pci_dev *pdev,
> > +						pci_channel_state_t state)
> > +{
> > +	struct nvme_dev *dev = pci_get_drvdata(pdev);
> > +
> > +	dev_warn(&pdev->dev, "%s: state:%d\n", __func__, state);
> > +	switch (state) {
> > +	case pci_channel_io_normal:
> > +		return PCI_ERS_RESULT_CAN_RECOVER;
> > +	case pci_channel_io_frozen:
> > +		nvme_dev_shutdown(dev);
> > +		return PCI_ERS_RESULT_NEED_RESET;
> > +	case pci_channel_io_perm_failure:
> > +		return PCI_ERS_RESULT_DISCONNECT;
> > +	}
> > +	return PCI_ERS_RESULT_NEED_RESET;
> > +}
> 
> 
> This seems to be somewhat of a default methods used by various drivers,
> and looks rather boiler plate-y.  Any reason this conversion isn't done
> by core code?

Yeah, it's pretty common. I referenced a few other pci drivers, but
mostly mpt3sas.

Sounds like a nice longer term goal to eliminate driver specific handlers
and have a common handler in the pci-core. Many error_detected/slot_reset
handlers look similar to a suspend/resume, so maybe we can leverage
power management.

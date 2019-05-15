From: kbusch@kernel.org (Keith Busch)
Date: Wed, 15 May 2019 13:34:16 -0600
Subject: [PATCHv2 6/6] nvme-pci: Use host managed power state for suspend
In-Reply-To: <f3d7281f020844828161b2387732cc42@AUSX13MPC105.AMER.DELL.COM>
References: <20190515163625.21776-1-keith.busch@intel.com>
 <20190515163625.21776-6-keith.busch@intel.com>
 <f3d7281f020844828161b2387732cc42@AUSX13MPC105.AMER.DELL.COM>
Message-ID: <20190515193415.GA22079@localhost.localdomain>

On Wed, May 15, 2019@07:33:45PM +0000, Mario.Limonciello@dell.com wrote:
> > +static int nvme_deep_state(struct nvme_dev *dev) {
> > +	struct pci_dev *pdev = to_pci_dev(dev->dev);
> > +	struct nvme_ctrl *ctrl = &dev->ctrl;
> > +	int ret = -EBUSY;;
> 
> Looks like a small typographical error with the double ;;

Good eye. I won't respin for that just yet. :)

Just fyi, I accidently didn't explicitly CC you on patches 1-5, and most
of those are necessary for patch 6/6 to compile. They whole series is
on the mailing list though.

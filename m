From: Mario.Limonciello@dell.com (Mario.Limonciello@dell.com)
Date: Wed, 15 May 2019 19:43:16 +0000
Subject: [PATCHv2 6/6] nvme-pci: Use host managed power state for suspend
In-Reply-To: <20190515193415.GA22079@localhost.localdomain>
References: <20190515163625.21776-1-keith.busch@intel.com>
 <20190515163625.21776-6-keith.busch@intel.com>
 <f3d7281f020844828161b2387732cc42@AUSX13MPC105.AMER.DELL.COM>
 <20190515193415.GA22079@localhost.localdomain>
Message-ID: <67e9643567c94a168c64e791ce41e9ec@AUSX13MPC105.AMER.DELL.COM>

> -----Original Message-----
> From: Keith Busch <kbusch at kernel.org>
> Sent: Wednesday, May 15, 2019 2:34 PM
> To: Limonciello, Mario
> Cc: keith.busch at intel.com; hch at lst.de; sagi at grimberg.me; linux-
> nvme at lists.infradead.org; rafael at kernel.org; kai.heng.feng at canonical.com
> Subject: Re: [PATCHv2 6/6] nvme-pci: Use host managed power state for
> suspend
> 
> 
> [EXTERNAL EMAIL]
> 
> On Wed, May 15, 2019 at 07:33:45PM +0000, Mario.Limonciello at dell.com
> wrote:
> > > +static int nvme_deep_state(struct nvme_dev *dev) {
> > > +	struct pci_dev *pdev = to_pci_dev(dev->dev);
> > > +	struct nvme_ctrl *ctrl = &dev->ctrl;
> > > +	int ret = -EBUSY;;
> >
> > Looks like a small typographical error with the double ;;
> 
> Good eye. I won't respin for that just yet. :)
> 
> Just fyi, I accidently didn't explicitly CC you on patches 1-5, and most of those
> are necessary for patch 6/6 to compile. They whole series is on the mailing list
> though.

Yes I noticed this, and at least one of those needs stuff in -next.
Do you feel this is going to be valuable to test on something earlier via backports
(such as 4.19 LTS), or do you want to see results directly on -next?

The series pretty much applies to 4.19 after backporting 2d4bcc16481ebc395b2d6220804a1ef2531e5ede

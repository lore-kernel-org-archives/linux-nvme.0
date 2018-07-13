From: keith.busch@linux.intel.com (Keith Busch)
Date: Fri, 13 Jul 2018 14:54:55 -0600
Subject: [PATCHv3 0/9] nvme timeout fixes, v3
In-Reply-To: <CACVXFVMMC+O65bNweq7KqTgMkGBCdqfe+_QPegFZ5=rPH1Qokg@mail.gmail.com>
References: <20180524203500.14081-1-keith.busch@intel.com>
 <CACVXFVMMC+O65bNweq7KqTgMkGBCdqfe+_QPegFZ5=rPH1Qokg@mail.gmail.com>
Message-ID: <20180713205455.GA19505@localhost.localdomain>

On Fri, Jul 13, 2018@08:48:24AM +0800, Ming Lei wrote:
> On Fri, May 25, 2018@4:34 AM, Keith Busch <keith.busch@intel.com> wrote:
> > Keith Busch (9):
> >   nvme: Sync request queues on reset
> >   nvme-pci: Fix queue freeze criteria on reset
> >   nvme: Move all IO out of controller reset
> >   nvme-pci: Rate limit the nvme timeout warnings
> >   nvme-pci: End IO requests immediately in CONNECTING state
> >   nvme-pci: Unquiesce dead controller queues
> >   nvme-pci: Attempt reset retry for IO failures
> >   nvme-pci: Queue creation error handling
> >   nvme-pci: Don't wait for HMB completion on shutdown
> >
> >  drivers/nvme/host/core.c |  23 ++++++-
> >  drivers/nvme/host/nvme.h |   2 +
> >  drivers/nvme/host/pci.c  | 173 ++++++++++++++++++++++++++++++++++-------------
> >  3 files changed, 150 insertions(+), 48 deletions(-)
> 
> Hello Keith,
> 
> I guess there will be V4 for addressing the reported issue?

Yes, I'll send that out in a few minutes.

The majority of the above are either merged already or unnecessary
anymore, but patches 1 and 3 still look useful. Patch 1 doesn't need to
change, but patch 3 from this series will be split into a series of prep
patches and made generic for the v4.

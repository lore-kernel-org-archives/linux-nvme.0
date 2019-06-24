From: hch@lst.de (Christoph Hellwig)
Date: Mon, 24 Jun 2019 08:16:17 +0200
Subject: [PATCH v2 2/5] nvme: rename "pci" operations to "mmio"
In-Reply-To: <CAD8Lp45ua=L+ixO+du=Njhy+dxjWobWA+V1i+Y2p6faeyt1FBQ@mail.gmail.com>
References: <20190620051333.2235-1-drake@endlessm.com>
 <20190620051333.2235-3-drake@endlessm.com> <20190620061038.GA20564@lst.de>
 <CAD8Lp45ua=L+ixO+du=Njhy+dxjWobWA+V1i+Y2p6faeyt1FBQ@mail.gmail.com>
Message-ID: <20190624061617.GA2848@lst.de>

On Thu, Jun 20, 2019@04:11:26PM +0800, Daniel Drake wrote:
> On Thu, Jun 20, 2019@2:11 PM Christoph Hellwig <hch@lst.de> wrote:
> > The Linux NVMe driver will deal with NVMe as specified plus whatever
> > minor tweaks we'll need for small bugs.  Hiding it behind an AHCI
> > device is completely out of scope and will not be accepted.
> 
> Do you have any new suggestions for alternative ways we can implement
> support for this storage configuration?

IFF we want to support it it has to be done at the PCIe layer.  But
even that will require actual documentation and support from Intel.

If Intel still believes this scheme is their magic secret to control
the NVMe market and give themselves and unfair advantage over their
competitors there is not much we can do.

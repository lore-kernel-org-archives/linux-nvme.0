From: drake@endlessm.com (Daniel Drake)
Date: Thu, 20 Jun 2019 16:11:26 +0800
Subject: [PATCH v2 2/5] nvme: rename "pci" operations to "mmio"
In-Reply-To: <20190620061038.GA20564@lst.de>
References: <20190620051333.2235-1-drake@endlessm.com>
 <20190620051333.2235-3-drake@endlessm.com>
 <20190620061038.GA20564@lst.de>
Message-ID: <CAD8Lp45ua=L+ixO+du=Njhy+dxjWobWA+V1i+Y2p6faeyt1FBQ@mail.gmail.com>

On Thu, Jun 20, 2019@2:11 PM Christoph Hellwig <hch@lst.de> wrote:
> The Linux NVMe driver will deal with NVMe as specified plus whatever
> minor tweaks we'll need for small bugs.  Hiding it behind an AHCI
> device is completely out of scope and will not be accepted.

Do you have any new suggestions for alternative ways we can implement
support for this storage configuration?

I tried to follow your earlier suggestions regarding faking a PCI bus
here: (or let me know if you had something different in mind...)
https://marc.info/?l=linux-pci&m=156015271021614&w=2
but it looks like that is not going to fly either :(

Daniel

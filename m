From: helgaas@kernel.org (Bjorn Helgaas)
Date: Wed, 14 Jun 2017 22:11:53 -0500
Subject: avoid null pointer rereference during FLR V2
In-Reply-To: <20170601111039.8913-1-hch@lst.de>
References: <20170601111039.8913-1-hch@lst.de>
Message-ID: <20170615031153.GI20778@bhelgaas-glaptop.roam.corp.google.com>

On Thu, Jun 01, 2017@01:10:36PM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> Rakesh reported a bug where a FLR can trivially crash his system.
> The reason for that is that NVMe unbinds the driver from the PCI device
> on an unrecoverable error, and that races with the reset_notify method.
> 
> This is fairly easily fixable by taking the device lock for a slightly
> longer period.  Note that the other PCI error handling methods actually
> have the same issue, but with them not taking the lock yet and me having
> no good way to reproducibly call them I'm a little reluctant to touch
> them, but it would be great if we could fix those issues as well.
> 
> Patches 2 and 3 are cleanups in the same area and not 4.12 material,
> but given that they depend on the first one I thought I'd send them
> along.
> 
> Changes since V1:
>  - lock over all calls to ->reset_notify

Applied all three (with some updated changelogs and comments) to
pci/virtualization for v4.13, thanks!

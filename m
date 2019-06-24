From: dwmw2@infradead.org (David Woodhouse)
Date: Mon, 24 Jun 2019 07:58:23 +0100
Subject: [PATCH v2 2/5] nvme: rename "pci" operations to "mmio"
In-Reply-To: <20190624061617.GA2848@lst.de>
References: <20190620051333.2235-1-drake@endlessm.com>
 <20190620051333.2235-3-drake@endlessm.com> <20190620061038.GA20564@lst.de>
 <CAD8Lp45ua=L+ixO+du=Njhy+dxjWobWA+V1i+Y2p6faeyt1FBQ@mail.gmail.com>
 <20190624061617.GA2848@lst.de>
Message-ID: <a7beeb56e98a5559c4ab7810368b4d388aedf44c.camel@infradead.org>

On Mon, 2019-06-24@08:16 +0200, Christoph Hellwig wrote:
> On Thu, Jun 20, 2019@04:11:26PM +0800, Daniel Drake wrote:
> > On Thu, Jun 20, 2019@2:11 PM Christoph Hellwig <hch@lst.de> wrote:
> > > The Linux NVMe driver will deal with NVMe as specified plus whatever
> > > minor tweaks we'll need for small bugs.  Hiding it behind an AHCI
> > > device is completely out of scope and will not be accepted.
> > 
> > Do you have any new suggestions for alternative ways we can implement
> > support for this storage configuration?
> 
> IFF we want to support it it has to be done at the PCIe layer.  But
> even that will require actual documentation and support from Intel.
> 
> If Intel still believes this scheme is their magic secret to control
> the NVMe market and give themselves and unfair advantage over their
> competitors there is not much we can do.

At the very least, the switch to make it normal again shouldn't be in
the BIOS settings where it requires manual interaction, but should be
changeable at run time by the operating system.

Intel are consistently failing to learn the "firmware exists to boot
the OS and get out of the way" lesson. There are cases like thermal
management which sometimes make for valid exceptions, of course. This
isn't one of them.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 5174 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20190624/b9487099/attachment.bin>

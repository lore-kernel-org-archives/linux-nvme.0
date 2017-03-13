From: keith.busch@intel.com (Keith Busch)
Date: Mon, 13 Mar 2017 12:11:28 -0400
Subject: [RFC PATCH] nvmet: Back namespace with files
In-Reply-To: <d6291643-c644-5790-4311-3a159d5eecc9@grimberg.me>
References: <1489008937-31043-1-git-send-email-keith.busch@intel.com>
 <20170308213519.GA32009@lst.de>
 <20170308221527.GA1885@localhost.localdomain>
 <20170308222014.GA635@lst.de>
 <20170309174120.GA14329@localhost.localdomain>
 <d6291643-c644-5790-4311-3a159d5eecc9@grimberg.me>
Message-ID: <20170313161128.GD6994@localhost.localdomain>

On Mon, Mar 13, 2017@10:32:38AM +0200, Sagi Grimberg wrote:
> > Hm, implementation details aside for a second, isn't namespace management
> > more useful on fabrics than pci? It's like managing LUNs on a SAN,
> > but with spec defined commands.
> 
> Not exactly, usually namespace/lun provisioning is something that a
> given host does not typically do or even aware of. Unlike in PCIe,
> in fabrics, the host does not really own "the" subsystem, it just owns
> a virtual subsystem that the target exposed for it.
>
> If we do support namespace management in the linux target, it'd need
> to be emulated somehow, obviously a host cannot simply add
> unprovisioned resources.

Yes, the RFC was light on details, and I'm probably getting ahead of
myself with the file-as-a-namespaces suggestion.

I'd like an NVMe subsystem to be provided a pool of storage that it
may dynamically carve into namespaces and attach to connected hosts as
needed. I also want hosts to do this using the spec defined Namespace
Management commands. That isn't all that unusual from what I hear.

This doesn't really require a filesystem. Maybe LVM is more appropriate,
but I think that'd require userspace to manage the LVs. Still, file backed
namespaces has uses if only for testing purposes, like LIO's FILEIO.

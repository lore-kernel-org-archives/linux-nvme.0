From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 13 Mar 2017 10:32:38 +0200
Subject: [RFC PATCH] nvmet: Back namespace with files
In-Reply-To: <20170309174120.GA14329@localhost.localdomain>
References: <1489008937-31043-1-git-send-email-keith.busch@intel.com>
 <20170308213519.GA32009@lst.de> <20170308221527.GA1885@localhost.localdomain>
 <20170308222014.GA635@lst.de> <20170309174120.GA14329@localhost.localdomain>
Message-ID: <d6291643-c644-5790-4311-3a159d5eecc9@grimberg.me>

>> Given that namespace management is tied to controller IDs it's a fairly
>> bad fit for fabrics, especially so with our dynamic controller model.
>
> Hm, implementation details aside for a second, isn't namespace management
> more useful on fabrics than pci? It's like managing LUNs on a SAN,
> but with spec defined commands.

Not exactly, usually namespace/lun provisioning is something that a
given host does not typically do or even aware of. Unlike in PCIe,
in fabrics, the host does not really own "the" subsystem, it just owns
a virtual subsystem that the target exposed for it.

If we do support namespace management in the linux target, it'd need
to be emulated somehow, obviously a host cannot simply add
unprovisioned resources.

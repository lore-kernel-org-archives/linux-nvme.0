From: hare@suse.de (Hannes Reinecke)
Date: Mon, 13 Mar 2017 17:07:51 +0100
Subject: [RFC PATCH] nvmet: Back namespace with files
In-Reply-To: <20170313161128.GD6994@localhost.localdomain>
References: <1489008937-31043-1-git-send-email-keith.busch@intel.com>
 <20170308213519.GA32009@lst.de> <20170308221527.GA1885@localhost.localdomain>
 <20170308222014.GA635@lst.de> <20170309174120.GA14329@localhost.localdomain>
 <d6291643-c644-5790-4311-3a159d5eecc9@grimberg.me>
 <20170313161128.GD6994@localhost.localdomain>
Message-ID: <cacd8e66-bf3d-8eb9-6423-4c6000094263@suse.de>

On 03/13/2017 05:11 PM, Keith Busch wrote:
> On Mon, Mar 13, 2017@10:32:38AM +0200, Sagi Grimberg wrote:
>>> Hm, implementation details aside for a second, isn't namespace management
>>> more useful on fabrics than pci? It's like managing LUNs on a SAN,
>>> but with spec defined commands.
>>
>> Not exactly, usually namespace/lun provisioning is something that a
>> given host does not typically do or even aware of. Unlike in PCIe,
>> in fabrics, the host does not really own "the" subsystem, it just owns
>> a virtual subsystem that the target exposed for it.
>>
>> If we do support namespace management in the linux target, it'd need
>> to be emulated somehow, obviously a host cannot simply add
>> unprovisioned resources.
> 
> Yes, the RFC was light on details, and I'm probably getting ahead of
> myself with the file-as-a-namespaces suggestion.
> 
> I'd like an NVMe subsystem to be provided a pool of storage that it
> may dynamically carve into namespaces and attach to connected hosts as
> needed. I also want hosts to do this using the spec defined Namespace
> Management commands. That isn't all that unusual from what I hear.
> 
> This doesn't really require a filesystem. Maybe LVM is more appropriate,
> but I think that'd require userspace to manage the LVs. Still, file backed
> namespaces has uses if only for testing purposes, like LIO's FILEIO.
> 
I'm not against this in principle, but can we make the selectable?
IE not ripping out the original implementation, but rather have them
both side-by-side and let the admin decide what he wants to use?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)

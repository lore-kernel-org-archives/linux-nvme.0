From: hch@lst.de (Christoph Hellwig)
Date: Tue, 9 Oct 2018 08:13:43 +0200
Subject: [PATCH 1/2] nvme: NUMA locality information for fabrics
In-Reply-To: <cffba6f0-3d8a-8596-ced1-ef6eea7195f5@bjorling.me>
References: <20181005092915.126636-1-hare@suse.de>
 <20181005092915.126636-2-hare@suse.de> <20181008100423.GA6686@lst.de>
 <cffba6f0-3d8a-8596-ced1-ef6eea7195f5@bjorling.me>
Message-ID: <20181009061343.GB6752@lst.de>

On Mon, Oct 08, 2018@12:22:26PM +0200, Matias Bj?rling wrote:
>> This changes behavior as node might remain NUMA_NO_NODE when the code
>> above sets the device node to first_memory_node now when
>> it would otherwise be NUMA_NO_NODE.  Then again that code makes no
>> sense to me to start with - Matias added it with the blk-mq conversion,
>> so maybe he remembers why we do it to start with?  If we want to fix
>> up nodes like that it seems like we should do it in the driver core
>> or the PCI core.
>>
>
> Back in the days it was carried over to make sure the structures was 
> allocated from the same node as the pcie device.

Well, the PCI device will only get allocated from a node if it has
a node set, so overriding it doesn't make much sense.

Now it seems like various architectures have a stub pcibus_to_node
and thus always return NUMA_NO_NODE, but I don't really see a good
reason to override it.  Either we live with that, or move the
set_dev_node hack into the PCI core.

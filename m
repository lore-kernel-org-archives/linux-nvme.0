From: hare@suse.de (Hannes Reinecke)
Date: Mon, 21 Jan 2019 14:57:31 +0100
Subject: [PATCH] nvme-fc: use pci device as parent for nvme controller
In-Reply-To: <20190119130810.GA24374@lst.de>
References: <20190117074241.40672-1-hare@suse.de>
 <20190119130810.GA24374@lst.de>
Message-ID: <2dbe68ee-ae87-f23e-c3f3-fb6035cb21b2@suse.de>

On 1/19/19 2:08 PM, Christoph Hellwig wrote:
> On Thu, Jan 17, 2019@08:42:41AM +0100, Hannes Reinecke wrote:
>> To allow system tools to figure out which pci device provides a
>> given NVMe controller this patch moves the nvme controller sysfs
>> entry as a child of the PCI device.
>>
>> With this tools like dracut can traverse the device hierarchy to figure
>> out which modules to include.
> 
> Doesn't ->create_ctrl consumer the reference to the passed in device,
> or in other words you create a leak on the fabrics device here?
> 
Hmm. Have to check.

Cheers,

Hannes

-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)

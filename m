From: hare@suse.de (Hannes Reinecke)
Date: Tue, 3 Oct 2017 12:00:16 +0200
Subject: [PATCH 4/6] nvme: display 'NMIC' namespace attribute
In-Reply-To: <20171002161654.GC11048@lst.de>
References: <1506952559-1588-1-git-send-email-hare@suse.de>
 <1506952559-1588-5-git-send-email-hare@suse.de>
 <20171002161654.GC11048@lst.de>
Message-ID: <e5f46d2d-9473-c99c-9319-8567567b6994@suse.de>

On 10/02/2017 06:16 PM, Christoph Hellwig wrote:
> On Mon, Oct 02, 2017@03:55:57PM +0200, Hannes Reinecke wrote:
>> From: Johannes Thumshirn <jthumshirn at suse.de>
>>
>> To figure out if a namespace is shared via multipath we need to expose
>> the 'NMIC' value to sysfs.
> 
> What for?
> 
Do stop systemd/udev doing weird things on the device.
If we have the 'NMIC' attribute in sysfs we can evaluate it during event
handling, and set the 'SYSTEMD_READY=0' flag if NMIC=1.
By setting this attribute udev is instructed to not do any fancy
checking, and systemd will leave it alone.
Otherwise systemd will happily forward the block device to all attached
services, btrfs will start checking the device, blkid will be scanning
for filesystems, swap will declaring this device as a valid swap space
and the like.

One of the painful lessons learned when moving multipath-tools to
systemd; we absolutely need an indicator in sysfs to handle multipath
devices race-free.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)

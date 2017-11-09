From: hch@lst.de (Christoph Hellwig)
Date: Thu, 9 Nov 2017 16:51:41 +0100
Subject: [PATCH 4/5] nvme: implement multipath access to nvme subsystems
In-Reply-To: <163098dc-02f0-4146-17da-903971e5214d@suse.de>
References: <20171102183034.9320-1-hch@lst.de>
 <20171102183034.9320-5-hch@lst.de>
 <163098dc-02f0-4146-17da-903971e5214d@suse.de>
Message-ID: <20171109155141.GA25997@lst.de>

On Thu, Nov 09, 2017@04:44:32PM +0100, Hannes Reinecke wrote:
> - We don't have the topology information in sysfs;

We have all the topology information in sysfs, but you seem to look
for the wrong thing.

> while the namespace
> device has the 'slaves' and 'holders' directories, they remain empty,
> and the path devices don't even have those directories. I really would
> like to see them populated to help things like dracut figuring out the
> topology when building up a list of modules to include.

Of course there aren't because there is not block device you can hold
for the controller.  

> - The patch doesn't integrate with the 'claim' mechanism for block
> devices, ie device-mapper might accidentally stumble upon it when
> traversing devices.

Same as above.  There is no block device to be claimed.

> I'll be sending two patches to resurrect the 'bd_link_disk_holder'
> idea I posted earlier; that should take care of these issues.

It doesn't.  There is not block device you can hold, so there is no
point in claiming it.

From: hch@lst.de (Christoph Hellwig)
Date: Mon, 8 Feb 2016 11:13:50 +0100
Subject: complete boot failure in 4.5-rc1 caused by nvme: make SG_IO
 support optional
In-Reply-To: <56B8676C.20600@dev.mellanox.co.il>
References: <1454783624.2809.6.camel@HansenPartnership.com>
 <20160207092241.GA15331@lst.de>
 <1454861040.2329.4.camel@HansenPartnership.com> <56B7C527.6050300@kernel.dk>
 <1454886441.2329.27.camel@HansenPartnership.com> <56B8448A.3000106@suse.de>
 <56B8676C.20600@dev.mellanox.co.il>
Message-ID: <20160208101350.GA32632@lst.de>

On Mon, Feb 08, 2016@12:01:16PM +0200, Sagi Grimberg wrote:
>
>> Do we have defined sysfs attributes for NVMe devices nowadays?
>
> /sys/block/nvme0n1/uuid

That's only supported for NVMe 1.1 and higher devices, and optional.
For older or stupid devices we need to support the algorithm based
on the serial attribute from nvme_fill_device_id_scsi_string() in
drivers/nvme/host/scsi.c.

Which btw is ?ncorrect as it doesn't identify namespaces properly,
and thus the associatation of 0 is an actively harmful lie.

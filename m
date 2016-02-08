From: keith.busch@intel.com (Keith Busch)
Date: Mon, 8 Feb 2016 15:12:58 +0000
Subject: complete boot failure in 4.5-rc1 caused by nvme: make SG_IO
 support optional
In-Reply-To: <20160208101350.GA32632@lst.de>
References: <1454783624.2809.6.camel@HansenPartnership.com>
 <20160207092241.GA15331@lst.de>
 <1454861040.2329.4.camel@HansenPartnership.com>
 <56B7C527.6050300@kernel.dk>
 <1454886441.2329.27.camel@HansenPartnership.com>
 <56B8448A.3000106@suse.de> <56B8676C.20600@dev.mellanox.co.il>
 <20160208101350.GA32632@lst.de>
Message-ID: <20160208151258.GB25111@localhost.localdomain>

On Mon, Feb 08, 2016@11:13:50AM +0100, Christoph Hellwig wrote:
> On Mon, Feb 08, 2016@12:01:16PM +0200, Sagi Grimberg wrote:
> >
> >> Do we have defined sysfs attributes for NVMe devices nowadays?
> >
> > /sys/block/nvme0n1/uuid
> 
> That's only supported for NVMe 1.1 and higher devices, and optional.
> For older or stupid devices we need to support the algorithm based
> on the serial attribute from nvme_fill_device_id_scsi_string() in
> drivers/nvme/host/scsi.c.

It's even worse. NGUID was defined for 1.2 devices and higher. 1.1
devices should have EUI-64 at:
 
  /sys/block/nvmeXnY/eui

1.2 devices will have either uuid or eui (or both).

The majority of devices in circulation today are 1.0, and need to concat
these three entries to make a unique identifier:

  /sys/block/nvmeXnY/device/serial
  /sys/block/nvmeXnY/device/model
  /sys/block/nvmeXnY/nsid

From: Bart.VanAssche@wdc.com (Bart Van Assche)
Date: Tue, 14 Aug 2018 15:24:34 +0000
Subject: [PATCH 5/5] virtio-blk: modernize sysfs attribute creation
In-Reply-To: <20180814073305.87255-6-hare@suse.de>
References: <20180814073305.87255-1-hare@suse.de>
 <20180814073305.87255-6-hare@suse.de>
Message-ID: <0e99ae23c2bea89e597dd3e8b20489054f461ff5.camel@wdc.com>

On Tue, 2018-08-14@09:33 +0200, Hannes Reinecke wrote:
> Use new-style DEVICE_ATTR_RO/DEVICE_ATTR_RW to create the sysfs attributes
> and register the disk with default sysfs attribute groups.

Reviewed-by: Bart Van Assche <bart.vanassche at wdc.com>

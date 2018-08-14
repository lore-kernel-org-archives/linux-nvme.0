From: Bart.VanAssche@wdc.com (Bart Van Assche)
Date: Tue, 14 Aug 2018 15:23:06 +0000
Subject: [PATCH 4/5] zram: register default groups with device_add_disk()
In-Reply-To: <20180814073305.87255-5-hare@suse.de>
References: <20180814073305.87255-1-hare@suse.de>
 <20180814073305.87255-5-hare@suse.de>
Message-ID: <3f8e9adbb899d40dde900e4b5d57cafe663f808b.camel@wdc.com>

On Tue, 2018-08-14@09:33 +0200, Hannes Reinecke wrote:
> Register default sysfs groups during device_add-disk() to avoid a
                                       ^^^^^^^^^^^^^^^^^
                                       device_add_disk()?
> race condition with udev during startup.
> 
> Signed-off-by: Hannes Reinecke <hare at suse.com>
> Cc: Minchan Kim <minchan at kernel.org>
> Cc: Nitin Gupta <ngupta at vflare.org>
> Reviewed-by: Christoph Hellwig <hch at lst.de>

Anyway:

Reviewed-by: Bart Van Assche <bart.vanassche at wdc.com>

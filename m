From: mwilck@suse.de (Martin Wilck)
Date: Thu, 13 Jul 2017 17:08:25 +0200
Subject: [PATCH] nvmet: preserve controller serial number between reboots
In-Reply-To: <20170713104806.12353-1-jthumshirn@suse.de>
References: <20170713104806.12353-1-jthumshirn@suse.de>
Message-ID: <1499958505.6432.8.camel@suse.de>

On Thu, 2017-07-13@12:48 +0200, Johannes Thumshirn wrote:
> The NVMe target has no way to preserve controller serial
> IDs across reboots which breaks udev scripts doing
> SYMLINK+="dev/disk/by-id/nvme-$env{ID_SERIAL}-part%n.
> 
> Export the randomly generated serial number via configfs and allow
> setting of a serial via configfs to mitigate this breakage.

I'm wondering if this should be a write-once attribute. Also,
Once the serial number has been passed on to some host (or maybe only:
while the device is in use by some host), the attribute should probably
be read-only.

Martin

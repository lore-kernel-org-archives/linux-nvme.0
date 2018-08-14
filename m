From: Bart.VanAssche@wdc.com (Bart Van Assche)
Date: Tue, 14 Aug 2018 15:17:11 +0000
Subject: [PATCH 1/5] block: genhd: add 'groups' argument to device_add_disk
In-Reply-To: <20180814073305.87255-2-hare@suse.de>
References: <20180814073305.87255-1-hare@suse.de>
 <20180814073305.87255-2-hare@suse.de>
Message-ID: <712eaa404a1a76193b1a304443dcbae339e53ab5.camel@wdc.com>

On Tue, 2018-08-14@09:33 +0200, Hannes Reinecke wrote:
> Update device_add_disk() to take an 'groups' argument so that
> individual drivers can register a device with additional sysfs
> attributes.
> This avoids race condition the driver would otherwise have if these
             ^ "a" is missing?
> groups were to be created with sysfs_add_groups().

Anyway:

Reviewed-by: Bart Van Assche <bart.vanassche at wdc.com>

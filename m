From: axboe@kernel.dk (Jens Axboe)
Date: Fri, 28 Sep 2018 08:30:53 -0600
Subject: [PATCHv4 0/5] genhd: register default groups with
 device_add_disk()
In-Reply-To: <20180928061723.13180-1-hare@suse.de>
References: <20180928061723.13180-1-hare@suse.de>
Message-ID: <ca3e3be0-2ca4-6474-d8be-697ab7cc133b@kernel.dk>

On 9/28/18 12:17 AM, Hannes Reinecke wrote:
> device_add_disk() doesn't allow to register with default sysfs groups,
> which introduces a race with udev as these groups have to be created after
> the uevent has been sent.
> This patchset updates device_add_disk() to accept a 'groups' argument to
> avoid this race and updates the obvious drivers to use it.
> There are some more drivers which might benefit from this (eg loop or md),
> but the interface is not straightforward so I haven't attempted it.

Thanks Hannes, applied for 4.20.

-- 
Jens Axboe

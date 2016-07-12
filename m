From: axboe@fb.com (Jens Axboe)
Date: Tue, 12 Jul 2016 08:36:57 -0700
Subject: [PATCH] nvme-loop: add configfs dependency
In-Reply-To: <12070715.hig6uZ5icx@wuerfel>
References: <20160707090144.3061799-1-arnd@arndb.de>
 <577E68A5.8080709@kernel.dk> <20160710121417.GA21551@lst.de>
 <12070715.hig6uZ5icx@wuerfel>
Message-ID: <57850E99.1080901@fb.com>

On 07/11/2016 01:29 PM, Arnd Bergmann wrote:
> On Sunday, July 10, 2016 2:14:17 PM CEST Christoph Hellwig wrote:
>> On Thu, Jul 07, 2016@08:35:17AM -0600, Jens Axboe wrote:
>>> Thanks Arnd, applied.
>>
>> Actually I think we should replace the select with the depends.  In
>> fact I though I had done that a while ago, but I must have messed it up.
>
> Makes sense. I ran into the same problem on NVME_TARGET_RDMA now,
> which otherwise needs dependencies on both CONFIG_BLOCK and
> CONFIGFS_FS:
>
>      warning: (NVME_TARGET_LOOP && NVME_TARGET_RDMA) selects NVME_TARGET which has unmet direct dependencies (BLOCK && CONFIGFS_FS)
>      0xA002B368 Mon Jul 11 18:00:45 CEST 2016 failed
>      In file included from ../drivers/nvme/target/core.c:16:0:
>      drivers/nvme/target/nvmet.h:222:14: error: field 'inline_bio' has incomplete type
>        struct bio  inline_bio;
>                    ^~~~~~~~~~
>      drivers/nvme/target/core.c: In function 'nvmet_async_event_work':
>      drivers/nvme/target/core.c:98:3: error: implicit declaration of function 'kfree' [-Werror=implicit-function-declaration]
>         kfree(aen);
>         ^~~~~
>      ../drivers/nvme/target/core.c: In function 'nvmet_ns_enable':
>      ../drivers/nvme/target/core.c:269:13: error: implicit declaration of function 'blkdev_get_by_path' [-Werror=implicit-function-declaration]
>        ns->bdev = blkdev_get_by_path(ns->device_path, FMODE_READ | FMODE_WRITE,
>
> Folding in my patch below should address that too.

I folded this in.

-- 
Jens Axboe

From: wenbo.wang@memblaze.com (Wenbo Wang)
Date: Tue, 2 Feb 2016 02:41:53 +0000
Subject: [PATCH 1/2] NVMe: Make surprise removal work again
In-Reply-To: <20160202011752.GB4679@localhost.localdomain>
References: <1453757017-13640-1-git-send-email-keith.busch@intel.com>
 <BJXPR01MB199DDC40C3949335FD70DEBE0DE0@BJXPR01MB199.CHNPR01.prod.partner.outlook.cn>
 <B58D82457FDA0744A320A2FC5AC253B93D3D7E57@fmsmsx104.amr.corp.intel.com>
 <20160202011752.GB4679@localhost.localdomain>
Message-ID: <BJXPR01MB199DD66107F6C2D86BB3F83E0DF0@BJXPR01MB199.CHNPR01.prod.partner.outlook.cn>

Is it confirmed that blk_cleanup_queue has returned? It is likely the driver stuck in del_gendisk.

-----Original Message-----
From: Keith Busch [mailto:keith.busch@intel.com] 
Sent: Tuesday, February 2, 2016 9:18 AM
To: Wenbo Wang; linux-nvme at lists.infradead.org; Jens Axboe
Cc: Christoph Hellwig
Subject: Re: [PATCH 1/2] NVMe: Make surprise removal work again

On Mon, Feb 01, 2016@07:27:23AM -0800, Busch, Keith wrote:
> the direction I was given was to move the request ending to the block 
> layer when we kill it, so this won't be necessary in the next revision 
> (will be sent out today).

After merging and moving io ending to the block layer, something appears broken. Not sure what's going on, so just posting here in case there's better ideas.

The test runs buffered writes to an nvme drive (ex: dd if=/dev/zero
of=/dev/nvme0n1 bs=16M), then yank the drive when that ramps up.

Device removal completes after a few seconds, and /dev/nvme0n1 is no longer present. However, the 'dd' task never completes, with kernel stack trace:

[<ffffffff81093fb0>] __mod_timer+0xd4/0xe6 [<ffffffff810939bf>] process_timeout+0x0/0xc [<ffffffff810fcad7>] balance_dirty_pages_ratelimited+0x8b1/0xa05
[<ffffffff8116a2a3>] __set_page_dirty.constprop.61+0x81/0x9f
[<ffffffff810f3457>] generic_perform_write+0x15a/0x1d1 [<ffffffff81157095>] generic_update_time+0x9f/0xaa [<ffffffff810f4965>] __generic_file_write_iter+0xea/0x146
[<ffffffff8116d2a3>] blkdev_write_iter+0x78/0xf5 [<ffffffff811429b4>] __vfs_write+0x83/0xab [<ffffffff81143cda>] vfs_write+0x87/0xdd [<ffffffff81143ed7>] SyS_write+0x56/0x8a [<ffffffff81472657>] entry_SYSCALL_64_fastpath+0x12/0x6a
[<ffffffffffffffff>] 0xffffffffffffffff

If driver ends all IO's it knows about and blk_cleanup_queue returns, then the driver did it's part as far as I know. Not sure how to get this to end with the expected IO error, but I'm pretty sure this used to work.

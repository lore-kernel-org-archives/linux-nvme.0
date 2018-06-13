From: jitendra.bhivare@broadcom.com (Jitendra Bhivare)
Date: Wed, 13 Jun 2018 16:11:56 +0530
Subject: Read request exceeding max_hw_sectors_kb
Message-ID: <0ba3cccb9d2ee7cba50a91bfc92b373a@mail.gmail.com>

Hi Christoph, Daniel,

On my NVMf setup using SPDK, MDTS gets configured to 4 for a target
subsystem.
This sets max_hw_sector_kb to 64KB for a remotely attached NS block device
on the initiator.
The NS is exported from Intel NVMe 750 SSD connected to target which has a
quirk of NVME_QUIRK_STRIPE_SIZE.
So SPDK is filling up noiob to 256 as per vendor specific controller data
vs[3] = 5. The corresponding NS on initiator
gets chunk_sectors configured to 256 (128KB) though max_hw_sectors_kb is
64KB.

This is causing an issue in block layer submitting a readahead request
exceeding max transfer size which SPDK fails causing
nvme-rdma controller recovery. Call trace when request gets submitted has
been pasted below.

The path which allows the request to go through is
blk_mq_make_request -> blk_queue_split -> blk_bio_segment_split ->
get_max_io_size.

Though target is sending chunk size greater than mdts, shouldn't nvme-core
set chunk_sectors appropriately?
In this case, the block layer too, didn't seem to honor the
max_hw_sectors_kb.

So something like resolves the issue:
static void nvme_set_chunk_size(struct nvme_ns *ns)
{
	u32 chunk_size = (((u32)ns->noiob) << (ns->lba_shift - 9));

	chunk_size = rounddown_pow_of_two(chunk_size);
	chunk_size = min(ns->ctrl->max_hw_sectors, chunk_size);
	blk_queue_chunk_sectors(ns->queue,
rounddown_pow_of_two(chunk_size));
}

Please do let me know if this is the right approach or SPDK should set
noiob appropriately.

Thanks,

JB

[ 1798.507808] nvme nvme2: JB: ctrl ffff880220f942c0 max_hw_sectors 128
max_segments 17 page_size 4096
[ 1798.512752] CPU: 8 PID: 5749 Comm: systemd-udevd Tainted: G O 4.14.44
#2
[ 1798.512753] Hardware name: Dell Inc. PowerEdge T620/0658N7, BIOS 2.5.4
01/22/2016
[ 1798.512754] Call Trace:
[ 1798.512761] dump_stack+0x63/0x87
[ 1798.512766] nvme_rdma_queue_rq+0x5ee/0x670 [nvme_rdma]
[ 1798.512769] __blk_mq_try_issue_directly+0xde/0x140
[ 1798.512771] blk_mq_try_issue_directly+0x6f/0x80
[ 1798.512773] ? blk_account_io_start+0xf4/0x190
[ 1798.512774] blk_mq_make_request+0x32a/0x5f0
[ 1798.512776] generic_make_request+0x122/0x2f0
[ 1798.512777] submit_bio+0x73/0x150
[ 1798.512778] ? submit_bio+0x73/0x150
[ 1798.512781] ? guard_bio_eod+0x2c/0x100
[ 1798.512783] mpage_readpages+0x1aa/0x1f0
[ 1798.512784] ? I_BDEV+0x20/0x20
[ 1798.512787] ? alloc_pages_current+0x6a/0xe0
[ 1798.512788] blkdev_readpages+0x1d/0x20
[ 1798.512791] __do_page_cache_readahead+0x1be/0x2c0
[ 1798.512793] force_page_cache_readahead+0xb8/0x110
[ 1798.512794] ? force_page_cache_readahead+0xb8/0x110
[ 1798.512795] page_cache_sync_readahead+0x3f/0x50
[ 1798.512798] generic_file_read_iter+0x7eb/0xbb0
[ 1798.512800] ? page_cache_tree_insert+0xb0/0xb0
[ 1798.512801] blkdev_read_iter+0x35/0x40
[ 1798.512804] __vfs_read+0xf9/0x170
[ 1798.512806] vfs_read+0x93/0x130
[ 1798.512807] SyS_read+0x55/0xc0
[ 1798.512810] do_syscall_64+0x73/0x130
[ 1798.512813] entry_SYSCALL_64_after_hwframe+0x3d/0xa2
[ 1798.512814] RIP: 0033:0x7f59a6260500
[ 1798.512815] RSP: 002b:00007ffe79114e58 EFLAGS: 00000246 ORIG_RAX:
0000000000000000
[ 1798.512817] RAX: ffffffffffffffda RBX: 000056152f7e88c0 RCX:
00007f59a6260500
[ 1798.512818] RDX: 0000000000040000 RSI: 000056152f7e88e8 RDI:
000000000000000f
[ 1798.512819] RBP: 000056152f7966b0 R08: 000056152f7e88c0 R09:
0000000000000000
[ 1798.512819] R10: 0000000000000000 R11: 0000000000000246 R12:
0000000000040000
[ 1798.512820] R13: 0000000000000000 R14: 000056152f796700 R15:
000056152f7e88d8
[ 1798.512824] nvme nvme2: JB: nvme_rdma_queue_rq: rq ffff88021da00000 op
0 data len 0x11000

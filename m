From: maxg@mellanox.com (Max Gurtovoy)
Date: Sat, 8 Jul 2017 21:14:26 +0300
Subject: I/O Errors due to keepalive timeouts with NVMf RDMA
In-Reply-To: <20170707094838.GD16648@linux-x5ow.site>
References: <20170707094838.GD16648@linux-x5ow.site>
Message-ID: <4f2962b4-b099-276c-b3da-32c8fa63adcf@mellanox.com>



On 7/7/2017 12:48 PM, Johannes Thumshirn wrote:
> Hi,

Hi Johannes,

>
> In my recent tests I'm facing I/O errors with nvme_rdma because of the
> keepalive timer expiring.
>
> This is easily reproducible on hfi1, but also on mlx4 with the follwing fio
> job:

I need more info to repro.
What is the backing store at the target ?
are you using RoCE or IB link layer ?
ConnectX-3 vs. ConnectX-3 B2B ?
what is the FW on both target and host ?
what is the KATO ?
can you increase it as a WA ?

>
> [global]
> direct=1
> rw=randrw
> ioengine=libaio
> size=16g
> norandommap
> time_based
> runtime=10m
> group_reporting
> bs=4k
> iodepth=128
> numjobs=88
>
> [NVMf-test]
> filename=/dev/nvme0n1
>
>
> This happens with libaio as well as psync as I/O engine (haven't checked
> others yet).
>
> here's the dmesg excerpt:
> nvme nvme0: failed nvme_keep_alive_end_io error=-5
> nvme nvme0: Reconnecting in 10 seconds...
> blk_update_request: 31 callbacks suppressed
> blk_update_request: I/O error, dev nvme0n1, sector 73391680
> blk_update_request: I/O error, dev nvme0n1, sector 52827640
> blk_update_request: I/O error, dev nvme0n1, sector 125050288
> blk_update_request: I/O error, dev nvme0n1, sector 32099608
> blk_update_request: I/O error, dev nvme0n1, sector 65805440
> blk_update_request: I/O error, dev nvme0n1, sector 120114368
> blk_update_request: I/O error, dev nvme0n1, sector 48812368
> nvme0n1: detected capacity change from 68719476736 to -67549595420313600
> blk_update_request: I/O error, dev nvme0n1, sector 0
> buffer_io_error: 23 callbacks suppressed
> Buffer I/O error on dev nvme0n1, logical block 0, async page read
> blk_update_request: I/O error, dev nvme0n1, sector 0
> Buffer I/O error on dev nvme0n1, logical block 0, async page read
> blk_update_request: I/O error, dev nvme0n1, sector 0
> Buffer I/O error on dev nvme0n1, logical block 0, async page read
> ldm_validate_partition_table(): Disk read failed.
> Buffer I/O error on dev nvme0n1, logical block 0, async page read
> Buffer I/O error on dev nvme0n1, logical block 0, async page read
> Buffer I/O error on dev nvme0n1, logical block 0, async page read
> Buffer I/O error on dev nvme0n1, logical block 0, async page read
> Buffer I/O error on dev nvme0n1, logical block 0, async page read
> Buffer I/O error on dev nvme0n1, logical block 3, async page read
> Buffer I/O error on dev nvme0n1, logical block 0, async page read
> nvme0n1: unable to read partition table
>
> I'm seeing this on stock v4.12 as well as on our backports.
>
> My current hypothesis is that I saturate the RDMA link so the keepalives have
> no chance to get to the target. Is there a way to priorize the admin queue
> somehow?
>
> Thanks,
> 	Johannes
>

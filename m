From: tom.leiming@gmail.com (Ming Lei)
Date: Tue, 5 Jun 2018 16:56:39 +0800
Subject: [BUG REPORT] reset_controller stress operation lead to kernel
 NULL pointer
In-Reply-To: <1952603032.5635954.1528044389779.JavaMail.zimbra@redhat.com>
References: <174598543.5605323.1527938722046.JavaMail.zimbra@redhat.com>
 <59cee541-f34e-8586-d9c6-f52baf4710be@grimberg.me>
 <825ff884-26d5-e05a-3375-e1a644722ad6@mellanox.com>
 <1952603032.5635954.1528044389779.JavaMail.zimbra@redhat.com>
Message-ID: <CACVXFVM4JAYd79EPMBNg_0NcMg+y2_6s+UcDBgt_8GsEXb-vWA@mail.gmail.com>

On Mon, Jun 4, 2018@12:46 AM, Yi Zhang <yi.zhang@redhat.com> wrote:
> Hi Max/Sagi
>
> Thanks for looking this issue.
> I just tried Isreal and Sagi's patch, the kernel NULL pointer cannot be reproduced any more.
> But the reset operation always hang with less than 100 times, then I found IO hang on Host side and "keep-alive timer expired" observed on target[2].
> I also found some other error log during my test[1].
>
> [1]
> [  245.229779] nvme nvme0: Removing ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery"
> [  245.238728] nvme nvme0: Property Set error: 7, offset 0x14
>
> [2]
> Target:
> [  647.523888] nvmet: creating controller 1 for subsystem testnqn for NQN nqn.2014-08.org.nvmexpress:uuid:58282b02-64ae-4155-bad5-e37183e148e9.
> --snip--
> [  715.975355] nvmet: creating controller 1 for subsystem testnqn for NQN nqn.2014-08.org.nvmexpress:uuid:58282b02-64ae-4155-bad5-e37183e148e9.
> [  731.214264] nvmet: ctrl 1 keep-alive timer (15 seconds) expired!
> [  731.222435] nvmet: ctrl 1 fatal error occurred!
>
> Host:
> [  245.219461] nvme nvme0: new ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery", addr 172.31.1.92:4420
> [  245.229779] nvme nvme0: Removing ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery"
> [  245.238728] nvme nvme0: Property Set error: 7, offset 0x14
> [  245.302714] nvme nvme0: creating 40 I/O queues.
> [  246.011104] nvme nvme0: new ctrl: NQN "testnqn", addr 172.31.1.92:4420
> [  252.159464] nvme nvme0: Property Set error: 7, offset 0x14
> [  252.204801] nvme nvme0: creating 40 I/O queues.
> [  255.005423] nvme nvme0: Property Set error: 7, offset 0x14
> --snip--
> [  426.191472] nvme nvme0: creating 40 I/O queues.
> [  428.994740] nvme nvme0: Property Set error: 7, offset 0x14
> [  429.042588] nvme nvme0: creating 40 I/O queues.
> [  615.682478] INFO: task kworker/u81:8:685 blocked for more than 120 seconds.
> [  615.690891]       Not tainted 4.17.0-rc7.Sagi+ #10
> [  615.696721] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [  615.706003] kworker/u81:8   D    0   685      2 0x80000000
> [  615.712675] Workqueue: writeback wb_workfn (flush-259:0)
> [  615.719150] Call Trace:
> [  615.722423]  ? __schedule+0x290/0x870
> [  615.727053]  schedule+0x32/0x80
> [  615.731092]  io_schedule+0x12/0x40
> [  615.735425]  blk_mq_get_tag+0x12e/0x260
> [  615.740240]  ? remove_wait_queue+0x60/0x60
> [  615.745343]  blk_mq_get_request+0xce/0x390
> [  615.750437]  ? __blk_mq_sched_bio_merge+0xec/0x190
> [  615.756311]  blk_mq_make_request+0x11c/0x560
> [  615.761608]  generic_make_request+0x18c/0x390
> [  615.766996]  submit_bio+0x6e/0x130
> [  615.771320]  ? guard_bio_eod+0x2c/0xa0
> [  615.776020]  submit_bh_wbc+0x157/0x190
> [  615.780727]  __block_write_full_page+0x14b/0x400
> [  615.786406]  __writepage+0x19/0x50
> [  615.790722]  write_cache_pages+0x222/0x470
> [  615.795803]  ? bdi_set_max_ratio+0x70/0x70
> [  615.800895]  generic_writepages+0x51/0x80
> [  615.805883]  ? __wake_up_common_lock+0x87/0xc0
> [  615.811356]  do_writepages+0x1a/0x70
> [  615.815849]  __writeback_single_inode+0x3d/0x340
> [  615.821508]  writeback_sb_inodes+0x24f/0x4b0
> [  615.826784]  __writeback_inodes_wb+0x87/0xb0
> [  615.832060]  wb_writeback+0x27c/0x310
> [  615.836651]  wb_workfn+0x306/0x450
> [  615.840952]  process_one_work+0x158/0x360
> [  615.845932]  worker_thread+0x47/0x3e0
> [  615.850517]  kthread+0xf8/0x130
> [  615.854518]  ? max_active_store+0x80/0x80
> [  615.859480]  ? kthread_bind+0x10/0x10
> [  615.864063]  ret_from_fork+0x35/0x40

This one seems one fixed blk-mq issue, and the following merged commit
might be helpful:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e6fc46498784e799d3eb95d83079180e413c4e7d


Thanks,
Ming Lei

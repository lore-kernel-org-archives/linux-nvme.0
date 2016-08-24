From: swise@opengridcomputing.com (Steve Wise)
Date: Wed, 24 Aug 2016 15:34:26 -0500
Subject: nvmf host shutdown hangs when nvmf controllers are in
 recovery/reconnect
In-Reply-To: <021d01d1fe45$af92ff60$0eb8fe20$@opengridcomputing.com>
References: <00de01d1fd4d$10e44700$32acd500$@opengridcomputing.com>
 <b93e8bc6-1fd1-3191-d811-1503cc2e4499@grimberg.me>
 <a004bd27-6efd-98aa-6430-da7aeafd46b0@grimberg.me>
 <021d01d1fe45$af92ff60$0eb8fe20$@opengridcomputing.com>
Message-ID: <022101d1fe46$e84a14f0$b8de3ed0$@opengridcomputing.com>

> > > Hey Steve,
> > >
> > > For some reason I can't reproduce this on my setup...
> > >
> > > So I'm wandering where is nvme_rdma_del_ctrl() thread stuck?
> > > Probably a dump of all the kworkers would be helpful here:
> > >
> > > $ pids=`ps -ef | grep kworker | grep -v grep | awk {'print $2'}`
> > > $ for p in $pids; do echo "$p:" ;cat /proc/$p/stack; done
> > >
> 
> I can't do this because the system is crippled due to shutting down.  I
> get the feeling though that the del_ctrl thread isn't getting scheduled.
> Note that the difference between 'reboot' and 'reboot -f' is that without
> the -f, iw_cxgb4 isn't unloaded before we get stuck.  So there has to be
> some part of 'reboot' that deletes the controllers for it to work.  But I
> still don't know what is stalling the reboot anyway.  Some I/O pending I
> guess?

According to the hung task detector, this is the only thread stuck:

[  861.638248] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this
message.
[  861.647826] vgs             D ffff880ff6e5b8e8     0  4849   4848 0x10000080
[  861.656702]  ffff880ff6e5b8e8 ffff8810381a15c0 ffff88103343ab80
ffff8810283a6f10
[  861.665829]  00000001e0941240 ffff880ff6e5b8b8 ffff880ff6e58008
ffff88103f059300
[  861.674882]  7fffffffffffffff 0000000000000000 0000000000000000
ffff880ff6e5b938
[  861.683819] Call Trace:
[  861.687677]  [<ffffffff816ddde0>] schedule+0x40/0xb0
[  861.694078]  [<ffffffff816e0a8d>] schedule_timeout+0x2ad/0x410
[  861.701279]  [<ffffffff8132d6d2>] ? blk_flush_plug_list+0x132/0x2e0
[  861.708924]  [<ffffffff810fe67c>] ? ktime_get+0x4c/0xc0
[  861.715452]  [<ffffffff8132c92c>] ? generic_make_request+0xfc/0x1d0
[  861.723060]  [<ffffffff816dd6c4>] io_schedule_timeout+0xa4/0x110
[  861.730319]  [<ffffffff81269cb9>] dio_await_one+0x99/0xe0
[  861.736951]  [<ffffffff8126d359>] do_blockdev_direct_IO+0x919/0xc00
[  861.744402]  [<ffffffff81267350>] ? I_BDEV+0x20/0x20
[  861.750569]  [<ffffffff81267350>] ? I_BDEV+0x20/0x20
[  861.756677]  [<ffffffff8115527b>] ? rb_reserve_next_event+0xdb/0x230
[  861.764155]  [<ffffffff811547ba>] ? rb_commit+0x10a/0x1a0
[  861.770642]  [<ffffffff8126d67a>] __blockdev_direct_IO+0x3a/0x40
[  861.777729]  [<ffffffff81267b83>] blkdev_direct_IO+0x43/0x50
[  861.784439]  [<ffffffff81199ef7>] generic_file_read_iter+0xf7/0x110
[  861.791727]  [<ffffffff81267657>] blkdev_read_iter+0x37/0x40
[  861.798404]  [<ffffffff8122b15c>] __vfs_read+0xfc/0x120
[  861.804624]  [<ffffffff8122b22e>] vfs_read+0xae/0xf0
[  861.810544]  [<ffffffff81249633>] ? __fdget+0x13/0x20
[  861.816539]  [<ffffffff8122bd36>] SyS_read+0x56/0xc0
[  861.822437]  [<ffffffff81003e7d>] do_syscall_64+0x7d/0x230
[  861.828863]  [<ffffffff8106f057>] ? do_page_fault+0x37/0x90
[  861.835313]  [<ffffffff816e1921>] entry_SYSCALL64_slow_path+0x25/0x25

From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 28 Mar 2017 14:37:38 +0300
Subject: [PATCH 0/3] Introduce fabrics controller loss timeout
In-Reply-To: <859829333.6134255.1490575296451.JavaMail.zimbra@redhat.com>
References: <1489876941-6401-1-git-send-email-sagi@grimberg.me>
 <859829333.6134255.1490575296451.JavaMail.zimbra@redhat.com>
Message-ID: <97faaf24-c95f-fa94-9ea7-7b91f3fc1291@grimberg.me>


> Hello Sagi
> With these three patches, the reconnecting stopped after 60 times.

Progress..

> I restart another test that do fio testing on nvme0n1[1] on client before executing "nvmetclt clear" on target side.
> After that, I found another issue that the fio jobs cannot be stopped even I tried "Ctrl + C", and the device node also cannot be released[2].
> Here is the kernel log[3].

Thanks for the new test case ;)

> [3]
> [  356.812399] nvme nvme0: Reconnecting in 10 seconds...
> [  366.965161] nvme nvme0: Connect rejected: status 8 (invalid service ID).
> [  367.002048] nvme nvme0: rdma_resolve_addr wait failed (-104).
> [  367.029926] nvme nvme0: Failed reconnect attempt 21
> [  367.051905] nvme nvme0: Reconnecting in 10 seconds...
> [  371.444001] INFO: task kworker/u130:1:155 blocked for more than 120 seconds.
> [  371.480773]       Not tainted 4.11.0-rc3.ctrl_tmo+ #1
> [  371.505608] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [  371.540918] kworker/u130:1  D    0   155      2 0x00000000
> [  371.565584] Workqueue: writeback wb_workfn (flush-259:0)
> [  371.590031] Call Trace:
> [  371.600981]  __schedule+0x289/0x8f0
> [  371.616644]  schedule+0x36/0x80
> [  371.630693]  io_schedule+0x16/0x40
> [  371.645565]  blk_mq_get_tag+0x16c/0x280
> [  371.662929]  ? remove_wait_queue+0x60/0x60
> [  371.680942]  __blk_mq_alloc_request+0x1b/0xe0
> [  371.700508]  blk_mq_sched_get_request+0x1a0/0x240
> [  371.721616]  blk_mq_make_request+0x113/0x620
> [  371.741215]  generic_make_request+0x110/0x2c0
> [  371.760755]  submit_bio+0x75/0x150

Looks like we have I/O waiting for a tag, but the
controller teardown couldn't interrupt and fail it...

In this specific case, its a writeback, also udevd is
stuck in the same location below...

I'm thinking we might need something similar to Keith
nvme_start_freeze/nvme_wait_freeze/nvme_unfreeze calls
for fabrics too.. :/

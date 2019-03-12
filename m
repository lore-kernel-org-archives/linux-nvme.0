From: yuyufen@huawei.com (yuyufen)
Date: Tue, 12 Mar 2019 09:50:58 +0800
Subject: v5.1-rc1: New NVMe warning triggered by nvme_delete_ctrl_work()
In-Reply-To: <1552344226.45180.104.camel@acm.org>
References: <1552344226.45180.104.camel@acm.org>
Message-ID: <a20111ff-d1d2-b1ca-0898-c5956f6f8319@huawei.com>

Hi


On 2019/3/12 6:43, Bart Van Assche wrote:
> Hello,
>
> If I run the nvme tests from blktests against Linus' current master then
> the following warning appears:
>
> WARNING: CPU: 5 PID: 98 at kernel/workqueue.c:3030 __flush_work+0x423/0x430
> CPU: 5 PID: 98 Comm: kworker/u12:2 Not tainted 5.0.0-dbg+ #1
> Workqueue: nvme-delete-wq nvme_delete_ctrl_work
> RIP: 0010:__flush_work+0x423/0x430
> Call Trace:
>   __cancel_work_timer+0x200/0x2b0
>   cancel_work_sync+0x10/0x20
>   nvmet_ctrl_free+0x217/0x330 [nvmet]
>   nvmet_sq_destroy+0xc1/0x290 [nvmet]
>   nvme_loop_destroy_admin_queue+0x29/0x50 [nvme_loop]
>   nvme_loop_shutdown_ctrl+0xb2/0xd0 [nvme_loop]
>   nvme_loop_delete_ctrl_host+0x15/0x20 [nvme_loop]
>   nvme_do_delete_ctrl+0x97/0xcd
>   nvme_delete_ctrl_work+0x15/0x17
>   process_one_work+0x4f1/0xa40
>   worker_thread+0x67/0x5b0
>   kthread+0x1cf/0x1f0
>   ret_from_fork+0x24/0x30
>
> I think this is a result of commit 4d43d395fed1 ("workqueue: Try to
> catch flush_work() without INIT_WORK()").

You are right. It is caused by commit 4d43d395fed1.
And I am trying to fix it.
http://lists.infradead.org/pipermail/linux-nvme/2019-March/022690.html

> Bart.
>
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
>
>

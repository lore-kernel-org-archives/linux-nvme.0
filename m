From: sagi@grimberg.me (Sagi Grimberg)
Date: Fri, 7 Dec 2018 12:05:37 -0800
Subject: [PATCH] nvme-rdma: complete requests from ->timeout
In-Reply-To: <CAJX3CthC6KxH7ZtpSzEGGQTVUgKO6UVkjiMMBV6=OG__UVF43Q@mail.gmail.com>
References: <1543535954-28073-1-git-send-email-jalee@purestorage.com>
 <cc7cbad6-0e7d-8328-c602-61d659c3a7de@grimberg.me>
 <CAJX3CtiBs6YOjkP5xGb5yPShvOdmhuD7kx-kBAVL7+YsyEGMyw@mail.gmail.com>
 <CAJX3CthC6KxH7ZtpSzEGGQTVUgKO6UVkjiMMBV6=OG__UVF43Q@mail.gmail.com>
Message-ID: <2055d5b5-2c27-b5a2-e3a0-75146c7bd227@grimberg.me>


> Could you please take a look at this bug and code review?
> 
> We are seeing more instances of this bug and found that reconnect_work
> could hang as well, as can be seen from below stacktrace.
> 
>   Workqueue: nvme-wq nvme_rdma_reconnect_ctrl_work [nvme_rdma]
>   Call Trace:
>   __schedule+0x2ab/0x880
>   schedule+0x36/0x80
>   schedule_timeout+0x161/0x300
>   ? __next_timer_interrupt+0xe0/0xe0
>   io_schedule_timeout+0x1e/0x50
>   wait_for_completion_io_timeout+0x130/0x1a0
>   ? wake_up_q+0x80/0x80
>   blk_execute_rq+0x6e/0xa0
>   __nvme_submit_sync_cmd+0x6e/0xe0
>   nvmf_connect_admin_queue+0x128/0x190 [nvme_fabrics]
>   ? wait_for_completion_interruptible_timeout+0x157/0x1b0
>   nvme_rdma_start_queue+0x5e/0x90 [nvme_rdma]
>   nvme_rdma_setup_ctrl+0x1b4/0x730 [nvme_rdma]
>   nvme_rdma_reconnect_ctrl_work+0x27/0x70 [nvme_rdma]
>   process_one_work+0x179/0x390
>   worker_thread+0x4f/0x3e0
>   kthread+0x105/0x140
>   ? max_active_store+0x80/0x80
>   ? kthread_bind+0x20/0x20
> 
> This bug is produced by setting MTU of RoCE interface to '568' for
> test while running I/O traffics.

I think that with the latest changes from Keith we can no longer rely
on blk-mq to barrier racing completions. We will probably need
to barrier ourselves in nvme-rdma...

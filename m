From: jalee@purestorage.com (Jaesoo Lee)
Date: Fri, 7 Dec 2018 22:28:36 -0800
Subject: [PATCH] nvme-rdma: complete requests from ->timeout
In-Reply-To: <20181208020201.GD21523@localhost.localdomain>
References: <1543535954-28073-1-git-send-email-jalee@purestorage.com>
 <cc7cbad6-0e7d-8328-c602-61d659c3a7de@grimberg.me>
 <CAJX3CtiBs6YOjkP5xGb5yPShvOdmhuD7kx-kBAVL7+YsyEGMyw@mail.gmail.com>
 <CAJX3CthC6KxH7ZtpSzEGGQTVUgKO6UVkjiMMBV6=OG__UVF43Q@mail.gmail.com>
 <2055d5b5-2c27-b5a2-e3a0-75146c7bd227@grimberg.me>
 <20181208020201.GD21523@localhost.localdomain>
Message-ID: <CAJX3CthF7zbxwke7GY5ghZqj=WeNXQM+gKvzdU+7wzmsYcz+eQ@mail.gmail.com>

Now, I see that my patch is not safe and can cause double completions.
However, I am having a hard time finding out a good solution to
barrier the racing completions.

Could you suggest where the fix should go and what should it look
like? We can provide more details on reproducing this issue if that
helps.

On Fri, Dec 7, 2018@6:04 PM Keith Busch <keith.busch@intel.com> wrote:
>
> On Fri, Dec 07, 2018@12:05:37PM -0800, Sagi Grimberg wrote:
> >
> > > Could you please take a look at this bug and code review?
> > >
> > > We are seeing more instances of this bug and found that reconnect_work
> > > could hang as well, as can be seen from below stacktrace.
> > >
> > >   Workqueue: nvme-wq nvme_rdma_reconnect_ctrl_work [nvme_rdma]
> > >   Call Trace:
> > >   __schedule+0x2ab/0x880
> > >   schedule+0x36/0x80
> > >   schedule_timeout+0x161/0x300
> > >   ? __next_timer_interrupt+0xe0/0xe0
> > >   io_schedule_timeout+0x1e/0x50
> > >   wait_for_completion_io_timeout+0x130/0x1a0
> > >   ? wake_up_q+0x80/0x80
> > >   blk_execute_rq+0x6e/0xa0
> > >   __nvme_submit_sync_cmd+0x6e/0xe0
> > >   nvmf_connect_admin_queue+0x128/0x190 [nvme_fabrics]
> > >   ? wait_for_completion_interruptible_timeout+0x157/0x1b0
> > >   nvme_rdma_start_queue+0x5e/0x90 [nvme_rdma]
> > >   nvme_rdma_setup_ctrl+0x1b4/0x730 [nvme_rdma]
> > >   nvme_rdma_reconnect_ctrl_work+0x27/0x70 [nvme_rdma]
> > >   process_one_work+0x179/0x390
> > >   worker_thread+0x4f/0x3e0
> > >   kthread+0x105/0x140
> > >   ? max_active_store+0x80/0x80
> > >   ? kthread_bind+0x20/0x20
> > >
> > > This bug is produced by setting MTU of RoCE interface to '568' for
> > > test while running I/O traffics.
> >
> > I think that with the latest changes from Keith we can no longer rely
> > on blk-mq to barrier racing completions. We will probably need
> > to barrier ourselves in nvme-rdma...
>
> You really need to do that anyway. If you were relying on blk-mq to save
> you from double completions by ending a request in the nvme driver while
> the lower half can still complete the same one, the only thing preventing
> data corruption is the probability the request wasn't reallocated for a
> new command.

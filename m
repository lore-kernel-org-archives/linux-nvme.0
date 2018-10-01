From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 1 Oct 2018 13:12:59 -0700
Subject: [PATCH RFC] nvmet-rdma: use a private workqueue for delete
In-Reply-To: <1538172846.53591.8.camel@acm.org>
References: <20180927180031.10706-1-sagi@grimberg.me>
 <1538172846.53591.8.camel@acm.org>
Message-ID: <d6b9397c-2817-535d-f794-74dc01d8f601@grimberg.me>


>> Queue deletion is done asynchronous when the last reference on
>> the queue is dropped. Thus, in order to make sure we don't over
>> allocate under a connect/disconnect storm, we let queue deletion
>> complete before making forward progress.
>>
>> However, given that we flush the system_wq from rdma_cm context
>> which runs from a workqueue context, we can have a circular
>> locking complaint [1]. Fix that by using a private workqueue for
>> queue deletion.
> 
> Hi Sagi,
> 
> Thanks for this patch. With this patch applied the warning I reported
> earlier disappears but a new warning appeared:

Thanks for testing, this is a similar complaint though...

What I'm missing here is why flushing a work that runs on workqueue A
can't be done from a work that runs on workqueue B. It is
guaranteed that the id_priv that is used as a barrier from
rdma_destroy_id is different from the id_priv that is handling the
connect. So I'm not clear on what is the dependency yet.

Any insights?

> 
> ======================================================
> WARNING: possible circular locking dependency detected
> 4.19.0-rc5-dbg+ #8 Not tainted
> ------------------------------------------------------
> kworker/u24:7/977 is trying to acquire lock:
> 000000003dc8471f (&id_priv->handler_mutex){+.+.}, at: rdma_destroy_id+0x6f/0x440 [rdma_cm]
> 
> but task is already holding lock:
> 0000000086ca5cb1 ((work_completion)(&queue->release_work)){+.+.}, at: process_one_work+0x3ed/0xa20
> 
> which lock already depends on the new lock.
> 
> 
> the existing dependency chain (in reverse order) is:
> 
> -> #3 ((work_completion)(&queue->release_work)){+.+.}:
>         process_one_work+0x474/0xa20
>         worker_thread+0x63/0x5a0
>         kthread+0x1cf/0x1f0
>         ret_from_fork+0x24/0x30
> 
> -> #2 ((wq_completion)"nvmet-rdma-delete-wq"){+.+.}:
>         flush_workqueue+0xf3/0x970
>         nvmet_rdma_cm_handler+0x1319/0x170f [nvmet_rdma]
>         cma_ib_req_handler+0x72f/0xf90 [rdma_cm]
>         cm_process_work+0x2e/0x110 [ib_cm]
>         cm_req_handler+0x135b/0x1c30 [ib_cm]
>         cm_work_handler+0x2b7/0x38cd [ib_cm]
>         process_one_work+0x4ae/0xa20
>         worker_thread+0x63/0x5a0
>         kthread+0x1cf/0x1f0
>         ret_from_fork+0x24/0x30
> 
> -> #1 (&id_priv->handler_mutex/1){+.+.}:
>         __mutex_lock+0xfe/0xbe0
>         mutex_lock_nested+0x1b/0x20
>         cma_ib_req_handler+0x6aa/0xf90 [rdma_cm]
>         cm_process_work+0x2e/0x110 [ib_cm]
>         cm_req_handler+0x135b/0x1c30 [ib_cm]
>         cm_work_handler+0x2b7/0x38cd [ib_cm]
>         process_one_work+0x4ae/0xa20
>         worker_thread+0x63/0x5a0
>         kthread+0x1cf/0x1f0
>         ret_from_fork+0x24/0x30
> 
> -> #0 (&id_priv->handler_mutex){+.+.}:
>         lock_acquire+0xc5/0x200
>         __mutex_lock+0xfe/0xbe0
>         mutex_lock_nested+0x1b/0x20
>         rdma_destroy_id+0x6f/0x440 [rdma_cm]
>         nvmet_rdma_release_queue_work+0x8e/0x1b0 [nvmet_rdma]
>         process_one_work+0x4ae/0xa20
>         worker_thread+0x63/0x5a0
>         kthread+0x1cf/0x1f0
>         ret_from_fork+0x24/0x30
> 
> other info that might help us debug this:
> 
> Chain exists of:
>    &id_priv->handler_mutex --> (wq_completion)"nvmet-rdma-delete-wq" --> (work_completion)(&queue->release_work)
> 
>   Possible unsafe locking scenario:
> 
>         CPU0                    CPU1
>         ----                    ----
>    lock((work_completion)(&queue->release_work));
>                                 lock((wq_completion)"nvmet-rdma-delete-wq");
>                                 lock((work_completion)(&queue->release_work));
>    lock(&id_priv->handler_mutex);
> 
>   *** DEADLOCK ***
> 
> 2 locks held by kworker/u24:7/977:
>   #0: 00000000148450ab ((wq_completion)"nvmet-rdma-delete-wq"){+.+.}, at: process_one_work+0x3ed/0xa20
>   #1: 0000000086ca5cb1 ((work_completion)(&queue->release_work)){+.+.}, at: process_one_work+0x3ed/0xa20
> 
> stack backtrace:
> CPU: 1 PID: 977 Comm: kworker/u24:7 Not tainted 4.19.0-rc5-dbg+ #8
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
> Workqueue: nvmet-rdma-delete-wq nvmet_rdma_release_queue_work [nvmet_rdma]
> Call Trace:
>   dump_stack+0x86/0xc5
>   print_circular_bug.isra.32+0x20a/0x218
>   __lock_acquire+0x1a54/0x1b20
>   lock_acquire+0xc5/0x200
>   __mutex_lock+0xfe/0xbe0
>   mutex_lock_nested+0x1b/0x20
>   rdma_destroy_id+0x6f/0x440 [rdma_cm]
>   nvmet_rdma_release_queue_work+0x8e/0x1b0 [nvmet_rdma]
>   process_one_work+0x4ae/0xa20
>   worker_thread+0x63/0x5a0
>   kthread+0x1cf/0x1f0
>   ret_from_fork+0x24/0x30
> 

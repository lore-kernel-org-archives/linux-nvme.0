From: shahar.salzman@gmail.com (shahar.salzman)
Date: Thu, 18 May 2017 08:52:15 +0300
Subject: NVMeoF: multipath stuck after bringing one ethernet port down
In-Reply-To: <ebb7ffb8-4dec-5540-5cef-ffd36bef3e25@grimberg.me>
References: <CAK0KL7DPLw+0AB8cGop7jowfE1HV9wyXBmJhE90trpor-PcSYw@mail.gmail.com>
 <ebb7ffb8-4dec-5540-5cef-ffd36bef3e25@grimberg.me>
Message-ID: <fa6277fa-948f-103e-1322-f8b2362467c3@gmail.com>

I have seen this too, but was internally investigating it as I am 
running 4.9.6 and not upstream. I will be able to check this patch on 
Sunday/Monday.

On my setup the IOs never complete even after the path is reconnected, 
and the process remains stuck in D state, and the path unusable until I 
power cycle the server.

Some more information, hope it helps:

Dumping the stuck process stack (multipath -ll):

[root at kblock01-knode02 ~]# cat /proc/9715/stack
[<ffffffff94354727>] blk_execute_rq+0x97/0x110
[<ffffffffc0a72f8a>] __nvme_submit_user_cmd+0xca/0x300 [nvme_core]
[<ffffffffc0a73369>] nvme_submit_user_cmd+0x29/0x30 [nvme_core]
[<ffffffffc0a734bd>] nvme_user_cmd+0x14d/0x180 [nvme_core]
[<ffffffffc0a7376c>] nvme_ioctl+0x7c/0xa0 [nvme_core]
[<ffffffff9435d548>] __blkdev_driver_ioctl+0x28/0x30
[<ffffffff9435dce1>] blkdev_ioctl+0x131/0x8f0
[<ffffffff9428993c>] block_ioctl+0x3c/0x40
[<ffffffff94260ae8>] vfs_ioctl+0x18/0x30
[<ffffffff94261201>] do_vfs_ioctl+0x161/0x600
[<ffffffff94261732>] SyS_ioctl+0x92/0xa0
[<ffffffff9479cc77>] entry_SYSCALL_64_fastpath+0x1a/0xa9
[<ffffffffffffffff>] 0xffffffffffffffff

Looking at the dissasembly:

0000000000000170 <blk_execute_rq>:

...

  1fa:   e8 00 00 00 00          callq  1ff <blk_execute_rq+0x8f>
         /* Prevent hang_check timer from firing at us during very long 
I/O */
         hang_check = sysctl_hung_task_timeout_secs;
         if (hang_check)
                 while (!wait_for_completion_io_timeout(&wait, 
hang_check * (HZ/2)));
         else
                 wait_for_completion_io(&wait);
  1ff:   4c 89 e7                mov    %r12,%rdi
  202:   e8 00 00 00 00          callq  207 <blk_execute_rq+0x97>

         if (rq->errors)
  207:   83 bb 04 01 00 00 01    cmpl   $0x1,0x104(%rbx)

I ran btrace, and it seems that the IO running before the path 
disconnect is properly cleaned, and only the IO running after gets stuck 
(in the btrace example bellow I run both multipath -ll, and a dd):

259,2   15    27548     4.790727567  8527  I  RS 764837376 + 8 [fio]
259,2   15    27549     4.790728103  8527  D  RS 764837376 + 8 [fio]
259,2   15    27550     4.791244566  8527  A   R 738007008 + 8 <- 
(253,0) 738007008
259,2   15    27551     4.791245136  8527  I  RS 738007008 + 8 [fio]
259,2   15    27552     4.791245803  8527  D  RS 738007008 + 8 [fio]
<<<<< From this stage there are no more fio Queue requests, only completions
259,2    8     9118     4.758116423  8062  C  RS 2294539440 + 8 [0]
259,2    8     9119     4.758559461  8062  C  RS 160307464 + 8 [0]
259,2    8     9120     4.759009990     0  C  RS 2330623512 + 8 [0]
259,2    8     9121     4.759457400     0  C  RS 2657710096 + 8 [0]
259,2    8     9122     4.759928113     0  C  RS 2988256176 + 8 [0]
259,2    8     9123     4.760388009     0  C  RS 789190936 + 8 [0]
259,2    8     9124     4.760835889     0  C  RS 2915035352 + 8 [0]
259,2    8     9125     4.761304282     0  C  RS 2458313624 + 8 [0]
259,2    8     9126     4.761779694     0  C  RS 2280411456 + 8 [0]
259,2    8     9127     4.762286741     0  C  RS 2082207376 + 8 [0]
259,2    8     9128     4.762783722     0  C  RS 2874601688 + 8 [0]
....
259,2    8     9173     4.785798485     0  C  RS 828737568 + 8 [0]
259,2    8     9174     4.786301391     0  C  RS 229168888 + 8 [0]
259,2    8     9175     4.786769105     0  C  RS 893604096 + 8 [0]
259,2    8     9176     4.787270594     0  C  RS 2308778728 + 8 [0]
259,2    8     9177     4.787797448     0  C  RS 2190029912 + 8 [0]
259,2    8     9178     4.788298956     0  C  RS 2652012944 + 8 [0]
259,2    8     9179     4.788803759     0  C  RS 2205242008 + 8 [0]
259,2    8     9180     4.789309423     0  C  RS 1948528416 + 8 [0]
259,2    8     9181     4.789831240     0  C  RS 2003421288 + 8 [0]
259,2    8     9182     4.790343528     0  C  RS 2464964728 + 8 [0]
259,2    8     9183     4.790854684     0  C  RS 764837376 + 8 [0]
<<<<<< This is probably where the port had been disconnected
259,2   21        7     9.413088410  8574  Q   R 0 + 8 [multipathd]
259,2   21        8     9.413089387  8574  G   R 0 + 8 [multipathd]
259,2   21        9     9.413095030  8574  U   N [multipathd] 1
259,2   21       10     9.413095367  8574  I  RS 0 + 8 [multipathd]
259,2   21       11     9.413096534  8574  D  RS 0 + 8 [multipathd]
259,2   10        1    14.381330190  2016  C  RS 738007008 + 8 [7]
259,2   21       12    14.381394890     0  R  RS 0 + 8 [7]
259,2    8     9184    80.500537429  8657  Q   R 0 + 8 [dd]
259,2    8     9185    80.500540122  8657  G   R 0 + 8 [dd]
259,2    8     9186    80.500545289  8657  U   N [dd] 1
259,2    8     9187    80.500545792  8657  I  RS 0 + 8 [dd]
<<<<<< At this stage, I reconnected the path:
259,2    4        1  8381.791090134 11127  Q   R 0 + 8 [dd]
259,2    4        2  8381.791093611 11127  G   R 0 + 8 [dd]
259,2    4        3  8381.791098288 11127  U   N [dd] 1
259,2    4        4  8381.791098791 11127  I  RS 0 + 8 [dd]


As I wrote above, I will check the patch on Sunday/Monday.

On 05/17/2017 08:28 PM, Sagi Grimberg wrote:
> Hi Alex,
>
>> I am trying to test failure scenarios of NVMeoF + multipath. I bring
>> one of ports down and expect to see failed paths using "multipath
>> -ll". Instead I see that "multipath -ll" get stuck.
>>
>> reproduce:
>> 1. Connected to NVMeoF device through 2 ports.
>> 2. Bind them with multipath.
>> 3. Bring one port down (ifconfig eth3 down)
>> 4. Execute "multipath -ll" command and it will get stuck.
>> From strace I see that multipath is stuck in io_destroy() during
>> release of resources. As I understand io_destroy is stuck because of
>> io_cancel() that failed. And io_cancel() failed because of port that
>> was disabled in step 3.
>
> Hmm, it looks like we do take care of failing fast pending IO, but once
> we schedule periodic reconnects the request queues are already stopped
> and new incoming requests may block until we successfully reconnect.
>
> I don't have too much time for it at the moment, but here is an untested
> patch for you to try out:
>
> -- 
> [PATCH] nvme-rdma: restart queues after we at error recovery to fast
>  fail incoming io
>
> When we encounter an transport/controller errors, error recovery
> kicks in which performs:
> 1. stops io/admin queues
> 2. moves transport queues out of LIVE state
> 3. fast fail pending io
> 4. schedule periodic reconnects.
>
> But we also need to fast fail incoming IO taht enters after we
> already scheduled. Given that our queue is not LIVE anymore, simply
> restart the request queues to fail in .queue_rq
>
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> ---
>  drivers/nvme/host/rdma.c | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index dd1c6deef82f..a0aa2bfb91ee 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -753,28 +753,26 @@ static void nvme_rdma_reconnect_ctrl_work(struct 
> work_struct *work)
>         if (ret)
>                 goto requeue;
>
> -       blk_mq_start_stopped_hw_queues(ctrl->ctrl.admin_q, true);
> -
>         ret = nvmf_connect_admin_queue(&ctrl->ctrl);
>         if (ret)
> -               goto stop_admin_q;
> +               goto requeue;
>
>         set_bit(NVME_RDMA_Q_LIVE, &ctrl->queues[0].flags);
>
>         ret = nvme_enable_ctrl(&ctrl->ctrl, ctrl->cap);
>         if (ret)
> -               goto stop_admin_q;
> +               goto requeue;
>
>         nvme_start_keep_alive(&ctrl->ctrl);
>
>         if (ctrl->queue_count > 1) {
>                 ret = nvme_rdma_init_io_queues(ctrl);
>                 if (ret)
> -                       goto stop_admin_q;
> +                       goto requeue;
>
>                 ret = nvme_rdma_connect_io_queues(ctrl);
>                 if (ret)
> -                       goto stop_admin_q;
> +                       goto requeue;
>         }
>
>         changed = nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_LIVE);
> @@ -782,7 +780,6 @@ static void nvme_rdma_reconnect_ctrl_work(struct 
> work_struct *work)
>         ctrl->ctrl.opts->nr_reconnects = 0;
>
>         if (ctrl->queue_count > 1) {
> -               nvme_start_queues(&ctrl->ctrl);
>                 nvme_queue_scan(&ctrl->ctrl);
>                 nvme_queue_async_events(&ctrl->ctrl);
>         }
> @@ -791,8 +788,6 @@ static void nvme_rdma_reconnect_ctrl_work(struct 
> work_struct *work)
>
>         return;
>
> -stop_admin_q:
> -       blk_mq_stop_hw_queues(ctrl->ctrl.admin_q);
>  requeue:
>         dev_info(ctrl->ctrl.device, "Failed reconnect attempt %d\n",
>                         ctrl->ctrl.opts->nr_reconnects);
> @@ -823,6 +818,13 @@ static void nvme_rdma_error_recovery_work(struct 
> work_struct *work)
>         blk_mq_tagset_busy_iter(&ctrl->admin_tag_set,
>                                 nvme_cancel_request, &ctrl->ctrl);
>
> +       /*
> +        * queues are not a live anymore, so restart the queues to 
> fail fast
> +        * new IO
> +        */
> +       blk_mq_start_stopped_hw_queues(ctrl->ctrl.admin_q, true);
> +       nvme_start_queues(&ctrl->ctrl);
> +
>         nvme_rdma_reconnect_or_remove(ctrl);
>  }
>
> -- 
>
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme

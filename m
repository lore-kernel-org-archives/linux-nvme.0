From: swise@opengridcomputing.com (Steve Wise)
Date: Thu, 8 Sep 2016 16:37:28 -0500
Subject: nvmf/rdma host crash during heavy load and keep alive recovery
In-Reply-To: <021401d20a16$ed60d470$c8227d50$@opengridcomputing.com>
References: <018301d1e9e1$da3b2e40$8eb18ac0$@opengridcomputing.com>
 <010f01d1f31e$50c8cb40$f25a61c0$@opengridcomputing.com>
 <013701d1f320$57b185d0$07149170$@opengridcomputing.com>
 <018401d1f32b$792cfdb0$6b86f910$@opengridcomputing.com>
 <01a301d1f339$55ba8e70$012fab50$@opengridcomputing.com>
 <2fb1129c-424d-8b2d-7101-b9471e897dc8@grimberg.me>
 <004701d1f3d8$760660b0$62132210$@opengridcomputing.com>
 <008101d1f3de$557d2850$007778f0$@opengridcomputing.com>
 <00fe01d1f3e8$8992b330$9cb81990$@opengridcomputing.com>
 <01c301d1f702$d28c7270$77a55750$@opengridcomputing.com>
 <6ef9b0d1-ce84-4598-74db-7adeed313bb6@grimberg.me>
 <045601d1f803$a9d73a20$fd85ae60$@opengridcomputing.com>
 <69c0e819-76d9-286b-c4fb-22f087f36ff1@grimberg.me>
 <08b701d1f8ba$a709ae10$f51d0a30$@opengridcomputing.com>
 <01c301d20485$0dfcd2c0$29f67840$@opengridcomputing.com> <0c159abb
 -24ee-21bf-09d2-9fe7d2 69a2eb@grimberg.me>
 <039401d2094c$084d64e0$18e82ea0$@opengridcomputing.com>
 <7f09e373-6316-26a3-ae81-dab1205d88ab@grimbe rg.me> <021201d20a14$0
 f203b80$2d60b280$@opengridcomputing.com>
 <021401d20a16$ed60d470$c8227d50$@opengridcomputing.com>
Message-ID: <021501d20a19$327ba5b0$9772f110$@opengridcomputing.com>

> > > Not sure if it fixes anything, but we probably need it regardless, can
> > > you give another go with this on top:
> >
> > Still hit it with this on top (had to tweak the patch a little).
> >
> > Steve.
> 
> So with this patch, the crash is a little different.  One thread is in the
> usual place crashed in nvme_rdma_post_send() called by
> nvme_rdma_queue_rq() because the qp and cm_id in the nvme_rdma_queue have
> been freed.   Actually there are a handful of CPUs processing different
> requests in the same type stack trace.  But perhaps that is expected given
> the work load and number of controllers (10) and queues (32 per
> controller)...
> 
> I also see another worker thread here:
> 
> PID: 3769   TASK: ffff880e18972f40  CPU: 3   COMMAND: "kworker/3:3"
>  #0 [ffff880e2f7938d0] __schedule at ffffffff816dfa17
>  #1 [ffff880e2f793930] schedule at ffffffff816dff00
>  #2 [ffff880e2f793980] schedule_timeout at ffffffff816e2b1b
>  #3 [ffff880e2f793a60] wait_for_completion_timeout at ffffffff816e0f03
>  #4 [ffff880e2f793ad0] destroy_cq at ffffffffa061d8f3 [iw_cxgb4]
>  #5 [ffff880e2f793b60] c4iw_destroy_cq at ffffffffa061dad5 [iw_cxgb4]
>  #6 [ffff880e2f793bf0] ib_free_cq at ffffffffa0360e5a [ib_core]
>  #7 [ffff880e2f793c20] nvme_rdma_destroy_queue_ib at ffffffffa0644e9b
> [nvme_rdma]
>  #8 [ffff880e2f793c60] nvme_rdma_stop_and_free_queue at ffffffffa0645083
> [nvme_rdma]
>  #9 [ffff880e2f793c80] nvme_rdma_reconnect_ctrl_work at ffffffffa0645a9f
> [nvme_rdma]
> #10 [ffff880e2f793cb0] process_one_work at ffffffff810a1613
> #11 [ffff880e2f793d90] worker_thread at ffffffff810a22ad
> #12 [ffff880e2f793ec0] kthread at ffffffff810a6dec
> #13 [ffff880e2f793f50] ret_from_fork at ffffffff816e3bbf
> 
> I'm trying to identify if this reconnect is for the same controller that
> crashed processing a request.  It probably is, but I need to search the
> stack frame to try and find the controller pointer...
> 
> Steve.

Both the thread that crashed and the thread doing reconnect are operating on
ctrl "nvme2"...

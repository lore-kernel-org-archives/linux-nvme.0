From: swise@opengridcomputing.com (Steve Wise)
Date: Wed, 10 Aug 2016 12:20:21 -0500
Subject: nvmf/rdma host crash during heavy load and keep alive recovery
In-Reply-To: <013701d1f320$57b185d0$07149170$@opengridcomputing.com>
References: <018301d1e9e1$da3b2e40$8eb18ac0$@opengridcomputing.com>
 <20160801110658.GF16141@lst.de>
 <008801d1ec00$a0bcfbf0$e236f3d0$@opengridcomputing.com>
 <015801d1ec3d$0ca07ea0$25e17be0$@opengridcomputing.com>
 <010f01d1f31e$50c8cb40$f25a61c0$@opengridcomputing.com>
 <013701d1f320$57b185d0$07149170$@opengridcomputing.com>
Message-ID: <018401d1f32b$792cfdb0$6b86f910$@opengridcomputing.com>

> Here is the stack that crashed processing a blk request:
> 
> crash> bt
> PID: 402    TASK: ffff880397968040  CPU: 0   COMMAND: "kworker/0:1H"
>  #0 [ffff8803970f7800] machine_kexec at ffffffff8105fc40
>  #1 [ffff8803970f7870] __crash_kexec at ffffffff81116908
>  #2 [ffff8803970f7940] crash_kexec at ffffffff811169dd
>  #3 [ffff8803970f7970] oops_end at ffffffff81032be6
>  #4 [ffff8803970f79a0] die at ffffffff810330db
>  #5 [ffff8803970f79d0] do_general_protection at ffffffff81030144
>  #6 [ffff8803970f7a00] general_protection at ffffffff816e4ca8
>     [exception RIP: nvme_rdma_post_send+131]
>     RIP: ffffffffa0414083  RSP: ffff8803970f7ab8  RFLAGS: 00010246
>     RAX: 6b6b6b6b6b6b6b6b  RBX: ffff8802dd923598  RCX: 0000000000000002
>     RDX: ffff8803970f7ae0  RSI: ffff8803970f7ab8  RDI: ffff8802dd9fc518
>     RBP: ffff8803970f7af8   R8: ffff8803970f7ab8   R9: 0000000000000000
>     R10: 0000000000000000  R11: ffff8802dde6ef58  R12: ffff8802dd923598
>     R13: ffff8802dde6eeb0  R14: ffff880399f4c548  R15: ffff8802dde59db8
>     ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
>  #7 [ffff8803970f7b00] nvme_rdma_queue_rq at ffffffffa0415c72 [nvme_rdma]
>  #8 [ffff8803970f7b50] __blk_mq_run_hw_queue at ffffffff81338324
>  #9 [ffff8803970f7ca0] blk_mq_run_work_fn at ffffffff81338552
> #10 [ffff8803970f7cb0] process_one_work at ffffffff810a1593
> #11 [ffff8803970f7d90] worker_thread at ffffffff810a222d
> #12 [ffff8803970f7ec0] kthread at ffffffff810a6d6c
> #13 [ffff8803970f7f50] ret_from_fork at ffffffff816e2cbf
> 
> Here is the nvme_rdma_request:
> 
> crash> nvme_rdma_request ffff8802dde6eeb0
> struct nvme_rdma_request {
>   mr = 0xffff8802dde5c008,
>   sqe = {
>     cqe = {
>       done = 0xffffffffa0414320 <nvme_rdma_send_done>
>     },
>     data = 0xffff8802dde59db8,
>     dma = 12312747448
>   },
>   sge = {{
>       addr = 12312747448,
>       length = 64,
>       lkey = 0
>     }, {
>       addr = 12138727424,
>       length = 2048,
>       lkey = 0
>     }},
>   num_sge = 2,
>   nents = 1,
>   inline_data = true,
>   need_inval = false,
>   reg_wr = {
>     wr = {
>       next = 0x0,
>       {
>         wr_id = 0,
>         wr_cqe = 0x0
>       },
>       sg_list = 0x0,
>       num_sge = 0,
>       opcode = IB_WR_RDMA_WRITE,
>       send_flags = 0,
>       ex = {
>         imm_data = 0,
>         invalidate_rkey = 0
>       }
>     },
>     mr = 0x0,
>     key = 0,
>     access = 0
>   },
>   reg_cqe = {
>     done = 0x0
>   },
>   queue = 0xffff8802dd923598,
>   sg_table = {
>     sgl = 0xffff8802dde6ef58,
>     nents = 1,
>     orig_nents = 1
>   },
>   first_sgl = 0xffff8802dde6ef58
> }
> 
> And here is the nvme_rdma_queue:
> 
> crash> nvme_rdma_queue 0xffff8802dd923598
> struct nvme_rdma_queue {
>   rsp_ring = 0xffff8802dd968008,
>   sig_count = 200 '\310',
>   queue_size = 128,
>   cmnd_capsule_len = 4160,
>   ctrl = 0xffff8802dbd5d3d8,
>   device = 0xffff880384ceb5e8,
>   ib_cq = 0xffff8802dd9d2e68,
>   qp = 0xffff8802dd9fc518,
>   flags = 0,
>   cm_id = 0xffff8802dd9f8008,
>   cm_error = 0,
>   cm_done = {
>     done = 0,
>     wait = {
>       lock = {
>         {
>           rlock = {
>             raw_lock = {
>               val = {
>                 counter = 0
>               }
>             }
>           }
>         }
>       },
>       task_list = {
>         next = 0xffff8802dd9235f8,
>         prev = 0xffff8802dd9235f8
>       }
>     }
>   }
> }
> 
> And see here the ib_qp has been freed:
> 
> crash> gdb x/8g 0xffff8802dd9fc518
> 0xffff8802dd9fc518:     0x6b6b6b6b6b6b6b6b      0x6b6b6b6b6b6b6b6b
> 0xffff8802dd9fc528:     0x6b6b6b6b6b6b6b6b      0x6b6b6b6b6b6b6b6b
> 0xffff8802dd9fc538:     0x6b6b6b6b6b6b6b6b      0x6b6b6b6b6b6b6b6b
> 0xffff8802dd9fc548:     0x6b6b6b6b6b6b6b6b      0x6b6b6b6b6b6b6b6b

The nvme_rdma_ctrl queue associated with the request is in RECONNECTING state:

  ctrl = {
    state = NVME_CTRL_RECONNECTING,
    lock = {

So it should not be posting SQ WRs...

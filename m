From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 16 Aug 2016 12:26:30 +0300
Subject: nvmf/rdma host crash during heavy load and keep alive recovery
In-Reply-To: <01c301d1f702$d28c7270$77a55750$@opengridcomputing.com>
References: <018301d1e9e1$da3b2e40$8eb18ac0$@opengridcomputing.com>
 <20160801110658.GF16141@lst.de>
 <008801d1ec00$a0bcfbf0$e236f3d0$@opengridcomputing.com>
 <015801d1ec3d$0ca07ea0$25e17be0$@opengridcomputing.com>
 <010f01d1f31e$50c8cb40$f25a61c0$@opengridcomputing.com>
 <013701d1f320$57b185d0$07149170$@opengridcomputing.com>
 <018401d1f32b$792cfdb0$6b86f910$@opengridcomputing.com>
 <01a301d1f339$55ba8e70$012fab50$@opengridcomputing.com>
 <2fb1129c-424d-8b2d-7101-b9471e897dc8@grimberg.me>
 <004701d1f3d8$760660b0$62132210$@opengridcomputing.com>
 <008101d1f3de$557d2850$007778f0$@opengridcomputing.com>
 <00fe01d1f3e8$8992b330$9cb81990$@opengridcomputing.com>
 <01c301d1f702$d28c7270$77a55750$@opengridcomputing.com>
Message-ID: <6ef9b0d1-ce84-4598-74db-7adeed313bb6@grimberg.me>



On 15/08/16 17:39, Steve Wise wrote:
>
>> Ah, I see the nvme_rdma worker thread running
>> nvme_rdma_reconnect_ctrl_work() on the same nvme_rdma_queue that is
>> handling the request and crashing:
>>
>> crash> bt 371
>> PID: 371    TASK: ffff8803975a4300  CPU: 5   COMMAND: "kworker/5:2"
>>     [exception RIP: set_track+16]
>>     RIP: ffffffff81202070  RSP: ffff880397f2ba18  RFLAGS: 00000086
>>     RAX: 0000000000000001  RBX: ffff88039f407a00  RCX: ffffffffa0853234
>>     RDX: 0000000000000001  RSI: ffff8801d663e008  RDI: ffff88039f407a00
>>     RBP: ffff880397f2ba48   R8: ffff8801d663e158   R9: 000000000000005a
>>     R10: 00000000000000cc  R11: 0000000000000000  R12: ffff8801d663e008
>>     R13: ffffea0007598f80  R14: 0000000000000001  R15: ffff8801d663e008
>>     CS: 0010  SS: 0018
>>  #0 [ffff880397f2ba50] free_debug_processing at ffffffff81204820
>>  #1 [ffff880397f2bad0] __slab_free at ffffffff81204bfb
>>  #2 [ffff880397f2bb90] kfree at ffffffff81204dcd
>>  #3 [ffff880397f2bc00] nvme_rdma_free_qe at ffffffffa0853234 [nvme_rdma]
>>  #4 [ffff880397f2bc20] nvme_rdma_destroy_queue_ib at ffffffffa0853dbf
>> [nvme_rdma]
>>  #5 [ffff880397f2bc60] nvme_rdma_stop_and_free_queue at ffffffffa085402d
>> [nvme_rdma]
>>  #6 [ffff880397f2bc80] nvme_rdma_reconnect_ctrl_work at ffffffffa0854957
>> [nvme_rdma]
>>  #7 [ffff880397f2bcb0] process_one_work at ffffffff810a1593
>>  #8 [ffff880397f2bd90] worker_thread at ffffffff810a222d
>>  #9 [ffff880397f2bec0] kthread at ffffffff810a6d6c
>> #10 [ffff880397f2bf50] ret_from_fork at ffffffff816e2cbf
>>
>> So  why is this request being processed during a reconnect?
>
> Hey Sagi,
>
> Do you have any ideas on this crash? I could really use some help.

Not yet :(

> Is it
> possible that recovery/reconnect/restart of a different controller is somehow
> restarting the requests for a controller still in recovery?

I don't think this is the case.
Can you try and find out if the request is from the admin tagset or from
the io tagset?

We rely on the fact that no I/O will be issued after we call
nvme_stop_queues(). can you trace that we indeed call nvme_stop_queues
when we start error recovery and do nvme_start_queues only when we
successfully reconnect and not anywhere in between?

If that is the case, I think we need to have a closer look at
nvme_stop_queues...

> Here is one issue
> perhaps:  nvme_rdma_reconnect_ctrl_work() calls blk_mq_start_stopped_hw_queues()
> before calling nvme_rdma_init_io_queues().  Is that a problem?

Its for the admin queue, without that you won't be able to issue the
admin connect.

> I tried moving
> blk_mq_start_stopped_hw_queues() to after the io queues are setup, but this
> causes a stall in nvme_rdma_reconnect_ctrl_work().

Make sense...

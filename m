From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 9 Jul 2018 13:42:22 +0300
Subject: NVMe over Fabrics I/O Error with RDMA/RXE
In-Reply-To: <4F63AE27-CBFD-4429-8BF9-ADEE946A9DB7@connect.ust.hk>
References: <4F63AE27-CBFD-4429-8BF9-ADEE946A9DB7@connect.ust.hk>
Message-ID: <2f4ac5ac-9aa9-8f21-75cf-8419101a482f@grimberg.me>


> Hi all,

Hi Bairen,

> I am testing NVMe over Fabrics on a Linux 4.15 VM (latest Ubuntu 18.04 LTS, unmodified kernel), with an NVMe card and SoftRoCE (RXE) as transport.
> 
> It works just fine for the client connecting NVMeof target. However, it reports I/O error and timeout when read/write to the target over RXE.

Thanks for reporting,

Would it be possible to test with upstream kernel? I'm testing with
4.17.0 and I/O seems to work fine...

I suspect that probably some stable fixes need to be taken to 4.15.y?

What is your exact kernel version?

The difference from linux-stable-4.15.y is:
--
bb42f87e2924 IB/rxe: avoid unnecessary export
da2f3b286a39 IB/rxe: avoid calling WARN_ON_ONCE twice
e02637e97d68 IB: Fix RDMA_RXE and INFINIBAND_RDMAVT dependencies for 
DMA_VIRT_OPS
f5e27a203f4c Merge branch 'k.o/for-rc' into k.o/wip/dl-for-next
1661d3b0e218 nvmet,rxe: defer ip datagram sending to tasklet
ecb238f6a7f3 IB/cxgb4: use skb_put_zero()/__skb_put_zero
9fd4350ba895 IB/rxe: avoid double kfree_skb
2da36d44a9d5 IB/rxe: add RXE_START_MASK for rxe_opcode 
IB_OPCODE_RC_SEND_ONLY_INV
e12ee8ce5143 IB/rxe: remove unused function variable
0dff463a6a86 IB/rxe: change rxe_set_mtu function type to void
10c47d560603 IB/rxe: Change rxe_rcv to return void
fe896ceb5772 IB/rxe: replace refcount_inc with skb_get
2e47350789eb IB/rxe: optimize the function duplicate_request
8f1a72c815cf IB/rxe: make rxe_release_udp_tunnel static
76be04500be2 IB/rxe: avoid export symbols
0f02ba7ed16a IB/rxe: make the variable static
efc365e7290d IB/rxe: Fix for oops in rxe_register_device on ppc64le arch
39e00b6cf658 IB/rxe: Removed GID add/del dummy routines
414448d249d8 RDMA: Use ib_gid_attr during GID modification
3e44e0ee0893 IB/providers: Avoid null netdev check for RoCE
0e1f9b924471 RDMA/providers: Simplify query_gid callback of RoCE providers
99dae690255e IB/rxe: optimize mcast recv process
f2e9bfac13c9 RDMA/rxe: Fix uABI structure layouts for 32/64 compat
0ede73bc012c IB/uverbs: Extend uverbs_ioctl header with driver_id
0c43ab371bcb RDMA/rxe: Use structs to describe the uABI instead of 
opencoding
b92ec0fe3224 RDMA/rxe: Get rid of confusing udata parameter to 
rxe_cq_chk_attr
43c9fc509fa5 rdma_rxe: make rxe work over 802.1q VLAN devices
befd8d98f230 IB/rxe: change the function rxe_init_device_param type
31f1bd14cbfe IB/rxe: remove unnecessary rxe in rxe_send
86af61764151 IB/rxe: remove unnecessary skb_clone
a6544a624c3f RDMA/rxe: Fix an out-of-bounds read
c33bab622d47 IB/rxe: Remove unused variable (char *rxe_qp_state_name[])
7061f28d8a2f rxe: Do not use 'struct sockaddr' in a uapi header
316663c6bfeb IB/rxe: remove redudant parameter in rxe_av_fill_ip_info
45a290f8f6c6 IB/rxe: change the function rxe_av_fill_ip_info to void
a402dc445dd6 IB/rxe: change the function to void from int
9c96f3d4ddba IB/rxe: remove unnecessary parameter in rxe_av_to_attr
ca3d9feee6a9 IB/rxe: change the function to void from int
1a241db19ca9 IB/rxe: remove redudant parameter in function
0812ed132178 IB/rxe: Change RDMA_RXE kconfig to use select
--

Possible suspect might be:
--
commit 2da36d44a9d54a2c6e1f8da1f7ccc26b0bc6cfec
Author: Jianchao Wang <jianchao.w.wang at oracle.com>
Date:   Thu Apr 26 11:52:39 2018 +0800

     IB/rxe: add RXE_START_MASK for rxe_opcode IB_OPCODE_RC_SEND_ONLY_INV

     w/o RXE_START_MASK, the last_psn of IB_OPCODE_RC_SEND_ONLY_INV
     will not be updated in update_wqe_psn, and the corresponding
     wqe will not be acked in rxe_completer due to its last_psn is
     zero. Finally, the other wqe will also not be able to be acked,
     because the wqe of IB_OPCODE_RC_SEND_ONLY_INV with last_psn 0
     is still there. This causes large amount of io timeout when
     nvmeof is over rxe.

     Add RXE_START_MASK for IB_OPCODE_RC_SEND_ONLY_INV to fix this.

     Signed-off-by: Jianchao Wang <jianchao.w.wang at oracle.com>
     Reviewed-by: Zhu Yanjun <yanjun.zhu at oracle.com>
     Signed-off-by: Doug Ledford <dledford at redhat.com>
--

Another useful stable candidate would be:
--
commit 1661d3b0e2183ce90f6611641c350a5aa02aaa80
Author: Alexandru Moise <00moses.alexander00 at gmail.com>
Date:   Tue May 8 11:02:02 2018 +0200

     nvmet,rxe: defer ip datagram sending to tasklet

     This addresses 3 separate problems:

     1. When using NVME over Fabrics we may end up sending IP
     packets in interrupt context, we should defer this work
     to a tasklet.

     [   50.939957] WARNING: CPU: 3 PID: 0 at kernel/softirq.c:161 
__local_bh_enable_ip+0x1f/0xa0
     [   50.942602] CPU: 3 PID: 0 Comm: swapper/3 Kdump: loaded Tainted: 
G        W         4.17.0-rc3-ARCH+ #104
     [   50.945466] Hardware name: QEMU Standard PC (i440FX + PIIX, 
1996), BIOS 1.11.0-20171110_100015-anatol 04/01/2014
     [   50.948163] RIP: 0010:__local_bh_enable_ip+0x1f/0xa0
     [   50.949631] RSP: 0018:ffff88009c183900 EFLAGS: 00010006
     [   50.951029] RAX: 0000000080010403 RBX: 0000000000000200 RCX: 
0000000000000001
     [   50.952636] RDX: 0000000000000000 RSI: 0000000000000200 RDI: 
ffffffff817e04ec
     [   50.954278] RBP: ffff88009c183910 R08: 0000000000000001 R09: 
0000000000000614
     [   50.956000] R10: ffffea00021d5500 R11: 0000000000000001 R12: 
ffffffff817e04ec
     [   50.957779] R13: 0000000000000000 R14: ffff88009566f400 R15: 
ffff8800956c7000
     [   50.959402] FS:  0000000000000000(0000) 
GS:ffff88009c180000(0000) knlGS:0000000000000000
     [   50.961552] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
     [   50.963798] CR2: 000055c4ec0ccac0 CR3: 0000000002209001 CR4: 
00000000000606e0
     [   50.966121] Call Trace:
     [   50.966845]  <IRQ>
     [   50.967497]  __dev_queue_xmit+0x62d/0x690
     [   50.968722]  dev_queue_xmit+0x10/0x20
     [   50.969894]  neigh_resolve_output+0x173/0x190
     [   50.971244]  ip_finish_output2+0x2b8/0x370
     [   50.972527]  ip_finish_output+0x1d2/0x220
     [   50.973785]  ? ip_finish_output+0x1d2/0x220
     [   50.975010]  ip_output+0xd4/0x100
     [   50.975903]  ip_local_out+0x3b/0x50
     [   50.976823]  rxe_send+0x74/0x120
     [   50.977702]  rxe_requester+0xe3b/0x10b0
     [   50.978881]  ? ip_local_deliver_finish+0xd1/0xe0
     [   50.980260]  rxe_do_task+0x85/0x100
     [   50.981386]  rxe_run_task+0x2f/0x40
     [   50.982470]  rxe_post_send+0x51a/0x550
     [   50.983591]  nvmet_rdma_queue_response+0x10a/0x170
     [   50.985024]  __nvmet_req_complete+0x95/0xa0
     [   50.986287]  nvmet_req_complete+0x15/0x60
     [   50.987469]  nvmet_bio_done+0x2d/0x40
     [   50.988564]  bio_endio+0x12c/0x140
     [   50.989654]  blk_update_request+0x185/0x2a0
     [   50.990947]  blk_mq_end_request+0x1e/0x80
     [   50.991997]  nvme_complete_rq+0x1cc/0x1e0
     [   50.993171]  nvme_pci_complete_rq+0x117/0x120
     [   50.994355]  __blk_mq_complete_request+0x15e/0x180
     [   50.995988]  blk_mq_complete_request+0x6f/0xa0
     [   50.997304]  nvme_process_cq+0xe0/0x1b0
     [   50.998494]  nvme_irq+0x28/0x50
     [   50.999572]  __handle_irq_event_percpu+0xa2/0x1c0
     [   51.000986]  handle_irq_event_percpu+0x32/0x80
     [   51.002356]  handle_irq_event+0x3c/0x60
     [   51.003463]  handle_edge_irq+0x1c9/0x200
     [   51.004473]  handle_irq+0x23/0x30
     [   51.005363]  do_IRQ+0x46/0xd0
     [   51.006182]  common_interrupt+0xf/0xf
     [   51.007129]  </IRQ>

     2. Work must always be offloaded to tasklet for rxe_post_send_kernel()
     when using NVMEoF in order to solve lock ordering between 
neigh->ha_lock
     seqlock and the nvme queue lock:

     [   77.833783]  Possible interrupt unsafe locking scenario:
     [   77.833783]
     [   77.835831]        CPU0                    CPU1
     [   77.837129]        ----                    ----
     [   77.838313]   lock(&(&n->ha_lock)->seqcount);
     [   77.839550]                                local_irq_disable();
     [   77.841377] 
lock(&(&nvmeq->q_lock)->rlock);
     [   77.843222] 
lock(&(&n->ha_lock)->seqcount);
     [   77.845178]   <Interrupt>
     [   77.846298]     lock(&(&nvmeq->q_lock)->rlock);
     [   77.847986]
     [   77.847986]  *** DEADLOCK ***

     3. Same goes for the lock ordering between sch->q.lock and nvme 
queue lock:

     [   47.634271]  Possible interrupt unsafe locking scenario:
     [   47.634271]
     [   47.636452]        CPU0                    CPU1
     [   47.637861]        ----                    ----
     [   47.639285]   lock(&(&sch->q.lock)->rlock);
     [   47.640654]                                local_irq_disable();
     [   47.642451] 
lock(&(&nvmeq->q_lock)->rlock);
     [   47.644521] 
lock(&(&sch->q.lock)->rlock);
     [   47.646480]   <Interrupt>
     [   47.647263]     lock(&(&nvmeq->q_lock)->rlock);
     [   47.648492]
     [   47.648492]  *** DEADLOCK ***

     Using NVMEoF after this patch seems to finally be stable, without it,
     rxe eventually deadlocks the whole system and causes RCU stalls.

     Signed-off-by: Alexandru Moise <00moses.alexander00 at gmail.com>
     Reviewed-by: Zhu Yanjun <yanjun.zhu at oracle.com>
     Signed-off-by: Doug Ledford <dledford at redhat.com>
--

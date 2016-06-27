From: mlin@kernel.org (Ming Lin)
Date: Mon, 27 Jun 2016 15:29:42 -0700
Subject: target crash / host hang with nvme-all.3 branch of nvme-fabrics
In-Reply-To: <020201d1c812$ec94b430$c5be1c90$@opengridcomputing.com>
References: <00d801d1c7de$e17fc7d0$a47f5770$@opengridcomputing.com>
 <20160616145724.GA32635@infradead.org>
 <017001d1c7e7$95057270$bf105750$@opengridcomputing.com>
 <5763044A.9090206@grimberg.me>
 <01b501d1c809$92cb1a60$b8614f20$@opengridcomputing.com>
 <576306EE.4020306@grimberg.me>
 <01b901d1c80b$72f83680$58e8a380$@opengridcomputing.com>
 <CAF1ivSYUG4c7Ej-gNqA=aPFR2zkNq8KhBoodhp64wdY=eQLx6g@mail.gmail.com>
 <01c101d1c80d$96d13c80$c473b580$@opengridcomputing.com>
 <20160616203437.GA19079@lst.de>
 <01e701d1c810$91d851c0$b588f540$@opengridcomputing.com>
 <020201d1c812$ec94b430$c5be1c90$@opengridcomputing.com>
Message-ID: <1467066582.7205.7.camel@ssi>

On Thu, 2016-06-16@16:06 -0500, Steve Wise wrote:
> > > Unfortunately I think it's still wrong because it will only delete
> > > a single queue per controller.  We'll probably need something
> > > like this instead, which does the same think but also has a retry
> > > loop for additional queues:
> > >
> > >
> > > diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
> > > index b1c6e5b..425b55c 100644
> > > --- a/drivers/nvme/target/rdma.c
> > > +++ b/drivers/nvme/target/rdma.c
> > > @@ -1293,19 +1293,20 @@ static int nvmet_rdma_cm_handler(struct
> > > rdma_cm_id *cm_id,
> > >
> > >  static void nvmet_rdma_delete_ctrl(struct nvmet_ctrl *ctrl)
> > >  {
> > > -	struct nvmet_rdma_queue *queue, *next;
> > > -	static LIST_HEAD(del_list);
> > > +	struct nvmet_rdma_queue *queue;
> > >
> > > +restart:
> > >  	mutex_lock(&nvmet_rdma_queue_mutex);
> > > -	list_for_each_entry_safe(queue, next,
> > > -			&nvmet_rdma_queue_list, queue_list) {
> > > -		if (queue->nvme_sq.ctrl->cntlid == ctrl->cntlid)
> > > -			list_move_tail(&queue->queue_list, &del_list);
> > > +	list_for_each_entry(queue, &nvmet_rdma_queue_list, queue_list) {
> > > +		if (queue->nvme_sq.ctrl == ctrl) {
> > > +			list_del_init(&queue->queue_list);
> > > +			mutex_unlock(&nvmet_rdma_queue_mutex);
> > > +
> > > +			__nvmet_rdma_queue_disconnect(queue);
> > > +			goto restart;
> > > +		}
> > >  	}
> > >  	mutex_unlock(&nvmet_rdma_queue_mutex);
> > > -
> > > -	list_for_each_entry_safe(queue, next, &del_list, queue_list)
> > > -		nvmet_rdma_queue_disconnect(queue);
> > >  }
> > >
> > >  static int nvmet_rdma_add_port(struct nvmet_port *port)
> > >
> > 
> > This patch works.
> > 
> > Tested-by: Steve Wise <swise at opengridcomputing.com>
> > 
> > 
> 
> hrm...
> 
> Forcing more reconnects, I just hit this.  It looks different from the other
> issue:
> 
> general protection fault: 0000 [#1] SMP
> Modules linked in: rdma_ucm iw_cxgb4 cxgb4 nvmet_rdma rdma_cm iw_cm nvmet
> null_blk configfs ip6table_filter ip6_tables ebtable_nat ebtables
> nf_conntrack_ipv4 nf_defrag_ipv4 xt_state nf_conntrack ipt_REJECT nf_reject_
> ipv4 xt_CHECKSUM iptable_mangle iptable_filter ip_tables bridge autofs4 8021q
> garp stp llc ipmi_devintf cachefiles fscache ib_ipoib ib_cm ib_uverbs ib_umad
> iw_nes libcrc32c iw_cxgb3 cxgb3 mdio ib_qib rdmavt mlx4_en i   b_mthca dm_mirror
> dm_region_hash dm_log vhost_net macvtap macvlan vhost tun kvm_intel kvm
> irqbypass uinput iTCO_wdt iTCO_vendor_support mxm_wmi pcspkr mlx4_ib ib_core
> ipv6 mlx4_core dm_mod i2c_i801 sg lpc_ich mfd_cor   e nvme nvme_core
> acpi_cpufreq ioatdma igb dca i2c_algo_bit i2c_core ptp pps_core wmi ext4(E)
> mbcache(E) jbd2(E) sd_mod(E) ahci(E) libahci(E) [last unloaded: cxgb4]
> CPU: 3 PID: 19213 Comm: kworker/3:10 Tainted: G            E
> 4.7.0-rc2-nvmf-all.3+rxe+ #84
> Hardware name: Supermicro X9DR3-F/X9DR3-F, BIOS 3.2a 07/09/2015
> Workqueue: events nvmet_rdma_release_queue_work [nvmet_rdma]
> task: ffff88103d68cf00 ti: ffff880fdf7a4000 task.ti: ffff880fdf7a4000
> RIP: 0010:[<ffffffffa01ef5b7>]  [<ffffffffa01ef5b7>]
> nvmet_rdma_free_rsps+0x67/0xb0 [nvmet_rdma]
> RSP: 0018:ffff880fdf7a7bb8  EFLAGS: 00010202
> RAX: dead000000000100 RBX: 000000000000001f RCX: 0000000000000001
> RDX: dead000000000200 RSI: ffff880fdd884290 RDI: dead000000000200
> RBP: ffff880fdf7a7bf8 R08: dead000000000100 R09: ffff88103c768140
> R10: ffff88103c7682c0 R11: ffff88103c768340 R12: 00000000000044c8
> R13: ffff88103db39c00 R14: 0000000000000100 R15: ffff88103e29cec0
> FS:  0000000000000000(0000) GS:ffff88107f2c0000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000001016b00 CR3: 000000103bcb7000 CR4: 00000000000406e0
> Stack:
>  ffff880fdd8a23f8 00000000ffac1a05 ffff880fdf7a7bf8 ffff88103db39c00
>  ffff88103c64cc00 ffffe8ffffac1a00 0000000000000000 ffffe8ffffac1a05
>  ffff880fdf7a7c18 ffffffffa01ef652 0000000000000246 ffff88103e29cec0
> Call Trace:
>  [<ffffffffa01ef652>] nvmet_rdma_free_queue+0x52/0xa0 [nvmet_rdma]
>  [<ffffffffa01ef6d3>] nvmet_rdma_release_queue_work+0x33/0x70 [nvmet_rdma]
>  [<ffffffff8107cb5b>] process_one_work+0x17b/0x510
>  [<ffffffff8161495c>] ? __schedule+0x23c/0x630
>  [<ffffffff810c6c4c>] ? del_timer_sync+0x4c/0x60
>  [<ffffffff8107da0b>] ? maybe_create_worker+0x8b/0x110
>  [<ffffffff81614eb0>] ? schedule+0x40/0xb0
>  [<ffffffff8107dbf6>] worker_thread+0x166/0x580
>  [<ffffffff8161495c>] ? __schedule+0x23c/0x630
>  [<ffffffff8108e162>] ? default_wake_function+0x12/0x20
>  [<ffffffff8109fc26>] ? __wake_up_common+0x56/0x90
>  [<ffffffff8107da90>] ? maybe_create_worker+0x110/0x110
>  [<ffffffff81614eb0>] ? schedule+0x40/0xb0
>  [<ffffffff8107da90>] ? maybe_create_worker+0x110/0x110
>  [<ffffffff8108255c>] kthread+0xcc/0xf0
>  [<ffffffff8108cade>] ? schedule_tail+0x1e/0xc0
>  [<ffffffff816186cf>] ret_from_fork+0x1f/0x40
>  [<ffffffff81082490>] ? kthread_freezable_should_stop+0x70/0x70
> Code: b8 00 01 00 00 00 00 ad de 48 bf 00 02 00 00 00 00 ad de 83 c3 01 49 81 c4
> 38 02 00 00 48 8b 86 28 02 00 00 48 8b 96 30 02 00 00 <48> 89 50 08 48 89 45 c0
> 48 89 02 48 89 be 30 02 00 00 4c 89 ff
> RIP  [<ffffffffa01ef5b7>] nvmet_rdma_free_rsps+0x67/0xb0 [nvmet_rdma]
>  RSP <ffff880fdf7a7bb8>
> ---[ end trace a30265f72371b5ce ]---

Hi Steve,

Now I can reproduce this with Chelsio card and below script:

root at host:~# cat loop.sh 
#!/bin/bash

ETH=eth3

while [ 1 ] ; do
	ifconfig $ETH down ; sleep $(( 10 + ($RANDOM & 0x7) )); ifconfig $ETH up ;sleep $(( 10 + ($RANDOM & 0x7) ))
done

And below patch fixed it.
Could you also help to test it?

The root cause is the "rsp" was already removed from the free_list by
nvmet_rdma_get_rsp().

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 425b55c..627942c 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -425,7 +425,15 @@ static void nvmet_rdma_free_rsps(struct nvmet_rdma_queue *queue)
 	for (i = 0; i < nr_rsps; i++) {
 		struct nvmet_rdma_rsp *rsp = &queue->rsps[i];
 
-		list_del(&rsp->free_list);
+		/*
+		 * Don't call "list_del(&rsp->free_list)", because:
+		 * It could be already removed from the free list by
+		 * nvmet_rdma_get_rsp(), or it's on the queue::rsp_wait_list
+		 *
+		 * It's safe we just free it because at this point the queue
+		 * was already disconnected so nvmet_rdma_get_rsp() won't be
+		 * called any more.
+		 */
 		nvmet_rdma_free_rsp(ndev, rsp);
 	}
 	kfree(queue->rsps);

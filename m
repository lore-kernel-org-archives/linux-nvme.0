From: mlin@kernel.org (Ming Lin)
Date: Mon, 27 Jun 2016 10:26:36 -0700
Subject: target crash / host hang with nvme-all.3 branch of nvme-fabrics
In-Reply-To: <20160616203437.GA19079@lst.de>
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
Message-ID: <1467048396.7205.3.camel@ssi>

On Thu, 2016-06-16@22:34 +0200, 'Christoph Hellwig' wrote:
> On Thu, Jun 16, 2016@03:28:06PM -0500, Steve Wise wrote:
> > > Just to follow, does Christoph's patch fix the crash?
> > 
> > It does. 
> 
> Unfortunately I think it's still wrong because it will only delete
> a single queue per controller.  We'll probably need something
> like this instead, which does the same think but also has a retry
> loop for additional queues:
> 
> 
> diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
> index b1c6e5b..425b55c 100644
> --- a/drivers/nvme/target/rdma.c
> +++ b/drivers/nvme/target/rdma.c
> @@ -1293,19 +1293,20 @@ static int nvmet_rdma_cm_handler(struct rdma_cm_id *cm_id,
>  
>  static void nvmet_rdma_delete_ctrl(struct nvmet_ctrl *ctrl)
>  {
> -	struct nvmet_rdma_queue *queue, *next;
> -	static LIST_HEAD(del_list);
> +	struct nvmet_rdma_queue *queue;
>  
> +restart:
>  	mutex_lock(&nvmet_rdma_queue_mutex);
> -	list_for_each_entry_safe(queue, next,
> -			&nvmet_rdma_queue_list, queue_list) {
> -		if (queue->nvme_sq.ctrl->cntlid == ctrl->cntlid)
> -			list_move_tail(&queue->queue_list, &del_list);
> +	list_for_each_entry(queue, &nvmet_rdma_queue_list, queue_list) {
> +		if (queue->nvme_sq.ctrl == ctrl) {
> +			list_del_init(&queue->queue_list);
> +			mutex_unlock(&nvmet_rdma_queue_mutex);
> +
> +			__nvmet_rdma_queue_disconnect(queue);
> +			goto restart;
> +		}
>  	}
>  	mutex_unlock(&nvmet_rdma_queue_mutex);
> -
> -	list_for_each_entry_safe(queue, next, &del_list, queue_list)
> -		nvmet_rdma_queue_disconnect(queue);
>  }
>  
>  static int nvmet_rdma_add_port(struct nvmet_port *port)

Run below test over weekend on host side(nvmf-all.3),

#!/bin/bash

while [ 1 ] ; do
	ifconfig eth5 down ; sleep $(( 10 + ($RANDOM & 0x7) )); ifconfig eth5 up ;sleep $(( 10 + ($RANDOM & 0x7) ))
done

Then target side hit below crash:

[122730.252874] nvmet: creating controller 1 for NQN nqn.2014-08.org.nvmexpress:NVMf:uuid:53ea06bc-e1d0-4d59-a6e9-138684f3662b.
[122730.281665] nvmet: adding queue 1 to ctrl 1.
[122730.287133] nvmet: adding queue 2 to ctrl 1.
[122730.292672] nvmet: adding queue 3 to ctrl 1.
[122730.298197] nvmet: adding queue 4 to ctrl 1.
[122730.303742] nvmet: adding queue 5 to ctrl 1.
[122730.309375] nvmet: adding queue 6 to ctrl 1.
[122730.315015] nvmet: adding queue 7 to ctrl 1.
[122730.320688] nvmet: adding queue 8 to ctrl 1.
[122732.014747] mlx4_en: eth4: Link Down
[122745.298422] nvmet: ctrl 1 keep-alive timer (15 seconds) expired!
[122745.305601] BUG: unable to handle kernel paging request at 0000010173180018
[122745.313755] IP: [<ffffffffc08bb7fa>] nvmet_rdma_delete_ctrl+0x4a/0xa0 [nvmet_rdma]
[122745.322513] PGD 0
[122745.325667] Oops: 0000 [#1] PREEMPT SMP
[122745.462435] CPU: 0 PID: 4849 Comm: kworker/0:3 Tainted: G           OE   4.7.0-rc2+ #256
[122745.472376] Hardware name: Dell Inc. OptiPlex 7010/0773VG, BIOS A12 01/10/2013
[122745.481433] Workqueue: events nvmet_keep_alive_timer [nvmet]
[122745.488909] task: ffff880035346a00 ti: ffff8800d1078000 task.ti: ffff8800d1078000
[122745.498246] RIP: 0010:[<ffffffffc08bb7fa>]  [<ffffffffc08bb7fa>] nvmet_rdma_delete_ctrl+0x4a/0xa0 [nvmet_rdma]
[122745.510170] RSP: 0018:ffff8800d107bdf0  EFLAGS: 00010207
[122745.517384] RAX: 0000010173180100 RBX: 000001017317ffe0 RCX: 0000000000000000
[122745.526464] RDX: 0000010173180100 RSI: ffff88012020dc28 RDI: ffffffffc08bf080
[122745.535566] RBP: ffff8800d107be00 R08: 0000000000000000 R09: ffff8800c7bd7bc0
[122745.544715] R10: 000000000000f000 R11: 0000000000015c68 R12: ffff8800b85c3400
[122745.553873] R13: ffff88012021ac00 R14: 0000000000000000 R15: ffff880120216300
[122745.563025] FS:  0000000000000000(0000) GS:ffff880120200000(0000) knlGS:0000000000000000
[122745.573152] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[122745.580923] CR2: 0000010173180018 CR3: 0000000001c06000 CR4: 00000000001406f0
[122745.590125] Stack:
[122745.594187]  ffff8800b85c34c8 ffff8800b85c34c8 ffff8800d107be18 ffffffffc090d0be
[122745.603771]  ffff8800d7cfaf00 ffff8800d107be60 ffffffff81083019 ffff8800d7cfaf30
[122745.613374]  0000000035346a00 ffff880120216320 ffff8800d7cfaf30 ffff880035346a00
[122745.622992] Call Trace:
[122745.627593]  [<ffffffffc090d0be>] nvmet_keep_alive_timer+0x2e/0x40 [nvmet]
[122745.636685]  [<ffffffff81083019>] process_one_work+0x159/0x370
[122745.644745]  [<ffffffff81083356>] worker_thread+0x126/0x490
[122745.652545]  [<ffffffff816f17fe>] ? __schedule+0x1de/0x590
[122745.660217]  [<ffffffff81083230>] ? process_one_work+0x370/0x370
[122745.668387]  [<ffffffff81088864>] kthread+0xc4/0xe0
[122745.675437]  [<ffffffff816f571f>] ret_from_fork+0x1f/0x40
[122745.683025]  [<ffffffff810887a0>] ? kthread_create_on_node+0x170/0x170

(gdb) list *nvmet_rdma_delete_ctrl+0x4a
0x82a is in nvmet_rdma_delete_ctrl (/home/mlin/linux-nvmeof/drivers/nvme/target/rdma.c:1301).
1296		struct nvmet_rdma_queue *queue;
1297	
1298	restart:
1299		mutex_lock(&nvmet_rdma_queue_mutex);
1300		list_for_each_entry(queue, &nvmet_rdma_queue_list, queue_list) {
1301			if (queue->nvme_sq.ctrl == ctrl) {
1302				list_del_init(&queue->queue_list);
1303				mutex_unlock(&nvmet_rdma_queue_mutex);
1304	
1305				__nvmet_rdma_queue_disconnect(queue);

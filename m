From: rajur@chelsio.com (Raju  Rangoju)
Date: Tue, 24 Oct 2017 16:26:51 +0000
Subject: kernel paging request error observed on initiator after 'nvmetcli
 clear' on target
Message-ID: <CY1PR12MB07745F65B8684865F1AB8EEABC470@CY1PR12MB0774.namprd12.prod.outlook.com>

Hi Sagi,

I'm seeing an issue with nvmeof, while running fio if I offline CPUs on initiator and 'nvmetcli clear' on target, 'kernel paging request' error is observed on initiator.

This happens at
static int __ib_process_cq(struct ib_cq *cq, int budget)
{
...

    if (wc->wr_cqe)
          wc->wr_cqe->done(cq, wc);
                       ^^^^^^^^^^^

Steps to reproduce:
1. configure target
2. connect to target from client
3. Start fio and offline CPUs on initiator and do 'nvmetcli clear' on target
client side:
fio -filename=/dev/nvme0n1 -iodepth=1 -thread -rw=randwrite -ioengine=psync -bssplit=5k/10:9k/10:13k/10:17k/10:21k/10:25k/10:29k/10:33k/10:37k/10:41k/10 -bs_unaligned -runtime=300 -size=-group_reporting -name=mytest -numjobs=60  &
echo 0 > /sys/devices/system/cpu/cpu1/online
echo 0 > /sys/devices/system/cpu/cpu2/online
echo 0 > /sys/devices/system/cpu/cpu3/online

target side:
nvmetcli clear

-> cqe.wr_id looks like a valid pointer, but it seems the structure that it points to was freed before all the WR completions were reaped.

-> I enabled memory debugging to see if the memory that wr_id was pointing to was freed earlier, but memory debugging did not help.

kernel log:
iw_cxgb4: Chelsio T4/T5 RDMA Driver - version 0.1
iw_cxgb4: 0000:02:00.4: Up
iw_cxgb4: 0000:02:00.4: On-Chip Queues not supported on this device
IPv6: ADDRCONF(NETDEV_UP): enp2s0f4d1: link is not ready
cxgb4 0000:02:00.4 enp2s0f4d1: passive DA module inserted
cxgb4 0000:02:00.4 enp2s0f4d1: link up, 10Gbps, full-duplex, Tx/Rx PAUSE
IPv6: ADDRCONF(NETDEV_CHANGE): enp2s0f4d1: link becomes ready
iwpm_register_pid: Unable to send a nlmsg (client = 2)
nvme nvme0: creating 16 I/O queues.
nvme nvme0: new ctrl: NQN "nvme-ram0", addr 102.10.10.238:4420
Broke affinity for irq 120
Broke affinity for irq 125
smpboot: CPU 1 is now offline
IRQ fixup: irq 81 move in progress, old vector 71
Broke affinity for irq 81
Broke affinity for irq 120
Broke affinity for irq 125
smpboot: CPU 2 is now offline
Broke affinity for irq 81
Broke affinity for irq 120
Broke affinity for irq 125
smpboot: CPU 3 is now offline
BUG: unable to handle kernel paging request at 000000000ba30c00
IP: 0xba30c00
PGD 0
P4D 0

Oops: 0010 [#1] SMP DEBUG_PAGEALLOC
CPU: 11 PID: 4180 Comm: kworker/u32:0 Not tainted 4.12.0-rc1 #1
Hardware name: Supermicro X10SRA-F/X10SRA-F, BIOS 2.0a 06/23/2016
Workqueue: iw_cxgb4 process_work [iw_cxgb4]
task: ffff88084c656780 task.stack: ffffc90001848000
RIP: 0010:0xba30c00
RSP: 0018:ffff88087b6c3ee8 EFLAGS: 00010282
RAX: 0000000000000007 RBX: 00000000000001c0 RCX: ffff8808130d0000
RDX: ffff880812e70168 RSI: ffff880857973400 RDI: ffff880855ae5400
RBP: ffff88087b6c3f20 R08: ffff88087b6c3e90 R09: ffff88087b6c3e8c
R10: ffff880857973d60 R11: ffff8808130e0000 R12: 0000000000000007
R13: 0000000000000080 R14: 0000000000000000 R15: ffff880855ae5400
FS:  0000000000000000(0000) GS:ffff88087b6c0000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000ba30c00 CR3: 0000000001c09000 CR4: 00000000003406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 ? __ib_process_cq+0x5c/0xb0 [ib_core]
 ib_poll_handler+0x22/0x70 [ib_core]
 irq_poll_softirq+0x98/0xf0
 __do_softirq+0xd0/0x277
 do_softirq_own_stack+0x1c/0x30
 </IRQ>
 do_softirq+0x47/0x50
 __local_bh_enable_ip+0x57/0x60
 t4_ofld_send+0x10d/0x170 [cxgb4]
 cxgb4_remove_tid+0x93/0x110 [cxgb4]
 _c4iw_free_ep+0x58/0x110 [iw_cxgb4]
 close_con_rpl+0x9f/0x180 [iw_cxgb4]
 ? process_work+0x4f/0x60 [iw_cxgb4]
 ? skb_dequeue+0x59/0x70
 process_work+0x43/0x60 [iw_cxgb4]
 process_one_work+0x147/0x370
 worker_thread+0x4a/0x390
 kthread+0x109/0x140
 ? process_one_work+0x370/0x370
 ? kthread_park+0x60/0x60
 ret_from_fork+0x29/0x40
Code:  Bad RIP value.
RIP: 0xba30c00 RSP: ffff88087b6c3ee8
CR2: 000000000ba30c00
---[ end trace 3630f896456a7326 ]---
Kernel panic - not syncing: Fatal exception in interrupt
Kernel Offset: disabled
---[ end Kernel panic - not syncing: Fatal exception in interrupt
sched: Unexpected reschedule of offline CPU#0!
------------[ cut here ]------------
WARNING: CPU: 11 PID: 4180 at arch/x86/kernel/smp.c:128 native_smp_send_reschedule+0x3c/0x40
CPU: 11 PID: 4180 Comm: kworker/u32:0 Tainted: G      D         4.12.0-rc1 #1
Hardware name: Supermicro X10SRA-F/X10SRA-F, BIOS 2.0a 06/23/2016
Workqueue: iw_cxgb4 process_work [iw_cxgb4]
task: ffff88084c656780 task.stack: ffffc90001848000
RIP: 0010:native_smp_send_reschedule+0x3c/0x40
RSP: 0018:ffff88087b6c3a10 EFLAGS: 00010096
RAX: 000000000000002e RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000001 RSI: ffff88087b6ccba8 RDI: ffff88087b6ccba8
RBP: ffff88087b6c3a10 R08: 0000000000000001 R09: 000000000000081a
R10: 0000000000000059 R11: ffffc9000144fe50 R12: 000000000000000b
R13: 000000010005ec33 R14: ffff88084c656780 R15: ffff88087b6d32a8
FS:  0000000000000000(0000) GS:ffff88087b6c0000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000ba30c00 CR3: 0000000001c09000 CR4: 00000000003406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 trigger_load_balance+0x10e/0x1f0
 scheduler_tick+0xa1/0xd0
 ? tick_sched_do_timer+0x40/0x40
 update_process_times+0x47/0x60
 tick_sched_handle.isra.15+0x25/0x60
 tick_sched_timer+0x3d/0x70
 __hrtimer_run_queues+0xe3/0x220
 hrtimer_interrupt+0xa8/0x190
 local_apic_timer_interrupt+0x35/0x60
 smp_apic_timer_interrupt+0x38/0x50
 apic_timer_interrupt+0x86/0x90
RIP: 0010:panic+0x1df/0x21d
RSP: 0018:ffff88087b6c3c60 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff10
RAX: 0000000000000041 RBX: 0000000000000000 RCX: 0000000000000006
RDX: 0000000000000000 RSI: 0000000000000092 RDI: ffff88087b6ccba0
RBP: ffff88087b6c3cc8 R08: 0000000000000001 R09: 0000000000000819
R10: 000000000000006c R11: ffffc9000144fe20 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000046
 oops_end+0xb5/0xc0
 no_context+0x17c/0x3d0
 __bad_area_nosemaphore+0xe8/0x1c0
 bad_area_nosemaphore+0x14/0x20
 __do_page_fault+0x89/0x4a0
 ? __radix_tree_lookup+0x75/0xe0
 do_page_fault+0xc/0x10
 page_fault+0x22/0x30
RIP: 0010:0xba30c00
RSP: 0018:ffff88087b6c3ee8 EFLAGS: 00010282
RAX: 0000000000000007 RBX: 00000000000001c0 RCX: ffff8808130d0000
RDX: ffff880812e70168 RSI: ffff880857973400 RDI: ffff880855ae5400
RBP: ffff88087b6c3f20 R08: ffff88087b6c3e90 R09: ffff88087b6c3e8c
R10: ffff880857973d60 R11: ffff8808130e0000 R12: 0000000000000007
R13: 0000000000000080 R14: 0000000000000000 R15: ffff880855ae5400
 ? __ib_process_cq+0x5c/0xb0 [ib_core]
 ? ib_poll_handler+0x22/0x70 [ib_core]
 ? irq_poll_softirq+0x98/0xf0
 ? __do_softirq+0xd0/0x277
 ? do_softirq_own_stack+0x1c/0x30
 </IRQ>
 ? do_softirq+0x47/0x50
 ? __local_bh_enable_ip+0x57/0x60
 ? t4_ofld_send+0x10d/0x170 [cxgb4]
 ? cxgb4_remove_tid+0x93/0x110 [cxgb4]
 ? _c4iw_free_ep+0x58/0x110 [iw_cxgb4]
 ? close_con_rpl+0x9f/0x180 [iw_cxgb4]
 ? process_work+0x4f/0x60 [iw_cxgb4]
 ? skb_dequeue+0x59/0x70
 ? process_work+0x43/0x60 [iw_cxgb4]
 ? process_one_work+0x147/0x370
 ? worker_thread+0x4a/0x390
 ? kthread+0x109/0x140
 ? process_one_work+0x370/0x370
 ? kthread_park+0x60/0x60
 ? ret_from_fork+0x29/0x40
Code: d8 00 0f 92 c0 84 c0 74 14 48 8b 05 6f ba a2 00 be fd 00 00 00 ff 90 a0 00 00 00 5d c3 89 fe 48 c7 c7 58 ee 9c 81 e8 d6 35 11 00 <0f> ff 5d c3 0f 1f 44 00 00 55 be 20 00 08 01 48 89 e5 53 48 89
---[ end trace 3630f896456a7327 ]---

I'm happy to share any further information required.

Thanks,
Raju

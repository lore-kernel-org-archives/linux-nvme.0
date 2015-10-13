From: dan.j.williams@intel.com (Williams, Dan J)
Date: Tue, 13 Oct 2015 00:31:07 +0000
Subject: Block integrity registration update
In-Reply-To: <1444683912-7140-1-git-send-email-martin.petersen@oracle.com>
References: <B58D82457FDA0744A320A2FC5AC253B93CBE5758@fmsmsx104.amr.corp.intel.com>
 <1444683912-7140-1-git-send-email-martin.petersen@oracle.com>
Message-ID: <1444696266.9780.13.camel@intel.com>

On Mon, 2015-10-12@17:05 -0400, Martin K. Petersen wrote:
> As requested, here's the integrity registration update for 4.4. Only
> delta is patch 5 which retains the non-PI metadata check as requested by
> Keith as well as the DM rework by Mike. I rebased on top of
> block/for-4.4/drivers to accommodate the NVMe shuffle.
> 
> [PATCH 1/5] block: Move integrity kobject to struct gendisk
> [PATCH 2/5] block: Consolidate static integrity profile properties
> [PATCH 3/5] block: Reduce the size of struct blk_integrity
> [PATCH 4/5] block: Export integrity data interval size in sysfs
> [PATCH 5/5] block: Inline blk_integrity in struct gendisk
> 

I'm triggering the oops below with the libnvdimm unit tests when running
these on top of block.git#for-4.4/drivers, and the problem does not
happen (readily) with them not applied.  I say "readily" because I don't
think this failure mode is new as much as it is making an existing
problem more reproducible.  I'll take a look, but wanted to give a heads
up in the meantime.

See "make check" and README.md in the ndctl repository if you want to
try reproducing...

https://github.com/pmem/ndctl

---

BUG: unable to handle kernel paging request at ffff8800d731bbd0
IP: [<ffff8800d731bbd0>] 0xffff8800d731bbd0
PGD 2f65067 PUD 21fffd067 PMD 80000000d72001e3 
Oops: 0011 [#1] SMP  
Dumping ftrace buffer: 
   (ftrace buffer empty)
Modules linked in: nd_blk(O) nfit_test(O) nfit(O) ip6t_rpfilter
ip6t_REJECT nf_reject_ipv6 xt_conntrack ebtable_nat ebtable_broute
bridge stp llc ebtable_filter ebtables ip6table_nat nf_conntrack_ipv6
nf_defrag_ipv6 nf_nat_ipv6 ip6table_mangle ip6table_security
ip6table_raw ip6table_filter ip6_tables iptable_nat nf_conntrack_ipv4
nf_defrag_ipv4 nf_nat_ipv4 nf_nat nf_conntrack iptable_mangle
iptable_security iptable_raw nd_pmem(O) nd_btt(O) serio_raw nd_e820(O)
libnvdimm(O) nfit_test_iomap(O)
CPU: 1 PID: 420 Comm: kworker/1:1H Tainted: G           O    4.3.0-rc4+
#1546
Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
Workqueue: kintegrityd bio_integrity_verify_fn
task: ffff8800d9cd3fc0 ti: ffff8800d9dc0000 task.ti: ffff8800d9dc0000
RIP: 0010:[<ffff8800d731bbd0>]  [<ffff8800d731bbd0>] 0xffff8800d731bbd0
RSP: 0018:ffff8800d9dc3cd8  EFLAGS: 00010286
RAX: ffff8800d731bbd0 RBX: 0000000000001000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffff8800d7393600 RDI: ffff8800d9dc3d10
RBP: ffff8800d9dc3d68 R08: 0000000000000000 R09: 0000000000000000
R10: 0000160000000000 R11: ffff8800d9cd3fe8 R12: 0000000000001000
R13: ffff8800d9cd3fc0 R14: ffff88020d95ef00 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88021fc40000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: ffff8800d731bbd0 CR3: 00000000da226000 CR4: 00000000000006e0
Stack:
 ffffffff8144d9ae 0000000000000000 ffff880000000000 0000160000000000
 ffff8800d731bbd0 0000000000000000 0000000000000000 ffff8800da780940
 ffff8800d9174000 0000000000000000 0000020000001000 ffff8800cda8380c
Call Trace:
 [<ffffffff8144d9ae>] ? bio_integrity_process+0x12e/0x290
 [<ffffffff8144dd96>] bio_integrity_verify_fn+0x36/0x60
 [<ffffffff810bd2dc>] process_one_work+0x1cc/0x4e0
 [<ffffffff810bd26e>] ? process_one_work+0x15e/0x4e0
 [<ffffffff810bd92b>] worker_thread+0x4b/0x440
 [<ffffffff810bd8e0>] ? rescuer_thread+0x2f0/0x2f0
 [<ffffffff810bd8e0>] ? rescuer_thread+0x2f0/0x2f0
 [<ffffffff810c3993>] kthread+0xf3/0x110
 [<ffffffff810c38a0>] ? kthread_create_on_node+0x230/0x230
 [<ffffffff818f1aaf>] ret_from_fork+0x3f/0x70
 [<ffffffff810c38a0>] ? kthread_create_on_node+0x230/0x230
Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 c0 bb 31 d7 00 88 ff ff c0 bb 31 d7 00 88 ff ff <d0> bb 31 d7 00 88 ff ff d0 bb 31 d7 00 88 ff ff e0 bb 31 d7 00 
RIP  [<ffff8800d731bbd0>] 0xffff8800d731bbd0
 RSP <ffff8800d9dc3cd8>
CR2: ffff8800d731bbd0
---[ end trace 056f87b7ce676294 ]---

From: mlin@kernel.org (Ming Lin)
Date: Thu, 16 Jun 2016 14:47:37 -0700
Subject: target crash / host hang with nvme-all.3 branch of nvme-fabrics
In-Reply-To: <57631D2E.8050508@grimberg.me>
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
 <57631D2E.8050508@grimberg.me>
Message-ID: <CAF1ivSbhMDs0N=QU1+jPZQPL1zv07NOPpGK7d_e3PwF86Q+yPg@mail.gmail.com>

On Thu, Jun 16, 2016@2:42 PM, Sagi Grimberg <sagi@grimberg.me> wrote:
>
>> hrm...
>>
>> Forcing more reconnects, I just hit this.  It looks different from the
>> other
>> issue:
>>
>> general protection fault: 0000 [#1] SMP
>> Modules linked in: rdma_ucm iw_cxgb4 cxgb4 nvmet_rdma rdma_cm iw_cm nvmet
>> null_blk configfs ip6table_filter ip6_tables ebtable_nat ebtables
>> nf_conntrack_ipv4 nf_defrag_ipv4 xt_state nf_conntrack ipt_REJECT
>> nf_reject_
>> ipv4 xt_CHECKSUM iptable_mangle iptable_filter ip_tables bridge autofs4
>> 8021q
>> garp stp llc ipmi_devintf cachefiles fscache ib_ipoib ib_cm ib_uverbs
>> ib_umad
>> iw_nes libcrc32c iw_cxgb3 cxgb3 mdio ib_qib rdmavt mlx4_en i   b_mthca
>> dm_mirror
>> dm_region_hash dm_log vhost_net macvtap macvlan vhost tun kvm_intel kvm
>> irqbypass uinput iTCO_wdt iTCO_vendor_support mxm_wmi pcspkr mlx4_ib
>> ib_core
>> ipv6 mlx4_core dm_mod i2c_i801 sg lpc_ich mfd_cor   e nvme nvme_core
>> acpi_cpufreq ioatdma igb dca i2c_algo_bit i2c_core ptp pps_core wmi
>> ext4(E)
>> mbcache(E) jbd2(E) sd_mod(E) ahci(E) libahci(E) [last unloaded: cxgb4]
>> CPU: 3 PID: 19213 Comm: kworker/3:10 Tainted: G            E
>> 4.7.0-rc2-nvmf-all.3+rxe+ #84
>> Hardware name: Supermicro X9DR3-F/X9DR3-F, BIOS 3.2a 07/09/2015
>> Workqueue: events nvmet_rdma_release_queue_work [nvmet_rdma]
>> task: ffff88103d68cf00 ti: ffff880fdf7a4000 task.ti: ffff880fdf7a4000
>> RIP: 0010:[<ffffffffa01ef5b7>]  [<ffffffffa01ef5b7>]
>> nvmet_rdma_free_rsps+0x67/0xb0 [nvmet_rdma]
>> RSP: 0018:ffff880fdf7a7bb8  EFLAGS: 00010202
>> RAX: dead000000000100 RBX: 000000000000001f RCX: 0000000000000001
>> RDX: dead000000000200 RSI: ffff880fdd884290 RDI: dead000000000200
>> RBP: ffff880fdf7a7bf8 R08: dead000000000100 R09: ffff88103c768140
>> R10: ffff88103c7682c0 R11: ffff88103c768340 R12: 00000000000044c8
>> R13: ffff88103db39c00 R14: 0000000000000100 R15: ffff88103e29cec0
>> FS:  0000000000000000(0000) GS:ffff88107f2c0000(0000)
>> knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 0000000001016b00 CR3: 000000103bcb7000 CR4: 00000000000406e0
>> Stack:
>>   ffff880fdd8a23f8 00000000ffac1a05 ffff880fdf7a7bf8 ffff88103db39c00
>>   ffff88103c64cc00 ffffe8ffffac1a00 0000000000000000 ffffe8ffffac1a05
>>   ffff880fdf7a7c18 ffffffffa01ef652 0000000000000246 ffff88103e29cec0
>> Call Trace:
>>   [<ffffffffa01ef652>] nvmet_rdma_free_queue+0x52/0xa0 [nvmet_rdma]
>>   [<ffffffffa01ef6d3>] nvmet_rdma_release_queue_work+0x33/0x70
>> [nvmet_rdma]
>
>
> This looks more like a double-free/use-after-free condition...
> I'll try to reproduce this next week.

Interesting. I'll also try to reproduce it.

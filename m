From: swise@opengridcomputing.com (Steve Wise)
Date: Thu, 16 Jun 2016 10:24:37 -0500
Subject: target crash / host hang with nvme-all.3 branch of nvme-fabrics
In-Reply-To: <20160616145724.GA32635@infradead.org>
References: <00d801d1c7de$e17fc7d0$a47f5770$@opengridcomputing.com>
 <20160616145724.GA32635@infradead.org>
Message-ID: <012a01d1c7e3$31c08820$95419860$@opengridcomputing.com>

> 
> On Thu, Jun 16, 2016@09:53:45AM -0500, Steve Wise wrote:
> > [11436.603807] nvmet: ctrl 1 keep-alive timer (15 seconds) expired!
> > [11436.609866] BUG: unable to handle kernel NULL pointer dereference at
> > 0000000000000050
> > [11436.617764] IP: [<ffffffffa09c6dff>] nvmet_rdma_delete_ctrl+0x6f/0x100
> 
> Can you check using gdb where in the code this is?
> 
> This is the obvious crash we'll need to fix first.  Then we'll need to
> figure out why the keep alive timer times out under this workload.
> 

While Yoichi is gathering this on his setup, I'm trying to reproduce it on mine.
I hit a similar crash by loading up a fio job, and then bringing down the
interface of the port used on the host node, let the target timer expire, then
bring the host interface back up.  The target freed the queues, and eventually
the host reconnected, and the test continued.  But shortly after that I hit this
on the target.  It looks related:

BUG: unable to handle kernel NULL pointer dereference at 0000000000000008
IP: [<ffffffffa0203b69>] nvmet_rdma_queue_disconnect+0x49/0x90 [nvmet_rdma]
PGD 102f0d1067 PUD 102ccc5067 PMD 0
Oops: 0002 [#1] SMP
Modules linked in: iw_cxgb4 ib_isert iscsi_target_mod target_core_user uio
target_core_pscsi target_core_file target_core_iblock target_core_mod udp_tunnel
ip6_udp_tunnel rdma_ucm cxgb4 nvmet_rdma rdma_cm iw_cm nvmet null_blk configfs
ip6table_filter ip6_tables ebtable_nat ebtables nf_conntrack_ipv4 nf_defrag_ipv4
xt_state nf_conntrack ipt_REJECT nf_reject_ipv4 xt_CHECKSUM iptable_mangle
iptable_filter ip_tables bridge autofs4 8021q garp stp llc ipmi_devintf
cachefiles fscache ib_ipoib ib_cm ib_uverbs ib_umad iw_nes libcrc32c iw_cxgb3
cxgb3 mdio ib_qib rdmavt mlx4_en ib_mthca dm_mirror dm_region_hash dm_log
vhost_net macvtap macvlan vhost tun kvm_intel kvm irqbypass uinput iTCO_wdt
iTCO_vendor_support mxm_wmi pcspkr mlx4_ib ib_core ipv6 mlx4_core dm_mod
i2c_i801 sg lpc_ich mfd_core acpi_cpufreq nvme nvme_core ioatdma igb dca
i2c_algo_bit i2c_core ptp pps_core wmi ext4(E) mbcache(E) jbd2(E) sd_mod(E)
ahci(E) libahci(E) [last unloaded: ib_rxe]
CPU: 5 PID: 106 Comm: kworker/5:1 Tainted: G            E
4.7.0-rc2-nvmf-all.3+rxe+ #83
Hardware name: Supermicro X9DR3-F/X9DR3-F, BIOS 3.2a 07/09/2015
Workqueue: events nvmet_keep_alive_timer [nvmet]
task: ffff88103f3e8e00 ti: ffff88103f3ec000 task.ti: ffff88103f3ec000
RIP: 0010:[<ffffffffa0203b69>]  [<ffffffffa0203b69>]
nvmet_rdma_queue_disconnect+0x49/0x90 [nvmet_rdma]
RSP: 0018:ffff88103f3efb98  EFLAGS: 00010282
RAX: ffff88102ebe4320 RBX: ffff88102ebe4200 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffff88103f3e8e80 RDI: ffffffffa02061e0
RBP: ffff88103f3efbd8 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000d28 R11: 0000000000000001 R12: ffff88107f355c40
R13: ffffe8ffffb41a00 R14: 0000000000000000 R15: ffffe8ffffb41a05
FS:  0000000000000000(0000) GS:ffff88107f340000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000008 CR3: 000000102f0f2000 CR4: 00000000000406e0
Stack:
 ffff88102ebe4200 ffff88103f3e8e80 ffff88102ebe4200 ffffffffffffff10
 0000000000000000 0000000000000010 0000000000000292 ffff88102ebe4200
 ffff88103f3efc18 ffffffffa0203c9e ffffffffa0206210 0000000000000001
Call Trace:
 [<ffffffffa0203c9e>] nvmet_rdma_delete_ctrl+0xee/0x120 [nvmet_rdma]
 [<ffffffffa01d4237>] nvmet_keep_alive_timer+0x37/0x40 [nvmet]
 [<ffffffff8107cb5b>] process_one_work+0x17b/0x510

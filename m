From: maxg@mellanox.com (Max Gurtovoy)
Date: Tue, 17 Apr 2018 18:35:31 +0300
Subject: [PATCH 1/1] nvmet-rdma: Add error flow for post_recv failures
In-Reply-To: <20180417151405.GA24654@lst.de>
References: <1523885152-20800-1-git-send-email-maxg@mellanox.com>
 <20180417151405.GA24654@lst.de>
Message-ID: <8efe3839-a1a7-5956-8e50-d780d404a2b3@mellanox.com>



On 4/17/2018 6:14 PM, Christoph Hellwig wrote:
> On Mon, Apr 16, 2018@04:25:52PM +0300, Max Gurtovoy wrote:
>> Posting receive buffer operation can fail, thus we should
>> make sure there is no memory leakage in that flow.
> 
> This looks reasonable, but can you explain the memory leak a bit
> better?  In general once posting a WR fails we should be tearing
> down the QP rather sooner than later, where are we leaking memory?
> 

Sure, In case we fail in the initial post_recv (SRQ or non SRQ) we don't 
have an error flow, right ?

regarding the fast-path, we don't leak there (just want to tear it down 
sooner).
Actually this is the secondary issue I'm debugging.

The first one is that I'm getting list_del curruption under fatal error 
injection state:

[ 1441.115877] list_del corruption, c000003f37717c30->next is 
LIST_POISON1 (5deadbeef0000100)
[ 1441.115980] ------------[ cut here ]------------
[ 1441.116053] WARNING: CPU: 19 PID: 12722 at lib/list_debug.c:47 
__list_del_entry_valid+0x98/0x100
[ 1441.116141] Modules linked in: nvmet_rdma(OE) rdma_cm(OE) iw_cm(OE) 
nvmet(OE) nvme(OE) nvme_core(OE) nfsv3 nfs_acl nfs lockd grace fscache 
xt_CHECKSUM iptable_mangle ipt_MASQUERADE nf_nat_masquerade_ipv4 
iptable_nat nf_nat_ipv4 nf_nat nf_conntrack_ipv4 nf_defrag_ipv4 
xt_conntrack nf_conntrack libcrc32c ipt_REJECT nf_reject_ipv4 tun 
ebtable_filter ebtables ip6table_filter ip6_tables iptable_filter bridge 
stp llc ib_ipoib(OE) ib_cm(OE) ib_uverbs(OE) ib_umad(OE) mlx5_ib(OE) 
mlx5_core(OE) cxl mlx4_en(OE) mlx4_ib(OE) ib_core(OE) mlx4_core(OE) 
mlx_compat(OE) devlink kvm_hv kvm i2c_dev sunrpc dm_mirror 
dm_region_hash dm_log dm_mod sg shpchp at24 ofpart uio_pdrv_genirq uio 
powernv_flash mtd ipmi_powernv opal_prd ipmi_devintf ipmi_msghandler 
i2c_opal ibmpowernv knem(OE) ip_tables ext4 mbcache jbd2 sd_mod
[ 1441.117066]  nouveau ast i2c_algo_bit drm_kms_helper syscopyarea 
sysfillrect sysimgblt fb_sys_fops ttm drm ahci libahci libata tg3 
i2c_core ptp pps_core [last unloaded: mlx_compat]
[ 1441.117257] CPU: 19 PID: 12722 Comm: kworker/19:17 Kdump: loaded 
Tainted: G        W  OE  ------------   4.14.0-49.el7a.ppc64le #1
[ 1441.117421] Workqueue: events nvmet_rdma_release_queue_work [nvmet_rdma]
[ 1441.117497] task: c000003fd0130e00 task.stack: c000003fd644c000
[ 1441.117622] NIP:  c0000000006a4bd8 LR: c0000000006a4bd4 CTR: 
000000003003da4c
[ 1441.117729] REGS: c000003fd644f8b0 TRAP: 0700   Tainted: G        W 
OE  ------------    (4.14.0-49.el7a.ppc64le)
[ 1441.117864] MSR:  9000000000029033 <SF,HV,EE,ME,IR,DR,RI,LE>  CR: 
22132822  XER: 20040000
[ 1441.117948] CFAR: c0000000001d487c SOFTE: 1
[ 1441.117948] GPR00: c0000000006a4bd4 c000003fd644fb30 c0000000014c7e00 
000000000000004e
[ 1441.117948] GPR04: c000003fef03cdd0 c000003fef053648 9000000000009033 
0000000000000000
[ 1441.117948] GPR08: 0000000000000007 c00000000105346c 0000003fedff0000 
9000000000001003
[ 1441.117948] GPR12: 0000000022132822 c000000007a1d100 c0000000001708a8 
c000003f43f78880
[ 1441.117948] GPR16: c000003fef057280 c00000000137c4b0 c000003fef056f78 
c000003fef056f20
[ 1441.117948] GPR20: 0000000000000000 0000000000000000 fffffffffffffef7 
0000000000000402
[ 1441.117948] GPR24: 0000000000000000 0000000000024000 c000003f31be2280 
c00020396ab12000
[ 1441.117948] GPR28: 5deadbeef0000100 5deadbeef0000200 0000000000017c40 
c000003f37717a00
[ 1441.459201] NIP [c0000000006a4bd8] __list_del_entry_valid+0x98/0x100
[ 1441.459312] LR [c0000000006a4bd4] __list_del_entry_valid+0x94/0x100
[ 1441.459395] Call Trace:
[ 1441.459418] [c000003fd644fb30] [c0000000006a4bd4] 
__list_del_entry_valid+0x94/0x100 (unreliable)
[ 1441.459511] [c000003fd644fb90] [c008000012132064] 
nvmet_rdma_free_rsps+0xa4/0x120 [nvmet_rdma]
[ 1441.461005] [c000003fd644fbf0] [c008000012132c44] 
nvmet_rdma_release_queue_work+0xe4/0x250 [nvmet_rdma]

I'm still working on this one. Seems like there is a rsp that wasn't 
returned to free_rsps list...

So if you have a hint it will be great :)
I suspect the async_events...

-Max.

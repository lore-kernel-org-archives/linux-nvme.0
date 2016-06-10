From: mlin@kernel.org (Ming Lin)
Date: Fri, 10 Jun 2016 11:43:27 -0700
Subject: nvme-fabrics: crash at nvme connect-all
In-Reply-To: <020b01d1c334$45077f50$cf167df0$@opengridcomputing.com>
References: <53708289.31891804.1465463883806.JavaMail.zimbra@kalray.eu>
 <20160609132459.GA5105@infradead.org>
 <1290178000.33062227.1465486654766.JavaMail.zimbra@kalray.eu>
 <04d301d1c28d$183af7b0$48b0e710$@opengridcomputing.com>
 <CAF1ivSb2fvjEzCxWXnrxv_i74SRm2qxWZ-RiKpEaGOx-Dk3f1A@mail.gmail.com>
 <04e301d1c292$d6c34430$8449cc90$@opengridcomputing.com>
 <CAF1ivSYBtsuvm-UO6osPAVT-krpF7iXqWy_8LheyWDDoAdWL1A@mail.gmail.com>
 <055801d1c29f$e164c000$a42e4000$@opengridcomputing.com>
 <01c601d1c32a$59576ec0$0c064c40$@opengridcomputing.com>
 <020b01d1c334$45077f50$cf167df0$@opengridcomputing.com>
Message-ID: <CAF1ivSb82yM94jande+kfomG3hx6PwbUAzTb3VPNygd05uVbXg@mail.gmail.com>

On Fri, Jun 10, 2016@9:22 AM, Steve Wise <swise@opengridcomputing.com> wrote:

>
> I enabled lots of kernel memory debugging and now hit this.  Perhaps a clue?  Freeing an active timer list widget?
>
> nvme nvme1: new ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery", addr 10.0.1.14:4420
> nvme nvme1: creating 16 I/O queues.
> nvme nvme1: Connect rejected, no private data.
> nvme nvme1: rdma_resolve_addr wait failed (-104).
> nvme nvme1: failed to initialize i/o queue: -104
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 10440 at lib/debugobjects.c:263 debug_print_object+0x8e/0xb0
> ODEBUG: free active (active state 0) object type: timer_list hint: delayed_work_timer_fn+0x0/0x20
> Modules linked in: nvme_rdma nvme_fabrics rdma_ucm rdma_cm iw_cm configfs iw_cxgb4 cxgb4 ip6table_filter ip6_tables ebtable_nat ebtables nf_conntrack_ipv4 nf_defrag_ipv4 xt_state nf_conntrack ipt_REJECT nf_reject_ipv4 xt_CHECKSUM iptable_mangle iptable_filter ip_tables bridge autofs4 8021q garp stp llc cachefiles fscache ib_ipoib ib_cm ib_uverbs ib_umad iw_nes libcrc32c iw_cxgb3 cxgb3 mdio ib_qib rdmavt mlx4_en ib_mthca dm_mirror dm_region_hash dm_log vhost_net macvtap macvlan vhost tun kvm irqbypass uinput iTCO_wdt iTCO_vendor_support pcspkr mlx4_ib ib_core ipv6 mlx4_core dm_mod sg lpc_ich mfd_core i2c_i801 nvme nvme_core igb dca ptp pps_core acpi_cpufreq ext4(E) mbcache(E) jbd2(E) sd_mod(E) nouveau(E) ttm(E) drm_kms_helper(E) drm(E) fb_sys_fops(E) sysimgblt(E) sysfillrect(E) syscopyarea(E) i2c_algo_bit(E) i2c_core(E) mxm_wmi(E) video(E) ahci(E) libahci(E) wmi(E) [last unloaded: cxgb4]
> CPU: 1 PID: 10440 Comm: nvme Tainted: G            E   4.7.0-rc2-nvmf-all.2+ #42
> Hardware name: Supermicro X9DR3-F/X9DR3-F, BIOS 3.2a 07/09/2015
>  0000000000000000 ffff881027a13a18 ffffffff812f032d ffffffff8130e65e
>  ffff881027a13a78 ffff881027a13a78 0000000000000000 ffff881027a13a68
>  ffffffff8106694d 0000031800000001 000001072aad7ce8 dead000000000200
> Call Trace:
>  [<ffffffff812f032d>] dump_stack+0x51/0x74
>  [<ffffffff8130e65e>] ? debug_print_object+0x8e/0xb0
>  [<ffffffff8106694d>] __warn+0xfd/0x120
>  [<ffffffff81066a29>] warn_slowpath_fmt+0x49/0x50
>  [<ffffffff81182d72>] ? kfree_const+0x22/0x30
>  [<ffffffff8130e65e>] debug_print_object+0x8e/0xb0
>  [<ffffffff81080850>] ? __queue_work+0x520/0x520
>  [<ffffffff8130ecbe>] __debug_check_no_obj_freed+0x1ee/0x270
>  [<ffffffff8130ed57>] debug_check_no_obj_freed+0x17/0x20
>  [<ffffffff811c3aac>] kfree+0x9c/0x120
>  [<ffffffff81182d72>] ? kfree_const+0x22/0x30
>  [<ffffffff812f2f3c>] ? kobject_cleanup+0x9c/0x1b0
>  [<ffffffffa04cc696>] nvme_rdma_free_ctrl+0xa6/0xc0 [nvme_rdma]
>  [<ffffffffa06fcc36>] nvme_free_ctrl+0x46/0x60 [nvme_core]
>  [<ffffffffa06feb2b>] nvme_put_ctrl+0x1b/0x20 [nvme_core]
>  [<ffffffffa04cf1a2>] nvme_rdma_create_ctrl+0x412/0x4f0 [nvme_rdma]
>  [<ffffffffa04c5d02>] nvmf_create_ctrl+0x182/0x210 [nvme_fabrics]
>  [<ffffffffa04c5e3c>] nvmf_dev_write+0xac/0x110 [nvme_fabrics]
>  [<ffffffff811d9c24>] __vfs_write+0x34/0x120
>  [<ffffffff81002515>] ? trace_event_raw_event_sys_enter+0xb5/0x130
>  [<ffffffff811d9dc9>] vfs_write+0xb9/0x130
>  [<ffffffff811f9592>] ? __fdget_pos+0x12/0x50
>  [<ffffffff811da9b9>] SyS_write+0x59/0xc0
>  [<ffffffff81002d6d>] do_syscall_64+0x6d/0x160
>  [<ffffffff81642e7c>] entry_SYSCALL64_slow_path+0x25/0x25
> ---[ end trace 7f80ebccfc6bd15d ]---

I can reproduce this and below patch fixed it.
[PATCH] nvme-rdma: correctly stop keep alive on error path
http://lists.infradead.org/pipermail/linux-nvme/2016-June/004931.html

Could you also give it a try and see if it helps for the crash you saw?

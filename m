From: yi.zhang@redhat.com (Yi Zhang)
Date: Mon, 11 Dec 2017 21:29:40 +0800
Subject: BUG: NULL pointer at IP: blk_mq_map_swqueue+0xbc/0x200 on
 4.15.0-rc2
In-Reply-To: <20171211035844.GB22819@ming.t460p>
References: <799322399.34367785.1512659684033.JavaMail.zimbra@redhat.com>
 <1443577037.35143768.1512717869183.JavaMail.zimbra@redhat.com>
 <20171211035844.GB22819@ming.t460p>
Message-ID: <07dd2fb3-60e0-445c-211c-6201982ebab4@redhat.com>



On 12/11/2017 11:58 AM, Ming Lei wrote:
> Hi Zhang Yi,
>
> On Fri, Dec 08, 2017@02:24:29AM -0500, Yi Zhang wrote:
>> Hi
>> I found this issue during nvme blk-mq io scheduler test on 4.15.0-rc2, let me know if you need more info, thanks.
>>
>> Reproduce steps
>> MQ_IOSCHEDS=`sed 's/[][]//g' /sys/block/nvme0n1/queue/scheduler
>> dd if=/dev/nvme0n1p1 of=/dev/null bs=4096 &
>> while kill -0 $! 2>/dev/null; do
>> 	for SCHEDULER in $MQ_IOSCHEDS; do
>> 		echo "INFO: BLK-MQ IO SCHEDULER:$SCHEDULER testing during IO"
>> 		echo $SCHEDULER > /sys/block/nvme0n1/queue/scheduler
>> 		echo 1 >/sys/bus/pci/devices/0000\:84\:00.0/reset
>> 		sleep 0.5
>> 	done
>> done
>>
>> Kernel log:
>> [  101.202734] BUG: unable to handle kernel NULL pointer dereference at 0000000094d3013f
>> [  101.211487] IP: blk_mq_map_swqueue+0xbc/0x200
> As we talked offline, this IP points to cpumask_set_cpu(), seems this
> case may happen when one CPU isn't mapped to any hw queue, could you test
> the following patch to see if it helps your issue?

Hi Ming
With this patch, I reproduced another BUG, here is part for the log

[?? 93.263237] ------------[ cut here ]------------
[?? 93.268391] kernel BUG at drivers/nvme/host/pci.c:408!
[?? 93.274146] invalid opcode: 0000 [#1] SMP
[?? 93.278618] Modules linked in: nfsv3 nfs_acl rpcsec_gss_krb5 
auth_rpcgss nfsv4 dns_resolver nfs lockd grace fscache sunrpc ipmi_ssif 
vfat fat intel_rapl sb_edac x86_pkg_temp_thermal intel_powerclamp 
coretemp kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul 
ghash_clmulni_intel iTCO_wdt intel_cstate ipmi_si iTCO_vendor_support 
intel_uncore mxm_wmi mei_me ipmi_devintf intel_rapl_perf pcspkr sg 
ipmi_msghandler lpc_ich dcdbas mei shpchp acpi_power_meter wmi 
dm_multipath ip_tables xfs libcrc32c sd_mod mgag200 i2c_algo_bit 
drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops ttm drm 
ahci libahci nvme libata crc32c_intel nvme_core tg3 megaraid_sas ptp 
i2c_core pps_core dm_mirror dm_region_hash dm_log dm_mod
[?? 93.349071] CPU: 5 PID: 1842 Comm: sh Not tainted 4.15.0-rc2.ming+ #4
[?? 93.356256] Hardware name: Dell Inc. PowerEdge R730xd/072T6D, BIOS 
2.5.5 08/16/2017
[?? 93.364801] task: 00000000fb8abf2a task.stack: 0000000028bd82d1
[?? 93.371408] RIP: 0010:nvme_init_request+0x36/0x40 [nvme]
[?? 93.377333] RSP: 0018:ffffc90002537ca8 EFLAGS: 00010246
[?? 93.383161] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 
0000000000000008
[?? 93.391122] RDX: 0000000000000000 RSI: ffff880276ae0000 RDI: 
ffff88047bae9008
[?? 93.399084] RBP: ffff88047bae9008 R08: ffff88047bae9008 R09: 
0000000009dabc00
[?? 93.407045] R10: 0000000000000004 R11: 000000000000299c R12: 
ffff880186bc1f00
[?? 93.415007] R13: ffff880276ae0000 R14: 0000000000000000 R15: 
0000000000000071
[?? 93.422969] FS:? 00007f33cf288740(0000) GS:ffff88047ba80000(0000) 
knlGS:0000000000000000
[?? 93.431996] CS:? 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[?? 93.438407] CR2: 00007f33cf28e000 CR3: 000000047e5bb006 CR4: 
00000000001606e0
[?? 93.446368] Call Trace:
[?? 93.449103]? blk_mq_alloc_rqs+0x231/0x2a0
[?? 93.453579]? blk_mq_sched_alloc_tags.isra.8+0x42/0x80
[?? 93.459214]? blk_mq_init_sched+0x7e/0x140
[?? 93.463687]? elevator_switch+0x5a/0x1f0
[?? 93.467966]? ? elevator_get.isra.17+0x52/0xc0
[?? 93.472826]? elv_iosched_store+0xde/0x150
[?? 93.477299]? queue_attr_store+0x4e/0x90
[?? 93.481580]? kernfs_fop_write+0xfa/0x180
[?? 93.485958]? __vfs_write+0x33/0x170
[?? 93.489851]? ? __inode_security_revalidate+0x4c/0x60
[?? 93.495390]? ? selinux_file_permission+0xda/0x130
[?? 93.500641]? ? _cond_resched+0x15/0x30
[?? 93.504815]? vfs_write+0xad/0x1a0
[?? 93.508512]? SyS_write+0x52/0xc0
[?? 93.512113]? do_syscall_64+0x61/0x1a0
[?? 93.516199]? entry_SYSCALL64_slow_path+0x25/0x25
[?? 93.521351] RIP: 0033:0x7f33ce96aab0
[?? 93.525337] RSP: 002b:00007ffe57570238 EFLAGS: 00000246 ORIG_RAX: 
0000000000000001
[?? 93.533785] RAX: ffffffffffffffda RBX: 0000000000000006 RCX: 
00007f33ce96aab0
[?? 93.541746] RDX: 0000000000000006 RSI: 00007f33cf28e000 RDI: 
0000000000000001
[?? 93.549707] RBP: 00007f33cf28e000 R08: 000000000000000a R09: 
00007f33cf288740
[?? 93.557669] R10: 00007f33cf288740 R11: 0000000000000246 R12: 
00007f33cec42400
[?? 93.565630] R13: 0000000000000006 R14: 0000000000000001 R15: 
0000000000000000
[?? 93.573592] Code: 4c 8d 40 08 4c 39 c7 74 16 48 8b 00 48 8b 04 08 48 
85 c0 74 16 48 89 86 78 01 00 00 31 c0 c3 8d 4a 01 48 63 c9 48 c1 e1 03 
eb de <0f> 0b 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 85 f6 53 48 89
[?? 93.594676] RIP: nvme_init_request+0x36/0x40 [nvme] RSP: ffffc90002537ca8
[?? 93.602273] ---[ end trace 810dde3993e5f14e ]---

Full log:
https://pastebin.com/iafzB2DE

> --
> diff --git a/block/blk-mq-pci.c b/block/blk-mq-pci.c
> index 76944e3271bf..c60d06bfa76e 100644
> --- a/block/blk-mq-pci.c
> +++ b/block/blk-mq-pci.c
> @@ -33,6 +33,9 @@ int blk_mq_pci_map_queues(struct blk_mq_tag_set *set, struct pci_dev *pdev)
>   	const struct cpumask *mask;
>   	unsigned int queue, cpu;
>   
> +	for_each_possible_cpu(cpu)
> +		set->mq_map[cpu] = 0;
> +
>   	for (queue = 0; queue < set->nr_hw_queues; queue++) {
>   		mask = pci_irq_get_affinity(pdev, queue);
>   		if (!mask)
> Thanks,
> Ming
>
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme

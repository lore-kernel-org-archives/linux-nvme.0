From: yizhan@redhat.com (Yi Zhang)
Date: Fri, 3 Mar 2017 18:34:44 +0800
Subject: NVMe issues with NVMe rescan/reset/remove operation
In-Reply-To: <20170223165757.GC5196@localhost.localdomain>
References: <1607299454.26128419.1487559924230.JavaMail.zimbra@redhat.com>
 <1953565943.26260263.1487572436764.JavaMail.zimbra@redhat.com>
 <20170223165757.GC5196@localhost.localdomain>
Message-ID: <33adcd92-579c-2b75-e5a8-5345769ea0f9@redhat.com>



On 02/24/2017 12:57 AM, Keith Busch wrote:
> On Mon, Feb 20, 2017@01:33:56AM -0500, Yi Zhang wrote:
>> Hi
>>
>> I found several issues during NVMe rescan/reset/remove with IO on 4.10.0-rc8, could you help check it, thanks.
>>
>> Steps I used:
>> #fio -filename=/dev/nvme0n1p1 -iodepth=1 -thread -rw=randwrite -ioengine=psync -bssplit=5k/10:9k/10:13k/10:17k/10:21k/10:25k/10:29k/10:33k/10:37k/10:41k/10 -bs_unaligned -runtime=1200 -size=-group_reporting -name=mytest -numjobs=60 &
>> #lspci | grep -i nvme
>> 84:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd NVMe SSD Controller 172X (rev 01)
>> #sleep 35
>> #echo 1 > /sys/bus/pci/devices/0000:84:00.0/rescan
>> #echo 1 > /sys/bus/pci/devices/0000:84:00.0/reset
>> #echo 1 > /sys/bus/pci/devices/0000:84:00.0/remove
>>
>> 1. kernel BUG at block/blk-mq.c:374!
>>     Full log: http://pastebin.com/fymFAxjP
> This should be fixed with this commit staged for 4.11:
>
> https://git.kernel.org/cgit/linux/kernel/git/axboe/linux-block.git/commit/?id=f33447b90e96076483525b21cc4e0a8977cdd07c
>   
Thanks Keith
I will retry with 4.11 and update the results later.

Yi
>> [  129.974989] kernel BUG at block/blk-mq.c:374!
>> [  129.979849] invalid opcode: 0000 [#1] SMP
>> [  129.984318] Modules linked in: ipmi_ssif vfat fat intel_rapl sb_edac edac_core x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul ghash_clmulni_intel iTCO_wdt iTCO_vendor_support intel_cstate mei_me mei intel_uncore mxm_wmi ipmi_si dcdbas intel_rapl_perf lpc_ich ipmi_devintf pcspkr sg ipmi_msghandler shpchp acpi_power_meter wmi nfsd auth_rpcgss nfs_acl lockd grace dm_multipath sunrpc ip_tables xfs libcrc32c sd_mod mgag200 i2c_algo_bit drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops ttm drm nvme crc32c_intel nvme_core ahci i2c_core libahci libata tg3 megaraid_sas ptp pps_core fjes dm_mirror dm_region_hash dm_log dm_mod
>> [  130.051563] CPU: 2 PID: 1287 Comm: kworker/2:1H Not tainted 4.10.0-rc8 #1
>> [  130.059139] Hardware name: Dell Inc. PowerEdge R730xd/072T6D, BIOS 2.2.5 09/06/2016
>> [  130.067689] Workqueue: kblockd blk_mq_timeout_work
>> [  130.073033] task: ffff88027373ad00 task.stack: ffffc900028c0000
>> [  130.079639] RIP: 0010:blk_mq_end_request+0x58/0x70
>> [  130.084982] RSP: 0018:ffffc900028c3d50 EFLAGS: 00010202
>> [  130.090810] RAX: 0000000000000001 RBX: ffff8804712260c0 RCX: ffff880167377d88
>> [  130.098771] RDX: 0000000000001000 RSI: 0000000000001000 RDI: 0000000000000000
>> [  130.106732] RBP: ffffc900028c3d60 R08: 0000000000000006 R09: ffff880167377d00
>> [  130.114694] R10: 0000000000001000 R11: 0000000000000001 R12: 00000000fffffffb
>> [  130.122656] R13: ffff8804709be300 R14: 0000000000000002 R15: ffff880471bccb40
>> [  130.130619] FS:  0000000000000000(0000) GS:ffff880277c40000(0000) knlGS:0000000000000000
>> [  130.139647] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [  130.146058] CR2: 00007f77f827ef78 CR3: 0000000384a19000 CR4: 00000000001406e0
>> [  130.154018] Call Trace:
>> [  130.156750]  blk_mq_check_expired+0x76/0x80
>> [  130.161417]  bt_iter+0x45/0x50
>> [  130.164823]  blk_mq_queue_tag_busy_iter+0xdd/0x1f0
>> [  130.170170]  ? blk_mq_rq_timed_out+0x70/0x70
>> [  130.174933]  ? blk_mq_rq_timed_out+0x70/0x70
>> [  130.179698]  ? __switch_to+0x140/0x450
>> [  130.183879]  blk_mq_timeout_work+0x88/0x170
>> [  130.188549]  process_one_work+0x165/0x410
>> [  130.193014]  worker_thread+0x137/0x4c0
>> [  130.197195]  kthread+0x101/0x140
>> [  130.200794]  ? rescuer_thread+0x3b0/0x3b0
>> [  130.205265]  ? kthread_park+0x90/0x90
>> [  130.209353]  ret_from_fork+0x2c/0x40
>> [  130.213340] Code: 48 85 c0 74 0d 44 89 e6 48 89 df ff d0 5b 41 5c 5d c3 48 8b bb 70 01 00 00 48 85 ff 75 0f 48 89 df e8 5d f0 ff ff 5b 41 5c 5d c3 <0f> 0b e8 51 f0 ff ff 90 eb e9 0f 1f 40 00 66 2e 0f 1f 84 00 00
>> [  130.234425] RIP: blk_mq_end_request+0x58/0x70 RSP: ffffc900028c3d50
>> [  130.241453] ---[ end trace 735162105b943c01 ]---
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme

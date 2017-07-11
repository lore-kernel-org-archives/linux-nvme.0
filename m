From: pgadmin@pse-consulting.de (Andreas Pflug)
Date: Tue, 11 Jul 2017 09:44:47 +0200
Subject: kernel BUG at nvme/host/pci.c
In-Reply-To: <20170710190818.GA13671@localhost.localdomain>
References: <28fcb21a-35b6-61c1-29e0-9adcc954c98c@pse-consulting.de>
 <20170710190818.GA13671@localhost.localdomain>
Message-ID: <64da8c4d-2d69-22fa-06a0-aa4f11903e39@pse-consulting.de>

Am 10.07.17 um 21:08 schrieb Keith Busch:
> On Mon, Jul 10, 2017@08:03:16PM +0200, Andreas Pflug wrote:
>> I'm running a patched (see below) debian 4.9.30 kernel with xen4.8.1 on
>> Debian9. Starting a specific virtual machine, very soon the kernel will emit
>>
>>     kernel BUG at /usr/src/kernel/linux-4.9.30/drivers/nvme/host/pci.c:495!
>>
>> via netconsole to my logging host, and become unstable until hard reset.
>> Hardware is dual E5-2620v4 on Supermicro 10DRI-T with two SAMSUNG
>> MZQLW960HMJP-00003 NVME disks (mdadm RAID-1) backing the vhds (os on
>> separate SSD).
>>
>> The bug was reported to debian as https://bugs.debian.org/866511 . According
>> to Ben Hutchings' advice, I patched the standard kernel with
>> 0001-swiotlb-ensure-that-page-sized-mappings-are-page-ali.patch since its
>> description sounded promising, but the bug remains.
> The BUG_ON means the nvme driver was given a scatter list that is invalid
> for the constraints the NVMe device was registered with. There have been
> issues in the past when NVMe is used with stacking devices like RAID,
> but I think they are all resolved. Would you happen to know if this
> is successful with the 4.12 kernel? If so, I might be able to find the
> patch(es) for 4.9-stable, otherwise we'll need to fix it there first.

Tested with 4.12.0, result is

  kernel BUG at drivers/nvme/host/pci.c:610!

Kernel seems to recover from that, but I did a reboot anyway.

Log file attached.


Regards,

Andreas

-------------- next part --------------
Jul 11 09:37:28 xen2 [  110.002253] ------------[ cut here ]------------
Jul 11 09:37:28 xen2 [  110.002310] kernel BUG at drivers/nvme/host/pci.c:610!
Jul 11 09:37:28 xen2 [  110.002336] invalid opcode: 0000 [#1] SMP
Jul 11 09:37:28 xen2 [  110.002357] Modules linked in: xt_physdev br_netfilter iptable_filter xen_netback xen_blkback netconsole configfs bridge xen_gntdev xen_evtchn xenfs xen_privcmd dm_snapshot dm_bufio intel_rapl sb_edac x86_pkg_temp_thermal intel_powerclamp coretemp crct10dif_pclmul crc32_pclmul ghash_clmulni_intel pcbc aesni_intel aes_x86_64 iTCO_wdt crypto_simd iTCO_vendor_support glue_helper mxm_wmi cryptd snd_pcm snd_timer snd soundcore intel_rapl_perf pcspkr ast ttm e1000e drm_kms_helper joydev i2c_i801 ixgbe mei_me nvme drm ehci_pci ptp lpc_ich i2c_algo_bit sg mfd_core ehci_hcd mei pps_core nvme_core mdio ioatdma shpchp dca wmi acpi_power_meter 8021q garp mrp stp llc button ipmi_si ipmi_devintf ipmi_msghandler drbd lru_cache sunrpc ip_tables x_tables autofs4 ext4 crc16 jbd2 fscrypto mbcache raid10 raid456 libcrc32c
Jul 11 09:37:28 xen2 [  110.002638]  crc32c_generic async_raid6_recov async_memcpy async_pq async_xor xor async_tx evdev hid_generic usbhid hid raid6_pq raid0 multipath linear bcache dm_mod raid1 md_mod sd_mod crc32c_intel ahci libahci xhci_pci xhci_hcd libata usbcore scsi_mod
Jul 11 09:37:28 xen2 [  110.002746] CPU: 0 PID: 5522 Comm: 2.hda-0 Tainted: G        W       4.12.0pse #2
Jul 11 09:37:28 xen2 [  110.002775] Hardware name: Supermicro X10DRi/X10DRI-T, BIOS 2.1 09/13/2016
Jul 11 09:37:28 xen2 [  110.002807] task: ffff88015fb3e140 task.stack: ffffc90047b64000
Jul 11 09:37:28 xen2 [  110.002838] RIP: e030:nvme_queue_rq+0x644/0x7c0 [nvme]
Jul 11 09:37:28 xen2 [  110.002864] RSP: e02b:ffffc90047b67a10 EFLAGS: 00010286
Jul 11 09:37:28 xen2 [  110.002889] RAX: 0000000000000008 RBX: 00000000fffff400 RCX: 0000000000001000
Jul 11 09:37:28 xen2 [  110.002922] RDX: 0000000000000000 RSI: 0000000000000200 RDI: 0000000000000200
Jul 11 09:37:28 xen2 [  110.002954] RBP: 0000000000711000 R08: 0000000000001400 R09: ffff880171a82a00
Jul 11 09:37:28 xen2 [  110.002987] R10: 0000000000001000 R11: ffff880161316d00 R12: 0000000000006000
Jul 11 09:37:28 xen2 [  110.003019] R13: 0000000000000200 R14: ffff880161316d00 R15: 0000000000000002
Jul 11 09:37:28 xen2 [  110.003056] FS:  0000000000000000(0000) GS:ffff880186a00000(0000) knlGS:ffff880186a00000
Jul 11 09:37:28 xen2 [  110.003088] CS:  e033 DS: 0000 ES: 0000 CR0: 0000000080050033
Jul 11 09:37:28 xen2 [  110.003115] CR2: 00007fed265e5fe8 CR3: 000000016eec0000 CR4: 0000000000042660
Jul 11 09:37:28 xen2 [  110.003148] Call Trace:
Jul 11 09:37:28 xen2 [  110.003169]  ? blk_mq_dispatch_rq_list+0x201/0x400
Jul 11 09:37:28 xen2 [  110.003193]  ? blk_mq_flush_busy_ctxs+0xc1/0x120
Jul 11 09:37:28 xen2 [  110.003217]  ? blk_mq_sched_dispatch_requests+0x1b1/0x1e0
Jul 11 09:37:28 xen2 [  110.003243]  ? __blk_mq_delay_run_hw_queue+0x91/0xa0
Jul 11 09:37:28 xen2 [  110.003265]  ? blk_mq_flush_plug_list+0x184/0x260
Jul 11 09:37:28 xen2 [  110.003290]  ? blk_flush_plug_list+0xf2/0x280
Jul 11 09:37:28 xen2 [  110.003312]  ? blk_finish_plug+0x27/0x40
Jul 11 09:37:28 xen2 [  110.003335]  ? dispatch_rw_block_io+0x732/0x9c0 [xen_blkback]
Jul 11 09:37:28 xen2 [  110.003363]  ? __do_block_io_op+0x362/0x690 [xen_blkback]
Jul 11 09:37:28 xen2 [  110.003393]  ? _raw_spin_unlock_irqrestore+0x16/0x20
Jul 11 09:37:28 xen2 [  110.003415]  ? __do_block_io_op+0x362/0x690 [xen_blkback]
Jul 11 09:37:28 xen2 [  110.003442]  ? xen_blkif_schedule+0x116/0x7f0 [xen_blkback]
Jul 11 09:37:28 xen2 [  110.003469]  ? __schedule+0x3cd/0x850
Jul 11 09:37:28 xen2 [  110.003488]  ? remove_wait_queue+0x60/0x60
Jul 11 09:37:28 xen2 [  110.003511]  ? kthread+0xfc/0x130
Jul 11 09:37:28 xen2 [  110.003530]  ? xen_blkif_be_int+0x30/0x30 [xen_blkback]
Jul 11 09:37:28 xen2 [  110.003556]  ? kthread_create_on_node+0x70/0x70
Jul 11 09:37:28 xen2 [  110.003581]  ? do_group_exit+0x3a/0xa0
Jul 11 09:37:28 xen2 [  110.004573]  ? ret_from_fork+0x25/0x30
Jul 11 09:37:28 xen2 [  110.005560] Code: ff 4c 89 ef 89 54 24 20 89 4c 24 18 e8 66 e0 e9 c0 8b 54 24 20 48 89 44 24 10 4c 8b 48 10 44 8b 40 18 8b 4c 24 18 e9 74 fd ff ff <0f> 0b 49 8b 77 68 48 8b 3c 24 e8 8d b3 e8 c0 83 e8 01 74 55 41 
Jul 11 09:37:28 xen2 [  110.007650] RIP: nvme_queue_rq+0x644/0x7c0 [nvme] RSP: ffffc90047b67a10
Jul 11 09:37:28 xen2 [  110.008708] ---[ end trace ad956c9e07e27784 ]---
Jul 11 09:37:28 xen2 [  110.009061] systemd-journald[413]: Compressed data object 809 -> 751 using LZ4
Jul 11 09:37:32 xen2 [  113.693382] BUG: unable to handle kernel paging request at 0000010000030000
Jul 11 09:37:32 xen2 [  113.694614] IP: __list_add_valid+0xc/0x70
Jul 11 09:37:32 xen2 [  113.695634] PGD 0 
Jul 11 09:37:32 xen2 [  113.695635] P4D 0 
Jul 11 09:37:32 xen2 [  113.696613] 
Jul 11 09:37:32 xen2 [  113.698441] Oops: 0000 [#2] SMP
Jul 11 09:37:32 xen2 [  113.699307] Modules linked in: xt_physdev br_netfilter iptable_filter xen_netback xen_blkback netconsole configfs bridge xen_gntdev xen_evtchn xenfs xen_privcmd dm_snapshot dm_bufio intel_rapl sb_edac x86_pkg_temp_thermal intel_powerclamp coretemp crct10dif_pclmul crc32_pclmul ghash_clmulni_intel pcbc aesni_intel aes_x86_64 iTCO_wdt crypto_simd iTCO_vendor_support glue_helper mxm_wmi cryptd snd_pcm snd_timer snd soundcore intel_rapl_perf pcspkr ast ttm e1000e drm_kms_helper joydev i2c_i801 ixgbe mei_me nvme drm ehci_pci ptp lpc_ich i2c_algo_bit sg mfd_core ehci_hcd mei pps_core nvme_core mdio ioatdma shpchp dca wmi acpi_power_meter 8021q garp mrp stp llc button ipmi_si ipmi_devintf ipmi_msghandler drbd lru_cache sunrpc ip_tables x_tables autofs4 ext4 crc16 jbd2 fscrypto mbcache raid10 raid456 libcrc32c
Jul 11 09:37:32 xen2 [  113.705697]  crc32c_generic async_raid6_recov async_memcpy async_pq async_xor xor async_tx evdev hid_generic usbhid hid raid6_pq raid0 multipath linear bcache dm_mod raid1 md_mod sd_mod crc32c_intel ahci libahci xhci_pci xhci_hcd libata usbcore scsi_mod
Jul 11 09:37:32 xen2 [  113.707697] CPU: 11 PID: 106 Comm: xenwatch Tainted: G      D W       4.12.0pse #2
Jul 11 09:37:32 xen2 [  113.708720] Hardware name: Supermicro X10DRi/X10DRI-T, BIOS 2.1 09/13/2016
Jul 11 09:37:32 xen2 [  113.709754] task: ffff88017be3b040 task.stack: ffffc900466c4000
Jul 11 09:37:32 xen2 [  113.710794] RIP: e030:__list_add_valid+0xc/0x70
Jul 11 09:37:32 xen2 [  113.711838] RSP: e02b:ffffc900466c7c78 EFLAGS: 00010046
Jul 11 09:37:32 xen2 [  113.712890] RAX: ffff88016741bb48 RBX: ffff88016741bb40 RCX: 0000000000000000
Jul 11 09:37:32 xen2 [  113.713936] RDX: ffff88016741bb48 RSI: 0000010000030000 RDI: ffffc900466c7c98
Jul 11 09:37:32 xen2 [  113.714977] RBP: 0000010000030000 R08: 0000010000030000 R09: 0000000000000000
Jul 11 09:37:32 xen2 [  113.716015] R10: ffffc900466c7d50 R11: ffffffff81f333e0 R12: ffff88016741bb38
Jul 11 09:37:32 xen2 [  113.717055] R13: ffffc900466c7c98 R14: ffff88016741bb48 R15: ffff88017be90f38
Jul 11 09:37:32 xen2 [  113.718100] FS:  0000000000000000(0000) GS:ffff880186cc0000(0000) knlGS:ffff880186cc0000
Jul 11 09:37:32 xen2 [  113.719157] CS:  e033 DS: 0000 ES: 0000 CR0: 0000000080050033
Jul 11 09:37:32 xen2 [  113.720213] CR2: 0000010000030000 CR3: 000000015d554000 CR4: 0000000000042660
Jul 11 09:37:32 xen2 [  113.721283] Call Trace:
Jul 11 09:37:32 xen2 [  113.722350]  ? wait_for_completion+0xd1/0x190
Jul 11 09:37:32 xen2 [  113.723429]  ? wake_up_q+0x70/0x70
Jul 11 09:37:32 xen2 [  113.724497]  ? kthread_stop+0x43/0xf0
Jul 11 09:37:32 xen2 [  113.725581]  ? xen_blkif_disconnect+0x62/0x290 [xen_blkback]
Jul 11 09:37:32 xen2 [  113.726655]  ? xen_blkbk_remove+0x59/0xf0 [xen_blkback]
Jul 11 09:37:32 xen2 [  113.727724]  ? xenbus_dev_remove+0x4c/0xa0
Jul 11 09:37:32 xen2 [  113.728633]  ? device_release_driver_internal+0x154/0x210
Jul 11 09:37:32 xen2 [  113.729546]  ? bus_remove_device+0xf5/0x160
Jul 11 09:37:32 xen2 [  113.730461]  ? device_del+0x1cc/0x300
Jul 11 09:37:32 xen2 [  113.731526]  ? device_unregister+0x16/0x60
Jul 11 09:37:32 xen2 [  113.732436]  ? frontend_changed+0x9d/0x580 [xen_blkback]
Jul 11 09:37:32 xen2 [  113.733503]  ? xenbus_read_driver_state+0x39/0x60
Jul 11 09:37:32 xen2 [  113.734572]  ? prepare_to_wait_event+0x7a/0x150
Jul 11 09:37:32 xen2 [  113.735648]  ? xenwatch_thread+0xb7/0x150
Jul 11 09:37:32 xen2 [  113.736697]  ? remove_wait_queue+0x60/0x60
Jul 11 09:37:32 xen2 [  113.737721]  ? kthread+0xfc/0x130
Jul 11 09:37:32 xen2 [  113.738728]  ? find_watch+0x40/0x40
Jul 11 09:37:32 xen2 [  113.739723]  ? kthread_create_on_node+0x70/0x70
Jul 11 09:37:32 xen2 [  113.740569]  ? ret_from_fork+0x25/0x30
Jul 11 09:37:32 xen2 [  113.741542] Code: ff ff 48 89 e8 4c 8b 6c 24 10 48 83 c8 01 e9 0d ff ff ff e8 87 f9 d0 ff 0f 1f 80 00 00 00 00 4c 8b 42 08 48 89 d0 49 39 f0 75 18 <49> 8b 10 48 39 d0 75 27 49 39 f8 74 39 48 39 f8 74 34 b8 01 00 
Jul 11 09:37:32 xen2 [  113.743589] RIP: __list_add_valid+0xc/0x70 RSP: ffffc900466c7c78
Jul 11 09:37:32 xen2 [  113.744631] CR2: 0000010000030000
Jul 11 09:37:32 xen2 [  113.745682] ---[ end trace ad956c9e07e27785 ]---

From: pgadmin@pse-consulting.de (Andreas Pflug)
Date: Thu, 13 Jul 2017 10:46:27 +0200
Subject: kernel BUG at nvme/host/pci.c
In-Reply-To: <20170712195012.GA8388@localhost.localdomain>
References: <28fcb21a-35b6-61c1-29e0-9adcc954c98c@pse-consulting.de>
 <20170710190818.GA13671@localhost.localdomain>
 <64da8c4d-2d69-22fa-06a0-aa4f11903e39@pse-consulting.de>
 <20170711194523.GD4604@localhost.localdomain>
 <458f2115-4a07-e23c-2f1f-a90a95668f74@pse-consulting.de>
 <20170712195012.GA8388@localhost.localdomain>
Message-ID: <5ac79312-b9e3-7cbb-8a82-382fb99705b5@pse-consulting.de>

Am 12.07.17 um 21:50 schrieb Keith Busch:
> On Wed, Jul 12, 2017@08:06:29AM +0200, Andreas Pflug wrote:
>> nomerges set to 1 on both devices, same BUG_ON.
> Thanks for the info.
>
> Could you possibly recreate with the patch below? This will simply
> return IO error rather the panic, and show exactly how this invalid SGL
> is constructed.
Won't compile with 4.12.0, since BLK_STS_* and blk_status_t aren't present.
Got the latest sources from git, applied the patch and earned "Invalid
SGL for payload:36864 nents:7". System is badly yelling about i/o errors
on NVME, so I rebooted.

Log attached.

Regards,
Andreas
-------------- next part --------------
Jul 13 10:37:37 xen2 [  202.688278] Invalid SGL for payload:36864 nents:7
Jul 13 10:37:37 xen2 [  202.688342] ------------[ cut here ]------------
Jul 13 10:37:37 xen2 [  202.688374] WARNING: CPU: 0 PID: 6970 at drivers/nvme/host/pci.c:623 nvme_queue_rq+0x81b/0x840 [nvme]
Jul 13 10:37:37 xen2 [  202.688413] Modules linked in: xt_physdev br_netfilter iptable_filter xen_netback xen_blkback netconsole configfs bridge xen_gntdev xen_evtchn xenfs xen_privcmd intel_rapl iTCO_wdt iTCO_vendor_support mxm_wmi x86_pkg_temp_thermal intel_powerclamp coretemp crct10dif_pclmul crc32_pclmul ghash_clmulni_intel pcbc aesni_intel aes_x86_64 crypto_simd glue_helper cryptd intel_rapl_perf snd_pcm snd_timer snd soundcore pcspkr i2c_i801 ast ttm drm_kms_helper sg joydev drm i2c_algo_bit lpc_ich mfd_core ehci_pci ehci_hcd mei_me mei e1000e ixgbe ptp nvme pps_core nvme_core mdio ioatdma shpchp dca wmi acpi_power_meter 8021q garp mrp stp llc button ipmi_si ipmi_devintf ipmi_msghandler drbd lru_cache sunrpc ip_tables x_tables autofs4 ext4 crc16 mbcache jbd2 fscrypto raid10 raid456 libcrc32c crc32c_generic async_raid6_recov
Jul 13 10:37:37 xen2 [  202.688695]  async_memcpy async_pq async_xor xor async_tx evdev hid_generic usbhid hid raid6_pq raid0 multipath linear bcache dm_mod raid1 md_mod sd_mod crc32c_intel ahci libahci xhci_pci xhci_hcd libata usbcore scsi_mod
Jul 13 10:37:37 xen2 [  202.688780] CPU: 0 PID: 6970 Comm: 2.hda-0 Tainted: G        W       4.12.0-20170713+ #1
Jul 13 10:37:37 xen2 [  202.688817] Hardware name: Supermicro X10DRi/X10DRI-T, BIOS 2.1 09/13/2016
Jul 13 10:37:37 xen2 [  202.688850] task: ffff880179ef5080 task.stack: ffffc9004874c000
Jul 13 10:37:37 xen2 [  202.688876] RIP: e030:nvme_queue_rq+0x81b/0x840 [nvme]
Jul 13 10:37:37 xen2 [  202.688899] RSP: e02b:ffffc9004874fa00 EFLAGS: 00010286
Jul 13 10:37:37 xen2 [  202.688925] RAX: 0000000000000025 RBX: 00000000fffff400 RCX: 0000000000000000
Jul 13 10:37:37 xen2 [  202.688954] RDX: 0000000000000000 RSI: ffff880186a0de98 RDI: ffff880186a0de98
Jul 13 10:37:37 xen2 [  202.688988] RBP: ffff88017b50f000 R08: 0000000000000001 R09: 00000000000009e7
Jul 13 10:37:37 xen2 [  202.689021] R10: 0000000000001000 R11: 0000000000000001 R12: 0000000000000200
Jul 13 10:37:37 xen2 [  202.689053] R13: 0000000000001000 R14: ffff880160134600 R15: ffff880170d91800
Jul 13 10:37:37 xen2 [  202.689091] FS:  0000000000000000(0000) GS:ffff880186a00000(0000) knlGS:ffff880186a00000
Jul 13 10:37:37 xen2 [  202.689128] CS:  e033 DS: 0000 ES: 0000 CR0: 0000000080050033
Jul 13 10:37:37 xen2 [  202.689155] CR2: 00007f91740959a8 CR3: 0000000161716000 CR4: 0000000000042660
Jul 13 10:37:37 xen2 [  202.689189] Call Trace:
Jul 13 10:37:37 xen2 [  202.689210]  ? __sbitmap_get_word+0x2a/0x80
Jul 13 10:37:37 xen2 [  202.689235]  ? blk_mq_dispatch_rq_list+0x200/0x3d0
Jul 13 10:37:37 xen2 [  202.689257]  ? blk_mq_flush_busy_ctxs+0xd1/0x120
Jul 13 10:37:37 xen2 [  202.689279]  ? blk_mq_sched_dispatch_requests+0x1c0/0x1f0
Jul 13 10:37:37 xen2 [  202.689306]  ? __blk_mq_delay_run_hw_queue+0x8f/0xa0
Jul 13 10:37:37 xen2 [  202.689328]  ? blk_mq_flush_plug_list+0x184/0x260
Jul 13 10:37:37 xen2 [  202.689353]  ? blk_flush_plug_list+0xf2/0x280
Jul 13 10:37:37 xen2 [  202.689376]  ? blk_finish_plug+0x27/0x40
Jul 13 10:37:37 xen2 [  202.689400]  ? dispatch_rw_block_io+0x732/0x9c0 [xen_blkback]
Jul 13 10:37:37 xen2 [  202.690364]  ? __do_block_io_op+0x362/0x690 [xen_blkback]
Jul 13 10:37:37 xen2 [  202.691408]  ? _raw_spin_unlock_irqrestore+0x16/0x20
Jul 13 10:37:37 xen2 [  202.692440]  ? __do_block_io_op+0x362/0x690 [xen_blkback]
Jul 13 10:37:37 xen2 [  202.693420]  ? xen_blkif_schedule+0x116/0x7f0 [xen_blkback]
Jul 13 10:37:37 xen2 [  202.694361]  ? __schedule+0x3cd/0x850
Jul 13 10:37:37 xen2 [  202.695410]  ? remove_wait_queue+0x60/0x60
Jul 13 10:37:37 xen2 [  202.696432]  ? kthread+0xfc/0x130
Jul 13 10:37:37 xen2 [  202.697377]  ? xen_blkif_be_int+0x30/0x30 [xen_blkback]
Jul 13 10:37:37 xen2 [  202.698290]  ? kthread_create_on_node+0x70/0x70
Jul 13 10:37:37 xen2 [  202.699293]  ? do_group_exit+0x3a/0xa0
Jul 13 10:37:37 xen2 [  202.700206]  ? ret_from_fork+0x25/0x30
Jul 13 10:37:37 xen2 [  202.701184] Code: f9 ff ff 41 f6 47 4a 04 c6 05 7a 3e 00 00 01 41 8b 97 70 01 00 00 74 28 41 8b b7 90 00 00 00 48 c7 c7 b8 17 54 c0 e8 40 14 b9 c0 <0f> ff e9 4d fe ff ff 0f 0b 4c 8b 2d c5 05 6e c1 e9 53 ff ff ff 
Jul 13 10:37:37 xen2 [  202.703231] ---[ end trace 5b778353298dbe78 ]---
Jul 13 10:37:37 xen2 [  202.704217] sg[0] phys_addr:0x0000000aff50ec00 offset:3072 length:9216 dma_address:0x000000000070f000 dma_length:9216
Jul 13 10:37:37 xen2 [  202.705197] sg[1] phys_addr:0x0000000aff511000 offset:0 length:4096 dma_address:0x00000008755a1000 dma_length:4096
Jul 13 10:37:37 xen2 [  202.706275] sg[2] phys_addr:0x0000000aff5ef000 offset:0 length:8192 dma_address:0x0000000000712000 dma_length:8192
Jul 13 10:37:37 xen2 [  202.707315] sg[3] phys_addr:0x0000000aff564000 offset:0 length:4096 dma_address:0x0000000874fc0000 dma_length:4096
Jul 13 10:37:37 xen2 [  202.708202] sg[4] phys_addr:0x0000000aff5a7000 offset:0 length:4096 dma_address:0x0000000874fc0000 dma_length:4096
Jul 13 10:37:37 xen2 [  202.709030] sg[5] phys_addr:0x0000000aff5a6000 offset:0 length:4096 dma_address:0x0000000874fc0000 dma_length:4096
Jul 13 10:37:37 xen2 [  202.709960] sg[6] phys_addr:0x0000000aff5a5000 offset:0 length:3072 dma_address:0x0000000874fc0000 dma_length:3072
Jul 13 10:37:37 xen2 [  202.710755] print_req_error: I/O error, dev nvme0n1, sector 1188548943
Jul 13 10:37:37 xen2 [  202.711527] md/raid1:md1: nvme0n1p1: rescheduling sector 1188284751
Jul 13 10:37:37 xen2 [  202.712926] sg[0] phys_addr:0x0000000aff50ec00 offset:3072 length:9216 dma_address:0x0000000000716000 dma_length:9216
Jul 13 10:37:37 xen2 [  202.712928] sg[0] phys_addr:0x0000000aff559c00 offset:3072 length:17408 dma_address:0x000000000071b000 dma_length:17408
Jul 13 10:37:37 xen2 [  202.712931] sg[1] phys_addr:0x0000000aff5f5000 offset:0 length:4096 dma_address:0x0000000874fc0000 dma_length:4096
Jul 13 10:37:37 xen2 [  202.712932] sg[2] phys_addr:0x0000000aff586000 offset:0 length:4096 dma_address:0x0000000874fc0000 dma_length:4096

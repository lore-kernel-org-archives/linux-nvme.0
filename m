From: pgadmin@pse-consulting.de (Andreas Pflug)
Date: Sat, 15 Jul 2017 15:34:24 +0200
Subject: kernel BUG at nvme/host/pci.c
In-Reply-To: <20170715085141.GC25753@infradead.org>
References: <28fcb21a-35b6-61c1-29e0-9adcc954c98c@pse-consulting.de>
 <20170710190818.GA13671@localhost.localdomain>
 <64da8c4d-2d69-22fa-06a0-aa4f11903e39@pse-consulting.de>
 <20170711194523.GD4604@localhost.localdomain>
 <458f2115-4a07-e23c-2f1f-a90a95668f74@pse-consulting.de>
 <20170712195012.GA8388@localhost.localdomain>
 <5ac79312-b9e3-7cbb-8a82-382fb99705b5@pse-consulting.de>
 <20170713134754.GD8388@localhost.localdomain>
 <39459fb9-ea2c-0718-10a1-a7e96b9ec21f@pse-consulting.de>
 <20170714170846.GA24365@localhost.localdomain>
 <20170715085141.GC25753@infradead.org>
Message-ID: <2fdb1d68-254b-cdc2-c60c-febd1f7785e0@pse-consulting.de>

Am 15.07.17 um 10:51 schrieb Christoph Hellwig:
> On Fri, Jul 14, 2017@01:08:47PM -0400, Keith Busch wrote:
>>> So LVM2 backed by md raid1 isn't compatible with newer hardware... Any
>>> suggestions?
>> It's not that LVM2 or RAID isn't compatible. Either the IOMMU isn't
>> compatible if can use different page offsets for DMA addresses than the
>> physical aaddresses, or the driver for it is broken. The DMA addresses
>> in this mapped SGL look completely broken, at least, since the last 4
>> entries are all the same address. That'll corrupt data.
> Given that this is a Xen system I wonder if swiotlb-xen is involved
> here, which does some odd chunking of dma translations?

I did some more testing now.

With data stored on SATA disks with md1 and lvm2 (i.e. just replacing
NVME by SATA), there's nothing happening.
With data stored on /dev/nvme1n1p1, i.e. without any device mapping
stuff, I get the same problem.
Log attached.

Regards,
Andreas
-------------- next part --------------
Jul 15 15:25:06 xen2 [ 4376.149215] Invalid SGL for payload:20992 nents:5
Jul 15 15:25:06 xen2 [ 4376.150382] ------------[ cut here ]------------
Jul 15 15:25:06 xen2 [ 4376.151261] WARNING: CPU: 0 PID: 29095 at drivers/nvme/host/pci.c:623 nvme_queue_rq+0x81b/0x840 [nvme]
Jul 15 15:25:06 xen2 [ 4376.152194] Modules linked in: xt_physdev br_netfilter iptable_filter xen_netback xen_blkback netconsole configfs bridge xen_gntdev xen_evtchn xenfs xen_privcmd iTCO_wdt intel_rapl iTCO_vendor_support mxm_wmi x86_pkg_temp_thermal intel_powerclamp coretemp crct10dif_pclmul crc32_pclmul ghash_clmulni_intel pcbc aesni_intel aes_x86_64 crypto_simd glue_helper cryptd intel_rapl_perf snd_pcm snd_timer snd soundcore pcspkr i2c_i801 joydev ast ttm drm_kms_helper drm sg i2c_algo_bit lpc_ich ehci_pci mfd_core ehci_hcd mei_me mei e1000e ixgbe ptp nvme pps_core mdio nvme_core ioatdma shpchp dca wmi acpi_power_meter 8021q garp mrp stp llc button ipmi_si ipmi_devintf ipmi_msghandler sunrpc drbd lru_cache ip_tables x_tables autofs4 ext4 crc16 mbcache jbd2 fscrypto raid10 raid456 libcrc32c crc32c_generic async_raid6_recov
Jul 15 15:25:06 xen2 [ 4376.158582]  async_memcpy async_pq async_xor xor async_tx raid6_pq raid0 multipath linear evdev hid_generic usbhid hid bcache dm_mod raid1 md_mod sd_mod crc32c_intel ahci libahci xhci_pci xhci_hcd libata usbcore scsi_mod
Jul 15 15:25:06 xen2 [ 4376.160593] CPU: 0 PID: 29095 Comm: 8.hda-0 Tainted: G      D W       4.12.0-20170713+ #1
Jul 15 15:25:06 xen2 [ 4376.161678] Hardware name: Supermicro X10DRi/X10DRI-T, BIOS 2.1 09/13/2016
Jul 15 15:25:06 xen2 [ 4376.162649] task: ffff88015fdc5000 task.stack: ffffc90048134000
Jul 15 15:25:06 xen2 [ 4376.163676] RIP: e030:nvme_queue_rq+0x81b/0x840 [nvme]
Jul 15 15:25:06 xen2 [ 4376.164804] RSP: e02b:ffffc90048137a00 EFLAGS: 00010286
Jul 15 15:25:06 xen2 [ 4376.165890] RAX: 0000000000000025 RBX: 00000000fffff200 RCX: 0000000000000000
Jul 15 15:25:06 xen2 [ 4376.166982] RDX: 0000000000000000 RSI: ffff880186a0de98 RDI: ffff880186a0de98
Jul 15 15:25:06 xen2 [ 4376.168099] RBP: ffff8801732ff000 R08: 0000000000000001 R09: 0000000000000a57
Jul 15 15:25:06 xen2 [ 4376.169081] R10: 0000000000001000 R11: 0000000000000001 R12: 0000000000000200
Jul 15 15:25:06 xen2 [ 4376.170198] R13: 0000000000001000 R14: ffff88015f9d7800 R15: ffff88016fce1800
Jul 15 15:25:06 xen2 [ 4376.171330] FS:  0000000000000000(0000) GS:ffff880186a00000(0000) knlGS:ffff880186a00000
Jul 15 15:25:06 xen2 [ 4376.172474] CS:  e033 DS: 0000 ES: 0000 CR0: 0000000080050033
Jul 15 15:25:06 xen2 [ 4376.173600] CR2: 000000b0f98d1970 CR3: 0000000175d4f000 CR4: 0000000000042660
Jul 15 15:25:06 xen2 [ 4376.174643] Call Trace:
Jul 15 15:25:06 xen2 [ 4376.175743]  ? __sbitmap_get_word+0x2a/0x80
Jul 15 15:25:06 xen2 [ 4376.176814]  ? blk_mq_dispatch_rq_list+0x200/0x3d0
Jul 15 15:25:06 xen2 [ 4376.177932]  ? blk_mq_flush_busy_ctxs+0xd1/0x120
Jul 15 15:25:06 xen2 [ 4376.178961]  ? blk_mq_sched_dispatch_requests+0x1c0/0x1f0
Jul 15 15:25:06 xen2 [ 4376.179942]  ? __blk_mq_delay_run_hw_queue+0x8f/0xa0
Jul 15 15:25:06 xen2 [ 4376.180941]  ? blk_mq_flush_plug_list+0x184/0x260
Jul 15 15:25:06 xen2 [ 4376.181935]  ? blk_flush_plug_list+0xf2/0x280
Jul 15 15:25:06 xen2 [ 4376.182952]  ? blk_finish_plug+0x27/0x40
Jul 15 15:25:06 xen2 [ 4376.183985]  ? dispatch_rw_block_io+0x732/0x9c0 [xen_blkback]
Jul 15 15:25:06 xen2 [ 4376.185059]  ? _raw_spin_lock_irqsave+0x17/0x39
Jul 15 15:25:06 xen2 [ 4376.186103]  ? __do_block_io_op+0x362/0x690 [xen_blkback]
Jul 15 15:25:06 xen2 [ 4376.187167]  ? _raw_spin_unlock_irqrestore+0x16/0x20
Jul 15 15:25:06 xen2 [ 4376.188216]  ? __do_block_io_op+0x362/0x690 [xen_blkback]
Jul 15 15:25:06 xen2 [ 4376.189294]  ? xen_blkif_schedule+0x116/0x7f0 [xen_blkback]
Jul 15 15:25:06 xen2 [ 4376.190247]  ? __schedule+0x3cd/0x850
Jul 15 15:25:06 xen2 [ 4376.191152]  ? remove_wait_queue+0x60/0x60
Jul 15 15:25:06 xen2 [ 4376.192112]  ? kthread+0xfc/0x130
Jul 15 15:25:06 xen2 [ 4376.193169]  ? xen_blkif_be_int+0x30/0x30 [xen_blkback]
Jul 15 15:25:06 xen2 [ 4376.194105]  ? kthread_create_on_node+0x70/0x70
Jul 15 15:25:06 xen2 [ 4376.195059]  ? do_group_exit+0x3a/0xa0
Jul 15 15:25:06 xen2 [ 4376.196049]  ? ret_from_fork+0x25/0x30
Jul 15 15:25:06 xen2 [ 4376.197050] Code: f9 ff ff 41 f6 47 4a 04 c6 05 7a 3e 00 00 01 41 8b 97 70 01 00 00 74 28 41 8b b7 90 00 00 00 48 c7 c7 b8 87 48 c0 e8 40 a4 c4 c0 <0f> ff e9 4d fe ff ff 0f 0b 4c 8b 2d c5 95 79 c1 e9 53 ff ff ff 
Jul 15 15:25:06 xen2 [ 4376.198947] ---[ end trace 6d7d395a29c931b5 ]---
Jul 15 15:25:06 xen2 [ 4376.200012] sg[0] phys_addr:0x0000000aff549e00 offset:3584 length:4608 dma_address:0x00000000004a3000 dma_length:4608
Jul 15 15:25:06 xen2 [ 4376.200951] sg[1] phys_addr:0x0000000aff5c3000 offset:0 length:4096 dma_address:0x00000009f4a80000 dma_length:4096
Jul 15 15:25:06 xen2 [ 4376.202015] sg[2] phys_addr:0x0000000aff615000 offset:0 length:4096 dma_address:0x00000009f4a80000 dma_length:4096
Jul 15 15:25:06 xen2 [ 4376.203006] sg[3] phys_addr:0x0000000aff608000 offset:0 length:4096 dma_address:0x00000009f4a80000 dma_length:4096
Jul 15 15:25:06 xen2 [ 4376.203889] sg[4] phys_addr:0x0000000aff50e000 offset:0 length:4096 dma_address:0x00000009f5a4e000 dma_length:4096
Jul 15 15:25:06 xen2 [ 4376.204722] print_req_error: I/O error, dev nvme1n1, sector 14318951

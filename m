From: wolfgang@rohdewald.de (Wolfgang Rohdewald)
Date: Tue, 25 Jun 2019 09:51:04 +0200
Subject: [nvme] Invalid SGL for payload:91648 nents:3
Message-ID: <92778741dff3723fc94cd75df3043adc9c8bf21a.camel@rohdewald.de>

For some time now, I am getting this on an Intel SSD M.2, output of smartctl see below.
This also happens with sgl_threshold=0.

Untainted kernel 5.1.14 (happens also with 5.1.8 and 5.1.15) on Ubuntu 19.04

I cannot say exactly when this started. I cannot trigger it with
cp -a but after starting Virtualbox 6.0.6_Ubuntu r129722 with a Windows 10 client,
it happens quickly. The first logged case is with Linux 5.1.11 but I did
not use Virtualbox for some time before, so if that is what it triggers,
the bug might be older.

I have a Samsung SSD 950 PRO 512GB for the root partition, the Intel SSD
holds a separate ext4 file system. According to smartctl, the Samsung
has no problems. Using Virtualbox there also gives me unexplainable
print_req_error messages but nothing else.

After this happens, smartctl -a often says

Read Error Information Log failed: NVMe Status 0x02

Otherwise, smartctl finds no problems with the SSD, fsck -f is clean,
fsck -c finds no bad blocks.

The sector numbers in the print_req_error message vary, see below.

smartctl 6.6 2017-11-05 r4594 [x86_64-linux-5.1.15-364] (local build)
Copyright (C) 2002-17, Bruce Allen, Christian Franke, www.smartmontools.org

=== START OF INFORMATION SECTION ===
Model Number:                       INTEL SSDPEKNW020T8
Serial Number:                      BTNH903409YJ2P0C
Firmware Version:                   002C
PCI Vendor/Subsystem ID:            0x8086
IEEE OUI Identifier:                0x5cd2e4
Controller ID:                      1
Number of Namespaces:               1
Namespace 1 Size/Capacity:          2.048.408.248.320 [2,04 TB]
Namespace 1 Formatted LBA Size:     512
Local Time is:                      Tue Jun 25 08:57:41 2019 CEST
Firmware Updates (0x14):            2 Slots, no Reset required
Optional Admin Commands (0x0017):   Security Format Frmw_DL Self_Test
Optional NVM Commands (0x005f):     Comp Wr_Unc DS_Mngmt Wr_Zero Sav/Sel_Feat Timestmp
Maximum Data Transfer Size:         32 Pages
Warning  Comp. Temp. Threshold:     77 Celsius
Critical Comp. Temp. Threshold:     80 Celsius

Supported Power States
St Op     Max   Active     Idle   RL RT WL WT  Ent_Lat  Ex_Lat
 0 +     5.50W       -        -    0  0  0  0        0       0
 1 +     3.60W       -        -    1  1  1  1        0       0
 2 +     2.60W       -        -    2  2  2  2        0       0
 3 -   0.0300W       -        -    3  3  3  3     5000    5000
 4 -   0.0040W       -        -    4  4  4  4     5000    9000

Supported LBA Sizes (NSID 0x1)
Id Fmt  Data  Metadt  Rel_Perf
 0 +     512       0         0

=== START OF SMART DATA SECTION ===
SMART overall-health self-assessment test result: PASSED

SMART/Health Information (NVMe Log 0x02, NSID 0x1)
Critical Warning:                   0x00
Temperature:                        32 Celsius
Available Spare:                    100%
Available Spare Threshold:          10%
Percentage Used:                    0%
Data Units Read:                    9.228.998 [4,72 TB]
Data Units Written:                 3.245.879 [1,66 TB]
Host Read Commands:                 41.518.159
Host Write Commands:                14.046.787
Controller Busy Time:               365
Power Cycles:                       40
Power On Hours:                     1.239
Unsafe Shutdowns:                   11
Media and Data Integrity Errors:    0
Error Information Log Entries:      0
Warning  Comp. Temperature Time:    0
Critical Comp. Temperature Time:    0

Read Error Information Log failed: NVMe Status 0x02


Jun 23 07:49:20 skull kernel: [  171.583390] vboxdrv: 0000000000000000 VBoxEhciR0.r0
Jun 23 07:52:35 skull kernel: [  366.611276] sg[0] phys_addr:0x0000000372be9000 offset:0 length:60416 dma_address:0x0000000372be9000 dma_length:60416
Jun 23 07:52:35 skull kernel: [  366.611277] sg[1] phys_addr:0x0000000372bf7c00 offset:3072 length:33792 dma_address:0x0000000372bf7c00 dma_length:33792
Jun 23 07:52:35 skull kernel: [  366.611278] sg[2] phys_addr:0x0000000372929000 offset:0 length:36864 dma_address:0x0000000372929000 dma_length:36864
Jun 23 07:52:35 skull kernel: [  366.611281] ------------[ cut here ]------------
Jun 23 07:52:35 skull kernel: [  366.611282] Invalid SGL for payload:131072 nents:3
Jun 23 07:52:35 skull kernel: [  366.611294] WARNING: CPU: 2 PID: 7675 at drivers/nvme/host/pci.c:748 nvme_queue_rq+0x9ed/0xa40
Jun 23 07:52:35 skull kernel: [  366.611294] Modules linked in: ccm rfcomm ipt_MASQUERADE nf_conntrack_netlink xfrm_user xfrm_algo iptable_nat xt_addrtype iptable_filter xt_conntrack nf_nat
nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c br_netfilter bridge stp llc rpcsec_gss_krb5 auth_rpcgss pci_stub vboxpci(OE) vboxnetadp(OE) vboxnetflt(OE) vboxdrv(OE) nfsv4 nfs lockd grace
fscache dummy nfnetlink_queue nfnetlink_log nfnetlink cmac bnep input_leds joydev btusb btrtl overlay btbcm btintel bluetooth ecdh_generic binfmt_misc nls_iso8859_1 arc4 snd_hda_codec_hdmi
snd_hda_codec_realtek intel_rapl x86_pkg_temp_thermal snd_hda_codec_generic intel_powerclamp snd_hda_intel snd_hda_codec snd_hda_core snd_hwdep crct10dif_pclmul snd_pcm crc32_pclmul
ghash_clmulni_intel snd_seq_midi snd_seq_midi_event iwlmvm snd_rawmidi aesni_intel mac80211 aes_x86_64 crypto_simd cryptd glue_helper intel_cstate intel_rapl_perf snd_seq iwlwifi snd_seq_device
snd_timer snd cfg80211 soundcore mei_me mei intel_pch_thermal ir_rc6_decoder wmi
Jun 23 07:52:35 skull kernel: [  366.611322]  rc_rc6_mce nuvoton_cir rc_core acpi_pad squashfs sch_fq_codel nct6775 hwmon_vid coretemp sunrpc ip_tables x_tables autofs4 hid_logitech_hidpp
hid_logitech_dj hid_generic usbhid hid i915 i2c_algo_bit drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops e1000e drm sdhci_pci cqhci i2c_i801 sdhci video
Jun 23 07:52:35 skull kernel: [  366.611333] CPU: 2 PID: 7675 Comm: AioMgr0-N Tainted: G           OE     5.1.14-363 #1
Jun 23 07:52:35 skull kernel: [  366.611334] Hardware name:  /NUC6i7KYB, BIOS KYSKLi70.86A.0062.2019.0507.1702 05/07/2019
Jun 23 07:52:35 skull kernel: [  366.611336] RIP: 0010:nvme_queue_rq+0x9ed/0xa40
Jun 23 07:52:35 skull kernel: [  366.611338] Code: 48 c7 c7 38 6a a3 b3 e8 a1 f0 e1 ff 41 8b 97 4c 01 00 00 41 f6 47 1e 04 75 57 41 8b 77 24 48 c7 c7 80 7e f2 b2 e8 bd e4 a2 ff <0f> 0b bd 0a 00 00 00
e9 fb fd ff ff 49 89 df bd 09 00 00 00 e9 ee
Jun 23 07:52:35 skull kernel: [  366.611338] RSP: 0018:ffffa396c8fb75c8 EFLAGS: 00010282
Jun 23 07:52:35 skull kernel: [  366.611340] RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000000006
Jun 23 07:52:35 skull kernel: [  366.611340] RDX: 0000000000000007 RSI: 0000000000000086 RDI: ffff97649ea954f0
Jun 23 07:52:35 skull kernel: [  366.611341] RBP: 0000000000000000 R08: 000000000000067c R09: 0000000000000004
Jun 23 07:52:35 skull kernel: [  366.611342] R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000003
Jun 23 07:52:35 skull kernel: [  366.611342] R13: ffff97649aa28000 R14: 0000000000011000 R15: ffff976491a7ac00
Jun 23 07:52:35 skull kernel: [  366.611344] FS:  00007f148b0c8700(0000) GS:ffff97649ea80000(0000) knlGS:0000000000000000
Jun 23 07:52:35 skull kernel: [  366.611344] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Jun 23 07:52:35 skull kernel: [  366.611345] CR2: 00007ffb890206c4 CR3: 00000005839f8005 CR4: 00000000003626e0
Jun 23 07:52:35 skull kernel: [  366.611346] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
Jun 23 07:52:35 skull kernel: [  366.611347] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Jun 23 07:52:35 skull kernel: [  366.611347] Call Trace:
Jun 23 07:52:35 skull kernel: [  366.611354]  __blk_mq_try_issue_directly+0x114/0x1c0
Jun 23 07:52:35 skull kernel: [  366.611357]  blk_mq_request_issue_directly+0x48/0xe0
Jun 23 07:52:35 skull kernel: [  366.611359]  blk_mq_try_issue_list_directly+0x41/0xb0
Jun 23 07:52:35 skull kernel: [  366.611361]  blk_mq_sched_insert_requests+0xa5/0xf0
Jun 23 07:52:35 skull kernel: [  366.611363]  blk_mq_flush_plug_list+0x211/0x2c0
Jun 23 07:52:35 skull kernel: [  366.611366]  blk_flush_plug_list+0xc6/0xf0
Jun 23 07:52:35 skull kernel: [  366.611368]  blk_mq_make_request+0x208/0x580
Jun 23 07:52:35 skull kernel: [  366.611370]  generic_make_request+0x19e/0x400
Jun 23 07:52:35 skull kernel: [  366.611373]  submit_bio+0x45/0x140
Jun 23 07:52:35 skull kernel: [  366.611376]  do_blockdev_direct_IO+0x21e4/0x2e30
Jun 23 07:52:35 skull kernel: [  366.611380]  ? find_get_pages_range_tag+0x81/0x2d0
Jun 23 07:52:35 skull kernel: [  366.611384]  ? ext4_dio_get_block_unwritten_sync+0x50/0x50
Jun 23 07:52:35 skull kernel: [  366.611386]  ext4_direct_IO+0x359/0x740
Jun 23 07:52:35 skull kernel: [  366.611388]  ? touch_atime+0x33/0xe0
Jun 23 07:52:35 skull kernel: [  366.611391]  generic_file_read_iter+0x9c/0xc90
Jun 23 07:52:35 skull kernel: [  366.611394]  aio_read+0xec/0x160
Jun 23 07:52:35 skull kernel: [  366.611397]  ? tomoyo_init_request_info+0x84/0x90
Jun 23 07:52:35 skull kernel: [  366.611399]  ? tomoyo_path_number_perm+0x68/0x1e0
Jun 23 07:52:35 skull kernel: [  366.611401]  ? _cond_resched+0x15/0x30
Jun 23 07:52:35 skull kernel: [  366.611403]  ? __kmalloc+0x166/0x200
Jun 23 07:52:35 skull kernel: [  366.611416]  ? rtR0MemAllocEx+0x14c/0x240 [vboxdrv]
Jun 23 07:52:35 skull kernel: [  366.611425]  ? supdrvIOCtl+0xcc1/0x36e0 [vboxdrv]
Jun 23 07:52:35 skull kernel: [  366.611426]  ? kmem_cache_alloc+0x150/0x1c0
Jun 23 07:52:35 skull kernel: [  366.611428]  io_submit_one+0x171/0xb20
Jun 23 07:52:35 skull kernel: [  366.611434]  ? VBoxDrvLinuxIOCtl_6_0_6+0x188/0x240 [vboxdrv]
Jun 23 07:52:35 skull kernel: [  366.611436]  ? __x64_sys_io_submit+0xa9/0x190
Jun 23 07:52:35 skull kernel: [  366.611441]  ? lookup_ioctx+0x1d/0x90
Jun 23 07:52:35 skull kernel: [  366.611442]  __x64_sys_io_submit+0xa9/0x190
Jun 23 07:52:35 skull kernel: [  366.611451]  do_syscall_64+0x5f/0x190
Jun 23 07:52:35 skull kernel: [  366.611453]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
Jun 23 07:52:35 skull kernel: [  366.611455] RIP: 0033:0x7f14ed70e2e9
Jun 23 07:52:35 skull kernel: [  366.611457] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73
01 c3 48 8b 0d 77 cb 0c 00 f7 d8 64 89 01 48
Jun 23 07:52:35 skull kernel: [  366.611457] RSP: 002b:00007f148b0c7b98 EFLAGS: 00000246 ORIG_RAX: 00000000000000d1
Jun 23 07:52:35 skull kernel: [  366.611459] RAX: ffffffffffffffda RBX: 00007f14948aaed0 RCX: 00007f14ed70e2e9
Jun 23 07:52:35 skull kernel: [  366.611459] RDX: 00007f148b0c7c60 RSI: 000000000000000a RDI: 00007f14d81ab000
Jun 23 07:52:35 skull kernel: [  366.611460] RBP: 00007f148b0c7bc0 R08: 0000000000000001 R09: 00007f148b0c7c70
Jun 23 07:52:35 skull kernel: [  366.611461] R10: 00007f149c00ea00 R11: 0000000000000246 R12: 00007f148b0c7c60
Jun 23 07:52:35 skull kernel: [  366.611461] R13: 000000000000000a R14: 00007f149493f5a0 R15: 000000000000000a
Jun 23 07:52:35 skull kernel: [  366.611463] ---[ end trace d2b93cc190ac7a41 ]---
Jun 23 07:52:35 skull kernel: [  366.611466] print_req_error: I/O error, dev nvme1n1, sector 741253002 flags 4000

grep -a sector /var/log/kern.log*
/var/log/kern.log:Jun 23 07:52:35 skull kernel: [  366.611466] print_req_error: I/O error, dev nvme1n1, sector 741253002 flags 4000
/var/log/kern.log:Jun 23 07:55:24 skull kernel: [  535.823599] print_req_error: I/O error, dev nvme1n1, sector 160612274 flags 4000
/var/log/kern.log:Jun 23 08:04:50 skull kernel: [   70.839418] print_req_error: I/O error, dev nvme1n1, sector 161154970 flags 0
/var/log/kern.log:Jun 23 08:05:52 skull kernel: [  132.746319] print_req_error: I/O error, dev nvme1n1, sector 161154970 flags 4000
/var/log/kern.log:Jun 23 08:05:52 skull kernel: [  132.832546] print_req_error: I/O error, dev nvme1n1, sector 161154970 flags 0
/var/log/kern.log:Jun 23 08:05:52 skull kernel: [  132.855611] print_req_error: I/O error, dev nvme1n1, sector 161154970 flags 4000
/var/log/kern.log:Jun 23 08:08:52 skull kernel: [  312.957573] print_req_error: I/O error, dev nvme1n1, sector 161150857 flags 0
/var/log/kern.log:Jun 23 08:08:52 skull kernel: [  312.958424] print_req_error: I/O error, dev nvme1n1, sector 161150857 flags 0
/var/log/kern.log:Jun 23 08:08:52 skull kernel: [  312.959489] print_req_error: I/O error, dev nvme1n1, sector 161150857 flags 0
/var/log/kern.log:Jun 24 18:57:11 skull kernel: [ 3576.127767] print_req_error: I/O error, dev nvme1n1, sector 790335378 flags 0
/var/log/kern.log:Jun 24 18:57:11 skull kernel: [ 3576.130135] print_req_error: I/O error, dev nvme1n1, sector 790335378 flags 4000
/var/log/kern.log:Jun 24 18:57:11 skull kernel: [ 3576.132458] print_req_error: I/O error, dev nvme1n1, sector 790335378 flags 0
/var/log/kern.log:Jun 24 18:57:11 skull kernel: [ 3576.134669] print_req_error: I/O error, dev nvme1n1, sector 790335378 flags 4000
/var/log/kern.log:Jun 24 18:58:40 skull kernel: [ 3665.022567] print_req_error: I/O error, dev nvme1n1, sector 740323209 flags 0
/var/log/kern.log:Jun 24 18:58:40 skull kernel: [ 3665.023451] print_req_error: I/O error, dev nvme1n1, sector 740323209 flags 0
/var/log/kern.log:Jun 24 18:58:40 skull kernel: [ 3665.024407] print_req_error: I/O error, dev nvme1n1, sector 740323209 flags 0
/var/log/kern.log:Jun 24 18:58:40 skull kernel: [ 3665.037217] print_req_error: I/O error, dev nvme1n1, sector 740323209 flags 0
/var/log/kern.log:Jun 24 18:58:40 skull kernel: [ 3665.038041] print_req_error: I/O error, dev nvme1n1, sector 740323209 flags 0
/var/log/kern.log:Jun 24 18:58:40 skull kernel: [ 3665.038891] print_req_error: I/O error, dev nvme1n1, sector 740323209 flags 0
/var/log/kern.log:Jun 24 18:58:40 skull kernel: [ 3665.040467] print_req_error: I/O error, dev nvme1n1, sector 740323209 flags 0
/var/log/kern.log:Jun 24 20:18:56 skull kernel: [ 8481.617887] print_req_error: I/O error, dev nvme1n1, sector 1805959090 flags 8801
/var/log/kern.log:Jun 24 22:07:18 skull kernel: [ 5407.282088] print_req_error: I/O error, dev nvme1n1, sector 1988491146 flags 4000
/var/log/kern.log:Jun 25 07:23:32 skull kernel: [  111.452844] print_req_error: I/O error, dev nvme1n1, sector 1988980610 flags 0
/var/log/kern.log:Jun 25 07:23:32 skull kernel: [  111.455658] print_req_error: I/O error, dev nvme1n1, sector 1988980610 flags 4000
/var/log/kern.log:Jun 25 07:23:32 skull kernel: [  111.458181] print_req_error: I/O error, dev nvme1n1, sector 1988980610 flags 0
/var/log/kern.log:Jun 25 07:23:32 skull kernel: [  111.460729] print_req_error: I/O error, dev nvme1n1, sector 1988980610 flags 4000
/var/log/kern.log:Jun 25 08:33:22 skull kernel: [  659.895032] print_req_error: I/O error, dev nvme1n1, sector 739135402 flags 0
/var/log/kern.log:Jun 25 08:33:22 skull kernel: [  659.904044] print_req_error: I/O error, dev nvme1n1, sector 739135402 flags 0
/var/log/kern.log:Jun 25 08:33:22 skull kernel: [  659.919253] print_req_error: I/O error, dev nvme1n1, sector 739135402 flags 4000
/var/log/kern.log:Jun 25 08:43:06 skull kernel: [  108.723789] print_req_error: I/O error, dev nvme1n1, sector 1781874554 flags 0
/var/log/kern.log.1:Jun 19 18:35:10 skull kernel: [ 1209.920642] print_req_error: I/O error, dev nvme1n1, sector 313347962 flags 4000



-- 
mit freundlichen Gr?ssen

Wolfgang Rohdewald

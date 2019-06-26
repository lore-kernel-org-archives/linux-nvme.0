From: ming.lei@redhat.com (Ming Lei)
Date: Wed, 26 Jun 2019 09:26:56 +0800
Subject: [nvme] Invalid SGL for payload:91648 nents:3
In-Reply-To: <6e23e6656188778c22e4aef04b6572c247103972.camel@rohdewald.de>
References: <92778741dff3723fc94cd75df3043adc9c8bf21a.camel@rohdewald.de>
 <20190625091704.GA30606@ming.t460p>
 <CAOSXXT5PgPJqouD0G7qJjar5tmy-9z+wWdFMqpD2K1=5vQZ+HA@mail.gmail.com>
 <20190625094532.GA11214@ming.t460p> <20190625095013.GA1353@lst.de>
 <336692273232ee2441e30e7e2a1c542201854010.camel@rohdewald.de>
 <20190625132900.GA22428@ming.t460p>
 <6e23e6656188778c22e4aef04b6572c247103972.camel@rohdewald.de>
Message-ID: <20190626012654.GA23698@ming.t460p>

On Tue, Jun 25, 2019@05:07:30PM +0200, Wolfgang Rohdewald wrote:
> On Di, 2019-06-25@21:29 +0800, Ming Lei wrote:
> > On Tue, Jun 25, 2019@02:11:04PM +0200, Wolfgang Rohdewald wrote:
> > > On Di, 2019-06-25@11:50 +0200, Christoph Hellwig wrote:
> > > > On Tue, Jun 25, 2019@05:45:35PM +0800, Ming Lei wrote:
> > > > > On Tue, Jun 25, 2019@06:38:58PM +0900, Keith Busch wrote:
> > > > > > The first two sg elements should have been merged to one and would have
> > > > > > avoided the error. The bug is kernel, nothing to do with the device.
> > > > > 
> > > > > The default max segment size is 64k, so the first two can't be merged.
> > > > > 
> > > > > And the 1st sg should have been dispatched as single request.
> > > > 
> > > > Well, that is exactly what I fixed with my patches that went into
> > > > 5.2.  Looks like we need to backport those as well.
> > > > 
> > > > Wolfgang, can you try the latest 5.2-rc git tree?
> > > 
> > > 5.2.0-rc6 works fine.
> > > 
> > > Do you still want me to apply nvme_dump_rq() to 5.1 for finding the root cause?
> > 
> > Yeah, please dump the request, and maybe there is issue in merge code.
> > BTW, please replace the trace_printk with printk in the debug patch.
> > 
> > Also not sure if Christoph's patch can be backported safely, given there
> > is report wrt. too big max segment size recently.
> > 
> > Thanks,
> > Ming
> 
> 
> Jun 25 17:05:05 skull kernel: [  150.419778] sg[0] phys_addr:0x000000049cbe9000 offset:0 length:32256 dma_address:0x000000049cbe9000 dma_length:32256
> Jun 25 17:05:05 skull kernel: [  150.419780] sg[1] phys_addr:0x000000049cbf0e00 offset:3584 length:40960 dma_address:0x000000049cbf0e00 dma_length:40960
> Jun 25 17:05:05 skull kernel: [  150.419783] ------------[ cut here ]------------
> Jun 25 17:05:05 skull kernel: [  150.419784] Invalid SGL for payload:73216 nents:2
> Jun 25 17:05:05 skull kernel: [  150.419820] WARNING: CPU: 2 PID: 3566 at drivers/nvme/host/pci.c:771 nvme_pci_setup_prps.isra.48+0x372/0x3d0 [nvme]
> Jun 25 17:05:05 skull kernel: [  150.419821] Modules linked in: ccm rfcomm ipt_MASQUERADE nf_conntrack_netlink xfrm_user xfrm_algo iptable_nat xt_addrtype iptable_filter xt_conntrack nf_nat
> nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c br_netfilter bridge stp llc rpcsec_gss_krb5 auth_rpcgss pci_stub vboxpci(OE) vboxnetadp(OE) vboxnetflt(OE) vboxdrv(OE) nfsv4 nfs lockd grace
> fscache dummy nfnetlink_queue nfnetlink_log nfnetlink cmac bnep btusb btrtl btbcm btintel bluetooth joydev input_leds ecdh_generic overlay binfmt_misc nls_iso8859_1 arc4 snd_hda_codec_hdmi intel_rapl
> x86_pkg_temp_thermal intel_powerclamp snd_hda_codec_realtek snd_hda_codec_generic snd_hda_intel snd_hda_codec crct10dif_pclmul snd_hda_core crc32_pclmul snd_hwdep snd_pcm ghash_clmulni_intel
> snd_seq_midi snd_seq_midi_event iwlmvm snd_rawmidi mac80211 iwlwifi snd_seq aesni_intel aes_x86_64 crypto_simd cryptd glue_helper snd_seq_device snd_timer intel_cstate intel_rapl_perf snd cfg80211
> soundcore mei_me intel_pch_thermal mei ir_rc6_decoder wmi
> Jun 25 17:05:05 skull kernel: [  150.419845]  rc_rc6_mce nuvoton_cir rc_core acpi_pad squashfs sch_fq_codel sunrpc nct6775 hwmon_vid coretemp ip_tables x_tables autofs4 hid_logitech_hidpp
> hid_logitech_dj hid_generic usbhid hid i915 i2c_algo_bit drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops nvme sdhci_pci drm e1000e cqhci i2c_i801 nvme_core sdhci video
> Jun 25 17:05:05 skull kernel: [  150.419857] CPU: 2 PID: 3566 Comm: AioMgr0-N Tainted: G           OE     5.1.15- #1
> Jun 25 17:05:05 skull kernel: [  150.419857] Hardware name:  /NUC6i7KYB, BIOS KYSKLi70.86A.0062.2019.0507.1702 05/07/2019
> Jun 25 17:05:05 skull kernel: [  150.419860] RIP: 0010:nvme_pci_setup_prps.isra.48+0x372/0x3d0 [nvme]
> Jun 25 17:05:05 skull kernel: [  150.419861] Code: 48 c7 c7 c0 85 0b c0 e8 2c 08 fb da 41 8b 97 4c 01 00 00 41 f6 47 1e 04 75 57 41 8b 77 24 48 c7 c7 38 4a 0b c0 e8 78 fb bb da <0f> 0b e9 28 ff ff ff
> b8 0a 00 00 00 e9 f3 fe ff ff 4c 8b 7d 98 4d
> Jun 25 17:05:05 skull kernel: [  150.419863] RSP: 0018:ffffa39186847558 EFLAGS: 00010282
> Jun 25 17:05:05 skull kernel: [  150.419864] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000006
> Jun 25 17:05:05 skull kernel: [  150.419865] RDX: 0000000000000007 RSI: 0000000000000086 RDI: ffff95d61ea954f0
> Jun 25 17:05:05 skull kernel: [  150.419865] RBP: ffffa391868475e8 R08: 000000000000066d R09: 0000000000000004
> Jun 25 17:05:05 skull kernel: [  150.419866] R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000002
> Jun 25 17:05:05 skull kernel: [  150.419867] R13: 0000000000000002 R14: 0000000000000007 R15: ffff95d60feed000
> Jun 25 17:05:05 skull kernel: [  150.419868] FS:  00007ff4d6168700(0000) GS:ffff95d61ea80000(0000) knlGS:0000000000000000
> Jun 25 17:05:05 skull kernel: [  150.419869] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> Jun 25 17:05:05 skull kernel: [  150.419870] CR2: ffffe20ea05ec2e8 CR3: 0000000500d24004 CR4: 00000000003626e0
> Jun 25 17:05:05 skull kernel: [  150.419870] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> Jun 25 17:05:05 skull kernel: [  150.419871] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Jun 25 17:05:05 skull kernel: [  150.419872] Call Trace:
> Jun 25 17:05:05 skull kernel: [  150.419878]  nvme_queue_rq+0x566/0x710 [nvme]
> Jun 25 17:05:05 skull kernel: [  150.419883]  __blk_mq_try_issue_directly+0x114/0x1c0
> Jun 25 17:05:05 skull kernel: [  150.419886]  ? ktime_get_raw_ts64+0x30/0xc0
> Jun 25 17:05:05 skull kernel: [  150.419888]  blk_mq_request_issue_directly+0x48/0xe0
> Jun 25 17:05:05 skull kernel: [  150.419890]  blk_mq_try_issue_list_directly+0x41/0xb0
> Jun 25 17:05:05 skull kernel: [  150.419893]  blk_mq_sched_insert_requests+0xa5/0xf0
> Jun 25 17:05:05 skull kernel: [  150.419895]  blk_mq_flush_plug_list+0x211/0x2c0
> Jun 25 17:05:05 skull kernel: [  150.419898]  blk_flush_plug_list+0xc6/0xf0
> Jun 25 17:05:05 skull kernel: [  150.419900]  blk_mq_make_request+0x208/0x580
> Jun 25 17:05:05 skull kernel: [  150.419902]  generic_make_request+0x19e/0x400
> Jun 25 17:05:05 skull kernel: [  150.419904]  submit_bio+0x45/0x140
> Jun 25 17:05:05 skull kernel: [  150.419908]  do_blockdev_direct_IO+0x21e4/0x2e30
> Jun 25 17:05:05 skull kernel: [  150.419912]  ? find_get_pages_range_tag+0x81/0x2d0
> Jun 25 17:05:05 skull kernel: [  150.419915]  ? ext4_dio_get_block_unwritten_sync+0x50/0x50
> Jun 25 17:05:05 skull kernel: [  150.419917]  ext4_direct_IO+0x359/0x740
> Jun 25 17:05:05 skull kernel: [  150.419920]  ? touch_atime+0x33/0xe0
> Jun 25 17:05:05 skull kernel: [  150.419923]  generic_file_read_iter+0x9c/0xc90
> Jun 25 17:05:05 skull kernel: [  150.419925]  aio_read+0xec/0x160
> Jun 25 17:05:05 skull kernel: [  150.419929]  ? tomoyo_init_request_info+0x84/0x90
> Jun 25 17:05:05 skull kernel: [  150.419930]  ? tomoyo_path_number_perm+0x68/0x1e0
> Jun 25 17:05:05 skull kernel: [  150.419933]  ? _cond_resched+0x15/0x30
> Jun 25 17:05:05 skull kernel: [  150.419934]  ? __kmalloc+0x166/0x200
> Jun 25 17:05:05 skull kernel: [  150.419949]  ? rtR0MemAllocEx+0x14c/0x240 [vboxdrv]
> Jun 25 17:05:05 skull kernel: [  150.419958]  ? supdrvIOCtl+0xcc1/0x36e0 [vboxdrv]
> Jun 25 17:05:05 skull kernel: [  150.419959]  ? kmem_cache_alloc+0x150/0x1c0
> Jun 25 17:05:05 skull kernel: [  150.419961]  io_submit_one+0x171/0xb20
> Jun 25 17:05:05 skull kernel: [  150.419967]  ? VBoxDrvLinuxIOCtl_6_0_6+0x188/0x240 [vboxdrv]
> Jun 25 17:05:05 skull kernel: [  150.419969]  ? __x64_sys_io_submit+0xa9/0x190
> Jun 25 17:05:05 skull kernel: [  150.419971]  ? lookup_ioctx+0x1d/0x90
> Jun 25 17:05:05 skull kernel: [  150.419973]  __x64_sys_io_submit+0xa9/0x190
> Jun 25 17:05:05 skull kernel: [  150.419975]  do_syscall_64+0x5f/0x190
> Jun 25 17:05:05 skull kernel: [  150.419978]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> Jun 25 17:05:05 skull kernel: [  150.419980] RIP: 0033:0x7ff539ace2e9
> Jun 25 17:05:05 skull kernel: [  150.419981] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73
> 01 c3 48 8b 0d 77 cb 0c 00 f7 d8 64 89 01 48
> Jun 25 17:05:05 skull kernel: [  150.419982] RSP: 002b:00007ff4d6167b98 EFLAGS: 00000246 ORIG_RAX: 00000000000000d1
> Jun 25 17:05:05 skull kernel: [  150.419984] RAX: ffffffffffffffda RBX: 00007ff4b801c9b0 RCX: 00007ff539ace2e9
> Jun 25 17:05:05 skull kernel: [  150.419984] RDX: 00007ff4d6167c60 RSI: 0000000000000005 RDI: 00007ff50802c000
> Jun 25 17:05:05 skull kernel: [  150.419985] RBP: 00007ff4d6167bc0 R08: 0000000000000001 R09: 00007ff4d6167c70
> Jun 25 17:05:05 skull kernel: [  150.419986] R10: 00007ff4b801b960 R11: 0000000000000246 R12: 00007ff4d6167c60
> Jun 25 17:05:05 skull kernel: [  150.419986] R13: 0000000000000005 R14: 00007ff4e0940100 R15: 0000000000000005
> Jun 25 17:05:05 skull kernel: [  150.419988] ---[ end trace 581bcb8c21b397f6 ]---
> Jun 25 17:05:05 skull kernel: [  150.419994] bio 0: 7602/0 1 2105917377 32256
> Jun 25 17:05:05 skull kernel: [  150.420017] bio 1: 6602/0 1 2105917440 40960
> Jun 25 17:05:05 skull kernel: [  150.420022] 0: pfn 4836329 offset 0 len 32256
> Jun 25 17:05:05 skull kernel: [  150.420027] 1: pfn 4836336 offset 3584 len 40960

I can understand the issue now, and the issue isn't related with bio
split, and it is in the normal bio merge code: biovec_phys_mergeable()
which merges two bios if their bvecs are physically continuous, and not consider
max segment size limit, which is still applied in blk_bvec_map_sg(),
then sg with unaligned virt boundary is made.

Christoph's patch 09324d32d2a08 ("block: force an unlimited segment size on queues
with a virt boundary") can fix the issue, but another regression might be
caused because of too big segment size from view of IOMMU.

And the following patch should fix the 5.1 issue too:

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 1c9d4f0f96ea..ff69b7dd2179 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -60,7 +60,8 @@ static inline bool bio_will_gap(struct request_queue *q,
 	 */
 	bio_get_last_bvec(prev, &pb);
 	bio_get_first_bvec(next, &nb);
-	if (bios_segs_mergeable(q, prev, &pb, &nb))
+	if (bios_segs_mergeable(q, prev, &pb, &nb) && prev->bi_seg_back_size +
+			next->bi_seg_front_size < queue_max_segment_size(q))
 		return false;
 	return __bvec_gap_to_prev(q, &pb, nb.bv_offset);
 }

Thanks,
Ming

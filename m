From: yoichi@chelsio.com (Yoichi Hayakawa)
Date: Mon, 4 Jul 2016 09:57:21 +0000
Subject: target crash / host hang with nvme-all.3 branch of nvme-fabrics
In-Reply-To: <20160628085011.GA7680@infradead.org>
References: <20160616145724.GA32635@infradead.org>
 <017001d1c7e7$95057270$bf105750$@opengridcomputing.com>
 <5763044A.9090206@grimberg.me>
 <005f01d1c8a1$5a229240$0e67b6c0$@opengridcomputing.com>
 <007801d1c8a2$d6056530$82102f90$@opengridcomputing.com>
 <CAF1ivSZNJhOtORceAfk9Ym9SPpYOGQ4q0KOD8eEuy0ovU2Eefw@mail.gmail.com>
 <57668896.7090308@grimberg.me>
 <006e01d1cbc7$d0d9cc40$728d64c0$@opengridcomputing.com>
 <002201d1cc8b$e3f66030$abe32090$@opengridcomputing.com>
 <014601d1d07e$e9196f70$bb4c4e50$@opengridcomputing.com>
 <20160628085011.GA7680@infradead.org>
Message-ID: <BY1PR12MB04709BA9DFE7B849179414A6DF380@BY1PR12MB0470.namprd12.prod.outlook.com>

nvmf-all.3 + this patch hits the issue.

[  475.017390] NMI watchdog: Watchdog detected hard LOCKUP on cpu 1dModules linked in: xt_CHECKSUM iptable_mangle ipt_MASQUERADE nf_nat_masquerade_ipv4 iptable_nat nf_nat_ipv4 nf_nat nf_conntrack_ipv4 nf_defrag_ipv4 xt_conntrack nf_conntrack ipt_REJECT nf_reject_ipv4 iptable_filter ip_tables tun bridge stp llc rpcrdma sunrpc ib_isert iscsi_target_mod ib_iser libiscsi scsi_transport_iscsi ib_srpt target_core_mod snd_hda_codec_realtek snd_hda_codec_generic snd_hda_intel snd_hda_codec snd_hda_core intel_rapl iosf_mbi sb_edac ib_srp edac_core snd_hwdep scsi_transport_srp ib_ipoib snd_seq rdma_ucm ib_ucm x86_pkg_temp_thermal ib_uverbs intel_powerclamp coretemp ib_umad rdma_cm kvm_intel snd_seq_device snd_pcm kvm snd_timer ib_cm iw_cm snd irqbypass usb_storage eeepc_wmi asus_wmi sparse_keymap rfkill iTCO_wdt crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel aesni_intel iTCO_vendor_support lrw gf128mul glue_helper video serio_raw mxm_wmi ablk_helper soundcore pcspkr cryptd ipmi_si l[  475.017391] CPU: 1 PID: 3802 Comm: fio Not tainted 4.7.0-rc2+ #2
[  475.017391] Hardware name: ASUSTeK COMPUTER INC. Z10PE-D16 WS/Z10PE-D16 WS, BIOS 3101 11/04/2015
[  475.017391]  0000000000000086 00000000a5918d2f ffff88085fc45bb0 ffffffff8133c50f
[  475.017392]  0000000000000000 0000000000000000 ffff88085fc45bc8 ffffffff8113b148
[  475.017392]  ffff88085f81f000 ffff88085fc45c00 ffffffff81174fec 0000000000000001
[  475.017392] Call Trace:
[  475.017393]  <NMI>  [<ffffffff8133c50f>] dump_stack+0x63/0x84
[  475.017393]  [<ffffffff8113b148>] watchdog_overflow_callback+0xc8/0xf0
[  475.017393]  [<ffffffff81174fec>] __perf_event_overflow+0x7c/0x1f0
[  475.017393]  [<ffffffff8117f024>] perf_event_overflow+0x14/0x20
[  475.017394]  [<ffffffff8100c33a>] intel_pmu_handle_irq+0x1da/0x480
[  475.017394]  [<ffffffff8133e686>] ? ioremap_page_range+0x296/0x410
[  475.017394]  [<ffffffff811cb4ac>] ? vunmap_page_range+0x1dc/0x310
[  475.017395]  [<ffffffff811cb5f1>] ? unmap_kernel_range_noflush+0x11/0x20
[  475.017395]  [<ffffffff813eecb6>] ? ghes_copy_tofrom_phys+0x116/0x1f0
[  475.017395]  [<ffffffff81052f3f>] ? native_apic_wait_icr_idle+0x1f/0x30
[  475.017396]  [<ffffffff810054bd>] perf_event_nmi_handler+0x2d/0x50
[  475.017396]  [<ffffffff810311a1>] nmi_handle+0x61/0x110
[  475.017396]  [<ffffffff81031704>] default_do_nmi+0x44/0x120
[  475.017397]  [<ffffffff810318cb>] do_nmi+0xeb/0x160
[  475.017397]  [<ffffffff816b24f1>] end_repeat_nmi+0x1a/0x1e
[  475.017397]  [<ffffffff8118ccd7>] ? mempool_free_slab+0x17/0x20
[  475.017397]  [<ffffffff810cc397>] ? native_queued_spin_lock_slowpath+0x177/0x1a0
[  475.017398]  [<ffffffff810cc397>] ? native_queued_spin_lock_slowpath+0x177/0x1a0
[  475.017398]  [<ffffffff810cc397>] ? native_queued_spin_lock_slowpath+0x177/0x1a0
[  475.017398]  <<EOE>>  <IRQ>  [<ffffffff81187380>] queued_spin_lock_slowpath+0xb/0xf
[  475.017399]  [<ffffffff816afe77>] _raw_spin_lock_irqsave+0x37/0x40
[  475.017399]  [<ffffffff8125d96f>] aio_complete+0x6f/0x300
[  475.017399]  [<ffffffff813072d3>] ? bio_put+0x23/0x30
[  475.017400]  [<ffffffff8124da8d>] dio_complete+0xad/0x140
[  475.017400]  [<ffffffff8124dd1b>] dio_bio_end_aio+0x6b/0xf0
[  475.017400]  [<ffffffff81307335>] bio_endio+0x55/0x60
[  475.017400]  [<ffffffff8130fb97>] blk_update_request+0x87/0x300
[  475.017401]  [<ffffffff8131919a>] blk_mq_end_request+0x1a/0x70
[  475.017401]  [<ffffffffa033bfc3>] nvme_complete_rq+0x73/0x1a0 [nvme]
[  475.017401]  [<ffffffff813182f0>] ? blkdev_issue_zeroout+0x1e0/0x1e0
[  475.017402]  [<ffffffff81318303>] __blk_mq_complete_request_remote+0x13/0x20
[  475.017402]  [<ffffffff8110346b>] flush_smp_call_function_queue+0x5b/0x160
[  475.017402]  [<ffffffff81103f53>] generic_smp_call_function_single_interrupt+0x13/0x60
[  475.017403]  [<ffffffff81050317>] smp_call_function_single_interrupt+0x27/0x40
[  475.017403]  [<ffffffff816b135c>] call_function_single_interrupt+0x8c/0xa0
[  475.017403]  <EOI>  [<ffffffff812025c9>] ? mem_cgroup_migrate+0xd9/0x140
[  475.017404]  [<ffffffff811f205a>] migrate_page_copy+0x26a/0x550
[  475.017404]  [<ffffffff8125d822>] aio_migratepage+0x142/0x1b0
[  475.017404]  [<ffffffff811f23eb>] move_to_new_page+0x5b/0x1f0
[  475.017404]  [<ffffffff811ca2b9>] ? rmap_walk+0x39/0x60
[  475.017405]  [<ffffffff811ca679>] ? try_to_unmap+0xb9/0x150
[  475.017405]  [<ffffffff811c9480>] ? page_remove_rmap+0x220/0x220
[  475.017405]  [<ffffffff811c7ea0>] ? invalid_page_referenced_vma+0x90/0x90
[  475.017406]  [<ffffffff811f2f19>] migrate_pages+0x869/0x8f0
[  475.017406]  [<ffffffff811f0ad0>] ? compound_head+0x20/0x20
[  475.017406]  [<ffffffff811f38a5>] migrate_misplaced_page+0x125/0x1b0
[  475.017407]  [<ffffffff811bc1b2>] handle_pte_fault+0x642/0x1760
[  475.017407]  [<ffffffff811be74b>] handle_mm_fault+0x2bb/0x660
[  475.017407]  [<ffffffff810b5379>] ? task_numa_work+0x259/0x320
[  475.017407]  [<ffffffff8106a3ae>] __do_page_fault+0x1ce/0x4a0
[  475.017408]  [<ffffffff8106a6b0>] do_page_fault+0x30/0x80
[  475.017408]  [<ffffffff81003ba5>] ? do_syscall_64+0xf5/0x110
[  475.017408]  [<ffffffff816b2188>] page_fault+0x28/0x30
[  475.017409] Kernel panic - not syncing: Hard LOCKUP
[  475.017409] CPU: 1 PID: 3802 Comm: fio Not tainted 4.7.0-rc2+ #2
[  475.017409] Hardware name: ASUSTeK COMPUTER INC. Z10PE-D16 WS/Z10PE-D16 WS, BIOS 3101 11/04/2015
[  475.017410]  0000000000000086 00000000a5918d2f ffff88085fc45b20 ffffffff8133c50f
[  475.017410]  ffffffff81a202d2 0000000000000000 ffff88085fc45ba0 ffffffff81186dc6
[  475.017410]  0000000000000010 ffff88085fc45bb0 ffff88085fc45b50 00000000a5918d2f
[  475.017411] Call Trace:
[  475.017411]  <NMI>  [<ffffffff8133c50f>] dump_stack+0x63/0x84
[  475.017411]  [<ffffffff81186dc6>] panic+0xe2/0x233
[  475.017411]  [<ffffffff8108267f>] nmi_panic+0x3f/0x40
[  475.017412]  [<ffffffff8113b161>] watchdog_overflow_callback+0xe1/0xf0
[  475.017412]  [<ffffffff81174fec>] __perf_event_overflow+0x7c/0x1f0
[  475.017412]  [<ffffffff8117f024>] perf_event_overflow+0x14/0x20
[  475.017413]  [<ffffffff8100c33a>] intel_pmu_handle_irq+0x1da/0x480
[  475.017413]  [<ffffffff8133e686>] ? ioremap_page_range+0x296/0x410
[  475.017413]  [<ffffffff811cb4ac>] ? vunmap_page_range+0x1dc/0x310
[  475.017414]  [<ffffffff811cb5f1>] ? unmap_kernel_range_noflush+0x11/0x20
[  475.017414]  [<ffffffff813eecb6>] ? ghes_copy_tofrom_phys+0x116/0x1f0
[  475.017414]  [<ffffffff81052f3f>] ? native_apic_wait_icr_idle+0x1f/0x30
[  475.017414]  [<ffffffff810054bd>] perf_event_nmi_handler+0x2d/0x50
[  475.017415]  [<ffffffff810311a1>] nmi_handle+0x61/0x110
[  475.017415]  [<ffffffff81031704>] default_do_nmi+0x44/0x120
[  475.017415]  [<ffffffff810318cb>] do_nmi+0xeb/0x160
[  475.017416]  [<ffffffff816b24f1>] end_repeat_nmi+0x1a/0x1e
[  475.017416]  [<ffffffff8118ccd7>] ? mempool_free_slab+0x17/0x20
[  475.017416]  [<ffffffff810cc397>] ? native_queued_spin_lock_slowpath+0x177/0x1a0
[  475.017417]  [<ffffffff810cc397>] ? native_queued_spin_lock_slowpath+0x177/0x1a0
[  475.017417]  [<ffffffff810cc397>] ? native_queued_spin_lock_slowpath+0x177/0x1a0
[  475.017417]  <<EOE>>  <IRQ>  [<ffffffff81187380>] queued_spin_lock_slowpath+0xb/0xf
[  475.017418]  [<ffffffff816afe77>] _raw_spin_lock_irqsave+0x37/0x40
[  475.017418]  [<ffffffff8125d96f>] aio_complete+0x6f/0x300
[  475.017418]  [<ffffffff813072d3>] ? bio_put+0x23/0x30
[  475.017418]  [<ffffffff8124da8d>] dio_complete+0xad/0x140
[  475.017419]  [<ffffffff8124dd1b>] dio_bio_end_aio+0x6b/0xf0
[  475.017419]  [<ffffffff81307335>] bio_endio+0x55/0x60
[  475.017419]  [<ffffffff8130fb97>] blk_update_request+0x87/0x300
[  475.017420]  [<ffffffff8131919a>] blk_mq_end_request+0x1a/0x70
[  475.017420]  [<ffffffffa033bfc3>] nvme_complete_rq+0x73/0x1a0 [nvme]
[  475.017420]  [<ffffffff813182f0>] ? blkdev_issue_zeroout+0x1e0/0x1e0
[  475.017420]  [<ffffffff81318303>] __blk_mq_complete_request_remote+0x13/0x20
[  475.017421]  [<ffffffff8110346b>] flush_smp_call_function_queue+0x5b/0x160
[  475.017421]  [<ffffffff81103f53>] generic_smp_call_function_single_interrupt+0x13/0x60
[  475.017421]  [<ffffffff81050317>] smp_call_function_single_interrupt+0x27/0x40
[  475.017422]  [<ffffffff816b135c>] call_function_single_interrupt+0x8c/0xa0
[  475.017422]  <EOI>  [<ffffffff812025c9>] ? mem_cgroup_migrate+0xd9/0x140
[  475.017422]  [<ffffffff811f205a>] migrate_page_copy+0x26a/0x550
[  475.017423]  [<ffffffff8125d822>] aio_migratepage+0x142/0x1b0
[  475.017423]  [<ffffffff811f23eb>] move_to_new_page+0x5b/0x1f0
[  475.017423]  [<ffffffff811ca2b9>] ? rmap_walk+0x39/0x60
[  475.017424]  [<ffffffff811ca679>] ? try_to_unmap+0xb9/0x150
[  475.017424]  [<ffffffff811c9480>] ? page_remove_rmap+0x220/0x220
[  475.017424]  [<ffffffff811c7ea0>] ? invalid_page_referenced_vma+0x90/0x90
[  475.017424]  [<ffffffff811f2f19>] migrate_pages+0x869/0x8f0
[  475.017425]  [<ffffffff811f0ad0>] ? compound_head+0x20/0x20
[  475.017425]  [<ffffffff811f38a5>] migrate_misplaced_page+0x125/0x1b0
[  475.017425]  [<ffffffff811bc1b2>] handle_pte_fault+0x642/0x1760
[  475.017426]  [<ffffffff811be74b>] handle_mm_fault+0x2bb/0x660
[  475.017426]  [<ffffffff810b5379>] ? task_numa_work+0x259/0x320
[  475.017426]  [<ffffffff8106a3ae>] __do_page_fault+0x1ce/0x4a0
[  475.017427]  [<ffffffff8106a6b0>] do_page_fault+0x30/0x80
[  475.017427]  [<ffffffff81003ba5>] ? do_syscall_64+0xf5/0x110
[  475.017427]  [<ffffffff816b2188>] page_fault+0x28/0x30
[  475.017483] Kernel Offset: disabled

# diff -u block/blk-lib.c ~/blk-lib.c 
--- block/blk-lib.c     2016-07-04 18:52:58.655123151 +0900
+++ /root/blk-lib.c     2016-07-04 18:52:31.154899845 +0900
@@ -118,6 +118,7 @@
                ret = submit_bio_wait(bio);
                if (ret == -EOPNOTSUPP)
                        ret = 0;
+               bio_put(bio);
        }
        blk_finish_plug(&plug);
 
@@ -171,8 +172,10 @@
                }
        }
 
-       if (bio)
+       if (bio) {
                ret = submit_bio_wait(bio);
+               bio_put(bio);
+       }
        return ret != -EOPNOTSUPP ? ret : 0;
 }
 EXPORT_SYMBOL(blkdev_issue_write_same);
@@ -212,8 +215,11 @@
                }
        }
 
-       if (bio)
-               return submit_bio_wait(bio);
+       if (bio) {
+               ret = submit_bio_wait( bio);
+               bio_put(bio);
+               return ret;
+       }
        return 0;
 }



-----Original Message-----
From: 'Christoph Hellwig' [mailto:hch@infradead.org] 
Sent: Tuesday, June 28, 2016 5:50 PM
To: SWise OGC <swise at opengridcomputing.com>
Cc: 'Sagi Grimberg' <sagi at grimberg.me>; 'Ming Lin' <mlin at kernel.org>; 'Christoph Hellwig' <hch at infradead.org>; Yoichi Hayakawa <yoichi at chelsio.com>; linux-nvme at lists.infradead.org
Subject: Re: target crash / host hang with nvme-all.3 branch of nvme-fabrics

On Mon, Jun 27, 2016@09:19:26AM -0500, Steve Wise wrote:
> It appears this OOM issue is resolved in linux-4.7-rc5.  Does it make sense to
> publish a rebased nvmf-all?  

I'd rather get everything into Jens' tree...

Either way - I suspect the fix you need is this one:

http://git.kernel.dk/cgit/linux-block/commit/block/blk-lib.c?h=for-linus&id=05bd92dddc595d74ea645e793c1f3bd4b1fc251a

but that won't be in the for-next tree either.

From: mohana.goli@seagate.com (Mohana Goli)
Date: Wed, 9 Sep 2015 12:36:41 +0530
Subject: [PATCH] NVMe: Force cancel commands on hot-removal
In-Reply-To: <CAPYzm7Sm4K-VVWxGLAD2sjJ_e=FL3aQor8npN4sVcJ6irBtzJg@mail.gmail.com>
References: <1441743187-12277-1-git-send-email-keith.busch@intel.com>
 <CAPYzm7Sm4K-VVWxGLAD2sjJ_e=FL3aQor8npN4sVcJ6irBtzJg@mail.gmail.com>
Message-ID: <CAPYzm7RB-LqEW1f0e-_Sh_ui3vS6q3sEOQ7sk5xfsOEG9SOVmg@mail.gmail.com>

Keith,

Don't we need to take a queue spin lock  while processing the IOs on
each request queue like the way we are doing in nvme_clear_queue ?


 >>>blk_mq_all_tag_busy_iter(hctx->tags,
                                              nvme_cancel_queue_ios,
                                               hctx->driver_data);


Thanks & Regards,
Mohan.

On Wed, Sep 9, 2015@10:18 AM, Mohana Goli <mohana.goli@seagate.com> wrote:
> Keith,
>
> With the  patch issue is resolved.I do not see any IO timeouts and
> device removal process is also very quick.However i noticed below
> warning while running dd write IOs.I think this warning is OK since
> the IOs which are generated as part of flushing the  dirty filesystem
> cache are failed.
>
> Thanks for the patch.
>
> Tested-by: Mohana Rao Goli <mohana.goli at seagate.com>
>
> ------------------------
> [49317.467067] pciehp 0000:0e:09.0:pcie24: pending interrupts 0x0108
> from Slot Status
> [49317.467077] pciehp 0000:0e:09.0:pcie24: DPC Interrupt status is
> set:status = 0x89
> [49317.467079] pciehp 0000:0e:09.0:pcie24: DPC is triggered:status = 0x89
> [49317.467085] pciehp 0000:0e:09.0:pcie24: Card not present on Slot(9)
> [49317.467087] pciehp 0000:0e:09.0:pcie24: slot(9): Link Down event
> [49317.467098] pciehp 0000:0e:09.0:pcie24: Handle DPC Event on the slot(9)
> [49317.467100] pciehp 0000:0e:09.0:pcie24: handle_dpc_trigger_event:
> allocated memory :info =0xffff88102ddc1580
> [49317.467105] pciehp 0000:0e:09.0:pcie24: pciehp_unconfigure_device:
> domain:bus:dev = 0000:15:00
> [49317.467132] nvme_ns_remove :entry kill =1
> [49317.467142] nvme 0000:15:00.0: Cancelling I/O 330 QID 4
> [49317.467144] blk_update_request: 22 callbacks suppressed
> [49317.467145] blk_update_request: I/O error, dev nvme0n1, sector 5868608
> [49317.467147] Buffer I/O error on dev nvme0n1, logical block 733576,
> lost async page write
> [49317.467151] nvme 0000:15:00.0: Cancelling I/O 331 QID 4
> [49317.467153] blk_update_request: I/O error, dev nvme0n1, sector 5868616
> [49317.467154] Buffer I/O error on dev nvme0n1, logical block 733577,
> lost async page write
> [49317.467156] nvme 0000:15:00.0: Cancelling I/O 332 QID 4
> [49317.467157] blk_update_request: I/O error, dev nvme0n1, sector 5868624
> [49317.467158] Buffer I/O error on dev nvme0n1, logical block 733578,
> lost async page write
> [49317.467161] nvme 0000:15:00.0: Cancelling I/O 334 QID 4
> [49317.467162] blk_update_request: I/O error, dev nvme0n1, sector 5868640
> [49317.467163] Buffer I/O error on dev nvme0n1, logical block 733580,
> lost async page write
> [49317.467166] nvme 0000:15:00.0: Cancelling I/O 336 QID 4
> [49317.467167] blk_update_request: I/O error, dev nvme0n1, sector 5868656
> [49317.467168] Buffer I/O error on dev nvme0n1, logical block 733582,
> lost async page write
> [49317.467170] nvme 0000:15:00.0: Cancelling I/O 339 QID 4
> [49317.467171] blk_update_request: I/O error, dev nvme0n1, sector 5868680
> [49317.467172] Buffer I/O error on dev nvme0n1, logical block 733585,
> lost async page write
> [49317.467175] nvme 0000:15:00.0: Cancelling I/O 341 QID 4
> [49317.467176] blk_update_request: I/O error, dev nvme0n1, sector 5868696
> [49317.467177] Buffer I/O error on dev nvme0n1, logical block 733587,
> lost async page write
> [49317.467179] nvme 0000:15:00.0: Cancelling I/O 344 QID 4
> [49317.467180] blk_update_request: I/O error, dev nvme0n1, sector 5868720
> [49317.467181] Buffer I/O error on dev nvme0n1, logical block 733590,
> lost async page write
> [49317.467184] nvme 0000:15:00.0: Cancelling I/O 348 QID 4
> [49317.467185] blk_update_request: I/O error, dev nvme0n1, sector 5868752
> [49317.467186] Buffer I/O error on dev nvme0n1, logical block 733594,
> lost async page write
> [49317.467188] nvme 0000:15:00.0: Cancelling I/O 351 QID 4
> [49317.467189] blk_update_request: I/O error, dev nvme0n1, sector 5868776
> [49317.467190] Buffer I/O error on dev nvme0n1, logical block 733597,
> lost async page write
> [49317.467193] nvme 0000:15:00.0: Cancelling I/O 353 QID 4
> [49317.467196] nvme 0000:15:00.0: Cancelling I/O 355 QID 4
> [49317.467198] nvme 0000:15:00.0: Cancelling I/O 358 QID 4
> [49317.467200] nvme 0000:15:00.0: Cancelling I/O 360 QID 4
> [49317.467203] nvme 0000:15:00.0: Cancelling I/O 363 QID 4
> [49317.467206] nvme 0000:15:00.0: Cancelling I/O 366 QID 4
> [49317.467209] nvme 0000:15:00.0: Cancelling I/O 368 QID 4
> [49317.467211] nvme 0000:15:00.0: Cancelling I/O 371 QID 4
> [49317.467213] nvme 0000:15:00.0: Cancelling I/O 373 QID 4
> [49317.467216] nvme 0000:15:00.0: Cancelling I/O 374 QID 4
> [49317.467219] nvme 0000:15:00.0: Cancelling I/O 376 QID 4
> [49317.467221] nvme 0000:15:00.0: Cancelling I/O 377 QID 4
> [49317.467224] nvme 0000:15:00.0: Cancelling I/O 379 QID 4
> [49317.467227] nvme 0000:15:00.0: Cancelling I/O 380 QID 4
> [49317.467230] nvme 0000:15:00.0: Cancelling I/O 383 QID 4
> [49317.467233] nvme 0000:15:00.0: Cancelling I/O 384 QID 4
> [49317.467236] nvme 0000:15:00.0: Cancelling I/O 386 QID 4
> [49317.467239] nvme 0000:15:00.0: Cancelling I/O 387 QID 4
> [49317.467242] nvme 0000:15:00.0: Cancelling I/O 389 QID 4
> [49317.467244] nvme 0000:15:00.0: Cancelling I/O 390 QID 4
> [49317.467247] nvme 0000:15:00.0: Cancelling I/O 392 QID 4
> [49317.467250] nvme 0000:15:00.0: Cancelling I/O 393 QID 4
> [49317.467253] nvme 0000:15:00.0: Cancelling I/O 395 QID 4
> [49317.467255] nvme 0000:15:00.0: Cancelling I/O 396 QID 4
> [49317.467257] nvme 0000:15:00.0: Cancelling I/O 398 QID 4
> [49317.467260] nvme 0000:15:00.0: Cancelling I/O 400 QID 4
> [49317.467262] nvme 0000:15:00.0: Cancelling I/O 402 QID 4
> [49317.467264] nvme 0000:15:00.0: Cancelling I/O 404 QID 4
> [49317.467266] nvme 0000:15:00.0: Cancelling I/O 406 QID 4
> [49317.467269] nvme 0000:15:00.0: Cancelling I/O 408 QID 4
> [49317.467271] nvme 0000:15:00.0: Cancelling I/O 410 QID 4
> [49317.467273] nvme 0000:15:00.0: Cancelling I/O 411 QID 4
> [49317.467275] nvme 0000:15:00.0: Cancelling I/O 412 QID 4
> [49317.467278] nvme 0000:15:00.0: Cancelling I/O 413 QID 4
> [49317.467280] nvme 0000:15:00.0: Cancelling I/O 414 QID 4
> [49317.467282] nvme 0000:15:00.0: Cancelling I/O 415 QID 4
> [49317.467284] nvme 0000:15:00.0: Cancelling I/O 416 QID 4
> [49317.467287] nvme 0000:15:00.0: Cancelling I/O 417 QID 4
> [49317.467290] nvme 0000:15:00.0: Cancelling I/O 419 QID 4
> [49317.467293] nvme 0000:15:00.0: Cancelling I/O 420 QID 4
> [49317.467295] nvme 0000:15:00.0: Cancelling I/O 423 QID 4
> [49317.467298] nvme 0000:15:00.0: Cancelling I/O 426 QID 4
> [49317.467301] nvme 0000:15:00.0: Cancelling I/O 429 QID 4
> [49317.467304] nvme 0000:15:00.0: Cancelling I/O 432 QID 4
> [49317.467305] nvme 0000:15:00.0: Cancelling I/O 434 QID 4
> [49317.467308] nvme 0000:15:00.0: Cancelling I/O 435 QID 4
> [49317.467311] nvme 0000:15:00.0: Cancelling I/O 440 QID 4
> [49317.467314] nvme 0000:15:00.0: Cancelling I/O 441 QID 4
> [49317.467316] nvme 0000:15:00.0: Cancelling I/O 442 QID 4
> [49317.467319] nvme 0000:15:00.0: Cancelling I/O 443 QID 4
> [49317.467320] nvme 0000:15:00.0: Cancelling I/O 444 QID 4
> [49317.467322] nvme 0000:15:00.0: Cancelling I/O 445 QID 4
> [49317.467324] nvme 0000:15:00.0: Cancelling I/O 446 QID 4
> [49317.467327] nvme 0000:15:00.0: Cancelling I/O 447 QID 4
> [49317.467329] nvme 0000:15:00.0: Cancelling I/O 448 QID 4
> [49317.467331] nvme 0000:15:00.0: Cancelling I/O 449 QID 4
> [49317.769832] device: 'nvme0n1': device_del
> [49317.769974] nvme_ns_remove :gen disk removed
> [49317.821140] ------------[ cut here ]------------
> [49317.821150] WARNING: CPU: 2 PID: 50212 at fs/block_dev.c:57
> __blkdev_put+0x1c1/0x200()
> [49317.821152] Modules linked in: nvme(OE) fuse(E) btrfs(E) xor(E)
> raid6_pq(E) hfsplus(E) vfat(E) msdos(E) fat(E) jfs(E) reiserfs(E)
> ext4(E) crc16(E) jbd2(E) ext3(E) jbd(E) ext2(E) mbcache(E)
> xt_CHECKSUM(E) ipt_MASQUERADE(E) nf_nat_masquerade_ipv4(E) tun(E)
> af_packet(E) xt_tcpudp(E) ip6t_rpfilter(E) ip6t_REJECT(E)
> nf_reject_ipv6(E) ipt_REJECT(E) nf_reject_ipv4(E) xt_conntrack(E)
> sr_mod(E) cdrom(E) ebtable_nat(E) ebtable_broute(E) bridge(E) stp(E)
> llc(E) ebtable_filter(E) ebtables(E) ip6table_nat(E)
> nf_conntrack_ipv6(E) nf_defrag_ipv6(E) nf_nat_ipv6(E)
> ip6table_mangle(E) ip6table_raw(E) ip6table_filter(E) ip6_tables(E)
> iptable_nat(E) nf_conntrack_ipv4(E) nf_defrag_ipv4(E) nf_nat_ipv4(E)
> nf_nat(E) nf_conntrack(E) iptable_mangle(E) iptable_raw(E)
> iptable_filter(E) ip_tables(E) x_tables(E) dm_mirror(E)
> [49317.821186]  dm_region_hash(E) dm_log(E) coretemp(E)
> x86_pkg_temp_thermal(E) kvm_intel(E) kvm(E) uas(E) ipmi_devintf(E)
> usb_storage(E) crct10dif_pclmul(E) crc32_pclmul(E) crc32c_intel(E)
> ghash_clmulni_intel(E) jitterentropy_rng(E) hmac(E) drbg(E)
> ansi_cprng(E) aesni_intel(E) aes_x86_64(E) lrw(E) gf128mul(E)
> iTCO_wdt(E) glue_helper(E) iTCO_vendor_support(E) ablk_helper(E)
> mousedev(E) evdev(E) cryptd(E) mac_hid(E) tpm_tis(E) sb_edac(E)
> lpc_ich(E) pcspkr(E) ioatdma(E) edac_core(E) tpm(E) ipmi_si(E)
> i2c_i801(E) mfd_core(E) battery(E) ipmi_msghandler(E) thermal(E)
> wmi(E) acpi_pad(E) nfsd(E) button(E) processor(E) ac(E) auth_rpcgss(E)
> nfs_acl(E) lockd(E) grace(E) sunrpc(E) hid_generic(E) usbhid(E) hid(E)
> sd_mod(E) ast(E) syscopyarea(E) sysfillrect(E) sysimgblt(E)
> i2c_algo_bit(E) drm_kms_helper(E) ahci(E)
> [49317.821219]  libahci(E) ttm(E) libata(E) ixgbe(E) ehci_pci(E)
> drm(E) mdio(E) ehci_hcd(E) hwmon(E) vxlan(E) ip6_udp_tunnel(E)
> udp_tunnel(E) e1000e(E) dca(E) usbcore(E) ptp(E) scsi_mod(E)
> usb_common(E) i2c_core(E) pps_core(E) ipv6(E) [last unloaded: nvme]
> [49317.821231] CPU: 2 PID: 50212 Comm: dd Tainted: G        W  OE   4.2.0 #5
> [49317.821233] Hardware name: Seagate CS6000AC/Type2 - Board Product
> Summit Point, BIOS SummitPoint.v02.0009 08/13/2014
> [49317.821234]  ffffffff817397d3 ffff88103445fdb8 ffffffff81523669
> 0000000000000000
> [49317.821236]  0000000000000000 ffff88103445fdf8 ffffffff810534aa
> 0000000000000000
> [49317.821238]  ffff880f226f00f0 ffff880f226f0000 ffff880f226f0170
> ffff880f226f0018
> [49317.821240] Call Trace:
> [49317.821247]  [<ffffffff81523669>] dump_stack+0x45/0x57
> [49317.821251]  [<ffffffff810534aa>] warn_slowpath_common+0x8a/0xc0
> [49317.821253]  [<ffffffff8105359a>] warn_slowpath_null+0x1a/0x20
> [49317.821255]  [<ffffffff811d7961>] __blkdev_put+0x1c1/0x200
> [49317.821256]  [<ffffffff811d8220>] blkdev_put+0x50/0x120
> [49317.821258]  [<ffffffff811d83a5>] blkdev_close+0x25/0x30
> [49317.821262]  [<ffffffff811a1d3c>] __fput+0xdc/0x1e0
> [49317.821264]  [<ffffffff811a1e8e>] ____fput+0xe/0x10
> [49317.821267]  [<ffffffff8106cda5>] task_work_run+0x85/0xb0
> [49317.821270]  [<ffffffff81003798>] do_notify_resume+0x58/0x80
> [49317.821273]  [<ffffffff81529b02>] int_signal+0x12/0x17
> [49317.821274] ---[ end trace 100510bdcaa3ba59 ]---
> [49317.823245] device: '259:0': device_unregister
> [49317.823248] device: '259:0': device_del
> [49317.823299] device: '259:0': device_create_release
> [49317.823303] nvme_ns_remove :exit
> [49317.824749] nvme 0000:15:00.0: Cancelling I/O 1 QID 0
> [49317.824756] nvme :Removed the namespaces
> [49317.824856] device: 'nvme0': device_unregister
> [49317.824857] device: 'nvme0': device_del
> [49317.825047] device: 'nvme0': device_create_release
> [49317.832985] nvme :nvme dev completly removed
> [49317.832993] device: '0000:15:00.0': device_del
> [49317.833043] pciehp 0000:0e:09.0:pcie24: pciehp_unconfigure_device:
> domain:bus:dev = 0000:15:00
> [49317.833054] pcieport 0000:0e:09.0: Clear the DPC trigger status = 0x89
>
> On Wed, Sep 9, 2015@1:43 AM, Keith Busch <keith.busch@intel.com> wrote:
>> On a surprise removal when pciehp is in use, the port services driver
>> will usually notify the nvme driver to remove the device before the
>> nvme polling thread detects it is gone. If this happens, the queues are
>> not shutdown prior to deleting namespace gendisks, so there may be IO
>> outstanding that will never complete. An unnecessarily long timeout has to
>> happen in order to complete the IO's with failure status. This patch fixes
>> that by clearing the queues first when we know the device is IO incapable.
>>
>> Reported-by: Mohana Goli <mohana.goli at seagate.com>
>> Signed-off-by: Keith Busch <keith.busch at intel.com>
>> ---
>>  drivers/block/nvme-core.c |   13 ++++++++++++-
>>  1 file changed, 12 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
>> index b97fc3f..cf052b5 100644
>> --- a/drivers/block/nvme-core.c
>> +++ b/drivers/block/nvme-core.c
>> @@ -2402,8 +2402,19 @@ static void nvme_ns_remove(struct nvme_ns *ns)
>>  {
>>         bool kill = nvme_io_incapable(ns->dev) && !blk_queue_dying(ns->queue);
>>
>> -       if (kill)
>> +       if (kill) {
>> +               int i;
>> +               struct blk_mq_hw_ctx *hctx;
>> +
>>                 blk_set_queue_dying(ns->queue);
>> +               queue_for_each_hw_ctx(ns->queue, hctx, i) {
>> +                       if (!hctx->tags)
>> +                               continue;
>> +                       blk_mq_all_tag_busy_iter(hctx->tags,
>> +                                               nvme_cancel_queue_ios,
>> +                                               hctx->driver_data);
>> +               }
>> +       }
>>         if (ns->disk->flags & GENHD_FL_UP) {
>>                 if (blk_get_integrity(ns->disk))
>>                         blk_integrity_unregister(ns->disk);
>> --
>> 1.7.10.4
>>

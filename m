Return-Path: <SRS0=Lfpf=MM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC4E0C07E9B
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Jul 2021 22:08:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 504B061009
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Jul 2021 22:08:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 504B061009
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=strugglers.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=xnh8AtcfNrvKcgsf0Pur6stDdKMA8KevWxhDXHofUWI=; b=xxmbjrbWCvFRk+
	nAbIwnd6h11mSWZFc+1VAIidVNmTIB7mZVx5KW/yuIb92UohIbf27LPoiEYBIEsUJrD8d/Cy3lU0/
	BRFj+gBBL/Os6dChcbdUHRXehhuRnBWRJykqIRnc35p7k8R2c9nJwtK9//MszQUsWo2wCE5+43HTw
	f1gTr0eS/2Ky5w6JK4RGH5Nngr4I56WP9BB46uogboaCvC8SzowedVBjy/WkP15+er5HhUVObB/0w
	btUAHEKuG5c8w/fBBEHmkzEH2/Odk0T9/LrkXOIv8u91phlYRyJhNeYlA1HVNIaMuokqPO2ZcGxOg
	mkyTXAn5pjgSvpNqUAlA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m5xtt-00E334-TQ; Tue, 20 Jul 2021 22:07:41 +0000
Received: from mail.bitfolk.com ([2001:ba8:1f1:f019::25])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m5xtq-00E32P-E0
 for Linux-nvme@lists.infradead.org; Tue, 20 Jul 2021 22:07:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bitfolk.com
 ; s=alpha;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Subject:To:From:Date:Sender:Reply-To:Cc:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=TvPPbgzCvD/3wAzz+8aBy9ZtEnaleku/Y11a4Eb96b8=; b=jveCSaURMcXUwT9yQnDTy4E9lg
 JzUkKtbGmGhg4Pp/dJB9ELRFfTRQwwdn2aA5tFlGnLyaM0FuSThKXvqifx0jAc6ooGaJulBqrMw7H
 s0RGxQ/gt4oOVYNs97VtfPkHo7peD6VdeEpA7gUtd9YbtPqLxw/Y5yQuF0ruz4fhkX2LYZV22GXR7
 +/2qgDXXh/pxWEWfQeuJIHJ0nDvic7IkftBAVUoOKZO/MJ4kmEtWFHftq/StHB1B1vx6oXvUCK99L
 1Y69VqxLm06B3LYsZb+CIxIedD9gREoW5kTOTc5UkngzjWG8zpRRPoruq4Fuqca6Gd7ENeEtcuu3N
 esTlq83w==;
Received: from andy by mail.bitfolk.com with local (Exim 4.89)
 (envelope-from <andy@strugglers.net>) id 1m5xtl-0004nq-MY
 for Linux-nvme@lists.infradead.org; Tue, 20 Jul 2021 22:07:33 +0000
Date: Tue, 20 Jul 2021 22:07:33 +0000
From: Andy Smith <andy@strugglers.net>
To: Linux-nvme@lists.infradead.org
Subject: 5.10.40-1 - Invalid SGL for payload:131072 nents:13
Message-ID: <20210720220733.h324jghdtqorh2hs@bitfolk.com>
MIME-Version: 1.0
Content-Disposition: inline
OpenPGP: id=BF15490B; url=http://strugglers.net/~andy/pubkey.asc
X-URL: http://strugglers.net/wiki/User:Andy
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: andy@strugglers.net
X-SA-Exim-Scanned: No (on mail.bitfolk.com); SAEximRunCond expanded to false
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210720_150738_689295_FD999FDA 
X-CRM114-Status: GOOD (  16.74  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi,

I have a Debian stable machine with a Samsung PM983 NVMe and a
Samsung SM883 in an MD RAID-1. It's been running the 4.19.x Debian
packaged kernel for almost 2 years now.

About 24 hours ago I upgraded its kernel to the buster-backports
kernel which is version 5.10.40-1~bpo10+1 and around four hours
after that I got this:

Jul 20 02:17:54 lamb kernel: [21061.388607] sg[0] phys_addr:0x00000015eb803000 offset:0 length:4096 dma_address:0x000000209e7b7000 dma_length:4096
Jul 20 02:17:54 lamb kernel: [21061.389775] sg[1] phys_addr:0x00000015eb7bc000 offset:0 length:4096 dma_address:0x000000209e7b8000 dma_length:4096
Jul 20 02:17:54 lamb kernel: [21061.390874] sg[2] phys_addr:0x00000015eb809000 offset:0 length:4096 dma_address:0x000000209e7b9000 dma_length:4096
Jul 20 02:17:54 lamb kernel: [21061.391974] sg[3] phys_addr:0x00000015eb766000 offset:0 length:4096 dma_address:0x000000209e7ba000 dma_length:4096
Jul 20 02:17:54 lamb kernel: [21061.393042] sg[4] phys_addr:0x00000015eb7a3000 offset:0 length:4096 dma_address:0x000000209e7bb000 dma_length:4096
Jul 20 02:17:54 lamb kernel: [21061.394086] sg[5] phys_addr:0x00000015eb7c6000 offset:0 length:4096 dma_address:0x000000209e7bc000 dma_length:4096
Jul 20 02:17:54 lamb kernel: [21061.395078] sg[6] phys_addr:0x00000015eb7c2000 offset:0 length:4096 dma_address:0x000000209e7bd000 dma_length:4096
Jul 20 02:17:54 lamb kernel: [21061.396042] sg[7] phys_addr:0x00000015eb7a9000 offset:0 length:4096 dma_address:0x000000209e7be000 dma_length:4096
Jul 20 02:17:54 lamb kernel: [21061.397004] sg[8] phys_addr:0x00000015eb775000 offset:0 length:4096 dma_address:0x000000209e7bf000 dma_length:4096
Jul 20 02:17:54 lamb kernel: [21061.397971] sg[9] phys_addr:0x00000015eb7c7000 offset:0 length:4096 dma_address:0x00000020ff520000 dma_length:4096
Jul 20 02:17:54 lamb kernel: [21061.398889] sg[10] phys_addr:0x00000015eb7cb000 offset:0 length:4096 dma_address:0x00000020ff521000 dma_length:4096
Jul 20 02:17:54 lamb kernel: [21061.399814] sg[11] phys_addr:0x00000015eb7e3000 offset:0 length:61952 dma_address:0x00000020ff522000 dma_length:61952
Jul 20 02:17:54 lamb kernel: [21061.400754] sg[12] phys_addr:0x00000015eb7f2200 offset:512 length:24064 dma_address:0x00000020ff531200 dma_length:24064
Jul 20 02:17:54 lamb kernel: [21061.401781] ------------[ cut here ]------------
Jul 20 02:17:54 lamb kernel: [21061.402738] Invalid SGL for payload:131072 nents:13
Jul 20 02:17:54 lamb kernel: [21061.403724] WARNING: CPU: 1 PID: 12669 at drivers/nvme/host/pci.c:716 nvme_map_data+0x7e0/0x820 [nvme]
Jul 20 02:17:54 lamb kernel: [21061.404728] Modules linked in: binfmt_misc ip6t_REJECT nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 xt_tcpmss nf_log_ipv6 nf_log_ipv4 nf_log_common xt_LOG xt_limit nfnetlink_log nfnetlink xt_NFLOG xt_multiport xt_tcpudp ip6table_filter ip6_tables iptable_filter bonding btrfs blake2b_generic dm_snapshot dm_bufio intel_rapl_msr intel_rapl_common skx_edac nfit libnvdimm intel_powerclamp crc32_pclmul ghash_clmulni_intel ipmi_ssif aesni_intel libaes crypto_simd cryptd glue_helper snd_hda_intel snd_intel_dspcfg mei_wdt soundwire_intel soundwire_generic_allocation nvme wdat_wdt snd_soc_core ast snd_compress watchdog drm_vram_helper drm_ttm_helper soundwire_cadence pcspkr nvme_core ttm snd_hda_codec drm_kms_helper snd_hda_core i2c_i801 snd_hwdep i2c_smbus cec soundwire_bus snd_pcm drm snd_timer snd soundcore igb ptp pps_core i2c_algo_bit joydev mei_me sg mei intel_lpss_pci intel_lpss idma64 acpi_ipmi ipmi_si ipmi_devintf ioatdma dca wmi ipmi_msghandler button dm_m
 od xenfs xen_acpi_processor
Jul 20 02:17:54 lamb kernel: [21061.404831]  xen_privcmd xen_pciback xen_netback xen_blkback xen_gntalloc xen_gntdev xen_evtchn ip_tables x_tables autofs4 ext4 crc16 mbcache jbd2 raid456 libcrc32c crc32c_generic async_raid6_recov async_memcpy async_pq async_xor xor async_tx evdev hid_generic usbhid hid raid6_pq raid0 multipath linear raid10 raid1 md_mod sd_mod t10_pi crc_t10dif crct10dif_generic crct10dif_pclmul crct10dif_common xhci_pci ahci libahci crc32c_intel xhci_hcd libata usbcore scsi_mod usb_common
Jul 20 02:17:54 lamb kernel: [21061.417998] CPU: 1 PID: 12669 Comm: 62.xvda-0 Not tainted 5.10.0-0.bpo.7-amd64 #1 Debian 5.10.40-1~bpo10+1
Jul 20 02:17:54 lamb kernel: [21061.418459] Hardware name: Supermicro Super Server/X11SRM-VF, BIOS 1.2a 02/18/2019
Jul 20 02:17:54 lamb kernel: [21061.418922] RIP: e030:nvme_map_data+0x7e0/0x820 [nvme]
Jul 20 02:17:54 lamb kernel: [21061.419354] Code: d0 7b c0 48 c7 c7 40 d6 7b c0 e8 5b 44 c9 c0 8b 93 4c 01 00 00 f6 43 1e 04 75 36 8b 73 28 48 c7 c7 20 9c 7b c0 e8 8b 71 09 c1 <0f> 0b 41 bd 0a 00 00 00 e9 f7 fe ff ff 48 8d bd 68 02 00 00 48 89
Jul 20 02:17:54 lamb kernel: [21061.420271] RSP: e02b:ffffc90044797930 EFLAGS: 00010286
Jul 20 02:17:54 lamb kernel: [21061.420727] RAX: 0000000000000000 RBX: ffff888157db4200 RCX: 0000000000000027
Jul 20 02:17:54 lamb kernel: [21061.421186] RDX: 0000000000000027 RSI: ffff888292858a00 RDI: ffff888292858a08
Jul 20 02:17:54 lamb kernel: [21061.421639] RBP: ffff888103243000 R08: 0000000000000000 R09: c00000010000118b
Jul 20 02:17:54 lamb kernel: [21061.422090] R10: 0000000000165920 R11: ffffc90044797738 R12: ffffffffc07b9bd0
Jul 20 02:17:54 lamb kernel: [21061.422583] R13: 000000000000000d R14: 0000000000000000 R15: 000000000000000d
Jul 20 02:17:54 lamb kernel: [21061.423052] FS:  0000000000000000(0000) GS:ffff888292840000(0000) knlGS:0000000000000000
Jul 20 02:17:54 lamb kernel: [21061.423518] CS:  e030 DS: 0000 ES: 0000 CR0: 0000000080050033
Jul 20 02:17:54 lamb kernel: [21061.423986] CR2: 00007f909a037c30 CR3: 000000010d2dc000 CR4: 0000000000050660
Jul 20 02:17:54 lamb kernel: [21061.424472] Call Trace:
Jul 20 02:17:54 lamb kernel: [21061.424943]  nvme_queue_rq+0x98/0x190 [nvme]
Jul 20 02:17:54 lamb kernel: [21061.425425]  blk_mq_dispatch_rq_list+0x123/0x7d0
Jul 20 02:17:54 lamb kernel: [21061.425904]  ? sbitmap_get+0x66/0x140
Jul 20 02:17:54 lamb kernel: [21061.426385]  ? elv_rb_del+0x1f/0x30
Jul 20 02:17:54 lamb kernel: [21061.426909]  ? deadline_remove_request+0x55/0xc0
Jul 20 02:17:54 lamb kernel: [21061.427373]  __blk_mq_do_dispatch_sched+0x164/0x2d0
Jul 20 02:17:54 lamb kernel: [21061.427843]  __blk_mq_sched_dispatch_requests+0x135/0x170
Jul 20 02:17:54 lamb kernel: [21061.428310]  blk_mq_sched_dispatch_requests+0x30/0x60
Jul 20 02:17:54 lamb kernel: [21061.428795]  __blk_mq_run_hw_queue+0x51/0xd0
Jul 20 02:17:54 lamb kernel: [21061.429269]  __blk_mq_delay_run_hw_queue+0x141/0x160
Jul 20 02:17:54 lamb kernel: [21061.429752]  blk_mq_sched_insert_requests+0x6a/0xf0
Jul 20 02:17:54 lamb kernel: [21061.430233]  blk_mq_flush_plug_list+0x119/0x1b0
Jul 20 02:17:54 lamb kernel: [21061.430756]  blk_flush_plug_list+0xd7/0x100
Jul 20 02:17:54 lamb kernel: [21061.431241]  blk_finish_plug+0x21/0x30
Jul 20 02:17:54 lamb kernel: [21061.431734]  dispatch_rw_block_io+0x6a5/0x9a0 [xen_blkback]
Jul 20 02:17:54 lamb kernel: [21061.432220]  __do_block_io_op+0x31d/0x620 [xen_blkback]
Jul 20 02:17:54 lamb kernel: [21061.432714]  ? _raw_spin_unlock_irqrestore+0x14/0x20
Jul 20 02:17:54 lamb kernel: [21061.433193]  ? try_to_del_timer_sync+0x4d/0x80
Jul 20 02:17:54 lamb kernel: [21061.433680]  xen_blkif_schedule+0xda/0x670 [xen_blkback]
Jul 20 02:17:54 lamb kernel: [21061.434160]  ? __schedule+0x2c6/0x770
Jul 20 02:17:54 lamb kernel: [21061.434679]  ? finish_wait+0x80/0x80
Jul 20 02:17:54 lamb kernel: [21061.435129]  ? xen_blkif_be_int+0x30/0x30 [xen_blkback]
Jul 20 02:17:54 lamb kernel: [21061.435571]  kthread+0x116/0x130
Jul 20 02:17:54 lamb kernel: [21061.436002]  ? kthread_park+0x80/0x80
Jul 20 02:17:54 lamb kernel: [21061.436422]  ret_from_fork+0x22/0x30
Jul 20 02:17:54 lamb kernel: [21061.436846] ---[ end trace 1d90be7aea2d9148 ]---
Jul 20 02:17:54 lamb kernel: [21061.437250] blk_update_request: I/O error, dev nvme0n1, sector 912000815 op 0x1:(WRITE) flags 0x800 phys_seg 13 prio class 0
Jul 20 02:17:54 lamb kernel: [21061.446344] md/raid1:md4: Disk failure on nvme0n1, disabling device.
Jul 20 02:17:54 lamb kernel: [21061.446344] md/raid1:md4: Operation continuing on 1 devices.

I was able to re-add nvme0n1 to the RAID-1 and continue without
rebooting but then later:

Jul 20 20:43:23 lamb kernel: [87388.876154] blk_update_request: I/O error, dev nvme0n1, sector 916064223 op 0x1:(WRITE) flags 0x800 phys_seg 28 prio class 0
Jul 20 20:43:23 lamb kernel: [87388.877750] md/raid1:md4: Disk failure on nvme0n1, disabling device.
Jul 20 20:43:23 lamb kernel: [87388.877750] md/raid1:md4: Operation continuing on 1 devices.

(no call trace this time)

Since this has started happening so soon after changing kernel, I
suspect change in kernel rather than faulty NVMe device, or maybe
faulty device that previous 4.19.x kernels did not catch, at least.

I found
<http://lists.infradead.org/pipermail/linux-nvme/2017-July/011930.html>
with similar log warning, which seems to be about invalid DMA
addresses and maybe Xen; in
<http://lists.infradead.org/pipermail/linux-nvme/2017-July/012055.html>
Christoph says, "I wonder if swiotlb-xen is involved" but the thread
doesn't seem to come to a resolution. My system is a Xen system
also.

Does anyone know if this issue was isolated and fixed but maybe not
backported to the Debian backports kernel?

Or could it be lurking undetected in the 4.19.x kernels I was
previously running (and am still running on other hosts with same
drives)?

Apart from the I/O error which causes the device to be kicked out
of RAID, can it be causing corruption either on this kernel or
silently on the 4.19.x kernels?

I am sorry that I haven't simply tried latest mainline kernel yet.
This is a production server and I need to schedule that; that will
obviously happen very soon if data corruption is suspected or if
this is a known fixed issue.

Thanks!
Andy

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

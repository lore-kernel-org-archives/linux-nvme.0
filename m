Return-Path: <SRS0=M8F8=XG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41040C49ED6
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Sep 2019 16:26:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FBAC2085B
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Sep 2019 16:26:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UHhrMqOD";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ly1LSre/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FBAC2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=HPwW+SYV5JYIZrnSOH2chxZBI0kr++Zbd4qZeHpG+UY=; b=UHhrMqOD+s2PK+
	aRd0C+5kPl9PqixreP8y6XeYadfAVQ5hTauncOwixNJlorsMJSIHyqKg7SZvgnD+D5dBfCx+zUKm0
	zgBHQ9N6BA/nCI1Y55k6wq1QAukncVhvnglZCCnW1yJcuTSSCXuT0F3O5xsF//4fxuJSff4IY9vZh
	uf9KzNfv7Wl6n2IORDNj+AoFEjXO1nAbT0MsElvSA9+EdqXUaTnzl+WTEJE3suZTINgs15AeUkxHd
	n2Z7eR7HNTdZ3D8+2B9x/UX/oLd56wmAcoBUAEpEjLjW5BjeLhENdn8I+4As8hbVvZLcii+ZpDW5+
	Nv+gasSCHfA1PZ7oaUtg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1i85S9-0002Si-Hd; Wed, 11 Sep 2019 16:26:45 +0000
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1i85S7-0002S1-16
 for linux-nvme@lists.infradead.org; Wed, 11 Sep 2019 16:26:44 +0000
Received: by mail-lf1-x142.google.com with SMTP id r22so5666518lfm.1
 for <linux-nvme@lists.infradead.org>; Wed, 11 Sep 2019 09:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=EAOxKqAsGB+Fl+XXS3RbKMSzJKNFkD9EiRqNq0C3Cpc=;
 b=ly1LSre/R2XJP16HeApPdALWlxvwry9mocmMqgRn+gzjv1mqZpEpMJ114s915QbIDu
 6yCRaQXDPD3xu+/zlAVpf1m3nA/+iXr4n3w3yRWqP8hsLrmNoFshKncjViBOnX7ndAF5
 EzkpYbi0hkx+C/FHI5rqGBnFEnL+hWDVvHve89970qjTjMWkF0WJj7zPeIDEUueRLl3k
 gZiRDDPH3zbSEOZJFh6PPT1IOPg0ae12He23s6LE9e6SKsDdpr2Mpw6LrbXFemjz8OI5
 /OqRiPwSlkTCpKUVczBEbqDGtim1iPNU0A+diRJsXu2tbXSz8gXVfqOD/Wo6BYqaBOi/
 Weeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=EAOxKqAsGB+Fl+XXS3RbKMSzJKNFkD9EiRqNq0C3Cpc=;
 b=FeL21Mc+zi38t7NaSK1rqkVEJUgmgSgxtNpxc6zkXqvdBQDgIBdyA5xcVeB+s0Lair
 K+fUT3D+UWFr5HrBdFTXZ1giLc9mvpAsISrbfEWAjSBqlWtQYGIyo/EUgRWxQnkJB/pT
 GOZTjtkCHCFzjqvY1G9mmHqZI8oTFnz2hiMLQ41n+SlQRqG/GUORU0DMU5lNcMUY61Qc
 iaT4rrAB1iELq8uScpsrUN40d+dH8pDhV+1v5xmQJluQD3z1FTILIZnMqGDDgQeTSweo
 9Bt6YGTxafP8V4YMOyIaEFM8+knT45UUGgHcOg2xUpCAXnDj597rSz3xzBPCf27Jx4Bx
 xL0A==
X-Gm-Message-State: APjAAAXjsCSkvn8B9oOG0YS4OGJ/LzSz3MOmubN0tVqMUJhHTDrLwYse
 NqE7/tU9XGtHwN881++ET68/orU609bIRoeimg==
X-Google-Smtp-Source: APXvYqyQdG27qGXzmZMAB3uXRQxDXaVHkCS9lJljH6i3wU4Ic/J9vhiGnoF2W+UyXI1YQ7DF4d94d9WLPZvXU0GWf64=
X-Received: by 2002:ac2:5203:: with SMTP id a3mr1393961lfl.151.1568219201336; 
 Wed, 11 Sep 2019 09:26:41 -0700 (PDT)
MIME-Version: 1.0
From: Gabriel C <nix.or.die@gmail.com>
Date: Wed, 11 Sep 2019 18:26:15 +0200
Message-ID: <CAEJqkggcnW98Sk3BEBCCZf57Uwd9rdqD5Da0tmuTaNfkJN5kVg@mail.gmail.com>
Subject: nvme vs. hibernation ( again )
To: LKML <linux-kernel@vger.kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190911_092643_096509_4658F4F1 
X-CRM114-Status: UNSURE (   9.37  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi Christoph,

I see this was already discussed in 2 threads:

 https://lists.infradead.org/pipermail/linux-nvme/2019-April/023234.html
 https://lkml.org/lkml/2019/5/24/668

but in latest git the issue still exists.

I hit that on each resume on my Acer Nitro 5 (AN515-43-R8BF) Laptop.

.....
Sep 11 16:16:30 nitro5 kernel: Freezing remaining freezable tasks ...
(elapsed 0.000 seconds) done.
Sep 11 16:16:30 nitro5 kernel: printk: Suspending console(s) (use
no_console_suspend to debug)
Sep 11 16:16:30 nitro5 kernel: WARNING: CPU: 0 PID: 882 at
kernel/irq/chip.c:210 irq_startup+0xe6/0xf0
Sep 11 16:16:30 nitro5 kernel: Modules linked in: af_packet bnep
amdgpu ath10k_pci ath10k_core ath mac80211 joydev uvcvideo
videobuf2_vmalloc videobuf2_memops edac_mce_amd videobuf2_v4l2
amd_iommu_v2 kvm_amd gpu_sched btusb snd_hda_codec_realtek ttm btrtl
btbcm btintel hid_multitouch ccp snd_hda_codec_generic nls_utf8
bluetooth drm_kms_helper hid_generic videobuf2_common ledtrig_audio
snd_hda_codec_hdmi nls_cp437 cfg80211 drm kvm snd_hda_intel vfat
videodev fat agpgart efi_pstore r8169 snd_hda_codec ecdh_generic
i2c_algo_bit realtek irqbypass pcspkr mc rfkill fb_sys_fops efivars
syscopyarea snd_hda_core ecc k10temp wmi_bmof sysfillrect tpm_crb
crc16 libphy i2c_piix4 libarc4 snd_hwdep hwmon sysimgblt tpm_tis
tpm_tis_core evdev ac tpm battery mac_hid i2c_designware_platform
pinctrl_amd i2c_designware_core rng_core acer_wireless button
acpi_cpufreq ppdev sch_fq_codel fuse snd_pcm_oss snd_mixer_oss snd_pcm
snd_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq snd_seq_device
snd_timer snd soundcore lp parport_pc
Sep 11 16:16:30 nitro5 kernel:  parport xfs libcrc32c crc32c_generic
crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel ahci
libahci libata xhci_pci xhci_hcd aesni_intel usbcore scsi_mod
aes_x86_64 crypto_simd cryptd glue_helper serio_raw i2c_hid hid video
i2c_core wmi dm_mirror dm_region_hash dm_log dm_mod unix sha1_ssse3
sha1_generic hmac ipv6 nf_defrag_ipv6 autofs4
Sep 11 16:16:30 nitro5 kernel: CPU: 0 PID: 882 Comm: kworker/u32:9 Not
tainted 5.3.0-rc8-00007-g3120b9a6a3f7-dirty #2
Sep 11 16:16:30 nitro5 kernel: Hardware name: Acer Nitro
AN515-43/Octavia_PKS, BIOS V1.05 08/07/2019
Sep 11 16:16:30 nitro5 kernel: Workqueue: events_unbound async_run_entry_fn
Sep 11 16:16:30 nitro5 kernel: RIP: 0010:irq_startup+0xe6/0xf0
Sep 11 16:16:30 nitro5 kernel: Code: e8 7f 3c 00 00 85 c0 0f 85 e3 09
00 00 4c 89 e7 31 d2 4c 89 ee e8 1a cf ff ff 48 89 ef e8 b2 fe ff ff
41 89 c4 e9 51 ff ff ff <0f> 0b eb b2 66 0f 1f 44 00 00 0f 1f 44 00 00
55 48 89 fd 53 48 8b
Sep 11 16:16:30 nitro5 kernel: RSP: 0018:ffffbe9b00793c38 EFLAGS: 00010002
Sep 11 16:16:30 nitro5 kernel: RAX: 0000000000000010 RBX:
0000000000000001 RCX: 0000000000000040
Sep 11 16:16:30 nitro5 kernel: RDX: 0000000000000000 RSI:
ffffffff9d1b8800 RDI: ffff9c9d9e136598
Sep 11 16:16:30 nitro5 kernel: RBP: ffff9c9d981e5400 R08:
0000000000000000 R09: ffff9c9d9e8003f0
Sep 11 16:16:30 nitro5 kernel: R10: 0000000000000000 R11:
ffffffff9d057688 R12: 0000000000000001
Sep 11 16:16:30 nitro5 kernel: R13: ffff9c9d9e136598 R14:
0000000000000000 R15: ffff9c9d9e346000
Sep 11 16:16:30 nitro5 kernel: FS:  0000000000000000(0000)
GS:ffff9c9da0800000(0000) knlGS:0000000000000000
Sep 11 16:16:30 nitro5 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Sep 11 16:16:30 nitro5 kernel: CR2: 00005633ad8d0060 CR3:
00000003db8d0000 CR4: 00000000003406f0
Sep 11 16:16:30 nitro5 kernel: Call Trace:
Sep 11 16:16:30 nitro5 kernel:  enable_irq+0x48/0x90
Sep 11 16:16:30 nitro5 kernel:  nvme_poll_irqdisable+0x20c/0x280
Sep 11 16:16:30 nitro5 kernel:  __nvme_disable_io_queues+0x19d/0x1d0
Sep 11 16:16:30 nitro5 kernel:  ? nvme_del_queue_end+0x20/0x20
Sep 11 16:16:30 nitro5 kernel:  nvme_dev_disable+0x15c/0x210
Sep 11 16:16:30 nitro5 kernel:  nvme_suspend+0x40/0x130
Sep 11 16:16:30 nitro5 kernel:  pci_pm_suspend+0x72/0x130
Sep 11 16:16:30 nitro5 kernel:  ? pci_pm_freeze+0xb0/0xb0
Sep 11 16:16:30 nitro5 kernel:  dpm_run_callback+0x29/0x120
Sep 11 16:16:30 nitro5 kernel:  __device_suspend+0x1b2/0x400
Sep 11 16:16:30 nitro5 kernel:  async_suspend+0x1b/0x90
Sep 11 16:16:30 nitro5 kernel:  async_run_entry_fn+0x37/0xe0
Sep 11 16:16:30 nitro5 kernel:  process_one_work+0x1d1/0x3a0
Sep 11 16:16:30 nitro5 kernel:  worker_thread+0x4a/0x3d0
Sep 11 16:16:30 nitro5 kernel:  kthread+0xf9/0x130
Sep 11 16:16:30 nitro5 kernel:  ? process_one_work+0x3a0/0x3a0
Sep 11 16:16:30 nitro5 kernel:  ? kthread_park+0x80/0x80
Sep 11 16:16:30 nitro5 kernel:  ret_from_fork+0x22/0x40
Sep 11 16:16:30 nitro5 kernel: ---[ end trace c598a86b44574730 ]---

...

The patch from Dongli Zhang was rejected the time without any other fix
or work on this issue I could find.

Are there any plans to fix that or any code to test?

Best Regards,

Gabriel C

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

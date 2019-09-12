Return-Path: <SRS0=lXTb=XH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 110C1C5ACAE
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Sep 2019 09:25:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7E512084F
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Sep 2019 09:25:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="D8wJJ9lt";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DBbJsAAZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7E512084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cjZLwD/4l+TWpBlhj1IfIxA1Xgl124rjVeQGxWV3ac4=; b=D8wJJ9ltz9/rDO
	3BqzbNamwJAZxLQdNeEN4w5A0hHgELUqCu2jEgL5cpDMDQBvX4xCVesdWl/HXqwYcjIKjkkt9b9W5
	oZoEZGuRf+coaF19Es0Lo0blDKVtBPglJgKekdTSautWmh9clawBb7H9P2EG2XT38dfjVd6c5plca
	yu6fk9E3oJjXn3Jhm54vZV1n+EZ3CLVLdCsHB/7gN+INHNtSJqHoIiGzabjNvnfG8sLuhF9mPascE
	lh7lDeB3F9OzdkPcKR8nVanuMcA8FC9MZCEHWlNc/rqqmATsKEStBKH6Sff44jRlY8/YsC/KjSlPq
	iIUAb5fFklUyEWP/SeoQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1i8LLU-0003lv-Gx; Thu, 12 Sep 2019 09:24:56 +0000
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1i8LLP-0003lB-Oo
 for linux-nvme@lists.infradead.org; Thu, 12 Sep 2019 09:24:53 +0000
Received: by mail-lf1-x143.google.com with SMTP id r134so18721209lff.12
 for <linux-nvme@lists.infradead.org>; Thu, 12 Sep 2019 02:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=yHQnV9O9yrLOCUG3Vr898tC1TxZ1cDR4UaNF7upy7JA=;
 b=DBbJsAAZDVIjUKR7ohKRWrSZsn/K7qLiMHwWz+bc7dLhhWl5NypE8lYkowVBHrJj+Q
 k12L3KMFQdCH/aDsivkH0oqDvm/sy1uHlTAnO5QPZlBNtsd1UF2e0bhWN5d/kZyzlka+
 2EKab7J3W/4r54nB+6gXksXBufzoeDfDchCOBO5m6+G3LTWjoYXby+BTbt7FUc8eCTs+
 dBygoYZzj0HfFPMdiQGhO68B7fNNDqy3Wkcfi+zRCm941BZEQwYfgKdcOMW8ROspD/cP
 1hV2Ji1a6jh5/m/IWcXr0Sy7ndMfvqG88+NqsPhMixncSmxskJZV+jnG3HidWHwRpDWR
 +JuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yHQnV9O9yrLOCUG3Vr898tC1TxZ1cDR4UaNF7upy7JA=;
 b=pp9y09uMrkXjrcbyuEyaer53d9Lrl4P+YgQqzhvPUuBUvLFe/HDphDfCVnbmhRNnfs
 EdfNtCCtoMWF+KVAyAh+mD9kYt1cj01yCzqcMxzOtZTyuMczvf1QAVxdTcq2ke/V0KBa
 akcn4in2ANw0l6COipbfpq7+eqaOPZTLTCHvT9Pn1pjzdYL6a39H3twIxgxqw3Wx/KGm
 Rl5W0sX3MNAQRTFOlGowQa3lBR328nYL8s8vtGX8IjNfzKxn8ZtsCmChdWTJadD7G5hK
 H5Tj3/77R0Bt8tdKaN+8D6yOllXywjFhhD2BYvktX5VS1QiJliRku+yJKlCxiKYWIovC
 f8DQ==
X-Gm-Message-State: APjAAAW2U3gtSxkrN/ULlxrBqXzNlJpoEbGC0dbOWffHo6ydPofO9/rd
 Z4iR/0BPjaHSqvN0laqP+enq/WP6gkrKBDJ52Q==
X-Google-Smtp-Source: APXvYqw8LV6WBXXCSed18FikGz+Bsc7kDpDCooXPCBOam9zJuGc0Z3FaOdxPALOOIR5UbsS0/3YFWdKWcCh9vADW1s4=
X-Received: by 2002:a19:2c1:: with SMTP id 184mr27057695lfc.100.1568280289888; 
 Thu, 12 Sep 2019 02:24:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAEJqkggcnW98Sk3BEBCCZf57Uwd9rdqD5Da0tmuTaNfkJN5kVg@mail.gmail.com>
 <CACVXFVNiRX+K8toexRfykazVnpC1sNYj2UbUtnqNeqkqUfs8TA@mail.gmail.com>
In-Reply-To: <CACVXFVNiRX+K8toexRfykazVnpC1sNYj2UbUtnqNeqkqUfs8TA@mail.gmail.com>
From: Gabriel C <nix.or.die@gmail.com>
Date: Thu, 12 Sep 2019 11:24:23 +0200
Message-ID: <CAEJqkgii81G8_=ddVb92TFAcsr5LCEOi08aBfQ2RAu2UPAYpwg@mail.gmail.com>
Subject: Re: nvme vs. hibernation ( again )
To: Ming Lei <tom.leiming@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190912_022451_832691_D9696805 
X-CRM114-Status: GOOD (  15.77  )
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
Cc: LKML <linux-kernel@vger.kernel.org>,
 linux-nvme <linux-nvme@lists.infradead.org>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Am Do., 12. Sept. 2019 um 02:51 Uhr schrieb Ming Lei <tom.leiming@gmail.com>:
>
> On Thu, Sep 12, 2019 at 12:27 AM Gabriel C <nix.or.die@gmail.com> wrote:
> >
> > Hi Christoph,
> >
> > I see this was already discussed in 2 threads:
> >
> >  https://lists.infradead.org/pipermail/linux-nvme/2019-April/023234.html
> >  https://lkml.org/lkml/2019/5/24/668
> >
> > but in latest git the issue still exists.
> >
> > I hit that on each resume on my Acer Nitro 5 (AN515-43-R8BF) Laptop.
> >
> > .....
> > Sep 11 16:16:30 nitro5 kernel: Freezing remaining freezable tasks ...
> > (elapsed 0.000 seconds) done.
> > Sep 11 16:16:30 nitro5 kernel: printk: Suspending console(s) (use
> > no_console_suspend to debug)
> > Sep 11 16:16:30 nitro5 kernel: WARNING: CPU: 0 PID: 882 at
> > kernel/irq/chip.c:210 irq_startup+0xe6/0xf0
> > Sep 11 16:16:30 nitro5 kernel: Modules linked in: af_packet bnep
> > amdgpu ath10k_pci ath10k_core ath mac80211 joydev uvcvideo
> > videobuf2_vmalloc videobuf2_memops edac_mce_amd videobuf2_v4l2
> > amd_iommu_v2 kvm_amd gpu_sched btusb snd_hda_codec_realtek ttm btrtl
> > btbcm btintel hid_multitouch ccp snd_hda_codec_generic nls_utf8
> > bluetooth drm_kms_helper hid_generic videobuf2_common ledtrig_audio
> > snd_hda_codec_hdmi nls_cp437 cfg80211 drm kvm snd_hda_intel vfat
> > videodev fat agpgart efi_pstore r8169 snd_hda_codec ecdh_generic
> > i2c_algo_bit realtek irqbypass pcspkr mc rfkill fb_sys_fops efivars
> > syscopyarea snd_hda_core ecc k10temp wmi_bmof sysfillrect tpm_crb
> > crc16 libphy i2c_piix4 libarc4 snd_hwdep hwmon sysimgblt tpm_tis
> > tpm_tis_core evdev ac tpm battery mac_hid i2c_designware_platform
> > pinctrl_amd i2c_designware_core rng_core acer_wireless button
> > acpi_cpufreq ppdev sch_fq_codel fuse snd_pcm_oss snd_mixer_oss snd_pcm
> > snd_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq snd_seq_device
> > snd_timer snd soundcore lp parport_pc
> > Sep 11 16:16:30 nitro5 kernel:  parport xfs libcrc32c crc32c_generic
> > crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel ahci
> > libahci libata xhci_pci xhci_hcd aesni_intel usbcore scsi_mod
> > aes_x86_64 crypto_simd cryptd glue_helper serio_raw i2c_hid hid video
> > i2c_core wmi dm_mirror dm_region_hash dm_log dm_mod unix sha1_ssse3
> > sha1_generic hmac ipv6 nf_defrag_ipv6 autofs4
> > Sep 11 16:16:30 nitro5 kernel: CPU: 0 PID: 882 Comm: kworker/u32:9 Not
> > tainted 5.3.0-rc8-00007-g3120b9a6a3f7-dirty #2
> > Sep 11 16:16:30 nitro5 kernel: Hardware name: Acer Nitro
> > AN515-43/Octavia_PKS, BIOS V1.05 08/07/2019
> > Sep 11 16:16:30 nitro5 kernel: Workqueue: events_unbound async_run_entry_fn
> > Sep 11 16:16:30 nitro5 kernel: RIP: 0010:irq_startup+0xe6/0xf0
> > Sep 11 16:16:30 nitro5 kernel: Code: e8 7f 3c 00 00 85 c0 0f 85 e3 09
> > 00 00 4c 89 e7 31 d2 4c 89 ee e8 1a cf ff ff 48 89 ef e8 b2 fe ff ff
> > 41 89 c4 e9 51 ff ff ff <0f> 0b eb b2 66 0f 1f 44 00 00 0f 1f 44 00 00
> > 55 48 89 fd 53 48 8b
> > Sep 11 16:16:30 nitro5 kernel: RSP: 0018:ffffbe9b00793c38 EFLAGS: 00010002
> > Sep 11 16:16:30 nitro5 kernel: RAX: 0000000000000010 RBX:
> > 0000000000000001 RCX: 0000000000000040
> > Sep 11 16:16:30 nitro5 kernel: RDX: 0000000000000000 RSI:
> > ffffffff9d1b8800 RDI: ffff9c9d9e136598
> > Sep 11 16:16:30 nitro5 kernel: RBP: ffff9c9d981e5400 R08:
> > 0000000000000000 R09: ffff9c9d9e8003f0
> > Sep 11 16:16:30 nitro5 kernel: R10: 0000000000000000 R11:
> > ffffffff9d057688 R12: 0000000000000001
> > Sep 11 16:16:30 nitro5 kernel: R13: ffff9c9d9e136598 R14:
> > 0000000000000000 R15: ffff9c9d9e346000
> > Sep 11 16:16:30 nitro5 kernel: FS:  0000000000000000(0000)
> > GS:ffff9c9da0800000(0000) knlGS:0000000000000000
> > Sep 11 16:16:30 nitro5 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > Sep 11 16:16:30 nitro5 kernel: CR2: 00005633ad8d0060 CR3:
> > 00000003db8d0000 CR4: 00000000003406f0
> > Sep 11 16:16:30 nitro5 kernel: Call Trace:
> > Sep 11 16:16:30 nitro5 kernel:  enable_irq+0x48/0x90
> > Sep 11 16:16:30 nitro5 kernel:  nvme_poll_irqdisable+0x20c/0x280
> > Sep 11 16:16:30 nitro5 kernel:  __nvme_disable_io_queues+0x19d/0x1d0
> > Sep 11 16:16:30 nitro5 kernel:  ? nvme_del_queue_end+0x20/0x20
> > Sep 11 16:16:30 nitro5 kernel:  nvme_dev_disable+0x15c/0x210
> > Sep 11 16:16:30 nitro5 kernel:  nvme_suspend+0x40/0x130
> > Sep 11 16:16:30 nitro5 kernel:  pci_pm_suspend+0x72/0x130
> > Sep 11 16:16:30 nitro5 kernel:  ? pci_pm_freeze+0xb0/0xb0
> > Sep 11 16:16:30 nitro5 kernel:  dpm_run_callback+0x29/0x120
> > Sep 11 16:16:30 nitro5 kernel:  __device_suspend+0x1b2/0x400
> > Sep 11 16:16:30 nitro5 kernel:  async_suspend+0x1b/0x90
> > Sep 11 16:16:30 nitro5 kernel:  async_run_entry_fn+0x37/0xe0
> > Sep 11 16:16:30 nitro5 kernel:  process_one_work+0x1d1/0x3a0
> > Sep 11 16:16:30 nitro5 kernel:  worker_thread+0x4a/0x3d0
> > Sep 11 16:16:30 nitro5 kernel:  kthread+0xf9/0x130
> > Sep 11 16:16:30 nitro5 kernel:  ? process_one_work+0x3a0/0x3a0
> > Sep 11 16:16:30 nitro5 kernel:  ? kthread_park+0x80/0x80
> > Sep 11 16:16:30 nitro5 kernel:  ret_from_fork+0x22/0x40
> > Sep 11 16:16:30 nitro5 kernel: ---[ end trace c598a86b44574730 ]---
> >
> > ...
> >
> > The patch from Dongli Zhang was rejected the time without any other fix
> > or work on this issue I could find.
> >
> > Are there any plans to fix that or any code to test?
>
> I guess the following patchset may address it:
>
> https://lore.kernel.org/linux-block/20190812134312.16732-1-ming.lei@redhat.com/
>

Thx Ming Lei.

Can you tell me on what branch/tree they are based on?

Best Regards,

Gabriel C

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

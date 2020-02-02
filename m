Return-Path: <SRS0=8G+d=3W=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE24C35249
	for <linux-nvme@archiver.kernel.org>; Sun,  2 Feb 2020 23:32:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C93D20661
	for <linux-nvme@archiver.kernel.org>; Sun,  2 Feb 2020 23:32:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="P7zC9W/r";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ARcFnXLx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C93D20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yKosK3HAtBVYgzG+D+7RWPIxapYPZbd6RhLCfrLly3Y=; b=P7zC9W/r2Fhdqx
	POsdumv0w3R7TYyN3cBkqs+IzZrb9TlTidIv8mbPNovbnW9E3WfNDDzYPlSjDxECo7MlBwk/B3jMq
	Yr/sWlNDu9r2ZpuPDJsNVh5NEsaeOrr+XT0ZR8h4PzKvyAvVCrS6hBudB8wO8/C1weMKyRwJx/BKo
	Y1ytaEiTm4S8I5QpkGCboR1LFK3H0bBQWSJ0EoLw/Axve/y351KYWCiOh5pO4au/YCJTUC8Z1+I19
	lByn7kalO0AdsRDHraT1KrMMpK9Fm8sgBQoWR28ot3Hvi/jlPxaMevMn1VBVrZ1He+xo51z0hYNUd
	5STmtyldZlFr1shCIAdQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iyOjG-0008BO-Tm; Sun, 02 Feb 2020 23:32:38 +0000
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iyOj9-0008Af-C0
 for linux-nvme@lists.infradead.org; Sun, 02 Feb 2020 23:32:33 +0000
Received: by mail-qt1-x842.google.com with SMTP id d18so10066778qtj.10
 for <linux-nvme@lists.infradead.org>; Sun, 02 Feb 2020 15:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=efXK3J565NtS6vWhyXK7nP9j0w0XFM8tl1K3kDiivUQ=;
 b=ARcFnXLxnDt1zy1I/C5WdycrcGHIoG9nNOFifm/bluveSciO2+YiqFcxzFpx14HXp8
 XB7ZObdsfjjQGBI92wB2Xi1nmO2uxkX5TGUtRYX+NA2OYUaWScQ6SMEaxIhyRJwyog7K
 lUMVhm/rLbVmMWSq/5KYq+uk7WjcnOJYKD/AwmHYHbpokEVcKYEFymm9gghkVNbLrQrN
 qbMz0uvsG99NGlwCEPpxFTLlH7vP3AXbXvSGSomLebhLUf6xD2V3qruHZcGGCSlMzucR
 tWJu8a3X8jpR+F3S7cz/ceoBfZl9twt6jYGAEIlZJdcqoWilpi7OGvFefe2x8CryOPLk
 pMZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=efXK3J565NtS6vWhyXK7nP9j0w0XFM8tl1K3kDiivUQ=;
 b=dAbwHgInRK+q5km8MgJEVTFzjUPum14Svh8axwvAeIZO954h3IuvbJnYm2rcZwut7a
 +fCLd5znotgX7NUCCNqpCMeX+vy+AwYhDL2W4KTXBVnxiDiT9tasLy/XK77j5W134Roy
 t910Le4t4kLKm+E96adZhgrBud4Q4CRzOYMmJAltzdXJ/Zi8nxiBjegnLt/YDaznCiXU
 HX3MjvPm782FKXE5Z3FNpPMIT/YsWdDw6MrWSFgo+kJA+HiVVjyfjY4FqdFIeOUhE6Tq
 zQtf8dwTD1p5mESBqP2tpNF4x6OviQ3neC2uyuOBVJfnbzHfNTHPcKJf48e4+/zXA/7C
 1hoA==
X-Gm-Message-State: APjAAAUB9VD+r+2jT2VvjkKquuq3Zty9w8hAT2aQBJ4hpCFvuEyXGNy0
 tG6rS5+u4qFEN4bQw70L0vwjmU59lZ5s6J65CSE=
X-Google-Smtp-Source: APXvYqxFRTD4YvfM9i6/lGV+T7dgC4uDYhTAyhhoex+rvP2Gvr97DpCQPU8os9L/xEetCBgtB/lVl4UzGX33znc2XQs=
X-Received: by 2002:ac8:4e2c:: with SMTP id d12mr21680001qtw.219.1580686348484; 
 Sun, 02 Feb 2020 15:32:28 -0800 (PST)
MIME-Version: 1.0
References: <CAEJqkggcnW98Sk3BEBCCZf57Uwd9rdqD5Da0tmuTaNfkJN5kVg@mail.gmail.com>
 <CACVXFVNiRX+K8toexRfykazVnpC1sNYj2UbUtnqNeqkqUfs8TA@mail.gmail.com>
 <CAEJqkgii81G8_=ddVb92TFAcsr5LCEOi08aBfQ2RAu2UPAYpwg@mail.gmail.com>
 <20190917091806.GB15374@ming.t460p>
In-Reply-To: <20190917091806.GB15374@ming.t460p>
From: Dexuan-Linux Cui <dexuan.linux@gmail.com>
Date: Sun, 2 Feb 2020 15:32:17 -0800
Message-ID: <CAA42JLYMmHu7NV1L6CiacHtLS45NtCDa53VFji6Zj098B4z-gw@mail.gmail.com>
Subject: Re: nvme vs. hibernation ( again )
To: Ming Lei <ming.lei@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200202_153231_419482_7A890870 
X-CRM114-Status: GOOD (  26.33  )
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
Cc: Gabriel C <nix.or.die@gmail.com>, Ming Lei <tom.leiming@gmail.com>,
 Dexuan Cui <decui@microsoft.com>, LKML <linux-kernel@vger.kernel.org>,
 linux-nvme <linux-nvme@lists.infradead.org>, mikelley@microsoft.com,
 juhlee@microsoft.com, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Sep 17, 2019 at 2:58 AM Ming Lei <ming.lei@redhat.com> wrote:
>
> On Thu, Sep 12, 2019 at 11:24:23AM +0200, Gabriel C wrote:
> > Am Do., 12. Sept. 2019 um 02:51 Uhr schrieb Ming Lei <tom.leiming@gmail.com>:
> > >
> > > On Thu, Sep 12, 2019 at 12:27 AM Gabriel C <nix.or.die@gmail.com> wrote:
> > > >
> > > > Hi Christoph,
> > > >
> > > > I see this was already discussed in 2 threads:
> > > >
> > > >  https://lists.infradead.org/pipermail/linux-nvme/2019-April/023234.html
> > > >  https://lkml.org/lkml/2019/5/24/668
> > > >
> > > > but in latest git the issue still exists.
> > > >
> > > > I hit that on each resume on my Acer Nitro 5 (AN515-43-R8BF) Laptop.
> > > >
> > > > .....
> > > > Sep 11 16:16:30 nitro5 kernel: Freezing remaining freezable tasks ...
> > > > (elapsed 0.000 seconds) done.
> > > > Sep 11 16:16:30 nitro5 kernel: printk: Suspending console(s) (use
> > > > no_console_suspend to debug)
> > > > Sep 11 16:16:30 nitro5 kernel: WARNING: CPU: 0 PID: 882 at
> > > > kernel/irq/chip.c:210 irq_startup+0xe6/0xf0
> > > > Sep 11 16:16:30 nitro5 kernel: Modules linked in: af_packet bnep
> > > > amdgpu ath10k_pci ath10k_core ath mac80211 joydev uvcvideo
> > > > videobuf2_vmalloc videobuf2_memops edac_mce_amd videobuf2_v4l2
> > > > amd_iommu_v2 kvm_amd gpu_sched btusb snd_hda_codec_realtek ttm btrtl
> > > > btbcm btintel hid_multitouch ccp snd_hda_codec_generic nls_utf8
> > > > bluetooth drm_kms_helper hid_generic videobuf2_common ledtrig_audio
> > > > snd_hda_codec_hdmi nls_cp437 cfg80211 drm kvm snd_hda_intel vfat
> > > > videodev fat agpgart efi_pstore r8169 snd_hda_codec ecdh_generic
> > > > i2c_algo_bit realtek irqbypass pcspkr mc rfkill fb_sys_fops efivars
> > > > syscopyarea snd_hda_core ecc k10temp wmi_bmof sysfillrect tpm_crb
> > > > crc16 libphy i2c_piix4 libarc4 snd_hwdep hwmon sysimgblt tpm_tis
> > > > tpm_tis_core evdev ac tpm battery mac_hid i2c_designware_platform
> > > > pinctrl_amd i2c_designware_core rng_core acer_wireless button
> > > > acpi_cpufreq ppdev sch_fq_codel fuse snd_pcm_oss snd_mixer_oss snd_pcm
> > > > snd_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq snd_seq_device
> > > > snd_timer snd soundcore lp parport_pc
> > > > Sep 11 16:16:30 nitro5 kernel:  parport xfs libcrc32c crc32c_generic
> > > > crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel ahci
> > > > libahci libata xhci_pci xhci_hcd aesni_intel usbcore scsi_mod
> > > > aes_x86_64 crypto_simd cryptd glue_helper serio_raw i2c_hid hid video
> > > > i2c_core wmi dm_mirror dm_region_hash dm_log dm_mod unix sha1_ssse3
> > > > sha1_generic hmac ipv6 nf_defrag_ipv6 autofs4
> > > > Sep 11 16:16:30 nitro5 kernel: CPU: 0 PID: 882 Comm: kworker/u32:9 Not
> > > > tainted 5.3.0-rc8-00007-g3120b9a6a3f7-dirty #2
> > > > Sep 11 16:16:30 nitro5 kernel: Hardware name: Acer Nitro
> > > > AN515-43/Octavia_PKS, BIOS V1.05 08/07/2019
> > > > Sep 11 16:16:30 nitro5 kernel: Workqueue: events_unbound async_run_entry_fn
> > > > Sep 11 16:16:30 nitro5 kernel: RIP: 0010:irq_startup+0xe6/0xf0
> > > > Sep 11 16:16:30 nitro5 kernel: Code: e8 7f 3c 00 00 85 c0 0f 85 e3 09
> > > > 00 00 4c 89 e7 31 d2 4c 89 ee e8 1a cf ff ff 48 89 ef e8 b2 fe ff ff
> > > > 41 89 c4 e9 51 ff ff ff <0f> 0b eb b2 66 0f 1f 44 00 00 0f 1f 44 00 00
> > > > 55 48 89 fd 53 48 8b
> > > > Sep 11 16:16:30 nitro5 kernel: RSP: 0018:ffffbe9b00793c38 EFLAGS: 00010002
> > > > Sep 11 16:16:30 nitro5 kernel: RAX: 0000000000000010 RBX:
> > > > 0000000000000001 RCX: 0000000000000040
> > > > Sep 11 16:16:30 nitro5 kernel: RDX: 0000000000000000 RSI:
> > > > ffffffff9d1b8800 RDI: ffff9c9d9e136598
> > > > Sep 11 16:16:30 nitro5 kernel: RBP: ffff9c9d981e5400 R08:
> > > > 0000000000000000 R09: ffff9c9d9e8003f0
> > > > Sep 11 16:16:30 nitro5 kernel: R10: 0000000000000000 R11:
> > > > ffffffff9d057688 R12: 0000000000000001
> > > > Sep 11 16:16:30 nitro5 kernel: R13: ffff9c9d9e136598 R14:
> > > > 0000000000000000 R15: ffff9c9d9e346000
> > > > Sep 11 16:16:30 nitro5 kernel: FS:  0000000000000000(0000)
> > > > GS:ffff9c9da0800000(0000) knlGS:0000000000000000
> > > > Sep 11 16:16:30 nitro5 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > Sep 11 16:16:30 nitro5 kernel: CR2: 00005633ad8d0060 CR3:
> > > > 00000003db8d0000 CR4: 00000000003406f0
> > > > Sep 11 16:16:30 nitro5 kernel: Call Trace:
> > > > Sep 11 16:16:30 nitro5 kernel:  enable_irq+0x48/0x90
> > > > Sep 11 16:16:30 nitro5 kernel:  nvme_poll_irqdisable+0x20c/0x280
> > > > Sep 11 16:16:30 nitro5 kernel:  __nvme_disable_io_queues+0x19d/0x1d0
> > > > Sep 11 16:16:30 nitro5 kernel:  ? nvme_del_queue_end+0x20/0x20
> > > > Sep 11 16:16:30 nitro5 kernel:  nvme_dev_disable+0x15c/0x210
> > > > Sep 11 16:16:30 nitro5 kernel:  nvme_suspend+0x40/0x130
> > > > Sep 11 16:16:30 nitro5 kernel:  pci_pm_suspend+0x72/0x130
> > > > Sep 11 16:16:30 nitro5 kernel:  ? pci_pm_freeze+0xb0/0xb0
> > > > Sep 11 16:16:30 nitro5 kernel:  dpm_run_callback+0x29/0x120
> > > > Sep 11 16:16:30 nitro5 kernel:  __device_suspend+0x1b2/0x400
> > > > Sep 11 16:16:30 nitro5 kernel:  async_suspend+0x1b/0x90
> > > > Sep 11 16:16:30 nitro5 kernel:  async_run_entry_fn+0x37/0xe0
> > > > Sep 11 16:16:30 nitro5 kernel:  process_one_work+0x1d1/0x3a0
> > > > Sep 11 16:16:30 nitro5 kernel:  worker_thread+0x4a/0x3d0
> > > > Sep 11 16:16:30 nitro5 kernel:  kthread+0xf9/0x130
> > > > Sep 11 16:16:30 nitro5 kernel:  ? process_one_work+0x3a0/0x3a0
> > > > Sep 11 16:16:30 nitro5 kernel:  ? kthread_park+0x80/0x80
> > > > Sep 11 16:16:30 nitro5 kernel:  ret_from_fork+0x22/0x40
> > > > Sep 11 16:16:30 nitro5 kernel: ---[ end trace c598a86b44574730 ]---
> > > >
> > > > ...
> > > >
> > > > The patch from Dongli Zhang was rejected the time without any other fix
> > > > or work on this issue I could find.
> > > >
> > > > Are there any plans to fix that or any code to test?
> > >
> > > I guess the following patchset may address it:
> > >
> > > https://lore.kernel.org/linux-block/20190812134312.16732-1-ming.lei@redhat.com/
> > >
> >
> > Thx Ming Lei.
> >
> > Can you tell me on what branch/tree they are based on?
>
> The patchset can be applied cleanly on for-5.4/block.
>
> However, the warning can't be fixed, even though the issue and
> the patchset is closely related.
>
> The warning just means there isn't any online CPU in this managed IRQ's
> affinity. Once we can guarantee that there aren't any in-flight requests
> for dead hctx(no any online CPU in its affinity mask), the warning
> can be removed.
>
>
> thanks,
> Ming

Hi Ming,
I still see the call-trace with v5.5 (I passed through a NVMe
controller to a Linux VM running on Hyper-V and I'm testing VM
hibernation with some extra patches applied to the Hyper-V drivers).

It looks your Aug-2019 patchset
(https://lore.kernel.org/linux-block/20190812134312.16732-6-ming.lei@redhat.com/)
has not been accepted?

PS, this is the call-trace I'm seeing:

[  274.693172] PM: hibernation entry
[  274.718964] Filesystems sync: 0.022 seconds
[  274.718964] Freezing user space processes ... (elapsed 0.001 seconds) done.
[  274.720859] OOM killer disabled.
[  274.720873] PM: Marking nosave pages: [mem 0x00000000-0x00000fff]
[  274.720873] PM: Marking nosave pages: [mem 0x0009f000-0x000fffff]
[  274.720873] PM: Marking nosave pages: [mem 0x3fff0000-0xffffffff]
[  274.722536] PM: Marking nosave pages: [mem 0xfe0000000-0xfffffffff]
[  274.722539] PM: Basic memory bitmaps created
[  274.722539] PM: Preallocating image memory... done (allocated 837903 pages)
[  276.950530] PM: Allocated 3351612 kbytes in 2.22 seconds (1509.73 MB/s)
[  276.950530] Freezing remaining freezable tasks ... (elapsed 0.002
seconds) done.
[  276.956255] serial 00:04: disabled
[  277.014876] ------------[ cut here ]------------
[  277.014876] WARNING: CPU: 15 PID: 389 at kernel/irq/chip.c:210
irq_startup+0xe1/0xf0
[  277.014876] Modules linked in: ......
[  277.014876] CPU: 15 PID: 389 Comm: kworker/u258:2 Not tainted 5.5.0+ #1
[  277.014876] Hardware name: Microsoft Corporation Virtual
Machine/Virtual Machine, BIOS 090007  05/18/2018
[  277.014876] Workqueue: events_unbound async_run_entry_fn
[  277.014876] RIP: 0010:irq_startup+0xe1/0xf0
[  277.014876] Code: f6 4c 89 f7 e8 00 42 00 00 85 c0 75 21 4c 89 ee
31 d2 4c ......
[  277.014876] RSP: 0018:ffffb70e48043bc0 EFLAGS: 00010002
[  277.014876] RAX: 0000000000000080 RBX: ffff8e596e3a6c00 RCX: 0000000000000080
[  277.014876] RDX: 0000000000000000 RSI: ffffffff99c2b920 RDI: ffff8e599ad66d40
[  277.014876] RBP: ffffb70e48043be0 R08: 0000000000000000 R09: 0000000000000001
[  277.014876] R10: 0000000000000000 R11: ffffffff99a621a8 R12: 0000000000000001
[  277.014876] R13: ffff8e599ad66d40 R14: 0000000000000001 R15: ffff8e498b332000
[  277.014876] FS:  0000000000000000(0000) GS:ffff8e599efc0000(0000)
knlGS:0000000000000000
[  277.014876] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  277.014876] CR2: 000055eab6b36d80 CR3: 000000106e3b4000 CR4: 00000000003406e0
[  277.014876] Call Trace:
[  277.014877]  __enable_irq+0x52/0x60
[  277.014877]  enable_irq+0x4c/0x90
[  277.014877]  nvme_poll_irqdisable+0x376/0x380
[  277.014877]  ? wake_up_q+0xb0/0xb0
[  277.014877]  __nvme_disable_io_queues+0x1b5/0x200
[  277.014877]  ? nvme_del_queue_end+0x30/0x30
[  277.014877]  nvme_disable_io_queues+0x25/0x30
[  277.014877]  nvme_dev_disable+0x1b1/0x250
[  277.014877]  nvme_simple_suspend+0x2b/0x40
[  277.014877]  pci_pm_freeze+0x5c/0xd0
[  277.014877]  ? pci_pm_poweroff+0x100/0x100
[  277.014877]  dpm_run_callback+0x5a/0x170
[  277.014877]  __device_suspend+0x156/0x4f0
[  277.014877]  async_suspend+0x1f/0xa0
[  277.014877]  async_run_entry_fn+0x3c/0x150
[  277.014877]  process_one_work+0x1f7/0x3f0
[  277.014877]  worker_thread+0x34/0x400
[  277.014877]  kthread+0x121/0x140
[  277.014877]  ? process_one_work+0x3f0/0x3f0
[  277.014877]  ? kthread_park+0x90/0x90
[  277.014877]  ret_from_fork+0x22/0x40


Thanks,
Dexuan

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

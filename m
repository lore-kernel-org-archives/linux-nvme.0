Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E678C7EE25
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Jun 2023 11:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=c9DUToNqA5cOonn9Hc6jEEDYVPpV2MwNxZt+p+/Ax6w=; b=VkX8q3fi9qvu/P/7P86LaWLr7n
	fMn+w7649KPQPfSfIZbGCQQUgLWdLR5mjA4b5kUNcbSxTKwy1fIaH4f4UC3YNayPDkS8JM4A83BZ3
	Gy2fjMoQaDQoqKlbsRpWwEuZF1oAIGz9IPe1eiTK/KXJCkjcxc3Plg0mgKHZow29CunYKhvv4HIS7
	qT/gLG0bxR65RRv77yUIzcHRJAjLlFvzC/9a7snEQFYEV0gFQGs+q19FOHII2sPAmTjqHwEp9wX7y
	sb+jaXMHp8ogdHVbIaxUFT65Uhhrc6R98XVxsUNmNMzKWrVwrMHgMtpp9vYmGQOPwXppQs6+femWJ
	yUupxt/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q8fcf-003kYB-1i;
	Mon, 12 Jun 2023 11:22:09 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q8fcb-003kXD-2j
	for linux-nvme@lists.infradead.org;
	Mon, 12 Jun 2023 11:22:07 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E24AE2019C;
	Mon, 12 Jun 2023 11:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1686568922; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c9DUToNqA5cOonn9Hc6jEEDYVPpV2MwNxZt+p+/Ax6w=;
	b=tMG1/7jZZwUKG+D//4j4U4+9KeFvzglRXt+9ge/w41DjW9jKkp2B5YOux7A6l+xal4WSqG
	IDq2bxmDi13hvlqiyDtHTR5d73J18cPrYxyud6LvOx1UZaJd/ttzYga7tcRfn5sUlgYl/q
	IT75zt7IlU3RbnJ1yC1fwxuEsthZp4w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1686568922;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c9DUToNqA5cOonn9Hc6jEEDYVPpV2MwNxZt+p+/Ax6w=;
	b=Ol1nrwBMJCNDFfjgJ+Wm67kM1w55qWa5ao/CkHmUcrOay7jxNJhPlevpdxAouSSoUr3xtN
	G1yT1A7k0k5m6ZCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D4822138EC;
	Mon, 12 Jun 2023 11:22:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id cSTbM9r/hmRuRAAAMHmgww
	(envelope-from <dwagner@suse.de>); Mon, 12 Jun 2023 11:22:02 +0000
Date: Mon, 12 Jun 2023 13:22:02 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: module-autoload: duplicate request for module nvme-tcp
Message-ID: <dexdhjpxglogizzxg5nrydgz357oyriwi5x2igale7iaf2xsjn@haw6w2qrtbpd>
References: <tom6xspqarrxx6c5ilqu7c7nhysgt3ua26yu52l2zaj7mr2qlp@vqr7y355ohzf>
 <ZH/R3pl+8kY7MefU@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ZH/R3pl+8kY7MefU@bombadil.infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230612_042206_051408_646D8B56 
X-CRM114-Status: GOOD (  25.91  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi Luis,

On Tue, Jun 06, 2023 at 05:39:58PM -0700, Luis Chamberlain wrote:
 >  ------------[ cut here ]------------
> >  module-autoload: duplicate request for module nvme-tcp
> >  WARNING: CPU: 2 PID: 1725 at kernel/module/dups.c:185 kmod_dup_request=
_exists_wait+0x2bd/0x520
> >  Modules linked in: loop nvmet_tcp nvmet nvme_tcp nvme_fabrics nfsv3 nf=
s_acl rpcsec_gss_krb5 auth_rpcgss nfsv4 dns_resolver nfs lockd grace sunrpc=
 fscache netfs af_packet rfkill qrtr snd_hda_codec_generic intel_rapl_msr i=
ntel_rapl_common intel_pmc_core kvm_intel nls_iso8859_1 nls_cp437 vfat snd_=
hda_intel snd_intel_dspcfg fat snd_hda_codec kvm snd_hwdep iTCO_wdt intel_p=
mc_bxt snd_hda_core iTCO_vendor_support snd_pcm i2c_i801 irqbypass i2c_smbu=
s pcspkr snd_timer virtio_net snd virtio_balloon soundcore lpc_ich net_fail=
over failover tiny_power_button joydev button fuse efi_pstore configfs ip_t=
ables x_tables hid_generic usbhid crct10dif_pclmul crc32_pclmul ghash_clmul=
ni_intel xhci_pci xhci_pci_renesas xhci_hcd sr_mod aesni_intel cdrom crypto=
_simd cryptd virtio_blk virtio_rng usbcore nvme virtio_gpu virtio_dma_buf n=
vme_core nvme_common serio_raw btrfs libcrc32c crc32c_intel xor zlib_deflat=
e raid6_pq sg dm_multipath dm_mod scsi_dh_rdac scsi_dh_emc scsi_dh_alua efi=
varfs qemu_fw_cfg [last unloaded: loop]
> >  CPU: 2 PID: 1725 Comm: nvme Tainted: G        W          6.4.0-rc2+ #2=
 1daf2dc6ddfbfdba6b9ddd3bcf1253da050c6a9f
> >  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS unknown unkno=
wn
> >  RIP: 0010:kmod_dup_request_exists_wait+0x2bd/0x520
> >  Code: a4 e8 77 6f 28 02 4c 89 ff e8 3f 58 4c 00 80 3d 68 6d b5 03 00 0=
f 84 24 01 00 00 48 c7 c7 80 60 70 a3 48 89 de e8 03 5e d9 ff <0f> 0b 40 84=
 ed 0f 84 22 01 00 00 49 8d 7c 24 48 be 02 01 00 00 e8
> >  RSP: 0018:ffff8881086ff720 EFLAGS: 00010246
> >  RAX: 2c07e0659ca46000 RBX: ffff8881086ff820 RCX: 0000000000000027
> >  RDX: 0000000000000001 RSI: 0000000000000004 RDI: ffff88815abf07c8
> >  RBP: 0000000000000001 R08: dffffc0000000000 R09: ffffed102b57e0fa
> >  R10: 0000000000000000 R11: dffffc0000000001 R12: ffff888108fa8400
> >  R13: 0000000fffffffe0 R14: dffffc0000000000 R15: ffff88810af38c00
> >  FS:  00007fb64187e740(0000) GS:ffff88815aa00000(0000) knlGS:0000000000=
000000
> >  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >  CR2: 00007fb6419db28e CR3: 0000000130390005 CR4: 0000000000370ee0
> >  Call Trace:
> >   <TASK>
> >   __request_module+0x1ce/0x4e0
> >   ? trace_contention_end+0x38/0xf0
> >   ? kasan_unpoison+0x64/0x90
> >   ? __cfi___request_module+0x10/0x10
> >   ? __mutex_unlock_slowpath+0x21f/0x770
> >   ? kasan_quarantine_put+0xb4/0x1c0
> >   ? __kmem_cache_free+0x21f/0x3d0
> >   ? __asan_memcpy+0x3c/0x70
> >   ? nvmf_dev_write+0x1956/0x2430 [nvme_fabrics 08f7b8c3317d458ea9e1722c=
19d051cbfd8a49c3]
> >   nvmf_dev_write+0x1a2c/0x2430 [nvme_fabrics 08f7b8c3317d458ea9e1722c19=
d051cbfd8a49c3]
>=20
> nvmf_dev_write() seems to implicate a request_module() call, try to
> answer this question: how many times do you want to be calling
> request_module() for something ?

In nvmf_create_ctrl() we always call undconditionally

	request_module("nvme-%s", opts->transport)

> The warning comes up to tell developers they should try to see if they
> can instead just issue a request *once*. A simple bool would do it.

Sure, but that means the caller starts to track the 'livetime' of a module,=
 no?
Isn't this something we should do in a central place? Having

	if (!module_loaded)
		request_module()

sprinkled everywhere seems a bit silly, but I might just miss something in =
this
discussion. BTW, is there a specific reason there is no way to ask if
module is loaded (looking at kmod.h)?

> Why is this good? Well prior to me convincing folks that this could
> incur high virtual memory allocations I didn't have proof such abuse
> existed. My patch showed the abuse came not from kernel request_module()
> users but instead for userspace through udev.

I see.

> To give you some perspective, the issue scales linearly per number of
> cpus you have, vcpus or real, does not matter. over 200 cores for
> instance will have about 18 GiB of virtual memory allocation wasted
> on duplicate module loads because of udev. Although now have convinced
> folks this is an issue, because I have the proof, a fix for this is
> still pending upstream. For upstream we'll be going with a simple
> solution by Linus to converge duplicates, however that convergence
> will only last whlie we kernel_read() the module and duplicates enter
> the system during that time. That still seems to fix most of the
> virtual memory abuse on bootup.
>=20
> On the request_module() side of things -- this is a minor issue, but
> it is something for developers to consider seeing if they can just
> request a module once. But it's not a big deal.

Understood. Given that it's unlikly someone is running blktests on a
production server we should be fine for the time.

Thanks,
Daniel


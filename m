Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F41BDC7EE37
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Jun 2023 00:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qfMCkjt0JTJUh5EuBlJ4Ljxu9PPOJ7nUi/IUJ6GsWQM=; b=EE5TI40zpOUuT0WnCVK0HOSx3C
	UET1twzv8imQ0wnojNekW5r0KuZa9T9Vj2gf3FFCKuUoxn6mHX2IfEB/FZkaZPzi//17Zb0L/AGN3
	RBZ+WhDxVK4cIaoqeaBmAo4P+rdi1iSPzUzMWPqWyQ8HWAA/BAI2t51IYMa81NNaNB9X9cHbHW6n7
	+mc7FJKO/7znd3b7m3FVy5jBBmCisWJ+3/1ctCBpQkmYHu1kDznZbBVCj5vUtP7n86w2aLA+Tys2k
	QVMYy0Fvq0iJmNbNgd/ULJiH1EfX8kNS2u9Eh2BmO1Gl0Z5e3O1JbRoCUdmNknI4V7GBU4vjlcSq0
	TSQufNmw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6hDU-003nP8-2V;
	Wed, 07 Jun 2023 00:40:00 +0000
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1q6hDS-003nOv-2z;
	Wed, 07 Jun 2023 00:39:58 +0000
Date: Tue, 6 Jun 2023 17:39:58 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Daniel Wagner <dwagner@suse.de>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: module-autoload: duplicate request for module nvme-tcp
Message-ID: <ZH/R3pl+8kY7MefU@bombadil.infradead.org>
References: <tom6xspqarrxx6c5ilqu7c7nhysgt3ua26yu52l2zaj7mr2qlp@vqr7y355ohzf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <tom6xspqarrxx6c5ilqu7c7nhysgt3ua26yu52l2zaj7mr2qlp@vqr7y355ohzf>
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

On Tue, Jun 06, 2023 at 12:56:58PM +0200, Daniel Wagner wrote:
> Hi Luis,
>=20
> I've enabled the module debug options and got some traces when running bl=
ktests
> (nvme_trtype=3Dtcp ./check nvme). I read the commit message 8660484ed1cf =
("module:
> add debugging auto-load duplicate module support") I cannot really decide=
 what
> to do with the report. I disable the debug options for now (trying to wor=
k on
> something else). So this just to let you know, that the debug code seems =
to do
> something :)
>=20
> Thanks,
> Daniel
>=20
>  ------------[ cut here ]------------
>  module-autoload: duplicate request for module nvme-tcp
>  WARNING: CPU: 2 PID: 1725 at kernel/module/dups.c:185 kmod_dup_request_e=
xists_wait+0x2bd/0x520
>  Modules linked in: loop nvmet_tcp nvmet nvme_tcp nvme_fabrics nfsv3 nfs_=
acl rpcsec_gss_krb5 auth_rpcgss nfsv4 dns_resolver nfs lockd grace sunrpc f=
scache netfs af_packet rfkill qrtr snd_hda_codec_generic intel_rapl_msr int=
el_rapl_common intel_pmc_core kvm_intel nls_iso8859_1 nls_cp437 vfat snd_hd=
a_intel snd_intel_dspcfg fat snd_hda_codec kvm snd_hwdep iTCO_wdt intel_pmc=
_bxt snd_hda_core iTCO_vendor_support snd_pcm i2c_i801 irqbypass i2c_smbus =
pcspkr snd_timer virtio_net snd virtio_balloon soundcore lpc_ich net_failov=
er failover tiny_power_button joydev button fuse efi_pstore configfs ip_tab=
les x_tables hid_generic usbhid crct10dif_pclmul crc32_pclmul ghash_clmulni=
_intel xhci_pci xhci_pci_renesas xhci_hcd sr_mod aesni_intel cdrom crypto_s=
imd cryptd virtio_blk virtio_rng usbcore nvme virtio_gpu virtio_dma_buf nvm=
e_core nvme_common serio_raw btrfs libcrc32c crc32c_intel xor zlib_deflate =
raid6_pq sg dm_multipath dm_mod scsi_dh_rdac scsi_dh_emc scsi_dh_alua efiva=
rfs qemu_fw_cfg [last unloaded: loop]
>  CPU: 2 PID: 1725 Comm: nvme Tainted: G        W          6.4.0-rc2+ #2 1=
daf2dc6ddfbfdba6b9ddd3bcf1253da050c6a9f
>  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS unknown unknown
>  RIP: 0010:kmod_dup_request_exists_wait+0x2bd/0x520
>  Code: a4 e8 77 6f 28 02 4c 89 ff e8 3f 58 4c 00 80 3d 68 6d b5 03 00 0f =
84 24 01 00 00 48 c7 c7 80 60 70 a3 48 89 de e8 03 5e d9 ff <0f> 0b 40 84 e=
d 0f 84 22 01 00 00 49 8d 7c 24 48 be 02 01 00 00 e8
>  RSP: 0018:ffff8881086ff720 EFLAGS: 00010246
>  RAX: 2c07e0659ca46000 RBX: ffff8881086ff820 RCX: 0000000000000027
>  RDX: 0000000000000001 RSI: 0000000000000004 RDI: ffff88815abf07c8
>  RBP: 0000000000000001 R08: dffffc0000000000 R09: ffffed102b57e0fa
>  R10: 0000000000000000 R11: dffffc0000000001 R12: ffff888108fa8400
>  R13: 0000000fffffffe0 R14: dffffc0000000000 R15: ffff88810af38c00
>  FS:  00007fb64187e740(0000) GS:ffff88815aa00000(0000) knlGS:000000000000=
0000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 00007fb6419db28e CR3: 0000000130390005 CR4: 0000000000370ee0
>  Call Trace:
>   <TASK>
>   __request_module+0x1ce/0x4e0
>   ? trace_contention_end+0x38/0xf0
>   ? kasan_unpoison+0x64/0x90
>   ? __cfi___request_module+0x10/0x10
>   ? __mutex_unlock_slowpath+0x21f/0x770
>   ? kasan_quarantine_put+0xb4/0x1c0
>   ? __kmem_cache_free+0x21f/0x3d0
>   ? __asan_memcpy+0x3c/0x70
>   ? nvmf_dev_write+0x1956/0x2430 [nvme_fabrics 08f7b8c3317d458ea9e1722c19=
d051cbfd8a49c3]
>   nvmf_dev_write+0x1a2c/0x2430 [nvme_fabrics 08f7b8c3317d458ea9e1722c19d0=
51cbfd8a49c3]

nvmf_dev_write() seems to implicate a request_module() call, try to
answer this question: how many times do you want to be calling
request_module() for something ?

The warning comes up to tell developers they should try to see if they
can instead just issue a request *once*. A simple bool would do it.

Why is this good? Well prior to me convincing folks that this could
incur high virtual memory allocations I didn't have proof such abuse
existed. My patch showed the abuse came not from kernel request_module()
users but instead for userspace through udev.

To give you some perspective, the issue scales linearly per number of
cpus you have, vcpus or real, does not matter. over 200 cores for
instance will have about 18 GiB of virtual memory allocation wasted
on duplicate module loads because of udev. Although now have convinced
folks this is an issue, because I have the proof, a fix for this is
still pending upstream. For upstream we'll be going with a simple
solution by Linus to converge duplicates, however that convergence
will only last whlie we kernel_read() the module and duplicates enter
the system during that time. That still seems to fix most of the
virtual memory abuse on bootup.

On the request_module() side of things -- this is a minor issue, but
it is something for developers to consider seeing if they can just
request a module once. But it's not a big deal.

  Luis


Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D259DC7EE24
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Jun 2023 10:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=CxwxZtwY7UdZj2t3cDImiwiBNmlryfvLjaeZJcEH++4=; b=DsjJU3VGi9r6yTEel/oPKsWqGT
	E+0huMvb/kynb/r1rXbp5hvHFzzNQOyunFfYrJWQCXyTT8HNhBegxt+B+eQPmcwzBzVKqVpTeDVEn
	S4UojPbC/elXwmXaZ0RZ4ctjtiNkQE1UkGCQ08N3D59oTwVTvE+ldOdD0vfgmjOEgsr0BTjC4GHlT
	ca+OxhRPD3Km5bybb1o+eKzoucsdxd14Fppa3Agc+tUkAe43yr2n9vBiA/hcRzHLr7KtN/p+ML0hx
	k3XwtUOoj94P3M6OQEofIie/Ld7cx6BAJ+rAzYhtEC5+Ax9VP4jD+G3H28pe1B5shP/Fqsce/1q4U
	I42PsGsQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6UN8-001MbO-2i;
	Tue, 06 Jun 2023 10:57:06 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q6UN5-001MZM-2U
	for linux-nvme@lists.infradead.org;
	Tue, 06 Jun 2023 10:57:05 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 97C2C21992;
	Tue,  6 Jun 2023 10:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1686049019; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CxwxZtwY7UdZj2t3cDImiwiBNmlryfvLjaeZJcEH++4=;
	b=cmqZ9gx5RcGu4pwH9w2wU0wu0YzukSmIoUibufUOrWHnBur6Sexp7ijpfN3IuZ7YcoFAwY
	FkeivurEbPFYzpkNw8d6pmXRmHrZ+HwNYhGLC4E/+4PukdkJhlMjogQMOjazYLO8RN+ewv
	rrgfEMlOiJe7AUp8ZZIWGJ9jBwbR2FQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1686049019;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CxwxZtwY7UdZj2t3cDImiwiBNmlryfvLjaeZJcEH++4=;
	b=vMEdRzIL6qTGdl9DJWw3J+uTghWnD6jaJtSXW+NDl2Tcl8FmRTgAY9sNueNtJNDP/7hPNw
	VZjM0xKdbTY+qjAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8AA2413776;
	Tue,  6 Jun 2023 10:56:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id dVjWIfsQf2RgBgAAMHmgww
	(envelope-from <dwagner@suse.de>); Tue, 06 Jun 2023 10:56:59 +0000
Date: Tue, 6 Jun 2023 12:56:58 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: module-autoload: duplicate request for module nvme-tcp
Message-ID: <tom6xspqarrxx6c5ilqu7c7nhysgt3ua26yu52l2zaj7mr2qlp@vqr7y355ohzf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230606_035704_096920_10F269E7 
X-CRM114-Status: GOOD (  10.21  )
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

I've enabled the module debug options and got some traces when running blkt=
ests
(nvme_trtype=3Dtcp ./check nvme). I read the commit message 8660484ed1cf ("=
module:
add debugging auto-load duplicate module support") I cannot really decide w=
hat
to do with the report. I disable the debug options for now (trying to work =
on
something else). So this just to let you know, that the debug code seems to=
 do
something :)

Thanks,
Daniel

 ------------[ cut here ]------------
 module-autoload: duplicate request for module nvme-tcp
 WARNING: CPU: 2 PID: 1725 at kernel/module/dups.c:185 kmod_dup_request_exi=
sts_wait+0x2bd/0x520
 Modules linked in: loop nvmet_tcp nvmet nvme_tcp nvme_fabrics nfsv3 nfs_ac=
l rpcsec_gss_krb5 auth_rpcgss nfsv4 dns_resolver nfs lockd grace sunrpc fsc=
ache netfs af_packet rfkill qrtr snd_hda_codec_generic intel_rapl_msr intel=
_rapl_common intel_pmc_core kvm_intel nls_iso8859_1 nls_cp437 vfat snd_hda_=
intel snd_intel_dspcfg fat snd_hda_codec kvm snd_hwdep iTCO_wdt intel_pmc_b=
xt snd_hda_core iTCO_vendor_support snd_pcm i2c_i801 irqbypass i2c_smbus pc=
spkr snd_timer virtio_net snd virtio_balloon soundcore lpc_ich net_failover=
 failover tiny_power_button joydev button fuse efi_pstore configfs ip_table=
s x_tables hid_generic usbhid crct10dif_pclmul crc32_pclmul ghash_clmulni_i=
ntel xhci_pci xhci_pci_renesas xhci_hcd sr_mod aesni_intel cdrom crypto_sim=
d cryptd virtio_blk virtio_rng usbcore nvme virtio_gpu virtio_dma_buf nvme_=
core nvme_common serio_raw btrfs libcrc32c crc32c_intel xor zlib_deflate ra=
id6_pq sg dm_multipath dm_mod scsi_dh_rdac scsi_dh_emc scsi_dh_alua efivarf=
s qemu_fw_cfg [last unloaded: loop]
 CPU: 2 PID: 1725 Comm: nvme Tainted: G        W          6.4.0-rc2+ #2 1da=
f2dc6ddfbfdba6b9ddd3bcf1253da050c6a9f
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS unknown unknown
 RIP: 0010:kmod_dup_request_exists_wait+0x2bd/0x520
 Code: a4 e8 77 6f 28 02 4c 89 ff e8 3f 58 4c 00 80 3d 68 6d b5 03 00 0f 84=
 24 01 00 00 48 c7 c7 80 60 70 a3 48 89 de e8 03 5e d9 ff <0f> 0b 40 84 ed =
0f 84 22 01 00 00 49 8d 7c 24 48 be 02 01 00 00 e8
 RSP: 0018:ffff8881086ff720 EFLAGS: 00010246
 RAX: 2c07e0659ca46000 RBX: ffff8881086ff820 RCX: 0000000000000027
 RDX: 0000000000000001 RSI: 0000000000000004 RDI: ffff88815abf07c8
 RBP: 0000000000000001 R08: dffffc0000000000 R09: ffffed102b57e0fa
 R10: 0000000000000000 R11: dffffc0000000001 R12: ffff888108fa8400
 R13: 0000000fffffffe0 R14: dffffc0000000000 R15: ffff88810af38c00
 FS:  00007fb64187e740(0000) GS:ffff88815aa00000(0000) knlGS:00000000000000=
00
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 00007fb6419db28e CR3: 0000000130390005 CR4: 0000000000370ee0
 Call Trace:
  <TASK>
  __request_module+0x1ce/0x4e0
  ? trace_contention_end+0x38/0xf0
  ? kasan_unpoison+0x64/0x90
  ? __cfi___request_module+0x10/0x10
  ? __mutex_unlock_slowpath+0x21f/0x770
  ? kasan_quarantine_put+0xb4/0x1c0
  ? __kmem_cache_free+0x21f/0x3d0
  ? __asan_memcpy+0x3c/0x70
  ? nvmf_dev_write+0x1956/0x2430 [nvme_fabrics 08f7b8c3317d458ea9e1722c19d0=
51cbfd8a49c3]
  nvmf_dev_write+0x1a2c/0x2430 [nvme_fabrics 08f7b8c3317d458ea9e1722c19d051=
cbfd8a49c3]
  ? __cfi_nvmf_dev_write+0x10/0x10 [nvme_fabrics 08f7b8c3317d458ea9e1722c19=
d051cbfd8a49c3]
  ? entry_SYSCALL_64_after_hwframe+0x72/0xdc
  ? local_lock_release+0x23/0x70
  ? __cfi_do_filp_open+0x10/0x10
  ? lock_release+0xa3/0xd10
  ? rcu_lock_acquire+0x40/0x40
  ? common_file_perm+0x132/0x1e0
  vfs_write+0x1f7/0xa10
  ? kasan_quarantine_put+0xb4/0x1c0
  ? __cfi_vfs_write+0x10/0x10
  ? do_sys_openat2+0x311/0x410
  ? __cfi_handle_mm_fault+0x10/0x10
  ? do_sys_open+0x1e0/0x1e0
  ? lock_release+0xa3/0xd10
  ? __fdget_pos+0x51/0x260
  ksys_write+0x12a/0x210
  ? __cfi_ksys_write+0x10/0x10
  ? syscall_enter_from_user_mode+0x2e/0x210
  do_syscall_64+0x6e/0xa0
  ? syscall_exit_to_user_mode+0x5e/0x220
  ? do_syscall_64+0x7d/0xa0
  entry_SYSCALL_64_after_hwframe+0x72/0xdc
 RIP: 0033:0x7fb6419a6a54
 Code: ff eb b7 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e=
 fa 90 90 80 3d 2d 11 0f 00 00 74 13 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff =
ff 77 54 c3 0f 1f 00 48 83 ec 28 48 89 54 24 18 48
 RSP: 002b:00007ffd0ab7ac78 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
 RAX: ffffffffffffffda RBX: 000055ac367e1910 RCX: 00007fb6419a6a54
 RDX: 00000000000000cf RSI: 000055ac367e1910 RDI: 0000000000000005
 RBP: 0000000000000005 R08: 00000000000000cf R09: 000055ac367e1910
 R10: 0000000000000000 R11: 0000000000000202 R12: 000055ac367df140
 R13: 00000000000000cf R14: 00007fb641af5245 R15: 00007fb641af5282
  </TASK>
 irq event stamp: 0
 hardirqs last  enabled at (0): [<0000000000000000>] 0x0
 hardirqs last disabled at (0): [<ffffffffa0de0c64>] copy_process+0x1264/0x=
3610
 softirqs last  enabled at (0): [<ffffffffa0de0c90>] copy_process+0x1290/0x=
3610
 softirqs last disabled at (0): [<0000000000000000>] 0x0
 ---[ end trace 0000000000000000 ]---


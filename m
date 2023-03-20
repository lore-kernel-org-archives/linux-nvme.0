Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8F91C7618A
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Mar 2023 14:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Q+6xj4grsmXIvsrEci6WbliYWEfqxfbu+totmdLJEzo=; b=2qsywTwCLHN0IDKu7jsGQxwBeE
	XVlSOdSLMWxfH4UKf+arSWv0e8aSJv1DExGFjOc66nKwNGNTnkexshqBMB1ZkYJXnjzTBVXTl7tbH
	QQtwPriY2Rd/+AncKrUqo9XbY0ij0fzFKBjDgMC7mYB3mCKsf5LngY2qtCkneokn3ChVEMD5nUFUP
	N0R8yJcudKBLA8eeB8Jo1rewibQmlhHkUdJNRyevVaUnMaCqYr6+UitllOT7ljQwMp6ZmUNYM+0Io
	5/vCqhE+wihnmYM+U6Cjh5RB47H/KvUsttRhHCRe4rHv3tnQM0N8xDYSQ1Dpz0cnkEANQVIbdWg12
	ODl9Px4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1peGM7-009J9c-1c;
	Mon, 20 Mar 2023 14:19:23 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1peGM4-009J84-1K
	for linux-nvme@lists.infradead.org;
	Mon, 20 Mar 2023 14:19:22 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DFEB21F889;
	Mon, 20 Mar 2023 14:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1679321952; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=Q+6xj4grsmXIvsrEci6WbliYWEfqxfbu+totmdLJEzo=;
	b=zuXApaAzZrINAUdsWY6Tw94fc+oTYj47Mq4amg/q9zGbUHJpVGZriEuwgtbW5NJxVoE6U2
	UJz9Y72KUEctXKvGnKcIQLbAGSNgzT918WpVCeImHCa+7Fa/saZfh+VJnAffXg0Jbu0eyM
	jxnIqPH3gJoMT95g9dj5VSw2SESTpH8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1679321952;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=Q+6xj4grsmXIvsrEci6WbliYWEfqxfbu+totmdLJEzo=;
	b=7EEc3Ikvj447sXHmZTs+TRUnfl1WVq6Vn/C2j+W/lHmOsIyWQreNJDzqbLsjzTi1xNYcbT
	iIIJjj74JBY9T+Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D29BB13A00;
	Mon, 20 Mar 2023 14:19:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id r9L7MmBrGGRZHgAAMHmgww
	(envelope-from <dwagner@suse.de>); Mon, 20 Mar 2023 14:19:12 +0000
Date: Mon, 20 Mar 2023 15:19:12 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: nvme-tcp poll queue crash
Message-ID: <20230320141912.avtauwpy5t4x2rvz@carbon.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230320_071920_611314_B156A783 
X-CRM114-Status: GOOD (  11.35  )
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

While I am working on the unification of the ctrl state machine I run into
the crash below. It gets triggered as soon a poll queue is involved in the
setup, e.g

  nvme connect-all -P 2

An older downstream kernel works fine, thus I looked what has changed between
the older version and current upstream in this area. One commit which
caught my eye is

  3e08773c3841 ("block: switch polling to be bio based")

and a bisect test also points to this commit.

Not really sure what's wrong yet.




nvme_fabrics: ctrl_loss_tmo < 0 will reconnect forever
nvme nvme0: starting queue 0
nvme nvme0: new ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery", addr 10.161.60.229:4420
nvme_fabrics: ctrl_loss_tmo < 0 will reconnect forever
nvme nvme1: starting queue 0
nvme nvme1: creating 10 I/O queues.
nvme nvme1: mapped 8/0/2 default/read/poll queues.
general protection fault, probably for non-canonical address 0xdffffc0000000006: 0000 [#1] PREEMPT SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000030-0x0000000000000037]
CPU: 3 PID: 14721 Comm: nvme Kdump: loaded Tainted: G        W          6.3.0-rc1+ #5 6cd7634f287bf1c980624b45b3fda8104b866bd4
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
RIP: 0010:bio_poll+0x32/0x340
Code: 41 56 41 55 41 54 53 48 83 ec 10 89 d5 48 89 74 24 08 49 89 fc 49 bf 00 00 00 00 00 fc ff df 48 83 c7 34 48 89 f8 48 c1 e8 03 <42> 8a 04 38 84 c0 0f 85 e0 02 00 00 45 8b 6c 24 34 49 8d 5c 24 08
RSP: 0018:ffff88814f0f7738 EFLAGS: 00010207
RAX: 0000000000000006 RBX: 1ffff110300c8007 RCX: dffffc0000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000034
RBP: 0000000000000000 R08: dffffc0000000000 R09: fffffbfff6083f47
R10: fffffbfff6083f47 R11: 1ffffffff6083f46 R12: 0000000000000000
R13: 1ffff110300c8003 R14: ffff888180640038 R15: dffffc0000000000
FS:  00007fdfcee93780(0000) GS:ffff8881f0c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000564f11a29ef0 CR3: 0000000127fc2001 CR4: 0000000000170ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 blk_execute_rq+0x38c/0x520
 ? bio_add_pc_page+0xb2/0x160
 ? blk_rq_is_poll+0xb0/0xb0
 ? blk_rq_map_kern+0x346/0x790
 ? complete+0x2c/0x1e0
 ? blk_rq_map_kern+0x5f2/0x790
 __nvme_submit_sync_cmd+0x2f4/0x5e0 [nvme_core de304e8eff44299bdc13725667287374bc2160e2]
 nvmf_connect_io_queue+0x30d/0x5a0 [nvme_fabrics 4052b7860de0b5cb3ac1ed1621cbcc910632f6f5]
 ? nvmf_log_connect_error+0x470/0x470 [nvme_fabrics 4052b7860de0b5cb3ac1ed1621cbcc910632f6f5]
 ? blk_alloc_queue+0x3a4/0x460
 nvme_tcp_start_queue+0x6c/0x390 [nvme_tcp e4d004153d5b77412680c0bac676e3ee38ade317]
 nvme_tcp_setup_ctrl+0xc03/0x1690 [nvme_tcp e4d004153d5b77412680c0bac676e3ee38ade317]
 ? nvme_reset_ctrl_work+0xf0/0xf0 [nvme_tcp e4d004153d5b77412680c0bac676e3ee38ade317]
 ? _raw_spin_unlock_irqrestore+0x32/0x50
 ? nvme_change_ctrl_state+0xec/0x2d0 [nvme_core de304e8eff44299bdc13725667287374bc2160e2]
 nvme_tcp_create_ctrl+0x71e/0xa80 [nvme_tcp e4d004153d5b77412680c0bac676e3ee38ade317]
 nvmf_dev_write+0x498/0x790 [nvme_fabrics 4052b7860de0b5cb3ac1ed1621cbcc910632f6f5]
 vfs_write+0x1fc/0xaa0
 ? file_end_write+0x1a0/0x1a0
 ? __up_read+0x258/0x6b0
 ? __x64_sys_openat+0x20e/0x260
 ? __fdget_pos+0x51/0x250
 ksys_write+0x128/0x210
 ? __ia32_sys_read+0x80/0x80
 ? syscall_enter_from_user_mode+0x2e/0x1c0
 do_syscall_64+0x60/0x90
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fdfcdd06af3
Code: 0f 1f 80 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 64 8b 04 25 18 00 00 00 85 c0 75 14 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 55 f3 c3 0f 1f 00 41 54 55 49 89 d4 53 48 89
RSP: 002b:00007ffe791baad8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00005571420c85c0 RCX: 00007fdfcdd06af3
RDX: 00000000000000e6 RSI: 00005571420c85c0 RDI: 0000000000000005
RBP: 0000000000000005 R08: 00000000000000e6 R09: 00005571420c85c0
R10: 0000000000000000 R11: 0000000000000246 R12: 00005571420c4a00
R13: 00000000000000e6 R14: 00007fdfceec65b0 R15: 00007fdfceeb8740
 </TASK>
Modules linked in: nvme_tcp nvme_fabrics nvme_core nvme_common rpcsec_gss_krb5 auth_rpcgss nfsv4 dns_resolver nfs lockd grace sunrpc fscache netfs af_packet rfkill nls_iso8859_1 nls_cp437 vfat fat intel_rapl_msr snd_hda_codec_generic intel_rapl_common kvm_intel iTCO_wdt intel_pmc_bxt iTCO_vendor_support snd_hda_intel snd_intel_dspcfg kvm snd_hda_codec snd_hwdep irqbypass snd_hda_core snd_pcm pcspkr snd_timer i2c_i801 i2c_smbus efi_pstore joydev snd soundcore lpc_ich virtio_balloon tiny_power_button virtio_net net_failover failover button fuse configfs ip_tables x_tables crct10dif_pclmul crc32_pclmul ghash_clmulni_intel hid_generic usbhid aesni_intel crypto_simd cryptd xhci_pci serio_raw xhci_pci_renesas sr_mod cdrom virtio_blk xhci_hcd usbcore virtio_gpu virtio_dma_buf qemu_fw_cfg btrfs libcrc32c crc32c_intel xor zlib_deflate raid6_pq sg dm_multipath dm_mod scsi_dh_rdac scsi_dh_emc scsi_dh_alua efivarfs virtio_rng


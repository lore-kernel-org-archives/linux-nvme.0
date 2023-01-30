Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2C81C54EAA
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Jan 2023 11:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ro7TXEtrJhJlk/piFK4pKIbKbGBm8LI4SzTlzT/kdnM=; b=Kc6Rx0IjodgFkiqT40JEimV0DE
	OD9a6Ixvja7ZaZbrVnmjBj1wCv/NiTEcp1LtvyNoldHjXUbCY0O4Hdf1/oHSxkhW4WO9OqUbHemDW
	OWriPibINVifd3RmUWwi0ZhT0mG0medIy0srnep4ir1lRlfwrqXroBmCmscs2H9IkBmg9lfo461i6
	gXUtqrQdLEt2e4DHTfA8WV+efyJYZRin0TTVzIVTf0PiUBigcgDKwXaxDjZFwsDyxDAjncywUuWz2
	fHEKduxmNc1LH2akPgTSWRlh60Xhw2yVG/qBToQKNhYj87WlmlnR2M+XMIry7I2vAyEQDabRRGJ5u
	YPtiGnLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pMS8z-003GL5-32; Mon, 30 Jan 2023 11:16:13 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pMS8O-003GK4-7g
	for linux-nvme@lists.infradead.org; Mon, 30 Jan 2023 11:15:37 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D69CA1FE32;
	Mon, 30 Jan 2023 11:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1675077332; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=ro7TXEtrJhJlk/piFK4pKIbKbGBm8LI4SzTlzT/kdnM=;
	b=yakHvwhKAo/7MnpUMtDA4VwV+MTefNuN2Snajn4xNXnlKIUbMjXUeXQTEyC8LQf6D/AkDv
	SlUvJxKMchrymcUvB8Q/HE+4iMXB80isyYFxZiRUgxCiUiR/LsAp14gldM8q1sqNyKuh7z
	6Ri90X0rUoe6nyM1ljpdvD3uIVwpE/w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1675077332;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=ro7TXEtrJhJlk/piFK4pKIbKbGBm8LI4SzTlzT/kdnM=;
	b=YNgRLwSD1/sZBp1pzL4oqjyx3jbs/LJawTAWSxiWKfsXpz7axfL5STMLNaL0Ga3FLnVU5Z
	jiMvsQcZz9irgcAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C9F4813A06;
	Mon, 30 Jan 2023 11:15:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id jcU5MdSm12PCHgAAMHmgww
	(envelope-from <dwagner@suse.de>); Mon, 30 Jan 2023 11:15:32 +0000
Date: Mon, 30 Jan 2023 12:15:32 +0100
From: Daniel Wagner <dwagner@suse.de>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Hannes Reinecke <hare@suse.de>, James Smart <jsmart2021@gmail.com>
Subject: nvme-6.3: blktests nvme/003 null pointer for fc transport
Message-ID: <20230130111532.ez63iip4qxrh42ga@carbon.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230130_031536_440164_A8313B05 
X-CRM114-Status: UNSURE (   9.29  )
X-CRM114-Notice: Please train this message.
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

Hi,

Hannes added support to blktest to enable the FC transport for it. And as result
blktests is able to crash the kernel. Haven't startet to look into it yet.

 run blktests nvme/003 at 2023-01-30 12:08:28
 nvmet: adding nsid 1 to subsystem blktests-subsystem-1
 BUG: kernel NULL pointer dereference, address: 0000000000000010
 #PF: supervisor read access in kernel mode
 #PF: error_code(0x0000) - not-present page
 PGD 0 P4D 0
 Oops: 0000 [#1] PREEMPT SMP NOPTI
 CPU: 3 PID: 14200 Comm: nvme Not tainted 6.2.0-rc4+ #1 c9afca57e89c2aa3234427c2cd6cd4dd2984ae8c
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
 RIP: 0010:nvme_alloc_admin_tag_set+0x38/0x120 [nvme_core]
 Code: 48 89 d5 48 89 f3 49 89 fe ba 30 01 00 00 48 89 f7 31 f6 e8 9a a9 0a df 48 89 6b 38 c7 43 44 1e 00 00 00 49 8b 86 f8 00 00 00 <f6> 40 10 01 74 07 c7 43 48 01 00 00 00 41 8b 86 24 01 00 00 89 43
 RSP: 0018:ffffa9d341a07c48 EFLAGS: 00010246
 RAX: 0000000000000000 RBX: ffff902d57966090 RCX: 0000000000000000
 RDX: 0000000000000130 RSI: 0000000000000000 RDI: ffff902d579661c0
 RBP: ffffffffc0c08578 R08: 0000000000000dc0 R09: ffff902d57966090
 R10: ffffffff9f379a17 R11: 0000000000000010 R12: ffff902d579665a8
 R13: ffff902d7226a800 R14: ffff902d579665a8 R15: 00000000000001d8
 FS:  00007f50d94c1780(0000) GS:ffff902eb1400000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 0000000000000010 CR3: 00000001056d2001 CR4: 0000000000170ee0
 DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
 Call Trace:
  <TASK>
  nvme_fc_init_ctrl+0x444/0x620 [nvme_fc e229b68788426766352a96e834fb25104e3bb609]
  nvme_fc_create_ctrl+0x1e9/0x250 [nvme_fc e229b68788426766352a96e834fb25104e3bb609]
  ? rcu_read_lock_sched_held+0xb/0x70
  nvmf_dev_write+0x22d/0x330 [nvme_fabrics 903efb754406e989596ad7b178f3d4a61b162a0e]
  vfs_write+0x10d/0x2f0
  ? do_sys_openat2+0x128/0x150
  ksys_write+0x6c/0xd0
  do_syscall_64+0x60/0x90
  ? do_user_addr_fault+0x3bf/0x510
  ? rcu_read_lock_sched_held+0xb/0x70
  entry_SYSCALL_64_after_hwframe+0x63/0xcd
 RIP: 0033:0x7f50d7f06af3
 Code: 0f 1f 80 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 64 8b 04 25 18 00 00 00 85 c0 75 14 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 55 f3 c3 0f 1f 00 41 54 55 49 89 d4 53 48 89
 RSP: 002b:00007fff10857428 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
 RAX: ffffffffffffffda RBX: 0000560c887baeb0 RCX: 00007f50d7f06af3
 RDX: 000000000000012b RSI: 0000560c887baeb0 RDI: 0000000000000003
 RBP: 0000000000000003 R08: 000000000000012b R09: 0000560c887baeb0
 R10: 00007f50d7e07468 R11: 0000000000000246 R12: 0000560c887b7970
 R13: 000000000000012b R14: 00007f50d94eb5a0 R15: 00007f50d94dd520
  </TASK>
 Modules linked in: loop nvme_fcloop nvmet_fc nvmet nvme_fc nvme_fabrics nvme_core nvme_common rpcsec_gss_krb5 auth_rpcgss nfsv4 dns_resolver nfs lockd grace sunrpc fscache netfs af_packet rfkill nls_iso8859_1 nls_cp437 vfat intel_rapl_msr fat intel_rapl_common snd_hda_codec_generic kvm_intel snd_hda_intel iTCO_wdt intel_pmc_bxt snd_intel_dspcfg iTCO_vendor_support snd_hda_codec kvm snd_hwdep joydev snd_hda_core irqbypass snd_pcm pcspkr snd_timer i2c_i801 lpc_ich efi_pstore i2c_smbus snd virtio_net soundcore tiny_power_button net_failover virtio_balloon failover button fuse configfs ip_tables x_tables hid_generic usbhid crct10dif_pclmul crc32_pclmul ghash_clmulni_intel aesni_intel crypto_simd cryptd serio_raw xhci_pci sr_mod xhci_pci_renesas cdrom virtio_blk xhci_hcd usbcore virtio_gpu virtio_dma_buf qemu_fw_cfg btrfs libcrc32c crc32c_intel xor zlib_deflate raid6_pq sg dm_multipath dm_mod scsi_dh_rdac scsi_dh_emc scsi_dh_alua efivarfs virtio_rng
  [last unloaded: nvme_common]
 CR2: 0000000000000010
 ---[ end trace 0000000000000000 ]---

Thanks,
Daniel


Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D54CC433F5
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Mar 2022 21:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SOZh7mllByD0dsvSsQzAyd5iVpR524yiebHl9rW46T0=; b=GCOoh9bKYK0EcNSbSnWlQ204Vk
	nxKqmsaDLsbWomPjEaZCHFAqF3dYvh3+tSaB8zl6gOppCY2yaoh1iJLruBW0r3VP8OD/aCqbNwD8Z
	S6pdSa+p49tzxp2vtGLY9PK2CamHvmJ3IJ0zHzSklZZAA6DBtFRqwcjLFXlenFA117L+9SmmGClpW
	/HDKXLEr0u36dhKFRxOKAFp/ZBTDRu0AF0IYZbsfxLVCTOamd4HbmAn26nvIbRvQTzk59YoD0JMcb
	Zt+H/kn3ajlEBqsYnD6NSDEC3oyU2mgqrAYrx19fsVP9hP8nZw6OyV78SzpDpfkM/X8CLxJFH9w0D
	DOM7a/qQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nQFDR-00C5YU-At; Fri, 04 Mar 2022 21:11:57 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nQFDN-00C5Xt-Jb
 for linux-nvme@lists.infradead.org; Fri, 04 Mar 2022 21:11:55 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 2A709B82B7D;
 Fri,  4 Mar 2022 21:11:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86076C340E9;
 Fri,  4 Mar 2022 21:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1646428310;
 bh=4Mc8VwnnTISw7h3v5rPiGJZSdJre1u5EXkwdeSlhzXo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=irBXa0ZPIDJUVFBzhlRFpHYyz8UwIWdenC+JrCpY6mvZSLBD0tjyJCbZH2T4i+jvW
 x2Zs63FdkeYjOWH8LekzvT9HDd/1O3ZkrZuBrrDlFjXgTMPtVb988xTh5a2lbSfO+x
 Msi7hVhq3Wz4336XkuAGOn170CwO6LfA7VbNjLQ2EGHX1unvTEh+WByVYxrgRmWXlm
 VDjevmzm53+1F3h81ZgES7rzjdEhBAAOyT84ItlcyIJ5LxbHjzdKHZ0zAGIWG63nqK
 sYsZkLCMnV5Hk3Irp2Z3dvyDAe+nQEVIy0nBffxxSHy/fGXZqBmqxoTIJoW+2q7Ayh
 s1kSeCiW04jiA==
Date: Fri, 4 Mar 2022 13:11:48 -0800
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Varun Prakash <varun@chelsio.com>, hch@lst.de, Ran.Anner@dell.com,
 linux-nvme@lists.infradead.org
Subject: Re: [PATCH v4] nvme-tcp: send H2CData PDUs based on MAXH2CDATA
Message-ID: <20220304211148.GB3256926@dhcp-10-100-145-180.wdc.com>
References: <1642870664-3401-1-git-send-email-varun@chelsio.com>
 <23ddf451-2540-86c2-c403-2614477c130f@grimberg.me>
 <98f61e6a-5bc2-788a-a0e0-557001adcf51@grimberg.me>
 <337cec23-c9ee-1cfb-89fc-e6aec649623c@grimberg.me>
 <20220301225601.GA2366101@dhcp-10-100-145-180.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220301225601.GA2366101@dhcp-10-100-145-180.wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220304_131153_978264_38581678 
X-CRM114-Status: GOOD (  12.16  )
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

Correction from the testing side, the below error was introduced
sometime after the most recent 5.15 stable and current 5.17-rc6. It has
nothing to do with this patch. I've requested a bisect to identify the
actual commit, and will report back any findings.

> [Tue Mar  1 13:13:19 2022] nvme nvme0: Removing ctrl: NQN "nqn.2015-09.co=
m.wdc:nvme.1"
> [Tue Mar  1 13:13:19 2022] ------------[ cut here ]------------
> [Tue Mar  1 13:13:19 2022] WARNING: CPU: 5 PID: 41414 at kernel/rcu/srcut=
ree.c:373 cleanup_srcu_struct+0xe8/0xf0
> [Tue Mar  1 13:13:19 2022] Modules linked in: nvme_tcp(OE) nvme_rdma nvme=
_fabrics nvme nvme_core ib_umad rdma_ucm rdma_cm iw_cm ib_cm snd_seq_dummy =
snd_hrtimer snd_seq_midi snd_seq_midi_event snd_rawmidi snd_seq snd_seq_dev=
ice snd_timer snd soundcore cmac nls_utf8 cifs cifs_arc4 cifs_md4 fscache n=
etfs cuse ipmi_ssif binfmt_misc nls_iso8859_1 intel_rapl_msr intel_rapl_com=
mon sb_edac x86_pkg_temp_thermal intel_powerclamp coretemp drm_vram_helper =
crct10dif_pclmul ghash_clmulni_intel drm_ttm_helper aesni_intel ttm crypto_=
simd drm_kms_helper cryptd cec rc_core fb_sys_fops rapl syscopyarea sysfill=
rect joydev input_leds sysimgblt intel_cstate efi_pstore mei_me ioatdma mei=
 acpi_ipmi ipmi_si acpi_power_meter acpi_pad mac_hid sch_fq_codel ipmi_devi=
ntf ipmi_msghandler msr parport_pc ppdev lp parport drm ip_tables x_tables =
autofs4 mlx5_ib ib_uverbs ib_core hid_generic usbhid hid mlx5_core crc32_pc=
lmul igb mlxfw psample i2c_i801 i2c_algo_bit ahci i2c_smbus lpc_ich xhci_pc=
i dca tls libahci xhci_pci_renesas
> [Tue Mar  1 13:13:19 2022]  pci_hyperv_intf wmi
> [Tue Mar  1 13:13:19 2022] CPU: 5 PID: 41414 Comm: nvme Tainted: G       =
    OE     5.17.0-051700rc4-generic #202202132130
> [Tue Mar  1 13:13:19 2022] Hardware name: Supermicro SYS-5018R-WR/X10SRW-=
F, BIOS 2.0a 08/02/2016
> [Tue Mar  1 13:13:19 2022] RIP: 0010:cleanup_srcu_struct+0xe8/0xf0
> [Tue Mar  1 13:13:19 2022] Code: ff 84 c0 0f 85 f9 45 b0 00 49 8b bd f0 c=
3 00 00 e8 cd 37 17 00 49 c7 85 f0 c3 00 00 00 00 00 00 5b 41 5c 41 5d 5d c=
3 0f 0b c3 <0f> 0b eb b5 0f 0b 66 90 0f 1f 44 00 00 48 8b 7f 28 f0 ff 8f 40=
 c4
> [Tue Mar  1 13:13:19 2022] RSP: 0018:ffff97844b7cfac8 EFLAGS: 00010202
> [Tue Mar  1 13:13:19 2022] RAX: 0000000000000001 RBX: ffff888575920080 RC=
X: 0000000000000010
> [Tue Mar  1 13:13:19 2022] RDX: 0000000000000010 RSI: 0000000000000000 RD=
I: 0000000000000010
> [Tue Mar  1 13:13:19 2022] RBP: ffff97844b7cfae0 R08: 0000000000000000 R0=
9: 0000000000000000
> [Tue Mar  1 13:13:19 2022] R10: 0000000000000010 R11: 0000000000000000 R1=
2: ffff888575920000
> [Tue Mar  1 13:13:19 2022] R13: ffff888575920578 R14: 0000000000000000 R1=
5: ffff888512eecfc0
> [Tue Mar  1 13:13:19 2022] FS:  00007f010e45c740(0000) GS:ffff888c5fb4000=
0(0000) knlGS:0000000000000000
> [Tue Mar  1 13:13:19 2022] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050=
033
> [Tue Mar  1 13:13:19 2022] CR2: 00007ffe64848e98 CR3: 00000002765f4002 CR=
4: 00000000003706e0
> [Tue Mar  1 13:13:19 2022] DR0: 0000000000000000 DR1: 0000000000000000 DR=
2: 0000000000000000
> [Tue Mar  1 13:13:19 2022] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR=
7: 0000000000000400
> [Tue Mar  1 13:13:19 2022] Call Trace:
> [Tue Mar  1 13:13:19 2022]  <TASK>
> [Tue Mar  1 13:13:19 2022]  blk_release_queue+0x10d/0x110
> [Tue Mar  1 13:13:19 2022]  kobject_cleanup+0x41/0x140
> [Tue Mar  1 13:13:19 2022]  kobject_put+0x53/0x70
> [Tue Mar  1 13:13:19 2022]  blk_put_queue+0x12/0x20
> [Tue Mar  1 13:13:19 2022]  disk_release+0x63/0x80
> [Tue Mar  1 13:13:19 2022]  device_release+0x3b/0xa0
> [Tue Mar  1 13:13:19 2022]  kobject_cleanup+0x41/0x140
> [Tue Mar  1 13:13:19 2022]  kobject_put+0x53/0x70
> [Tue Mar  1 13:13:19 2022]  put_device+0x13/0x20
> [Tue Mar  1 13:13:19 2022]  put_disk+0x1b/0x20
> [Tue Mar  1 13:13:19 2022]  nvme_free_ns+0x28/0x160 [nvme_core]
> [Tue Mar  1 13:13:19 2022]  nvme_ns_remove+0x124/0x1b0 [nvme_core]
> [Tue Mar  1 13:13:19 2022]  nvme_remove_namespaces+0xb0/0xf0 [nvme_core]
> [Tue Mar  1 13:13:19 2022]  nvme_do_delete_ctrl+0x5d/0x7a [nvme_core]
> [Tue Mar  1 13:13:19 2022]  nvme_sysfs_delete.cold+0x8/0xd [nvme_core]
> [Tue Mar  1 13:13:19 2022]  dev_attr_store+0x17/0x30
> [Tue Mar  1 13:13:19 2022]  sysfs_kf_write+0x3e/0x50
> [Tue Mar  1 13:13:19 2022]  kernfs_fop_write_iter+0x137/0x1c0
> [Tue Mar  1 13:13:19 2022]  new_sync_write+0x117/0x1a0
> [Tue Mar  1 13:13:19 2022]  ? get_kcore_size+0xf0/0xf0
> [Tue Mar  1 13:13:19 2022]  vfs_write+0x1f3/0x290
> [Tue Mar  1 13:13:19 2022]  ksys_write+0x67/0xe0
> [Tue Mar  1 13:13:19 2022]  __x64_sys_write+0x19/0x20
> [Tue Mar  1 13:13:19 2022]  do_syscall_64+0x5c/0xc0
> [Tue Mar  1 13:13:19 2022]  ? do_sys_openat2+0x87/0x160
> [Tue Mar  1 13:13:19 2022]  ? exit_to_user_mode_prepare+0x37/0xb0
> [Tue Mar  1 13:13:19 2022]  ? syscall_exit_to_user_mode+0x27/0x50
> [Tue Mar  1 13:13:19 2022]  ? do_syscall_64+0x69/0xc0
> [Tue Mar  1 13:13:19 2022]  ? exit_to_user_mode_prepare+0x37/0xb0
> [Tue Mar  1 13:13:19 2022]  ? irqentry_exit_to_user_mode+0x9/0x20
> [Tue Mar  1 13:13:19 2022]  ? irqentry_exit+0x33/0x40
> [Tue Mar  1 13:13:19 2022]  ? exc_page_fault+0x89/0x180
> [Tue Mar  1 13:13:19 2022]  ? asm_exc_page_fault+0x8/0x30
> [Tue Mar  1 13:13:19 2022]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [Tue Mar  1 13:13:19 2022] RIP: 0033:0x7f010e577a37
> [Tue Mar  1 13:13:19 2022] Code: 0f 00 f7 d8 64 89 02 48 c7 c0 ff ff ff f=
f eb b7 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 0=
0 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74=
 24
> [Tue Mar  1 13:13:19 2022] RSP: 002b:00007ffdd3c13538 EFLAGS: 00000246 OR=
IG_RAX: 0000000000000001
> [Tue Mar  1 13:13:19 2022] RAX: ffffffffffffffda RBX: 0000000000000037 RC=
X: 00007f010e577a37
> [Tue Mar  1 13:13:19 2022] RDX: 0000000000000001 RSI: 0000557cd45d4e8e RD=
I: 0000000000000003
> [Tue Mar  1 13:13:19 2022] RBP: 0000000000000003 R08: 0000557cd5dcd4a0 R0=
9: 0000557cd5dcd510
> [Tue Mar  1 13:13:19 2022] R10: 0000000000000000 R11: 0000000000000246 R1=
2: 0000557cd5dcd510
> [Tue Mar  1 13:13:19 2022] R13: 0000557cd45ed060 R14: 0000000000000000 R1=
5: 0000000000000003
> [Tue Mar  1 13:13:19 2022]  </TASK>
> [Tue Mar  1 13:13:19 2022] ---[ end trace 0000000000000000 ]---


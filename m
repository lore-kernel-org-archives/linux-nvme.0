Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E57F4D41D58
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Dec 2025 15:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:MIME-Version:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=IYiY/Eg9zPqFRUEwkZTnA8v8E9X45o8v/KhbLgIvU0c=; b=4nX9RF2qg63bXMDbwsBTk8fPCh
	cJs7riN5RRq5OhJSb/Zq69+Yph8d6OEil2dAV3/vMUnw6XWM4akqUbQHwM2jQbAaXv0LezbpCWB08
	VhMxDvN0nMyWrp0/xS1NRCdv7OcM7zZQ5LCMywcDeaK80FXPu7YltAdtgeTmZvmttb2CydArxQP/v
	gTKYVR+LT9+giinRgTcT1MpuTzqJ/ICLG0AqpNzS7yQKXRtXqoJTf0uj9JcCKdxu1Pl9mZgPdQV88
	9tIe0jhAte5s05zG3S20qf1rBuzuIt46iObi6EsPSgVRqPy25QN047/jtXgR1BU9HKcOiyz/iQkmW
	IBMo/t4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vTifB-0000000GmK9-1lwt;
	Thu, 11 Dec 2025 15:33:05 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vTif8-0000000GmJl-0fAB
	for linux-nvme@lists.infradead.org;
	Thu, 11 Dec 2025 15:33:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765467177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=IYiY/Eg9zPqFRUEwkZTnA8v8E9X45o8v/KhbLgIvU0c=;
	b=IQKdqyNaoLuuDj5/NnrQkV0nGBR+eY6oL7pr9PSDRskFBT01ovbGxC66V2ddbQbW0WwEg0
	+ibaOW0F/x58h3/lY6kpg63NTL9VhjERSl1NeBNuRtRtVyEC4fai/+w43tY+/0rOdTvfxD
	om6vHJF4PTJFk63gaI0lZg0G72HZpHk=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-349-3D2g2VwOOaaeqK04bYrTWw-1; Thu, 11 Dec 2025 10:32:55 -0500
X-MC-Unique: 3D2g2VwOOaaeqK04bYrTWw-1
X-Mimecast-MFC-AGG-ID: 3D2g2VwOOaaeqK04bYrTWw_1765467174
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-37f8b25aad6so806611fa.2
        for <linux-nvme@lists.infradead.org>; Thu, 11 Dec 2025 07:32:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765467173; x=1766071973;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IYiY/Eg9zPqFRUEwkZTnA8v8E9X45o8v/KhbLgIvU0c=;
        b=pxOG2Y5Z7KiB7QpGEithrjk3JAdN608sH8i3Jm4cUXPp3FnY4M84glt2zq1H+LdYmm
         oaCKHe+zmFeCeLqG5MxsI0YfXJuD367+6LmhxIKV776Y50jDE9ivxp3LFtnBilRNW5IG
         vze4vVSoiZkNCcyo0NdGHmlLpAWxljrsQMRGdeii+glY9brGtA9dM6pnEfEOQjd+G744
         oz9k2sIR145BE66dLMtWXJkOyp54GnD4IPjX+Y82Hkqd3OKP65kKy6YV9hKAH6RAVBb9
         p3b0vyFJG5xemDmfoT4V0swJgCjhrVd0X9uc+Nrrg7x/5cwB3/LARb0ROnxGy9To7xlp
         rJXw==
X-Forwarded-Encrypted: i=1; AJvYcCUZG3MKd55Ar2i3K5Y5/VNnrufWDaBmrQ3yrx1sWvK/52FTsfgDzY+Y8zBgjdHjWtvAtlrIYY9oSOaq@lists.infradead.org
X-Gm-Message-State: AOJu0YzzgWSJAYyH6no5gBAj43ChQNQ4pbFN8wgihclhq1BYFt9qmVwT
	1ulkfv2EZhtzIQ77Ye0UtsnRZR8P+3cwO6hTvXL29oID5XqL/ZPGJO77iNBH4Rw0TYiJ4pFQcYM
	h26cwO54AxmbrMC7heprIGDXKLbjcMhOTCta08vi+OfJLh08j3SLy4zDMCjt2duJcFm1mHgNLAo
	8HRhaQifW/8Jx2VciRycVpTT8UWFU1C87j1MLOE0HWXsU=
X-Gm-Gg: AY/fxX5/aWluFJRvcjGhgh9zqQi40YpPecrdnVJx36UQalbjKm91/P4FTs6UX4Xy8RU
	F8XtUOUYxYRXWzUlZhlHbJdhECe59XW3MrGT8sym2PWXog0SZVLOLFV7ocy8b3H0uth3TNhhvQp
	nw4A42P5Z52R+TlLLZookZlsFm4MSkk/OK2MDa/xPSUDj2kbxRhADJA4jGX2+9I25TnYo=
X-Received: by 2002:a2e:84cb:0:b0:37a:3794:376 with SMTP id 38308e7fff4ca-37fb2067165mr20240881fa.33.1765467173416;
        Thu, 11 Dec 2025 07:32:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH9Ch+n9xP67LHWDxnICGWNFU0jYxugZlh/fl5qsPbWjvlTJ5GcS+1Tkn99F9aJ/8OzLtgfkpAMtzrhLDNJcK8=
X-Received: by 2002:a2e:84cb:0:b0:37a:3794:376 with SMTP id
 38308e7fff4ca-37fb2067165mr20240771fa.33.1765467172870; Thu, 11 Dec 2025
 07:32:52 -0800 (PST)
MIME-Version: 1.0
From: Yi Zhang <yi.zhang@redhat.com>
Date: Thu, 11 Dec 2025 23:32:38 +0800
X-Gm-Features: AQt7F2ryuljKTXFolfEtLQiedO1xP75RAJ-VCzBY7Vc9sHhehuXUrE8NtjuCB_8
Message-ID: <CAHj4cs94Z0LuhJybxbU2QOqY965A03nbQm2FdVYf0gRcF9LnXg@mail.gmail.com>
Subject: [bug report] WARNING: block/blk-mq.c:321 at blk_mq_unquiesce_queue+0x93/0xb0
 observed by blktests nvme/fc nvme/058
To: linux-block <linux-block@vger.kernel.org>, 
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, Jens Axboe <axboe@kernel.dk>, 
	Daniel Wagner <dwagner@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Np-MGFH0_wPkd719rjTg70x1_3w12xepM3NksYOGGvs_1765467174
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251211_073302_271562_D24F2C9F 
X-CRM114-Status: UNSURE (   8.75  )
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

Hi

I found this issue with the latest linux-block/for-next. Please help
check it and let me know if you need any information or tests for it.
Thank you.

commit d678712ead7318d5650158aa00113f63ccd4e210
Merge: 95ed689e9f30 a0750fae73c5
Author: Jens Axboe <axboe@kernel.dk>
Date:   Wed Dec 10 13:41:17 2025 -0700

    Merge branch 'block-6.19' into for-next

    * block-6.19:
      blk-mq-dma: always initialize dma state

[13367.070880] run blktests nvme/058 at 2025-12-11 09:44:09
[13368.291045] nvme nvme7: NVME-FC{0}: create association : host wwpn
0x20001100aa000001  rport wwpn 0x20001100ab000001: NQN
"nqn.2014-08.org.nvmexpress.discovery"
[13368.309331] nvmet_fc: {0:0}: Association created
[13368.314356] nvmet: Created discovery controller 1 for subsystem
nqn.2014-08.org.nvmexpress.discovery for NQN
nqn.2014-08.org.nvmexpress:uuid:4c4c4544-0047-5a10-804b-cac04f514a33.
[13368.333710] nvme nvme7: NVME-FC{0}: controller connect complete
--snip--
[13377.364142] nvme nvme10: identifiers changed for nsid 3
[13377.364180] nvme nvme10: identifiers changed for nsid 2
[13377.366018] nvme nvme10: NVME-FC{3}: resetting controller
[13377.413250] nvme nvme12: Found shared namespace 1, but multipathing
not supported.
[13377.421051] nvme nvme9: Found shared namespace 1, but multipathing
not supported.
[13377.429122] nvme nvme9: IDs don't match for shared namespace 2
[13377.435247] nvme nvme10: Found shared namespace 1, but multipathing
not supported.
[13377.438649] ------------[ cut here ]------------
[13377.442996] nvme nvme12: IDs don't match for shared namespace 2
[13377.443116] nvme nvme10: Identify namespace failed (880)
[13377.447459] WARNING: block/blk-mq.c:321 at
blk_mq_unquiesce_queue+0x93/0xb0, CPU#4: kworker/u65:40/103352
[13377.447479] Modules linked in: nvme_fcloop nvmet_fc
[13377.453458] nvme nvme11: IDs don't match for shared namespace 2
[13377.458724]  nvmet nvme_fc nvme_fabrics nvme nvme_core
[13377.468369] nvme nvme12: Found shared namespace 3, but multipathing
not supported.
[13377.473178]  ext4 crc16 mbcache jbd2 platform_profile dell_wmi
dell_smbios intel_rapl_msr amd_atl sparse_keymap intel_rapl_common
rfkill video amd64_edac edac_mce_amd dcdbas kvm_amd vfat fat kvm
irqbypass mgag200 rapl ipmi_ssif dell_wmi_descriptor i2c_algo_bit
wmi_bmof pcspkr acpi_cpufreq i2c_piix4 ptdma i2c_smbus k10temp
acpi_power_meter ipmi_si acpi_ipmi ipmi_devintf ipmi_msghandler sg
loop fuse xfs sd_mod ahci libahci nvme_keyring tg3 ghash_clmulni_intel
libata nvme_auth ccp hkdf mpt3sas raid_class scsi_transport_sas
sp5100_tco wmi sunrpc dm_mirror dm_region_hash dm_log dm_mod nfnetlink
[last unloaded: nvmet]
[13377.492397]  nvme9n4: unable to read partition table
[13377.501340]  nvme12n4: unable to read partition table
[13377.510005] nvme nvme12: rescanning namespaces.
[13377.514737]  nvme11n4: unable to read partition table
[13377.520897] nvme nvme11: rescanning namespaces.
[13377.546199] CPU: 4 UID: 0 PID: 103352 Comm: kworker/u65:40 Kdump:
loaded Tainted: G             L      6.18.0+ #1 PREEMPT(voluntary)
[13377.546213] Tainted: [L]=SOFTLOCKUP
[13377.546217] Hardware name: Dell Inc. PowerEdge R6515/07PXPY, BIOS
2.17.0 12/04/2024
[13377.546224] Workqueue: nvme-reset-wq nvme_fc_reset_ctrl_work [nvme_fc]
[13377.555677] nvme nvme9: rescanning namespaces.
[13377.605978] RIP: 0010:blk_mq_unquiesce_queue+0x93/0xb0
[13377.611131] Code: 01 48 89 de bf 09 00 00 00 e8 39 3c fc ff 48 89
ee 4c 89 e7 e8 ee 1a 9a 01 48 89 df be 01 00 00 00 5b 5d 41 5c e9 1d
fa ff ff <0f> 0b 5b 48 89 ee 4c 89 e7 5d 41 5c e9 cc 1a 9a 01 e8 e7 84
99 ff
[13377.629885] RSP: 0018:ffffc9000c03fab8 EFLAGS: 00010046
[13377.635118] RAX: 0000000000000000 RBX: ffff888202a83d50 RCX: 0000000000000001
[13377.642251] RDX: 0000000000000000 RSI: ffffffff91b66900 RDI: ffff888202a83e70
[13377.649386] RBP: 0000000000000246 R08: 0000000000000001 R09: fffff52001807f46
[13377.656525] R10: 0000000000000003 R11: 00000000000003ad R12: ffff888202a83e28
[13377.663657] R13: ffff888265a71440 R14: ffff888178198048 R15: ffff888265a71418
[13377.670791] FS:  0000000000000000(0000) GS:ffff888889ec4000(0000)
knlGS:0000000000000000
[13377.678884] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[13377.684631] CR2: 00007fffa12a5688 CR3: 0000000245fa0000 CR4: 0000000000350ef0
[13377.691772] Call Trace:
[13377.694226]  <TASK>
[13377.696343]  blk_mq_unquiesce_tagset+0xe1/0x1c0
[13377.700884]  nvme_fc_delete_association+0x4e9/0x700 [nvme_fc]
[13377.706658]  ? __pfx_nvme_fc_delete_association+0x10/0x10 [nvme_fc]
[13377.712936]  ? __pfx_enable_work+0x10/0x10
[13377.717043]  ? __pfx_autoremove_wake_function+0x10/0x10
[13377.722288]  nvme_fc_reset_ctrl_work+0x2e/0x110 [nvme_fc]
[13377.727707]  process_one_work+0xd8b/0x1320
[13377.731821]  ? __pfx_process_one_work+0x10/0x10
[13377.736361]  ? srso_return_thunk+0x5/0x5f
[13377.740387]  ? srso_return_thunk+0x5/0x5f
[13377.744402]  ? assign_work+0x16c/0x240
[13377.748157]  ? srso_return_thunk+0x5/0x5f
[13377.752191]  worker_thread+0x5f3/0xfe0
[13377.752209]  ? __pfx_worker_thread+0x10/0x10
[13377.760238]  kthread+0x3b4/0x770
[13377.763479]  ? __pfx_do_raw_spin_trylock+0x10/0x10
[13377.768279]  ? srso_return_thunk+0x5/0x5f
[13377.772328]  ? __pfx_kthread+0x10/0x10
[13377.776087]  ? lock_acquire+0x10b/0x140
[13377.781313]  ? calculate_sigpending+0x3d/0x90
[13377.787059]  ? srso_return_thunk+0x5/0x5f
[13377.792457]  ? rcu_is_watching+0x15/0xb0
[13377.797770]  ? srso_return_thunk+0x5/0x5f
[13377.803170]  ? __pfx_kthread+0x10/0x10
[13377.808313]  ret_from_fork+0x4ce/0x710
[13377.813452]  ? __pfx_ret_from_fork+0x10/0x10
[13377.818503]  ? srso_return_thunk+0x5/0x5f
[13377.822521]  ? __switch_to+0x528/0xf50
[13377.826284]  ? __switch_to_asm+0x39/0x70
[13377.830220]  ? __pfx_kthread+0x10/0x10
[13377.833982]  ret_from_fork_asm+0x1a/0x30
[13377.837931]  </TASK>
[13377.840123] irq event stamp: 0
[13377.843183] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
[13377.849457] hardirqs last disabled at (0): [<ffffffff8ecd5acb>]
copy_process+0x174b/0x5440
[13377.857725] softirqs last  enabled at (0): [<ffffffff8ecd5b23>]
copy_process+0x17a3/0x5440
[13377.865992] softirqs last disabled at (0): [<0000000000000000>] 0x0
[13377.872259] ---[ end trace 0000000000000000 ]---

-- 
Best Regards,
  Yi Zhang



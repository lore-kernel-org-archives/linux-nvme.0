Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 528A9C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Feb 2022 06:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:To:Subject:
	Message-ID:Date:From:MIME-Version:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=lzpzupneu+PyOELCBCeklYDAebOUBMWynAwABT94OUI=; b=FsEXQYwOukpKDJkZODGLyKvs0K
	lGhKhLJDo+Z5vk2XkK0GM4Xhl0tzCQrviLENxpv4xHzpjOBw5XIeWIh3IDnf0DRJopA6/FQTO4+lF
	aoNwV5V+krPzFBQDKwLxol2TQknQJgPBd5M7W7GL2MsKF/y2EgwOz8vEnBlPosMiPlF00uGS5pUCF
	MBj1rFMDgcE/mlOTFWP2r2hL268eSkYl2h2W8T9Fs6OcZ6JoCYHG4dU4x+XUE3A0npRZM0IekJa1Y
	PMy2clqQBILYKNguOv2WgzHK7oSp4cH/YuqE9aPD0mLHyZB5xFGkh8gHh5446zMfAu/0Ptiz7YGc0
	DosOvNNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nM20x-003duw-4C; Mon, 21 Feb 2022 06:17:39 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nM20P-003ddQ-5p
 for linux-nvme@lists.infradead.org; Mon, 21 Feb 2022 06:17:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1645424224;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type;
 bh=lzpzupneu+PyOELCBCeklYDAebOUBMWynAwABT94OUI=;
 b=JQFbp4Vlet+0mxvJESnif/Jd1ZF5IUGGYzdd3tO9UIIem8afGTxnXFgB5uT1yPG+neIr0W
 FTsab7Mx5Tdipd6aO2Fn5y8S3edi5rC6NHY98f6d44y7hZWRb215upx9X2dDfYlQ51DC5k
 IxLFHRwm9QBqTV3AIe9XjeKprpS5NXY=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-539-GcaHybAMPTC32EaIPXys2A-1; Mon, 21 Feb 2022 01:17:00 -0500
X-MC-Unique: GcaHybAMPTC32EaIPXys2A-1
Received: by mail-pl1-f199.google.com with SMTP id
 v14-20020a170902e8ce00b0014b48e8e498so4137006plg.2
 for <linux-nvme@lists.infradead.org>; Sun, 20 Feb 2022 22:17:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=lzpzupneu+PyOELCBCeklYDAebOUBMWynAwABT94OUI=;
 b=QIDSCMZqL8MRM2V1vSbTrzPk+2tQAlckgZUT0GO9OU0/uTUQFBcD8lSahX3EkU4Bnv
 rmkscvTfOJZ67Dy0ngKA5X7u2LemaIfLkopdOO7873TYKhzD2LcNgpi7eokn/dlgKtqp
 ASTsZZYOAXMceqsjnvFWwOjQfhw8chG+JLNRs8AEf9ciCZtdoq/zp81Qk2Z6ayLUtDJi
 HqLu05Im6cCzFgR4wmFVe42XD2ENMz+0/5Vtsg0C7mdbO5ifdK4gmeJZTDGlYqAAnHw2
 mp6ycCJAgnxz0dWN7izi5aZaYGVcMn5NpNjAxbUxVofVpznXPBR8pIjJoPRo2wHbzawJ
 KCaw==
X-Gm-Message-State: AOAM530haE/KhBruCdyCnXrzglUJCdj5w3F46s/BThxIBKGALDGYYQtd
 cgpELSYwRSUDnY2YlRVeAd0PiXEQqXFHD70/UILhpMcyBiG0Pwe2M3j4kTM6qF+BoSR1OTl49YM
 +cj2q9qERkb2VExEaFLLFMr63wsQoF7fTuMASs0VD8tM=
X-Received: by 2002:a63:f555:0:b0:373:9ad0:ca08 with SMTP id
 e21-20020a63f555000000b003739ad0ca08mr14960391pgk.315.1645424219211; 
 Sun, 20 Feb 2022 22:16:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyelIYMPR79BUIxK5ggcO9hePSQ6Fgqi5EfynIbREZ31uaILJh6wdhAPdga4Awn8LtLpDSoKTAuGXhzNMhbuyU=
X-Received: by 2002:a63:f555:0:b0:373:9ad0:ca08 with SMTP id
 e21-20020a63f555000000b003739ad0ca08mr14960379pgk.315.1645424218939; Sun, 20
 Feb 2022 22:16:58 -0800 (PST)
MIME-Version: 1.0
From: Yi Zhang <yi.zhang@redhat.com>
Date: Mon, 21 Feb 2022 14:16:47 +0800
Message-ID: <CAHj4cs_=1bFXGe+dqf0os0nvMwSnVtMJ3aZ12EAydcXGNSwo6w@mail.gmail.com>
Subject: [bug report] NVMe/IB: WARNING at kernel/dma/debug.c:571
 add_dma_entry+0x36a/0x4c0 observed on host side after connect
To: "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>, 
 RDMA mailing list <linux-rdma@vger.kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=yizhan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220220_221705_354738_B48FD91C 
X-CRM114-Status: UNSURE (   7.11  )
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

Hello
The below WARNING was triggered on the host side after a connection on
5.17.0-rc3, here is the full log, let me if you need any tests for it,
thanks

HW:
# lspci | grep -i mel
04:00.0 Infiniband controller: Mellanox Technologies MT27700 Family [ConnectX-4]
04:00.1 Infiniband controller: Mellanox Technologies MT27700 Family [ConnectX-4]

dmesg:
[  507.229417] ------------[ cut here ]------------
[  507.235233] DMA-API: mlx5_core 0000:04:00.0: cacheline tracking
EEXIST, overlapping mappings aren't supported
[  507.246475] WARNING: CPU: 10 PID: 855 at kernel/dma/debug.c:571
add_dma_entry+0x36a/0x4c0
[  507.255751] Modules linked in: nvme_rdma nvme_fabrics nvme_core
8021q garp mrp bonding bridge stp llc rfkill rpcrdma sunrpc rdma_ucm
ib_srpt ib_isert iscsi_target_mod target_core_mod ib_iser libiscsi
ib_umad scsi_transport_iscsi rdma_cm ib_ipoib iw_cm ib_cm
intel_rapl_msr intel_rapl_common sb_edac x86_pkg_temp_thermal
intel_powerclamp coretemp kvm_intel kvm mlx5_ib iTCO_wdt
iTCO_vendor_support irqbypass ib_uverbs crct10dif_pclmul crc32_pclmul
ib_core ghash_clmulni_intel rapl intel_cstate intel_uncore pcspkr
lpc_ich mei_me mxm_wmi ipmi_ssif mei ipmi_si ipmi_devintf
ipmi_msghandler acpi_power_meter xfs libcrc32c mgag200 i2c_algo_bit
drm_shmem_helper sd_mod drm_kms_helper t10_pi sg syscopyarea
sysfillrect sysimgblt fb_sys_fops mlx5_core drm ahci mlxfw libahci
crc32c_intel pci_hyperv_intf tls tg3 libata psample wmi dm_mirror
dm_region_hash dm_log dm_mod
[  507.341004] CPU: 10 PID: 855 Comm: kworker/u80:3 Tainted: G S
         5.17.0-rc3.rc3.debug #3
[  507.351351] Hardware name: Dell Inc. PowerEdge R430/03XKDV, BIOS
2.9.1 12/07/2018
[  507.361252] Workqueue: ib_addr process_one_req [ib_core]
[  507.368756] RIP: 0010:add_dma_entry+0x36a/0x4c0
[  507.375291] Code: 01 00 00 4c 8b 6d 50 4d 85 ed 0f 84 9d 00 00 00
48 89 ef e8 18 e5 0e 01 48 89 c6 4c 89 ea 48 c7 c7 80 a0 8c 8d e8 a6
d6 da 01 <0f> 0b 48 85 db 0f 85 20 c9 dc 01 8b 05 75 56 24 04 85 c0 0f
85 c2
[  507.399392] RSP: 0018:ffff8890b6aaf7a0 EFLAGS: 00010282
[  507.406756] RAX: 0000000000000000 RBX: ffff8885d1d6e600 RCX: 0000000000000000
[  507.416302] RDX: 0000000000000001 RSI: ffffffff8da92ac0 RDI: ffffffff90ff9880
[  507.425860] RBP: ffff8882580640d0 R08: ffffed11854bfb39 R09: ffffed11854bfb39
[  507.435450] R10: ffff888c2a5fd9c7 R11: ffffed11854bfb38 R12: 1ffff11216d55ef6
[  507.445054] R13: ffff889086697b20 R14: 00000000ffffffef R15: 0000000000000202
[  507.454683] FS:  0000000000000000(0000) GS:ffff888c2a400000(0000)
knlGS:0000000000000000
[  507.465423] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  507.473553] CR2: 00007f080b8fe000 CR3: 00000017fd62c001 CR4: 00000000001706e0
[  507.483282] Call Trace:
[  507.487748]  <TASK>
[  507.491829]  ? dma_debug_init+0x130/0x130
[  507.498064]  ? debug_dma_map_page+0x278/0x320
[  507.504722]  dma_map_page_attrs+0x3bb/0xa90
[  507.511191]  ? dma_need_sync+0x100/0x100
[  507.517369]  ? kmem_cache_alloc_trace+0x13b/0x220
[  507.524457]  nvme_rdma_create_queue_ib+0x8a6/0x12c0 [nvme_rdma]
[  507.532949]  ? nvme_rdma_reconnect_ctrl_work+0x60/0x60 [nvme_rdma]
[  507.541744]  ? rdma_restrack_add+0xfb/0x4a0 [ib_core]
[  507.549302]  ? rcu_read_lock_sched_held+0xaf/0xe0
[  507.556469]  nvme_rdma_cm_handler+0x71e/0xa20 [nvme_rdma]
[  507.564436]  ? nvme_rdma_create_queue_ib+0x12c0/0x12c0 [nvme_rdma]
[  507.573293]  ? lock_release+0x42f/0xc90
[  507.579540]  ? lock_downgrade+0x6b0/0x6b0
[  507.585978]  ? lock_is_held_type+0xd9/0x130
[  507.592632]  ? rcu_read_lock_sched_held+0xaf/0xe0
[  507.599879]  ? rcu_read_lock_bh_held+0xc0/0xc0
[  507.606842]  ? lock_is_held_type+0xd9/0x130
[  507.613510]  cma_cm_event_handler+0xf2/0x530 [rdma_cm]
[  507.621292]  addr_handler+0x189/0x2a0 [rdma_cm]
[  507.628405]  ? cma_work_handler+0x220/0x220 [rdma_cm]
[  507.636179]  ? cma_work_handler+0x220/0x220 [rdma_cm]
[  507.643834]  process_one_req+0xdd/0x590 [ib_core]
[  507.651094]  process_one_work+0x97e/0x1700
[  507.657607]  ? pwq_dec_nr_in_flight+0x270/0x270
[  507.664571]  worker_thread+0x87/0xb30
[  507.670501]  ? process_one_work+0x1700/0x1700
[  507.677145]  kthread+0x29d/0x340
[  507.682465]  ? kthread_complete_and_exit+0x20/0x20
[  507.689503]  ret_from_fork+0x22/0x30
[  507.695143]  </TASK>
[  507.699133] irq event stamp: 473271
[  507.704543] hardirqs last  enabled at (473281):
[<ffffffff8b39a9b2>] __up_console_sem+0x52/0x60
[  507.715840] hardirqs last disabled at (473290):
[<ffffffff8b39a997>] __up_console_sem+0x37/0x60
[  507.727102] softirqs last  enabled at (473218):
[<ffffffff8d60064a>] __do_softirq+0x64a/0xa4c
[  507.738185] softirqs last disabled at (473309):
[<ffffffff8b21561e>] irq_exit_rcu+0x1ce/0x240
[  507.749206] ---[ end trace 0000000000000000 ]---
[  507.755780] DMA-API: Mapped at:
[  507.760660]  debug_dma_map_page+0x86/0x320
[  507.766603]  dma_map_page_attrs+0x3bb/0xa90
[  507.772628]  nvme_rdma_create_queue_ib+0x8a6/0x12c0 [nvme_rdma]
[  507.780613]  nvme_rdma_cm_handler+0x71e/0xa20 [nvme_rdma]
[  507.788009]  cma_cm_event_handler+0xf2/0x530 [rdma_cm]
[  508.648545] mlx5_ib0.8008: multicast join failed for
ff12:401b:8008:0000:0000:0000:ffff:ffff, status -22
[  509.655833] nvme nvme0: creating 40 I/O queues.
[  509.672625] mlx5_ib0.8016: multicast join failed for
ff12:401b:8016:0000:0000:0000:ffff:ffff, status -22
[  511.267023] DMA-API: dma_debug_entry pool grown to 2162688 (3300%)
[  520.572519] DMA-API: dma_debug_entry pool grown to 2228224 (3400%)
[  523.451478] nvme nvme0: mapped 40/0/0 default/read/poll queues.
[  523.631836] nvme nvme0: new ctrl: NQN "testnqn", addr 172.31.0.202:4420


-- 
Best Regards,
  Yi Zhang



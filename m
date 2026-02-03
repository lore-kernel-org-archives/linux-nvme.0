Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF5C1E87822
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Feb 2026 12:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:MIME-Version:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=b3v7qXh8dLHy2074F6XoVLXkWVS0VD/XNrXmappg4PE=; b=sEACWDrEsZoFQ85b8BstfpnNrO
	W8sVeKdNWvFcv79dlYG4mruGCVbmE+eCUhcrTyTdGLldANaapktoIVZT7UYsnFkLsgs7n080iwkvE
	SUVIZZ9TdaJv2gBqCo7QOucJJErKpAuJ5/AfyvOs/BvuFwCljYD402YkfL7IcK6LJ/zh9r+/o3Emn
	NHFOv2ZI7Yzahn1GLooRfsoKOZMM8H3uXInBgLozVG1aFKEnrW55rECf1r6dZLNsBAtUczPmSBEq/
	fNqAD14MK841Ip0DAPS2lbmHqxEVsKo4TtvSGkX7uVJh7wOVzD6z3QHr8lo45y0w1NHoOYTfJROai
	heK2ukVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnFWy-00000006bDI-0xbR;
	Tue, 03 Feb 2026 12:29:20 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnFWw-00000006bCu-1Oex
	for linux-nvme@lists.infradead.org;
	Tue, 03 Feb 2026 12:29:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770121756;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=b3v7qXh8dLHy2074F6XoVLXkWVS0VD/XNrXmappg4PE=;
	b=N8O8ekfB02EWQ/rHrU/zQkYNfnHMYoFgtzVqRameYv7Mu1Ge26fzo/8DI11vhK70FUS3cU
	IX7CPKcz8WBfI38rGUQTABfJLnuah/PNmqujjxZW3dLqgDao0i3YbkFlK5Cls5qgXAJqen
	i9Zoqzfl9uHCywWivNGHE9oaCSldG04=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-101-DmFT-weoO760nIucyajKXw-1; Tue, 03 Feb 2026 07:29:12 -0500
X-MC-Unique: DmFT-weoO760nIucyajKXw-1
X-Mimecast-MFC-AGG-ID: DmFT-weoO760nIucyajKXw_1770121751
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-385fed5fa78so35047611fa.1
        for <linux-nvme@lists.infradead.org>; Tue, 03 Feb 2026 04:29:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770121751; x=1770726551;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b3v7qXh8dLHy2074F6XoVLXkWVS0VD/XNrXmappg4PE=;
        b=bwqLDjxb5ShmhEAvoTWfbnPrs5qzXoahiYjhwSGXG6Sa9U2cOMT/mVNvvCznDG+OuB
         EZUkSPKlUWaXEytR+VwQFz/GQ0cxMYlIyG6Zafo02iPcGerE547x/dJ+BZzYM1G75pNN
         zwsG0qJ2q140qFKQ90Dpdn08NBX5kQoQmY84lMriVVwSBI1JzyLoEXxRJizZKJqjXwO5
         OUNgxfT7OWff1ZT+LABfKlC6dYQ4B6fKu2A+8wPgCopUbcd4nCH9ABMFksN0CmYgB8bw
         rN6EAxrlCVEG/Eu4FYxMGO+oK2wuBSwOE9YIGCRKh4+YMlVgABAlBSZBzgUoyKtJWorA
         p+og==
X-Forwarded-Encrypted: i=1; AJvYcCVB/YFsXkTvUjaG1LL5vZNnY76CSgj4pgeZey5BQyNZ8A0rJLPvGx57vPB0uvvOBACXG8KUG+8ZZSxP@lists.infradead.org
X-Gm-Message-State: AOJu0YzvJKpse0H81RRdmglnwtTI3i3gqOdUlk+MKi2NH+obrPyYZrk8
	76a8Hv2vEkh1BzrAEjS2iu7yPsAeRg+5lrZ3Tz1PNkpNc7PsO9TFrBB/tSk2Q+Ou6kkWEkAgtGx
	7v8OW1PiuYVpplNM2GjP0e7uzqpUHp81Q9g33Hd3k/KFaFRzd+YpLx6lk2OjyeW9cHglzPRBn81
	GlaADjARLsMWsOe+QHdxu8/KuLtH8TqxjJBQCEN1IKoSw=
X-Gm-Gg: AZuq6aK/wqMyOhwLTjmE/Bh5zZCW1Le9tZUo9cbbcNwl9qezQSVUz8rLaH4rkjLCcfv
	iAGjt85rZ2BVb4uwctyhx+ZrAfS/lsyDxtUGrCfU6Cvg3ORweivY0FaRLbqGtQm+u5gV544KAMa
	lImi0AJz+C3lRJYPRyExnqlRjA/on7r2IV8ScaRE7x04zySD8OVUZF5+9yuvWep2YGwD0=
X-Received: by 2002:a05:651c:154e:b0:378:e079:ecdb with SMTP id 38308e7fff4ca-386466b463dmr55460191fa.32.1770121751158;
        Tue, 03 Feb 2026 04:29:11 -0800 (PST)
X-Received: by 2002:a05:651c:154e:b0:378:e079:ecdb with SMTP id
 38308e7fff4ca-386466b463dmr55460081fa.32.1770121750707; Tue, 03 Feb 2026
 04:29:10 -0800 (PST)
MIME-Version: 1.0
From: Yi Zhang <yi.zhang@redhat.com>
Date: Tue, 3 Feb 2026 20:28:56 +0800
X-Gm-Features: AZwV_QishAydBM0xNeTvJarIZYponRgq3_h2ExgRtRiuicXD-M3bXOXa5lsvzyI
Message-ID: <CAHj4cs9gNKEYAPagD9JADfO5UH+OiCr4P7OO2wjpfOYeM-RV=A@mail.gmail.com>
Subject: [bug report] WARNING: block/blk-mq-debugfs.c:620 at
 debugfs_create_files.isra.0+0x54/0x60, CPU#220: kworker/u1036:7/70421
To: linux-block <linux-block@vger.kernel.org>, 
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, Ming Lei <ming.lei@redhat.com>, yukuai@fnnas.com, 
	Jens Axboe <axboe@kernel.dk>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Vq9onwMU1UUARDybsENjltuqo1Y_vSoMe2mgJNSCfZM_1770121751
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260203_042918_442431_6D421638 
X-CRM114-Status: UNSURE (   8.31  )
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

CKI reported the following failure today. Seems it was introduced from
the recently blk-mq-debugfs update, please help check and let me know
if you need any testing/info.

Reproducer: blktests nvme/tcp nvme/005
Commit message: Merge branch 'for-7.0/block' into for-next

dmesg:
[  951.319384] run blktests nvme/005 at 2026-02-02 17:59:35
[  951.346116] loop0: detected capacity change from 0 to 2097152
[  951.356428] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[  951.370823] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
[  951.397438] nvmet: Created nvm controller 1 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[  951.412081] nvme nvme0: creating 128 I/O queues.
[  951.425914] nvme nvme0: mapped 128/0/0 default/read/poll queues.
[  951.467027] nvme nvme0: new ctrl: NQN "blktests-subsystem-1", addr
127.0.0.1:4420, hostnqn:
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
[  951.784608] nvmet: Created nvm controller 2 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[  951.798920] nvme nvme0: creating 128 I/O queues.
[  951.871600] nvme nvme0: mapped 128/0/0 default/read/poll queues.
[  951.880680] ------------[ cut here ]------------
[  951.885309] WARNING: block/blk-mq-debugfs.c:620 at
debugfs_create_files.isra.0+0x54/0x60, CPU#220: kworker/u1036:7/70421
[  951.896190] Modules linked in: nvmet_tcp nvmet nvme_tcp
nvme_fabrics nvme nvme_core nvme_keyring nvme_auth rtrs_core rdma_cm
iw_cm ib_cm hkdf nbd loop mlx5_ib ib_uverbs macsec sunrpc ib_core
mlx5_fwctl fwctl rfkill vfat fat amd_atl intel_rapl_msr
intel_rapl_common amd64_edac edac_mce_amd jc42 kvm_amd ee1004 joydev
wmi_bmof mlx5_core kvm irqbypass mlxfw rapl psample tls ptdma ipmi_si
ipmi_devintf pcspkr ipmi_msghandler acpi_cpufreq i2c_piix4 k10temp
i2c_smbus fuse nfnetlink zram lz4hc_compress lz4_compress xfs ast
i2c_algo_bit ghash_clmulni_intel wmi sp5100_tco i2c_dev [last
unloaded: nvmet]
[  951.948577] CPU: 220 UID: 0 PID: 70421 Comm: kworker/u1036:7 Not
tainted 6.19.0-rc7 #1 PREEMPT(lazy)
[  951.957814] Hardware name: AMD Corporation DAYTONA_X/DAYTONA_X,
BIOS RYM100GA 01/13/2025
[  951.965941] Workqueue: nvme-reset-wq nvme_reset_ctrl_work [nvme_tcp]
[  951.972321] RIP: 0010:debugfs_create_files.isra.0+0x54/0x60
[  951.977911] Code: 48 89 d9 4d 89 e0 48 89 ea 49 c7 c1 20 20 73 9a
48 83 c3 28 e8 bd 57 d9 ff 48 8b 3b 48 85 ff 75 db 5b 5d 41 5c e9 f7
b6 51 ff <0f> 0b eb be 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90
90 90
[  951.996673] RSP: 0018:ffffd137f8ee3c90 EFLAGS: 00010202
[  952.001919] RAX: ffff8e3a49aa6c00 RBX: ffffffff9a731e00 RCX: ffffffff9a731e00
[  952.009070] RDX: ffff8e3a831ab000 RSI: ffff8e3a49aa6c00 RDI: 0000000000000001
[  952.016227] RBP: ffff8e3a49aa6c00 R08: 0000000000000064 R09: 0000000000000000
[  952.023396] R10: ffff8e3a1c6a2540 R11: 0000000000000000 R12: ffff8e3a831ab000
[  952.030607] R13: ffff8e3a64c03620 R14: ffffd137f8ee3d38 R15: ffff8e3a8c43e400
[  952.037815] FS:  0000000000000000(0000) GS:ffff8e5601f7b000(0000)
knlGS:0000000000000000
[  952.045946] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  952.051708] CR2: 00007f310853ef58 CR3: 00000037aac2e003 CR4: 0000000000f70ef0
[  952.058856] PKRU: 55555554
[  952.061579] Call Trace:
[  952.064048]  <TASK>
[  952.066159]  blk_mq_debugfs_register_hctx+0x97/0x150
[  952.071136]  ? srso_alias_return_thunk+0x5/0xfbef5
[  952.075945]  blk_mq_debugfs_register_hctxs+0x4e/0x70
[  952.080924]  __blk_mq_update_nr_hw_queues+0x218/0x390
[  952.085991]  blk_mq_update_nr_hw_queues+0x39/0x50
[  952.090714]  nvme_tcp_configure_io_queues.cold+0x1ac/0x35e [nvme_tcp]
[  952.097175]  nvme_tcp_setup_ctrl+0xab/0x250 [nvme_tcp]
[  952.102327]  ? nvme_change_ctrl_state+0x135/0x1b0 [nvme_core]
[  952.108090]  nvme_reset_ctrl_work+0x9a/0xd0 [nvme_tcp]
[  952.113246]  process_one_work+0x18d/0x340
[  952.117266]  worker_thread+0x256/0x3a0
[  952.121030]  ? __pfx_worker_thread+0x10/0x10
[  952.125320]  kthread+0xfc/0x240
[  952.128481]  ? __pfx_kthread+0x10/0x10
[  952.132245]  ? __pfx_kthread+0x10/0x10
[  952.136009]  ret_from_fork+0x126/0x190
[  952.139773]  ? __pfx_kthread+0x10/0x10
[  952.143539]  ret_from_fork_asm+0x1a/0x30
[  952.147484]  </TASK>
[  952.149687] ---[ end trace 0000000000000000 ]---
[  952.167930] nvme nvme0: Removing ctrl: NQN "blktests-subsystem-1"
[  952.195424] block nvme0n1: no available path - failing I/O
[  952.200938] block nvme0n1: no available path - failing I/O
[  952.206483] buffer_io_error: 439 callbacks suppressed
[  952.206486] Buffer I/O error on dev nvme0n1, logical block 262142,
async page read



-- 
Best Regards,
  Yi Zhang



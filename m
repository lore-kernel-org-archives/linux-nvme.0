Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A93A10F6FC5
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Apr 2026 15:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dLVMAKqyGscpMd3RaTb0PTlAAEY6ecJ8SdxwSVZ0340=; b=E/TlQxNyW7D84SldsJ9dnN6ykv
	Xsq2qFJ+L2IODjl+qGYKrQEuIy6Xl651Dc61OuxI7FD1NWw7FKplrHOeAnu9Qv/zkLOPpYlTFrZGW
	rq2M+s1eSFyADub+u946eQXI80vG/cU0otLrpn7UmDo+x0UHJgR89hUm8jEAac6Ckh86EzYgcg23+
	3nhBaGLaHNWI274o2q/nxSKVtlyF86HbSTtfqUsC6XzHpBXWX2heuykHXOtCtlUvf6+B4tNnItmge
	AztTA0tlnjtH7LbmAnnY0eE+uL0BJfnJgHAufNMK/6DZ3Hpsw3G4LSoMlWQCJpZ7Lo928pApSc/9W
	DvFlVwzw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7x5B-0000000FYxm-3ZGl;
	Wed, 01 Apr 2026 15:02:13 +0000
Received: from iad-out-014.esa.us-east-1.outbound.mail-perimeter.amazon.com ([50.16.246.183])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7vkm-0000000FKNJ-45IE;
	Wed, 01 Apr 2026 13:37:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1775050625; x=1806586625;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:mime-version:content-transfer-encoding;
  bh=dLVMAKqyGscpMd3RaTb0PTlAAEY6ecJ8SdxwSVZ0340=;
  b=r3hBrcdRUAcA3XntsoW+jFiZZD8c1smXgyUcu+OGU6qkvE/z8nfc5FUH
   62yfxGHaelKVLCMgCT4BrBNJVTWSNApuBPCxNp0HEsYK/Y0G4LWi7QOCp
   di3Rzv0E3FxC5k0ftay7IUcE9Fa2A9PIXBhBcd335OeV5+i1SREs+JT/3
   5+F4uEM3zy8iELU0FtcHl71KI+QxMU17KhBFTi2F62lVfFsT8LGKI9VsO
   glcuvcaU+NhoeA/ooB8inyXveXxNAec7O1Pj+QQF6pwrlArLmBpHF1P3V
   qyhS9j8PIxHvJFQXeKp3TyZLmxv8UMfwQRDlSe58tOe7cPSNl3ev35zcO
   Q==;
X-CSE-ConnectionGUID: nkfwnKAOR2a89Vp4yTuwNw==
X-CSE-MsgGUID: NKaMDt+ATpqEH+/8F8yegA==
X-IronPort-AV: E=Sophos;i="6.23,153,1770595200"; 
   d="scan'208";a="14739828"
Received: from ip-10-4-13-79.ec2.internal (HELO smtpout.naws.us-east-1.prod.farcaster.email.amazon.dev) ([10.4.13.79])
  by internal-iad-out-014.esa.us-east-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 13:36:59 +0000
Received: from EX19MTAUEC001.ant.amazon.com [52.94.133.134:10610]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.95.220:2525] with esmtp (Farcaster)
 id 442ca74e-e7fa-4a65-a99e-8452b83b2313; Wed, 1 Apr 2026 13:36:59 +0000 (UTC)
X-Farcaster-Flow-ID: 442ca74e-e7fa-4a65-a99e-8452b83b2313
Received: from EX19D012UEC004.ant.amazon.com (10.252.135.219) by
 EX19MTAUEC001.ant.amazon.com (10.252.135.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Wed, 1 Apr 2026 13:36:57 +0000
Received: from EX19D012UEC003.ant.amazon.com (10.252.135.160) by
 EX19D012UEC004.ant.amazon.com (10.252.135.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Wed, 1 Apr 2026 13:36:56 +0000
Received: from EX19D012UEC003.ant.amazon.com ([fe80::67ea:859:1e17:25a9]) by
 EX19D012UEC003.ant.amazon.com ([fe80::67ea:859:1e17:25a9%3]) with mapi id
 15.02.2562.037; Wed, 1 Apr 2026 13:36:56 +0000
From: "Heyne, Maximilian" <mheyne@amazon.de>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: "Heyne, Maximilian" <mheyne@amazon.de>, Jens Axboe <axboe@kernel.dk>,
	Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>, "Alyssa
 Rosenzweig" <alyssa@rosenzweig.io>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, "James E.J.
 Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen"
	<martin.petersen@oracle.com>, Alim Akhtar <alim.akhtar@samsung.com>, "Avri
 Altman" <avri.altman@wdc.com>, Bart Van Assche <bvanassche@acm.org>, "Sasha
 Levin" <sashal@kernel.org>, Peter Wang <peter.wang@mediatek.com>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, Wonkon Kim
	<wkon.kim@samsung.com>, Seunghwan Baek <sh8267.baek@samsung.com>, "Adrian
 Hunter" <adrian.hunter@intel.com>, Bean Huo <beanhuo@micron.com>, Brian Kao
	<powenkao@google.com>, Seunghui Lee <sh043.lee@samsung.com>, Sanjeev Yadav
	<sanjeev.y@mediatek.com>, Hannes Reinecke <hare@suse.de>, Ming Lei
	<ming.lei@redhat.com>, Chaitanya Kulkarni <kch@nvidia.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"asahi@lists.linux.dev" <asahi@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "linux-scsi@vger.kernel.org"
	<linux-scsi@vger.kernel.org>
Subject: [PATCH 6.1.y 1/8] Revert "nvme: fix admin request_queue lifetime"
Thread-Topic: [PATCH 6.1.y 1/8] Revert "nvme: fix admin request_queue
 lifetime"
Thread-Index: AQHcwdybH4188GigBECVKFyE1IXyog==
Date: Wed, 1 Apr 2026 13:36:56 +0000
Message-ID: <20260401-figure-weird-3a1932c2@mheyne-amazon>
References: <20260401-defer-gleam-5226cb65@mheyne-amazon>
In-Reply-To: <20260401-defer-gleam-5226cb65@mheyne-amazon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.13.235.223]
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260401_063705_270320_FC5B4744 
X-CRM114-Status: GOOD (  13.93  )
X-Mailman-Approved-At: Wed, 01 Apr 2026 08:02:12 -0700
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

This reverts commit ff037b5f47eeccc1636c03f84cd47db094eb73c9.

The backport of upstream commit 03b3bcd319b3 ("nvme: fix admin
request_queue lifetime") to 6.1 is broken in 2 ways. First of all it
doesn't actually fix the issue because blk_put_queue will still be
called as part of blk_mq_destroy_queue in nvme_remove_admin_tag_set
leading to the UAF.
Second, the backport leads to a refcount underflow when unbinding a pci
nvme device:

 refcount_t: underflow; use-after-free.
 WARNING: CPU: 2 PID: 1486 at lib/refcount.c:28 refcount_warn_saturate+0xba=
/0x110
 Modules linked in: bochs drm_vram_helper simpledrm skx_edac_common drm_shm=
em_helper drm_kms_helper kvm_intel cfbfillrect syscopyarea cfbimgblt sysfil=
lrect sysimgblt fb_sys_fops cfbcopyarea drm_ttm_helper fb ttm kvm fbdev drm=
 mousedev nls_ascii psmouse irqbypass nls_cp437 atkbd crc32_pclmul crc32c_i=
ntel libps2 vfat fat sunrpc virtio_net ata_piix vivaldi_fmap drm_panel_orie=
ntation_quirks libata backlight i2c_piix4 net_failover i8042 ghash_clmulni_=
intel failover serio i2c_core button sch_fq_codel
 CPU: 2 PID: 1486 Comm: bash Not tainted 6.1.167 #2
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS edk2-20240813-=
306.amzn2 08/13/2024
 RIP: 0010:refcount_warn_saturate+0xba/0x110
 Code: 01 01 e8 89 79 ad ff 0f 0b e9 82 f4 7e 00 80 3d 73 03 cc 01 00 75 85=
 48 c7 c7 e0 5d 3b 8e c6 05 63 03 cc 01 01 e8 66 79 ad ff <0f> 0b c3 cc cc =
cc cc 80 3d 4e 03 cc 01 00 0f 85 5e ff ff ff 48 c7
 RSP: 0018:ffffd0cc011bfd18 EFLAGS: 00010286
 RAX: 0000000000000000 RBX: ffff8ada07b33210 RCX: 0000000000000027
 RDX: ffff8adb37d1f728 RSI: 0000000000000001 RDI: ffff8adb37d1f720
 RBP: ffff8ada07b33000 R08: 0000000000000000 R09: 00000000fffeffff
 R10: ffffd0cc011bfba8 R11: ffffffff8f1781a8 R12: ffffd0cc011bfd38
 R13: ffff8ada03080800 R14: ffff8ada07b33210 R15: ffff8ada07b33b10
 FS:  00007f50f6964740(0000) GS:ffff8adb37d00000(0000) knlGS:00000000000000=
00
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 000055cdb54e6ae0 CR3: 000000010224e001 CR4: 0000000000770ee0
 DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
 PKRU: 55555554
 Call Trace:
  <TASK>
  nvme_pci_free_ctrl+0x45/0x80
  nvme_free_ctrl+0x1aa/0x2b0
  device_release+0x34/0x90
  kobject_cleanup+0x3a/0x130
  pci_device_remove+0x3e/0xb0
  device_release_driver_internal+0x1aa/0x230
  unbind_store+0x11f/0x130
  kernfs_fop_write_iter+0x13a/0x1d0
  vfs_write+0x2a6/0x3b0
  ksys_write+0x5f/0xe0
  do_syscall_64+0x35/0x80
  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
 RIP: 0033:0x7f50f66ff897
 Code: 0f 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 1e fa=
 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff =
ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
 RSP: 002b:00007fffaef903d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
 RAX: ffffffffffffffda RBX: 00007f50f67fd780 RCX: 00007f50f66ff897
 RDX: 000000000000000d RSI: 0000557f72ef6b90 RDI: 0000000000000001
 RBP: 000000000000000d R08: 0000000000000000 R09: 00007f50f67b2d20
 R10: 00007f50f67b2c20 R11: 0000000000000246 R12: 000000000000000d
 R13: 0000557f72ef6b90 R14: 000000000000000d R15: 00007f50f67f89c0
  </TASK>

The reason for this is that nvme_free_ctrl calls ->free_ctrl which
resolves to nvme_pci_free_ctrl in aforementioned case which also has a
blk_put_queue, so the admin queue is put twice. This is because on 6.1
we're missing the commit 96ef1be53663 ("nvme-pci: put the admin queue in
nvme_dev_remove_admin").

Signed-off-by: Maximilian Heyne <mheyne@amazon.de>
---
 drivers/nvme/host/core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 9df33b293ee3e..938af571dc13e 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -5180,8 +5180,6 @@ static void nvme_free_ctrl(struct device *dev)
 		container_of(dev, struct nvme_ctrl, ctrl_device);
 	struct nvme_subsystem *subsys =3D ctrl->subsys;
 =

-	if (ctrl->admin_q)
-		blk_put_queue(ctrl->admin_q);
 	if (!subsys || ctrl->instance !=3D subsys->instance)
 		ida_free(&nvme_instance_ida, ctrl->instance);
 =

-- =

2.50.1




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christof Hellmis, Andreas Stieger
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597



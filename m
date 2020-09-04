Return-Path: <SRS0=O63G=CN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74217C43461
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Sep 2020 02:40:35 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B1BF2075D
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Sep 2020 02:40:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="onKoR+ip";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="jeOjPC+I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B1BF2075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=zuSG9YpGca6Q+sG/DJ2puFjozntNsoru6OUdqJs/P20=; b=onKoR+ipg9FKTYxe2gJ53Zglu
	Hi9PoFpsh1T3lUzZKoLwWBqlw1lYpHXnWoYn0W+dpXkN1DZZFs2VZJDR4eSBKlg94sn1upqaedFPV
	DE/CoW4pZnX/BDBjIKNq3lAIyC9DsdJHAQ19gcjnfW85CzVGcDEQFCquAX4qS0j0aVeo3Lz7yJO+b
	AxIf10+O3/irXD1yHLvc0liEDiJiceBtZxOQ+ZHLujCygPEB9aWXz3VrH1ojJyFqkIfcsibg3tv+5
	SkkmoNpZr6Ocgr7Xny/9Rguc+gRKFM9iHz6ZSGtolohRkVNKFrWNqwSjZbf1K/mImlZYz+vFifV8D
	FYFJi9nkQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kE1eT-000601-FP; Fri, 04 Sep 2020 02:40:33 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kE1eQ-0005zL-PV
 for linux-nvme@lists.infradead.org; Fri, 04 Sep 2020 02:40:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1599187230; x=1630723230;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=poKBW6VYRJKv+pnndTYEQAqcmTYQsUfo/cGTNLLybRA=;
 b=jeOjPC+I+qiToMa1lMcU+Hq5UcfJSQXcpC3XpDvRdTb7YMGHpZvopUmz
 SRYF3ec9ENHULVra34VJt5Foyj2NKPKr4d+b5EzXEPMW1UHC8Pzl1EpVN
 195oFn6FsgszZWns6cv+o3aj3f6Sc+aYR48Qgj2FprSlvqAF5FOJS3ZPX
 GQ/1zI5EKAbKdocCGQCem3bBeMTSLaxAkaprt4X9eJMPIaVGljmreqCOY
 M05j6C5VW6ADfaVAWaKsiHzo3JgvB4uj1yobzPTwL7ty0zKtFTcCsHshU
 E4Iaiw+z9ajaNPRyq6wJ/68wZ52DtZ3Ie1U24oKKevqD8scpkJI4DECyc Q==;
IronPort-SDR: Jff6/npHAXqvsFN6h2IR5N4n2kHCFss4IGH/X5/gMqwFlXdtKrnMubPouy3sDMu4Fh3luY6d64
 R1Qtt8nHNxUYYAi/UtM/awgZNM9GMXxgzSra/h9X4y3qqnm67F/eEEk0mQ5gVpBtm14ZxsfmRn
 WUve/WsKlt7wQhOjfiF4MbASHqke9+XYiG50O+cXM2T4G1nhsoaIj33QuhjgRhVvLz36Mo+n8b
 wzjYw53WZFPkY1bNgXryRlpHkwt7ovhvHbGzu0Vy/zbNsoXpzWloJXAmSn5U80+TLSmM8+/TnG
 HAw=
X-IronPort-AV: E=Sophos;i="5.76,387,1592841600"; d="scan'208";a="146476427"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 04 Sep 2020 10:40:30 +0800
IronPort-SDR: KUgTJ1SPUEMWnsSmg0v0mZGd2IYchEe5SlxuaVUKj+yAXX1GCv32KD6TdfZXEoHVMPABhb8Shy
 sK8BC5pW0EcQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2020 19:27:54 -0700
IronPort-SDR: OskQ1wCGQJUWl1xo4ET7tXD3wLe6Uur1sRPS2IDKf0uJ7CegZmQrNjUNSOH26DeDA1yz89Br7e
 dLzrkA0FnXLQ==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 03 Sep 2020 19:40:29 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 3/3] nvme-core: fix nvme module ref count Oops
Date: Thu,  3 Sep 2020 19:39:29 -0700
Message-Id: <20200904023929.5320-4-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20200904023929.5320-1-chaitanya.kulkarni@wdc.com>
References: <20200904023929.5320-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200903_224030_961808_8A09C553 
X-CRM114-Status: GOOD (  12.97  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: kbusch@kernel.org, logang@deltatee.com, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

In the passthru controller enable path current code doesn't take the
reference to the passthru ctrl module. Which produces following Oops :-

Entering kdb (current=0xffff8887f8290000, pid 3128) on processor 30 Oops: (null)
due to oops @ 0xffffffffa01019ad
CPU: 30 PID: 3128 Comm: bash Tainted: G        W  OE     5.8.0-rc4nvme-5.9+ #35
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.4
RIP: 0010:nvme_free_ctrl+0x234/0x285 [nvme_core]
Code: 57 10 a0 e8 73 bf 02 e1 ba 3d 11 00 00 48 c7 c6 98 33 10 a0 48 c7 c7 1d 57 10 a0 e8 5b bf 02 e1 8
RSP: 0018:ffffc90001d63de0 EFLAGS: 00010246
RAX: ffffffffa05c0440 RBX: ffff8888119e45a0 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffff8888177e9550 RDI: ffff8888119e43b0
RBP: ffff8887d4768000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: ffffc90001d63c90 R12: ffff8888119e43b0
R13: ffff8888119e5108 R14: dead000000000100 R15: ffff8888119e5108
FS:  00007f1ef27b0740(0000) GS:ffff888817600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffa05c0470 CR3: 00000007f6bee000 CR4: 00000000003406e0
Call Trace:
 device_release+0x27/0x80
 kobject_put+0x98/0x170
 nvmet_passthru_ctrl_disable+0x4a/0x70 [nvmet]
 nvmet_passthru_enable_store+0x4c/0x90 [nvmet]
 configfs_write_file+0xe6/0x150
 vfs_write+0xba/0x1e0
 ksys_write+0x5f/0xe0
 do_syscall_64+0x52/0xb0
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7f1ef1eb2840
Code: Bad RIP value.
RSP: 002b:00007fffdbff0eb8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f1ef1eb2840
RDX: 0000000000000002 RSI: 00007f1ef27d2000 RDI: 0000000000000001
RBP: 00007f1ef27d2000 R08: 000000000000000a R09: 00007f1ef27b0740
R10: 0000000000000001 R11: 0000000000000246 R12: 00007f1ef2186400
R13: 0000000000000002 R14: 0000000000000001 R15: 0000000000000000

We fix that by taking a module ref count in nvme_dev_open() and release
that ref count in nvme_dev_release() atomically with ctrl get/put
respectively.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/host/core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index a1707afcb710..8445293c74e3 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3263,6 +3263,12 @@ static int nvme_dev_open(struct inode *inode, struct file *file)
 
 	file->private_data = ctrl;
 	nvme_get_ctrl(ctrl);
+	if (!try_module_get(ctrl->ops->module)) {
+		pr_err("try_module_get failed for cntlid 0x%x\n", ctrl->cntlid);
+		nvme_put_ctrl(ctrl);
+		return -EINVAL;
+	}
+
 	return 0;
 }
 
@@ -3271,6 +3277,7 @@ static int nvme_dev_release(struct inode *inode, struct file *file)
 	struct nvme_ctrl *ctrl =
 		container_of(inode->i_cdev, struct nvme_ctrl, cdev);
 
+	module_put(ctrl->ops->module);
 	nvme_put_ctrl(ctrl);
 	return 0;
 }
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

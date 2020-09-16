Return-Path: <SRS0=FbzM=CZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67C23C433E2
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Sep 2020 03:53:46 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08212221E3
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Sep 2020 03:53:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="meai3vNg";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Ixd5tKyV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08212221E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=fy1Qpp/xdiyg4fuHbsXUP32xP1DzzpK6F/DaqSkXcGk=; b=meai3vNgl4qz99JCxrFS8BwAW
	+/zA9+CCZX8KI5F86q2WxiEziwmDCMJio1MBDTQzRxlCBPiLgNu1pzfXjvOnaloUpOvN+a6WAIQZd
	Ar5BNDGVFuAy/Vjz/fnGeWLhlw+bY8xLZisXEn2p5szf3t7lMUsrozNehd9+IvXSJRZ3SeXd9WQ4i
	u2sQTOcNArEv+Dy4W6cHMyMV6Wh2kOSDrMkOaS9jIjW76F96QMq3MDVF4xzIdnUBx5AnboctyoBWi
	dJ5helgdWa+xNWmK2OjxWj+qJMw5RMPaw735sNvTDgD1bbGHrJW2Pa1fNifiBF4Sf3sURZo3SWkeW
	2iPOKsNfQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kIOVp-0003B8-VZ; Wed, 16 Sep 2020 03:53:42 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kIOVf-00035l-A6
 for linux-nvme@lists.infradead.org; Wed, 16 Sep 2020 03:53:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1600228412; x=1631764412;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=aZrOMA3Mx0b8ugPsRxU+61Ts73ySYDXrgXM8bJPJT38=;
 b=Ixd5tKyV/ohyMLOIon+jg6USN0da8lnCLiPhvZKRzIWo2hbP0A1wde0Q
 JbbvtwWIDIoAYldmlUH9k008OCoKiQ253Me5jdhEnM2VPUcy+cltEQpJ9
 QGLQ6BRBO/fxgKxKwxggDrPOFaZHNepIRYobF/+YsxnpoURTNl9tmuiLv
 zFDARY9Tn1mWmYmGne2KzFjyr0gBYTMi6xd3aOFQALvzEWpu8p60WXdsp
 v3bd2QkZSoJlIoguUWvmTvy5StpXkWzl2xGsBk55Y3/G92eV5TDALB7Vi
 7Mg//fao1TPWlWtFNVxusmGxB3FTigqMiAUpxKcRyljYL90GlG5qXMBFM A==;
IronPort-SDR: J4u3KVHSYg/onmgdJ4N6Wp0wJUNRK2+4a3De9f4LaIJnyykfm/27USyqxI4pF9Xd/TogimIryb
 7N0coP98rfpb8Vd+kDKGGnrgubt4IvC0KF9qsOlOMCtvci10qLWtY/AAa96Ba9Nw6jUu0sI2I+
 owLt5FUX+J21luqRW3azvE7OZXY23Og6V6fX3BYRHPKC4ftKlU6hN/+wfw5AkBXoJo/3hQkmGJ
 tfq5SH/rhYXWDxtfpx0elat12BNsKVUN1qZtnXL68FoEgQVABtEw9eo7Gw6QsPaiKkxh/zUlgm
 1SI=
X-IronPort-AV: E=Sophos;i="5.76,431,1592841600"; d="scan'208";a="148717382"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 16 Sep 2020 11:53:30 +0800
IronPort-SDR: h9qMbKvKs2ktlmMu948uKnzks+29FOcM/eVVOYt1cfJDAqYKaSQtYfAImMwDumH8pbltx5+muQ
 VSvPaPGHhpwA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2020 20:39:45 -0700
IronPort-SDR: YlJALDV+AuMTgLC5sqlemjFlm6vBSGZpKvjSeyHzJbwwFn8pgU/lQenlGahxEgg7zpANnupzbp
 O/jZa8r59yOA==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 15 Sep 2020 20:53:29 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V2 1/2] nvme-core: fix nvme module ref count Oops
Date: Tue, 15 Sep 2020 20:53:25 -0700
Message-Id: <20200916035326.9229-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20200916035326.9229-1-chaitanya.kulkarni@wdc.com>
References: <20200916035326.9229-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200915_235331_477080_9A57EE9E 
X-CRM114-Status: GOOD (  16.13  )
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
Cc: kbusch@kernel.org, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Introduce car dev relase function, get/put the module refernece which
allows us to fix the potential Oops which can be easily reproduced with
NVMeOF passthru ctrl :-

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

With this patch fix we take the module ref count in nvme_dev_open() and
release that ref count in newly introduced nvme_dev_release().

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/host/core.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 8b75f6ca0b61..c5f9d64b2bec 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3261,10 +3261,22 @@ static int nvme_dev_open(struct inode *inode, struct file *file)
 		return -EWOULDBLOCK;
 	}
 
+	if (!try_module_get(ctrl->ops->module))
+		return -EINVAL;
+
 	file->private_data = ctrl;
 	return 0;
 }
 
+static int nvme_dev_release(struct inode *inode, struct file *file)
+{
+	struct nvme_ctrl *ctrl =
+		container_of(inode->i_cdev, struct nvme_ctrl, cdev);
+
+	module_put(ctrl->ops->module);
+	return 0;
+}
+
 static int nvme_dev_user_cmd(struct nvme_ctrl *ctrl, void __user *argp)
 {
 	struct nvme_ns *ns;
@@ -3327,6 +3339,7 @@ static long nvme_dev_ioctl(struct file *file, unsigned int cmd,
 static const struct file_operations nvme_dev_fops = {
 	.owner		= THIS_MODULE,
 	.open		= nvme_dev_open,
+	.release	= nvme_dev_release,
 	.unlocked_ioctl	= nvme_dev_ioctl,
 	.compat_ioctl	= compat_ptr_ioctl,
 };
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

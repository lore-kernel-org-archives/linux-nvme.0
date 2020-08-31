Return-Path: <SRS0=W+Vz=CJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B34ACC433E6
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Aug 2020 22:28:08 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A7F8207EA
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Aug 2020 22:28:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ekvJ4I46";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Czj0nvbE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A7F8207EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=OtF/6+6df+SywN9htiFCdW05mrDwsFUGzva25LMIMcE=; b=ekvJ4I4636YiG3M4pKbtWehCf
	LDf/MEZX+NP1Lo4nQ4XEDQFUhoHGFLQJUTcamP0bl0v1EkMIlXNhxqvHmtfLxQv9VIOCHyp8g/V38
	3ot+NR/O0bJkYpQkQrvxu516rH72IJDYa4aCtz0HSTIBH+AB4IARPvJSwIV7knBbOkBshbKGHMHm/
	z73WCK9jBpP+MJ/Z1/pil3l4zpwUJIz8OYrSkDTH2k/FhdCiOISdkonKBBRNe+SoR9Nm/B4hzt7mS
	lVdHA76lx70XEbPJmM61TGCS0TYmQdGGIvjBzbpdhea7PHZtxgUQRdx0cCaSkVT88jTcdy5Wv8uT8
	wAPKiy7iA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kCsHT-0005kD-IJ; Mon, 31 Aug 2020 22:28:03 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kCsHG-0005Vg-F1
 for linux-nvme@lists.infradead.org; Mon, 31 Aug 2020 22:27:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1598912870; x=1630448870;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=OEd8sUpSpho++4GEt0gz3n8iqiLiEQYC8WoB0vy9SnM=;
 b=Czj0nvbEFzRtEG6LUPh0gNEErDSx1LlUeKw6vZa4L0uyM0Uq8tJUjGSV
 kOqbZ5kmL0MH+cYO7xrn0OoNJ2QoR+6ZYPecgTWkpqj3RZOk6SYTpt4cs
 50HjCJ+JFHzOYmRPeq27u/7kQ/JhKcgGoKOsugIK4e5EudxepSXt84OOU
 BkGU3hqUezQSTv7Qy7uuF879n9MA5dzOePzBEdgJd8OtGS5BG9jeGfxKH
 YxTl04NAjjluJa5hUdgtwZBH5VzXpr45cQrT07I8JYT/ZPv2fFU/UsMV5
 1CWrs4HVL6RLAELZGRTXrThaN5wkqHxUX2Ve7kgzYefwcKRc9Zk9OPv3G Q==;
IronPort-SDR: DxvK7xmV7qxNFd2LGLkBqZox/eMMbiw2o3CYw8j/s8jqThHE+rFlcZaDR5Hdey3VZZmfUtH3O2
 iQzVo9aPenpPyFo20x8BnKNU2JKFJ3nD5osqtwCD65Qv2WSh562sfgCvnKSdCcqHP8P2ZLxgy0
 iQ7bTdKMfzVoCv/4PvcT6eyRRXj1LfEWtpsptd4wapgj3AFrzrBZ/g9stsXe5apt9IqOeyEiUP
 zr3Ml+OiYRDbKOjs8QlSH+FCkcU3n3UrDo4AEt6UygHRgXHFH8UMBzHAe1CQ/xvPLX7mAUXUDJ
 MaA=
X-IronPort-AV: E=Sophos;i="5.76,376,1592841600"; d="scan'208";a="147482866"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 01 Sep 2020 06:27:50 +0800
IronPort-SDR: hE2dFRGX392EUxfoontmS4ccIKN1J3sqDKwSAOi+SEzkSjV+Uv48VsfvW5KFM57Rj/8ikH6Ct7
 0nalPRq9SKtQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2020 15:15:18 -0700
IronPort-SDR: 8bWbVUTmcEIgBCJvGrYhVXJxWpxZxArmEcNEIOkMMxdgzaIE+VTyNNRSSKFbKYHe/diCwQqXCz
 oMfoH2raYNvQ==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 31 Aug 2020 15:27:50 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V2 09/12] nvmet: fix nvme module ref count Oops
Date: Mon, 31 Aug 2020 15:27:04 -0700
Message-Id: <20200831222707.35611-10-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20200831222707.35611-1-chaitanya.kulkarni@wdc.com>
References: <20200831222707.35611-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200831_182750_799061_B148CF22 
X-CRM114-Status: GOOD (  14.92  )
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
that ref count in nvme_dev_release().

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/host/core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f82c6a283b15..c940f49a30bf 100644
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

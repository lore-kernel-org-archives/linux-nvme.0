Return-Path: <SRS0=JVDK=LI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08DA8C48BE6
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Jun 2021 03:21:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 926E36137D
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Jun 2021 03:21:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 926E36137D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=AaDBVNO9kuSnYfEad8C3/LGzfzgt5pwVcv4ZpynVql0=; b=30VR5ode5pNAWi
	CVwe/yDeVEe9vFZehxd40M0vW3AgX6KYSkF563rmvV7FDZudtEfqDoRYhvfNtRuMraoZ+kFCkRLV4
	65wh45eWb4Irv21x5AdMcjuhuHBpAMo1SaMnFmerf3LDt1DqzniHicUZQolUp229eEd7OBIoNmrgG
	MPtppNKytfEJAhBR/vMkFk+UhXG9lJy739tM5lEb51gkCohAxCeD6ew9I7+8VWoVskXNmJkRhcPhv
	QIE4Y4hdxVNJbdG6xbk0CZV0WMTIyXyqgMxd5rBL8tHumsMKXeJRRACWQj53rThk7AZwJ/Veoe9xw
	lfMgTkprwiI8hsnjNjew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lsd9g-00CD9E-KP; Mon, 14 Jun 2021 03:20:52 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lsd9c-00CD89-ST
 for linux-nvme@lists.infradead.org; Mon, 14 Jun 2021 03:20:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1623640846; x=1655176846;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=gZranR3JAQP+6aIdG/y9hGe7po44/CgYNINArlofjkA=;
 b=D8q+C0SBN/BAQ3kiuC3ORuqxXpGvFaWQ826ICtugEd/2/54WHl497e+N
 UK+YA+mpouoMFnrbB1GkCvx2gqALzvFDCB6NoReSzc9QC/LQ7spGjedtV
 Bvd4uo8rQLjwg7LtpnAa2ol+Ct0lax3PDXAvolJ5027WWKb5gi31cw5OL
 ANyTZuHYaF6IRl7V4RVdewoZlT+6S6NzRHtEyhTSWaoOYbDuhoVeaZc0B
 i34HiFSsTQ9Jlh5LPkY5DZq7jVYT0mVy0frb/i9uJqh8GhyMSXg1PFr8+
 1mlim/wSDl6ibdO5WRYF29eX7T3mKV0a/JKakg29BHP6SCWAUZf2xBR4r g==;
IronPort-SDR: RFtJsLLZGP3RvTT5EF0wZA+/1a59ukpL0xSyejosgmk3Crkov+/lieL1XYy42oqxbdfpsoYSHI
 7CmcI8kq+l0FdaCRMhWMAxf7dZPIJVYYuJEvpTOGijvZr/po070SAK3agv3xYyJeTcBO6p/4ws
 Fr9fIp8t4LFjLwSBym+2tLWtRccaAklQdJ5ZcS6ODROCX/KYeK4wj4KVrwK2bVHe8KBtKUn3aw
 F+qeNQiMvh9/+p6lG9DnUCfy2q9wcD8BFe8Plud8SG6ZNkm8XkQQo8+r2dzDJW9TWw4el7Zicj
 nfA=
X-IronPort-AV: E=Sophos;i="5.83,272,1616428800"; d="scan'208";a="176570222"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 14 Jun 2021 11:20:45 +0800
IronPort-SDR: ZVGKxg/ipe50w9LRjfGIdYODAzeOoUaLGKI98zoV5kkA9YywCKJ/9ofCOJIWugwZDbfVXDktBa
 nx+SnOg4vTeD3z4pOPlwn9LYLdBLgcuXK4+YB8Mg7S/6cJWfC0pMwdfZFuH8Q4bcbWYGJh6uMr
 /lP8YELUUkLpxDgaRkq7U7ZBKBXtgu6gRP5bKCmJnzXeuWlIgV1TzcAvpM+cjvsm5/nk3Tyc6n
 IWoVMBrh9SpJTxM61dm+C8Np1jTT5okmXIIXiowTHfJw5pVMcCIaLxGAxe4jA+EVH/kIL7x3rD
 IIZvm2haY3L+347h4eABdgiX
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jun 2021 19:59:44 -0700
IronPort-SDR: MT2B+imHDTnRkqs3kYxjUyRuBMSzoKJwWUnXTGhboy9aEjdVhg+Nr5o4icUgSGwCutqEGdCuhO
 bZLUpiga//6Ajne1rrKJvxte/m+eAE1Rft3MmxJ2EVTT5FVA4i2GIB4WM76FTiYldIVyLGiImd
 iO5pZfNJ0x0Bh1oOMVHk/ksPoHfqfOxIQRuLF7h9+R8bZCX/cHTe6jp7TKhgcIZY1sr1OqYje1
 eq9QCIUfP5yMJ+2oWOuCwCutpi16/jQdjguAYPdG/1fiNfhVDHhamoTTl2xk/rbtEST36Fu5Cl
 elQ=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 13 Jun 2021 20:20:46 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH] nvme: move pr code into separate file
Date: Sun, 13 Jun 2021 20:20:46 -0700
Message-Id: <20210614032046.18678-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210613_202048_983234_802FCC45 
X-CRM114-Status: GOOD (  19.78  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/host/Makefile |   2 +-
 drivers/nvme/host/core.c   | 121 -----------------------------------
 drivers/nvme/host/nvme.h   |   2 +
 drivers/nvme/host/pr.c     | 126 +++++++++++++++++++++++++++++++++++++
 4 files changed, 129 insertions(+), 122 deletions(-)
 create mode 100644 drivers/nvme/host/pr.c

diff --git a/drivers/nvme/host/Makefile b/drivers/nvme/host/Makefile
index cbc509784b2e..8771f27fb49a 100644
--- a/drivers/nvme/host/Makefile
+++ b/drivers/nvme/host/Makefile
@@ -9,7 +9,7 @@ obj-$(CONFIG_NVME_RDMA)			+= nvme-rdma.o
 obj-$(CONFIG_NVME_FC)			+= nvme-fc.o
 obj-$(CONFIG_NVME_TCP)			+= nvme-tcp.o
 
-nvme-core-y				:= core.o ioctl.o
+nvme-core-y				:= core.o ioctl.o pr.o
 nvme-core-$(CONFIG_TRACING)		+= trace.o
 nvme-core-$(CONFIG_NVME_MULTIPATH)	+= multipath.o
 nvme-core-$(CONFIG_NVM)			+= lightnvm.o
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index cb1a76a3d42a..6eedb78ca9ab 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -16,11 +16,9 @@
 #include <linux/list_sort.h>
 #include <linux/slab.h>
 #include <linux/types.h>
-#include <linux/pr.h>
 #include <linux/ptrace.h>
 #include <linux/nvme_ioctl.h>
 #include <linux/pm_qos.h>
-#include <asm/unaligned.h>
 
 #include "nvme.h"
 #include "fabrics.h"
@@ -1921,125 +1919,6 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_id_ns *id)
 	return ret;
 }
 
-static char nvme_pr_type(enum pr_type type)
-{
-	switch (type) {
-	case PR_WRITE_EXCLUSIVE:
-		return 1;
-	case PR_EXCLUSIVE_ACCESS:
-		return 2;
-	case PR_WRITE_EXCLUSIVE_REG_ONLY:
-		return 3;
-	case PR_EXCLUSIVE_ACCESS_REG_ONLY:
-		return 4;
-	case PR_WRITE_EXCLUSIVE_ALL_REGS:
-		return 5;
-	case PR_EXCLUSIVE_ACCESS_ALL_REGS:
-		return 6;
-	default:
-		return 0;
-	}
-};
-
-static int nvme_send_ns_head_pr_command(struct block_device *bdev,
-		struct nvme_command *c, u8 data[16])
-{
-	struct nvme_ns_head *head = bdev->bd_disk->private_data;
-	int srcu_idx = srcu_read_lock(&head->srcu);
-	struct nvme_ns *ns = nvme_find_path(head);
-	int ret = -EWOULDBLOCK;
-
-	if (ns) {
-		c->common.nsid = cpu_to_le32(ns->head->ns_id);
-		ret = nvme_submit_sync_cmd(ns->queue, c, data, 16);
-	}
-	srcu_read_unlock(&head->srcu, srcu_idx);
-	return ret;
-}
-	
-static int nvme_send_ns_pr_command(struct nvme_ns *ns, struct nvme_command *c,
-		u8 data[16])
-{
-	c->common.nsid = cpu_to_le32(ns->head->ns_id);
-	return nvme_submit_sync_cmd(ns->queue, c, data, 16);
-}
-
-static int nvme_pr_command(struct block_device *bdev, u32 cdw10,
-				u64 key, u64 sa_key, u8 op)
-{
-	struct nvme_command c;
-	u8 data[16] = { 0, };
-
-	put_unaligned_le64(key, &data[0]);
-	put_unaligned_le64(sa_key, &data[8]);
-
-	memset(&c, 0, sizeof(c));
-	c.common.opcode = op;
-	c.common.cdw10 = cpu_to_le32(cdw10);
-
-	if (IS_ENABLED(CONFIG_NVME_MULTIPATH) &&
-	    bdev->bd_disk->fops == &nvme_ns_head_ops)
-		return nvme_send_ns_head_pr_command(bdev, &c, data);
-	return nvme_send_ns_pr_command(bdev->bd_disk->private_data, &c, data);
-}
-
-static int nvme_pr_register(struct block_device *bdev, u64 old,
-		u64 new, unsigned flags)
-{
-	u32 cdw10;
-
-	if (flags & ~PR_FL_IGNORE_KEY)
-		return -EOPNOTSUPP;
-
-	cdw10 = old ? 2 : 0;
-	cdw10 |= (flags & PR_FL_IGNORE_KEY) ? 1 << 3 : 0;
-	cdw10 |= (1 << 30) | (1 << 31); /* PTPL=1 */
-	return nvme_pr_command(bdev, cdw10, old, new, nvme_cmd_resv_register);
-}
-
-static int nvme_pr_reserve(struct block_device *bdev, u64 key,
-		enum pr_type type, unsigned flags)
-{
-	u32 cdw10;
-
-	if (flags & ~PR_FL_IGNORE_KEY)
-		return -EOPNOTSUPP;
-
-	cdw10 = nvme_pr_type(type) << 8;
-	cdw10 |= ((flags & PR_FL_IGNORE_KEY) ? 1 << 3 : 0);
-	return nvme_pr_command(bdev, cdw10, key, 0, nvme_cmd_resv_acquire);
-}
-
-static int nvme_pr_preempt(struct block_device *bdev, u64 old, u64 new,
-		enum pr_type type, bool abort)
-{
-	u32 cdw10 = nvme_pr_type(type) << 8 | (abort ? 2 : 1);
-
-	return nvme_pr_command(bdev, cdw10, old, new, nvme_cmd_resv_acquire);
-}
-
-static int nvme_pr_clear(struct block_device *bdev, u64 key)
-{
-	u32 cdw10 = 1 | (key ? 1 << 3 : 0);
-
-	return nvme_pr_command(bdev, cdw10, key, 0, nvme_cmd_resv_register);
-}
-
-static int nvme_pr_release(struct block_device *bdev, u64 key, enum pr_type type)
-{
-	u32 cdw10 = nvme_pr_type(type) << 8 | (key ? 1 << 3 : 0);
-
-	return nvme_pr_command(bdev, cdw10, key, 0, nvme_cmd_resv_release);
-}
-
-const struct pr_ops nvme_pr_ops = {
-	.pr_register	= nvme_pr_register,
-	.pr_reserve	= nvme_pr_reserve,
-	.pr_release	= nvme_pr_release,
-	.pr_preempt	= nvme_pr_preempt,
-	.pr_clear	= nvme_pr_clear,
-};
-
 #ifdef CONFIG_BLK_SED_OPAL
 int nvme_sec_submit(void *data, u16 spsp, u8 secp, void *buffer, size_t len,
 		bool send)
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 1f397ecba16c..db90b57c4336 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -53,6 +53,8 @@ enum {
 	NVME_NS_LIGHTNVM	= 1,
 };
 
+extern const struct pr_ops nvme_pr_ops;
+
 /*
  * List of workarounds for devices that required behavior not specified in
  * the standard.
diff --git a/drivers/nvme/host/pr.c b/drivers/nvme/host/pr.c
new file mode 100644
index 000000000000..64a3c84d3ef4
--- /dev/null
+++ b/drivers/nvme/host/pr.c
@@ -0,0 +1,126 @@
+#include <linux/blkdev.h>
+#include <linux/pr.h>
+#include <asm/unaligned.h>
+
+#include "nvme.h"
+#include "fabrics.h"
+
+static char nvme_pr_type(enum pr_type type)
+{
+	switch (type) {
+	case PR_WRITE_EXCLUSIVE:
+		return 1;
+	case PR_EXCLUSIVE_ACCESS:
+		return 2;
+	case PR_WRITE_EXCLUSIVE_REG_ONLY:
+		return 3;
+	case PR_EXCLUSIVE_ACCESS_REG_ONLY:
+		return 4;
+	case PR_WRITE_EXCLUSIVE_ALL_REGS:
+		return 5;
+	case PR_EXCLUSIVE_ACCESS_ALL_REGS:
+		return 6;
+	default:
+		return 0;
+	}
+}
+
+static int nvme_send_ns_head_pr_command(struct block_device *bdev,
+		struct nvme_command *c, u8 data[16])
+{
+	struct nvme_ns_head *head = bdev->bd_disk->private_data;
+	int srcu_idx = srcu_read_lock(&head->srcu);
+	struct nvme_ns *ns = nvme_find_path(head);
+	int ret = -EWOULDBLOCK;
+
+	if (ns) {
+		c->common.nsid = cpu_to_le32(ns->head->ns_id);
+		ret = nvme_submit_sync_cmd(ns->queue, c, data, 16);
+	}
+	srcu_read_unlock(&head->srcu, srcu_idx);
+	return ret;
+}
+	
+static int nvme_send_ns_pr_command(struct nvme_ns *ns, struct nvme_command *c,
+		u8 data[16])
+{
+	c->common.nsid = cpu_to_le32(ns->head->ns_id);
+	return nvme_submit_sync_cmd(ns->queue, c, data, 16);
+}
+
+static int nvme_pr_command(struct block_device *bdev, u32 cdw10,
+				u64 key, u64 sa_key, u8 op)
+{
+	struct nvme_command c;
+	u8 data[16] = { 0, };
+
+	put_unaligned_le64(key, &data[0]);
+	put_unaligned_le64(sa_key, &data[8]);
+
+	memset(&c, 0, sizeof(c));
+	c.common.opcode = op;
+	c.common.cdw10 = cpu_to_le32(cdw10);
+
+	if (IS_ENABLED(CONFIG_NVME_MULTIPATH) &&
+	    bdev->bd_disk->fops == &nvme_ns_head_ops)
+		return nvme_send_ns_head_pr_command(bdev, &c, data);
+	return nvme_send_ns_pr_command(bdev->bd_disk->private_data, &c, data);
+}
+
+static int nvme_pr_register(struct block_device *bdev, u64 old,
+		u64 new, unsigned flags)
+{
+	u32 cdw10;
+
+	if (flags & ~PR_FL_IGNORE_KEY)
+		return -EOPNOTSUPP;
+
+	cdw10 = old ? 2 : 0;
+	cdw10 |= (flags & PR_FL_IGNORE_KEY) ? 1 << 3 : 0;
+	cdw10 |= (1 << 30) | (1 << 31); /* PTPL=1 */
+	return nvme_pr_command(bdev, cdw10, old, new, nvme_cmd_resv_register);
+}
+
+static int nvme_pr_reserve(struct block_device *bdev, u64 key,
+		enum pr_type type, unsigned flags)
+{
+	u32 cdw10;
+
+	if (flags & ~PR_FL_IGNORE_KEY)
+		return -EOPNOTSUPP;
+
+	cdw10 = nvme_pr_type(type) << 8;
+	cdw10 |= ((flags & PR_FL_IGNORE_KEY) ? 1 << 3 : 0);
+	return nvme_pr_command(bdev, cdw10, key, 0, nvme_cmd_resv_acquire);
+}
+
+static int nvme_pr_preempt(struct block_device *bdev, u64 old, u64 new,
+		enum pr_type type, bool abort)
+{
+	u32 cdw10 = nvme_pr_type(type) << 8 | (abort ? 2 : 1);
+
+	return nvme_pr_command(bdev, cdw10, old, new, nvme_cmd_resv_acquire);
+}
+
+static int nvme_pr_clear(struct block_device *bdev, u64 key)
+{
+	u32 cdw10 = 1 | (key ? 1 << 3 : 0);
+
+	return nvme_pr_command(bdev, cdw10, key, 0, nvme_cmd_resv_register);
+}
+
+static int nvme_pr_release(struct block_device *bdev, u64 key, enum pr_type type)
+{
+	u32 cdw10 = nvme_pr_type(type) << 8 | (key ? 1 << 3 : 0);
+
+	return nvme_pr_command(bdev, cdw10, key, 0, nvme_cmd_resv_release);
+}
+
+const struct pr_ops nvme_pr_ops = {
+	.pr_register	= nvme_pr_register,
+	.pr_reserve	= nvme_pr_reserve,
+	.pr_release	= nvme_pr_release,
+	.pr_preempt	= nvme_pr_preempt,
+	.pr_clear	= nvme_pr_clear,
+};
+
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86D5ED6206A
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Nov 2024 10:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Z/inj4cpn/saktglTxIrSmDpk/W78fzSrg+68LncMZE=; b=uQPJMLEbXqAkSVUnkzZEWxrleX
	ZhNGKsD3K9NpTphS+mwYlJw9HOzXlVuDcMeuxmIPP4XXpo5yd6I15pp3wFgC5y2l/V5E8mkAPEUM/
	O2A4GJJZzcL14GlHj9jJxUwtXHuG6e767wHtY9rYX4f/Qcz+voVL67DIFwnMs6KOVn/AO8pk8dl5V
	x1rXO/3W9MeYdFVr9JarwqH9jPY1JM53A65FaDw0BJnzHI3HEsug58dW3dPtRCBmCpgzSM75ok9q6
	kNawByF7iyjbNRaES007weYMZ3mqvOExvAPrN1GViixXEoGzg9VCyrFvipMT1tLniTeG5eHDDwGdA
	fQiwAkjw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tDLZt-0000000C4os-2KxL;
	Tue, 19 Nov 2024 10:35:25 +0000
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tDLUJ-0000000C3jC-3tiI
	for linux-nvme@lists.infradead.org;
	Tue, 19 Nov 2024 10:29:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1732012176; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=Z/inj4cpn/saktglTxIrSmDpk/W78fzSrg+68LncMZE=;
	b=KvGWsF04a/DzVXXcN5INszlqURk4S4okNymhjOiPg3xj6g29hDXQkYY+uUY88lzY05bZILuX5ikB/haNSOgOnfkX7IcAY7ygHScXmMp8oVo87nrzF/HkEtImQtoOA9Jic7ohF3/OzlhEdlz/wOaIoY4OzWLLfszzoWabOcGyFs4=
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WJo467Q_1732012165 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 19 Nov 2024 18:29:31 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH] nvme: tuning pr code by using defined structs and macros
Date: Tue, 19 Nov 2024 18:29:25 +0800
Message-ID: <20241119102925.128435-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241119_022940_611893_CC1509A8 
X-CRM114-Status: GOOD (  13.65  )
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

All the modifications are simply to make the code more readable,
and this patch does not include any functional changes.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/nvme/host/pr.c | 125 +++++++++++++++++++++++++----------------
 1 file changed, 78 insertions(+), 47 deletions(-)

diff --git a/drivers/nvme/host/pr.c b/drivers/nvme/host/pr.c
index dc7922f22600..3fd292badd42 100644
--- a/drivers/nvme/host/pr.c
+++ b/drivers/nvme/host/pr.c
@@ -9,6 +9,9 @@
 
 #include "nvme.h"
 
+#define NVME_PR_SET_PTPL_TO_PERSIST ((1 << 30) | (1 << 31))
+#define NVME_PR_IGNORE_KEY (1 << 3)
+
 static enum nvme_pr_type nvme_pr_type_from_blk(enum pr_type type)
 {
 	switch (type) {
@@ -94,109 +97,137 @@ static int nvme_status_to_pr_err(int status)
 	}
 }
 
-static int nvme_send_pr_command(struct block_device *bdev,
-		struct nvme_command *c, void *data, unsigned int data_len)
+static int __nvme_send_pr_command(struct block_device *bdev, u32 cdw10,
+		u32 cdw11, u8 op, void *data, unsigned int data_len)
 {
-	if (nvme_disk_is_ns_head(bdev->bd_disk))
-		return nvme_send_ns_head_pr_command(bdev, c, data, data_len);
+	struct nvme_command c = { 0 };
 
-	return nvme_send_ns_pr_command(bdev->bd_disk->private_data, c, data,
-				       data_len);
+	c.common.opcode = op;
+	c.common.cdw10 = cpu_to_le32(cdw10);
+	c.common.cdw11 = cpu_to_le32(cdw11);
+
+	if (nvme_disk_is_ns_head(bdev->bd_disk))
+		return nvme_send_ns_head_pr_command(bdev, &c, data, data_len);
+	return nvme_send_ns_pr_command(bdev->bd_disk->private_data, &c,
+				data, data_len);
 }
 
-static int nvme_pr_command(struct block_device *bdev, u32 cdw10,
-				u64 key, u64 sa_key, u8 op)
+static int nvme_send_pr_command(struct block_device *bdev, u32 cdw10, u32 cdw11,
+		u8 op, void *data, unsigned int data_len)
 {
-	struct nvme_command c = { };
-	u8 data[16] = { 0, };
 	int ret;
 
-	put_unaligned_le64(key, &data[0]);
-	put_unaligned_le64(sa_key, &data[8]);
-
-	c.common.opcode = op;
-	c.common.cdw10 = cpu_to_le32(cdw10);
-
-	ret = nvme_send_pr_command(bdev, &c, data, sizeof(data));
-	if (ret < 0)
-		return ret;
-
-	return nvme_status_to_pr_err(ret);
+	ret = __nvme_send_pr_command(bdev, cdw10, cdw11, op, data, data_len);
+	return ret < 0 ? ret : nvme_status_to_pr_err(ret);
 }
 
-static int nvme_pr_register(struct block_device *bdev, u64 old,
-		u64 new, unsigned flags)
+static int nvme_pr_register(struct block_device *bdev, u64 old_key, u64 new_key,
+		unsigned int flags)
 {
+	struct nvmet_pr_register_data data = { 0 };
 	u32 cdw10;
 
 	if (flags & ~PR_FL_IGNORE_KEY)
 		return -EOPNOTSUPP;
 
-	cdw10 = old ? 2 : 0;
-	cdw10 |= (flags & PR_FL_IGNORE_KEY) ? 1 << 3 : 0;
-	cdw10 |= (1 << 30) | (1 << 31); /* PTPL=1 */
-	return nvme_pr_command(bdev, cdw10, old, new, nvme_cmd_resv_register);
+	data.crkey = cpu_to_le64(old_key);
+	data.nrkey = cpu_to_le64(new_key);
+
+	cdw10 = old_key ? NVME_PR_REGISTER_ACT_REPLACE :
+		NVME_PR_REGISTER_ACT_REG;
+	cdw10 |= (flags & PR_FL_IGNORE_KEY) ? NVME_PR_IGNORE_KEY : 0;
+	cdw10 |= NVME_PR_SET_PTPL_TO_PERSIST;
+
+	return nvme_send_pr_command(bdev, cdw10, 0, nvme_cmd_resv_register,
+			&data, sizeof(data));
 }
 
 static int nvme_pr_reserve(struct block_device *bdev, u64 key,
 		enum pr_type type, unsigned flags)
 {
+	struct nvmet_pr_acquire_data data = { 0 };
 	u32 cdw10;
 
 	if (flags & ~PR_FL_IGNORE_KEY)
 		return -EOPNOTSUPP;
 
-	cdw10 = nvme_pr_type_from_blk(type) << 8;
-	cdw10 |= ((flags & PR_FL_IGNORE_KEY) ? 1 << 3 : 0);
-	return nvme_pr_command(bdev, cdw10, key, 0, nvme_cmd_resv_acquire);
+	data.crkey = cpu_to_le64(key);
+
+	cdw10 = NVME_PR_ACQUIRE_ACT_ACQUIRE;
+	cdw10 |= nvme_pr_type_from_blk(type) << 8;
+	cdw10 |= (flags & PR_FL_IGNORE_KEY) ? NVME_PR_IGNORE_KEY : 0;
+
+	return nvme_send_pr_command(bdev, cdw10, 0, nvme_cmd_resv_acquire,
+			&data, sizeof(data));
 }
 
 static int nvme_pr_preempt(struct block_device *bdev, u64 old, u64 new,
 		enum pr_type type, bool abort)
 {
-	u32 cdw10 = nvme_pr_type_from_blk(type) << 8 | (abort ? 2 : 1);
+	struct nvmet_pr_acquire_data data = { 0 };
+	u32 cdw10;
 
-	return nvme_pr_command(bdev, cdw10, old, new, nvme_cmd_resv_acquire);
+	data.crkey = cpu_to_le64(old);
+	data.prkey = cpu_to_le64(new);
+
+	cdw10 = abort ? NVME_PR_ACQUIRE_ACT_PREEMPT_AND_ABORT :
+			NVME_PR_ACQUIRE_ACT_PREEMPT;
+	cdw10 |= nvme_pr_type_from_blk(type) << 8;
+
+	return nvme_send_pr_command(bdev, cdw10, 0, nvme_cmd_resv_acquire,
+			&data, sizeof(data));
 }
 
 static int nvme_pr_clear(struct block_device *bdev, u64 key)
 {
-	u32 cdw10 = 1 | (key ? 0 : 1 << 3);
+	struct nvmet_pr_release_data data = { 0 };
+	u32 cdw10;
 
-	return nvme_pr_command(bdev, cdw10, key, 0, nvme_cmd_resv_release);
+	data.crkey = cpu_to_le64(key);
+
+	cdw10 = NVME_PR_RELEASE_ACT_CLEAR;
+	cdw10 |= key ? 0 : NVME_PR_IGNORE_KEY;
+
+	return nvme_send_pr_command(bdev, cdw10, 0, nvme_cmd_resv_release,
+			&data, sizeof(data));
 }
 
 static int nvme_pr_release(struct block_device *bdev, u64 key, enum pr_type type)
 {
-	u32 cdw10 = nvme_pr_type_from_blk(type) << 8 | (key ? 0 : 1 << 3);
+	struct nvmet_pr_release_data data = { 0 };
+	u32 cdw10;
+
+	data.crkey = cpu_to_le64(key);
 
-	return nvme_pr_command(bdev, cdw10, key, 0, nvme_cmd_resv_release);
+	cdw10 = NVME_PR_RELEASE_ACT_RELEASE;
+	cdw10 |= nvme_pr_type_from_blk(type) << 8;
+	cdw10 |= key ? 0 : NVME_PR_IGNORE_KEY;
+
+	return nvme_send_pr_command(bdev, cdw10, 0, nvme_cmd_resv_release,
+			&data, sizeof(data));
 }
 
 static int nvme_pr_resv_report(struct block_device *bdev, void *data,
 		u32 data_len, bool *eds)
 {
-	struct nvme_command c = { };
+	u32 cdw10, cdw11;
 	int ret;
 
-	c.common.opcode = nvme_cmd_resv_report;
-	c.common.cdw10 = cpu_to_le32(nvme_bytes_to_numd(data_len));
-	c.common.cdw11 = cpu_to_le32(NVME_EXTENDED_DATA_STRUCT);
+	cdw10 = nvme_bytes_to_numd(data_len);
+	cdw11 = NVME_EXTENDED_DATA_STRUCT;
 	*eds = true;
 
 retry:
-	ret = nvme_send_pr_command(bdev, &c, data, data_len);
+	ret = __nvme_send_pr_command(bdev, cdw10, cdw11, nvme_cmd_resv_report,
+			data, data_len);
 	if (ret == NVME_SC_HOST_ID_INCONSIST &&
-	    c.common.cdw11 == cpu_to_le32(NVME_EXTENDED_DATA_STRUCT)) {
-		c.common.cdw11 = 0;
+	    cdw11 == NVME_EXTENDED_DATA_STRUCT) {
+		cdw11 = 0;
 		*eds = false;
 		goto retry;
 	}
 
-	if (ret < 0)
-		return ret;
-
-	return nvme_status_to_pr_err(ret);
+	return ret < 0 ? ret : nvme_status_to_pr_err(ret);
 }
 
 static int nvme_pr_read_keys(struct block_device *bdev,
-- 
2.43.0



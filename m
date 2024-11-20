Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91BE0D6E2CD
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Nov 2024 07:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=W0s9CfNybKFpBiNgsh2Xu+UYYrelOoYRDED/C80ye4g=; b=w+cY9cSXPSpIMIiywiOUl3z9EG
	nAe/phNZGOcIHGT8EXjgd6scc3jklRUGNm9OqWJC5hG51MSDMhHyjfCe9R60aNeyqve2pjRYI7yVK
	EEPikHOdOoz1op+ZEWk3rH8bG1G7ZjIp9i3sGoLP9qaGenzjjJRFipu0ahfA1JNmXpkTbcqdrDxaw
	6h9Ab7JvZAsjZE31Rv9bLu+lxb1xgCQwLbAV3WHvTzGS0qkbGeEmTE4bNSz9O98zKgNH/4G3m7pvW
	9iMvTU2AR4NgX/O8T+495S6Vi8PL3jqs4SReCOPcf3iN2hVipfwzQ+e3liFtTXZtjYODKxg+EJooW
	vYkehdGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tDer5-0000000EaLE-3uBj;
	Wed, 20 Nov 2024 07:10:27 +0000
Received: from out30-111.freemail.mail.aliyun.com ([115.124.30.111])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tDer3-0000000EaKH-18Yb
	for linux-nvme@lists.infradead.org;
	Wed, 20 Nov 2024 07:10:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1732086623; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=W0s9CfNybKFpBiNgsh2Xu+UYYrelOoYRDED/C80ye4g=;
	b=D9eHfE3KlmG8xSvowx3FWDrOJTFmoQdzBo8g4TgE+ZcO7jgYY7XPRzfsuM+i9eDk0ohEXLCCrLyoDfecBEwDdsVOuWBBCn4Qsi7qtGj8l16W6Ej63sPPYJULpci+JzRDIV/0ceo3EPCTaR6aRxiDmN+ubyzLLxYpjnUBAiAfbZY=
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WJrAD2y_1732086618 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 20 Nov 2024 15:10:22 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH v2 2/2] nvme: tuning pr code by using defined structs and macros
Date: Wed, 20 Nov 2024 15:10:08 +0800
Message-ID: <20241120071008.106933-3-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241120071008.106933-1-kanie@linux.alibaba.com>
References: <20241120071008.106933-1-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241119_231025_449943_5BA81E3C 
X-CRM114-Status: GOOD (  13.75  )
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
 drivers/nvme/host/pr.c | 122 +++++++++++++++++++++++++----------------
 1 file changed, 75 insertions(+), 47 deletions(-)

diff --git a/drivers/nvme/host/pr.c b/drivers/nvme/host/pr.c
index dc7922f22600..cf2d2c5039dd 100644
--- a/drivers/nvme/host/pr.c
+++ b/drivers/nvme/host/pr.c
@@ -94,109 +94,137 @@ static int nvme_status_to_pr_err(int status)
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
+	cdw10 |= NVME_PR_CPTPL_PERSIST;
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
+
+	data.crkey = cpu_to_le64(old);
+	data.prkey = cpu_to_le64(new);
 
-	return nvme_pr_command(bdev, cdw10, old, new, nvme_cmd_resv_acquire);
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
+
+	data.crkey = cpu_to_le64(key);
 
-	return nvme_pr_command(bdev, cdw10, key, 0, nvme_cmd_resv_release);
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



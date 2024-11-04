Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D092D111A0
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Nov 2024 03:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=tAfX7vVGazhL+lpTs3vajSkSd8axvSrvv02bwz02tUs=; b=wOmhATiQ9Lj46N9vM5pL+RAeSH
	JiK+p2vRT446Knyoqq24+ChIyg6pfM8gxm1JG7XkJ/x4sVPyhw7t+b8OaqNIs70knxLQ49NZVH9sx
	HDo1i6/Ly1QCJII6o456sxNf3yJGEKbIUGB4IVzZ2ZZs9nssOXyKuKV4Rd2UDbJcG6dGfDLp9sx66
	jkxI2sZHCw3gVEsBYbaRAsZUCTVdfH9BZ3rDudzPSq4tDHwaVyB++8B2Ja1fPUnyQHEg2D2Z9YUdo
	GUiafCP/cDaD39/ZR+qNF6MloGyt4hWQhgAYyRbm+Cca2E5P/bhQBwyGkwmAwHd0bxfl162dI4YQW
	8s5WR1WA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t7nY7-0000000CWGF-10x8;
	Mon, 04 Nov 2024 03:14:39 +0000
Received: from out30-110.freemail.mail.aliyun.com ([115.124.30.110])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t7nY2-0000000CWFS-3qLe
	for linux-nvme@lists.infradead.org;
	Mon, 04 Nov 2024 03:14:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730690069; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=tAfX7vVGazhL+lpTs3vajSkSd8axvSrvv02bwz02tUs=;
	b=nNdRKbl1agQ9vqbJ/6mh2keU5vjSG1VxNse8XuOPYfwwz1QwsX0TaJ2iTB5l13bOCeyycfPuonDLAOGFiyPBL/ST36H3PLu1FNZ6ciNi8MP2jxxg72GlcAeyMY6l1A9iFBY2k27yMsdqL/GXIX7ZtsyGY3ZqR55YUhqp3NKZdEo=
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WIZwANv_1730690058 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 04 Nov 2024 11:14:23 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH v2] nvme: check at least one ns identification reported
Date: Mon,  4 Nov 2024 11:14:18 +0800
Message-ID: <20241104031418.121235-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241103_191435_489439_4EDB93AB 
X-CRM114-Status: GOOD (  11.86  )
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

Per the NVMe spec after 1.3:
  At least one Namespace Identification Descriptor identifying the
  namespace (i.e., NIDT field set to 1h, 2h, or 3h).
Check there is at least one reported.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
Changes from v1 to v2:
- Check only when the nvme version is greater than or
equal to 1.3.

 drivers/nvme/host/core.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 84cb859a911d..cf767ac697dc 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1426,7 +1426,7 @@ static int nvme_identify_ctrl(struct nvme_ctrl *dev, struct nvme_id_ctrl **id)
 }
 
 static int nvme_process_ns_desc(struct nvme_ctrl *ctrl, struct nvme_ns_ids *ids,
-		struct nvme_ns_id_desc *cur, bool *csi_seen)
+		struct nvme_ns_id_desc *cur, bool *csi_seen, bool *has_id)
 {
 	const char *warn_str = "ctrl returned bogus length:";
 	void *data = cur;
@@ -1438,6 +1438,7 @@ static int nvme_process_ns_desc(struct nvme_ctrl *ctrl, struct nvme_ns_ids *ids,
 				 warn_str, cur->nidl);
 			return -1;
 		}
+		*has_id = true;
 		if (ctrl->quirks & NVME_QUIRK_BOGUS_NID)
 			return NVME_NIDT_EUI64_LEN;
 		memcpy(ids->eui64, data + sizeof(*cur), NVME_NIDT_EUI64_LEN);
@@ -1448,6 +1449,7 @@ static int nvme_process_ns_desc(struct nvme_ctrl *ctrl, struct nvme_ns_ids *ids,
 				 warn_str, cur->nidl);
 			return -1;
 		}
+		*has_id = true;
 		if (ctrl->quirks & NVME_QUIRK_BOGUS_NID)
 			return NVME_NIDT_NGUID_LEN;
 		memcpy(ids->nguid, data + sizeof(*cur), NVME_NIDT_NGUID_LEN);
@@ -1458,6 +1460,7 @@ static int nvme_process_ns_desc(struct nvme_ctrl *ctrl, struct nvme_ns_ids *ids,
 				 warn_str, cur->nidl);
 			return -1;
 		}
+		*has_id = true;
 		if (ctrl->quirks & NVME_QUIRK_BOGUS_NID)
 			return NVME_NIDT_UUID_LEN;
 		uuid_copy(&ids->uuid, data + sizeof(*cur));
@@ -1482,6 +1485,7 @@ static int nvme_identify_ns_descs(struct nvme_ctrl *ctrl,
 {
 	struct nvme_command c = { };
 	bool csi_seen = false;
+	bool has_id = false;
 	int status, pos, len;
 	void *data;
 
@@ -1513,13 +1517,25 @@ static int nvme_identify_ns_descs(struct nvme_ctrl *ctrl,
 		if (cur->nidl == 0)
 			break;
 
-		len = nvme_process_ns_desc(ctrl, &info->ids, cur, &csi_seen);
+		len = nvme_process_ns_desc(ctrl, &info->ids, cur,
+					   &csi_seen, &has_id);
 		if (len < 0)
 			break;
 
 		len += sizeof(*cur);
 	}
 
+	/*
+	 * NVMe 1.3 spec introduced ns identification, a controller should
+	 * return at least one.
+	 */
+	if (!has_id && ctrl->vs >= NVME_VS(1, 3, 0)) {
+		dev_warn(ctrl->device,
+			 "No identification reported for nsid:%d\n",
+			 info->nsid);
+		status = -EINVAL;
+	}
+
 	if (nvme_multi_css(ctrl) && !csi_seen) {
 		dev_warn(ctrl->device, "Command set not reported for nsid:%d\n",
 			 info->nsid);
-- 
2.43.0



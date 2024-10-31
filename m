Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B025AE68974
	for <linux-nvme@archiver.kernel.org>; Thu, 31 Oct 2024 10:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=7iCTVpvCwMu4XjRFgS8OKJlGQXXv0HnYPx7SLM3qfrk=; b=XMRmOqjPk8rjhu11y0of/2hTjF
	8dl5sOviCO0KocIwEB49SlR4c/flebEVu+/HK85TQOZX+vmQvzdMHP+csrRKsWE9qn9cCfRDSCcLC
	hxZrgTWto/M8RAyo5ciIOB1iwOqlSNYhlW2S6Sr1iBKB3xj26EZ6WFh9SGR6cc5ujAy7FWJgqaqmn
	0bt98HAcg1p3sxCYjToQ3UMsYSzaBN0feR/J3q8fZELn/krqDMSQM/uQ36v4yEAHSEgvHfRKP0NHd
	0df9x7Vb/6AVRWbiJbfDxz2tlXOhz9whAJeTUBmmYmZLAmmykRhSUM5zf4YHW3L942d+sAI9y3M0B
	6gdj5m+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t6SZD-00000003GOH-04FP;
	Thu, 31 Oct 2024 10:38:15 +0000
Received: from out30-101.freemail.mail.aliyun.com ([115.124.30.101])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t6SZ9-00000003GN9-49P6
	for linux-nvme@lists.infradead.org;
	Thu, 31 Oct 2024 10:38:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730371088; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=7iCTVpvCwMu4XjRFgS8OKJlGQXXv0HnYPx7SLM3qfrk=;
	b=Jythuc7xZMkUOk9RJGMhV7V05dWJdh0loPp5dWuOaiNjQUdrZ/Nx11Yg4YjfxmIJFp906AhTTvIID962ncvKeDq+5hhTsvXfd3esfRGhvCRVNlGsiEx1mrX99isqaqJJMlpTOOJ5Nnczp/CdIGDHy8QIVZuS1SSTvf445lSMlOA=
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WIIEMR8_1730371083 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 31 Oct 2024 18:38:07 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH] nvme: check at least one ns identification reported
Date: Thu, 31 Oct 2024 18:38:03 +0800
Message-ID: <20241031103803.55219-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241031_033812_397375_52924F49 
X-CRM114-Status: UNSURE (   9.86  )
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

Per 2.1 base NVMe spec:
  At least one Namespace Identification Descriptor identifying the
  namespace (i.e., NIDT field set to 1h, 2h, or 3h).
Check there is at least one reported.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/nvme/host/core.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 84cb859a911d..6e23d617ad7f 100644
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
 
@@ -1513,13 +1517,21 @@ static int nvme_identify_ns_descs(struct nvme_ctrl *ctrl,
 		if (cur->nidl == 0)
 			break;
 
-		len = nvme_process_ns_desc(ctrl, &info->ids, cur, &csi_seen);
+		len = nvme_process_ns_desc(ctrl, &info->ids, cur,
+					   &csi_seen, &has_id);
 		if (len < 0)
 			break;
 
 		len += sizeof(*cur);
 	}
 
+	if (!has_id) {
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



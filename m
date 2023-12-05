Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66B6EC07E97
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Dec 2023 07:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=+piqjQXTqkJYsq6eazyqpX1LIqvUFrzQQceHibQS5vE=; b=zBJXsRxslilluLnbVHcXZ5aaUD
	FG5ZC6kP/qaaXK5rE6yOOv9kZQpVd5FC0Cud2DtRZgbkGVqYFnlyqnt03G3OJFamFjaDhip7L/B5K
	BhCN/A/LQCjvlT8xKGw6eSGMZ151OsNpuaNx79JbrtZ55KNAWKLvf2hO4LIRUnPdjw6HFjETbW3GN
	JyeF/YQ+lUJ+WW8SyC79KgidVKcQujGJylSTKAxZpN5bYEbIcpWmZrZljV9bEncFYObNovNPp6cec
	gq8k8A1b9ZMNMFdOfr2/ujUqBlVi97OoDOV7CZXwStQBDO8VuMYIUPXiZPpwUPk/Daqloadv7n+kC
	KBRa2o0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rAQ0E-006Wip-21;
	Tue, 05 Dec 2023 07:37:58 +0000
Received: from out30-100.freemail.mail.aliyun.com ([115.124.30.100])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rAQ07-006Whn-2l
	for linux-nvme@lists.infradead.org;
	Tue, 05 Dec 2023 07:37:57 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R991e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VxtmQET_1701761860;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0VxtmQET_1701761860)
          by smtp.aliyun-inc.com;
          Tue, 05 Dec 2023 15:37:45 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH 1/2] nvme: introduce nvme_check_ctrl_fabric_info helper
Date: Tue,  5 Dec 2023 15:37:39 +0800
Message-Id: <1701761860-17623-1-git-send-email-kanie@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231204_233755_741811_2F9EDA4D 
X-CRM114-Status: GOOD (  10.26  )
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

Inroduce nvme_check_ctrl_fabric_info helper to check
fabric ctroller info returned by target.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/nvme/host/core.c | 42 ++++++++++++++++++++++++------------------
 1 file changed, 24 insertions(+), 18 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 1be1ce5..4da6ee6 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3024,6 +3024,28 @@ static int nvme_init_effects(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 	return 0;
 }
 
+static int nvme_check_ctrl_fabric_info(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
+{
+	/*
+	 * In fabrics we need to verify the cntlid matches the
+	 * admin connect
+	 */
+	if (ctrl->cntlid != le16_to_cpu(id->cntlid)) {
+		dev_err(ctrl->device,
+			"Mismatching cntlid: Connect %u vs Identify %u, rejecting\n",
+			ctrl->cntlid, le16_to_cpu(id->cntlid));
+		return -EINVAL;
+	}
+
+	if (!nvme_discovery_ctrl(ctrl) && !ctrl->kas) {
+		dev_err(ctrl->device,
+			"keep-alive support is mandatory for fabrics\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int nvme_init_identify(struct nvme_ctrl *ctrl)
 {
 	struct nvme_id_ctrl *id;
@@ -3136,25 +3158,9 @@ static int nvme_init_identify(struct nvme_ctrl *ctrl)
 		ctrl->iorcsz = le32_to_cpu(id->iorcsz);
 		ctrl->maxcmd = le16_to_cpu(id->maxcmd);
 
-		/*
-		 * In fabrics we need to verify the cntlid matches the
-		 * admin connect
-		 */
-		if (ctrl->cntlid != le16_to_cpu(id->cntlid)) {
-			dev_err(ctrl->device,
-				"Mismatching cntlid: Connect %u vs Identify "
-				"%u, rejecting\n",
-				ctrl->cntlid, le16_to_cpu(id->cntlid));
-			ret = -EINVAL;
-			goto out_free;
-		}
-
-		if (!nvme_discovery_ctrl(ctrl) && !ctrl->kas) {
-			dev_err(ctrl->device,
-				"keep-alive support is mandatory for fabrics\n");
-			ret = -EINVAL;
+		ret = nvme_check_ctrl_fabric_info(ctrl, id);
+		if (ret)
 			goto out_free;
-		}
 	} else {
 		ctrl->hmpre = le32_to_cpu(id->hmpre);
 		ctrl->hmmin = le32_to_cpu(id->hmmin);
-- 
1.8.3.1



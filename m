Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8675C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Apr 2022 06:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EVd4Hy24ofeDqJjgrR7FKr6oPp8WmN6pOfaBL2l5+88=; b=HPmCi1ggvQADSdjRCGxFDTOwCq
	JM3n4oNwiYpOYx/dogcN5oqjef0mLS4BJigdfsKvu1kAs3Z2yCDvq9uXQlAzxBT6X23sGSzc4eSbd
	KWdhcrGUg84KCkHKfKNlxXAoscSXKJIs8Azld5mDj3xQtDXSfhDheZbTVi2ZuZvFewsIIVqPk8byS
	M7or38FWRf7CD2e1PxEHS+5C0n1q9r7sJT4l6nJaFNlMPL/AM5BITSH0X0vuZPmaKYIImOg3JvXvX
	uq9bST4L9gpALhRV6NJFgORPdPQF3jYFMRZpAUjzy4yrc2ZCc87lRirfTD8wbZXQrXq69IkWYqxJ4
	CH8LEXvg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ne9kV-00BorZ-4K; Tue, 12 Apr 2022 06:11:35 +0000
Received: from [2001:4bb8:18e:76f5:73f2:2aba:795d:ae99] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ne9kR-00Boq7-WD; Tue, 12 Apr 2022 06:11:32 +0000
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 linux-nvme@lists.infradead.org
Subject: [PATCH 1/3] nvme: add a quirk to disable namespace identifiers
Date: Tue, 12 Apr 2022 08:11:24 +0200
Message-Id: <20220412061126.244414-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220412061126.244414-1-hch@lst.de>
References: <20220412061126.244414-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Add a quirk to disable using and exporting namespace identifiers for
controllers where they are broken beyond repair.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 24 ++++++++++++++++++------
 drivers/nvme/host/nvme.h |  5 +++++
 2 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index efb85c6d8e2d5..41314dccb2209 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1282,6 +1282,8 @@ static int nvme_process_ns_desc(struct nvme_ctrl *ctrl, struct nvme_ns_ids *ids,
 
 	switch (cur->nidt) {
 	case NVME_NIDT_EUI64:
+		if (ctrl->quirks & NVME_QUIRK_BOGUS_NID)
+			return NVME_NIDT_EUI64_LEN;
 		if (cur->nidl != NVME_NIDT_EUI64_LEN) {
 			dev_warn(ctrl->device, "%s %d for NVME_NIDT_EUI64\n",
 				 warn_str, cur->nidl);
@@ -1290,6 +1292,8 @@ static int nvme_process_ns_desc(struct nvme_ctrl *ctrl, struct nvme_ns_ids *ids,
 		memcpy(ids->eui64, data + sizeof(*cur), NVME_NIDT_EUI64_LEN);
 		return NVME_NIDT_EUI64_LEN;
 	case NVME_NIDT_NGUID:
+		if (ctrl->quirks & NVME_QUIRK_BOGUS_NID)
+			return NVME_NIDT_NGUID_LEN;
 		if (cur->nidl != NVME_NIDT_NGUID_LEN) {
 			dev_warn(ctrl->device, "%s %d for NVME_NIDT_NGUID\n",
 				 warn_str, cur->nidl);
@@ -1298,6 +1302,8 @@ static int nvme_process_ns_desc(struct nvme_ctrl *ctrl, struct nvme_ns_ids *ids,
 		memcpy(ids->nguid, data + sizeof(*cur), NVME_NIDT_NGUID_LEN);
 		return NVME_NIDT_NGUID_LEN;
 	case NVME_NIDT_UUID:
+		if (ctrl->quirks & NVME_QUIRK_BOGUS_NID)
+			return NVME_NIDT_UUID_LEN;
 		if (cur->nidl != NVME_NIDT_UUID_LEN) {
 			dev_warn(ctrl->device, "%s %d for NVME_NIDT_UUID\n",
 				 warn_str, cur->nidl);
@@ -1399,12 +1405,18 @@ static int nvme_identify_ns(struct nvme_ctrl *ctrl, unsigned nsid,
 	if ((*id)->ncap == 0) /* namespace not allocated or attached */
 		goto out_free_id;
 
-	if (ctrl->vs >= NVME_VS(1, 1, 0) &&
-	    !memchr_inv(ids->eui64, 0, sizeof(ids->eui64)))
-		memcpy(ids->eui64, (*id)->eui64, sizeof(ids->eui64));
-	if (ctrl->vs >= NVME_VS(1, 2, 0) &&
-	    !memchr_inv(ids->nguid, 0, sizeof(ids->nguid)))
-		memcpy(ids->nguid, (*id)->nguid, sizeof(ids->nguid));
+
+	if (ctrl->quirks & NVME_QUIRK_BOGUS_NID) {
+		dev_info(ctrl->device,
+			 "Ignoring bogus Namespace Identifiers\n");
+	} else {
+		if (ctrl->vs >= NVME_VS(1, 1, 0) &&
+		    !memchr_inv(ids->eui64, 0, sizeof(ids->eui64)))
+			memcpy(ids->eui64, (*id)->eui64, sizeof(ids->eui64));
+		if (ctrl->vs >= NVME_VS(1, 2, 0) &&
+		    !memchr_inv(ids->nguid, 0, sizeof(ids->nguid)))
+			memcpy(ids->nguid, (*id)->nguid, sizeof(ids->nguid));
+	}
 
 	return 0;
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 1393bbf82d71e..a2b53ca633359 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -144,6 +144,11 @@ enum nvme_quirks {
 	 * encoding the generation sequence number.
 	 */
 	NVME_QUIRK_SKIP_CID_GEN			= (1 << 17),
+
+	/*
+	 * Reports garbage in the namespace identifiers (eui64, nguid, uuid).
+	 */
+	NVME_QUIRK_BOGUS_NID			= (1 << 18),
 };
 
 /*
-- 
2.30.2



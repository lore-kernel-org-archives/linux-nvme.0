Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56021C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Apr 2022 04:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Sok8n1Uo6TGtfQwqioh+JPCt7aPUeX1vBUgTb0PM9gs=; b=NUVOaecurq9DeWuEFEtTz8xGfS
	kzhNyCz8jx0Z24QVKa3Y0nyO94OmmGqX+1SjkAhlOaMUjl2buxGGqSnXtyn/PE6DIoD3d4loGWPV1
	gZdfToV8tWmJFk9wMka1q7NWomaTcLbRsGXPOKjsQEDVNtdisXtjPzbSBTifgcjObQA6bQ0WlyxQP
	RxL+atqpM8s9SZZwQXgtoikq6N9SuatBXcS97jsWZeb2pMsbKcaOg4mU08hSY+NsVcZZ9JVo+ascr
	o+a5aq/y+DDTLUJ+Greeh2wIaEEd8a0qDZbmi0OopJFyH2Rl7z7MbJ723AKoWXt2IVTQIDWtys/5z
	fIrnPK9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1neUwQ-00GlZY-N6; Wed, 13 Apr 2022 04:49:18 +0000
Received: from [2a02:1205:504b:4280:f5dd:42a4:896c:d877] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1neUwM-00GlYi-Jr; Wed, 13 Apr 2022 04:49:15 +0000
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 linux-nvme@lists.infradead.org, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 1/3] nvme: add a quirk to disable namespace identifiers
Date: Wed, 13 Apr 2022 06:49:03 +0200
Message-Id: <20220413044905.376785-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220413044905.376785-1-hch@lst.de>
References: <20220413044905.376785-1-hch@lst.de>
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

The most directly visible problem with non-unique namespace identifiers
is that they break the /dev/disk/by-id/ links, with the link for a
supposedly unique identifier now pointing to one of multiple possible
namespaces that share the same ID, and a somewhat random selection of
which one actually shows up.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/host/core.c | 24 ++++++++++++++++++------
 drivers/nvme/host/nvme.h |  5 +++++
 2 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index be9fc9818e650..e1846d04817f3 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1288,6 +1288,8 @@ static int nvme_process_ns_desc(struct nvme_ctrl *ctrl, struct nvme_ns_ids *ids,
 				 warn_str, cur->nidl);
 			return -1;
 		}
+		if (ctrl->quirks & NVME_QUIRK_BOGUS_NID)
+			return NVME_NIDT_EUI64_LEN;
 		memcpy(ids->eui64, data + sizeof(*cur), NVME_NIDT_EUI64_LEN);
 		return NVME_NIDT_EUI64_LEN;
 	case NVME_NIDT_NGUID:
@@ -1296,6 +1298,8 @@ static int nvme_process_ns_desc(struct nvme_ctrl *ctrl, struct nvme_ns_ids *ids,
 				 warn_str, cur->nidl);
 			return -1;
 		}
+		if (ctrl->quirks & NVME_QUIRK_BOGUS_NID)
+			return NVME_NIDT_NGUID_LEN;
 		memcpy(ids->nguid, data + sizeof(*cur), NVME_NIDT_NGUID_LEN);
 		return NVME_NIDT_NGUID_LEN;
 	case NVME_NIDT_UUID:
@@ -1304,6 +1308,8 @@ static int nvme_process_ns_desc(struct nvme_ctrl *ctrl, struct nvme_ns_ids *ids,
 				 warn_str, cur->nidl);
 			return -1;
 		}
+		if (ctrl->quirks & NVME_QUIRK_BOGUS_NID)
+			return NVME_NIDT_UUID_LEN;
 		uuid_copy(&ids->uuid, data + sizeof(*cur));
 		return NVME_NIDT_UUID_LEN;
 	case NVME_NIDT_CSI:
@@ -1400,12 +1406,18 @@ static int nvme_identify_ns(struct nvme_ctrl *ctrl, unsigned nsid,
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



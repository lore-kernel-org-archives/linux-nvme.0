Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3605BC282DE
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Mar 2025 05:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=OYPQEuL6H4Q+nRCvsnBc+CStaMjODQAC9sGLqAhPDCQ=; b=FHzz6o8ZYumZEs55z8kHe1S1Kg
	bAT/+BfSjilgMLZpkWPlLAoFkIjuSnLJuWi4+jvgsjSCsCNp137/u80+tYS6VNTzliUcx8iwStRnJ
	tZEAsuSdi74CPbNRpatOR5aM+otz1k966gH58+xBDYFUtvkVkpmZNnpJXxduau77x/CiGIJ9/WWMk
	HmNKp5kOLRu0PEzSxRftaKPYNrybh/S3QUCH4chHyeO2UFUw2YwuCBZx0qAfMaQrPVVU2ngCpl2IQ
	dlNynXpfyz9xIkzuoBEuxdjr4E8DNGMcWuqwjIoItPlmioU+dOSbrGTrZDJqx+UudT3Y2mOUjpNSV
	V/dRH8Gw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tsb4c-0000000A93I-2iNh;
	Thu, 13 Mar 2025 05:25:38 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tsb4Z-0000000A92I-3iNg
	for linux-nvme@lists.infradead.org;
	Thu, 13 Mar 2025 05:25:36 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 2F0D65C5774;
	Thu, 13 Mar 2025 05:23:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00986C4CEDD;
	Thu, 13 Mar 2025 05:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741843534;
	bh=8UhSSX8G/lriulicxAr8K2ckAGuEL32jtoroAV2aYts=;
	h=From:To:Subject:Date:From;
	b=C2BFfQVYpWtHM7l9iLH9ZY/COZtQS3rCBSacu8fxd0dSN2AEhW38TrNtBDwsXZhVq
	 2qJeVaFTeynkXy8dxQiHSrDPSmxRfsb2lH9XmZxI2hNIRBiZNoXwYC/gJ9pr9zsZ5E
	 J5h4HW49uQLDGJDUcO4n8jC4nUalYVW5Vf/iCrlGV6FkyeKizoDrOelyRq8vYUj9zR
	 urHnJEiwFag6JPtWtpybkUdRcFkwZ97RPxiwHTUkcfOtNYrVJytkCKprHfd0kmXzN6
	 T/1jMLbFCjHtT+eCTi2gWaK6D1HYCUReTyQcedQpRJSfNfdMjtKwIFgffYkFL63H2a
	 r/C0O5vJh9Hiw==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH] nvme: zns: Simplify nvme_zone_parse_entry()
Date: Thu, 13 Mar 2025 14:25:20 +0900
Message-ID: <20250313052520.1439245-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250312_222535_963651_FAA1E4EB 
X-CRM114-Status: GOOD (  10.83  )
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

Instead of passing a pointer to a struct nvme_ctrl and a pointer to a
struct nvme_ns_head as the first two arguments of
nvme_zone_parse_entry(), pass only a pointer to a struct nvme_ns as both
the controller structure and ns head structure can be infered from the
namespace structure.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/nvme/host/zns.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
index 382949e18c6a..cce4c5b55aa9 100644
--- a/drivers/nvme/host/zns.c
+++ b/drivers/nvme/host/zns.c
@@ -146,17 +146,16 @@ static void *nvme_zns_alloc_report_buffer(struct nvme_ns *ns,
 	return NULL;
 }
 
-static int nvme_zone_parse_entry(struct nvme_ctrl *ctrl,
-				 struct nvme_ns_head *head,
+static int nvme_zone_parse_entry(struct nvme_ns *ns,
 				 struct nvme_zone_descriptor *entry,
 				 unsigned int idx, report_zones_cb cb,
 				 void *data)
 {
+	struct nvme_ns_head *head = ns->head;
 	struct blk_zone zone = { };
 
 	if ((entry->zt & 0xf) != NVME_ZONE_TYPE_SEQWRITE_REQ) {
-		dev_err(ctrl->device, "invalid zone type %#x\n",
-				entry->zt);
+		dev_err(ns->ctrl->device, "invalid zone type %#x\n", entry->zt);
 		return -EINVAL;
 	}
 
@@ -213,8 +212,7 @@ int nvme_ns_report_zones(struct nvme_ns *ns, sector_t sector,
 			break;
 
 		for (i = 0; i < nz && zone_idx < nr_zones; i++) {
-			ret = nvme_zone_parse_entry(ns->ctrl, ns->head,
-						    &report->entries[i],
+			ret = nvme_zone_parse_entry(ns, &report->entries[i],
 						    zone_idx, cb, data);
 			if (ret)
 				goto out_free;
-- 
2.48.1



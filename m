Return-Path: <SRS0=9Kud=5W=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A65C2BA19
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Apr 2020 12:14:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB5EF20678
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Apr 2020 12:14:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Fx5mLa5R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB5EF20678
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=UOvbnh4BzrGITpNl5JjEJCyyB3PPfdYUdni8NvO0nZg=; b=Fx5mLa5RX7JBxm
	FSWrJszjigicOkchR21B8haiT4khg0XZd9hZZpmXShsKliLpTEhDJbAVk8/C/j180B21W3aL8grlG
	B36b5s6NIS+qUVhxTqBdWnN+aJBiZRsH8XvRACTvwi3e5WW4/yVGR9BU7n6uOp5FSQHZ90q5v4ZKN
	ds9MWKycDgSi2VlXDgFWyy9R6lEIXk+PnnQO7xpGNRL+xpy6ed2D3P69TN2Xl5PQsX1NXSCC5ztqe
	1EfeWBKAs27CcU7/vqjzEf4MLLtTiLGtm9BfHXby6H7oO/esqCzfo0aun8aFpu3usceD+OOO/iVhw
	aFF8napCvBbCqIvZJIXA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jLQe6-0004fp-UG; Mon, 06 Apr 2020 12:14:31 +0000
Received: from [2001:4bb8:180:5765:7ca0:239a:fe26:fec2] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jLQde-0004B1-2D; Mon, 06 Apr 2020 12:14:02 +0000
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH 3/5] nvme: factor out a nvme_ns_remove_by_nsid helper
Date: Mon,  6 Apr 2020 14:13:50 +0200
Message-Id: <20200406121352.1151026-4-hch@lst.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200406121352.1151026-1-hch@lst.de>
References: <20200406121352.1151026-1-hch@lst.de>
MIME-Version: 1.0
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
Cc: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Factor out a pice of deeply indented and logicaly separate piece of code
from nvme_scan_ns_list.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 5fcc35f74eac..ffa1d62eaeb1 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3697,6 +3697,16 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 	nvme_put_ns(ns);
 }
 
+static void nvme_ns_remove_by_nsid(struct nvme_ctrl *ctrl, u32 nsid)
+{
+	struct nvme_ns *ns = nvme_find_get_ns(ctrl, nsid);
+
+	if (ns) {
+		nvme_ns_remove(ns);
+		nvme_put_ns(ns);
+	}
+}
+
 static void nvme_validate_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 {
 	struct nvme_ns *ns;
@@ -3730,7 +3740,6 @@ static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
 
 static int nvme_scan_ns_list(struct nvme_ctrl *ctrl, unsigned nn)
 {
-	struct nvme_ns *ns;
 	__le32 *ns_list;
 	unsigned i, j, nsid, prev = 0;
 	unsigned num_lists = DIV_ROUND_UP_ULL((u64)nn, 1024);
@@ -3755,13 +3764,8 @@ static int nvme_scan_ns_list(struct nvme_ctrl *ctrl, unsigned nn)
 
 			nvme_validate_ns(ctrl, nsid);
 
-			while (++prev < nsid) {
-				ns = nvme_find_get_ns(ctrl, prev);
-				if (ns) {
-					nvme_ns_remove(ns);
-					nvme_put_ns(ns);
-				}
-			}
+			while (++prev < nsid)
+				nvme_ns_remove_by_nsid(ctrl, prev);
 		}
 		nn -= j;
 	}
-- 
2.25.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

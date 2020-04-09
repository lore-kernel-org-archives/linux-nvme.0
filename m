Return-Path: <SRS0=0ID+=5Z=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80930C2BA2B
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Apr 2020 16:10:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41581217D8
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Apr 2020 16:10:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gowHrK/Y";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="n5QyLV8e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41581217D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=52dnlFpvheBosTiMBMrsFMsd1wi0mDdgkH8HOmn5SJY=; b=gowHrK/YHdlwn4
	YNEh6Ttpn6t+DCYuY6ZQTE2eFsVLgNWHvtV3XvYGYuPf030zz1/rfNlfvtnVwJygYwDMHzrbugWnz
	vNcycIMziDgXOxBb0BJL1TI6+GhFyuKyoiHgQZh0Ra478S5AeuT5MkReiKK91cN6UUvuzEk4nnPgL
	KArkOsnhXFzCDkpYG/Wf3vkkEO6v9pv9UDuSXa3+bEBy8dOaTszviC8XCZfp7djScwLbprOQ1QOz7
	YFeYkR7Mu61/mLdyGIGTJA/5tyi4l2gpaHE+yLI+lUB6OT9bGMkrK5QsvXkvZzhHui9YlZbP4XHTH
	IhGnJ6pfce6TBRE99KFw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jMZky-0004uN-Lj; Thu, 09 Apr 2020 16:10:20 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jMZjt-0001Rb-Bc
 for linux-nvme@lists.infradead.org; Thu, 09 Apr 2020 16:09:14 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id BBC482145D;
 Thu,  9 Apr 2020 16:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1586448553;
 bh=26wypW4mj7bTF6am9wqzFx/BwIN0bH/r7XRWgQneXgc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=n5QyLV8eBfu6kySMdRqYFiVkPqJG/UVEeuPdLPf8oCgvjFTrbi90I/G8XigjYlON1
 w+igPoEs5laW+vEoN9l8ISDIfKdAG8vE/ITDYfe2+1RuqhYZL62HTbrvAymuL4JewU
 XHubASI5ToWz1gwCMM5LWXGOTttCJ7Lh+QT8rgkw=
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org,
	hch@lst.de,
	sagi@grimberg.me
Subject: [PATCH 06/10] nvme-multipath: set bdi capabilities once
Date: Thu,  9 Apr 2020 09:09:04 -0700
Message-Id: <20200409160908.1889471-7-kbusch@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200409160908.1889471-1-kbusch@kernel.org>
References: <20200409160908.1889471-1-kbusch@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200409_090913_431064_D6E63506 
X-CRM114-Status: GOOD (  10.13  )
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
Cc: Keith Busch <kbusch@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The queues' backing device info capabilities don't change with each
namespace revalidation. Set it only when each path's request_queue
is initially added to a multipath queue.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/core.c      | 7 -------
 drivers/nvme/host/multipath.c | 8 ++++++++
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 7e5d28ed7b0c..2a27dcb7fac7 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1908,13 +1908,6 @@ static void __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
 #ifdef CONFIG_NVME_MULTIPATH
 	if (ns->head->disk) {
 		blk_queue_stack_limits(ns->head->disk->queue, ns->queue);
-		if (bdi_cap_stable_pages_required(ns->queue->backing_dev_info)) {
-			struct backing_dev_info *info =
-				ns->head->disk->queue->backing_dev_info;
-
-                        info->capabilities |= BDI_CAP_STABLE_WRITES;
-		}
-
 		revalidate_disk(ns->head->disk);
 	}
 #endif
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 54603bd3e02d..9f2844935fdf 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -3,6 +3,7 @@
  * Copyright (c) 2017-2018 Christoph Hellwig.
  */
 
+#include <linux/backing-dev.h>
 #include <linux/moduleparam.h>
 #include <trace/events/block.h>
 #include "nvme.h"
@@ -666,6 +667,13 @@ void nvme_mpath_add_disk(struct nvme_ns *ns, struct nvme_id_ns *id)
 		nvme_mpath_set_live(ns);
 		mutex_unlock(&ns->head->lock);
 	}
+
+	if (bdi_cap_stable_pages_required(ns->queue->backing_dev_info)) {
+		struct backing_dev_info *info =
+					ns->head->disk->queue->backing_dev_info;
+
+		info->capabilities |= BDI_CAP_STABLE_WRITES;
+	}
 }
 
 void nvme_mpath_remove_disk(struct nvme_ns_head *head)
-- 
2.24.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

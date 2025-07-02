Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3A75C83F03
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Jul 2025 00:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8c2ielfwcDIkPJWuAAJqfRdDe6ib8JDSUeV6W9MqfZQ=; b=UAK88Jz6OakL7pxuQqrF8bKiMf
	ZE9TYGddOP5JIohwsCgsBP2tFLoohhbzox0iXxlZLzqo2nNTRFXregzzarmdeO8ydpXFsmRtar+FV
	oLtjLie1JISrP7mxbbhNvn8H4xMN8yfoaZVA5424dGHwC4z4DfFDhztM2ZjEeJejim7wV4v8gx8mY
	3xV9qiNH0B26xYCnAyDcD4MIDicBCRJ+yqGJzYLY8iKUz+ljqoQZjoSQeCzWPtYaFVfXA6/wLDDuX
	oawTDfQhT1otiVlF4LZ79c7nbHbOpqxaEhHtBRrCNyI6wHKH5m4/wIKKiJd241d/f9wMmeZSnevmd
	98qovIVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWlo6-00000006wZB-1zGv;
	Wed, 02 Jul 2025 00:58:38 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWlo3-00000006wVV-3KJe
	for linux-nvme@lists.infradead.org;
	Wed, 02 Jul 2025 00:58:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1751417915; x=1782953915;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VXNIZYL4TDNV74rDgxN9LTztkyCjwTb19kJ9JH/Ew7U=;
  b=WyR40FM6qK1glItOFBwQNqcZHTH4EeieCJ9Nt/nPQMLnf4h8mt9Al4qy
   sBZ2Csc73Khf3jR7jYkd8O4s42SVNtoisili1nnka5Jvv/Df86ghErCn+
   eT/ZfIk4rjNkZ73TUwnZVfgEKod7y2OYaxkjPN7Nr8sUVR0e4dRgH/EzQ
   yh10Gyea1+MQ6wspv0qaXUyd2JD9/ew/yH/K2SSQY611b3oG9/Mt8GYK2
   1TwHOoBo2qirHI/VL0qRU8f81GyRRuouNtmCmlQzTVVT31BTgUo6sjAD7
   JN2RTB2yCz97Dc/UKZt4aX6ZfNwAvEhXFKw/U2D2ZkpCKyfWeokZm0WXA
   Q==;
X-CSE-ConnectionGUID: itjs5XQWSoyEJfr1f4bMjw==
X-CSE-MsgGUID: whbU6RGeTgq9By6Sa61izg==
X-IronPort-AV: E=Sophos;i="6.16,280,1744041600"; 
   d="scan'208";a="91662750"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 02 Jul 2025 08:58:32 +0800
IronPort-SDR: 686475ad_5HP6L7y3Wa5SZB58kjoP2s/WzilOIVYyPYKSUWuwaWYFJ0f
 XFARUMEH+rXJhvVHrZiLCBRSBOK53KiHS4+6ivg==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Jul 2025 16:56:29 -0700
WDCIronportException: Internal
Received: from ros-3.wdc.com ([10.23.145.79])
  by uls-op-cesaip01.wdc.com with ESMTP; 01 Jul 2025 17:58:32 -0700
From: Kamaljit Singh <kamaljit.singh1@wdc.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: cassel@kernel.org,
	dlemoal@kernel.org,
	kamaljit.singh1@wdc.com
Subject: [PATCH v2 3/3] nvme: prevent ioq creation for discovery controllers
Date: Tue,  1 Jul 2025 17:58:29 -0700
Message-ID: <20250702005830.889217-4-kamaljit.singh1@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250702005830.889217-1-kamaljit.singh1@wdc.com>
References: <20250702005830.889217-1-kamaljit.singh1@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250701_175835_893001_8098DCC8 
X-CRM114-Status: GOOD (  14.31  )
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

Prevent ioq creation for discovery-controllers as the spec prohibits
them, similarly to the administrative controllers.

Reference: NVMe Base rev 2.2, sec 3.1.3.4, fig 28.

Signed-off-by: Kamaljit Singh <kamaljit.singh1@wdc.com>
---
 drivers/nvme/host/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c310634e75f3..3ad3b1da8b34 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3155,12 +3155,12 @@ static inline bool nvme_admin_ctrl(struct nvme_ctrl *ctrl)
 }
 
 /*
- * An admin controller has one admin queue, but no I/O queues.
+ * An admin or discovery controller has one admin queue, but no I/O queues.
  * Override queue_count so it only creates an admin queue.
  */
 void nvme_override_prohibited_io_queues(struct nvme_ctrl *ctrl)
 {
-	if (nvme_admin_ctrl(ctrl))
+	if (nvme_admin_ctrl(ctrl) || nvme_discovery_ctrl(ctrl))
 		ctrl->queue_count = 1;
 }
 EXPORT_SYMBOL_GPL(nvme_override_prohibited_io_queues);
-- 
2.43.0



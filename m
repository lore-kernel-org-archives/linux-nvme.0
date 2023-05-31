Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D04AC77B73
	for <linux-nvme@archiver.kernel.org>; Wed, 31 May 2023 12:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=eYvXG4zDBpYWy/WDfOfu+q+VymOvkEgS60e/X7yPtQ4=; b=dC8vRtETcO1/twscvZtpNsQ7Ie
	jnoK2E8/HHlYiTVPm6SezQeEKQmG5x5G6AoYGL0iX84ZWroWQeENRpkH9dmyphz2g4vpzK8OkiK+d
	yquy5/NciFYdeO/dWdDtvJURO9cTbEsuphhk9Hje8XyfDDWxqJaBY9Hrh+LV3hVl5tLd6XeVHCNfa
	QKVbKH/EB0QYre3q3aGLg6wp9CHWlMSt9Ci2rOSP6gITUCVOnGhTtC7CyMEz1OOjBaIFrRNzzzZgA
	45LO1QSL55ESzIv3ArgtzgWCqDl4bZp08OCfZIOFqQlN48RFo5QKetVDW6QMbPqZ3IgnnJyTDxno1
	wQD4E2Xg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q4LLy-00HQoq-1Q;
	Wed, 31 May 2023 12:55:02 +0000
Received: from [2001:4bb8:182:6d06:2e49:a56:513a:92ee] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1q4LLw-00HQo4-0J;
	Wed, 31 May 2023 12:55:00 +0000
From: Christoph Hellwig <hch@lst.de>
To: kbusch@kernel.org,
	sagi@grimberg.me
Cc: alan.adamson@oracle.com,
	linux-nvme@lists.infradead.org
Subject: [PATCH] nvme: fix the name of Zone Append for verbose logging
Date: Wed, 31 May 2023 14:54:54 +0200
Message-Id: <20230531125454.676077-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
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

No Management involved in Zone Appened.

Fixes: bd83fe6f2cd2 ("nvme: add verbose error logging")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/constants.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/constants.c b/drivers/nvme/host/constants.c
index bc523ca0225486..5e4f8848dce08e 100644
--- a/drivers/nvme/host/constants.c
+++ b/drivers/nvme/host/constants.c
@@ -21,7 +21,7 @@ static const char * const nvme_ops[] = {
 	[nvme_cmd_resv_release] = "Reservation Release",
 	[nvme_cmd_zone_mgmt_send] = "Zone Management Send",
 	[nvme_cmd_zone_mgmt_recv] = "Zone Management Receive",
-	[nvme_cmd_zone_append] = "Zone Management Append",
+	[nvme_cmd_zone_append] = "Zone Append",
 };
 
 static const char * const nvme_admin_ops[] = {
-- 
2.39.2



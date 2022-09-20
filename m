Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C06BBC54EE9
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Sep 2022 17:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YMVnKlllckbg/mfZwmKEmkrKwt/6fjwpK+NQy0uEjv0=; b=suGroFPUD6eeUOfo9rd5cNcdFQ
	WCRtF5i4GejyK6kbtz4qEEC0wC+nGLWiaPmY6PxXDSSPbN+h8BguW8JTIxafbEQMqLgJJVc5yVsVt
	PBvtsP2U3Wl08+AkHYZTfflrK0XKAHp0SqlqvTksfVSTeOeK5RcduZJxMSOLzVM8kSdBM/MqV+k9J
	d++9jVzWY1dm4mtjRvUyuUiUBXpCXL1MxzymCPzsC/qEEFeyMUH4pAyqX1awuHNLbZHrl1ixBhVFR
	Kv+Cz+/nGuo0oVfIViMpO57DV+OIMOsRu0wMISZlro5Jboi/IzPaocc5UVsc+pm1l+AKqPug0I5ot
	9XROLZhg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oagsi-005MRS-Bq; Tue, 20 Sep 2022 17:18:00 +0000
Received: from [77.247.85.102] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oagrj-005LlI-Cd; Tue, 20 Sep 2022 17:16:59 +0000
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH 13/13] nvme: remove nvme_ctrl_init_connect_q
Date: Tue, 20 Sep 2022 19:16:11 +0200
Message-Id: <20220920171611.1289361-14-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220920171611.1289361-1-hch@lst.de>
References: <20220920171611.1289361-1-hch@lst.de>
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

Unused now.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/nvme.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 6dec8a3bef1aa..4a845e9f17e47 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -976,14 +976,6 @@ static inline int nvme_update_zone_info(struct nvme_ns *ns, unsigned lbaf)
 }
 #endif
 
-static inline int nvme_ctrl_init_connect_q(struct nvme_ctrl *ctrl)
-{
-	ctrl->connect_q = blk_mq_init_queue(ctrl->tagset);
-	if (IS_ERR(ctrl->connect_q))
-		return PTR_ERR(ctrl->connect_q);
-	return 0;
-}
-
 static inline struct nvme_ns *nvme_get_ns_from_dev(struct device *dev)
 {
 	return dev_to_disk(dev)->private_data;
-- 
2.30.2



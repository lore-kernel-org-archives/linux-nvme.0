Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7C47C47DD9
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Feb 2024 18:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NXAbdD8CMNQ53MD8CHkDfC00JOZu8SZy2rSj/nwLb6g=; b=O2XxrysYcNSIMfiM9blGKwt0Vm
	o3WRM/rsqpJZ4DY9XorEYSVHb6y9aEo1i7w2FGKEPe0g3eBUV5bcx8bs2ioBSFjEM8nrBVSC4oSXr
	W2rwcdF3qaxvxMsQQZsAXO+YNkZAzrjKcOlkp8CpOuD4fWYgrlEJmUuab363lf+j5XpMcjo1K3KDr
	MkWT6HafT7rAMaf80DN1E2dtC+HIJzi2yN1nPfNYEAh3VpSCUVjv+iiXU1ITAffqqQgkVxQ0JEKUf
	ytmLvzP5RkmgVcK86r0ZAaXEYfjScgE7TQSjzcg1T4n4BL7LKfwCzlUY0ySxInM4Z2lqHgPm1Idi4
	rhrKvO6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfOQ0-0000000ARPD-2SMn;
	Wed, 28 Feb 2024 18:12:36 +0000
Received: from [4.28.11.157] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfOPk-0000000ARDw-2OFi;
	Wed, 28 Feb 2024 18:12:20 +0000
From: Christoph Hellwig <hch@lst.de>
To: Hector Martin <marcan@marcan.st>,
	Sven Peter <sven@svenpeter.dev>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	asahi@lists.linux.dev,
	linux-nvme@lists.infradead.org
Subject: [PATCH 07/21] nvme: cleanup the nvme_init_integrity calling conventions
Date: Wed, 28 Feb 2024 10:12:01 -0800
Message-Id: <20240228181215.873854-8-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240228181215.873854-1-hch@lst.de>
References: <20240228181215.873854-1-hch@lst.de>
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

Handle the no metadata support case in nvme_init_integrity as well to
simplify the calling convention and prepare for future changes in the
area.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 94d835f9dc90e9..76e548902ec33e 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1723,11 +1723,21 @@ int nvme_getgeo(struct block_device *bdev, struct hd_geometry *geo)
 	return 0;
 }
 
-#ifdef CONFIG_BLK_DEV_INTEGRITY
-static void nvme_init_integrity(struct gendisk *disk, struct nvme_ns_head *head)
+static bool nvme_init_integrity(struct gendisk *disk, struct nvme_ns_head *head)
 {
 	struct blk_integrity integrity = { };
 
+	if (!head->ms)
+		return true;
+
+	/*
+	 * PI can always be supported as we can ask the controller to simply
+	 * insert/strip it, which is not possible for other kinds of metadata.
+	 */
+	if (!IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY) ||
+	    !(head->features & NVME_NS_METADATA_SUPPORTED))
+		return nvme_ns_has_pi(head);
+
 	switch (head->pi_type) {
 	case NVME_NS_DPS_PI_TYPE3:
 		switch (head->guard_type) {
@@ -1772,12 +1782,8 @@ static void nvme_init_integrity(struct gendisk *disk, struct nvme_ns_head *head)
 	integrity.tuple_size = head->ms;
 	integrity.pi_offset = head->pi_offset;
 	blk_integrity_register(disk, &integrity);
+	return true;
 }
-#else
-static void nvme_init_integrity(struct gendisk *disk, struct nvme_ns_head *head)
-{
-}
-#endif /* CONFIG_BLK_DEV_INTEGRITY */
 
 static void nvme_config_discard(struct nvme_ctrl *ctrl, struct gendisk *disk,
 		struct nvme_ns_head *head)
@@ -2012,13 +2018,8 @@ static void nvme_update_disk_info(struct nvme_ctrl *ctrl, struct gendisk *disk,
 	 * I/O to namespaces with metadata except when the namespace supports
 	 * PI, as it can strip/insert in that case.
 	 */
-	if (head->ms) {
-		if (IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY) &&
-		    (head->features & NVME_NS_METADATA_SUPPORTED))
-			nvme_init_integrity(disk, head);
-		else if (!nvme_ns_has_pi(head))
-			capacity = 0;
-	}
+	if (!nvme_init_integrity(disk, head))
+		capacity = 0;
 
 	set_capacity_and_notify(disk, capacity);
 
-- 
2.39.2



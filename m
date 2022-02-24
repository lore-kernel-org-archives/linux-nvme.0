Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FE2CC433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Feb 2022 10:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Svt6wzNOJnc93gR6ua4EASmbOqUgE0UxcYsSw5MB/g4=; b=G186r/s+2M8XOFgxfpPRJvC7BQ
	dRJ2kzVK5/dtE8bO7C4xXuWWRlAFAKgFMK3GGB9P3lJWJlUwhr72PewstNNUmjbiau/wh21cWPP2H
	MR3Fe3KygizPeNtzpGNMrad4MrkVvlnThK4CZAAJXrX/CJ48//VQ/R1dnUnVW6KhabI2/4LVcP7aN
	FMbT6tii7lVXz94BzlZcjCEplo819kdvt3O+z1BgO783DGXlpV4NqgYcvnHukFWXxJIdu/f18fNBZ
	tvniqnl7p5RbmUcM8AeMoRuv4PnnyJ/BADvbpxes/14bHy92hXpI+aPQvYaMuIY5p8fLt3Px7ZUEx
	UCLadsAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nNBqH-000RoB-MF; Thu, 24 Feb 2022 10:59:25 +0000
Received: from [2001:4bb8:198:f8fc:e55d:3b08:349b:3812] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nNBpu-000Rgk-Tm; Thu, 24 Feb 2022 10:59:03 +0000
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH 3/3] nvme: check that EUI/GUID/UUID are globally unique
Date: Thu, 24 Feb 2022 11:58:52 +0100
Message-Id: <20220224105852.862715-4-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220224105852.862715-1-hch@lst.de>
References: <20220224105852.862715-1-hch@lst.de>
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

Add a check to verify that the unique identifiers are unique globally
in addition to the existing check that verifies that they are unique
inside a single subsystem.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index ac4749f257439..4f9623d9f7ed9 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3783,7 +3783,7 @@ static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ctrl *ctrl,
 	ret = nvme_subsys_check_duplicate_ids(ctrl->subsys, &head->ids);
 	if (ret) {
 		dev_err(ctrl->device,
-			"duplicate IDs for nsid %d\n", nsid);
+			"duplicate IDs in subsystem for nsid %d\n", nsid);
 		goto out_cleanup_srcu;
 	}
 
@@ -3815,12 +3815,40 @@ static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ctrl *ctrl,
 	return ERR_PTR(ret);
 }
 
+static int nvme_global_check_ids(struct nvme_subsystem *this,
+		struct nvme_ns_ids *ids)
+{
+	struct nvme_subsystem *s;
+	int ret = 0;
+
+	mutex_lock(&nvme_subsystems_lock);
+	list_for_each_entry(s, &nvme_subsystems, entry) {
+		if (s == this)
+			continue;
+		mutex_lock(&s->lock);
+		ret = nvme_subsys_check_duplicate_ids(s, ids);
+		mutex_unlock(&s->lock);
+		if (ret)
+			break;
+	}
+	mutex_unlock(&nvme_subsystems_lock);
+
+	return ret;
+}
+
 static int nvme_init_ns_head(struct nvme_ns *ns, unsigned nsid,
 		struct nvme_ns_ids *ids, bool is_shared)
 {
 	struct nvme_ctrl *ctrl = ns->ctrl;
 	struct nvme_ns_head *head = NULL;
-	int ret = 0;
+	int ret;
+
+	ret = nvme_global_check_ids(ctrl->subsys, ids);
+	if (ret) {
+		dev_err(ctrl->device,
+			"globally duplicate IDs for nsid %d\n", nsid);
+		return ret;
+	}
 
 	mutex_lock(&ctrl->subsys->lock);
 	head = nvme_find_ns_head(ctrl->subsys, nsid);
-- 
2.30.2



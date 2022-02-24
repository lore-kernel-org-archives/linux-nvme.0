Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 858FFC433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Feb 2022 19:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bgmcrelMqjRNYglMSFockKBbWTao6BYkNcRuOQ03f/o=; b=28lDQsLYZXteTRwBcHL/CxfK7C
	Wz5SncT7Z9QHA06cTutxt5hJ2V+FQT9SPJp8A0FNj1+A1v7dvFciYS6PBGzFAzhgXOUbXF223NHYm
	cv13fQGHDui3lRot4FBAvb9Ri7QUvmGAb+DhgIBOCs0uV99+zTWKQpeDXpAJ4GBFEE9WIxjggpOTo
	2g4JT0rLgMz2f59BB6Evgmmq9etP3KzDjrOx9dczsz6vHxyd7mODkJhmthqmRtvj2m9RK/H6BKkQR
	F5tMVVk3eR3JoQySY7qbEZREbeAG8nE11d7eWwmBDTGkxnWZdpGwZd+mntqeG6yeCwhZlpEVffZ3Y
	JxaiV4hQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nNJnl-0028jB-4L; Thu, 24 Feb 2022 19:29:21 +0000
Received: from 089144202139.atnat0011.highway.a1.net ([89.144.202.139]
 helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nNJnN-0028bw-FP; Thu, 24 Feb 2022 19:28:57 +0000
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH 3/4] nvme: check for duplicate identifiers earlier
Date: Thu, 24 Feb 2022 20:28:44 +0100
Message-Id: <20220224192845.1097602-4-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220224192845.1097602-1-hch@lst.de>
References: <20220224192845.1097602-1-hch@lst.de>
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

Lift the check for duplicate identifiers into nvme_init_ns_head, which
avoids pointless error unwinding in case they don't match, and also
matches where we check identifier validity for the multipath case.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 3e6ac985b24f6..cece987ba1691 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3782,13 +3782,6 @@ static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ctrl *ctrl,
 	head->ids = *ids;
 	kref_init(&head->ref);
 
-	ret = nvme_subsys_check_duplicate_ids(ctrl->subsys, &head->ids);
-	if (ret) {
-		dev_err(ctrl->device,
-			"duplicate IDs for nsid %d\n", nsid);
-		goto out_cleanup_srcu;
-	}
-
 	if (head->ids.csi) {
 		ret = nvme_get_effects_log(ctrl, head->ids.csi, &head->effects);
 		if (ret)
@@ -3827,6 +3820,12 @@ static int nvme_init_ns_head(struct nvme_ns *ns, unsigned nsid,
 	mutex_lock(&ctrl->subsys->lock);
 	head = nvme_find_ns_head(ctrl->subsys, nsid);
 	if (!head) {
+		ret = nvme_subsys_check_duplicate_ids(ctrl->subsys, ids);
+		if (ret) {
+			dev_err(ctrl->device,
+				"duplicate IDs for nsid %d\n", nsid);
+			goto out_unlock;
+		}
 		head = nvme_alloc_ns_head(ctrl, nsid, ids);
 		if (IS_ERR(head)) {
 			ret = PTR_ERR(head);
-- 
2.30.2



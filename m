Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBDA0C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Feb 2022 10:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mvXS8295GoEx5GrixerXfCMalWLv3SmJaD877uOicdk=; b=3KYskFxDQqkkczjjS8SJEjzdDc
	T/EqvKDCVoHYxoWw5UDn5FKOzBcSWjSGNc8ZZpbiFv7tGChoPpDV+t1wkhecrvzWwxQFh0oyzKbmm
	y4E86oCtEO0DY9bBzMz7wI626V/FzXQwGQ9ED5CekLA2LKVtUvdiJJXwKDHKMCSf5I2JJd/brxx8p
	/1Y8MzzWsbRGF767yMHlOw1wf5b8Ig18bRE8Ei1EV/CzU47hkuxMnce/oO/tCQUs+xxOlNCbQYyzA
	A12kVZAuB3MmbDS4oAk0vHGlXVKRGccuaNMKQxkVOIpst10KTf2+P/cvMQgCBm2P6WpJlVniH+e5g
	o+DgQOcg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nNBpy-000Ri5-Ra; Thu, 24 Feb 2022 10:59:06 +0000
Received: from [2001:4bb8:198:f8fc:e55d:3b08:349b:3812] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nNBpp-000Rfb-Ny; Thu, 24 Feb 2022 10:58:58 +0000
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH 1/3] nvme: cleanup __nvme_check_ids
Date: Thu, 24 Feb 2022 11:58:50 +0100
Message-Id: <20220224105852.862715-2-hch@lst.de>
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

Pass the actual nvme_ns_ids used for the comparism instead of the
ns_head that isn't needed and use a more descriptive function name.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 9cffc4770e737..076a03b801b7e 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3673,16 +3673,15 @@ static struct nvme_ns_head *nvme_find_ns_head(struct nvme_subsystem *subsys,
 	return NULL;
 }
 
-static int __nvme_check_ids(struct nvme_subsystem *subsys,
-		struct nvme_ns_head *new)
+static int nvme_subsys_check_duplicate_ids(struct nvme_subsystem *subsys,
+		struct nvme_ns_ids *ids)
 {
 	struct nvme_ns_head *h;
 
 	lockdep_assert_held(&subsys->lock);
 
 	list_for_each_entry(h, &subsys->nsheads, entry) {
-		if (nvme_ns_ids_valid(&new->ids) &&
-		    nvme_ns_ids_equal(&new->ids, &h->ids))
+		if (nvme_ns_ids_valid(ids) && nvme_ns_ids_equal(ids, &h->ids))
 			return -EINVAL;
 	}
 
@@ -3781,7 +3780,7 @@ static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ctrl *ctrl,
 	head->ids = *ids;
 	kref_init(&head->ref);
 
-	ret = __nvme_check_ids(ctrl->subsys, head);
+	ret = nvme_subsys_check_duplicate_ids(ctrl->subsys, &head->ids);
 	if (ret) {
 		dev_err(ctrl->device,
 			"duplicate IDs for nsid %d\n", nsid);
-- 
2.30.2



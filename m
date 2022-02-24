Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 523C4C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Feb 2022 19:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HrHDgYQ2ac1u+r4G1GnmYfjiCddpW0/Lza1bFCEuEBQ=; b=d0O6/lLgmtpwSnxFAu7I1Paar5
	jG7se9uP4i47LJsuhVn7pfRaVkP4FWvv8zZ2I87qDrtyDKSM4/fSYy7cDXinhoDsWUAoO3RAiRefJ
	t3IysHyNBdS+Uc3s3f2Y/2Ezyj0hozn8JE+P5ocjIflb6WcIRjirqBG4XbKequ9iuPcaDHv+Zfolv
	/LGhSymEFEmvJ8RlpbXjCl0IBc0S2SOG+2WQJAXlEXnptZp9GmU2gTgOtaDuFSAuXs3/z0N5BNmbJ
	5yVpz4NQMgxTU76QPr8jOKQ/LjSiLEqBXrr7i2UAsBve+q2lrZWAWwvnPK/v3wVx7COGYZ9xqk/dl
	/RvpFRYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nNJnX-0028eZ-2Q; Thu, 24 Feb 2022 19:29:07 +0000
Received: from 089144202139.atnat0011.highway.a1.net ([89.144.202.139]
 helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nNJnK-0028bK-9w; Thu, 24 Feb 2022 19:28:54 +0000
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH 2/4] nvme: fix the check for duplicate unique identifiers
Date: Thu, 24 Feb 2022 20:28:43 +0100
Message-Id: <20220224192845.1097602-3-hch@lst.de>
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

nvme_subsys_check_duplicate_ids should needs to return an error if any of
the identifiers matches, not just if all of them match.  But it does not
need to and should not look at the CSI value for this sanity check.

Rewrite the logic to be separate from nvme_ns_ids_equal and optimize it
by reducing duplicate checks for non-present identifiers.

Fixes: ed754e5deeb1 ("nvme: track shared namespaces")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 076a03b801b7e..3e6ac985b24f6 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1716,13 +1716,6 @@ static void nvme_config_discard(struct gendisk *disk, struct nvme_ns *ns)
 		blk_queue_max_write_zeroes_sectors(queue, UINT_MAX);
 }
 
-static bool nvme_ns_ids_valid(struct nvme_ns_ids *ids)
-{
-	return !uuid_is_null(&ids->uuid) ||
-		memchr_inv(ids->nguid, 0, sizeof(ids->nguid)) ||
-		memchr_inv(ids->eui64, 0, sizeof(ids->eui64));
-}
-
 static bool nvme_ns_ids_equal(struct nvme_ns_ids *a, struct nvme_ns_ids *b)
 {
 	return uuid_equal(&a->uuid, &b->uuid) &&
@@ -3676,12 +3669,21 @@ static struct nvme_ns_head *nvme_find_ns_head(struct nvme_subsystem *subsys,
 static int nvme_subsys_check_duplicate_ids(struct nvme_subsystem *subsys,
 		struct nvme_ns_ids *ids)
 {
+	bool has_uuid = !uuid_is_null(&ids->uuid);
+	bool has_nguid = memchr_inv(ids->nguid, 0, sizeof(ids->nguid));
+	bool has_eui64 = memchr_inv(ids->eui64, 0, sizeof(ids->eui64));
 	struct nvme_ns_head *h;
 
 	lockdep_assert_held(&subsys->lock);
 
 	list_for_each_entry(h, &subsys->nsheads, entry) {
-		if (nvme_ns_ids_valid(ids) && nvme_ns_ids_equal(ids, &h->ids))
+		if (has_uuid && uuid_equal(&ids->uuid, &h->ids.uuid))
+			return -EINVAL;
+		if (has_nguid &&
+		    memcmp(&ids->nguid, &h->ids.nguid, sizeof(ids->nguid)) == 0)
+			return -EINVAL;
+		if (has_eui64 &&
+		    memcmp(&ids->eui64, &h->ids.eui64, sizeof(ids->eui64)) == 0)
 			return -EINVAL;
 	}
 
-- 
2.30.2



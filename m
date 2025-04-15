Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADD41C369AB
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Apr 2025 06:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=dgrR+jsWMGJQc7lUCuqx/YoqCwjwiYqqThv8mqY7/v4=; b=4ul6UsG1Wdslzm99pZ14tAJdWR
	gn3Gr1Wmuqtn06m3llaTinumf0iIlapi6CBmYKEFBAJOv3Nt9JemD/+K5FXw8mQCH2YTsCFo1on7V
	hiRY/+joaD5e42cJ4tjXJTesCUBysM3IzuDPH2GhXIDQM75ytM+rQoCeL4Wwkn0w7RQCd22VM8Kz4
	dcec5BKu/FjN+YLMWsBKaEPYGGiWGdCJParFYBLD+Xoj44W9Iew+XYd/tHUfeuCiQRRW/7F0krOT0
	EtSMECfHjajf8GlgkcM43UJYSqHMsyOGW9F8cS7PpD24MCveeJnoQpuGDKlddKiQZBLePqBsttsth
	n/r5lmXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4a5D-00000004hia-3kKW;
	Tue, 15 Apr 2025 06:47:47 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4a5A-00000004hi5-3VCx
	for linux-nvme@lists.infradead.org;
	Tue, 15 Apr 2025 06:47:45 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 13E945C5547;
	Tue, 15 Apr 2025 06:45:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5027BC4CEDD;
	Tue, 15 Apr 2025 06:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744699663;
	bh=9DgTYZP6XZ6cSA55OvjXtrWJ31N49jMbHH/CotLlj2A=;
	h=From:To:Cc:Subject:Date:From;
	b=ZNnLu6k/mthnOrZakzU33Leh05zNdI6BRaS9K2BNH5/S+v/fplDT2cHHSybXrzwDh
	 LcH5V+jPhS4L888icFCR55exHZMvWh7HAsHfmm+YDQWcmKPvKmepdEbMRK+pOuX1Kv
	 UxqpEG20NgMdSlP97i56xgy7YcwjeDntelT2/sFLkDmQyxgVVdovQEz3tLc5J6gHSR
	 XBVoXtS+CmrtMX4BApxtBP5PTlJ8jDh7dA4wpB1PZVdjWVJeBn0C5eKcAWJbpUBAkK
	 /ksQjSSfT207jmIyO8KKC+cvxfJZ+dKri9Q0vz0aNzyvyxB6P0bQzODVGBGRIWy+Kz
	 SbZiThwi7eh7Q==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>,
	Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCHv2] nvme-multipath: sysfs links may not be created for devices
Date: Tue, 15 Apr 2025 08:47:37 +0200
Message-Id: <20250415064737.80953-1-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250414_234744_927945_236A78FA 
X-CRM114-Status: GOOD (  13.25  )
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

When rapidly rescanning for new namespaces nvme_mpath_add_sysfs_link() may be
called for a block device not added to sysfs. But NVME_NS_SYSFS_ATTR_LINK
had already been set, so when checking this device a second time we will fail
to create the link.

Fix this by exchanging the order of the block device check and the
NVME_NS_SYSFS_ATTR_LINK bit check.

Fixes: 4dbd2b2ebe4c ("nvme-multipath: Add visibility for round-robin io-policy")

Signed-off-by: Hannes Reinecke <hare@kernel.org>
Cc: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/multipath.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 05eccd96d34a..250f3da67cc9 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -1050,6 +1050,13 @@ void nvme_mpath_add_sysfs_link(struct nvme_ns_head *head)
 	srcu_idx = srcu_read_lock(&head->srcu);
 
 	list_for_each_entry_rcu(ns, &head->list, siblings) {
+		/*
+		 * Ensure that ns path disk node is already added otherwise we
+		 * may get invalid kobj name for target
+		 */
+		if (!test_bit(GD_ADDED, &ns->disk->state))
+			continue;
+
 		/*
 		 * Avoid creating link if it already exists for the given path.
 		 * When path ana state transitions from optimized to non-
@@ -1065,13 +1072,6 @@ void nvme_mpath_add_sysfs_link(struct nvme_ns_head *head)
 		if (test_and_set_bit(NVME_NS_SYSFS_ATTR_LINK, &ns->flags))
 			continue;
 
-		/*
-		 * Ensure that ns path disk node is already added otherwise we
-		 * may get invalid kobj name for target
-		 */
-		if (!test_bit(GD_ADDED, &ns->disk->state))
-			continue;
-
 		target = disk_to_dev(ns->disk);
 		/*
 		 * Create sysfs link from head gendisk kobject @kobj to the
-- 
2.35.3



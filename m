Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85253EE4987
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Sep 2024 09:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ly8QYVuqgr/ChfAJ1ymsP+7I2zikb0R/vnhWU7Ch2v4=; b=Ej/vkSmd832T7lPpNyG8ULe6Yh
	nB3/vJ49HI5v5ys4Aw1S8p8DQuZtKNioBuUr5pOt7iS9J4/sUL3iNpbBJmoyfwYkxW1+fAMjrs8TT
	a37ncCE8QEmk8L8fzOmK5JFmxgrfsdNXsOhNnyb2RY8cBE0LCwUvOfnuw5G0okcXfwAfTcKg2UYpJ
	Vj+qM0/DDglUq3Dyn2lgwJe5H96fNSZPR5a9IQUTJ4Ogyj7UinrDb5t9YGn9EOrHHD2sJ3RG4KG2C
	mNsISzF9i9FVTbAOmphJT1IqoOXKRrN0oLZWDgBb0f8/AZgzr4A2CvLxqRw8TUfFcltUOc8qb7oje
	UXNZ91Qw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1soK0f-00000008zTK-3uXQ;
	Wed, 11 Sep 2024 09:51:37 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1soK0P-00000008zNm-1Nno
	for linux-nvme@lists.infradead.org;
	Wed, 11 Sep 2024 09:51:35 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 526DB5C0318;
	Wed, 11 Sep 2024 09:51:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57792C4CEC5;
	Wed, 11 Sep 2024 09:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726048280;
	bh=vbJsC4YOvHredfadB0MPSv92Z8Cddd8yBUytLfj2u8w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rqYwfrkaTBI6sDLmur8LVdBCqY04FGe3ai6k4/HjDEjaJiB75BtV4kGo82IED+OIl
	 OBjIbBREgD7xFMay+e2qtqGtbvwRcLis3qb+aPknOGxdIrHmEV3a97k9YISphr/6dp
	 AfUx/eM0MWpRRmQCwuLxZ0v1NPCQ5Vkrth/zYCAXeS8n94OWGj1C6CqD7ONddHy3yS
	 Os3pkMJZ5SweH6ZExLUUAzw/VOepQb22/G8BNx3rbTcn75U74tzDcniGMY3AUidb4G
	 j8/a0zVphy1seFMZwgJjv2kJwvTKmlds0pz8YLdC8ow0DVEOtN99WrD9gEs/ZBYCbU
	 Yt4cKR30PQ7LQ==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 3/3] nvme-multipath: skip inaccessible paths during partition scan
Date: Wed, 11 Sep 2024 11:51:07 +0200
Message-Id: <20240911095107.121688-4-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240911095107.121688-1-hare@kernel.org>
References: <20240911095107.121688-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240911_025121_432044_BD483E2B 
X-CRM114-Status: GOOD (  15.42  )
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

When a path is switched to 'inaccessible' during partition scan
triggered via device_add_disk() and we only have one path the
system will be stuck as nvme_available_path() will always return
'true'. So I/O will never be completed and the system is stuck
in device_add_disk().
This patch introduces a flag NVME_NSHEAD_DISABLE_QUEUEING to
cause nvme_available_path() to always return NULL, and with
that I/O to be failed if all paths are unavailable.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/host/multipath.c | 10 +++++++++-
 drivers/nvme/host/nvme.h      |  1 +
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index f72c5a6a2d8e..bcd70755c663 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -421,7 +421,8 @@ static bool nvme_available_path(struct nvme_ns_head *head)
 {
 	struct nvme_ns *ns;
 
-	if (!test_bit(NVME_NSHEAD_DISK_LIVE, &head->flags))
+	if (!test_bit(NVME_NSHEAD_DISK_LIVE, &head->flags) ||
+	    test_bit(NVME_NSHEAD_DISABLE_QUEUEING, &head->flags))
 		return NULL;
 
 	list_for_each_entry_rcu(ns, &head->list, siblings) {
@@ -646,8 +647,15 @@ static void nvme_mpath_set_live(struct nvme_ns *ns)
 	 * head.
 	 */
 	if (!test_and_set_bit(NVME_NSHEAD_DISK_LIVE, &head->flags)) {
+		/*
+		 * Disable queueing to ensure I/O is not retried on unusable
+		 * paths, which would cause the system to be stuck during
+		 * partition scan.
+		 */
+		set_bit(NVME_NSHEAD_DISABLE_QUEUEING, &head->flags);
 		rc = device_add_disk(&head->subsys->dev, head->disk,
 				     nvme_ns_attr_groups);
+		clear_bit(NVME_NSHEAD_DISABLE_QUEUEING, &head->flags);
 		if (rc) {
 			clear_bit(NVME_NSHEAD_DISK_LIVE, &head->flags);
 			return;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 50515ad0f9d6..f45ca7c45fd2 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -493,6 +493,7 @@ struct nvme_ns_head {
 	struct mutex		lock;
 	unsigned long		flags;
 #define NVME_NSHEAD_DISK_LIVE	0
+#define NVME_NSHEAD_DISABLE_QUEUEING	1
 	struct nvme_ns __rcu	*current_path[];
 #endif
 };
-- 
2.35.3



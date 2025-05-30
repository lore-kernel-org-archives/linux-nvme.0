Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B908EC5B543
	for <linux-nvme@archiver.kernel.org>; Fri, 30 May 2025 12:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=dDA62x3BSIb2xoF4Tc6X3P/MnQaS9sGqfrpz6KRb4pI=; b=kERSoN/rzT15zPYxhtu0SWEXj8
	xBV7hTBdPFLd4b1fuib5yIdD+iADZBgdJA7CGTehHLHNgWcT2HxGY+T4zjtNGit1X8bhetAleDczQ
	hyPMttIGvdsx6baatNx70bLbU9VYFWNHCXsb4XPjEWHegUOvDeytfwJSKlsgKIYGqxGmEtAVgJLvJ
	avk0EsK5VZtobzQerabGafZPuz898cMojgJo8I41KdIT+8L5+7hqVXIdYHZBsHx1BtwbtfXZhFlQ7
	9zppSQxNYWDd1CScdB0FlTKmO6lcjnWWIGBEYael9VgxGC1cfuz+FgLPf9yCeVetzinJdyOcG2iNa
	KHF/zCFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKyQq-00000000UiQ-3ZVb;
	Fri, 30 May 2025 12:01:52 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKyQo-00000000Uh7-1S2k
	for linux-nvme@lists.infradead.org;
	Fri, 30 May 2025 12:01:51 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 6B97A5C633A;
	Fri, 30 May 2025 11:59:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBE8CC4CEE9;
	Fri, 30 May 2025 12:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748606509;
	bh=x0U/HUw+EU45ftZnmfaQB4ZS2E5b5q/c8HKxh90LCYc=;
	h=From:To:Cc:Subject:Date:From;
	b=H1LoWX3+pYr2O1iM5w6YcsJo+4EDc/d/D+rwQzPlvmN4NsPtHNVtcxaBVDos94mZN
	 nK0rWUZT4PmXPCTpTpD4xC13cS+Lp0iKQuxaBNw+9xSIFXMkNISynpADsVUhlz+VeH
	 bLVyBUAsOVKaSloEV/V1gxUOFtIWjwsxlKyApRMMnryTGXpS22iY4vlmzFJSYSg9Jj
	 yITMcbsQgYYmUYbOxxHuJyIksYXr3CJGI9Glf/LzTp9gye/CDMMI7MaE3QpHT7CrSM
	 sk3u5LX0kooZtO4kVOItGBq6V+sfmFzsQGV6JOzX6GO7fhiWXb6LEjgL6tUE288Ir3
	 avDQFNAafniBg==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH] nvme: Allow sending of admin commands to inaccessible paths
Date: Fri, 30 May 2025 14:01:42 +0200
Message-Id: <20250530120142.130469-1-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250530_050150_473109_86F9DB00 
X-CRM114-Status: GOOD (  17.44  )
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

The NVMe Base Specification (Section 8.1.1.10) specifies that admin
commands should not be affected by ANA states. So implement a function
nvme_find_admin_path() to return the first non-disabled path irrespective
of the ANA state.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/host/ioctl.c     | 33 +++++++++++++++++++------------
 drivers/nvme/host/multipath.c | 37 +++++++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h      |  1 +
 3 files changed, 58 insertions(+), 13 deletions(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 5d5f8b07cdec..1cf66d8b2d7f 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -723,19 +723,22 @@ int nvme_ns_head_ioctl(struct block_device *bdev, blk_mode_t mode,
 		flags |= NVME_IOCTL_PARTITION;
 
 	srcu_idx = srcu_read_lock(&head->srcu);
+	if (is_ctrl_ioctl(cmd)) {
+		ns = nvme_find_admin_path(head);
+		if (!ns)
+			goto out_unlock;
+		/*
+		 * Handle ioctls that apply to the controller instead of the namespace
+		 * seperately and drop the ns SRCU reference early.  This avoids a
+		 * deadlock when deleting namespaces using the passthrough interface.
+		 */
+		return nvme_ns_head_ctrl_ioctl(ns, cmd, argp, head, srcu_idx,
+					       open_for_write);
+	}
 	ns = nvme_find_path(head);
 	if (!ns)
 		goto out_unlock;
 
-	/*
-	 * Handle ioctls that apply to the controller instead of the namespace
-	 * seperately and drop the ns SRCU reference early.  This avoids a
-	 * deadlock when deleting namespaces using the passthrough interface.
-	 */
-	if (is_ctrl_ioctl(cmd))
-		return nvme_ns_head_ctrl_ioctl(ns, cmd, argp, head, srcu_idx,
-					       open_for_write);
-
 	ret = nvme_ns_ioctl(ns, cmd, argp, flags, open_for_write);
 out_unlock:
 	srcu_read_unlock(&head->srcu, srcu_idx);
@@ -754,13 +757,17 @@ long nvme_ns_head_chr_ioctl(struct file *file, unsigned int cmd,
 	int srcu_idx, ret = -EWOULDBLOCK;
 
 	srcu_idx = srcu_read_lock(&head->srcu);
-	ns = nvme_find_path(head);
-	if (!ns)
-		goto out_unlock;
+	if (is_ctrl_ioctl(cmd)) {
+		ns = nvme_find_admin_path(head);
+		if (!ns)
+			goto out_unlock;
 
-	if (is_ctrl_ioctl(cmd))
 		return nvme_ns_head_ctrl_ioctl(ns, cmd, argp, head, srcu_idx,
 				open_for_write);
+	}
+	ns = nvme_find_path(head);
+	if (!ns)
+		goto out_unlock;
 
 	ret = nvme_ns_ioctl(ns, cmd, argp, 0, open_for_write);
 out_unlock:
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 3fdbbe1fdbc4..d225c518a32c 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -473,6 +473,43 @@ inline struct nvme_ns *nvme_find_path(struct nvme_ns_head *head)
 	}
 }
 
+inline struct nvme_ns *nvme_find_admin_path(struct nvme_ns_head *head)
+{
+	struct nvme_ns *found = NULL, *fallback = NULL, *ns;
+
+	ns = srcu_dereference(head->current_path[numa_node_id()], &head->srcu);
+	if (ns && !nvme_path_is_disabled(ns))
+		return ns;
+
+	/*
+	 * Return the first optimized path or, failing that, the first non-
+	 * disabled path. Processing rules for admin commands are different
+	 * than those for I/O commands (NVMe Base Spec v2.2 section 8.1.1.10
+	 * "Asymmetric Namespace Access States Command Processing Effects")
+	 * so do not set the current path.
+	 */
+	list_for_each_entry_srcu(ns, &head->list, siblings,
+				 srcu_read_lock_held(&head->srcu)) {
+		if (nvme_path_is_disabled(ns))
+			continue;
+
+		switch (ns->ana_state) {
+		case NVME_ANA_OPTIMIZED:
+			return ns;
+		case NVME_ANA_NONOPTIMIZED:
+			found = ns;
+			break;
+		default:
+			fallback = ns;
+			break;
+		}
+	}
+
+	if (!found)
+		found = fallback;
+	return found;
+}
+
 static bool nvme_available_path(struct nvme_ns_head *head)
 {
 	struct nvme_ns *ns;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 45beb701011b..1d236a7ba757 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -952,6 +952,7 @@ extern const struct block_device_operations nvme_bdev_ops;
 
 void nvme_delete_ctrl_sync(struct nvme_ctrl *ctrl);
 struct nvme_ns *nvme_find_path(struct nvme_ns_head *head);
+struct nvme_ns *nvme_find_admin_path(struct nvme_ns_head *head);
 #ifdef CONFIG_NVME_MULTIPATH
 static inline bool nvme_ctrl_use_ana(struct nvme_ctrl *ctrl)
 {
-- 
2.35.3



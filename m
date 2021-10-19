Return-Path: <SRS0=W3/M=PH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 683C1C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Oct 2021 15:48:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B3E7610C7
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Oct 2021 15:48:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2B3E7610C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=+TqBun+VinlpbHjmMXQk0cEyjiNVHwkCqNzn8cecW+g=; b=brj8kG4NwiCmDBhOs2rN1IBS3S
	3wzJy9oJ9MRC/NUfpsM5BBs1pJS5/jniDnSn2jRy6CLdG0GEYuLbtIl/JAA7uCQAx6FPK2UaXCVHC
	2qPEC9F3/HbY658UXjDS40KYS5GSUUvorwCzDVMftHRWpFaY8U+kwLYoMu9Djf1nkIeN3uxhkkdRb
	NgauyqlewRxap32cC0OFwZPixyMSHVv7VVhli9cLS/huk7Uc72er2NozYAfohD7FWcSeTWiK60QIm
	ODBPb30ENTGPL6orPV/q18FafKjIz6yOjEjoSXa/skKLSOL3IXZfHj7yx2xyxx4GN8evEbWV06XJb
	c2Kw3ahA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mcrLo-001kUr-SI; Tue, 19 Oct 2021 15:48:28 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mcrLl-001kU0-Tn
 for linux-nvme@lists.infradead.org; Tue, 19 Oct 2021 15:48:27 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 8FACE1FD29;
 Tue, 19 Oct 2021 15:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1634658504; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=+TqBun+VinlpbHjmMXQk0cEyjiNVHwkCqNzn8cecW+g=;
 b=NraK4xJt45GJAiq/pd6FpoTxsWcNCo4E6bUt+oIOIhSJhJ8QsxWGhWpxINfAh5YtToryXw
 bQ94R8sKyMFskjKd15m5ls2zdW9RiqyRP87vlsvPySl7eQjoOMPJOvhtpEk1UfCQfrN2du
 42cEg2LfpKl3V9FtH7csGxPECL228cM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1634658504;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=+TqBun+VinlpbHjmMXQk0cEyjiNVHwkCqNzn8cecW+g=;
 b=LEFjSLOmJY/ctCeYcYz55EPkQFin5EK213+4cyoJMr1jY8aai+4jcJF/JHY/o06n369X3B
 /VNx1IdZaz+z7aDg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 5C5BFA3B83;
 Tue, 19 Oct 2021 15:48:24 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id 4F41E518FC50; Tue, 19 Oct 2021 17:48:24 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH] nvme: invalidate paths when removing contoller
Date: Tue, 19 Oct 2021 17:48:23 +0200
Message-Id: <20211019154823.91586-1-hare@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211019_084826_130245_1A187540 
X-CRM114-Status: GOOD (  14.69  )
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

When the I/O from the initial partition scan encounters an error
it will not necessarily be failed, but might trigger a reconnect
with the I/O itself being requeued.
Upon disconnect we need to ensure to flush the requeue list
independent on the current path, otherwise the I/O will never
complete.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/core.c      |  2 +-
 drivers/nvme/host/multipath.c | 13 +++++++++++++
 drivers/nvme/host/nvme.h      |  4 ++++
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 4d676b5db413..380689a1407b 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4137,7 +4137,7 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
 	 * might result from the scan itself and must complete
 	 * for the scan_work to make progress
 	 */
-	nvme_mpath_clear_ctrl_paths(ctrl);
+	nvme_mpath_invalidate_paths(ctrl);
 
 	/* prevent racing with ns scanning */
 	flush_work(&ctrl->scan_work);
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index fb96e900dd3a..a86fef7b1c28 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -165,6 +165,19 @@ void nvme_mpath_revalidate_paths(struct nvme_ns *ns)
 		rcu_assign_pointer(head->current_path[node], NULL);
 }
 
+void nvme_mpath_invalidate_paths(struct nvme_ctrl *ctrl)
+{
+	struct nvme_ns *ns;
+
+	down_read(&ctrl->namespaces_rwsem);
+	list_for_each_entry(ns, &ctrl->namespaces, list) {
+		clear_bit(NVME_NS_READY, &ns->flags);
+		if (ns->head->disk)
+			kblockd_schedule_work(&ns->head->requeue_work);
+	}
+	up_read(&ctrl->namespaces_rwsem);
+}
+
 static bool nvme_path_is_disabled(struct nvme_ns *ns)
 {
 	/*
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 2c7a77f600f8..313e54d37e16 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -752,6 +752,7 @@ void nvme_mpath_stop(struct nvme_ctrl *ctrl);
 bool nvme_mpath_clear_current_path(struct nvme_ns *ns);
 void nvme_mpath_revalidate_paths(struct nvme_ns *ns);
 void nvme_mpath_clear_ctrl_paths(struct nvme_ctrl *ctrl);
+void nvme_mpath_invalidate_paths(struct nvme_ctrl *ctrl);
 void nvme_mpath_shutdown_disk(struct nvme_ns_head *head);
 
 static inline void nvme_trace_bio_complete(struct request *req)
@@ -804,6 +805,9 @@ static inline void nvme_mpath_revalidate_paths(struct nvme_ns *ns)
 static inline void nvme_mpath_clear_ctrl_paths(struct nvme_ctrl *ctrl)
 {
 }
+void nvme_mpath_invalidate_paths(struct nvme_ctrl *ctrl)
+{
+}
 static inline void nvme_mpath_shutdown_disk(struct nvme_ns_head *head)
 {
 }
-- 
2.29.2



Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FEF2EE57D5
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Sep 2023 06:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=fgRM8On6F2mD8VxKjwUBJiY4mcbNonmfYQRC10uV2/E=; b=vziOm5XekAEWeVfsiRD4F09rUk
	MwFvnkQn79hLB5JmHgW2zFzhsdmkgwK+MHwgx9Ni7XIsj6UA+nrzA3LQ0vH4dXpyudZH6LpatyN8X
	/1BxYT2zStAG0UK+XYhxKEWQPKSHDIv4hh5XTiplDAjK+WJzK8eb29gVzh0tqwVZWoLr15IliPBzs
	zHDSYa2XArPmb1WtjlqmSkhAVBSyZyNWGflEvKxl7i9gi6VJFIGfBjEV+hUC1S9eHdcO+qyAJuZXG
	MCseuQJ7F2HhkvBRBqfBtb7TyqZemIDOYV6ZPfrtAsbX2twLmVUHQqe4MkjJDIQCU5nC7FXzfBEZH
	4jCYNOhg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qeVQi-00DCrU-1g;
	Fri, 08 Sep 2023 06:57:24 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qeVQg-00DCr5-06
	for linux-nvme@lists.infradead.org;
	Fri, 08 Sep 2023 06:57:23 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out1.suse.de (Postfix) with ESMTP id 940E42166E;
	Fri,  8 Sep 2023 06:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1694156239; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=fgRM8On6F2mD8VxKjwUBJiY4mcbNonmfYQRC10uV2/E=;
	b=ZskWAmu4xCHqFHrSmTZf/Jsw4HekmABqtZSxrKamWS1IIGyHDNIgOrSbhihIJsbdcv1uim
	+vgOemenYBDXoiTxK3SQhsjk98yC3XDOuWxakc/QtGYkU1Vgp/QnjkOGJoxJXg+aRycDei
	JR9O1mE0sclMnxbOmP+MgXM8WyrW3/U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1694156239;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=fgRM8On6F2mD8VxKjwUBJiY4mcbNonmfYQRC10uV2/E=;
	b=HhHW7ypcqFpjUVGqH3X0mI1Ig/MajUghy9rp9QS2CUi5Vvus96d+XZiOQN6XnrAbLe2fxg
	QUrMmd9mbscbElCA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id 87ADA2C142;
	Fri,  8 Sep 2023 06:57:19 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 7A24851CC652; Fri,  8 Sep 2023 08:57:19 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH] nvme: add namespace paths links
Date: Fri,  8 Sep 2023 08:57:17 +0200
Message-Id: <20230908065717.92207-1-hare@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230907_235722_234571_2112759C 
X-CRM114-Status: GOOD (  12.05  )
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

It is really annoying to always have to loop through the entire
/sys/block directory just to find the namespace path links for
a single namespace in libnvme/nvme-cli.
So provide links to the namespace paths for efficient lookup.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/core.c      |  3 +++
 drivers/nvme/host/multipath.c | 10 ++++++++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 37b6fa746662..88933838e067 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3681,6 +3681,9 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 
 	if (!nvme_ns_head_multipath(ns->head))
 		nvme_cdev_del(&ns->cdev, &ns->cdev_device);
+	else
+		sysfs_remove_link(&disk_to_dev(ns->head->disk)->kobj,
+				  ns->disk->disk_name);
 	del_gendisk(ns->disk);
 
 	down_write(&ns->ctrl->namespaces_rwsem);
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 0a88d7bdc5e3..9dd0be645dad 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -875,6 +875,16 @@ void nvme_mpath_add_disk(struct nvme_ns *ns, __le32 anagrpid)
 	if (blk_queue_is_zoned(ns->queue) && ns->head->disk)
 		ns->head->disk->nr_zones = ns->disk->nr_zones;
 #endif
+	if (ns->head->disk) {
+		int ret;
+
+		ret = sysfs_create_link(&disk_to_dev(ns->head->disk)->kobj,
+					&disk_to_dev(ns->disk)->kobj,
+					ns->disk->disk_name);
+		if (ret)
+			dev_warn(ns->ctrl->device,
+				 "failed to create namespace path link\n");
+	}
 }
 
 void nvme_mpath_shutdown_disk(struct nvme_ns_head *head)
-- 
2.35.3



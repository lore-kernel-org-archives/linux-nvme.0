Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F1D5C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Mar 2022 07:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=fFONp8pKLfWpxmB45kC1NFEyJX4sosl6tTNVF6FqKIM=; b=yTm23CkKG/nbfrZwo1zRl2ZwpP
	uBdfmsnoeewdRGAmibdhkI7Ga8I6FSvDanUf4HV0IduoVyiNRv04zQlTCFZooCrzQ1hguZYpXIOoH
	AQv7Fr+yRW0gJZeQBsEdRr0FZGnjhFW4Qbd64+UtPSTOH05Y6A2EulfLgQuYL28OJwB7tACxuiBdS
	kjjP0B11Ozsx4Fd2WZRZn9W66h8b6D0t3QzBtLyRH8REo4CycOsGR3Q5/qJDn20JmoGs8tbDfzMtp
	APmAKQpGKrli7Rwjxwdd03n9YcG3rCz9kk6OfQG/SMeoGiqNBYeay2Xoxc7uG8TIQH61TlKa63RL2
	++7NRyJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nU1TI-0084rC-Pf; Tue, 15 Mar 2022 07:19:56 +0000
Received: from [46.140.54.162] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nU1TG-0084pz-Af; Tue, 15 Mar 2022 07:19:54 +0000
From: Christoph Hellwig <hch@lst.de>
To: sagi@grimberg.me,
	kch@nvidia.com
Cc: linux-nvme@lists.infradead.org,
	Niels Dossche <dossche.niels@gmail.com>
Subject: [PATCH] nvmet: move the call to nvmet_ns_changed out of
 nvmet_ns_revalidate
Date: Tue, 15 Mar 2022 08:19:51 +0100
Message-Id: <20220315071951.1903382-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
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

nvmet_ns_changed states via lockdep that the ns->subsys->lock must be
held. The only caller of nvmet_ns_changed which does not acquire that
lock is nvmet_ns_revalidate. nvmet_ns_revalidate has 3 callers,
of which 2 do not acquire that lock: nvmet_execute_identify_cns_cs_ns
and nvmet_execute_identify_ns. The other caller
nvmet_ns_revalidate_size_store does acquire the lock.

Move the call to nvmet_ns_changed from nvmet_ns_revalidate to the callers
so that they can perform the correct locking as needed.

This issue was found using a static type-based analyser and manually
verified.

Reported-by: Niels Dossche <dossche.niels@gmail.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/target/admin-cmd.c | 6 +++++-
 drivers/nvme/target/configfs.c  | 3 ++-
 drivers/nvme/target/core.c      | 5 ++---
 drivers/nvme/target/nvmet.h     | 2 +-
 drivers/nvme/target/zns.c       | 6 +++++-
 5 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 6fb24746de069..46d0dab686dd6 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -511,7 +511,11 @@ static void nvmet_execute_identify_ns(struct nvmet_req *req)
 		goto done;
 	}
 
-	nvmet_ns_revalidate(req->ns);
+	if (nvmet_ns_revalidate(req->ns)) {
+		mutex_lock(&req->ns->subsys->lock);
+		nvmet_ns_changed(req->ns->subsys, req->ns->nsid);
+		mutex_unlock(&req->ns->subsys->lock);
+	}
 
 	/*
 	 * nuse = ncap = nsze isn't always true, but we have no way to find
diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index ac801fa1641bc..b650312dd4aed 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -586,7 +586,8 @@ static ssize_t nvmet_ns_revalidate_size_store(struct config_item *item,
 		mutex_unlock(&ns->subsys->lock);
 		return -EINVAL;
 	}
-	nvmet_ns_revalidate(ns);
+	if (nvmet_ns_revalidate(ns))
+		nvmet_ns_changed(ns->subsys, ns->nsid);
 	mutex_unlock(&ns->subsys->lock);
 	return count;
 }
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 724a6d373340a..92af37d33ec34 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -531,7 +531,7 @@ static void nvmet_p2pmem_ns_add_p2p(struct nvmet_ctrl *ctrl,
 		ns->nsid);
 }
 
-void nvmet_ns_revalidate(struct nvmet_ns *ns)
+bool nvmet_ns_revalidate(struct nvmet_ns *ns)
 {
 	loff_t oldsize = ns->size;
 
@@ -540,8 +540,7 @@ void nvmet_ns_revalidate(struct nvmet_ns *ns)
 	else
 		nvmet_file_ns_revalidate(ns);
 
-	if (oldsize != ns->size)
-		nvmet_ns_changed(ns->subsys, ns->nsid);
+	return oldsize != ns->size;
 }
 
 int nvmet_ns_enable(struct nvmet_ns *ns)
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 69637bf8f8e19..d910c6aad4b66 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -542,7 +542,7 @@ u16 nvmet_file_flush(struct nvmet_req *req);
 void nvmet_ns_changed(struct nvmet_subsys *subsys, u32 nsid);
 void nvmet_bdev_ns_revalidate(struct nvmet_ns *ns);
 void nvmet_file_ns_revalidate(struct nvmet_ns *ns);
-void nvmet_ns_revalidate(struct nvmet_ns *ns);
+bool nvmet_ns_revalidate(struct nvmet_ns *ns);
 u16 blk_to_nvme_status(struct nvmet_req *req, blk_status_t blk_sts);
 
 bool nvmet_bdev_zns_enable(struct nvmet_ns *ns);
diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c
index 3e421217a7ade..e34718b095504 100644
--- a/drivers/nvme/target/zns.c
+++ b/drivers/nvme/target/zns.c
@@ -123,7 +123,11 @@ void nvmet_execute_identify_cns_cs_ns(struct nvmet_req *req)
 		goto done;
 	}
 
-	nvmet_ns_revalidate(req->ns);
+	if (nvmet_ns_revalidate(req->ns)) {
+		mutex_lock(&req->ns->subsys->lock);
+		nvmet_ns_changed(req->ns->subsys, req->ns->nsid);
+		mutex_unlock(&req->ns->subsys->lock);
+	}
 	zsze = (bdev_zone_sectors(req->ns->bdev) << 9) >>
 					req->ns->blksize_shift;
 	id_zns->lbafe[0].zsze = cpu_to_le64(zsze);
-- 
2.30.2



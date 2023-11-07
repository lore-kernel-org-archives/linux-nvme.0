Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3066EC4332F
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Nov 2023 21:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HXkB8yvqhyaM6elo2IuYohpATIIF7/qluEIFeCGbTt8=; b=C9GKATUak+1wCs/s7RBOAdOLwq
	G7XpJliCjeiD41hakGcau5WaP+DhM4HZAGHh2/keNhQtkX0ylLiP4yCxLRr6RqpVy1UFVTpU8z3db
	+y7jomUfHbs8t6aCRfMwBLDNJpNOGE1Hbb8rGeD/bLZEfp1oaUoaRkQFtF2ee6M/gBrwhpSxoVKB6
	iIdzVW858kQgRBTisE6lgFF9nqC/ofOQTisWVu/h5/S9amzh5GOmPL1O8eCD3Mkwute0vymrXPdWD
	OtEXmjS1L1hRGb0A+LiZuG2Jls8Nz2a83N3Q+KZh+s1hUcQUJf0EBv/MIF4oiUhz/7BoSEJ71Go12
	/Y/3Yh9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r0TZa-002QTV-1d;
	Tue, 07 Nov 2023 21:25:22 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r0TZX-002QSw-2C
	for linux-nvme@lists.infradead.org;
	Tue, 07 Nov 2023 21:25:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699392318;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HXkB8yvqhyaM6elo2IuYohpATIIF7/qluEIFeCGbTt8=;
	b=KwicUQ+9YokNTwLGXItLbKUZOSLX2DHjbPaCgiOvksfjZhCHMxTmvQlJojDIdHV3rzzHYB
	PTiLFFp437d1fMIGXX2rdVEDYdsgub/xOh8zpWj4uAQbIMimDRH2P6NXj+iYFsMYETehb4
	JOOpRWlC4iK8LuqjuZkHlxJOz5tZ9hc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-tsMXuu9COPqruiUntJZQ6w-1; Tue, 07 Nov 2023 16:23:32 -0500
X-MC-Unique: tsMXuu9COPqruiUntJZQ6w-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5AFE785A58A;
	Tue,  7 Nov 2023 21:23:32 +0000 (UTC)
Received: from emilne.bos.redhat.com (unknown [10.18.25.205])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4355E492BE7;
	Tue,  7 Nov 2023 21:23:32 +0000 (UTC)
From: "Ewan D. Milne" <emilne@redhat.com>
To: linux-nvme@lists.infradead.org
Cc: tsong@purestorage.com
Subject: [PATCH 2/3] nvme: multipath: only update ctrl->nr_active when using queue-depth iopolicy
Date: Tue,  7 Nov 2023 16:23:30 -0500
Message-Id: <20231107212331.9413-2-emilne@redhat.com>
In-Reply-To: <20231107212331.9413-1-emilne@redhat.com>
References: <20231107212331.9413-1-emilne@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231107_132519_790126_651F53B4 
X-CRM114-Status: GOOD (  14.77  )
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

The atomic updates of ctrl->nr_active are unnecessary when using
numa or round-robin iopolicy, so avoid that cost on a per-request basis.
Clear nr_active when changing iopolicy and do not decrement below zero.
(This handles changing the iopolicy while requests are in flight.)

Signed-off-by: Ewan D. Milne <emilne@redhat.com>
---
 drivers/nvme/host/core.c      |  2 +-
 drivers/nvme/host/multipath.c | 21 ++++++++++++++++++---
 drivers/nvme/host/nvme.h      |  2 ++
 3 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 75a1b58a7a43..9bc19755be77 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -110,7 +110,7 @@ struct workqueue_struct *nvme_delete_wq;
 EXPORT_SYMBOL_GPL(nvme_delete_wq);
 
 static LIST_HEAD(nvme_subsystems);
-static DEFINE_MUTEX(nvme_subsystems_lock);
+DEFINE_MUTEX(nvme_subsystems_lock);
 
 static DEFINE_IDA(nvme_instance_ida);
 static dev_t nvme_ctrl_base_chr_devt;
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 4c2690cddef3..e184e7c377bc 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -133,7 +133,8 @@ void nvme_mpath_start_request(struct request *rq)
 	if (!blk_queue_io_stat(disk->queue) || blk_rq_is_passthrough(rq))
 		return;
 
-	atomic_inc(&ns->ctrl->nr_active);
+	if (READ_ONCE(ns->head->subsys->iopolicy) == NVME_IOPOLICY_QD)
+		atomic_inc(&ns->ctrl->nr_active);
 	nvme_req(rq)->flags |= NVME_MPATH_IO_STATS;
 	nvme_req(rq)->start_time = bdev_start_io_acct(disk->part0, req_op(rq),
 						      jiffies);
@@ -147,7 +148,8 @@ void nvme_mpath_end_request(struct request *rq)
 	if (!(nvme_req(rq)->flags & NVME_MPATH_IO_STATS))
 		return;
 
-	atomic_dec(&ns->ctrl->nr_active);
+	if (READ_ONCE(ns->head->subsys->iopolicy) == NVME_IOPOLICY_QD)
+		atomic_dec_if_positive(&ns->ctrl->nr_active);
 	bdev_end_io_acct(ns->head->disk->part0, req_op(rq),
 			 blk_rq_bytes(rq) >> SECTOR_SHIFT,
 			 nvme_req(rq)->start_time);
@@ -848,6 +850,19 @@ static ssize_t nvme_subsys_iopolicy_show(struct device *dev,
 			  nvme_iopolicy_names[READ_ONCE(subsys->iopolicy)]);
 }
 
+void nvme_subsys_iopolicy_update(struct nvme_subsystem *subsys, int iopolicy)
+{
+	struct nvme_ctrl *ctrl;
+
+	WRITE_ONCE(subsys->iopolicy, iopolicy);
+
+	mutex_lock(&nvme_subsystems_lock);
+	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
+		atomic_set(&ctrl->nr_active, 0);
+	}
+	mutex_unlock(&nvme_subsystems_lock);
+}
+
 static ssize_t nvme_subsys_iopolicy_store(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t count)
 {
@@ -857,7 +872,7 @@ static ssize_t nvme_subsys_iopolicy_store(struct device *dev,
 
 	for (i = 0; i < ARRAY_SIZE(nvme_iopolicy_names); i++) {
 		if (sysfs_streq(buf, nvme_iopolicy_names[i])) {
-			WRITE_ONCE(subsys->iopolicy, i);
+			nvme_subsys_iopolicy_update(subsys, i);
 			return count;
 		}
 	}
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index f0f3fd8b4197..c4469bc38d89 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -49,6 +49,8 @@ extern struct workqueue_struct *nvme_wq;
 extern struct workqueue_struct *nvme_reset_wq;
 extern struct workqueue_struct *nvme_delete_wq;
 
+extern struct mutex nvme_subsystems_lock;
+
 /*
  * List of workarounds for devices that required behavior not specified in
  * the standard.
-- 
2.20.1



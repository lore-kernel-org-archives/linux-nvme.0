Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3B9CC25B10
	for <linux-nvme@archiver.kernel.org>; Thu,  9 May 2024 20:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sv0rpGMuqN08MvqBMJOK0G6fcLMIR6LNv/hFD3yHl4g=; b=VUYWHNCN0gKbgSJtXl5aeq0GWK
	sUBVLoOWzUOy+74ZRSndltJwhTXKur/QyDPVQ8KvslfpW8UxIBkaE/MHWHDNugj5iBIMn2jX8XFg4
	ZadKKfs24bhClsqIujYVDtV/gyHNxNL1lDnaZqjJIZXAWqWWhrKLxhRHvJYKGgSxWTL1duEhLg1/b
	m3S6Fwu6WrIkmJs7MxpE0T5UotP7a/4w+2K/EHM4wzUqlQNmGXj59HDuhXKgNdui0poFQ3BJTSP0G
	ugqVNl4sNXYo0+dQe9KTqoRvSEr9ix4/EpCWOhptD/Hu1qJ3TGeclITodMM9GRxGrpNlYeOfk45gY
	+RM1eAjw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5AOj-00000002ltQ-0JMJ;
	Thu, 09 May 2024 20:29:49 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5AOd-00000002lp3-3fxe
	for linux-nvme@lists.infradead.org;
	Thu, 09 May 2024 20:29:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715286579;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sv0rpGMuqN08MvqBMJOK0G6fcLMIR6LNv/hFD3yHl4g=;
	b=GdohS6DvtR/vgcmlwWZSMHkdZgL/dODWKJHRsWQhvyCmACsdHktE+DSTg3ibCgUG1TPeGT
	M4zRTwApJC0eqqmZzU8O8a6Ww9H8gUQYJJzykBfXoB38nWIMpxAVD5a0Qjg3G/MFUUohvz
	3oIXyScpJxvzow45isd16RJM9OHEsiw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-383-v9XqlrW5OCWwBoYWkLxvJw-1; Thu, 09 May 2024 16:29:34 -0400
X-MC-Unique: v9XqlrW5OCWwBoYWkLxvJw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 22D098065D2;
	Thu,  9 May 2024 20:29:34 +0000 (UTC)
Received: from jmeneghi.bos.com (unknown [10.22.16.53])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 974B520C5674;
	Thu,  9 May 2024 20:29:33 +0000 (UTC)
From: John Meneghini <jmeneghi@redhat.com>
To: kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	emilne@redhat.com
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	jmeneghi@redhat.com,
	jrani@purestorage.com,
	randyj@purestorage.com,
	hare@kernel.org,
	constg@il.ibm.com,
	aviv.coro@ibm.com
Subject: [PATCH v2 2/3] nvme: multipath: only update ctrl->nr_active when using queue-depth iopolicy
Date: Thu,  9 May 2024 16:29:28 -0400
Message-Id: <20240509202929.831680-3-jmeneghi@redhat.com>
In-Reply-To: <20231107212331.9413-1-emilne@redhat.com>
References: <20231107212331.9413-1-emilne@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240509_132944_098467_3BBC58ED 
X-CRM114-Status: GOOD (  15.36  )
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

From: "Ewan D. Milne" <emilne@redhat.com>

The atomic updates of ctrl->nr_active are unnecessary when using
numa or round-robin iopolicy, so avoid that cost on a per-request basis.
Clear nr_active when changing iopolicy and do not decrement below zero.
(This handles changing the iopolicy while requests are in flight.)

Tested-by: John Meneghini <jmeneghi@redhat.com>
Signed-off-by: Ewan D. Milne <emilne@redhat.com>
---
 drivers/nvme/host/core.c      |  2 +-
 drivers/nvme/host/multipath.c | 21 ++++++++++++++++++---
 drivers/nvme/host/nvme.h      |  6 ++++++
 3 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 095f59e7aa93..ffc04d65c45e 100644
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
index 3603dd2c785f..02baadb45c82 100644
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
@@ -851,6 +853,19 @@ static ssize_t nvme_subsys_iopolicy_show(struct device *dev,
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
@@ -860,7 +875,7 @@ static ssize_t nvme_subsys_iopolicy_store(struct device *dev,
 
 	for (i = 0; i < ARRAY_SIZE(nvme_iopolicy_names); i++) {
 		if (sysfs_streq(buf, nvme_iopolicy_names[i])) {
-			WRITE_ONCE(subsys->iopolicy, i);
+			nvme_subsys_iopolicy_update(subsys, i);
 			return count;
 		}
 	}
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index e23e17ab94b9..a557b4577c01 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -50,6 +50,8 @@ extern struct workqueue_struct *nvme_wq;
 extern struct workqueue_struct *nvme_reset_wq;
 extern struct workqueue_struct *nvme_delete_wq;
 
+extern struct mutex nvme_subsystems_lock;
+
 /*
  * List of workarounds for devices that required behavior not specified in
  * the standard.
@@ -963,6 +965,7 @@ void nvme_mpath_clear_ctrl_paths(struct nvme_ctrl *ctrl);
 void nvme_mpath_shutdown_disk(struct nvme_ns_head *head);
 void nvme_mpath_start_request(struct request *rq);
 void nvme_mpath_end_request(struct request *rq);
+void nvme_subsys_iopolicy_update(struct nvme_subsystem *subsys, int iopolicy);
 
 static inline void nvme_trace_bio_complete(struct request *req)
 {
@@ -1062,6 +1065,9 @@ static inline bool nvme_disk_is_ns_head(struct gendisk *disk)
 {
 	return false;
 }
+static inline void nvme_subsys_iopolicy_update(struct nvme_subsystem *subsys, int iopolicy)
+{
+}
 #endif /* CONFIG_NVME_MULTIPATH */
 
 struct nvme_zone_info {
-- 
2.39.3



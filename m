Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60978EB4917
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Feb 2026 12:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MmTYg+8lSVcsO57yO3LwOWA4RGUT3WGDBMHU724l4Lc=; b=jsnVqi40G3L+bkycvb4mO0+GH6
	fnvsVLmDPqKHIveeTknzUD3KPOmxzKusdjXnnbvKAlxZOdPVXlEU3l+XLZvN1xgry4mIOhN7fYYGW
	Ssa0R9syB0RNUkX0KmFks1OFLVkWS8oLNe/5deZprtqcZcw8pUKXR5AI4j7rIm5wDga+HoR0DOYiD
	LPDkjY1US5c0TZqucxcDVxPZ8H0pr1cbez4gH28WoUtbaKeAy8fO0hC7gkG19yRh9g+vzN27BY9Sh
	3PyfaFZyx0eVWmy3N2X+a0kJyYtve39wVnmDaJJ9hCm0GxT6DSWR1gv69G+eaDpfQRKALyKWGPKr3
	UGjJO7tQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqVWR-000000023ZG-39JV;
	Thu, 12 Feb 2026 12:10:15 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqVWO-000000023XV-1jYk
	for linux-nvme@lists.infradead.org;
	Thu, 12 Feb 2026 12:10:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770898211;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MmTYg+8lSVcsO57yO3LwOWA4RGUT3WGDBMHU724l4Lc=;
	b=CcQM/aFyli84mOdW2q2ehFyKKTrvatiVSJYqlmKPw1gP2pLr6Cfl95ONuaFh6D3leoOl+e
	PgH5Y6DouBUq7p1EZKyv7tKsdamyLXzpwRUPGHHwoZ7GQnLFR4swPi8HC9/L6Vb60gwkW+
	oNfldB6Lx27zWo4pCfNMAlWJTHyCOLI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-711-kb06_s2fMviUMth9u9hClQ-1; Thu,
 12 Feb 2026 07:10:07 -0500
X-MC-Unique: kb06_s2fMviUMth9u9hClQ-1
X-Mimecast-MFC-AGG-ID: kb06_s2fMviUMth9u9hClQ_1770898206
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C43291955D88;
	Thu, 12 Feb 2026 12:10:06 +0000 (UTC)
Received: from mlombard-thinkpadt14gen4.rmtit.csb (unknown [10.44.32.22])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5D4141956095;
	Thu, 12 Feb 2026 12:10:04 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: kbusch@kernel.org
Cc: mheyne@amazon.de,
	emilne@redhat.com,
	jmeneghi@redhat.com,
	linux-nvme@lists.infradead.org,
	dwagner@suse.de,
	mlombard@bsdbackstore.eu
Subject: [PATCH RFC 4/5] nvme: add sysfs attribute to change IO timeout per nvme controller
Date: Thu, 12 Feb 2026 13:09:50 +0100
Message-ID: <20260212120951.79738-5-mlombard@redhat.com>
In-Reply-To: <20260212120951.79738-1-mlombard@redhat.com>
References: <20260212120951.79738-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0vz6SDBnwKHgJx6rngSGnGSCYCFTGV_-2IY_O-16U_o_1770898206
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260212_041012_525151_DA5B4288 
X-CRM114-Status: GOOD (  16.39  )
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

Currently, there is no method to adjust the timeout values
on a per controller basis with nvme I/O queues.
Add an io_timeout attribute to nvme so that different
nvme controllers which may have different timeout
requirements can have custom I/O timeouts set.

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
---
 drivers/nvme/host/apple.c |  2 +-
 drivers/nvme/host/core.c  |  4 +++-
 drivers/nvme/host/nvme.h  |  1 +
 drivers/nvme/host/sysfs.c | 38 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
index ed61b97fde59..e9bb64e3ec9c 100644
--- a/drivers/nvme/host/apple.c
+++ b/drivers/nvme/host/apple.c
@@ -1331,7 +1331,7 @@ static int apple_nvme_alloc_tagsets(struct apple_nvme *anv)
 	if (anv->hw->has_lsq_nvmmu)
 		anv->tagset.reserved_tags = APPLE_NVME_AQ_DEPTH;
 	anv->tagset.queue_depth = anv->hw->max_queue_depth - 1;
-	anv->tagset.timeout = NVME_IO_TIMEOUT;
+	anv->tagset.timeout = anv->ctrl.io_timeout;
 	anv->tagset.numa_node = NUMA_NO_NODE;
 	anv->tagset.cmd_size = sizeof(struct apple_nvme_iod);
 	anv->tagset.driver_data = &anv->ioq;
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index b9315f0abf80..cc7d725bd6ff 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4169,6 +4169,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
 		mutex_unlock(&ctrl->namespaces_lock);
 		goto out_unlink_ns;
 	}
+	blk_queue_rq_timeout(ns->queue, ctrl->io_timeout);
 	nvme_ns_add_to_ctrl_list(ns);
 	mutex_unlock(&ctrl->namespaces_lock);
 	synchronize_srcu(&ctrl->srcu);
@@ -4930,7 +4931,7 @@ int nvme_alloc_io_tag_set(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set,
 	set->cmd_size = cmd_size;
 	set->driver_data = ctrl;
 	set->nr_hw_queues = ctrl->queue_count - 1;
-	set->timeout = NVME_IO_TIMEOUT;
+	set->timeout = ctrl->io_timeout;
 	set->nr_maps = nr_maps;
 	ret = blk_mq_alloc_tag_set(set);
 	if (ret)
@@ -5107,6 +5108,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	memset(&ctrl->ka_cmd, 0, sizeof(ctrl->ka_cmd));
 	ctrl->ka_cmd.common.opcode = nvme_admin_keep_alive;
 	ctrl->ka_last_check_time = jiffies;
+	ctrl->io_timeout = NVME_IO_TIMEOUT;
 
 	BUILD_BUG_ON(NVME_DSM_MAX_RANGES * sizeof(struct nvme_dsm_range) >
 			PAGE_SIZE);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 9a5f28c5103c..ef390a020d8d 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -316,6 +316,7 @@ struct nvme_ctrl {
 	u16 mtfa;
 	u32 ctrl_config;
 	u32 queue_count;
+	u32 io_timeout;
 
 	u64 cap;
 	u32 max_hw_sectors;
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 149cd1ab3b3d..0536e4919aa7 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -631,6 +631,43 @@ static struct device_attribute dev_attr_admin_timeout =  \
 	__ATTR(admin_timeout, S_IRUGO | S_IWUSR, \
 	nvme_admin_timeout_show, nvme_admin_timeout_store);
 
+static ssize_t nvme_io_timeout_show(struct device *dev,
+			struct device_attribute *attr, char *buf)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%u\n", jiffies_to_msecs(ctrl->io_timeout));
+}
+
+static ssize_t nvme_io_timeout_store(struct device *dev,
+			struct device_attribute *attr,
+			const char *buf, size_t count)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+	struct nvme_ns *ns;
+	u32 timeout;
+	int err;
+
+	err = kstrtou32(buf, 10, &timeout);
+	if (err || !timeout)
+		return -EINVAL;
+
+	/* Take the namespaces_lock to avoid racing against nvme_alloc_ns() */
+	mutex_lock(&ctrl->namespaces_lock);
+
+	ctrl->io_timeout = msecs_to_jiffies(timeout);
+	list_for_each_entry(ns, &ctrl->namespaces, list)
+		blk_queue_rq_timeout(ns->queue, ctrl->io_timeout);
+
+	mutex_unlock(&ctrl->namespaces_lock);
+
+	return count;
+}
+
+static struct device_attribute dev_attr_io_timeout = \
+	__ATTR(io_timeout, S_IRUGO | S_IWUSR, \
+	nvme_io_timeout_show, nvme_io_timeout_store);
+
 #ifdef CONFIG_NVME_HOST_AUTH
 static ssize_t nvme_ctrl_dhchap_secret_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
@@ -773,6 +810,7 @@ static struct attribute *nvme_dev_attrs[] = {
 	&dev_attr_cntrltype.attr,
 	&dev_attr_dctype.attr,
 	&dev_attr_admin_timeout.attr,
+	&dev_attr_io_timeout.attr,
 #ifdef CONFIG_NVME_HOST_AUTH
 	&dev_attr_dhchap_secret.attr,
 	&dev_attr_dhchap_ctrl_secret.attr,
-- 
2.53.0



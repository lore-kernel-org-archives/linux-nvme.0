Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CB0CCD4851
	for <linux-nvme@archiver.kernel.org>; Thu, 14 May 2026 08:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XNGWFWOxksl5qOHfGszI8p+zoVN5QRXLtlgxF7HhVVo=; b=1siTrh8tyeYgD7CmqL8tIQGA5l
	hkM8dntt9ufXnmPYeUheQkvYjHO/ZYeO3B7uTlhUq0Wo6zgQFS99yN4C+0U3GFlleZJVtppBfU3v4
	QVVc/X8xJI08Ts0egfjqujQUUwKu/n3zy6i7MD/U/yTKLViapQDcCjHgZC7dLSH4Do3zSGTJMvYvp
	Bm3C9ts08vi58lfRqTUv0L2rbbVody/G2z/eeRFK3EwnbzCEnlLFT+wYTTgPXsn6W7hMypDven1Df
	/scVQOIcWgEWvcYB3HfZtQpgPwQI1LeYXyWWVgPEtYVIIn0hY8WknfBD3eWhCwcGWtAbyh9EHcvig
	JcHUQlMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNRVW-00000004x1z-2uBK;
	Thu, 14 May 2026 08:33:26 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNRVU-00000004wzi-0stC
	for linux-nvme@lists.infradead.org;
	Thu, 14 May 2026 08:33:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778747603;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XNGWFWOxksl5qOHfGszI8p+zoVN5QRXLtlgxF7HhVVo=;
	b=TJtspawfNVQfcKPNa5KEy1noiTt/NRROerOcjA+2G56yj31/Pe9ZmMpOAjP3gFMUaTGKK5
	tXDxV3XFhw9f87GiSGgLYhZyC/lij43o/ve6HLhoM33YTjjLq+pVWmVWd5KGGo0YcpkgVL
	a2gQH4nQ1oIRlP/GMQ3Rlv7GVyGHA+w=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-184-uPfc0as6P2yun6_aZhNUkw-1; Thu,
 14 May 2026 04:33:19 -0400
X-MC-Unique: uPfc0as6P2yun6_aZhNUkw-1
X-Mimecast-MFC-AGG-ID: uPfc0as6P2yun6_aZhNUkw_1778747597
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 326001956050;
	Thu, 14 May 2026 08:33:17 +0000 (UTC)
Received: from mlombard-thinkpadt14gen4.rmtit.csb (unknown [10.44.48.89])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 91E4D1956053;
	Thu, 14 May 2026 08:33:13 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: kbusch@kernel.org
Cc: mheyne@amazon.de,
	emilne@redhat.com,
	jmeneghi@redhat.com,
	linux-nvme@lists.infradead.org,
	dwagner@suse.de,
	mlombard@arkamax.eu,
	mkhalfella@purestorage.com,
	chaitanyak@nvidia.com,
	hare@kernel.org,
	hch@lst.de
Subject: [PATCH V5 4/7] nvme: add sysfs attribute to change IO timeout per controller
Date: Thu, 14 May 2026 10:32:52 +0200
Message-ID: <20260514083255.41109-5-mlombard@redhat.com>
In-Reply-To: <20260514083255.41109-1-mlombard@redhat.com>
References: <20260514083255.41109-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: BA4JuI5xGuw6BbLvKHEbc3Py92vjk5T1e_rhZMJvwEY_1778747597
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260514_013324_324144_F17E6BAC 
X-CRM114-Status: GOOD (  16.35  )
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

Currently, there is no method to adjust the timeout values on a
per controller basis with nvme I/O queues.
Add an io_timeout attribute to nvme so that different nvme controllers
which may have different timeout requirements can have custom I/O
timeouts set.

The I/O timeout is also applied to the connect queue (connect_q).
In NVMe over Fabrics, the connect queue is utilized specifically to
issue Connect commands that establish the I/O queues.

Reviewed-by: Mohamed Khalfella <mkhalfella@purestorage.com>
Reviewed-by: Daniel Wagner <dwagner@suse.de>
Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
---
 drivers/nvme/host/core.c  |  4 +++-
 drivers/nvme/host/nvme.h  |  1 +
 drivers/nvme/host/sysfs.c | 47 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index fe6dcd19cecb..626db6088dcd 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4207,6 +4207,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
 		mutex_unlock(&ctrl->namespaces_lock);
 		goto out_unlink_ns;
 	}
+	blk_queue_rq_timeout(ns->queue, ctrl->io_timeout);
 	nvme_ns_add_to_ctrl_list(ns);
 	mutex_unlock(&ctrl->namespaces_lock);
 	synchronize_srcu(&ctrl->srcu);
@@ -5145,6 +5146,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	ctrl->ka_cmd.common.opcode = nvme_admin_keep_alive;
 	ctrl->ka_last_check_time = jiffies;
 	ctrl->admin_timeout = NVME_ADMIN_TIMEOUT;
+	ctrl->io_timeout = NVME_IO_TIMEOUT;
 
 	BUILD_BUG_ON(NVME_DSM_MAX_RANGES * sizeof(struct nvme_dsm_range) >
 			PAGE_SIZE);
@@ -5253,7 +5255,7 @@ EXPORT_SYMBOL_GPL(nvme_unfreeze);
 
 int nvme_wait_freeze_timeout(struct nvme_ctrl *ctrl)
 {
-	unsigned long timeout = NVME_IO_TIMEOUT;
+	unsigned long timeout = ctrl->io_timeout;
 	struct nvme_ns *ns;
 	int srcu_idx;
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 7923533cce00..9ccaed0b9dbf 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -371,6 +371,7 @@ struct nvme_ctrl {
 	u32 ctrl_config;
 	u32 queue_count;
 	u32 admin_timeout;
+	u32 io_timeout;
 
 	u64 cap;
 	u32 max_hw_sectors;
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 3b39b64cd9da..b682c1a4b23f 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -663,6 +663,52 @@ static ssize_t nvme_admin_timeout_store(struct device *dev,
 static DEVICE_ATTR(admin_timeout, S_IRUGO | S_IWUSR,
 	nvme_admin_timeout_show, nvme_admin_timeout_store);
 
+static ssize_t nvme_io_timeout_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%u\n", jiffies_to_msecs(ctrl->io_timeout));
+}
+
+static ssize_t nvme_io_timeout_store(struct device *dev,
+		struct device_attribute *attr,
+		const char *buf, size_t count)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+	struct nvme_ns *ns;
+	u32 timeout;
+	int err;
+
+	/*
+	 * Wait until the controller reaches the LIVE state to be sure that
+	 * connect_q is properly initialized.
+	 */
+	if (!test_bit(NVME_CTRL_STARTED_ONCE, &ctrl->flags))
+		return -EBUSY;
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
+	if (ctrl->connect_q)
+		blk_queue_rq_timeout(ctrl->connect_q, ctrl->io_timeout);
+
+	return count;
+}
+
+static DEVICE_ATTR(io_timeout, S_IRUGO | S_IWUSR,
+	nvme_io_timeout_show, nvme_io_timeout_store);
+
 #ifdef CONFIG_NVME_HOST_AUTH
 static ssize_t nvme_ctrl_dhchap_secret_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
@@ -806,6 +852,7 @@ static struct attribute *nvme_dev_attrs[] = {
 	&dev_attr_dctype.attr,
 	&dev_attr_quirks.attr,
 	&dev_attr_admin_timeout.attr,
+	&dev_attr_io_timeout.attr,
 #ifdef CONFIG_NVME_HOST_AUTH
 	&dev_attr_dhchap_secret.attr,
 	&dev_attr_dhchap_ctrl_secret.attr,
-- 
2.54.0



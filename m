Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAAB4E9904A
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Apr 2026 07:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gR5ldiVmabrJ73oDPfaJTJJEG6MXxikvM7h2NQIRRfs=; b=ZqUyqZDm0Nwgd3X9o1lsj4kukW
	rFvYPqPNScY00g2vCjpIRwUlq0cXUor9yvHd2+U8whJAptH8TDHcSp8O7tYgHPN0FWCY+1rw1eqgs
	s9W1Xkjge8ezq69wLoXl8X2f9Y6sgsMIeYhvx7kJ4/160llbWzAGzmfJKpy52DvSrJaKGuuTLtoEN
	LHt6IL20uS8CrpeJN27Q9LcyIDf3YHW6nGm+ZWS4W7qteZwnYEqFDPxawVcOElnd5+LkqSNHZbfIX
	xEN3cVLdFhrcSrZloiNJNcpPotGhuq23hER7ozkbqcFYuxsBwwsnEHLyraXFZZmMPnnMrnAFDQ4cy
	mzlScS2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wB6T5-0000000Bl61-0oZ8;
	Fri, 10 Apr 2026 07:39:55 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wB6T2-0000000Bl3c-3jv4
	for linux-nvme@lists.infradead.org;
	Fri, 10 Apr 2026 07:39:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775806792;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gR5ldiVmabrJ73oDPfaJTJJEG6MXxikvM7h2NQIRRfs=;
	b=e6YMz8vje12TW89j0JW9wcLIRLlfiAc50lcyjOnFoqRypqA3Z1pfJ2dimbp+1312I4sc0Z
	YFTRrNBH3YzBv/pUb7jsKrfiF+QyL7/axZMuqKtds/l636yUgbqNdWnCkk44L4WRdlHg0V
	MI1v1YO8+0xNGc13Vtd/j4W7aDf7Ozg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-213-1Y7lRwZlMEOgFI3d6v6YdA-1; Fri,
 10 Apr 2026 03:39:48 -0400
X-MC-Unique: 1Y7lRwZlMEOgFI3d6v6YdA-1
X-Mimecast-MFC-AGG-ID: 1Y7lRwZlMEOgFI3d6v6YdA_1775806787
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BE89418002E5;
	Fri, 10 Apr 2026 07:39:46 +0000 (UTC)
Received: from mlombard-thinkpadt14gen4.rmtit.csb (unknown [10.44.32.170])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 56B611801ACE;
	Fri, 10 Apr 2026 07:39:43 +0000 (UTC)
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
Subject: [PATCH V3 4/8] nvme: add sysfs attribute to change IO timeout per nvme controller
Date: Fri, 10 Apr 2026 09:39:20 +0200
Message-ID: <20260410073924.61078-5-mlombard@redhat.com>
In-Reply-To: <20260410073924.61078-1-mlombard@redhat.com>
References: <20260410073924.61078-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: uWZgsI0_xQVerq-IjnY2GivZcjpWTgl1eMWOr4RGi3s_1775806787
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260410_003952_999954_75E55DEB 
X-CRM114-Status: GOOD (  14.38  )
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
which may have different timeout requirements can have custom
I/O timeouts set.

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
---
 drivers/nvme/host/core.c  |  2 ++
 drivers/nvme/host/nvme.h  |  1 +
 drivers/nvme/host/sysfs.c | 47 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 50 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 6dc3d273623c..1b676fd4d454 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4197,6 +4197,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
 		mutex_unlock(&ctrl->namespaces_lock);
 		goto out_unlink_ns;
 	}
+	blk_queue_rq_timeout(ns->queue, ctrl->io_timeout);
 	nvme_ns_add_to_ctrl_list(ns);
 	mutex_unlock(&ctrl->namespaces_lock);
 	synchronize_srcu(&ctrl->srcu);
@@ -5136,6 +5137,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	ctrl->ka_cmd.common.opcode = nvme_admin_keep_alive;
 	ctrl->ka_last_check_time = jiffies;
 	ctrl->admin_timeout = NVME_ADMIN_TIMEOUT;
+	ctrl->io_timeout = NVME_IO_TIMEOUT;
 
 	BUILD_BUG_ON(NVME_DSM_MAX_RANGES * sizeof(struct nvme_dsm_range) >
 			PAGE_SIZE);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 9da3ebebe9c8..a6d998c2e0e5 100644
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
index 000c29bd1f1f..1e6a0eecb30e 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -664,6 +664,52 @@ static ssize_t nvme_admin_timeout_store(struct device *dev,
 static DEVICE_ATTR(admin_timeout, S_IRUGO | S_IWUSR,
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
+	/*
+	 * Wait until the controller reaches the LIVE state
+	 * to be sure that connect_q is properly initialized.
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
+	if (ctrl->connect_q)
+		blk_queue_rq_timeout(ctrl->connect_q, ctrl->io_timeout);
+
+	mutex_unlock(&ctrl->namespaces_lock);
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
@@ -807,6 +853,7 @@ static struct attribute *nvme_dev_attrs[] = {
 	&dev_attr_dctype.attr,
 	&dev_attr_quirks.attr,
 	&dev_attr_admin_timeout.attr,
+	&dev_attr_io_timeout.attr,
 #ifdef CONFIG_NVME_HOST_AUTH
 	&dev_attr_dhchap_secret.attr,
 	&dev_attr_dhchap_ctrl_secret.attr,
-- 
2.53.0



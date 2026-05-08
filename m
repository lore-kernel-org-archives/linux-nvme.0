Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 585F5CD3447
	for <linux-nvme@archiver.kernel.org>; Fri,  8 May 2026 13:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gUOm8GYMQJAkXZ5ab5t6VHjULuBjW3j42VgEZyfruzw=; b=ZRI9xJYxeTDbZgLjdvVbX+33/3
	ldMVUgqbT6OshNkEPbP6dO87L68RnpYpkEvBUc9tdGAviXrPoLvso/SVvMjmw5FK0uAcMjdHwFc07
	IpjRh3nKUm05lpW+9DQkELD8EXk94YcaJqnO0RTOvg+Pe0xuAW7jADL3Vh2qeflZX7aRcLAK9cn+1
	u0gAh1SPyWPmNPOYhjBvkLwudK9aBw2ljNgKVmuaWdeunH9wzRjliQbgbzmRPZ+8LQTmmkwnifTrc
	m5DMtUPMrGjfCIN0nzpveUGHfNUaSTYzuFPbHbfHGpL50hX0UU2zoqIhbs7Jui479PCmoW0GMexfW
	apj1Z9BA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wLLLH-00000006Yhr-23pe;
	Fri, 08 May 2026 13:34:11 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wLLLE-00000006YeK-37BO
	for linux-nvme@lists.infradead.org;
	Fri, 08 May 2026 13:34:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778247247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gUOm8GYMQJAkXZ5ab5t6VHjULuBjW3j42VgEZyfruzw=;
	b=U7bLbmz/HSSPRRZOBHj9eegemPvWYp1PXGT6ssd5ZAGTwiIMqJOowIzOzT5Lx+lxSXYsUq
	ugIS0qveHZHCG8f1fKJF6+JtaP2r40k1NH+x+6MLF9G1V7N3rPxBh+wz7k0nn4pv0ljk2G
	AVlT9tZl/ViP1VERoWmTaRMgC0cJvjA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-629-dzLJ8IwzN3-l9t5d6T8DcQ-1; Fri,
 08 May 2026 09:34:03 -0400
X-MC-Unique: dzLJ8IwzN3-l9t5d6T8DcQ-1
X-Mimecast-MFC-AGG-ID: dzLJ8IwzN3-l9t5d6T8DcQ_1778247241
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EBD6919560BF;
	Fri,  8 May 2026 13:34:00 +0000 (UTC)
Received: from mlombard-thinkpadt14gen4.rmtit.csb (unknown [10.44.32.105])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BBC91195394A;
	Fri,  8 May 2026 13:33:57 +0000 (UTC)
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
Subject: [PATCH V4 5/9] nvme: add sysfs attribute to change IO timeout per controller
Date: Fri,  8 May 2026 15:33:31 +0200
Message-ID: <20260508133335.98612-6-mlombard@redhat.com>
In-Reply-To: <20260508133335.98612-1-mlombard@redhat.com>
References: <20260508133335.98612-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: clbTzDjIXvvggchJyszE2KhjwR9sT0hoy003rBGqQWs_1778247241
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260508_063408_851040_D69FF82C 
X-CRM114-Status: GOOD (  14.20  )
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
index 22be8cf5e982..fa60e10e05d5 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4203,6 +4203,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
 		mutex_unlock(&ctrl->namespaces_lock);
 		goto out_unlink_ns;
 	}
+	blk_queue_rq_timeout(ns->queue, ctrl->io_timeout);
 	nvme_ns_add_to_ctrl_list(ns);
 	mutex_unlock(&ctrl->namespaces_lock);
 	synchronize_srcu(&ctrl->srcu);
@@ -5141,6 +5142,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
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
index 9456af955aff..7e6810423735 100644
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
@@ -807,6 +853,7 @@ static struct attribute *nvme_dev_attrs[] = {
 	&dev_attr_dctype.attr,
 	&dev_attr_quirks.attr,
 	&dev_attr_admin_timeout.attr,
+	&dev_attr_io_timeout.attr,
 #ifdef CONFIG_NVME_HOST_AUTH
 	&dev_attr_dhchap_secret.attr,
 	&dev_attr_dhchap_ctrl_secret.attr,
-- 
2.54.0



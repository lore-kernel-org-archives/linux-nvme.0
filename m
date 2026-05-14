Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CDDACD4851
	for <linux-nvme@archiver.kernel.org>; Thu, 14 May 2026 08:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kbWcTCyaxy4Ase7i/CumyjFdx4fHgRzLqB501v9Ro94=; b=hayf8VasLbnnOnnGIYLzl4eks/
	dtaRi+DatbEcvvlLn2jtezt8vNw+d/b19osNFfHZWlXNy/Cilw9/gEdYKECk1pD6kcZAieNqoZxMt
	+MiEZJ3adYxgAvLPvTKWVDoSE/9X3yIJ9BW8yxQ4oJgN+Jy7FCQPbFJbkwJdQHwNbAwI1CM/66TwK
	Zn2acAIzIL5gP/pVPSTCuscdEYf6lG1G15D8xmukloR+gnFmvy+XYGaransSxIQbXm5qGiSHKmbP1
	zT3+wxogCVuDlGqDYSXmxkqPsh4LH3+Sq6thuGuQlkPnjzI9nZrNMuzz0VBUF6o2vxjpBc0yFJZ0L
	i/gWnbyg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNRVR-00000004wyj-2Rh1;
	Thu, 14 May 2026 08:33:21 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNRVP-00000004wxC-0L51
	for linux-nvme@lists.infradead.org;
	Thu, 14 May 2026 08:33:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778747598;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kbWcTCyaxy4Ase7i/CumyjFdx4fHgRzLqB501v9Ro94=;
	b=elcGDNxXzhf4mxhNe1A+qnM2pJpqrUlAIM9w4uvWkERh/0HOTtQUAy7tktNYJQzJ7gqqRb
	u2kYyPU+lP4uNP47uAodZfQZbAqsRNWxclL20fn+TsPf56IfrGPhBQ/zd7X4THmhJlhjoD
	q5wAJzDpHZ3GdSPPfJtTsTbNQPPbZyE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-86-hyUM8AEbPnGAHz4U4Ac4lg-1; Thu,
 14 May 2026 04:33:14 -0400
X-MC-Unique: hyUM8AEbPnGAHz4U4Ac4lg-1
X-Mimecast-MFC-AGG-ID: hyUM8AEbPnGAHz4U4Ac4lg_1778747593
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 175C7195608D;
	Thu, 14 May 2026 08:33:13 +0000 (UTC)
Received: from mlombard-thinkpadt14gen4.rmtit.csb (unknown [10.44.48.89])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D74CB1956053;
	Thu, 14 May 2026 08:33:09 +0000 (UTC)
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
Subject: [PATCH V5 3/7] nvme: add sysfs attribute to change admin timeout per nvme controller
Date: Thu, 14 May 2026 10:32:51 +0200
Message-ID: <20260514083255.41109-4-mlombard@redhat.com>
In-Reply-To: <20260514083255.41109-1-mlombard@redhat.com>
References: <20260514083255.41109-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: RT-kFiu1a6JR7ds5pXIEol7F5J_2G3hpUV-MFt2zPYk_1778747593
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260514_013319_195547_5DCE9406 
X-CRM114-Status: GOOD (  16.66  )
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
per-controller basis with nvme admin queues.
Add an admin_timeout attribute to nvme so that different nvme controllers
which may have different timeout requirements can have custom admin
timeouts set.

The admin timeout is also applied to the fabrics queue (fabrics_q).
The fabrics queue is utilized for fabric-specific administrative and
control operations, such as Connect and Property Get/Set commands.

Reviewed-by: Daniel Wagner <dwagner@suse.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
---
 drivers/nvme/host/core.c  |  1 +
 drivers/nvme/host/nvme.h  |  1 +
 drivers/nvme/host/pci.c   |  2 +-
 drivers/nvme/host/sysfs.c | 41 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 84f295e3bf08..fe6dcd19cecb 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -5144,6 +5144,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	memset(&ctrl->ka_cmd, 0, sizeof(ctrl->ka_cmd));
 	ctrl->ka_cmd.common.opcode = nvme_admin_keep_alive;
 	ctrl->ka_last_check_time = jiffies;
+	ctrl->admin_timeout = NVME_ADMIN_TIMEOUT;
 
 	BUILD_BUG_ON(NVME_DSM_MAX_RANGES * sizeof(struct nvme_dsm_range) >
 			PAGE_SIZE);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 6f9ecb4948f4..7923533cce00 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -370,6 +370,7 @@ struct nvme_ctrl {
 	u16 mtfa;
 	u32 ctrl_config;
 	u32 queue_count;
+	u32 admin_timeout;
 
 	u64 cap;
 	u32 max_hw_sectors;
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 8dc353451b21..80d2e517aac3 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3096,7 +3096,7 @@ static bool __nvme_delete_io_queues(struct nvme_dev *dev, u8 opcode)
 	unsigned long timeout;
 
  retry:
-	timeout = NVME_ADMIN_TIMEOUT;
+	timeout = dev->ctrl.admin_timeout;
 	while (nr_queues > 0) {
 		if (nvme_delete_queue(&dev->queues[nr_queues], opcode))
 			break;
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index e59758616f27..3b39b64cd9da 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -623,6 +623,46 @@ static ssize_t quirks_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RO(quirks);
 
+static ssize_t nvme_admin_timeout_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%u\n",
+				jiffies_to_msecs(ctrl->admin_timeout));
+}
+
+static ssize_t nvme_admin_timeout_store(struct device *dev,
+		struct device_attribute *attr,
+		const char *buf, size_t count)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+	u32 timeout;
+	int err;
+
+	/*
+	 * Wait until the controller reaches the LIVE state to be sure that
+	 * admin_q and fabrics_q are properly initialized.
+	 */
+	if (!test_bit(NVME_CTRL_STARTED_ONCE, &ctrl->flags))
+		return -EBUSY;
+
+	err = kstrtou32(buf, 10, &timeout);
+	if (err || !timeout)
+		return -EINVAL;
+
+	ctrl->admin_timeout = msecs_to_jiffies(timeout);
+
+	blk_queue_rq_timeout(ctrl->admin_q, ctrl->admin_timeout);
+	if (ctrl->fabrics_q)
+		blk_queue_rq_timeout(ctrl->fabrics_q, ctrl->admin_timeout);
+
+	return count;
+}
+
+static DEVICE_ATTR(admin_timeout, S_IRUGO | S_IWUSR,
+	nvme_admin_timeout_show, nvme_admin_timeout_store);
+
 #ifdef CONFIG_NVME_HOST_AUTH
 static ssize_t nvme_ctrl_dhchap_secret_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
@@ -765,6 +805,7 @@ static struct attribute *nvme_dev_attrs[] = {
 	&dev_attr_cntrltype.attr,
 	&dev_attr_dctype.attr,
 	&dev_attr_quirks.attr,
+	&dev_attr_admin_timeout.attr,
 #ifdef CONFIG_NVME_HOST_AUTH
 	&dev_attr_dhchap_secret.attr,
 	&dev_attr_dhchap_ctrl_secret.attr,
-- 
2.54.0



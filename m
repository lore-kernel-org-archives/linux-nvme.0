Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38A52C55AB9
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Feb 2026 12:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/yYXSUutZ2VmHq2QIlyDWBW1FBeXp3LglRCSAoPlYis=; b=DASR7gp9bE/Px6g1ESKrIV+j3m
	EeyKQ0GOQns78RtQhlue9oxgpll0V5F4H1nB6Q/VZPG7hnHJN8oqOstXE7Bj6dZ7eOCOEuV/GzwJw
	EfFOmTMNNB3xAq7s8uD/clf1PSPfzMWiwEoNth7q4q2gApw5jsFLwukdpwlcl6izikw+kUcoi9wZf
	/k6xhZMMDog2zLoFaGdz7B/Et3gnfPyYAqq7lwrF0nytt/mUbwGwaZTFBArldecc21RfNisjahteW
	jJtCPam+DRih4jlYOLXSojv/l9dTQoXnjYezYH2FqcyhH1NKuAWI5d/53eDg5UUHuamKUJd4VVaTy
	qD9dy9jA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtPyr-0000000EVHq-29RZ;
	Fri, 20 Feb 2026 12:51:37 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtPyp-0000000EVFa-09vI
	for linux-nvme@lists.infradead.org;
	Fri, 20 Feb 2026 12:51:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771591894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/yYXSUutZ2VmHq2QIlyDWBW1FBeXp3LglRCSAoPlYis=;
	b=MUcIu++rpi6C1fsFnfobxNoMTtiO4f7Njfo0rjEUAOLZ6PIunFeUVaiGflgABlQaa78/dQ
	A5TxCRp7RJkrfNWQkHsD5VhBuv+95f6dJtSSA8icSJNtWm61vibK4PVClbc5oxF5Frokob
	o6OEqwZOKaZm4Hp79mUUxipCvYqIQWk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-297-fuEVPVrZNNeoYFYtqj1K9Q-1; Fri,
 20 Feb 2026 07:51:30 -0500
X-MC-Unique: fuEVPVrZNNeoYFYtqj1K9Q-1
X-Mimecast-MFC-AGG-ID: fuEVPVrZNNeoYFYtqj1K9Q_1771591889
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 14E2D195609F;
	Fri, 20 Feb 2026 12:51:29 +0000 (UTC)
Received: from mlombard-thinkpadt14gen4.rmtit.csb (unknown [10.45.224.125])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4342D1800352;
	Fri, 20 Feb 2026 12:51:25 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: kbusch@kernel.org
Cc: mheyne@amazon.de,
	emilne@redhat.com,
	jmeneghi@redhat.com,
	linux-nvme@lists.infradead.org,
	dwagner@suse.de,
	mlombard@arkamax.eu,
	mkhalfella@purestorage.com
Subject: [PATCH V2 4/5] nvme: add sysfs attribute to change IO timeout per nvme controller
Date: Fri, 20 Feb 2026 13:51:07 +0100
Message-ID: <20260220125108.483250-5-mlombard@redhat.com>
In-Reply-To: <20260220125108.483250-1-mlombard@redhat.com>
References: <20260220125108.483250-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Gymqi6Lddm54l7eJ5AapmeWB1LyV188UF8my5Gefwoc_1771591889
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260220_045135_433922_62BC0635 
X-CRM114-Status: GOOD (  13.63  )
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
 drivers/nvme/host/sysfs.c | 40 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 43 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index bca3a7a0bd88..af0710c031e7 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4170,6 +4170,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
 		mutex_unlock(&ctrl->namespaces_lock);
 		goto out_unlink_ns;
 	}
+	blk_queue_rq_timeout(ns->queue, ctrl->io_timeout);
 	nvme_ns_add_to_ctrl_list(ns);
 	mutex_unlock(&ctrl->namespaces_lock);
 	synchronize_srcu(&ctrl->srcu);
@@ -5108,6 +5109,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
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
index 7733ca362ccb..8f5ac73129bc 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -635,6 +635,45 @@ static ssize_t nvme_admin_timeout_store(struct device *dev,
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
+	if (ctrl->ops->flags & NVME_F_FABRICS)
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
@@ -777,6 +816,7 @@ static struct attribute *nvme_dev_attrs[] = {
 	&dev_attr_cntrltype.attr,
 	&dev_attr_dctype.attr,
 	&dev_attr_admin_timeout.attr,
+	&dev_attr_io_timeout.attr,
 #ifdef CONFIG_NVME_HOST_AUTH
 	&dev_attr_dhchap_secret.attr,
 	&dev_attr_dhchap_ctrl_secret.attr,
-- 
2.53.0



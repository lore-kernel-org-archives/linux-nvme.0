Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 136A0CD3447
	for <linux-nvme@archiver.kernel.org>; Fri,  8 May 2026 13:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Pn7lRrOpbLIJcgGVz5BLiamaNSd1uTvH0ipHhIX6hTo=; b=UzbfhsQDNWojjkjFA0tSEMtlJW
	WmeqYoLo7XlaO+TEdWLaPEEsNjjR7VYvnRh4oBHaTahOs7WajIhYzOOdFtbCctxna4npYN5j7wKGG
	m6hz3FqS5apldmyYnjWpOrpNSmdGU4yd8HSl+ISJi2dkzcqL5/Gb7g/3yNXzP2/zdElmMu1blv0bB
	dN/MCXFrAz6zGXZlif8y+X+2Lte9FpZsXdVw4gD7sLkORhP0LH5kdcTndHmiFqKrUGOW8lmsLtVhC
	AmXVTSuGaNW5C7lGuGTmZK7ApH+OcAs8QnURqvqTQ+0ykL523v4eo2hhokdAG15DoX2L4tIke2NNR
	fNfkGMHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wLLL5-00000006YZp-0ca1;
	Fri, 08 May 2026 13:33:59 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wLLL2-00000006YXX-31f6
	for linux-nvme@lists.infradead.org;
	Fri, 08 May 2026 13:33:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778247236;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pn7lRrOpbLIJcgGVz5BLiamaNSd1uTvH0ipHhIX6hTo=;
	b=KIXOMCLgbQcy/NStgNpzDD0gjwxg8tbo1IHjUoqLsMYNsPDJAz45PoQ1KkZ+CqRZUHF7CP
	EQ66Ref9YKUgl31xSbW18YWkKtOBjoG3lSrxTWcFlgCpCkuxWPLGQ75Zm9opnlXalNxaio
	no3t+F/N2uMi/ftanpzTaY8NDoWHock=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-354-VmgRlEz2MV-Oyebesyg3Ww-1; Fri,
 08 May 2026 09:33:52 -0400
X-MC-Unique: VmgRlEz2MV-Oyebesyg3Ww-1
X-Mimecast-MFC-AGG-ID: VmgRlEz2MV-Oyebesyg3Ww_1778247229
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2928F1800616;
	Fri,  8 May 2026 13:33:49 +0000 (UTC)
Received: from mlombard-thinkpadt14gen4.rmtit.csb (unknown [10.44.32.105])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D6CA01944B20;
	Fri,  8 May 2026 13:33:45 +0000 (UTC)
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
Subject: [PATCH V4 2/9] nvme: add sysfs attribute to change admin timeout per nvme controller
Date: Fri,  8 May 2026 15:33:28 +0200
Message-ID: <20260508133335.98612-3-mlombard@redhat.com>
In-Reply-To: <20260508133335.98612-1-mlombard@redhat.com>
References: <20260508133335.98612-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: yepsmTvXQ88VjiwMp2wQSByfH24MvhKeY-uOSN6oOCQ_1778247229
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260508_063356_827253_D9C12F53 
X-CRM114-Status: GOOD (  13.80  )
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
on a per controller basis with nvme admin queues.
Add an admin_timeout attribute to nvme so that different
nvme controllers which may have different timeout
requirements can have custom admin timeouts set.

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
---
 drivers/nvme/host/core.c  |  1 +
 drivers/nvme/host/nvme.h  |  1 +
 drivers/nvme/host/sysfs.c | 42 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 44 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 89948d0acf18..b1bfcd0a0e5b 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -5140,6 +5140,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	memset(&ctrl->ka_cmd, 0, sizeof(ctrl->ka_cmd));
 	ctrl->ka_cmd.common.opcode = nvme_admin_keep_alive;
 	ctrl->ka_last_check_time = jiffies;
+	ctrl->admin_timeout = NVME_ADMIN_TIMEOUT;
 
 	BUILD_BUG_ON(NVME_DSM_MAX_RANGES * sizeof(struct nvme_dsm_range) >
 			PAGE_SIZE);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index ccd5e05dac98..9da3ebebe9c8 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -370,6 +370,7 @@ struct nvme_ctrl {
 	u16 mtfa;
 	u32 ctrl_config;
 	u32 queue_count;
+	u32 admin_timeout;
 
 	u64 cap;
 	u32 max_hw_sectors;
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index e59758616f27..9456af955aff 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -623,6 +623,47 @@ static ssize_t quirks_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RO(quirks);
 
+static ssize_t nvme_admin_timeout_show(struct device *dev,
+			struct device_attribute *attr, char *buf)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%u\n",
+				jiffies_to_msecs(ctrl->admin_timeout));
+}
+
+static ssize_t nvme_admin_timeout_store(struct device *dev,
+			struct device_attribute *attr,
+			const char *buf, size_t count)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+	u32 timeout;
+	int err;
+
+	/*
+	 * Wait until the controller reaches the LIVE state
+	 * to be sure that admin_q and fabrics_q are
+	 * properly initialized.
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
@@ -765,6 +806,7 @@ static struct attribute *nvme_dev_attrs[] = {
 	&dev_attr_cntrltype.attr,
 	&dev_attr_dctype.attr,
 	&dev_attr_quirks.attr,
+	&dev_attr_admin_timeout.attr,
 #ifdef CONFIG_NVME_HOST_AUTH
 	&dev_attr_dhchap_secret.attr,
 	&dev_attr_dhchap_ctrl_secret.attr,
-- 
2.54.0



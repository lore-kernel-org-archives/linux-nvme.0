Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E82BFA3758
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Sep 2024 13:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=l6AxS4YpS1wIrU9dW938lvfja9wx6A5mldfrvIZaPBE=; b=1kpTfQFh/NsjtYCjfjxDwLMg+b
	YqXNBd1VubueU/lY6+Hbf1kz61tpNYfqn+dh2fjC6jNfb0HPxysnXAxjp9jmI/Y6wVevqv9M6siPA
	vjNpxBpr81eEb6LBi0jnwj+//9L5G1cvwi8pZ6+UyqIGW8fXCseyBXSRCnvYJfrCweEoiWYN8XlOL
	W7vy2uIG1+yoqE13eLcpMMNveg7zFwicYgDeOCuiA7a3L38v8yvqxnhMFstBGNCUMQcGk4DiknV+3
	PzXPiYCqbGZkLo2dJqEqSbBh/dPUyBOQM2jDLxJ8Xq/RQ0lghX7mLG1IG7pT5ebQZpPXdXiZkjQMu
	cyiwUBAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sp6bj-0000000G4aE-3LoL;
	Fri, 13 Sep 2024 13:45:07 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sp6bX-0000000G4Xk-2A0U
	for linux-nvme@lists.infradead.org;
	Fri, 13 Sep 2024 13:44:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726235094;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l6AxS4YpS1wIrU9dW938lvfja9wx6A5mldfrvIZaPBE=;
	b=blUbYWCGECcfhGfdUAl5pbUjiqnVbRwtAaO9nBaxWdOyJeDqzZ87jcF/RPjkPYaxDjIeu7
	Re+sCDA7dqJI8/faxwC7QCo/3wEg8MlFhl2n70IXPDbX4tw8rusZrzKClN48Fbsvbvnarm
	JuYFsNKvCglcr8ei2WcNM3bkdvLDoFg=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-605-JMJv-THFPWOGrJ4J3YDmsg-1; Fri,
 13 Sep 2024 09:44:51 -0400
X-MC-Unique: JMJv-THFPWOGrJ4J3YDmsg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5943D1955F41;
	Fri, 13 Sep 2024 13:44:49 +0000 (UTC)
Received: from fedora-work.redhat.com (unknown [10.22.65.135])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5F2B03001D14;
	Fri, 13 Sep 2024 13:44:47 +0000 (UTC)
From: David Jeffery <djeffery@redhat.com>
To: Keith Busch <kbusch@kernel.org>,
	ens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org,
	David Jeffery <djeffery@redhat.com>
Subject: [PATCH 2/4] nvme: add sysfs attribute to change admin timeout per nvme dev
Date: Fri, 13 Sep 2024 09:44:28 -0400
Message-ID: <20240913134430.5416-3-djeffery@redhat.com>
In-Reply-To: <20240913134430.5416-1-djeffery@redhat.com>
References: <20240913134430.5416-1-djeffery@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240913_064455_645493_BF2DEC57 
X-CRM114-Status: GOOD (  13.57  )
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

Currently, there is no method to adjust the timeout values on a per device
basis with nvme admin queues. Add an admin_timeout attribute to nvme so
that different types of nvme devices which may have different timeout
requirements can have custom admin timeouts set.

Signed-off-by: David Jeffery <djeffery@redhat.com>
---
 drivers/nvme/host/sysfs.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index ba05faaac562..1d60316274ce 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -60,6 +60,36 @@ static ssize_t nvme_adm_passthru_err_log_enabled_store(struct device *dev,
 	return count;
 }
 
+static ssize_t nvme_admin_timeout_show(struct device *dev,
+                struct device_attribute *attr, char *buf)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%u\n", jiffies_to_msecs(
+					ctrl->admin_q->rq_timeout));
+}
+
+static ssize_t nvme_admin_timeout_store(struct device *dev,
+                struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+	unsigned int timeout;
+	int err;
+
+	err = kstrtou32(buf, 10, &timeout);
+	if (err || !timeout)
+		return -EINVAL;
+
+	blk_queue_rq_timeout(ctrl->admin_q, msecs_to_jiffies(timeout));
+
+	return count;
+}
+
+static struct device_attribute dev_attr_admin_timeout = \
+	__ATTR(admin_timeout, S_IRUGO | S_IWUSR, \
+	nvme_admin_timeout_show, nvme_admin_timeout_store);
+
+
 static inline struct nvme_ns_head *dev_to_ns_head(struct device *dev)
 {
 	struct gendisk *disk = dev_to_disk(dev);
@@ -708,6 +738,7 @@ static struct attribute *nvme_dev_attrs[] = {
 	&dev_attr_tls_key.attr,
 #endif
 	&dev_attr_adm_passthru_err_log_enabled.attr,
+	&dev_attr_admin_timeout.attr,
 	NULL
 };
 
-- 
2.46.0



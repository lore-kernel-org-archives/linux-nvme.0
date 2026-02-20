Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F5C4C55ABE
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Feb 2026 12:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GQtCpn9DC9rZ7cwXs7+G5fz/BRgM+CxT9tQ4vBV8NFc=; b=MUF4bvyo39T2R/7MiuURvNiBqC
	WtSpeCMSwQgvVppaDqT4gby3aT2WysNJttF4yXVY3Ava4LnXfVxa5DaWCfY8503NgAdlLa2FXk/+w
	/+sSOTkQLqCllHudr/4BZEtuL+YLTkDZdzyPQ0pJX0O9RVNHont0xtrDlNKdKDqJquYouHJeQg+hs
	79f1e8VbZFuib4PdjGcbZu0vk5QSoXvSvGVsI4WlZlzdl/UxliDUnNWjbpOEhz7yl7Uaj/c5gBsUs
	+qKd+h0owQvY2U49Q4DmeKSHBV1k4eOY6/pu45XLzcWCech75EptM9oVMFxpViFuKqNJ/4RtM+vhr
	Uv8IV3Iw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtPyl-0000000EVDM-37Xe;
	Fri, 20 Feb 2026 12:51:31 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtPyh-0000000EVA4-0WmA
	for linux-nvme@lists.infradead.org;
	Fri, 20 Feb 2026 12:51:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771591886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GQtCpn9DC9rZ7cwXs7+G5fz/BRgM+CxT9tQ4vBV8NFc=;
	b=XB3duPAx3o+E3pi1vgyWFdGnM5oBZ8httUCDzO/1ekFMNtho6U/KqhVBqlL4+XsQw/0X9a
	/ATpxRalvKjrwFXBVQJLwRTdlxa3i1C0ITo8lOUR6W9eI3kS0R2jFFHg+S/JEgGvGTYbJA
	K1ClLiSqnUwFi4QiiDW6AIfR/QHpk/c=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-15-MPtV73xdOzGztpi2sFqwGw-1; Fri,
 20 Feb 2026 07:51:22 -0500
X-MC-Unique: MPtV73xdOzGztpi2sFqwGw-1
X-Mimecast-MFC-AGG-ID: MPtV73xdOzGztpi2sFqwGw_1771591881
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 01182180034A;
	Fri, 20 Feb 2026 12:51:21 +0000 (UTC)
Received: from mlombard-thinkpadt14gen4.rmtit.csb (unknown [10.45.224.125])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2BAA01800352;
	Fri, 20 Feb 2026 12:51:17 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: kbusch@kernel.org
Cc: mheyne@amazon.de,
	emilne@redhat.com,
	jmeneghi@redhat.com,
	linux-nvme@lists.infradead.org,
	dwagner@suse.de,
	mlombard@arkamax.eu,
	mkhalfella@purestorage.com
Subject: [PATCH V2 2/5] nvme: add sysfs attribute to change admin timeout per nvme controller
Date: Fri, 20 Feb 2026 13:51:05 +0100
Message-ID: <20260220125108.483250-3-mlombard@redhat.com>
In-Reply-To: <20260220125108.483250-1-mlombard@redhat.com>
References: <20260220125108.483250-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ETctuZ63YZhwFsHZv1lKFMCOZuvBLBl2EoMDfgRb554_1771591881
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260220_045127_242949_B6154711 
X-CRM114-Status: GOOD (  11.10  )
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

Reviewed-by: Mohamed Khalfella <mkhalfella@purestorage.com>
Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
---
 drivers/nvme/host/sysfs.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 29430949ce2f..7733ca362ccb 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -601,6 +601,40 @@ static ssize_t dctype_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(dctype);
 
+static ssize_t nvme_admin_timeout_show(struct device *dev,
+			struct device_attribute *attr, char *buf)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%u\n",
+				jiffies_to_msecs(ctrl->admin_q->rq_timeout));
+}
+
+static ssize_t nvme_admin_timeout_store(struct device *dev,
+			struct device_attribute *attr,
+			const char *buf, size_t count)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+	unsigned int jiff;
+	u32 timeout;
+	int err;
+
+	err = kstrtou32(buf, 10, &timeout);
+	if (err || !timeout)
+		return -EINVAL;
+
+	jiff = msecs_to_jiffies(timeout);
+
+	blk_queue_rq_timeout(ctrl->admin_q, jiff);
+	if (ctrl->ops->flags & NVME_F_FABRICS)
+		 blk_queue_rq_timeout(ctrl->fabrics_q, jiff);
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
@@ -742,6 +776,7 @@ static struct attribute *nvme_dev_attrs[] = {
 	&dev_attr_kato.attr,
 	&dev_attr_cntrltype.attr,
 	&dev_attr_dctype.attr,
+	&dev_attr_admin_timeout.attr,
 #ifdef CONFIG_NVME_HOST_AUTH
 	&dev_attr_dhchap_secret.attr,
 	&dev_attr_dhchap_ctrl_secret.attr,
-- 
2.53.0



Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F6E9EB4917
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Feb 2026 12:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Q0brTfKVvbpQMbfcY7JpdtYeI8LmnojDJivSU87o9C0=; b=NQ+QTn542FkNOWMvlOmXouFJaC
	uU9n/90/hjVDvXXFT6SyU4KznuQ98+60HXYVrhSK0xN60JxBbERefwpLTn4n/ZRNlQVX3XtE/AYwQ
	METuCuBjP0wCZvv3ff5fA5UwsJLPF2GRvqI+xy9TcUjsnJ4CnOas6Xs51XVaHMNKFwUn66eKq4BHp
	BSeNO80IYGrH676ssw44xpsjLYMJceKbROzHXkZYUAX+KKYE4KLeOpl9wgmse6bY2O/Li+mYIPByJ
	ZvRGcI9DYxSPWEWApx6Ux4Qt6zH8ydzAvsNiDyXU79YMJlz6/PoiNV3Zi86Ks1la9kE2ZdmgTlsEZ
	ZjrlkeYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqVXh-000000023zV-27IN;
	Thu, 12 Feb 2026 12:11:33 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqVXd-000000023xi-1AJq
	for linux-nvme@lists.infradead.org;
	Thu, 12 Feb 2026 12:11:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770898288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q0brTfKVvbpQMbfcY7JpdtYeI8LmnojDJivSU87o9C0=;
	b=GyxWgdOnfjdNd90yKNZavDnXsU/3BzwXWFC/VVwoljyarGAvbB1fp+R1Tx6tQZ0YJC5OOf
	VGLoSucYsSKnYYlJkTdav7kDvCJrBaGItVYUsh1yGrd4LMWXDcGrID++StYMbIfWfQbpXT
	R4tmcJtz/pZl2dqNSBfpHz2xEF2kCtc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-658-WbFIq3ZLMiasEqqruot0vQ-1; Thu,
 12 Feb 2026 07:10:02 -0500
X-MC-Unique: WbFIq3ZLMiasEqqruot0vQ-1
X-Mimecast-MFC-AGG-ID: WbFIq3ZLMiasEqqruot0vQ_1770898201
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DC01E1955D7A;
	Thu, 12 Feb 2026 12:10:00 +0000 (UTC)
Received: from mlombard-thinkpadt14gen4.rmtit.csb (unknown [10.44.32.22])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B67541956095;
	Thu, 12 Feb 2026 12:09:58 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: kbusch@kernel.org
Cc: mheyne@amazon.de,
	emilne@redhat.com,
	jmeneghi@redhat.com,
	linux-nvme@lists.infradead.org,
	dwagner@suse.de,
	mlombard@bsdbackstore.eu
Subject: [PATCH RFC 2/5] nvme: add sysfs attribute to change admin timeout per nvme controller
Date: Thu, 12 Feb 2026 13:09:48 +0100
Message-ID: <20260212120951.79738-3-mlombard@redhat.com>
In-Reply-To: <20260212120951.79738-1-mlombard@redhat.com>
References: <20260212120951.79738-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: P15Bd9595ZUEeTft6dqMTvFRKe0xB2f7Vzxpzsvs7fg_1770898201
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260212_041130_933767_EFB0654D 
X-CRM114-Status: GOOD (  11.08  )
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
 drivers/nvme/host/sysfs.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 29430949ce2f..149cd1ab3b3d 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -601,6 +601,36 @@ static ssize_t dctype_show(struct device *dev,
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
+	u32 timeout;
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
+static struct device_attribute dev_attr_admin_timeout =  \
+	__ATTR(admin_timeout, S_IRUGO | S_IWUSR, \
+	nvme_admin_timeout_show, nvme_admin_timeout_store);
+
 #ifdef CONFIG_NVME_HOST_AUTH
 static ssize_t nvme_ctrl_dhchap_secret_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
@@ -742,6 +772,7 @@ static struct attribute *nvme_dev_attrs[] = {
 	&dev_attr_kato.attr,
 	&dev_attr_cntrltype.attr,
 	&dev_attr_dctype.attr,
+	&dev_attr_admin_timeout.attr,
 #ifdef CONFIG_NVME_HOST_AUTH
 	&dev_attr_dhchap_secret.attr,
 	&dev_attr_dhchap_ctrl_secret.attr,
-- 
2.53.0



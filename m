Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06BEDC3DA59
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Jul 2024 08:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CpZUPRGB529S0ORH/eevRz7hOKlKf7Dv5sYk4z1gLOU=; b=A/gL6aCNZ5zGljgBCPxh45VD2j
	KSeYpBz9Y5a6puwGJSVJ1mC9MlrhrwKgpFK5qO26YGSIX2cKYAWXYmpGSKUKfdG2C9u8K4wWD69LI
	sTr09JRHH+mVO5ULDGftFdygH2X+juaXbK1fE+VXM6QBvWf/zP7laVy00TgN+MlBgAts/i0oPU4Tm
	LH0RW98+XzUfEWjtHle+cKvIusJqDthWk2u6VQHvr7Xv10kwp+TQ5AloU/K6ld/WG180zgE+dzqsC
	JnRQJ9DKLMbYY3S1Lj7IEPN3SVeHL48ilWKbKaxmBaS/zTDOqdDFLJ4NqKwLNsUmGMxbaLj7Ia1hc
	s8llK42Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUj9F-000000026Jd-1X3F;
	Fri, 19 Jul 2024 08:39:29 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUj99-000000026FC-31Z1
	for linux-nvme@lists.infradead.org;
	Fri, 19 Jul 2024 08:39:25 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 0FCCB61C3A;
	Fri, 19 Jul 2024 08:39:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A796C32782;
	Fri, 19 Jul 2024 08:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721378362;
	bh=hv0cTTPILUqULWK400+pLotrR8rMruQcfGGDijQTWbQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ic8dO0fZE0HgN8pGi0l6FmPr/QJXYDotnt/FGItPF4zMmvS4O6abCCJT7PA5UUao9
	 K3CQs9cEQfh+/POxCBDQJCe2X5v9OwESGF6M5/jH/G+qTq2cYuCkrsmbGqHvR+yzWy
	 3EJm2XEKYe8wLn/svAX9RqFkPesxrelnABAmxP4sbTxAA1155C0+qeFwlq1I4QxtyN
	 0H5s0tUtQWVxiAM/lUN7Cr+Rp2fow1nR+pxqMxYx8pPL39bT3UM56u9/5UBtYToNEI
	 euWMOFb1uh+o3dcXTBRk+M+WiQmaGkLQifWb5jKVi4flc7eYdRH9ztfU9VMuZ2Buvj
	 Yf4Uw19Y3J4IQ==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 5/9] nvme: split off TLS sysfs attributes into a separate group
Date: Fri, 19 Jul 2024 10:38:57 +0200
Message-Id: <20240719083901.35399-6-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240719083901.35399-1-hare@kernel.org>
References: <20240719083901.35399-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240719_013923_942003_538A4291 
X-CRM114-Status: GOOD (  14.30  )
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

From: Hannes Reinecke <hare@suse.de>

Split off TLS sysfs attributes into a separate group to improve
readability and to keep all TLS related handling in one section.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/sysfs.c | 62 ++++++++++++++++++++++++++-------------
 1 file changed, 41 insertions(+), 21 deletions(-)

diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index c391ad6c5a88..dc7ceb53147f 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -664,19 +664,6 @@ static DEVICE_ATTR(dhchap_ctrl_secret, S_IRUGO | S_IWUSR,
 	nvme_ctrl_dhchap_ctrl_secret_show, nvme_ctrl_dhchap_ctrl_secret_store);
 #endif
 
-#ifdef CONFIG_NVME_TCP_TLS
-static ssize_t tls_key_show(struct device *dev,
-			    struct device_attribute *attr, char *buf)
-{
-	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
-
-	if (!ctrl->tls_pskid)
-		return 0;
-	return sysfs_emit(buf, "%08x\n", ctrl->tls_pskid);
-}
-static DEVICE_ATTR_RO(tls_key);
-#endif
-
 static struct attribute *nvme_dev_attrs[] = {
 	&dev_attr_reset_controller.attr,
 	&dev_attr_rescan_controller.attr,
@@ -703,9 +690,6 @@ static struct attribute *nvme_dev_attrs[] = {
 #ifdef CONFIG_NVME_HOST_AUTH
 	&dev_attr_dhchap_secret.attr,
 	&dev_attr_dhchap_ctrl_secret.attr,
-#endif
-#ifdef CONFIG_NVME_TCP_TLS
-	&dev_attr_tls_key.attr,
 #endif
 	&dev_attr_adm_passthru_err_log_enabled.attr,
 	NULL
@@ -737,11 +721,6 @@ static umode_t nvme_dev_attrs_are_visible(struct kobject *kobj,
 	if (a == &dev_attr_dhchap_ctrl_secret.attr && !ctrl->opts)
 		return 0;
 #endif
-#ifdef CONFIG_NVME_TCP_TLS
-	if (a == &dev_attr_tls_key.attr &&
-	    (!ctrl->opts || strcmp(ctrl->opts->transport, "tcp")))
-		return 0;
-#endif
 
 	return a->mode;
 }
@@ -752,8 +731,49 @@ const struct attribute_group nvme_dev_attrs_group = {
 };
 EXPORT_SYMBOL_GPL(nvme_dev_attrs_group);
 
+#ifdef CONFIG_NVME_TCP_TLS
+static ssize_t tls_key_show(struct device *dev,
+			    struct device_attribute *attr, char *buf)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+
+	if (!ctrl->tls_pskid)
+		return 0;
+	return sysfs_emit(buf, "%08x\n", ctrl->tls_pskid);
+}
+static DEVICE_ATTR_RO(tls_key);
+
+static struct attribute *nvme_tls_attrs[] = {
+	&dev_attr_tls_key.attr,
+};
+
+static umode_t nvme_tls_attrs_are_visible(struct kobject *kobj,
+		struct attribute *a, int n)
+{
+	struct device *dev = container_of(kobj, struct device, kobj);
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+
+	if (!ctrl->opts || strcmp(ctrl->opts->transport, "tcp"))
+		return 0;
+
+	if (a == &dev_attr_tls_key.attr &&
+	    !ctrl->opts->tls)
+		return 0;
+
+	return a->mode;
+}
+
+const struct attribute_group nvme_tls_attrs_group = {
+	.attrs		= nvme_tls_attrs,
+	.is_visible	= nvme_tls_attrs_are_visible,
+};
+#endif
+
 const struct attribute_group *nvme_dev_attr_groups[] = {
 	&nvme_dev_attrs_group,
+#ifdef CONFIG_NVME_TCP_TLS
+	&nvme_tls_attrs_group,
+#endif
 	NULL,
 };
 
-- 
2.35.3



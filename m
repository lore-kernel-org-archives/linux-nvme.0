Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70FD6C3DA5D
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Jul 2024 12:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rG24GZYl3/DcpbHudOHIq2c5VIv1FK4Pds9SALuDVY4=; b=fFfYu6sb+nxOuLgLTdAZ5EXd/J
	/YvWdT5T8qIB7vHmHKAZfxQEafS+eX8nbvPE/I5NEh7qPuhWOsYAqthKmf44vfQJwNc4n3mk8osiJ
	jBFAn5hV6uZYyGSbFLrMPLqGVBUTOK04XDc5FI9714wdOlo/MnxrF06sJG1POiW0UvPrpdDk4FOIZ
	RnZo0VM4yVu9DPeO9c1Z6CVGjrL17esSAErMbxMwEQ+HZJ6VRm/VGRqFayDNSrc95oV+DY1D8lgW9
	ef0m98CPdIy192p7RyF4BIatg6jWdqr9luBL9A+tTI4EJYPHteyxuvN2kay5wJwoC9dE5WUPMFgi2
	tvguSGIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sVrkZ-00000009SbH-3Pqt;
	Mon, 22 Jul 2024 12:02:43 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sVrkW-00000009SXo-40bw
	for linux-nvme@lists.infradead.org;
	Mon, 22 Jul 2024 12:02:42 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 3593ECE0B2E;
	Mon, 22 Jul 2024 12:02:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97A18C4AF0D;
	Mon, 22 Jul 2024 12:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721649758;
	bh=OXwq21fz7IiPEqtxMDbROTCJ3uCBgf4hhWhlbrLr0s8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NapwBLyfhTfdzzycHfZ3Wnp2uoUT83XPDoKAivfc246p9M6KK3N6Pf5v8QoofphrY
	 ABXArmz99STYreNeiDhK7+Dq3Urjb0ivkEM7Qf7lzfhXC+C3qs8UfVniNPOe/0XtFT
	 FW5Wm9KxZCuZcK9NKvz72QlBB281nbYRUK5C3rbsG7v9yojsah6aht+Tan6Gz9Xsut
	 eyOH0u5WrF/VSp1xhvE8EitcU7xZOpU/Voyx28qwGRsJ66bjXDXhXppe3y0bX+bXdL
	 /cJpJR0WxecaUo80ePS5ztz8uhLuIx+Oa40nV6F2T7wd20QHcR/ZQ3TeeVmP1E4MQU
	 G8wMJHerLqqgA==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 5/9] nvme: split off TLS sysfs attributes into a separate group
Date: Mon, 22 Jul 2024 14:02:22 +0200
Message-Id: <20240722120226.88737-6-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240722120226.88737-1-hare@kernel.org>
References: <20240722120226.88737-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240722_050241_429083_CF13F4C9 
X-CRM114-Status: GOOD (  14.34  )
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
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
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



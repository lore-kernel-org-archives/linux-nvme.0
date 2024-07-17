Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2210BC3DA4B
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Jul 2024 10:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4feMCzRarDS/WGbgt2As6Sn26Tp2oS8a8wYvnW7ISi0=; b=sn7l2Yp4mXhi54dTe9/n9y3vge
	9YyXxNa4upDhB+Ps47Dt9xIuOGIeY2S7KUL9o+4MKMmwmEMa64wdhfYSYtbwhnOERHLfe0Z81DrDc
	Ql6ZIUEEaCVZggba1qWeHuFS3cs6/3kV9AMuN9yIN50RKgId0V+jI9pIOHCObPfefNi5y+Om99v+V
	1T+3dtB8+Fa95VOnzSBc1hZbdaNQGwBAg78i13xXD9VGm4iHyn2ErIy9I/cJjRpeiI58Soc8mg5a0
	PnVFDsjEHWQMnl+71cBAve+/ST8UQF/aA1g7XYVC/gM83cusL/2SXf7K9oZnU2y/8UUs7V+wH39ax
	diF7Yz5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sU1hC-0000000DSTO-0yVw;
	Wed, 17 Jul 2024 10:15:38 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sU0gY-0000000DFpN-1CAd
	for linux-nvme@lists.infradead.org;
	Wed, 17 Jul 2024 09:11:24 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 8302BCE16C5;
	Wed, 17 Jul 2024 09:10:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6182AC4AF0F;
	Wed, 17 Jul 2024 09:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721207451;
	bh=WNkgWFxRfYf8Z/ebCKQaMdmJH/1rl0azN5emNeia2lM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JaEmOCD5fOri5rqCE3GKf/gsI4sCm32C2zrOhpe1oG6O/6oDKw/1wkzJ/LMoe1H8C
	 RQthmGQjsdu+xNqL4GQhxuzcxQa04DJhD/djzlKv8DoXL1hTb9KxujkoKwjQHi/KgR
	 q0pyYXQIxCk3BOYAZH6WKHbG342KBEbfe+ECV+P6ObFh6KE8+J27llVvC7KQQFPKq8
	 Qd+Mogm3RvmXdJaQ73GXQsx2+8wK/KwMvRvfTSSMfcE+D250GeG6jAniMjcGwTjgmt
	 UMHHhtIX31MvfaZY3dvln62KfxPwUHXy3WCVcDTGN/6WT6H6VCJbOfYtvmY2BzFtnx
	 +Fv8AQSRTF+FQ==
From: Hannes Reinecke <hare@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 06/16] nvme-sysfs: add 'tls_keyring' attribute
Date: Wed, 17 Jul 2024 11:10:21 +0200
Message-Id: <20240717091031.143188-7-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240717091031.143188-1-hare@kernel.org>
References: <20240717091031.143188-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240717_021054_622560_C65E7662 
X-CRM114-Status: GOOD (  12.19  )
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

Add a 'tls_keyring' attribute to display the contents of the
--keyring option from the connect string. Adding this attribute
allows us to recreate the original connect string from sysfs
settings.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/host/sysfs.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index e5cd738660b1..462d71e2fbf8 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -689,6 +689,18 @@ static ssize_t tls_configured_key_show(struct device *dev,
 	return sysfs_emit(buf, "%08x\n", key_serial(key));
 }
 static DEVICE_ATTR_RO(tls_configured_key);
+
+static ssize_t tls_keyring_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+	struct key *keyring = ctrl->opts->keyring;
+
+	if (!keyring)
+		return 0;
+	return sysfs_emit(buf, "%s\n", keyring->description);
+}
+static DEVICE_ATTR_RO(tls_keyring);
 #endif
 
 static struct attribute *nvme_dev_attrs[] = {
@@ -721,6 +733,7 @@ static struct attribute *nvme_dev_attrs[] = {
 #ifdef CONFIG_NVME_TCP_TLS
 	&dev_attr_tls_key.attr,
 	&dev_attr_tls_configured_key.attr,
+	&dev_attr_tls_keyring.attr,
 #endif
 	&dev_attr_adm_passthru_err_log_enabled.attr,
 	NULL
@@ -759,6 +772,9 @@ static umode_t nvme_dev_attrs_are_visible(struct kobject *kobj,
 	if (a == &dev_attr_tls_configured_key.attr &&
 	    (!ctrl->opts || strcmp(ctrl->opts->transport, "tcp")))
 		return 0;
+	if (a == &dev_attr_tls_keyring.attr &&
+	    (!ctrl->opts || strcmp(ctrl->opts->transport, "tcp")))
+		return 0;
 #endif
 
 	return a->mode;
-- 
2.35.3



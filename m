Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7D41C3DA42
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Jul 2024 09:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fR7MyFoFpfDQfopt89G9Fhxt347AvVQ6F1481dMZpQs=; b=P1rC6ub531EogoR6Icy/ABEi8G
	XDz78ef80OqXAE4voKFJwcV2fjrJaUa7LKcx1kLhV46KbQfIyD3ZwbFdWic1IvZqXZOuPdIDDv+70
	hatv+fYy/cuuIbTeJAzug21vRuo0n9F9Z8gB7vsbjGrBbjGTLY0e5bhlwtTqNokokPqRnExwvJV+r
	3VJNxHQ2FHXU4RIREtZWvuj614jxvKJDmBKFOMqG28wcnyeJtg9qxdrhx7jXXuNRC2cHlQM9C95Y+
	sVgYuXw28WYDEdhgjYMGpWAAKI5VtpRIwODSghn8M+SXYlHj141aiI2dJCyVMT0LRhzlnRKKGfmqP
	/3Wg+ppw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sU0h7-0000000DG5D-2jAS;
	Wed, 17 Jul 2024 09:11:29 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sU0gV-0000000DFnX-0oy3
	for linux-nvme@lists.infradead.org;
	Wed, 17 Jul 2024 09:11:27 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 4DC7F6167B;
	Wed, 17 Jul 2024 09:10:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4D0DC32782;
	Wed, 17 Jul 2024 09:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721207449;
	bh=H3TqKgd+WGQqa9yO9L45VoQFNhw7gHFLcnmw48vMZ+w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lr/oRLoy/+4FwFZI68rFMd6+IAcYXTpoal8E9M9sn8retxL/kQut3QGFgTqYdDRit
	 QvZ1lKZHdkGyIiFb+CjeXtReaV2J6iov/Ffe+OOkYCQ5jmj9TYIg6jTILmtOi6sM0X
	 sg/HaWAcz6EtDZ8EDYUK76s1d79XqB7Yi9iCOvhzxDd9+Q49iwcocWYQZhb/V3+cko
	 /bfDc/lBiOEuuTZ5t2LRkov7wtPO9BbmKOsatG+J/5cdO3rTZKjbDzHnSG9kbxlnot
	 XIBEqouT6mNrrY6wwUdJ0v84g18BZli/0HEcsmij6vtKzhx11tUHYmmiDsu3x52Wn7
	 vkf4n9yQvxsxQ==
From: Hannes Reinecke <hare@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 05/16] nvme-sysfs: add 'tls_configured_key' sysfs attribute
Date: Wed, 17 Jul 2024 11:10:20 +0200
Message-Id: <20240717091031.143188-6-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240717091031.143188-1-hare@kernel.org>
References: <20240717091031.143188-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240717_021051_327337_98D388B7 
X-CRM114-Status: GOOD (  13.64  )
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

There is a difference between the negotiated TLS key (which is
always present for a TLS encrypted connection) and the configured
TLS key (which is specified with the --tls_key command line option).
To differentate between these two add a new sysfs attribute
'tls_configured_key' to hold the specified on the command line.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/host/sysfs.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index be36206cb594..e5cd738660b1 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -676,6 +676,19 @@ static ssize_t tls_key_show(struct device *dev,
 	return sysfs_emit(buf, "%08x\n", ctrl->tls_pskid);
 }
 static DEVICE_ATTR_RO(tls_key);
+
+static ssize_t tls_configured_key_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+	struct key *key = ctrl->opts->tls_key;
+
+	if (!key)
+		return 0;
+
+	return sysfs_emit(buf, "%08x\n", key_serial(key));
+}
+static DEVICE_ATTR_RO(tls_configured_key);
 #endif
 
 static struct attribute *nvme_dev_attrs[] = {
@@ -707,6 +720,7 @@ static struct attribute *nvme_dev_attrs[] = {
 #endif
 #ifdef CONFIG_NVME_TCP_TLS
 	&dev_attr_tls_key.attr,
+	&dev_attr_tls_configured_key.attr,
 #endif
 	&dev_attr_adm_passthru_err_log_enabled.attr,
 	NULL
@@ -742,6 +756,9 @@ static umode_t nvme_dev_attrs_are_visible(struct kobject *kobj,
 	if (a == &dev_attr_tls_key.attr &&
 	    (!ctrl->opts || strcmp(ctrl->opts->transport, "tcp")))
 		return 0;
+	if (a == &dev_attr_tls_configured_key.attr &&
+	    (!ctrl->opts || strcmp(ctrl->opts->transport, "tcp")))
+		return 0;
 #endif
 
 	return a->mode;
-- 
2.35.3



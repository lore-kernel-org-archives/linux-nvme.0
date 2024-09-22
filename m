Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F63CCF9C69
	for <linux-nvme@archiver.kernel.org>; Sun, 22 Sep 2024 05:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Na8SvrxLN+YX4+gs7MaINxBMQEuGxhcl5ldrUojAQMY=; b=2l5wSJBOOnvWSXOo/K0W+clYez
	YyM2hhvlpDCegXmNOMWvyMp2mNWy2xB1oWQ4KiMRuXClkY0ar1K7lKwhw1NOUNN8fL1FYB+s9iYkk
	vr4mp44dgixtqInG0uPq35cmZeqWuPuM4KM1ijxsE3thF2uVqZgmEiU2ITUV2gtI312bdFHinBlPf
	QEbZtHcHMRqDemxnOYkeAlDC8ktRPS+RnYg6XyO/8cBgBcEJlrVUuTs1pD/Y4ytZRKVevZxLl01xt
	S4pYVHy6AQh73F8gxY8E5/ZidRPUAHPWkmVq1vBvRGCB+GkUZg1SVck2rCQpxy1k8BJ4Sa0PuilWl
	a88H+DiQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1ssFJC-0000000Ek8h-2ngy;
	Sun, 22 Sep 2024 05:38:58 +0000
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1ssFJ9-0000000Ek8L-42CZ
	for linux-nvme@lists.infradead.org;
	Sun, 22 Sep 2024 05:38:57 +0000
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-717934728adso2383633b3a.2
        for <linux-nvme@lists.infradead.org>; Sat, 21 Sep 2024 22:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726983535; x=1727588335; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Na8SvrxLN+YX4+gs7MaINxBMQEuGxhcl5ldrUojAQMY=;
        b=bigKHAGtc/PI2erAR6CZ795mXrAxgBWwJV0I+RbzY4Cg1K8srEz7OXcvcnQcsxz8Bc
         aJ2DbVG43JrCHTrX3mkNBSB3Jko0Ubilfo/wDBsWgdSoG7LMtER1kwB4uwq6hTcftDKr
         e6ySA8jfnkAM6LCPvVI9iIenqBby6I1EFajlgrflKsv1VaZNhdGqju7xtCgFp5O1wvjR
         T4NxAFy1/vKQBQ/m6Kdtj2UVgcJY2Jx16cF6JZkzQNFEzmIuRu1Cgw4AqM2RhsIBjFmR
         lsgfjRxT1BCc1Tyi0+MzP7iklwBBBE+GtdNNvzoVtzOA0a/XQFCaw+wZFJ3Qugo4Vd2f
         ySkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726983535; x=1727588335;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Na8SvrxLN+YX4+gs7MaINxBMQEuGxhcl5ldrUojAQMY=;
        b=P1h6SOCQDtYxMi/K6qNPAtxbgWNk48k6JgVJFYXPEd3ezCdOa24C+gVxl4q4a2YGDJ
         vpiqp4weczwsVHOK8H9z9Q5ZgeaBYcgw9jLXQO6Mqd+GBgA3SerlKqd80P4dkz+5RhZV
         71tozfkLMl/0AyVO5bfOT3yKFq7NjznyGG68V6RepKTb2sACouQAywGXVw5eLxwBdsPU
         hs5WLl6lhDG1i6Ue7iQVXCyVJkKR1MNup8Zooopdw3RxBUnDU21opRlhemRxWACFP2LJ
         EjsNTy6v1383h7XyA51fbLKRtmTWG1D6ECDyOV98Q72YScNGwQyBfVayJKWYDQ9ummwx
         Cm7A==
X-Gm-Message-State: AOJu0YwSF3XkzLmBk9JsEZg9H/xB3Ci31c7DNQHeyN7eANbaN5LyJCB0
	pS0wTX3M00GL+XoSRnM8506qiFWFiehqMx6khSGx5P1MU2ySn3pj54ZVEw==
X-Google-Smtp-Source: AGHT+IHFudSMM+pxxGDbNrM0E87n2UmF6JRfw03o/CAyT77sZKSygardpNfMmg/36E0WBGdIPGumnw==
X-Received: by 2002:a05:6a00:10c7:b0:714:3831:ec91 with SMTP id d2e1a72fcca58-7199ca835fcmr10582267b3a.25.1726983534576;
        Sat, 21 Sep 2024 22:38:54 -0700 (PDT)
Received: from tokunori-desktop.flets-east.jp ([240b:10:2720:5500:bc92:a9bf:1b52:7902])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944a977aesm11996095b3a.25.2024.09.21.22.38.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Sep 2024 22:38:54 -0700 (PDT)
From: Tokunori Ikegami <ikegami.t@gmail.com>
To: linux-nvme@lists.infradead.org
Cc: Tokunori Ikegami <ikegami.t@gmail.com>
Subject: [PATCH] nvme-sysfs: add 'lbaf_index' ns attribute
Date: Sun, 22 Sep 2024 14:38:18 +0900
Message-ID: <20240922053850.5494-1-ikegami.t@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240921_223856_053408_89985ACF 
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

The lbaf_index attriute is needed for the format NVM command.
This is to reduce the identify commands to get the information.

Signed-off-by: Tokunori Ikegami <ikegami.t@gmail.com>
---
 drivers/nvme/host/core.c  | 5 +++--
 drivers/nvme/host/nvme.h  | 1 +
 drivers/nvme/host/sysfs.c | 7 +++++++
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index ca9959a8fb9e..2cc9876322e6 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1909,7 +1909,7 @@ static void nvme_configure_metadata(struct nvme_ctrl *ctrl,
 	head->features &= ~(NVME_NS_METADATA_SUPPORTED | NVME_NS_EXT_LBAS);
 	head->pi_type = 0;
 	head->pi_size = 0;
-	head->ms = le16_to_cpu(id->lbaf[nvme_lbaf_index(id->flbas)].ms);
+	head->ms = le16_to_cpu(id->lbaf[head->lbaf_index].ms);
 	if (!head->ms || !(ctrl->ops->flags & NVME_F_METADATA_SUPPORTED))
 		return;
 
@@ -2151,7 +2151,8 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 	}
 
 	blk_mq_freeze_queue(ns->disk->queue);
-	ns->head->lba_shift = id->lbaf[lbaf].ds;
+	ns->head->lbaf_index = lbaf;
+	ns->head->lba_shift = id->lbaf[ns->head->lbaf_index].ds;
 	ns->head->nuse = le64_to_cpu(id->nuse);
 	capacity = nvme_lba_to_sect(ns->head, le64_to_cpu(id->nsze));
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 313a4f978a2c..fb1d7c812135 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -483,6 +483,7 @@ struct nvme_ns_head {
 	u64			zsze;
 #endif
 	unsigned long		features;
+	u8			lbaf_index;
 
 	struct ratelimit_state	rs_nuse;
 
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index eb345551d6fe..108b6eda07dc 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -246,6 +246,12 @@ static ssize_t nuse_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RO(nuse);
 
+static ssize_t lbaf_index_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%u\n", dev_to_ns_head(dev)->lbaf_index);
+}
+static DEVICE_ATTR_RO(lbaf_index);
+
 static struct attribute *nvme_ns_attrs[] = {
 	&dev_attr_wwid.attr,
 	&dev_attr_uuid.attr,
@@ -255,6 +261,7 @@ static struct attribute *nvme_ns_attrs[] = {
 	&dev_attr_nsid.attr,
 	&dev_attr_metadata_bytes.attr,
 	&dev_attr_nuse.attr,
+	&dev_attr_lbaf_index.attr,
 #ifdef CONFIG_NVME_MULTIPATH
 	&dev_attr_ana_grpid.attr,
 	&dev_attr_ana_state.attr,
-- 
2.43.0



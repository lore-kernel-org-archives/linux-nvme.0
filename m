Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9917BCF9C5B
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Sep 2024 05:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=9Ozpbeif7dP4VToXo7VGhswfdnRnaehPzNW9nt+KS28=; b=cGis0+G8MLxQjrdc/OemJ1D3oM
	J7YvR1CAz7guKo5iYdnCAFyM42Fzscz2fJ0Kt7Jr/Mb3ajYLjYXMVvOs8uKWoQ64k6i5nNOS5brMA
	ju0dDi6mEXmm5KjhRT/K/BSYwUmDqnLvTj5b2cfFS6X8Kjx2xm3NcQd9FxvLjIRQa6mNDYzOvd+yx
	aNjYQQZsSPgk0LQ5XlVY1FYBGX9Amt2WLFYCD7BJch4m2hzGrP46xwy09hKP8OqdexwAZmjKpvjg+
	G7XIwPBkXHbufq5T58Rss68jag5dO4uyb8FaXhgPWtvYvWFepf7vWU4D6ezqevDkx1cG3Q02/8dt2
	38teQ3kg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1ssbZD-0000000GKsV-32tD;
	Mon, 23 Sep 2024 05:24:59 +0000
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1ssbZA-0000000GKrj-2qNP
	for linux-nvme@lists.infradead.org;
	Mon, 23 Sep 2024 05:24:58 +0000
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-2053a0bd0a6so38527805ad.3
        for <linux-nvme@lists.infradead.org>; Sun, 22 Sep 2024 22:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727069095; x=1727673895; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9Ozpbeif7dP4VToXo7VGhswfdnRnaehPzNW9nt+KS28=;
        b=FuRZ5RxRw+FLiJa5WvIlYPBcVWrjkwWcZswzxH8eIvgWl2vGt4pZfw6NsX3uPzLw2x
         sIaEYUwsUSM6oiJOKCUDlnSOL0HFh/wUlaeDifwyL4PXgPGUhEIZemSUtzkkeoSt1Gf9
         bCRKPXMdzheQUScYBnJgA7Uphr/VmhOFKqh2iqaau7u4yG+RwIR73ZOQlpn4R9uwi54P
         OG48r+ht9b+u+tvFeb95OAmTBJ5o+FtST3kQmkAbhu2r29eQI6wJNl0W0kPAgnN6sS8D
         X1oVAMG4ROlF05RyNiUdtn1rgBocvIFs8dzqYvcL056IFYxbQiA7VBjkb+zN9hqsI3Aw
         3c4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727069095; x=1727673895;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9Ozpbeif7dP4VToXo7VGhswfdnRnaehPzNW9nt+KS28=;
        b=vRWdf3i5mTE0YDAmqyS1xVsco4LSsWEhVXnIeaToMyFhaOatVCkknJYqkHd2XyLiuu
         3UhCBWWT3XdDGBYgbU2NfEjz3vQzMQf81NiYBkDPXnBS1SQJ2xrgHfKGxJYUDM0J0eto
         Y8PgVIIbAHU09Llmk0+S1eDKh/MtYGa22/3GFNEG/Oe0+1DK3U6mO1162AflCiVSnDvv
         R3+2DwD9SDzbvg8qXHqWZzwMKSOsOxDdBr9gK6KKz5RLlUCDcb6M/5Gghv8p6bfuAiQV
         +bLkP0eZ4bGYMUwqnL1Ro068WaK/dlGihEbMNZC5KnxMriwb8Wh1ynVPLJOZNy6vgf8m
         UU8Q==
X-Gm-Message-State: AOJu0YzvwkS6l8O6a0fF9wx2ac+UHL2Linkj8XTaZ4Ojr032Y4A9E2/1
	mbwHcUPzABEjQTkqM8NjODqb1jx9zGXNO2Xg1SsBBX1hnRELxlDj+YiqFA==
X-Google-Smtp-Source: AGHT+IFGJqqpdl22K02jpmCCkGtVjRh99eKrxRuqa9ZRkgoVJRG7oUuXZT+Aea4XO7fePB23m6ZcoA==
X-Received: by 2002:a17:902:d509:b0:205:86f5:333d with SMTP id d9443c01a7336-208d8415934mr149059465ad.55.1727069095304;
        Sun, 22 Sep 2024 22:24:55 -0700 (PDT)
Received: from tokunori-desktop.flets-east.jp ([240b:10:2720:5500:ba23:ec81:7b64:46d9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20794748053sm125748935ad.289.2024.09.22.22.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2024 22:24:54 -0700 (PDT)
From: Tokunori Ikegami <ikegami.t@gmail.com>
To: linux-nvme@lists.infradead.org
Cc: Tokunori Ikegami <ikegami.t@gmail.com>
Subject: [PATCH v2] nvme-sysfs: add 'format_***' attributes
Date: Mon, 23 Sep 2024 14:24:14 +0900
Message-ID: <20240923052445.8588-1-ikegami.t@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240922_222456_751544_966D3031 
X-CRM114-Status: GOOD (  12.23  )
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

The format_all_ns attriute is needed for the format NVM command.

Signed-off-by: Tokunori Ikegami <ikegami.t@gmail.com>
---
Changes since v1:
- Split the sysfs fna attiributes to format_*** attributes.
- Add NVME_CTRL_FNA attiributes definitions.

 drivers/nvme/host/core.c  |  1 +
 drivers/nvme/host/nvme.h  |  1 +
 drivers/nvme/host/sysfs.c | 48 +++++++++++++++++++++++++++++++++++++++
 include/linux/nvme.h      |  4 ++++
 4 files changed, 54 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 2cc9876322e6..7aa291ca7d21 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3303,6 +3303,7 @@ static int nvme_init_identify(struct nvme_ctrl *ctrl)
 	ctrl->cctemp = le16_to_cpu(id->cctemp);
 
 	atomic_set(&ctrl->abort_limit, id->acl + 1);
+	ctrl->fna = id->fna;
 	ctrl->vwc = id->vwc;
 	if (id->mdts)
 		max_hw_sectors = nvme_mps_to_sectors(ctrl, id->mdts);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index fb1d7c812135..2a3679ef1397 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -328,6 +328,7 @@ struct nvme_ctrl {
 	u16 sqsize;
 	u32 max_namespaces;
 	atomic_t abort_limit;
+	u8 fna;
 	u8 vwc;
 	u32 vs;
 	u32 sgls;
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 108b6eda07dc..499468c7cbd8 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -553,6 +553,50 @@ static ssize_t dctype_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(dctype);
 
+static ssize_t format_all_ns_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+
+	if (ctrl->fna)
+		return sysfs_emit(buf, "%d\n", !!(ctrl->fna & NVME_CTRL_FNA_ALL_NS));
+
+	return 0;
+}
+static DEVICE_ATTR_RO(format_all_ns);
+
+static ssize_t format_se_all_ns_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+
+	if (ctrl->fna)
+		return sysfs_emit(buf, "%d\n", !!(ctrl->fna & NVME_CTRL_FNA_SE_ALL_NS));
+
+	return 0;
+}
+static DEVICE_ATTR_RO(format_se_all_ns);
+
+static ssize_t format_crypto_erase_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+
+	if (ctrl->fna)
+		return sysfs_emit(buf, "%d\n", !!(ctrl->fna & NVME_CTRL_FNA_CRYPTO_ERASE));
+
+	return 0;
+}
+static DEVICE_ATTR_RO(format_crypto_erase);
+
+static ssize_t format_nsid_all_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+
+	if (ctrl->fna)
+		return sysfs_emit(buf, "%d\n", !!(ctrl->fna & NVME_CTRL_FNA_NSID_ALL));
+
+	return 0;
+}
+static DEVICE_ATTR_RO(format_nsid_all);
+
 #ifdef CONFIG_NVME_HOST_AUTH
 static ssize_t nvme_ctrl_dhchap_secret_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
@@ -694,6 +738,10 @@ static struct attribute *nvme_dev_attrs[] = {
 	&dev_attr_kato.attr,
 	&dev_attr_cntrltype.attr,
 	&dev_attr_dctype.attr,
+	&dev_attr_format_all_ns.attr,
+	&dev_attr_format_se_all_ns.attr,
+	&dev_attr_format_crypto_erase.attr,
+	&dev_attr_format_nsid_all.attr,
 #ifdef CONFIG_NVME_HOST_AUTH
 	&dev_attr_dhchap_secret.attr,
 	&dev_attr_dhchap_ctrl_secret.attr,
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index b58d9405d65e..3505454549e9 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -388,6 +388,10 @@ enum {
 	NVME_CTRL_CTRATT_PREDICTABLE_LAT	= 1 << 5,
 	NVME_CTRL_CTRATT_NAMESPACE_GRANULARITY	= 1 << 7,
 	NVME_CTRL_CTRATT_UUID_LIST		= 1 << 9,
+	NVME_CTRL_FNA_ALL_NS			= 1 << 0,
+	NVME_CTRL_FNA_SE_ALL_NS			= 1 << 1,
+	NVME_CTRL_FNA_CRYPTO_ERASE		= 1 << 2,
+	NVME_CTRL_FNA_NSID_ALL			= 1 << 3,
 };
 
 struct nvme_lbaf {
-- 
2.43.0



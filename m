Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EA4FD10373
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Nov 2025 02:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Fup6CIzZoN1mUgXTOLLZWG3yGagOqWK2m84nC1cywRc=; b=eSfYl/b9zZd56ka3jqFpMKAf5o
	zJz9xyIpe9iyYz3FsmycNOM0p458SFiyukAC1Or3tq/ovySLd64A+27FkadMStLDJuMCZZun3chvf
	EPun4IVHyA/KSaq7c7CM8Esaxr5jNtoeb2a3EVP1SN2fzGi5EZlmy52sI/P/A45zkPy6f/8the80t
	QLv1/EScg0r6ghbDlcd0r5BE7rpWP0Gjro7Z6yniDZUTiRHUO9bgeagp00h9LbzyaU4NdVSP8jfVD
	U4Tp/bcqlgfwBTOelThjm0RWkXBcZyTzuqEbBJdRuCWW/eWmMx0agr7BQwXjl2g+063/lwrxU1AlF
	T+ecGEHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vO52D-0000000EDSS-2dmz;
	Wed, 26 Nov 2025 02:13:33 +0000
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vO527-0000000EDN6-3Esb
	for linux-nvme@lists.infradead.org;
	Wed, 26 Nov 2025 02:13:28 +0000
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-298456bb53aso77637675ad.0
        for <linux-nvme@lists.infradead.org>; Tue, 25 Nov 2025 18:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1764123207; x=1764728007; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fup6CIzZoN1mUgXTOLLZWG3yGagOqWK2m84nC1cywRc=;
        b=ggd3GbPO9w/tBTf5YIqhFNgL72MeTKLJGhpY+7F6TLQmjziriCnoQiK0JvKzbf5LKX
         /DRRnYQqsZjRkWqROQkza3Pm8lIDeh3cWRmoG6Tk0CxxdN+pLQLrLxCV+bDcpXtdpa36
         QNRs0kz2n+BFY0DAvJ83zC+Utw0KHYZYmgmAHBg6dshhkT8eVKvpjyCDacM/BeZ0MotL
         QdOtqR6MNKD26AEP+7utspFGHVt5eNQqyiJBGkTtv4io0Hk8YXR+GRJo/tWjwSnvIPZf
         BO0yBc2H3fIGWj+tFNQG6YG8a273wytecVYZwXDtmFmTlludWafNsnwm82mYM+Z49Jfd
         KMAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764123207; x=1764728007;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Fup6CIzZoN1mUgXTOLLZWG3yGagOqWK2m84nC1cywRc=;
        b=A7gUyIsdjrMrx5K91r/e/HlnyAlzSLrhvp6884FPq9Zguz3m9ORABs7F3XreahK3jA
         Qj5OWnA3bltwP4173PTdG7l4fUZ1zOMJNKp/R6HsCmBOffsW9aPuFydTBYu7pVRtA/3Y
         bZwaPn9y8lgFZ9DMQ1Xda+Ifza4+wJI2Y5Lhb1YtyuBOPDOoADghCu7ChNd+e5TlND+C
         LWF2UJ+mBpCXdi2BlNlrrkKGOxnwDdSmDZVl8fv/tvfYc8m+L8dP6q5KNePav/OjmnvV
         82SReIMxRRuSGLcrfG9X4hkXY6T5wXMuPt2MjaiwW08dbswt7LGG1TD/rQbIbQ+4cTAi
         ZyJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCFqbvtUJQA3ne21ky3t46dBajVKILDZQVSa0MtbNwMhyTvIvMz0vBBPvEPGDW/D86Q8PJ2QgtYzzk@lists.infradead.org
X-Gm-Message-State: AOJu0YyKXmzpZmAgRNETLCri+Q4BErsLRWwEx4+GJMhPhyIb0+tbrx5X
	MA8epcLzfhOyzxWJ79/oMRFPYc3k/Ak86/ubxaPNFFKKruMF/u6EsvSucgCF3MDWMQI=
X-Gm-Gg: ASbGnct9705rPWdKkRx3eBWJTw/atYBJwSBD4jX6ZoQcOxF6EboYwKU0W81RAeTtk37
	bbj663c2Qii8p1Ku9xfdRgQ8qpVbuy3Rycx5pjQud8Qt+BqGGIYSNxNd6PpKUxXljSzeGHbhUSX
	oAbXMsoECAxok3d2jBDS9R5rUllBaxcSMR/rbvEAkGHpgYuW47VZB+lsdVz9f9Fv6Fsc/WdRg19
	rHArTtc045GPt6B/vR29RxzN+fqQUYvq0MQyHugn5QDvxRW5zMukq8Z9RtwbaT6hPRXpkcnfDFz
	1OjpVOgWyRLhPBxRQJzVAUiXpq9PlMucoF3YIsQ6Ahv0vmDM8woPKScGwzbesuZWO2UcZvMtyTj
	UKuPZPljRYn/iU1bPR0KvKH38HHhQ8WHzCgTTibmtf1YjVwA7pfbFPgZrUVpeSLwh/laZZw2byy
	WR52qN0azoILybVHm6/Dg5chMO1mon6GgbFg==
X-Google-Smtp-Source: AGHT+IEGtCJVxQEDpFf3Jd3BrTA4e27R/LfD8qTutalpA0yqSHCpemiGQYzP9RyUO13yMxhultiV+Q==
X-Received: by 2002:a05:7022:670f:b0:11a:4016:4491 with SMTP id a92af1059eb24-11c9d84c6f8mr12170250c88.24.1764123206595;
        Tue, 25 Nov 2025 18:13:26 -0800 (PST)
Received: from apollo.purestorage.com ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-11cc631c236sm17922979c88.7.2025.11.25.18.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 18:13:26 -0800 (PST)
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Chaitanya Kulkarni <kch@nvidia.com>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Aaron Dailey <adailey@purestorage.com>,
	Randy Jennings <randyj@purestorage.com>,
	John Meneghini <jmeneghi@redhat.com>,
	Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Mohamed Khalfella <mkhalfella@purestorage.com>
Subject: [RFC PATCH 06/14] nvme: Rapid Path Failure Recovery read controller identify fields
Date: Tue, 25 Nov 2025 18:11:53 -0800
Message-ID: <20251126021250.2583630-7-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251126021250.2583630-1-mkhalfella@purestorage.com>
References: <20251126021250.2583630-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251125_181327_810929_E0C690E9 
X-CRM114-Status: GOOD (  13.88  )
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

TP2028 Rapid path failure added new fileds to controller identify
response. Read CIU (Controller Instance Uniquifier), CIRN (Controller
Instance Random Number), and CCRL (Cross-Controller Reset Limit) from
controller identify response. Expose CIU and CIRN as sysfs attributes
so the values can be used directrly by user if needed.

TP4129 KATO Corrections and Clarifications defined CQT (Command Quiesce
Time) which is used along with KATO (Keep Alive Timeout) to set an upper
limite for attempting Cross-Controller Recovery.

Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
---
 drivers/nvme/host/core.c  |  5 +++++
 drivers/nvme/host/nvme.h  | 11 +++++++++++
 drivers/nvme/host/sysfs.c | 23 +++++++++++++++++++++++
 3 files changed, 39 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index fa4181d7de73..aa007a7b9606 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3572,12 +3572,17 @@ static int nvme_init_identify(struct nvme_ctrl *ctrl)
 	ctrl->crdt[1] = le16_to_cpu(id->crdt2);
 	ctrl->crdt[2] = le16_to_cpu(id->crdt3);
 
+	ctrl->ciu = id->ciu;
+	ctrl->cirn = le64_to_cpu(id->cirn);
+	atomic_set(&ctrl->ccr_limit, id->ccrl);
+
 	ctrl->oacs = le16_to_cpu(id->oacs);
 	ctrl->oncs = le16_to_cpu(id->oncs);
 	ctrl->mtfa = le16_to_cpu(id->mtfa);
 	ctrl->oaes = le32_to_cpu(id->oaes);
 	ctrl->wctemp = le16_to_cpu(id->wctemp);
 	ctrl->cctemp = le16_to_cpu(id->cctemp);
+	ctrl->cqt = le16_to_cpu(id->cqt);
 
 	atomic_set(&ctrl->abort_limit, id->acl + 1);
 	ctrl->vwc = id->vwc;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 102fae6a231c..5195a9abfadf 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -326,13 +326,17 @@ struct nvme_ctrl {
 	u32 max_zone_append;
 #endif
 	u16 crdt[3];
+	u16 cqt;
 	u16 oncs;
 	u8 dmrl;
+	u8 ciu;
 	u32 dmrsl;
+	u64 cirn;
 	u16 oacs;
 	u16 sqsize;
 	u32 max_namespaces;
 	atomic_t abort_limit;
+	atomic_t ccr_limit;
 	u8 vwc;
 	u32 vs;
 	u32 sgls;
@@ -1218,4 +1222,11 @@ static inline bool nvme_multi_css(struct nvme_ctrl *ctrl)
 	return (ctrl->ctrl_config & NVME_CC_CSS_MASK) == NVME_CC_CSS_CSI;
 }
 
+static inline unsigned long nvme_recovery_timeout_ms(struct nvme_ctrl *ctrl)
+{
+	if (ctrl->ctratt & NVME_CTRL_ATTR_TBKAS)
+		return 3 * ctrl->kato * 1000 + ctrl->cqt;
+	return 2 * ctrl->kato * 1000 + ctrl->cqt;
+}
+
 #endif /* _NVME_H */
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 29430949ce2f..ae36249ad61e 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -388,6 +388,27 @@ nvme_show_int_function(queue_count);
 nvme_show_int_function(sqsize);
 nvme_show_int_function(kato);
 
+static ssize_t nvme_sysfs_uniquifier_show(struct device *dev,
+					  struct device_attribute *attr,
+					  char *buf)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%02x\n", ctrl->ciu);
+}
+static DEVICE_ATTR(uniquifier, S_IRUGO, nvme_sysfs_uniquifier_show, NULL);
+
+static ssize_t nvme_sysfs_random_show(struct device *dev,
+					  struct device_attribute *attr,
+					  char *buf)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%016llx\n", ctrl->cirn);
+}
+static DEVICE_ATTR(random, S_IRUGO, nvme_sysfs_random_show, NULL);
+
+
 static ssize_t nvme_sysfs_delete(struct device *dev,
 				struct device_attribute *attr, const char *buf,
 				size_t count)
@@ -734,6 +755,8 @@ static struct attribute *nvme_dev_attrs[] = {
 	&dev_attr_numa_node.attr,
 	&dev_attr_queue_count.attr,
 	&dev_attr_sqsize.attr,
+	&dev_attr_uniquifier.attr,
+	&dev_attr_random.attr,
 	&dev_attr_hostnqn.attr,
 	&dev_attr_hostid.attr,
 	&dev_attr_ctrl_loss_tmo.attr,
-- 
2.51.2



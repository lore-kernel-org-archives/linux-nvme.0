Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5F78D49C97
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Jan 2026 22:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3tS4KzqYbhEL6jev7Qh8Wf78xstwgPnfDr7XEbpNCcA=; b=TQdnrBI8qtKo9UnA1cllbeMna/
	xe/McKcKJV1SBrWRpkfvR6JRxo6krS9SFrZ2Fqp2b3nSBkykXc7wnhR+62Y/Qr5jcxhqcz6DIMaj/
	Vp//5ZLZE2DNwS8aRmLVqjUx6RA7ZaZ6GgOb93w405ddmaSwEij1ZQUPvE0E0WtO+fTO136RpBrNo
	DMbh2ss1xgErAebpYFQvfotBJxcxrKgYj9cM9vUpVg3cbQjHcuuIDatML7NqT7WCZ5T1Qvj7GL7eM
	ehm5ciQj49GJDJRDoMIXONHQf45D6qDqUChegwFQjH5XS7x5BGg8d1OmNfkhwPL8IjWDdgKCY1Zyv
	KoNVEwJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlx6O-000000022ms-3it7;
	Fri, 30 Jan 2026 22:36:32 +0000
Received: from mail-dl1-x1236.google.com ([2607:f8b0:4864:20::1236])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlx6M-000000022jD-0fej
	for linux-nvme@lists.infradead.org;
	Fri, 30 Jan 2026 22:36:31 +0000
Received: by mail-dl1-x1236.google.com with SMTP id a92af1059eb24-1248d27f2b9so3741630c88.0
        for <linux-nvme@lists.infradead.org>; Fri, 30 Jan 2026 14:36:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1769812589; x=1770417389; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3tS4KzqYbhEL6jev7Qh8Wf78xstwgPnfDr7XEbpNCcA=;
        b=GVmfGltmu8zqTLX55D55kesSM04cMBoDcgsnkNB5GM9i3uqzilQ/9ceU+tD6Q0DaDv
         dWP5lLVtJbP8fFiHSQOVoIo6enW7yMuKrHbdvLdRu8l9QZxMcLdCETGlCp9qSD125MH+
         WMoW8K4ccoKExaBoF4nAZgGeHC7GwPMO0nCgiT9R7ic6BHMCeCBXWWmqytEY8IUgnDP1
         LJ2EJcFsV8EGR1zwwlqLxBqdXTosc6t9szyA7TSrJkmdkbC5xJ5SgZ7RD6U66U9nSR8e
         Vf61ZNNSY4eEsF2Ti/B6EQqB4knsInxgdkPTRFWe1ulsG+6CyDuwG6LV33aOcEGLNflc
         QU5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769812589; x=1770417389;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3tS4KzqYbhEL6jev7Qh8Wf78xstwgPnfDr7XEbpNCcA=;
        b=oJ7qZpEyQSan8FKiu7Bjf89ThowSWnG2jW5HhYM9T0MucdKFeMQ8qo6qV0q4dE51P+
         A07HJAvj/htInTkMpJXM4zo5bF2RZQwujZy7MlY6vF8g0gza9/t8zNjvdEpJXIgRMfv9
         Yn9+4G/z61paoE1h3Nw6UHStXwjxBa/cR8YEVn2SfuJt6ZUNyZVvmDI0MCo6t1VwzuAl
         zou5owEzU0c1CO3XeLQ8aTZ+O2S29g/txqWpugXOYSIx6n1nhBG1HJgG5v4LLDp9fXsf
         6WaARAdNxmzeD7Haz1ZNYCN6jB6GfnPzDIQ3zW4Xp3GsZfXdt6JH9lqPXVX6/LTc1zAo
         Ncuw==
X-Forwarded-Encrypted: i=1; AJvYcCVUVMEJ+/ZDkO7bD2XcuDHA0C74i+cQ2AwDoLsALQL89NPwJl6VqvD3g9bTeg88GTIAm86TWy3TStsz@lists.infradead.org
X-Gm-Message-State: AOJu0YzOccwkLmDz9KK9QF1RKloldTWPY7XNuQK6tAfHaQckPRQWMmWc
	w/wIw7oXx6b+hu2+shrnyonERJpfDhLUyKWHed/cjBRy5431n12GsXkrE5ZqOAhzJ1Q=
X-Gm-Gg: AZuq6aL9bAWOV5FmSROVNl+KIOL/uHwQ03HNU/0fTmH3nCsaW1XJg3r5dVGWdIz2iXt
	9uTiw3rTdilITKfAIKcesFwUfdv+KR1IgXSe4JCZbH8tWrOH3mpUBZXCmj5L2dCz/wyzJO19I2r
	OmWNcXAtHT16KvEtRpuWWuCEuVh1xMARG58wEsoPYlC2O2dnC6L3tpSSTP8XdEp4JYp+CQsZRSp
	Yk9SW2cuXt/Gg30CSXefEEdcm6cFpTDf5C5vOwHQf1nt3SNTWBpqVcosM8kuLztZmiBz9Kr/o8I
	RTpV/e9rSVfL9vJ7RgdwVmdwGdZT+ShYrn3xH48Sq+Uyi5qpgP1EVCk+4VszdIaXAac6RNwDVes
	35JV2b5knoIBi1wdYl4jcRqhpvkC9uragSE2ulhEYIOt1LFnyku2oyamNcU2eCpY9lcj49sB15Z
	2T9pOYTwOABs1tZ0FQ8RVoj7ODULA9Nk1xqw==
X-Received: by 2002:a05:7022:e98d:b0:11e:65b5:75ce with SMTP id a92af1059eb24-125c0f9ab5fmr1931557c88.10.1769812589406;
        Fri, 30 Jan 2026 14:36:29 -0800 (PST)
Received: from apollo.purestorage.com ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-124a9d6b906sm13161717c88.4.2026.01.30.14.36.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 14:36:29 -0800 (PST)
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Aaron Dailey <adailey@purestorage.com>,
	Randy Jennings <randyj@purestorage.com>,
	Dhaval Giani <dgiani@purestorage.com>,
	Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Mohamed Khalfella <mkhalfella@purestorage.com>
Subject: [PATCH v2 06/14] nvme: Rapid Path Failure Recovery read controller identify fields
Date: Fri, 30 Jan 2026 14:34:10 -0800
Message-ID: <20260130223531.2478849-7-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260130223531.2478849-1-mkhalfella@purestorage.com>
References: <20260130223531.2478849-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260130_143630_203266_06442938 
X-CRM114-Status: GOOD (  13.27  )
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

TP8028 Rapid path failure added new fileds to controller identify
response. Read CIU (Controller Instance Uniquifier), CIRN (Controller
Instance Random Number), and CCRL (Cross-Controller Reset Limit) from
controller identify response. Expose CIU and CIRN as sysfs attributes
so the values can be used directrly by user if needed.

TP4129 KATO Corrections and Clarifications defined CQT (Command Quiesce
Time) which is used along with KATO (Keep Alive Timeout) to set an upper
limit for attempting Cross-Controller Recovery.

Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
---
 drivers/nvme/host/core.c  |  5 +++++
 drivers/nvme/host/nvme.h  | 11 +++++++++++
 drivers/nvme/host/sysfs.c | 23 +++++++++++++++++++++++
 3 files changed, 39 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 7bf228df6001..8961d612ccb0 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3571,6 +3571,11 @@ static int nvme_init_identify(struct nvme_ctrl *ctrl)
 	ctrl->crdt[1] = le16_to_cpu(id->crdt2);
 	ctrl->crdt[2] = le16_to_cpu(id->crdt3);
 
+	ctrl->ciu = id->ciu;
+	ctrl->cirn = le64_to_cpu(id->cirn);
+	atomic_set(&ctrl->ccr_limit, id->ccrl);
+	ctrl->cqt = le16_to_cpu(id->cqt);
+
 	ctrl->oacs = le16_to_cpu(id->oacs);
 	ctrl->oncs = le16_to_cpu(id->oncs);
 	ctrl->mtfa = le16_to_cpu(id->mtfa);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 9a5f28c5103c..9dd9f179ad88 100644
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
@@ -1225,4 +1229,11 @@ static inline bool nvme_multi_css(struct nvme_ctrl *ctrl)
 	return (ctrl->ctrl_config & NVME_CC_CSS_MASK) == NVME_CC_CSS_CSI;
 }
 
+static inline unsigned long nvme_fence_timeout_ms(struct nvme_ctrl *ctrl)
+{
+	if (ctrl->ctratt & NVME_CTRL_ATTR_TBKAS)
+		return 3 * ctrl->kato * 1000 + ctrl->cqt;
+	return 2 * ctrl->kato * 1000 + ctrl->cqt;
+}
+
 #endif /* _NVME_H */
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 29430949ce2f..f81bbb6ec768 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -388,6 +388,27 @@ nvme_show_int_function(queue_count);
 nvme_show_int_function(sqsize);
 nvme_show_int_function(kato);
 
+static ssize_t nvme_sysfs_ciu_show(struct device *dev,
+					  struct device_attribute *attr,
+					  char *buf)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%02x\n", ctrl->ciu);
+}
+static DEVICE_ATTR(ciu, S_IRUGO, nvme_sysfs_ciu_show, NULL);
+
+static ssize_t nvme_sysfs_cirn_show(struct device *dev,
+					  struct device_attribute *attr,
+					  char *buf)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%016llx\n", ctrl->cirn);
+}
+static DEVICE_ATTR(cirn, S_IRUGO, nvme_sysfs_cirn_show, NULL);
+
+
 static ssize_t nvme_sysfs_delete(struct device *dev,
 				struct device_attribute *attr, const char *buf,
 				size_t count)
@@ -734,6 +755,8 @@ static struct attribute *nvme_dev_attrs[] = {
 	&dev_attr_numa_node.attr,
 	&dev_attr_queue_count.attr,
 	&dev_attr_sqsize.attr,
+	&dev_attr_ciu.attr,
+	&dev_attr_cirn.attr,
 	&dev_attr_hostnqn.attr,
 	&dev_attr_hostid.attr,
 	&dev_attr_ctrl_loss_tmo.attr,
-- 
2.52.0



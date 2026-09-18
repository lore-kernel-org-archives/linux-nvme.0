Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52525C982D8
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Sep 2026 18:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+9AGoVe097CFQTljKQVnFARTDua53EnwrZ8dQWbEJDU=; b=OTfeTgoJHfVZd5+3JK3JSusKKD
	Ffq3aRqLHF4MzmhtZ3NMQ/pHuYzUqz+LZj0txG0A/9jL7B8sgf9ZBeWGxAIK9g5elpc4Aadekj4Ut
	eb5DahXdrQ38kuz6jxQvc3yTWo9DoFCoPpeb6FfwfCnWHsHiANoyY933oFCm1IQxxJGewi6Q8CkWu
	SEQhcUtcPyLKkOVUwnMjpKGM+FtqIoA357T8/XctjhYjF9XmhZ5/sw4/LfekeALprq6HGU6N1IONw
	TbZmUqVYdvNgVbVISEF9MeIr0w+1CDRj0+X3dAWSF3pvJbEYD+nEROxQmOtAMqtZ+ZGRL7AHyOiMw
	SMbogg0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7d93-0000000FH3g-2xLA;
	Fri, 18 Sep 2026 18:17:09 +0000
Received: from mail-pj2-x0f.google.com ([2607:f8b0:4864:39::f])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7d90-0000000FH0A-44Zj
	for linux-nvme@lists.infradead.org;
	Fri, 18 Sep 2026 18:17:08 +0000
Received: by mail-pj2-x0f.google.com with SMTP id 98e67ed59e1d1-396ccd4f99cso1158091a91.0
        for <linux-nvme@lists.infradead.org>; Fri, 18 Sep 2026 11:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1789755426; x=1790360226; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+9AGoVe097CFQTljKQVnFARTDua53EnwrZ8dQWbEJDU=;
        b=XtkpTMlmpWOyrVqH5x6kYM0A/HkajRcRgsr8Dmk02EOAdoB8403KSr8a697zqN5dEb
         xRZH9yZw3TOqFmOH/nC1QIT0ywhDvJCOW0rduAbTJDSCeG/NcsL7/cYMniePrAcr5zY5
         M4yMNikvVSLFF5PWPKwNIj1i2gn9ZPyn0q1J8/T1LGYp083C9KVuiHS/2FxIe2J7xd+Y
         bSg4UAsp9/pxIxjWMAxg74Ou6ZdcziVmQD8kZkEl5r+kqh0XpJaORmEN60ykHhXGOvHd
         TnziD4rgDQidmtoqrORzzgeLBytRedMcAD3FrF8d7lgAPzEYOPu4UsmSbW0XJRe20Fn+
         KfUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789755426; x=1790360226;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+9AGoVe097CFQTljKQVnFARTDua53EnwrZ8dQWbEJDU=;
        b=folRqEi53X1r+7AezSASg9Q+RRKixeF8COZ77lYpdPfPhR58mXC6rqoOAd/HBVaXkH
         PW2srIeVaYABsY+KqZ7t4BM0v8WW9Do0ChLOuGVZm/Jz8TDp7ILt3STQkn3cQgxmcgJr
         pWyViKv9ZlaAtW1NCMpPAQVdOQKHhormuvBPcFG2HM++3NWW2ug7FwPLtTtQ9pDwz9/W
         s7bJNLwcIkTsmANTaCLJTwaZbiowe/+xEawhkAz5UtamUFEDrH8Dd2rZRa5how8mTnbw
         vm7M2IaXHyCexiSKuaBCBcx++8FK+fAn3g5x75y9DVDdSw+B1LruLso+nDUTVFxaLJzB
         4sog==
X-Forwarded-Encrypted: i=1; AKwUvBxhSe5q20n0/bN+h8TctFlc1DtpbmtjCYNw6gwGZArKBfI0hfVDcpCu/Hoe4LVD22uqo1XXj70/1N9J@lists.infradead.org
X-Gm-Message-State: AFuF++kk+ppkFkEA/4+v1VC0BGu+mVoDlN/twz3XC+baX3EOpay9uNM9
	DELC4tbgxtaPPbxq2qHBWCJ/MP++cxSANk0V998NdynBBvar2UILVdkojLj4BUIeoZ8=
X-Gm-Gg: AYBFou1B78BsZRHuwyLScQRb29YMbgQ3qe5kjjRunsUo+ONWh68IZ9XkyJr1q4M+YhS
	2TrToyTZYRvphqL3CT5r2nKcOhN0/DkFK0Buv+bogQrspDqxq02JCXlLEdiuyMUJeqy7zb7npK+
	kizs4n5yLwPRCt3IdE4vaSH0k0FyLNwsPSPWweCgo56FBjCgUM+NbNvfeCbcKYeozU/3JvD9t/b
	Yw3BaCQL2JGXdI0mzydH0PMLF8vmgZcbOqaCqdKQLArtiiHJ+EZINH3BVQvBmKpn6J4nbQSumsH
	/ern+aBzpt7DaUExR+O8932ZRofqGnip2Co8/Vr1SQR/3ysDhrn/47vr2Eg98mM4QnfCTSa7erG
	DatdMICKB3/a3mzZpiWAM2qIMGPPnUr4EAW1AeGZzk4LsqnSGR4dDp1/fmWOd63gw0iuCrCoLtg
	PEqQuJs07Qu+ynwOKtuhWGkYH4WLKZ+1kCkBMkk1Iebf3Dwl8OaUW36/Zkh/Rg6+1jGR3bCdrmr
	++pBVCrzFmuM0EBMAnm4IBr9kggyiH9
X-Received: by 2002:a17:90b:4c03:b0:39e:6c69:9b90 with SMTP id 98e67ed59e1d1-39e6c69b206mr680725a91.53.1789755426270;
        Fri, 18 Sep 2026 11:17:06 -0700 (PDT)
Received: from apollo.purestorage.com ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-33c331aeeddsm335107eec.24.2026.09.18.11.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 11:17:05 -0700 (PDT)
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Hannes Reinecke <hare@kernel.org>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	James Smart <jsmart833426@gmail.com>,
	Randy Jennings <randyj@purestorage.com>,
	Mohamed Khalfella <mkhalfella@purestorage.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 06/18] nvme: Rapid Path Failure Recovery read controller identify fields
Date: Fri, 18 Sep 2026 11:14:06 -0700
Message-ID: <20260918181614.3947933-7-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260918181614.3947933-1-mkhalfella@purestorage.com>
References: <20260918181614.3947933-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260918_111707_018399_ADA0451A 
X-CRM114-Status: GOOD (  13.76  )
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

TP8028 Rapid Path Failure added new fields to controller identify
response. Read CIU (Controller Instance Uniquifier), CIRN (Controller
Instance Random Number), and CCRL (Cross-Controller Reset Limit) from
controller identify response. Expose CIU and CIRN as sysfs attributes
so the values can be used directly by user if needed.

Also add the nvme_fence_timeout_ms() helper that derives a fencing
timeout from the controller keep-alive timeout (kato).

Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/core.c  |  4 ++++
 drivers/nvme/host/nvme.h  | 10 ++++++++++
 drivers/nvme/host/sysfs.c | 23 +++++++++++++++++++++++
 3 files changed, 37 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 758245c799a1..ae7c04b77a3e 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3666,6 +3666,10 @@ static int nvme_init_identify(struct nvme_ctrl *ctrl)
 	ctrl->crdt[1] = le16_to_cpu(id->crdt2);
 	ctrl->crdt[2] = le16_to_cpu(id->crdt3);
 
+	ctrl->ciu = id->ciu;
+	ctrl->cirn = le64_to_cpu(id->cirn);
+	ctrl->ccrl = id->ccrl;
+
 	ctrl->oacs = le16_to_cpu(id->oacs);
 	ctrl->oncs = le16_to_cpu(id->oncs);
 	ctrl->mtfa = le16_to_cpu(id->mtfa);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 2cff9fcbf740..cb9d7f45188f 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -393,11 +393,14 @@ struct nvme_ctrl {
 	u16 crdt[3];
 	u16 oncs;
 	u8 dmrl;
+	u8 ciu;
 	u32 dmrsl;
+	u64 cirn;
 	u16 oacs;
 	u16 sqsize;
 	u32 max_namespaces;
 	atomic_t abort_limit;
+	u8 ccrl;
 	u8 vwc;
 	u32 vs;
 	u32 sgls;
@@ -1339,4 +1342,11 @@ static inline bool nvme_multi_css(struct nvme_ctrl *ctrl)
 	return (ctrl->ctrl_config & NVME_CC_CSS_MASK) == NVME_CC_CSS_CSI;
 }
 
+static inline unsigned long nvme_fence_timeout_ms(struct nvme_ctrl *ctrl)
+{
+	if (ctrl->ctratt & NVME_CTRL_ATTR_TBKAS)
+		return 3 * ctrl->kato * 1000;
+	return 2 * ctrl->kato * 1000;
+}
+
 #endif /* _NVME_H */
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 02a2490a9ed7..b60f5b66a1d1 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -487,6 +487,27 @@ nvme_show_int_function(queue_count);
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
+static DEVICE_ATTR(ciu, S_IRUSR, nvme_sysfs_ciu_show, NULL);
+
+static ssize_t nvme_sysfs_cirn_show(struct device *dev,
+					  struct device_attribute *attr,
+					  char *buf)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%016llx\n", ctrl->cirn);
+}
+static DEVICE_ATTR(cirn, S_IRUSR, nvme_sysfs_cirn_show, NULL);
+
+
 static ssize_t nvme_sysfs_delete(struct device *dev,
 				struct device_attribute *attr, const char *buf,
 				size_t count)
@@ -941,6 +962,8 @@ static struct attribute *nvme_dev_attrs[] = {
 	&dev_attr_numa_node.attr,
 	&dev_attr_queue_count.attr,
 	&dev_attr_sqsize.attr,
+	&dev_attr_ciu.attr,
+	&dev_attr_cirn.attr,
 	&dev_attr_hostnqn.attr,
 	&dev_attr_hostid.attr,
 	&dev_attr_ctrl_loss_tmo.attr,
-- 
2.55.0



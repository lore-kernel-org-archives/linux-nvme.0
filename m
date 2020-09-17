Return-Path: <SRS0=U7CH=C2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10AE7C43461
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Sep 2020 01:11:31 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4741206DB
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Sep 2020 01:11:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="b4lgLgrV";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Tzraydye"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4741206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=w1scUqItgh9lRsSMKhG5g/Vxg0+Qv4d/ggD7eA+S5zA=; b=b4lgLgrVtiY6CbVa0BxBjioLM
	27P37mMLRLiiM13oWqCzerwBopQDuy+lmfGiQ6kwuwMhKcqW5ah2w/R9pRaXGR9TbONKL3b4TMVFh
	YTNLCafgfa34qZevDrPMeFk+QOPwIYzJHdiJJV0hsCE4Sn02vGTymt7zeCVjWAJm2C5nrOFnrN5Gr
	sJS8hJFxIxn6eA/qgkyQHI+VVKod2NSfk1YzX88pO564d6ILxzjLfinKO3KSSwrhzy1rAOVBnIXc7
	B3i+UCzJGdAEN0Ruxb7gmOlV4q878K0fC9Y/Gtb3PkywVRER6rdLceFboJI+W5AezcPj2LLrSLV/n
	KVUajr16Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kIiSO-00075y-Ki; Thu, 17 Sep 2020 01:11:28 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kIiSM-00075F-PA
 for linux-nvme@lists.infradead.org; Thu, 17 Sep 2020 01:11:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1600305086; x=1631841086;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=btkT2zD0BPlvxFEj/5vfeia3e6Ys4d7v9WrmAED1LKg=;
 b=Tzraydye8H6iOQTMCRXM/I2OGsJGiaHcn6iCyRgv+6FywhvG4Cp1krNo
 WlTyA849labEJsctdGJpcJVV0UMj/xUWASoupYX6NrbvbmzRqB19PZZXf
 JuuU8PrvOwgOirKaVwinsu+F1K6ckDSuUDvA6beaqHuAtURtgXMvMS2Qh
 AYBX0eqAPeakyCaYHoMDLMK/yibb+XFf44FcGbwLIWMJFImbztbEj9BhV
 O3q6O5gJ1N9WlwbU8iH7RrvhsIShFArqvaLNknMiKdXTAIXadi3JdxitT
 ZtKznXpqINrjIFd1U7x2URbzW786dYoaArPp81fbU1i2KqCfVT9LW2kHK g==;
IronPort-SDR: JE5fP+63cEztkrdYhXz7EdXaIaOLupeeEqO3Gy5Amf6iG75cpQgKw3rAdYVZJzZVT0y830nC1t
 Egu1xjkGMG7SjJ1gC8+TZ9oDRN0FJzIE6idc2V2QpwLCfQ0hzva8R5PNTCB6xqDcOtHgVMUr2M
 Q678pNl3nhj6WFAf5ZOwnQb9oBzxPAwNht4eCQMZztPt2xy0VI0hT6URORdCxX9RUmVPIqFugz
 b6PaHwYOnCgz/nLM4ldWl3MdXy4q1vZS6OyPb2lBwcUWcJrFYQKaTl3YGL099Ti6F3JpmEmj6H
 nc4=
X-IronPort-AV: E=Sophos;i="5.76,434,1592841600"; d="scan'208";a="147499859"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 17 Sep 2020 09:11:25 +0800
IronPort-SDR: fmNbOSrubjmtpB5h6ZaR2Gh0e3OJL9EQ00BoILBLX7uozyjSLwb6nGXOA/shPDQC+YE1eoF1gb
 Lg5RIo+YYgbQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2020 17:58:34 -0700
IronPort-SDR: vTl4RYcLeq+B0vzfEFRUMHrM7yKPXT0NERafBr3jvdYzzFeeaU3cbGa6pVnL9OwJ6eDBIdKuaa
 bnOfgDXFkyog==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 16 Sep 2020 18:11:26 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V3 3/3] nvme: lift file open code from nvme_ctrl_get_by_path
Date: Wed, 16 Sep 2020 18:11:02 -0700
Message-Id: <20200917011102.14819-4-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20200917011102.14819-1-chaitanya.kulkarni@wdc.com>
References: <20200917011102.14819-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200916_211126_977187_9E428280 
X-CRM114-Status: GOOD (  17.12  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: logang@deltatee.com, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Lift opening the file open/close code from nvme_ctrl_get_by_path into
the caller, just keeping a simple nvme_ctrl_from_file() helper.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
[hch: refactored a bit, split the bug fixes into a separate prep patch]
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/nvme/host/core.c       | 25 +++++--------------------
 drivers/nvme/host/nvme.h       |  2 +-
 drivers/nvme/target/passthru.c | 27 ++++++++++++++++-----------
 3 files changed, 22 insertions(+), 32 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c013eb52fdc8..9beb9c94eeef 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4651,28 +4651,13 @@ void nvme_sync_queues(struct nvme_ctrl *ctrl)
 }
 EXPORT_SYMBOL_GPL(nvme_sync_queues);
 
-struct nvme_ctrl *nvme_ctrl_get_by_path(const char *path)
+struct nvme_ctrl *nvme_ctrl_from_file(struct file *file)
 {
-	struct nvme_ctrl *ctrl;
-	struct file *f;
-
-	f = filp_open(path, O_RDWR, 0);
-	if (IS_ERR(f))
-		return ERR_CAST(f);
-
-	if (f->f_op != &nvme_dev_fops) {
-		ctrl = ERR_PTR(-EINVAL);
-		goto out_close;
-	}
-
-	ctrl = f->private_data;
-	nvme_get_ctrl(ctrl);
-
-out_close:
-	filp_close(f, NULL);
-	return ctrl;
+	if (file->f_op != &nvme_dev_fops)
+		return NULL;
+	return file->private_data;
 }
-EXPORT_SYMBOL_NS_GPL(nvme_ctrl_get_by_path, NVME_TARGET_PASSTHRU);
+EXPORT_SYMBOL_NS_GPL(nvme_ctrl_from_file, NVME_TARGET_PASSTHRU);
 
 /*
  * Check we didn't inadvertently grow the command structure sizes:
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 9fd45ff656da..1e6aaa710262 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -835,7 +835,7 @@ static inline void nvme_hwmon_init(struct nvme_ctrl *ctrl) { }
 u32 nvme_command_effects(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 			 u8 opcode);
 void nvme_execute_passthru_rq(struct request *rq);
-struct nvme_ctrl *nvme_ctrl_get_by_path(const char *path);
+struct nvme_ctrl *nvme_ctrl_from_file(struct file *file);
 struct nvme_ns *nvme_find_get_ns(struct nvme_ctrl *ctrl, unsigned nsid);
 void nvme_put_ns(struct nvme_ns *ns);
 
diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index dacfa7435d0b..e3a5f8499a0b 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -474,6 +474,7 @@ u16 nvmet_parse_passthru_admin_cmd(struct nvmet_req *req)
 int nvmet_passthru_ctrl_enable(struct nvmet_subsys *subsys)
 {
 	struct nvme_ctrl *ctrl;
+	struct file *file;
 	int ret = -EINVAL;
 	void *old;
 
@@ -488,24 +489,29 @@ int nvmet_passthru_ctrl_enable(struct nvmet_subsys *subsys)
 		goto out_unlock;
 	}
 
-	ctrl = nvme_ctrl_get_by_path(subsys->passthru_ctrl_path);
-	if (IS_ERR(ctrl)) {
-		ret = PTR_ERR(ctrl);
+	file = filp_open(subsys->passthru_ctrl_path, O_RDWR, 0);
+	if (IS_ERR(file)) {
+		ret = PTR_ERR(file);
+		goto out_unlock;
+	}
+
+	ctrl = nvme_ctrl_from_file(file);
+	if (!ctrl) {
 		pr_err("failed to open nvme controller %s\n",
 		       subsys->passthru_ctrl_path);
 
-		goto out_unlock;
+		goto out_put_file;
 	}
 
 	old = xa_cmpxchg(&passthru_subsystems, ctrl->cntlid, NULL,
 			 subsys, GFP_KERNEL);
 	if (xa_is_err(old)) {
 		ret = xa_err(old);
-		goto out_put_ctrl;
+		goto out_put_file;
 	}
 
 	if (old)
-		goto out_put_ctrl;
+		goto out_put_file;
 
 	subsys->passthru_ctrl = ctrl;
 	subsys->ver = ctrl->vs;
@@ -516,13 +522,12 @@ int nvmet_passthru_ctrl_enable(struct nvmet_subsys *subsys)
 			NVME_TERTIARY(subsys->ver));
 		subsys->ver = NVME_VS(1, 2, 1);
 	}
-
+	nvme_get_ctrl(ctrl);
 	__module_get(subsys->passthru_ctrl->ops->module);
-	mutex_unlock(&subsys->lock);
-	return 0;
+	ret = 0;
 
-out_put_ctrl:
-	nvme_put_ctrl(ctrl);
+out_put_file:
+	filp_close(file, NULL);
 out_unlock:
 	mutex_unlock(&subsys->lock);
 	return ret;
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

Return-Path: <SRS0=FbzM=CZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C30DC433E2
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Sep 2020 03:53:56 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C507B21655
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Sep 2020 03:53:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="n6SD2L3x";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Z4ajIBLM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C507B21655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=TfbI+7Y+VQ9xS8AVjGBX9N2YkdblExY4QhEkdg2D3SY=; b=n6SD2L3xeKsFWho1RJaV1s4D6
	x3EJzINZZ1j0NbrlbuZYLgjmDhgYLOlwE+7HBmODfwGnaXw4fsJQ54STr5upepJf/8me6njrdmXpw
	zkwaYOv7tIdZYuBoPVPqf+T44IxacRv1PGTsrAwjRE0Jf5l2CAlThp0pWgzXwsXXVANI7o/pvdmeA
	X5ju0HwjlTuQz3RsdtyJ9px9/11wdPwCLr+WA/DMUPnyGbVWmtos8zqmvKwf4qv1W2ktZLMwWeYfT
	oqq2MKx7HuurxsbChh8wEzui+8mL5TSodoL/FePs334NhWTITH8Y5MiZbUxzAGbtbieK3w+eyA123
	vo0QNHtSQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kIOW1-0003Ez-0L; Wed, 16 Sep 2020 03:53:53 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kIOVk-000350-Bo
 for linux-nvme@lists.infradead.org; Wed, 16 Sep 2020 03:53:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1600228417; x=1631764417;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=c0SHvlXEI4GKPaQDRQBiP+iRHwP8teCgCCBm409AcLA=;
 b=Z4ajIBLMPnfF2iE7F8foQrWJ0i4dcdfU24P7g424cB+RVLzD80ndp2eu
 Fu9m6ljNwl7BhIJltC5SD3FnEhIbOOorTXAj+/RW9v4sHTjULDAsZDd14
 EQKtwkLuZ2c+asgj016ODXkUu+1bUIG8EW/HZglewG0udcGcTrTzc//Sf
 uDshq7+XIeMz5qN/P7iBrqKj5XayF4NSUqahEcuTf3XAjftAx4PVwAgDA
 KZ3qnicNw7/8QTtEMQHMb95mnuwNiPMUkToHB3DztBvIUCQNlyVVYDBf8
 48icJRiDYxntM+4+wXt8psBEFARG/5ZYh4bRA5nH5f3GB6yxFgQ62OtJy A==;
IronPort-SDR: 1G/zDS3q6HB4g3fHZzfHc0VK39MViKVKnUjRtzNwveCSO8qdp0nQkW3mvxGPEqraIXb0JFIqDL
 S4S3xMoEZ+s8c6TyI+teJKnttrnV99m9gC6EATopqv4ZI2l8zJDZJnIsK/mwfl8nrgM+k2tHci
 +2+HWsYwrs/5X7cQB3SdufyPTsIsJnIjL9DN5o0cBKyEhZcPsInbHj4U8khEH/YDXcsPlrHuKZ
 p2MRMQT/qxBHtRTqzTK4+0GX+mmBGIyvmBFPzEsDPVV8SfvLly+Njf3JZOV7jsH0Pxb9BQTR3D
 S+Y=
X-IronPort-AV: E=Sophos;i="5.76,431,1592841600"; d="scan'208";a="148717385"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 16 Sep 2020 11:53:31 +0800
IronPort-SDR: i4FPGXvbh0uDpuZT8ocr6qrd7o2ebPvZI2Yp7jNaCPRU6Fe7Oc52q7Mx+KOW0j5f/zCTAzOVM3
 hHijIrbsod1Q==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2020 20:39:46 -0700
IronPort-SDR: +6phMXiFtlJvvMMfRhesS9jCZBOt5/Ss5XaMhYvnTUvXWHdvvKh4Pi20UHztc2XO+mxsYhHuau
 p7AVi0+ldNhw==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 15 Sep 2020 20:53:30 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V2 2/2] nvme: decouple nvme_get_ctrl() from file open
Date: Tue, 15 Sep 2020 20:53:26 -0700
Message-Id: <20200916035326.9229-3-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20200916035326.9229-1-chaitanya.kulkarni@wdc.com>
References: <20200916035326.9229-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200915_235336_553694_2BE1B1B9 
X-CRM114-Status: GOOD (  19.90  )
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
Cc: kbusch@kernel.org, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Rename nvme_ctrl_get_by_path() -> nvme_ctrl_get_by_file() and lift
the file opening and error handling in the caller so that we can unwind
appropriately in the error path (in nvmet_passthru_ctrl_enable()).

Now that we decoupled the file open/close from host/core.c move the
nvme_get_ctrl() to nvmet_passthru_ctrl_enable(), also close the file
before we release the passthru controller's reference.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/host/core.c       | 15 ++++-----------
 drivers/nvme/host/nvme.h       |  2 +-
 drivers/nvme/target/nvmet.h    |  1 +
 drivers/nvme/target/passthru.c | 19 +++++++++++++++----
 4 files changed, 21 insertions(+), 16 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c5f9d64b2bec..c446584d8b12 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4649,28 +4649,21 @@ void nvme_sync_queues(struct nvme_ctrl *ctrl)
 }
 EXPORT_SYMBOL_GPL(nvme_sync_queues);
 
-struct nvme_ctrl *nvme_ctrl_get_by_path(const char *path)
+struct nvme_ctrl *nvme_ctrl_get_by_file(struct file *f)
 {
 	struct nvme_ctrl *ctrl;
-	struct file *f;
-
-	f = filp_open(path, O_RDWR, 0);
-	if (IS_ERR(f))
-		return ERR_CAST(f);
 
 	if (f->f_op != &nvme_dev_fops) {
 		ctrl = ERR_PTR(-EINVAL);
-		goto out_close;
+		goto out;
 	}
 
 	ctrl = f->private_data;
-	nvme_get_ctrl(ctrl);
 
-out_close:
-	filp_close(f, NULL);
+out:
 	return ctrl;
 }
-EXPORT_SYMBOL_NS_GPL(nvme_ctrl_get_by_path, NVME_TARGET_PASSTHRU);
+EXPORT_SYMBOL_NS_GPL(nvme_ctrl_get_by_file, NVME_TARGET_PASSTHRU);
 
 /*
  * Check we didn't inadvertently grow the command structure sizes:
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 9fd45ff656da..2cb966653a33 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -835,7 +835,7 @@ static inline void nvme_hwmon_init(struct nvme_ctrl *ctrl) { }
 u32 nvme_command_effects(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 			 u8 opcode);
 void nvme_execute_passthru_rq(struct request *rq);
-struct nvme_ctrl *nvme_ctrl_get_by_path(const char *path);
+struct nvme_ctrl *nvme_ctrl_get_by_file(struct file *f);
 struct nvme_ns *nvme_find_get_ns(struct nvme_ctrl *ctrl, unsigned nsid);
 void nvme_put_ns(struct nvme_ns *ns);
 
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 47ee3fb193bd..477439acb8e1 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -248,6 +248,7 @@ struct nvmet_subsys {
 #ifdef CONFIG_NVME_TARGET_PASSTHRU
 	struct nvme_ctrl	*passthru_ctrl;
 	char			*passthru_ctrl_path;
+	struct file             *passthru_ctrl_file;
 	struct config_group	passthru_group;
 #endif /* CONFIG_NVME_TARGET_PASSTHRU */
 };
diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index 8bd7f656e240..84f9daea81db 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -473,12 +473,13 @@ u16 nvmet_parse_passthru_admin_cmd(struct nvmet_req *req)
 
 int nvmet_passthru_ctrl_enable(struct nvmet_subsys *subsys)
 {
+	const char *pt_path = subsys->passthru_ctrl_path;
 	struct nvme_ctrl *ctrl;
 	int ret = -EINVAL;
 	void *old;
 
 	mutex_lock(&subsys->lock);
-	if (!subsys->passthru_ctrl_path)
+	if (!pt_path)
 		goto out_unlock;
 	if (subsys->passthru_ctrl)
 		goto out_unlock;
@@ -488,15 +489,22 @@ int nvmet_passthru_ctrl_enable(struct nvmet_subsys *subsys)
 		goto out_unlock;
 	}
 
-	ctrl = nvme_ctrl_get_by_path(subsys->passthru_ctrl_path);
+	subsys->passthru_ctrl_file = filp_open(pt_path, O_RDWR, 0);
+	if (IS_ERR(subsys->passthru_ctrl_file)) {
+		ret = PTR_ERR(subsys->passthru_ctrl_file);
+		goto out_unlock;
+	}
+
+	ctrl = nvme_ctrl_get_by_file(subsys->passthru_ctrl_file);
 	if (IS_ERR(ctrl)) {
 		ret = PTR_ERR(ctrl);
 		pr_err("failed to open nvme controller %s\n",
 		       subsys->passthru_ctrl_path);
-
-		goto out_unlock;
+		goto out_put_file;
 	}
 
+	nvme_get_ctrl(ctrl);
+
 	old = xa_cmpxchg(&passthru_subsystems, ctrl->cntlid, NULL,
 			 subsys, GFP_KERNEL);
 	if (xa_is_err(old)) {
@@ -522,6 +530,8 @@ int nvmet_passthru_ctrl_enable(struct nvmet_subsys *subsys)
 
 out_put_ctrl:
 	nvme_put_ctrl(ctrl);
+out_put_file:
+	filp_close(subsys->passthru_ctrl_file, NULL);
 out_unlock:
 	mutex_unlock(&subsys->lock);
 	return ret;
@@ -531,6 +541,7 @@ static void __nvmet_passthru_ctrl_disable(struct nvmet_subsys *subsys)
 {
 	if (subsys->passthru_ctrl) {
 		xa_erase(&passthru_subsystems, subsys->passthru_ctrl->cntlid);
+		filp_close(subsys->passthru_ctrl_file, NULL);
 		nvme_put_ctrl(subsys->passthru_ctrl);
 	}
 	subsys->passthru_ctrl = NULL;
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

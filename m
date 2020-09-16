Return-Path: <SRS0=FbzM=CZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D915AC433E2
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Sep 2020 06:52:51 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 682C920771
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Sep 2020 06:52:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gT/nVpde"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 682C920771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Type:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To
	:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=0Y2w5gwXL7CmVMebSoP0d+/DLfi4xSTbC7Gn6slQp4c=; b=gT/nVpdez48H5fWNHO7zPfJdI
	0ErvhR+/HwUj83CJxtbvVWAjCBG0xech7p4G64/M1hu7+i9YNI34RckjoHOu50NuAy19WDne7p5dV
	3my8wqv+vXYTvQtmWM76rZ4+P9RAfLEnj78BtkcdSyTP0hi3oFmwe6thftTwnN7tJoZ2vEQuxX/zU
	kvGOjr9iy/EzDsYjzFqNLpfiTHvOJht/MTGMe4dRHz2dbSC8tiHi0urw0T5E0sL7LKjiJLwWPWfyO
	oNnMSCnRdMWwQQ8wIUMlnXbJEZBbDcdPmPfTG+uOpgmyOhw5pxL/g8WxEp+hBmhkRoyb5geW9+/Co
	SqCYqrwng==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kIRJA-0003hW-3x; Wed, 16 Sep 2020 06:52:48 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kIRJ8-0003h8-Ct
 for linux-nvme@lists.infradead.org; Wed, 16 Sep 2020 06:52:47 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 0DFD568B05; Wed, 16 Sep 2020 08:52:44 +0200 (CEST)
Date: Wed, 16 Sep 2020 08:52:43 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH V2 2/2] nvme: decouple nvme_get_ctrl() from file open
Message-ID: <20200916065243.GA9283@lst.de>
References: <20200916035326.9229-1-chaitanya.kulkarni@wdc.com>
 <20200916035326.9229-3-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="3MwIy2ne0vdjdPXF"
Content-Disposition: inline
In-Reply-To: <20200916035326.9229-3-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200916_025246_660826_54C50402 
X-CRM114-Status: GOOD (  23.61  )
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
Cc: kbusch@kernel.org, hch@lst.de, linux-nvme@lists.infradead.org,
 sagi@grimberg.me
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This needs to be split into a fix and a cleanup.

Attached is how I'd do it.


--3MwIy2ne0vdjdPXF
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="0001-nvmet-ensure-the-passthrough-controller-has-a-refere.patch"

From 497f52797e6d068712ecd794bd54d59fd7af3036 Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Wed, 16 Sep 2020 08:47:50 +0200
Subject: nvmet: ensure the passthrough controller has a reference to the
 transport

Grab a reference to the transport driver to ensure it can't be unloaded
while a passthrough controller is active.

Fixes: c1fef73f793b ("nvmet: add passthru code to process commands")
Reported-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/target/passthru.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index 8bd7f656e240b2..dacfa7435d0b2f 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -517,6 +517,7 @@ int nvmet_passthru_ctrl_enable(struct nvmet_subsys *subsys)
 		subsys->ver = NVME_VS(1, 2, 1);
 	}
 
+	__module_get(subsys->passthru_ctrl->ops->module);
 	mutex_unlock(&subsys->lock);
 	return 0;
 
@@ -531,6 +532,7 @@ static void __nvmet_passthru_ctrl_disable(struct nvmet_subsys *subsys)
 {
 	if (subsys->passthru_ctrl) {
 		xa_erase(&passthru_subsystems, subsys->passthru_ctrl->cntlid);
+		module_put(subsys->passthru_ctrl->ops->module);
 		nvme_put_ctrl(subsys->passthru_ctrl);
 	}
 	subsys->passthru_ctrl = NULL;
-- 
2.28.0


--3MwIy2ne0vdjdPXF
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="0002-nvme-decouple-nvme_get_ctrl-from-file-open.patch"

From e912746df46bed02b695c9869544a111f0f7487f Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Wed, 16 Sep 2020 08:48:21 +0200
Subject: nvme: decouple nvme_get_ctrl() from file open

Lift opening the file from nvme_ctrl_get_by_path into the caller, just
keeping a simple nvme_ctrl_from_file helper.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
[hch: refactored a bit, split the bug fixes into a separate prep patch]
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c       | 25 +++++--------------------
 drivers/nvme/host/nvme.h       |  2 +-
 drivers/nvme/target/passthru.c | 27 ++++++++++++++++-----------
 3 files changed, 22 insertions(+), 32 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c5f9d64b2bec02..f51ccb43002231 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4649,28 +4649,13 @@ void nvme_sync_queues(struct nvme_ctrl *ctrl)
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
index 9fd45ff656da81..1e6aaa7102627a 100644
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
index dacfa7435d0b2f..c0fd20d8097ee8 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -474,6 +474,7 @@ u16 nvmet_parse_passthru_admin_cmd(struct nvmet_req *req)
 int nvmet_passthru_ctrl_enable(struct nvmet_subsys *subsys)
 {
 	struct nvme_ctrl *ctrl;
+	struct file *file;
 	int ret = -EINVAL;
 	void *old;
 
@@ -488,24 +489,28 @@ int nvmet_passthru_ctrl_enable(struct nvmet_subsys *subsys)
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
-
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
@@ -517,12 +522,12 @@ int nvmet_passthru_ctrl_enable(struct nvmet_subsys *subsys)
 		subsys->ver = NVME_VS(1, 2, 1);
 	}
 
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
2.28.0


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

--3MwIy2ne0vdjdPXF--


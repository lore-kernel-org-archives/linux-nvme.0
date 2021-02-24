Return-Path: <SRS0=qQKB=H2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B784CC433E6
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Feb 2021 09:44:02 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 331F364E2B
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Feb 2021 09:44:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 331F364E2B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=/cBzHWgRD18Gbl4Ky0frW0bnGBAkilIyymsNcgi4dVA=; b=xcZDm7gAgvtcFJE+j0I2DYv8H
	guLCIJHO+Ho6s786Au2aOqZslJfHdvKr3RipuGfrMqZYYQcYkX5/rZL/PtoyrEc5zGCjD6BWV6c0i
	tk4b4VcW/weclvIPWOcpNdNxRsU2FGRNUzS+YP6lli0BlLPT3N0+CUmd2306+b8jc0JPVG26LCDlp
	Xz181770PuzO2b/gRRSM1dwl84xVRVPIOXvKaqPBnRPNsX59xU/WUSjx1ASUxFbFqPi2Ozsb0HhIA
	YlfXZlWX0l8M65oCPhOkjg7oyMrNRNb31q/VFR5I7Gdsar5wsOUPzqVZwEFm9ga1OIK7UqbuI16N8
	lDONhHryQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lEqhz-0004Ft-74; Wed, 24 Feb 2021 09:43:51 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lEqhx-0004FT-K5
 for linux-nvme@lists.infradead.org; Wed, 24 Feb 2021 09:43:50 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 6126068D0A; Wed, 24 Feb 2021 10:43:47 +0100 (CET)
Date: Wed, 24 Feb 2021 10:43:47 +0100
From: Christoph Hellwig <hch@lst.de>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH 1/1] nvmet: allow setting model_number once
Message-ID: <20210224094347.GA5965@lst.de>
References: <20210217181153.15343-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210217181153.15343-1-mgurtovoy@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210224_044349_920068_12F32E7A 
X-CRM114-Status: GOOD (  17.04  )
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
Cc: sagi@grimberg.me, chaitanya.kulkarni@wdc.com,
 linux-nvme@lists.infradead.org, hch@lst.de, kbusch@kernel.org, oren@nvidia.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

So looking at this and Chaitanya patch I think this version simplifies
things quite nicely, and it also happens to get rid of the RCU annotation
sparse warnings.

Let me know what you think of the incremental cleanup and micro-opimization
below, though:


diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 3da285e22e9209..2ca13dd7e7b88a 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -313,34 +313,40 @@ static void nvmet_execute_get_log_page(struct nvmet_req *req)
 	nvmet_req_complete(req, NVME_SC_INVALID_FIELD | NVME_SC_DNR);
 }
 
-static int nvmet_id_set_model_number(struct nvme_id_ctrl *id,
-				      struct nvmet_subsys *subsys)
+static u16 nvmet_set_model_number(struct nvme_id_ctrl *id,
+		struct nvmet_subsys *subsys)
 {
-	int ret = 0;
+	u16 status = 0;
 
 	mutex_lock(&subsys->lock);
 	if (!subsys->model_number) {
-		subsys->model_number = kstrdup(NVMET_DEFAULT_CTRL_MODEL,
-					       GFP_KERNEL);
-		if (!subsys->model_number) {
-			ret = -ENOMEM;
-			goto out_unlock;
-		}
+		subsys->model_number =
+			kstrdup(NVMET_DEFAULT_CTRL_MODEL, GFP_KERNEL);
+		if (!subsys->model_number)
+			status = NVME_SC_INTERNAL;
 	}
-	memcpy_and_pad(id->mn, sizeof(id->mn), subsys->model_number,
-		       strlen(subsys->model_number), ' ');
-out_unlock:
 	mutex_unlock(&subsys->lock);
-	return ret;
+
+	return status;
 }
 
 static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 {
 	struct nvmet_ctrl *ctrl = req->sq->ctrl;
+	struct nvmet_subsys *subsys = ctrl->subsys;
 	struct nvme_id_ctrl *id;
 	u32 cmd_capsule_size;
 	u16 status = 0;
-	int ret;
+
+	/*
+	 * If there is no model number yet, so it now.  It will then remain
+	 * stable for the life time of the subsystem.
+	 */
+	if (!subsys->model_number) {
+		status = nvmet_set_model_number(id, subsys);
+		if (status)
+			goto out;
+	}
 
 	id = kzalloc(sizeof(*id), GFP_KERNEL);
 	if (!id) {
@@ -355,11 +361,8 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 	memset(id->sn, ' ', sizeof(id->sn));
 	bin2hex(id->sn, &ctrl->subsys->serial,
 		min(sizeof(ctrl->subsys->serial), sizeof(id->sn) / 2));
-	ret = nvmet_id_set_model_number(id, ctrl->subsys);
-	if (ret) {
-		status = NVME_SC_INTERNAL;
-		goto out_free;
-	}
+	memcpy_and_pad(id->mn, sizeof(id->mn), subsys->model_number,
+		       strlen(subsys->model_number), ' ');
 	memcpy_and_pad(id->fr, sizeof(id->fr),
 		       UTS_RELEASE, strlen(UTS_RELEASE), ' ');
 
@@ -467,7 +470,6 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 
 	status = nvmet_copy_to_sgl(req, 0, id, sizeof(*id));
 
-out_free:
 	kfree(id);
 out:
 	nvmet_req_complete(req, status);
diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 71a1fe2f6330a9..e5dbd1923b7b75 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -1118,13 +1118,11 @@ static ssize_t nvmet_subsys_attr_model_show(struct config_item *item,
 					    char *page)
 {
 	struct nvmet_subsys *subsys = to_subsys(item);
-	char *model = "";
 	int ret;
 
 	mutex_lock(&subsys->lock);
-	if (subsys->model_number)
-		model = subsys->model_number;
-	ret = snprintf(page, PAGE_SIZE, "%s\n", model);
+	ret = snprintf(page, PAGE_SIZE, "%s\n", subsys->model_number ?
+			subsys->model_number : NVMET_DEFAULT_CTRL_MODEL);
 	mutex_unlock(&subsys->lock);
 
 	return ret;
@@ -1136,54 +1134,45 @@ static bool nvmet_is_ascii(const char c)
 	return c >= 0x20 && c <= 0x7e;
 }
 
-static ssize_t nvmet_subsys_attr_model_store(struct config_item *item,
-					     const char *page, size_t count)
+static ssize_t nvmet_subsys_attr_model_store_locked(struct nvmet_subsys *subsys,
+		const char *page, size_t count)
 {
-	struct nvmet_subsys *subsys = to_subsys(item);
-	char *new_model_number;
 	int pos = 0, len;
 
-	down_write(&nvmet_config_sem);
-	mutex_lock(&subsys->lock);
 	if (subsys->model_number) {
 		pr_err("Can't set model number. %s is already assigned\n",
 		       subsys->model_number);
-		count = -EINVAL;
-		goto out_unlock;
+		return -EINVAL;
 	}
 
 	len = strcspn(page, "\n");
-	if (!len) {
-		count = -EINVAL;
-		goto out_unlock;
-	}
+	if (!len)
+		return -EINVAL;
 
 	for (pos = 0; pos < len; pos++) {
-		if (!nvmet_is_ascii(page[pos])) {
-			count = -EINVAL;
-			goto out_unlock;
-		}
+		if (!nvmet_is_ascii(page[pos]))
+			return -EINVAL;
 	}
 
-	new_model_number = kmemdup_nul(page, len, GFP_KERNEL);
-	if (!new_model_number) {
-		count = -ENOMEM;
-		goto out_unlock;
-	}
+	subsys->model_number = kmemdup_nul(page, len, GFP_KERNEL);
+	if (!subsys->model_number)
+		return -ENOMEM;
+	return count;
+}
 
-	subsys->model_number = kstrdup(new_model_number, GFP_KERNEL);
-	if (!subsys->model_number) {
-		count = -ENOMEM;
-		kfree(new_model_number);
-		goto out_unlock;
-	}
+static ssize_t nvmet_subsys_attr_model_store(struct config_item *item,
+					     const char *page, size_t count)
+{
+	struct nvmet_subsys *subsys = to_subsys(item);
+	ssize_t ret;
 
-	kfree(new_model_number);
-out_unlock:
+	down_write(&nvmet_config_sem);
+	mutex_lock(&subsys->lock);
+	ret = nvmet_subsys_attr_model_store_locked(subsys, page, count);
 	mutex_unlock(&subsys->lock);
 	up_write(&nvmet_config_sem);
 
-	return count;
+	return ret;
 }
 CONFIGFS_ATTR(nvmet_subsys_, attr_model);
 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

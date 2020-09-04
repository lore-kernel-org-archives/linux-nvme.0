Return-Path: <SRS0=O63G=CN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D426EC43461
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Sep 2020 02:40:24 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93F6220775
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Sep 2020 02:40:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Kmwu02Eq";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="mm1NynAj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93F6220775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=eTS9HWgkef5mLqYDZbE+yTrLl+14AvEBOPYVYdU6Rng=; b=Kmwu02EqenObMchTM3pgfrUJ+
	DPJrB8kuQyqB8pt2btm3NV06HIv1FXcTGNEdrWIgTIiYTBHy0+2X6Xks25VBMnwuzpIud3C2RjlVD
	m+TnmwGPg/22qX7CrSsbrjMzwHQakYsXMdlbBp8ex03rETz1tJyq3fiuLrhUUNkW116Cs7Jb3rq4L
	ect7SEIEcChsa5fZ2CVxOhUCfG0JPWGls3w/Jf8e/RZj3hZLZHu3/1phAvYuOQOQMsITxJ8jUGLPV
	CcWRgX8cyJ2/vQ2SNUBOMXrzj6SQN3/OCPdhxyHCrT7KgGys6TpGIJBoHh7KmuYSitdmzh7kGiTgc
	YyhWy55QQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kE1eH-0005xZ-Ku; Fri, 04 Sep 2020 02:40:21 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kE1eE-0005x6-Ol
 for linux-nvme@lists.infradead.org; Fri, 04 Sep 2020 02:40:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1599187227; x=1630723227;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=+ZeRriU0vEyRX8Yn22sCC80Pwr+iFSfxDpHQnCjRMcA=;
 b=mm1NynAjgBivapjVqNURrlI7weKiAAmAhZC5M8MDQxbar5mQYe2OU22v
 SNAkVbGcGuZyxLSiFHyMedUZEONvxxBuA0peys/oMp5mcrYPCJmh2jQ5t
 lXGvkFmlBqeiX3SoW84hrEX1t9dyFPRsuRMh8u0qYeOtKoe5CbagBZRZT
 mR0fT0gfKIVwt0nBMll8c65lx8eeGEqe5trEj6rYkuVzlDW2jeUbclK8e
 mBU6dDafr318KwTgw5Ton9DFYPgUiTTwai4av76ngWblkwf2z8r3LLT4c
 RLV2XVxTCdrNjo6WWICw32txJy/VAublX9nu2yqHgS5Qr2x/WSqe2MlMw w==;
IronPort-SDR: 4Tyyw4MRiYJ2mpc0Ap67ma1bJ/JFtsMCgFwDSzyIQ1uuMgMU+k1K2Ra+OsML6ETKXNLfENFdYb
 2d14EIFeB4AvkIQqZO9IILjRlnVl4o/WRgY9Bd8xMg+0H9fsNkntxo0tYEPvjs/eytpD3HO2Ep
 +3g2BkjojAIGC96DyBv0+SoomN1/E4KkhxF3lMU56D/JQ4C7SJsYn0wc9FdUC2EGmekDmLzWPb
 y7ekgUG74l+X5r+O0WsZDYBXQXuIYOj4IBujUKBkusOHaTtf9we3ml/YojMcDkZi0l97hV7l95
 6rI=
X-IronPort-AV: E=Sophos;i="5.76,387,1592841600"; d="scan'208";a="249822428"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 04 Sep 2020 10:40:25 +0800
IronPort-SDR: miMd8oizJRcxVyWJpWjY9nBS9+/E8g7MvIdLfKbLtb8OnmBXCj+GjSWPz2Ae4ogok1N44ZOdUD
 F6fAYV+RjD3g==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2020 19:26:51 -0700
IronPort-SDR: ym02/nacS1dLyigpBgkkxHhVDAPVcbg7s5IoD7iWvE03NChyKaD7ieU368Fb8H9QNWN03VS4VW
 d+HjFmnExqig==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 03 Sep 2020 19:40:17 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 1/3] nvme: decouple nvme_ctrl_get_by_path()
Date: Thu,  3 Sep 2020 19:39:27 -0700
Message-Id: <20200904023929.5320-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20200904023929.5320-1-chaitanya.kulkarni@wdc.com>
References: <20200904023929.5320-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200903_224018_926130_502F84B3 
X-CRM114-Status: GOOD (  18.94  )
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
Cc: kbusch@kernel.org, logang@deltatee.com, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Right now nvme_ctrl_get_by_path() accepts ctrl path, based on that it
opens a file and calls nvme_get_ctrl(). In order to take module
refcount it is important to distinguish the error between file_open()
and module file ops check so that we can unwind the code in the caller
nvmet_passthru_ctrl_enable() in the error path.

Rename nvme_ctrl_get_by_path() -> nvme_ctrl_get_by_file() and lift
the file opening and error handling in the caller so that we can unwind
appropriately in the error path.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/host/core.c       | 10 ++--------
 drivers/nvme/host/nvme.h       |  2 +-
 drivers/nvme/target/nvmet.h    |  1 +
 drivers/nvme/target/passthru.c | 17 +++++++++++++----
 4 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 5702a3843746..fa7c0def9184 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4641,14 +4641,9 @@ void nvme_sync_queues(struct nvme_ctrl *ctrl)
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
@@ -4659,10 +4654,9 @@ struct nvme_ctrl *nvme_ctrl_get_by_path(const char *path)
 	nvme_get_ctrl(ctrl);
 
 out_close:
-	filp_close(f, NULL);
 	return ctrl;
 }
-EXPORT_SYMBOL_NS_GPL(nvme_ctrl_get_by_path, NVME_TARGET_PASSTHRU);
+EXPORT_SYMBOL_NS_GPL(nvme_ctrl_get_by_file, NVME_TARGET_PASSTHRU);
 
 /*
  * Check we didn't inadvertently grow the command structure sizes:
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 2910f6caab7d..590cc880834a 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -836,7 +836,7 @@ static inline void nvme_hwmon_init(struct nvme_ctrl *ctrl) { }
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
index 8bd7f656e240..14a842408035 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -473,6 +473,7 @@ u16 nvmet_parse_passthru_admin_cmd(struct nvmet_req *req)
 
 int nvmet_passthru_ctrl_enable(struct nvmet_subsys *subsys)
 {
+	const char *pt_path = subsys->passthru_ctrl_path;
 	struct nvme_ctrl *ctrl;
 	int ret = -EINVAL;
 	void *old;
@@ -480,7 +481,7 @@ int nvmet_passthru_ctrl_enable(struct nvmet_subsys *subsys)
 	mutex_lock(&subsys->lock);
 	if (!subsys->passthru_ctrl_path)
 		goto out_unlock;
-	if (subsys->passthru_ctrl)
+	if (!pt_path)
 		goto out_unlock;
 
 	if (subsys->nr_namespaces) {
@@ -488,13 +489,18 @@ int nvmet_passthru_ctrl_enable(struct nvmet_subsys *subsys)
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
 
 	old = xa_cmpxchg(&passthru_subsystems, ctrl->cntlid, NULL,
@@ -522,6 +528,8 @@ int nvmet_passthru_ctrl_enable(struct nvmet_subsys *subsys)
 
 out_put_ctrl:
 	nvme_put_ctrl(ctrl);
+out_put_file:
+	filp_close(subsys->passthru_ctrl_file, NULL);
 out_unlock:
 	mutex_unlock(&subsys->lock);
 	return ret;
@@ -531,6 +539,7 @@ static void __nvmet_passthru_ctrl_disable(struct nvmet_subsys *subsys)
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

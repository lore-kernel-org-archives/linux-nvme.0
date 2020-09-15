Return-Path: <SRS0=GAdO=CY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 022BBC43461
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Sep 2020 21:52:06 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98D992078E
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Sep 2020 21:52:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="byMzI9p3";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="BvLloGKh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98D992078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=MvoYR3WfCWZlIPUgCm4/PWA2DFOh0mlLUMDky8I0BZ0=; b=byMzI9p3rEBBY8QpLPhwSvXTS
	zLmjJKhdkOuRwjstiM6X7NBsGfMnBEYJb8dKzCpRumeRDpoxegHO2TlIsB6ffPstN+MNmzyaFKEHz
	FqWnbTyKxwPUzKdf2CFGwxyoPGrjmXZW95t4M6Mbely0oHrnFlWcxw4gq3CdsAOPTta/52bWVQngN
	4RdSTc29t+Vxjxaf04vRC5lOSl7lclLDtyU2bnO5efX4wKM1KGr7Uj4RHKUtD8OUfcZNQawoKnKy5
	OCq9AdXg1N1FNsB0+d+1ywLwwcuRbd14VkciU4aWWIl4qc4/lksXrnNrVEWLWaZQSQzviYGxhyzxR
	sSB/3xl1Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kIIrr-0001dX-6D; Tue, 15 Sep 2020 21:52:03 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kIIro-0001cU-M5
 for linux-nvme@lists.infradead.org; Tue, 15 Sep 2020 21:52:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1600206721; x=1631742721;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=MsfrWHMZ5N0TrEElZ/sFfd5DnF6xXtClL+993wzO1jI=;
 b=BvLloGKhz20GowZh2GWXfrLSnlpkPcWixmdCe5aShunGaJCHJn9tA1PJ
 nKAnIpl1XdIJjCEXBXDgvewP3fQjc1SSQS6xeos+LKfuC5iSVf5IG2MOK
 mizpuJatl3hhRX8gwNuA87+vfWAhnAjJTezXL5YcKqAQlgSp4kksi128B
 BBLAF0FunBgO1ElBznLy+lPcCmdkv00vOsmbkV8NT1EyqLJfj1Oz8NshL
 ckR8xdW48FFMAKEVB7upkHdZE7FIYop4JpYy/7xT2fcj12HyiVG4ZNDMk
 oKTEYtlRbphAdbs271V3FCPvQxgRwws6MvWsjU3YKcbHtqDyef2MuXJ7O Q==;
IronPort-SDR: A/4mgem+TKjl/scNPcRwllyAVJYkELSfooo11PR1xMLXl/kuNfxdxr2jFT/N3KXF9tRdjSZgk3
 x9Guy/P6l9lHLny02FfI3zhRyLD5sxnC/R5U2X7H7Au7ccoaKhw5e6gcEhWIyk2jBSpqruuytl
 +gmv55aR/h9uSYK8qHcrekMuo2awq+ik759R+SkIneeiAHlx7lnEzZskbPI0VcLMY3BuYGikOI
 Eu0OdcU1v4oeJ71XKUlNNk+m5gVK64iZPcb53HaJfBXca4MBo/1gO6Iq6KI2PXxJmw6dOeDYeG
 25Y=
X-IronPort-AV: E=Sophos;i="5.76,430,1592841600"; d="scan'208";a="151828778"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 16 Sep 2020 05:52:00 +0800
IronPort-SDR: azekAf3McP+Vy/gPKuVE6F2c50EmgpK+xF4WZGwh663Jk0WV7lJMrbVl28afqX2xkBVv6Qy8NB
 RXLVf0ob5dog==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2020 14:38:16 -0700
IronPort-SDR: alB1Dy4UKIsQicWUXqdjtsv/aX6JAo+w3njPcqTwu/czAKmLOvOpvrVKT0lpvWnOt0PvTqvsLJ
 GdM14nm36INw==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 15 Sep 2020 14:52:00 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V3 5/7] nvmet: add passthru admin timeout value attr
Date: Tue, 15 Sep 2020 14:51:16 -0700
Message-Id: <20200915215118.3934-6-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20200915215118.3934-1-chaitanya.kulkarni@wdc.com>
References: <20200915215118.3934-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200915_175200_868751_27B3F0A7 
X-CRM114-Status: GOOD (  19.26  )
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

NVMeOF controller in the passsthru mode is capable of handling wide set
of admin commands including Vender unique passhtru admin comands (VUAC).

The VUACs are used to read the large driver logs and can take longer
than default NVMe commands, that is for passthru requests the timeout
value may differ from the passthru controller's default timeout values
(nvme-core:admin_timeout).

Add a configfs attribute so that user can set the admin timeout values.
In case if this configfs value is not set default to ADMIN_TIMEOUT
value.

This attribute setting is only allowed when ctrl is disable to avoid
rcu calls in the fast path, in future when needed we can always make it
fast path friendly using RCU.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/configfs.c | 34 ++++++++++++++++++++++++++++++++++
 drivers/nvme/target/nvmet.h    |  1 +
 drivers/nvme/target/passthru.c |  6 +++++-
 3 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 37e1d7784e17..b3b57add53d1 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -736,7 +736,41 @@ static ssize_t nvmet_passthru_enable_store(struct config_item *item,
 }
 CONFIGFS_ATTR(nvmet_passthru_, enable);
 
+static ssize_t nvmet_passthru_admin_timeout_show(struct config_item *item,
+		char *page)
+{
+	struct nvmet_subsys *subsys = to_subsys(item->ci_parent);
+
+	return sprintf(page, "%u\n", subsys->admin_timeout);
+}
+
+static ssize_t nvmet_passthru_admin_timeout_store(struct config_item *item,
+		const char *page, size_t count)
+{
+	struct nvmet_subsys *subsys = to_subsys(item->ci_parent);
+	unsigned int admin_timeout;
+	int ret = 0;
+
+	mutex_lock(&subsys->lock);
+	if (subsys->passthru_ctrl) {
+		pr_err("disable passthru ctrl before setting admin_timeout\n");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (kstrtouint(page, 0, &admin_timeout)) {
+		ret = -EINVAL;
+		goto out;
+	}
+	subsys->admin_timeout = admin_timeout;
+out:
+	mutex_unlock(&subsys->lock);
+	return ret ? ret : count;
+}
+CONFIGFS_ATTR(nvmet_passthru_, admin_timeout);
+
 static struct configfs_attribute *nvmet_passthru_attrs[] = {
+	&nvmet_passthru_attr_admin_timeout,
 	&nvmet_passthru_attr_device_path,
 	&nvmet_passthru_attr_enable,
 	NULL,
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 47ee3fb193bd..13266e413ccb 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -249,6 +249,7 @@ struct nvmet_subsys {
 	struct nvme_ctrl	*passthru_ctrl;
 	char			*passthru_ctrl_path;
 	struct config_group	passthru_group;
+	unsigned int		admin_timeout;
 #endif /* CONFIG_NVME_TARGET_PASSTHRU */
 };
 
diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index 53a3906bd913..3a364a12e8c9 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -215,6 +215,7 @@ static int nvmet_passthru_map_sg(struct nvmet_req *req, struct request *rq)
 
 static void nvmet_passthru_execute_cmd(struct nvmet_req *req)
 {
+	unsigned int admin_timeout = req->sq->ctrl->subsys->admin_timeout;
 	struct nvme_ctrl *ctrl = nvmet_req_passthru_ctrl(req);
 	struct request_queue *q = ctrl->admin_q;
 	struct nvme_ns *ns = NULL;
@@ -242,7 +243,7 @@ static void nvmet_passthru_execute_cmd(struct nvmet_req *req)
 		goto out_put_ns;
 	}
 
-	rq->timeout = q->queuedata ? NVME_IO_TIMEOUT : ADMIN_TIMEOUT;
+	rq->timeout = q->queuedata ? NVME_IO_TIMEOUT : admin_timeout;
 
 	if (req->sg_cnt) {
 		ret = nvmet_passthru_map_sg(req, rq);
@@ -519,6 +520,9 @@ int nvmet_passthru_ctrl_enable(struct nvmet_subsys *subsys)
 		subsys->ver = NVME_VS(1, 2, 1);
 	}
 
+	if (!subsys->admin_timeout)
+		subsys->admin_timeout = ADMIN_TIMEOUT;
+
 	mutex_unlock(&subsys->lock);
 	return 0;
 
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

Return-Path: <SRS0=GAdO=CY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8152C433E2
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Sep 2020 21:52:14 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D7E42078E
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Sep 2020 21:52:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SFgcqjc3";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="q72MZbIR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D7E42078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ZrQm5xCrfxkXv7KapnepjHH1+kVl0WIC3onHu6cjURg=; b=SFgcqjc3kfQIwWLMfLrFvolvp
	Ssvz78wgD8fS6j9yY8q6nzCcyYd4h6pNVPSFPalEwkj+WLKq2w35xoC72tOjfgG3J8fa1cTydJrBZ
	dZ51d27Oi6VWkpUKGsh5oaCmAGiQVZTvLIGGdzBliv5fosQCgmiWlWH8ZvnLQ1SpvdA1y3PyM7l2P
	hXtcX+qyA0WIm5e+J9IffCPBqlBmPyzrsS0cv5g9PSa2uxF2sz7Vw6Iom5tcV29A07CJAF6h0JOQY
	nNMZAHiyj7DRRpe4j4+F+kQVGaZjWSBVIBRvmT/q71LG5WpuLhEbiyryH7YUEIFX+kDfHSajZJ8aV
	FuT3y2KuQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kIIrz-0001gE-60; Tue, 15 Sep 2020 21:52:11 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kIIrw-0001f4-8f
 for linux-nvme@lists.infradead.org; Tue, 15 Sep 2020 21:52:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1600206728; x=1631742728;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=tNSB1HG0Q0R95VXGhmFZx3Ws2F+g3lrQQIiTMArZrJU=;
 b=q72MZbIRn2jHx+GwBFwIDCjCJF9/PKoP3C+id+Cx/gWppiHDMQ0Sapa6
 3LEOiDq+XbV/3wawUto61oOM6VPTTx5ONMTm/moRj7YxbQiUueB+1CJh1
 fPvZOarpN6RN2I3x6YrPkRDiGdDUGtqcsJ67GovtaQW+IksKcYuPu9Z9m
 QFDzXHS5rVkrL1mhHrshEa6znFYyHmIhqnmrhs8bKlbpOG4JYj2L1lmcp
 Vn2j1dgtCCKUXMbclM2TtOVM6yS813JaNvqs9kJ7Diuq6o8kTRzCs6tQb
 Kfig8y9CztVAtzwiuFUzYqR/RAqd5sm/jIYYKPhfxf1xlux1mTzdGs7iw A==;
IronPort-SDR: nXjZIAMbhqgSMo5gAQusDbLmuUH6zTbtGmPR0zPJoXppRH3El42MantOS0Wvdso8SGT7xWTWW1
 WywNV3TKK4j1sxyJXcK0VdkJi4nshW0ewbMKpFJk2otG+QFZskZj5D5sieFq4jSsThhgGgBY8n
 CzP3fkzXCgsf2Qk7Lh+PoeVj/u5VzvyseXHMC0mzvaiEgphhTx1mTk+T+TaReWvIxZEAmsAKDr
 knZqGKjc7/bCHyIioWC4KqpMBZiJA9POM76GN8pBhBZ8tECCcfgrUx857jPYTU+3HjIcf1XXYj
 10M=
X-IronPort-AV: E=Sophos;i="5.76,430,1592841600"; d="scan'208";a="147385166"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 16 Sep 2020 05:52:07 +0800
IronPort-SDR: MPfHyQ8D2Eh3G1RGH3QNbl1vhmS0mIAMWoSqxnwGqHoAzBF21KJZc0SRLdFXnQaH6h/OKnG0s0
 v3wiQKTzQ0ag==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2020 14:39:17 -0700
IronPort-SDR: xLCg7Qrn66uFCe7kGs3uwRv1449ERk7OtmN+2glLdmNMydxH1PnH71/z3djqJOGlC00BfIA1kO
 M50U2WoX7vfg==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 15 Sep 2020 14:52:07 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V3 6/7] nvmet: add passthru io timeout value attr
Date: Tue, 15 Sep 2020 14:51:17 -0700
Message-Id: <20200915215118.3934-7-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20200915215118.3934-1-chaitanya.kulkarni@wdc.com>
References: <20200915215118.3934-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200915_175208_443926_C3E5BC50 
X-CRM114-Status: GOOD (  18.89  )
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

NVMe controller in the passsthru mode is capable of handling wide set
of admin commands including Vender unique passhtru I/O comands
(VUICs).

The VUICs can take longer than default NVMe commands, that is for
passthru requests the timeout value may differ from the passthru
controller's default timeout values (nvme-core:io_timeout).

Add configfs attribute so that user can set the I/O timeout values.
In case if this configfs value is not set default to NVME_IO_TIMEOUT
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
index b3b57add53d1..506da13ac083 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -769,8 +769,42 @@ static ssize_t nvmet_passthru_admin_timeout_store(struct config_item *item,
 }
 CONFIGFS_ATTR(nvmet_passthru_, admin_timeout);
 
+static ssize_t nvmet_passthru_io_timeout_show(struct config_item *item,
+		char *page)
+{
+	struct nvmet_subsys *subsys = to_subsys(item->ci_parent);
+
+	return sprintf(page, "%u\n", subsys->io_timeout);
+}
+
+static ssize_t nvmet_passthru_io_timeout_store(struct config_item *item,
+		const char *page, size_t count)
+{
+	struct nvmet_subsys *subsys = to_subsys(item->ci_parent);
+	unsigned int io_timeout;
+	int ret = 0;
+
+	mutex_lock(&subsys->lock);
+	if (subsys->passthru_ctrl) {
+		pr_err("disable passthru ctrl before setting io_timeout\n");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (kstrtouint(page, 0, &io_timeout)) {
+		ret = -EINVAL;
+		goto out;
+	}
+	subsys->io_timeout = io_timeout;
+out:
+	mutex_unlock(&subsys->lock);
+	return ret ? ret : count;
+}
+CONFIGFS_ATTR(nvmet_passthru_, io_timeout);
+
 static struct configfs_attribute *nvmet_passthru_attrs[] = {
 	&nvmet_passthru_attr_admin_timeout,
+	&nvmet_passthru_attr_io_timeout,
 	&nvmet_passthru_attr_device_path,
 	&nvmet_passthru_attr_enable,
 	NULL,
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 13266e413ccb..a24b4c7a3ab4 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -250,6 +250,7 @@ struct nvmet_subsys {
 	char			*passthru_ctrl_path;
 	struct config_group	passthru_group;
 	unsigned int		admin_timeout;
+	unsigned int		io_timeout;
 #endif /* CONFIG_NVME_TARGET_PASSTHRU */
 };
 
diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index 3a364a12e8c9..2564b6769b9e 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -216,6 +216,7 @@ static int nvmet_passthru_map_sg(struct nvmet_req *req, struct request *rq)
 static void nvmet_passthru_execute_cmd(struct nvmet_req *req)
 {
 	unsigned int admin_timeout = req->sq->ctrl->subsys->admin_timeout;
+	unsigned int io_timeout = req->sq->ctrl->subsys->io_timeout;
 	struct nvme_ctrl *ctrl = nvmet_req_passthru_ctrl(req);
 	struct request_queue *q = ctrl->admin_q;
 	struct nvme_ns *ns = NULL;
@@ -243,7 +244,7 @@ static void nvmet_passthru_execute_cmd(struct nvmet_req *req)
 		goto out_put_ns;
 	}
 
-	rq->timeout = q->queuedata ? NVME_IO_TIMEOUT : admin_timeout;
+	rq->timeout = q->queuedata ? io_timeout : admin_timeout;
 
 	if (req->sg_cnt) {
 		ret = nvmet_passthru_map_sg(req, rq);
@@ -523,6 +524,9 @@ int nvmet_passthru_ctrl_enable(struct nvmet_subsys *subsys)
 	if (!subsys->admin_timeout)
 		subsys->admin_timeout = ADMIN_TIMEOUT;
 
+	if (!subsys->io_timeout)
+		subsys->io_timeout = NVME_IO_TIMEOUT;
+
 	mutex_unlock(&subsys->lock);
 	return 0;
 
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

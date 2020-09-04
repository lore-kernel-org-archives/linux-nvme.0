Return-Path: <SRS0=O63G=CN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A27A1C43461
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Sep 2020 00:17:11 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6470C20767
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Sep 2020 00:17:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="xmM8bEtT";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="J9N7ubly"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6470C20767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=xZ+bTLsyhv84PeSeJtcxBj59ALBaZ8LWluEOee6neX0=; b=xmM8bEtTckF7YVBfEEY/Z5xFk
	u5dtGZn3yI+yzKzXOUtqASM/8pDX1Qs/SWlJskUHPP314Efc4C4rt5IWSsFytS6AVcngjUTSTUQNB
	hbMJe+OszpWHmOKaqE0+40mq8IHRd6MC24L9vOY9A3NY5c/KkNAmNo3v4OvNW7QmIaGJQ7fQMYBiw
	dUvOnaDBPh1XhNer8KqX84qKNnVxqRtNb6eMCEan+Jbtr+9UHKyNW2QqeYxcT+ruwgnc/OU0W6Kz8
	I7XpEOkL/wxRvxsLHiJnDB0gl4deriGICS1wC8GC3E1TTwQRrWUfYLD9G1Ja/JhV2JSrH1UdmGjMU
	7HM2gvgUA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kDzPh-0003yJ-Fb; Fri, 04 Sep 2020 00:17:09 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kDzPf-0003v6-2f
 for linux-nvme@lists.infradead.org; Fri, 04 Sep 2020 00:17:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1599178628; x=1630714628;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=6o4mQotzXPiwSeDTCawEpYIajZIcx11pTqRnk9A9EaE=;
 b=J9N7ubly7Lvo9pLEvU3WzREV/wAGCBEOz+riCPJKw4oKVwS3FZ8JnO4U
 9tu6UMCgBTHldT78zTPg2lprlWDGpIrZwM0aZg9ZXL5VRvgaRnlKGXsLP
 hVKjijJdbmz/eJ9rbyf+W8bw8PgXhq9ZyCc+xG/1CKSfnciMqna+ijzCO
 SdYkocfY9sq9rfd0ODQuk+VbZovEiWUihjhTNm+IUl4kRbzJzYFI1GyYo
 syMvloU2pq1iOywsOYAcIooX43KyMau9wWFWTQCPXt575SpJTkuggRiEH
 UscNesyH9EWqfBQD0rHitPUYV/Q0QwAGAJHElvOFmw5M3CpOQsrnnCVlV A==;
IronPort-SDR: J1Ve1OCSLpRYDuJ4dBAYKVa/QFC+xa0u1GhwL7KSTF1ZhrERdl8TFrKsXYQumXKG2AmqT5TWtJ
 /xP9MlYowMAf0uEnRp1l25Myufl77nTDrjxn3pdaIZT8vFjXAtTN+5x3Gp+nIsB3zLsvHxtR4A
 wZ8hX2lJHUIAK2jamP1ueHWpdGKX8NDQpa8sA+NLRc66vgPi6sS3q2xuaCPn4hgrsg3t4PX7GN
 9wtEJr80I4XD38zBxfCvAr+WY0auh7nyE8pfzFpAm3q/Qj2cLN7pq1NqPsB+3YwKT/vHdOoxO0
 3U4=
X-IronPort-AV: E=Sophos;i="5.76,387,1592841600"; d="scan'208";a="146532581"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 04 Sep 2020 08:17:07 +0800
IronPort-SDR: jnmlIc8jg/2fFRx0iIffOnbP29r/r2H21YmqEL0M+lmzw2AJ5v6+NPyvFmIbj6qk4WV7+OLFpP
 oRnWKEumJDTg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2020 17:03:40 -0700
IronPort-SDR: O5MtVXGCHS7ybDxQj2f4LITCmkvx+tGMmW/Tr/cVsI2ysWeguk+sMznnYQyrv04KXEY2Ntis1h
 guFbgOC+enYQ==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 03 Sep 2020 17:17:06 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V2 4/6] nvmet: add passthru admin timeout value attr
Date: Thu,  3 Sep 2020 17:16:24 -0700
Message-Id: <20200904001626.5694-5-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20200904001626.5694-1-chaitanya.kulkarni@wdc.com>
References: <20200904001626.5694-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200903_201707_335341_90B03DEF 
X-CRM114-Status: GOOD (  18.83  )
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
Cc: keith.busch@intel.com, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

NVMe controller in the passsthru mode is capable of handling wide set
of admin commands including Vender unique passhtru admin comands
(VUACs).

The VUACs are used to read the large driver logs and can take longer
than default NVMe commands, that is for passthru requests the timeout
value may differ from the passthru controller's default timeout values
(nvme-core:admin_timeout).

Add configfs attribute so that user can set the admin timeout values.
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

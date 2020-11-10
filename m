Return-Path: <SRS0=JPfP=EQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86419C4741F
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Nov 2020 00:34:07 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09DE4206D8
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Nov 2020 00:34:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Q2m6TSRg";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="mOF+CtQV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09DE4206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=DHvbUvucgl3AhVigcf1dHC8eqZ70EggyyeoBTUSvf9U=; b=Q2m6TSRgtezYR3XOanztp1Zrr
	dRi0vfWWUAof319ZMwfDJpXWbwlwgGP3JJqy+vIV+GUglEtor/i4dnUc+SWuS7WHbeDWzC+o0myBb
	+wkn0I2oPKBZTWi20W5nisDUBXOLhUDg+nBj0DprAdkJb3S5CF4nHgd3/nhvKiW9GIl3JCeaLqxpZ
	NNn1YzaAnUBbsx529wGY1NLW2Z6FtnV+AmNVhYDyJ5nFSHfr1t2BAzh37Qkq2JD6rqguPVRvg25gs
	KZi5FZsmcISKpFsNDMv+hTvlIwV7+dpmpK8roY/mxk8xrqYiramN7tS/Bv8q7uCB8cAe5TNSWsC7U
	GUS/PNINw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kcHbo-0001zI-Ml; Tue, 10 Nov 2020 00:34:04 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kcHbl-0001yT-J1
 for linux-nvme@lists.infradead.org; Tue, 10 Nov 2020 00:34:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1604968441; x=1636504441;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=POPFCqyv7Gb4o0qMdI05Qj4MxVbltbZiI9MjGXrlt1I=;
 b=mOF+CtQVBOtwPvE9dIVI4MzzfS8keATTpYtztFRUwlEmvaLlyiS+84Yh
 yJ/B0upGNhRLTY8jVvApBfoqqdM++Bs7vPo4RqVJYi62cmMy2/k/A3+YM
 KHsduPfYPGfURKwinKZ3VbPViVa7ZFmrp3QxR17SgouJGtgT2u6Xo74pP
 3L0WaIO3R4EJ6GB5gSNVwCBS7DVzuY60OZyrV2b1yaiicHiSBjA39U6P5
 MIWC1HoUXLPlYHu0ZJwWBOa8Qx30CeZ8UsrMJ/G9iYey8TTFXXm38Or7O
 baw/g/Su5exJhsy7zrIbTSaXaCiUnRXQIOvseZjG+rcp2ndLfFB3VjHe5 A==;
IronPort-SDR: GgfNWOUUhS28e2GNTjMEmPaGbzvInxrl7Dg5tJcFNxpu4eNf1cDB9dOejuon35YKo+dLmDTXbm
 vXi9qP8rBufFKsPHAIld3FuWNDI3vdSfQJFgoEhbT6OBCageXgoFl1KOHhD6OsPCKz7njxErRt
 UU305RgvHjzumGQ9yN3G3ZD40U5mkJkQvcvIS4Yi25aCKswXj26rIxYKBs8WgAPlWTcfV1m20M
 oPvPm/HyVXrOUU3mJ7pPi3/At14Tj8HP7qx+7uKHRq8TWc5rbhNuz0S16rkQCtgyg/STELEmw9
 3Mc=
X-IronPort-AV: E=Sophos;i="5.77,464,1596470400"; d="scan'208";a="152131762"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 10 Nov 2020 08:34:00 +0800
IronPort-SDR: mbOX49V+kni0FpYqg/9pbdsTSrWEXPd/g/sWAoGBZZ9Ddv5aK+U/HdI/1yV4/YkF2cP7YjJVBT
 D1T/8HS8SKtEDeAfaUJ+PpKc8wschNky3lQ5YVY7UfTaVpGxh2Gfc7WayyD4KuynecLPUxERXN
 v7enKkxHnY8LI0PAodRQbf75/RN4yuvMk57tGmsUMEItcYlgk4ozAqKnrPGvKDdAPi1m1NOcS4
 7vexzqk7vUrTIhuh1/CGjpdhf/7FIShMvg8MwaO5J9YUpBd7RAbeD+06YsPN6ODyA7iaK4qvYe
 2QMn78HrNOHuynF6QRtQSjMN
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2020 16:18:48 -0800
IronPort-SDR: Cs4uMUUwnBagec2m7riY46sEcDmuunEMCtxUSMUD2Iv70VZaS8XxqhfUbbfb7tAde5l27Ne1Yr
 zTF0AwsDZqP/b3yojlSmsf7YVSEnV1I3U48rZTtNcNX6evREKXHNil4RBGuprzaATysqjcb0Q6
 RxMTyJbt+MoRIYbmH6h4sWujOeNvJBLxvDR07luPDhKx+dQ9QUQKDMeKGdSrenWfsov/JHCS9Z
 WQs/K8ewTNX3QP853UBBrDsDYzjm85D6QvVkM4/FKXCTRcTL3SFycjUvYt8sePIxIKdyrv9Q6J
 qrk=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 09 Nov 2020 16:34:00 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V8 2/4] nvmet: add passthru admin timeout value attr
Date: Mon,  9 Nov 2020 16:33:43 -0800
Message-Id: <20201110003345.8191-3-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201110003345.8191-1-chaitanya.kulkarni@wdc.com>
References: <20201110003345.8191-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201109_193401_824037_30BDE824 
X-CRM114-Status: GOOD (  17.10  )
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
Cc: kbusch@kernel.org, sagi@grimberg.me,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

NVMeOF controller in the passsthru mode is capable of handling wide set
of admin commands including vender specific passhtru admin comands.

The vendor specific admin commands are used to read the large drive
logs and can take longer than default NVMe commands, i.e. for
passthru requests the timeout value may differ from the passthru
controller's default timeout values (nvme-core:admin_timeout).

Add a configfs attribute so that user can set the admin timeout values.
In case if this configfs value is not set nvme_alloc_request() will set
the ADMIN_TIMEOUT value when request queuedata is NULL.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/configfs.c | 24 ++++++++++++++++++++++++
 drivers/nvme/target/nvmet.h    |  1 +
 drivers/nvme/target/passthru.c |  6 ++++++
 3 files changed, 31 insertions(+)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 37e1d7784e17..67e231e3df2b 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -736,9 +736,33 @@ static ssize_t nvmet_passthru_enable_store(struct config_item *item,
 }
 CONFIGFS_ATTR(nvmet_passthru_, enable);
 
+static ssize_t nvmet_passthru_admin_timeout_show(struct config_item *item,
+		char *page)
+{
+	return sprintf(page, "%u\n", to_subsys(item->ci_parent)->admin_timeout);
+}
+
+static ssize_t nvmet_passthru_admin_timeout_store(struct config_item *item,
+		const char *page, size_t count)
+{
+	struct nvmet_subsys *subsys = to_subsys(item->ci_parent);
+	unsigned int admin_timeout;
+	int ret = 0;
+
+	if (kstrtouint(page, 0, &admin_timeout)) {
+		ret = -EINVAL;
+		goto out;
+	}
+	subsys->admin_timeout = admin_timeout;
+out:
+	return ret ? ret : count;
+}
+CONFIGFS_ATTR(nvmet_passthru_, admin_timeout);
+
 static struct configfs_attribute *nvmet_passthru_attrs[] = {
 	&nvmet_passthru_attr_device_path,
 	&nvmet_passthru_attr_enable,
+	&nvmet_passthru_attr_admin_timeout,
 	NULL,
 };
 
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 559a15ccc322..a0c80e5179a2 100644
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
index 8ee94f056898..dd17d314fa3e 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -227,6 +227,7 @@ static void nvmet_passthru_execute_cmd(struct nvmet_req *req)
 	struct request_queue *q = ctrl->admin_q;
 	struct nvme_ns *ns = NULL;
 	struct request *rq = NULL;
+	unsigned int timeout;
 	u32 effects;
 	u16 status;
 	int ret;
@@ -242,6 +243,8 @@ static void nvmet_passthru_execute_cmd(struct nvmet_req *req)
 		}
 
 		q = ns->queue;
+	} else {
+		timeout = req->sq->ctrl->subsys->admin_timeout;
 	}
 
 	rq = nvme_alloc_request(q, req->cmd, 0, NVME_QID_ANY);
@@ -250,6 +253,9 @@ static void nvmet_passthru_execute_cmd(struct nvmet_req *req)
 		goto out_put_ns;
 	}
 
+	if (timeout)
+		rq->timeout = timeout;
+
 	if (req->sg_cnt) {
 		ret = nvmet_passthru_map_sg(req, rq);
 		if (unlikely(ret)) {
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

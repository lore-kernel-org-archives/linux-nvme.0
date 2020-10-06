Return-Path: <SRS0=LUST=DN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68C68C4363D
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Oct 2020 23:31:45 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F38DD2087E
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Oct 2020 23:31:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="o1hMIc7P";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="OtaMC6Ij"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F38DD2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=CnLpq0ILBos+7yfrBZatMusI7pM5+Di+hztq2RRrfpc=; b=o1hMIc7PLD6R3EM/8at8c/kYl
	nL4ZXem/KzmZ4Hxx+52LSbX5dq2ziT83Ay8dHqJrqA+s4WU1Ci+mu9JhGXd40zqlwKs1ydpU8qkaO
	BXm9WbTEUrHtqqLcVC8Qg32eZUb7jWf7X9fwuodgHDVUnmKlTwpPc/KyQTxa3TX1xiKUk0nIvAPOh
	O/5+FkaUUFxrESjBpp7mAf+amanPJLilFEo8GGuxfSGMbDK0FDio/Yti950W5+CpGbCvByedC19Fg
	c/GVIUCVtA6LEFboc16Cu28Xoh3naeDWv3uqe9FFape+7fRTcgP6mrxheIBBhiXCm5Vmoem3Qqsgd
	HfvRoCRfg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kPwQp-0006LR-1u; Tue, 06 Oct 2020 23:31:43 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kPwQm-0006KL-Hz
 for linux-nvme@lists.infradead.org; Tue, 06 Oct 2020 23:31:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1602027196; x=1633563196;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=CLMt6QAe4RvCPeav/ujBwpExuNBQIJlkE6ALh+nQnXU=;
 b=OtaMC6IjQktMulRIkp/GEeAAE0XarojW+IYaK2KNQMHOxUZpIaD7zCAw
 2yW03vZFuhSrSIL/fovSe1tM0d9BN0vNRQqKWPBjblvU8jG9yRy4NAAPU
 VBmVu+ye1pLvzz1pv3xmPsZT+XguuGLLuDYsjZhSL2+QDx2/tsHVa23u2
 D4JY91NAFv0JXI0JyFwmPisPOgTIwyHfTZm5kEun2n/3BUKOT3lLWCZEy
 +RrkCS3hUAuLCO1jBN7mO08CMb/XH+9Mqp6qYb7sB/5q/3HiX7gV2uuXN
 d4yHAHo5K0A96TKJgUMzFCc7CS+H9rkB1TytmX6x3oIzgUr16jpE/U4ia A==;
IronPort-SDR: pfOZvoarlIcQ/10ZBSMzDrtPYLZNTJtR9FPPha8qy+PmMmEyAzPWVOhhogs/vL7MdlGabjmyl5
 l2NtEfHa/r+apjFVh39jDvJ/XHljqghuelXjSouhGllYWGt+0sPnXSmjLRYgmLIm4Vpz8Bak1T
 iHv6NnT+X2A2HF1Ogosr+mQbno8oTkUdwxWKvrXuJ8OehfM4Pblbq+kPjb5NNuhWsfPQaRmkq1
 ONxYpcpdMF5hc1DeK4WPvmZ1YIPt8+Yx2YgYHAJqBogcqzp8EvZGxvzZ0Lc/68cMuexS0QNjkt
 2YM=
X-IronPort-AV: E=Sophos;i="5.77,344,1596470400"; d="scan'208";a="252647653"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 07 Oct 2020 07:33:15 +0800
IronPort-SDR: d9vXXZt/dzyBwnJcseTvfCSxeUjoakHzdSpHAf9os7vRCGC20a9uOlIR8GL+5GHaHCSzeuPfBd
 fniwUP5e17MA==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2020 16:18:25 -0700
IronPort-SDR: /ICpTGF/bEOblrbzxx0CWhh1NtZwFaiiY89dhyuOc0a7/es/Bi7Yb1Wbnh/9ESKkUfgNhU8DAA
 K+Nq9jjozQdA==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip01.wdc.com with ESMTP; 06 Oct 2020 16:31:40 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V4 5/7] nvmet: add passthru admin timeout value attr
Date: Tue,  6 Oct 2020 16:30:47 -0700
Message-Id: <20201006233049.55458-6-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201006233049.55458-1-chaitanya.kulkarni@wdc.com>
References: <20201006233049.55458-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201006_193140_705688_9AEC8564 
X-CRM114-Status: GOOD (  19.16  )
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
 drivers/nvme/target/configfs.c | 32 ++++++++++++++++++++++++++++++++
 drivers/nvme/target/nvmet.h    |  1 +
 drivers/nvme/target/passthru.c |  7 ++++++-
 3 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 37e1d7784e17..7625f8892fb5 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -736,9 +736,41 @@ static ssize_t nvmet_passthru_enable_store(struct config_item *item,
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
index 9f9ab5665dd2..253ca2b6ed10 100644
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
@@ -540,6 +541,10 @@ int nvmet_passthru_ctrl_enable(struct nvmet_subsys *subsys)
 			NVME_TERTIARY(subsys->ver));
 		subsys->ver = NVME_VS(1, 2, 1);
 	}
+
+	if (!subsys->admin_timeout)
+		subsys->admin_timeout = ADMIN_TIMEOUT;
+
 	nvme_get_ctrl(ctrl);
 	__module_get(subsys->passthru_ctrl->ops->module);
 	ret = 0;
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

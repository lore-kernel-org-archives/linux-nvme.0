Return-Path: <SRS0=H+rW=EL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8443C388F9
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Nov 2020 03:42:53 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F367205F4
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Nov 2020 03:42:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="vgUSY5Bb";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mhZadFar";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="LKPImxpu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F367205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Dul5t/A9O8neZDFgEX8aiVyFFB+dSHrRrWBfPmZqc9U=; b=vgUSY5Bb9Q85q6L/NXa+cmydW
	jDni1UXmfi4cAvJWSfG00AL1KPRMd1ihBG/ecRnZcA3OHNjg8wVgW5DyndzcKu/uIC74ux2y7xGBm
	VWyHcBVBd8glauIASoB8EZ1BVM/mkDw0LokPA4517EPYFZfa9XS1tCgFGkNhprwyqBC92TxZWRRI4
	HcI0C6vpUbY566oypXNXT5JSFvZPTAo3cldKh/sZ6O81g3oT0o/aIuWsxetgvgXUMhHiA9GsgZbtk
	OUHDCJbVmibMg06j4d7p1s+Ahk54I147pY5gj6BjwC4gTv6tHZQSXpuo1hZXTLcEma9ikLay84BsY
	fTeN56w2Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kaWAi-0003rI-JN; Thu, 05 Nov 2020 03:42:48 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kaW9T-0002bw-4I
 for linux-nvme@merlin.infradead.org; Thu, 05 Nov 2020 03:41:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=hrYanscMMqunxuNP655aSSkoMzjn40xVP3IF8WdakOY=; b=mhZadFar3XufKwoTEzxw+d6eUD
 SQphqlAlvptdMRLVB5NljbBUMMZlu881oYL60SjvW5mbqvsTK7RZ9hxj20+88g9a5wBe78YeB4AOP
 A4g0mey6c4npdVpiQ26WDx2w5ku8kLXYzwXIaVw3fcORiFGAUdq4cDKnKFjonebefhQre/VK/aAVd
 +OwIDSkO6H2wvzag0I6xxtXvSbGd26wy+kZh2KJ97nRCk8dkevJIyY95D7jQhHqPljQi8716C97xX
 Z0Co0AyghPjTrFTx5sUi/7ywuK5x+YqK+4qDhF+ItArif0dLzwWeIKlySsBFbJ/nJnDsgUkrkpXJo
 vI/oxLeA==;
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by casper.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kaPYZ-0005h9-Jd
 for linux-nvme@lists.infradead.org; Wed, 04 Nov 2020 20:39:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1604522340; x=1636058340;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=gOq4RkyOZ5zQdshDMtQzCafL0419wo6OX7RnM1vXdvg=;
 b=LKPImxpuV+oE3jygm+DdAvpNkL/5yBKee2j/luvH1odV1e08Q2Ns9Pqv
 ngigJsk7X89MzHOG4tauN6bB3jhhX1R4+guHGEtNtv9GysOucMd7OsMME
 axonudV9mHzw0E/DQ+Lb2x1+HfpDcxqdULLw7OQ6lOmHO0TF9IwIiUYWO
 x63srIUfefRuw+kFujgoWh1Xj1c73/2qJWsfbpq/bUIgBdWLPQts2gJ5r
 VoNehoWRwExKNTdpKsu/xV8XbTgHIy5DJCiH+XrlohHWYvECNRY7zyjMY
 c920xuWJ8jiei5xkp7og5Yk8vmGTvOIxDJQRpmwfvmOfNeNiEmcmzbtkK A==;
IronPort-SDR: UwlI2eDtAxI3w1wiROsK8glYAUHi15AswgFSKJfJCjXMOCTKO5QZDVJ6B0eREr/28hvJei3IVd
 3OSXVLdlsBj+WIztTngipHz9SwvRRQy+A9fuOMmo6IUYudiBIyWmfPjf7qMl321iQDSeziv19f
 cTxUfMxwvQZmyS/cXjeUi+Crdjjy0Y89+ABIoAy4PsQZDJOMex4MSevMkDwLnZj487f385zFFJ
 1dcDhp7TozuuAAKBgEL/8gtO/vvOh1fEdvJt7x9O9gz8MJkqKD9ImrgUnUmnrtadGtiCeuP6ve
 VKM=
X-IronPort-AV: E=Sophos;i="5.77,451,1596470400"; d="scan'208";a="153042264"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 05 Nov 2020 04:37:56 +0800
IronPort-SDR: PXYdqtUPTmiYX8GV79+lNM3CN3ht6C1sZtytdfGDCAQdnWX9YNnARdqc45/LE2+widZCFo0U/C
 iM1p7YPapdslumjLM+QCi3RAgxHfiMh/YBBbXFqyYEelA8hSL6FEWja62EjFFCWZoP1SE/CHmP
 fOjYldKGgDLdEAHaChaxwkKRSkyHtvEgcVSEHWwctieU3pxdaZ5fL3LznW3ieYURG0Vh0I30gQ
 BYUGtaQ8q7qY/NRsPYAhgWcgiR1OqEW4AFaHfu+dN5M5qZWiqiWlhEwLXFaPRuurar48IUETdE
 DoluLtnOFW1PjWIkeOFufBWK
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2020 12:24:03 -0800
IronPort-SDR: wqn6aGkN6ASHCcKRv06YFD8NGOIwoRE7wscYxpymapvxbnaiuam7ze8AiT0XlYQ054nA+AaALP
 lp/ObDThLDVQuzzx3miN9LOK9NQahRaNpew5iohPs1uri3ubXKx70nzYy3K8u71+BCAhH5PE+x
 gGSs94j44xVDzxg356P1IxRTRUMTBcWfV++AVX7PGbLIszVM8UpOUZlrzrtLZ4VsjdmxKw2OXV
 mbzSyymPIxjjGzDFHjbFUGCcgtrSllmwckAJCcIZHcV5hUJFZBy+MpWI46FC02XGz9lVRwHIkb
 9DI=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 04 Nov 2020 12:37:55 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V6 2/5] nvmet: add passthru admin timeout value attr
Date: Wed,  4 Nov 2020 12:37:33 -0800
Message-Id: <20201104203736.62745-3-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201104203736.62745-1-chaitanya.kulkarni@wdc.com>
References: <20201104203736.62745-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201104_203900_331951_594EF47A 
X-CRM114-Status: GOOD (  20.02  )
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
of admin commands including Vender unique passhtru admin comands (VUAC).

The VUACs are used to read the large driver logs and can take longer
than default NVMe commands, that is for passthru requests the timeout
value may differ from the passthru controller's default timeout values
(nvme-core:admin_timeout).

Add a configfs attribute so that user can set the admin timeout values.
In case if this configfs value is not set nvme_alloc_request() will set
use the ADMIN_TIMEOUT value.

This attribute setting is only allowed when ctrl is disable to avoid
rcu calls in the fast path, in future when needed we can always make it
fast path friendly using RCU.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/configfs.c | 32 ++++++++++++++++++++++++++++++++
 drivers/nvme/target/nvmet.h    |  1 +
 drivers/nvme/target/passthru.c | 11 ++++++++++-
 3 files changed, 43 insertions(+), 1 deletion(-)

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
index 2905c039b479..93d48b562f6d 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -221,6 +221,14 @@ static int nvmet_passthru_map_sg(struct nvmet_req *req, struct request *rq)
 	return 0;
 }
 
+static inline unsigned int nvmet_passthru_req_timeout(struct nvmet_req *req,
+						      struct request_queue *q)
+{
+	unsigned int admin_timeout = req->sq->ctrl->subsys->admin_timeout;
+
+	return q->queuedata == NULL ? admin_timeout : 0;
+}
+
 static void nvmet_passthru_execute_cmd(struct nvmet_req *req)
 {
 	struct nvme_ctrl *ctrl = nvmet_req_passthru_ctrl(req);
@@ -244,7 +252,8 @@ static void nvmet_passthru_execute_cmd(struct nvmet_req *req)
 		q = ns->queue;
 	}
 
-	rq = nvme_alloc_request(q, req->cmd, 0, NVME_QID_ANY, 0);
+	rq = nvme_alloc_request(q, req->cmd, 0, NVME_QID_ANY,
+				nvmet_passthru_req_timeout(req, q));
 	if (IS_ERR(rq)) {
 		status = NVME_SC_INTERNAL;
 		goto out_put_ns;
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

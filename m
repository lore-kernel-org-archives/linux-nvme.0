Return-Path: <SRS0=pD35=EE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FBBFC4741F
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Oct 2020 23:48:28 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D68920720
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Oct 2020 23:48:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ySwPhEsS";
	dkim=permerror (0-bit key) header.d=wdc.com header.i=@wdc.com header.b="ZQi8HJfU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D68920720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=9L+XDnX8DkL/yiPa1AIDp/o8HYb2G/nLJV0LUjE9ME4=; b=ySwPhEsSKi+Vhlpggry9jOIQj
	zcXvfdlDLXzTIsgAYwDS1IaZmSlya2p2zMZSmrlx/cMGDnDzWFt5jimns4kewktgaw47wYHRLJVpu
	PPpVYRDV+2hymkgVxTyM43/gOZM3Pl6eEQCfmQEazkRW7T4VagdJPdmm5Km9jCfv/kszaGTdKioqH
	4mZ44xWBAayhU7ieo9Fqs0Vj6wGmd7gsISuHoRcZ74nrYjqT0Yhqicv/gNcItrWG7WbJwL5NjrtjU
	RKRTcx61Ttt6eZB2oGszFf6pB9+18nMy52LOgQTHPd70nFPWUFzVGaaoVZcbv1fE01FlLIeE4hQvy
	So3zAfI4A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kYHeb-0000JE-C4; Thu, 29 Oct 2020 23:48:25 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kYHeY-0000Hm-Tb
 for linux-nvme@lists.infradead.org; Thu, 29 Oct 2020 23:48:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1604016131; x=1635552131;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=A+ndmzn0ch9k+YEQkhGDQ3zl25ZHpUo50JnlSBZJpyk=;
 b=ZQi8HJfU5fdGJojSMq7Po9kcqlE/HkSjHmwT+MEb82WNO3p51SoUiySW
 jGm9Cm+9aDexQQzXn9ISeJZQItAD/c5th3qTFgDz2q/VEZjq+/rdDoYse
 +MkwYbDLeh3sCQ8PtNN3Z8x2yV7NhWQHa4OOsBUkYO8zVxngQ6E9UKCP5
 0Tt7XMz+yVi34IrbVjr+cOysFCG5dHt442FvFbk4HbtC5NnGQFc1Dpc+V
 BRanUEdFrjDa1Pklo62dVbrvuB3mhLQ2RMw8so5nVT52Oq/qGpS+rK4uN
 fCZKbvQ7yh/bisMwbFo2pgZ3YJS+3ugiHYZpYs/vHJLgHqkPpp9yRbjZS Q==;
IronPort-SDR: v3Kt6BcdlwOdQ2dseX0lHvo+bPtoh+u14thXgDcm6Crzf8wFBAKpPqKDx7swvW0g7MeEuHG3fp
 Rsg3+Omgaa7Da/HW1HPt3j8XCnPWvdKU3xMj38lZSCwszQjIql8Rjj+rlqVNHoS8yGFZb/zt0i
 GiwHgUhheGDJZw4vlD6Kn8zChoigvXnySggmytu1vvlIswpoYlkDTu8oLcPkacUBBNyrYkDqMm
 n4U+Y2sq9WzzLiXtP3GW4XxWTtcO6S2Lrx1SK2OiNi9RdCRnsL4zgWlhdyMI1M0/vZ9O+7nSqc
 JwU=
X-IronPort-AV: E=Sophos;i="5.77,431,1596470400"; d="scan'208";a="254830215"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 30 Oct 2020 08:02:09 +0800
IronPort-SDR: 9eHQIP2aKT0D1LODocR8rflzrhcQYbdcIWOou/8V7xrAUOBZTj6pqoe72fdyPafDdbBBhox7sx
 HPBNqkex3QmYw2j2MGL3v2tOw6xtod8ZKzjj9BM60RHTcoYHvlzK9KcCdoPVN7FTejjNbR3BuM
 RtbGVPi8EvcCwa1WTJw9ud/zB0l1tkam1x/mSVM/e6JYNxP4adFKAiNg0wTJ3RHMsvxH+ywGar
 5I9MLalgq1x/O0HGaebSBDuTAbLSOffn7Xt3xXFdtWttRpQ+1+V4gF84iaycmWMjVV+IRsUH5s
 jxoUtA1CGGmfj6/mI8eJAx35
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2020 16:33:26 -0700
IronPort-SDR: 8yumGeTxkkOl2VoxcVeGhyVDWL7DODWPRwmh/PAkRB6rYsJN7f0L/dSn5I9Jwl/VQ+9jguS5lO
 uyejzpTryn3iCWsE4lAkp4RNkBFoPxSWcjv+xzrYIpr0F2eqpTIRSmqs55m3YZqDxI2lJsrEgE
 lVh3EqM+50xQcq55WSpWcK6Gy+9MNsQm9fDAiKe0sMGpkTrt3idNUMl5ZjXfCfD9rpLC4W036a
 4UFmDNwM9AAsXVIHJhwmkJSXJZUXs1lDAKIJem8lb78MgCUSEHWvoGTGIyJ8Ku78wXuI9rNA56
 AL8=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip01.wdc.com with ESMTP; 29 Oct 2020 16:48:22 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V5 6/7] nvmet: add passthru io timeout value attr
Date: Thu, 29 Oct 2020 16:47:38 -0700
Message-Id: <20201029234739.21266-7-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201029234739.21266-1-chaitanya.kulkarni@wdc.com>
References: <20201029234739.21266-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201029_194823_128907_70B805A0 
X-CRM114-Status: GOOD (  18.67  )
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
 drivers/nvme/target/configfs.c | 32 ++++++++++++++++++++++++++++++++
 drivers/nvme/target/nvmet.h    |  1 +
 drivers/nvme/target/passthru.c |  6 +++++-
 3 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 7625f8892fb5..5beae49ba6ad 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -767,10 +767,42 @@ static ssize_t nvmet_passthru_admin_timeout_store(struct config_item *item,
 }
 CONFIGFS_ATTR(nvmet_passthru_, admin_timeout);
 
+static ssize_t nvmet_passthru_io_timeout_show(struct config_item *item,
+		char *page)
+{
+	return sprintf(page, "%u\n", to_subsys(item->ci_parent)->io_timeout);
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
 	&nvmet_passthru_attr_device_path,
 	&nvmet_passthru_attr_enable,
 	&nvmet_passthru_attr_admin_timeout,
+	&nvmet_passthru_attr_io_timeout,
 	NULL,
 };
 
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index a0c80e5179a2..2f9635273629 100644
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
index d75ca6ddf60a..177ea23561e4 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -224,6 +224,7 @@ static int nvmet_passthru_map_sg(struct nvmet_req *req, struct request *rq)
 static void nvmet_passthru_execute_cmd(struct nvmet_req *req)
 {
 	unsigned int admin_timeout = req->sq->ctrl->subsys->admin_timeout;
+	unsigned int io_timeout = req->sq->ctrl->subsys->io_timeout;
 	struct nvme_ctrl *ctrl = nvmet_req_passthru_ctrl(req);
 	struct request_queue *q = ctrl->admin_q;
 	struct nvme_ns *ns = NULL;
@@ -251,7 +252,7 @@ static void nvmet_passthru_execute_cmd(struct nvmet_req *req)
 		goto out_put_ns;
 	}
 
-	rq->timeout = q->queuedata ? NVME_IO_TIMEOUT : admin_timeout;
+	rq->timeout = q->queuedata ? io_timeout : admin_timeout;
 
 	if (req->sg_cnt) {
 		ret = nvmet_passthru_map_sg(req, rq);
@@ -553,6 +554,9 @@ int nvmet_passthru_ctrl_enable(struct nvmet_subsys *subsys)
 	if (!subsys->admin_timeout)
 		subsys->admin_timeout = ADMIN_TIMEOUT;
 
+	if (!subsys->io_timeout)
+		subsys->io_timeout = NVME_IO_TIMEOUT;
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

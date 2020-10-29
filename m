Return-Path: <SRS0=pD35=EE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38465C4741F
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Oct 2020 23:48:23 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B344A20720
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Oct 2020 23:48:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EQUzLwWa";
	dkim=permerror (0-bit key) header.d=wdc.com header.i=@wdc.com header.b="TV3YZOjI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B344A20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=pqmAgtW5HG4bR7VV4IpyyUl+We8vKHnyLDssNk2gkfM=; b=EQUzLwWalRG9XLNRWLPaaGKAC
	DAXYVZY1tS8W/UqY2+44pLLNqjtSkAUP7Er4dtUyA1GV4ShRooCXC72fCjD5V6ND6bsczu7ujMKJw
	oaDJGguYTnh96r6A/ZmesehTACb8uWz3+JZ2+Edej+CEkLaEK5veeSq5R57SooryVJIJRAWcfF3AK
	wIBC4fhu+lyTxui4rDvgIR9VqIGflXXzcUUf/AdOMKDSn9Nym2Y36DEqwpV0sjXxrpr4FSPXUNWjK
	itUVrVXvtpx8V1utpxzu4UP3mzGbq8BqvRgqsON+cv8Vzfv/wuHqSfoBEdbk4fXN5CwmsEGreh9i9
	dv0qEfVvg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kYHeV-0000Gr-TG; Thu, 29 Oct 2020 23:48:20 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kYHeS-0000Fv-JO
 for linux-nvme@lists.infradead.org; Thu, 29 Oct 2020 23:48:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1604016121; x=1635552121;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Mg4OXFXx5dil+9WDpuZtVGT4wtNId9m8qC36UV4kiTs=;
 b=TV3YZOjIKzCzPQxLCKDqa/90UjkTzqHOKkKD1blqEjaD2ZKGEkSxLCN0
 cxhGZoqQXVhTUGKns1ehNM61oEaQa/iPJhcmwrmQGxbObovHYcDZK7A+V
 L73W0jHEsRt5zgqI4vBqh7Kvzi9AIF0V9jo2PJqQ8i5lucDf0lGNZYfoX
 spm+HFL51optMuoT4xTZABM4N4SxvhqwdQSbLViL5Sd+kUJXObi8GWRP0
 JbPCxZ5Cd2O8rGBAwpwTYtBr/RXj7gDksdKbxEDMAeqYJHw7kUY5xu8VK
 gqWpvwLPheI+K+RAJcPHOORT4SCU/7JOVrrphkXrBOPwP2Ft20f+KAko+ g==;
IronPort-SDR: wIeURzsXDlT++4fp0CgpEFid5AFuuM/Oh+Tbr/t7Ho4GHmOtFDnMUEIHvRKBkKaaYU84xtcz8K
 AE/HW1MrGs/Eucut5WIVYCXxO1aV+kZNp7uiZovSAcS5gW84xVAzfoHAsBYih9jzAqryVBzHTM
 SeMQYwqcJF5HKYZv1aGlH3OUiAatswRQG01dhfYL2pSWB0c/uawHBzMdXR4eam+jqpvjqIjX33
 8B/UPpHWt9za0saJPeerAMEWKVNPzgxF/A8xJMi4a+jz2fYKO/TQiO1o2kGeGCrqlPWkY7NNzZ
 dgQ=
X-IronPort-AV: E=Sophos;i="5.77,431,1596470400"; d="scan'208";a="254830206"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 30 Oct 2020 08:02:00 +0800
IronPort-SDR: id/oEgvCTr/ofTkK61bmwGGDowjc2CyklOJ+bkZGVPeLFg4ATEIg5bxuNIPV/Z/gPYHVcPNGPh
 gdgB06NEwF3QhrliISZTSgbGMoM6vW5AU47a36Fh/3619t8j3q5d/U+/6QFd507O0+acEUICzi
 ZeJxiCRTpyQkPu+Q0+5C9Wjjgl/NJAVlQCj1LoAU4QJ2kFE4U9Lp/4iEA0R7iucaWfYkLJkfkI
 +uy6q8WkVOwLbfWVSVRyUKrYGMV6v4n21E1wwsT+NEeAxWxgaE/nkTedfQnk2zp9QNRomIoXZX
 7FF4bzIX4agHPlFX8PJUeoal
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2020 16:34:30 -0700
IronPort-SDR: 9oZpOp2K4vBlbaCleAFEMZrAPZFu+XK5dMTL0k63RmmOmnl9ZoUdKVEkIU5VgusXe2HXvWyiDc
 SyZcsARYI94NqnyXzLt/JnWqY8lysJeUy2BogBfbvWI/s2usbkysWjWxqEJ+IDSDqF9Qyu4lz/
 X2Zqbv8IU4JS/ykCJ60kuxjrHMBJGWNZW1OyeN78HdpL+HtUcfxvhusJHFQl+vDnWQkg8X9GV6
 6xz0CRyrPE+TfKp+q141acA0yQgpbUtl3r9mmw+a/JfJStkOlx6bjJEXAke2LA7ii5ma/TyMh/
 Muk=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip01.wdc.com with ESMTP; 29 Oct 2020 16:48:16 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V5 5/7] nvmet: add passthru admin timeout value attr
Date: Thu, 29 Oct 2020 16:47:37 -0700
Message-Id: <20201029234739.21266-6-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201029234739.21266-1-chaitanya.kulkarni@wdc.com>
References: <20201029234739.21266-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201029_194816_803644_251170F7 
X-CRM114-Status: GOOD (  19.18  )
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
index da23485352d2..d75ca6ddf60a 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -223,6 +223,7 @@ static int nvmet_passthru_map_sg(struct nvmet_req *req, struct request *rq)
 
 static void nvmet_passthru_execute_cmd(struct nvmet_req *req)
 {
+	unsigned int admin_timeout = req->sq->ctrl->subsys->admin_timeout;
 	struct nvme_ctrl *ctrl = nvmet_req_passthru_ctrl(req);
 	struct request_queue *q = ctrl->admin_q;
 	struct nvme_ns *ns = NULL;
@@ -250,7 +251,7 @@ static void nvmet_passthru_execute_cmd(struct nvmet_req *req)
 		goto out_put_ns;
 	}
 
-	rq->timeout = q->queuedata ? NVME_IO_TIMEOUT : ADMIN_TIMEOUT;
+	rq->timeout = q->queuedata ? NVME_IO_TIMEOUT : admin_timeout;
 
 	if (req->sg_cnt) {
 		ret = nvmet_passthru_map_sg(req, rq);
@@ -548,6 +549,10 @@ int nvmet_passthru_ctrl_enable(struct nvmet_subsys *subsys)
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

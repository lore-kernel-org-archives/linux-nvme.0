Return-Path: <SRS0=ZUg+=YX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F2ACCA9EC5
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Oct 2019 19:49:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52FF820717
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Oct 2019 19:49:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lyW0rjxJ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="QPHKsyJg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52FF820717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=BxtWQVaCQkmBfWLcZUVQ4qYui51pu9Zx7ZOH9vbUuFY=; b=lyW0rjxJq4orHH
	V4HZhimzu+jn+IPn6BM8mjKOWntCO/6+oYf0VK1M4/xHX++RA1hWGanR4mZkti8J4ddPUsPUATr6C
	cxAr7O//VIHpkuujsE1onDflscxeNs4TK4ZlrWmEmqpCaLxQzUJtKsWjeHERVOMQD1xb91Dq73V6t
	oU5ezEL1jOQSGLbXGy6DnKqEzvHjHXqwmJGE/uMujYpgBKistYPR9iuIhS2Ck+jRqBtO3oRaSuvmz
	EEghtAQm0V8wUx4+K6T2V3Yx5osQ8cphB21XDg0Mn2OQKKBqjnjX1KZAfYZt7eWkyrZBoZEF12/9M
	fLS0F6BtvEP0Cqvx4/cA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iPtxr-00086N-HX; Wed, 30 Oct 2019 19:49:07 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iPtxo-00085t-As
 for linux-nvme@lists.infradead.org; Wed, 30 Oct 2019 19:49:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1572464945; x=1604000945;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=dN8/5wVXvidWFDt0sDm7Cql2XxRm0VsyXXCyij+NfoU=;
 b=QPHKsyJg2GuHYKNbn5NZ3TKmvO3ipZwwEw84mLIXVpcthZccjoylxNj1
 sW3b9VkrpO1lFuLUw438bxSZ1ugfypkYaJyYM8i274bqtTaaPdjy8IyCc
 IOJxjX7rwVlW79KxSJ8D74FUHUkc+YfS5I1QTOAa0iM/5deQdC3ceZLJy
 BBuYLwQ7GRnPDGUcIrUqtiX5r8SfZhm2LWegIGHWq3jtnkIKoJLJymEXi
 3hYjB7d8mtJCazfOTOj2L+bay7n/lL3WKBTx0ixhqC3Yo9Kk7Ak7vbuWT
 jWerwhtg9QNBdxsV1r3MBPycLFCQ5amXN06WCkOvXHwUg1MOPmIuHaJAm g==;
IronPort-SDR: iEDAFHRKY4gLZJRwe+byy6JMANgVPnt0FKuCn7NixuBBP8SjzfTKF4NxIDkEtu7vN2d68BJ/Ge
 bZk1xnt6nODBMadlQtdb+TkjFAizqF2kGyjor92R4Ew/ZWPdh8IgwScOOBsPVIPTkzOR13Fjsb
 KZZweYWPVcQvlPOE9P2AmZ0HT3Z+R+mQ7mOnmN1Ij9lLf9rkbOdrJ/Gw7n0v0tSQNvYzWnoO/V
 yzYcc6h+CTfCpX7mQdTCjxhdOeAO6YkKMFce2ulYIdYKxFFMpCGoBTF+TE7McXh41gI2aA0mZu
 okw=
X-IronPort-AV: E=Sophos;i="5.68,248,1569254400"; d="scan'208";a="126145485"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 31 Oct 2019 03:49:00 +0800
IronPort-SDR: 6Y/MSd3/WDDkPCfNHVJVjBEmhHdsSNBVR4sIUiVN617txgrXgGy7UL4zKxcJsUJB7A2tSnNTVL
 8WLIttgW/FFJwX6m1Anm4U/wARlKatlf2B4dbBSuOp0yt/a3ONJkuSQslfQth3eD12WVoDwYa4
 ZHilglT2dXIzFUp3ime7wgz4oZhP0rNbI/TPsMKq/v6+unyhGikPu1kEbAqEwl1FEtUL5UOQCT
 D99Wh3KNoBVcXfDUyztOO8z1ARhAiq9qncvd4cE+nfPb2xI4nSmFBFfKjdWEnyPU2llYy9IT1h
 D/Bm+6Bfe9Xknk/hPxY9tFwO
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2019 12:44:23 -0700
IronPort-SDR: JgzMmio6bmpOGhglUj2oRa+3Eu0LUhg45OSx6pRbL+5yTJxvrx8CaboGv/ahAxi8rBxt3WjtnM
 q0328w+tziCw+d6xFqmgQ3zHP15BTc2DPCDEZ7rl4uLFfpINRZK5IUrcSf9MqT5FHiSikzDELN
 6D5NUqLx/8+AzdSYKa4iniZMLmns2GT5LPrxgNEtQquX2ZUOxOLOcd5h4tYGCJxAVFrkCsR6X4
 DUbzanSY37o75s+LFIdQS9BRaTQ4VoLpcw6alHL4513ucB0yR9yaTXAOh1sdyEQGy0HqES+GDK
 a3M=
WDCIronportException: Internal
Received: from cvenusqemu.hgst.com ([10.202.66.73])
 by uls-op-cesaip01.wdc.com with ESMTP; 30 Oct 2019 12:49:00 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH] nvmet: make ctrl model configurable
Date: Wed, 30 Oct 2019 12:48:58 -0700
Message-Id: <20191030194858.30788-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191030_124904_404956_2C5A3E9B 
X-CRM114-Status: GOOD (  13.31  )
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
Cc: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This patch adds a new target subsys attribute which allows user to
optionally specify model name which then used in the
nvmet_execute_identify_ctrl() to fill up the nvme_id_ctrl structure.

Default value for the model is set to "Linux".

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/admin-cmd.c |  4 ++--
 drivers/nvme/target/configfs.c  | 29 +++++++++++++++++++++++++++++
 drivers/nvme/target/core.c      |  6 ++++++
 drivers/nvme/target/nvmet.h     |  2 ++
 4 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 56c21b501185..917d8f3fded7 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -315,9 +315,9 @@ static void nvmet_execute_get_log_page(struct nvmet_req *req)
 static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 {
 	struct nvmet_ctrl *ctrl = req->sq->ctrl;
+	const char *model = ctrl->subsys->model;
 	struct nvme_id_ctrl *id;
 	u16 status = 0;
-	const char model[] = "Linux";
 
 	id = kzalloc(sizeof(*id), GFP_KERNEL);
 	if (!id) {
@@ -332,7 +332,7 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 	memset(id->sn, ' ', sizeof(id->sn));
 	bin2hex(id->sn, &ctrl->subsys->serial,
 		min(sizeof(ctrl->subsys->serial), sizeof(id->sn) / 2));
-	memcpy_and_pad(id->mn, sizeof(id->mn), model, sizeof(model) - 1, ' ');
+	memcpy_and_pad(id->mn, sizeof(id->mn), model, strlen(model), ' ');
 	memcpy_and_pad(id->fr, sizeof(id->fr),
 		       UTS_RELEASE, strlen(UTS_RELEASE), ' ');
 
diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 98613a45bd3b..e91ebe74c938 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -862,10 +862,39 @@ static ssize_t nvmet_subsys_attr_serial_store(struct config_item *item,
 }
 CONFIGFS_ATTR(nvmet_subsys_, attr_serial);
 
+static ssize_t nvmet_subsys_attr_model_show(struct config_item *item,
+					     char *page)
+{
+	struct nvmet_subsys *subsys = to_subsys(item);
+
+	return snprintf(page, PAGE_SIZE, "%s\n", subsys->model);
+}
+
+static ssize_t nvmet_subsys_attr_model_store(struct config_item *item,
+					     const char *page, size_t count)
+{
+	struct nvmet_subsys *subsys = to_subsys(item);
+	int ret = 0;
+
+	down_write(&nvmet_config_sem);
+	kfree(subsys->model);
+	subsys->model = kzalloc(PAGE_SIZE, GFP_KERNEL);
+	if (!subsys->model)
+		ret = -ENOMEM;
+	else
+		sscanf(page, "%s\n", subsys->model);
+	up_write(&nvmet_config_sem);
+
+	return ret ? ret : count;
+}
+
+CONFIGFS_ATTR(nvmet_subsys_, attr_model);
+
 static struct configfs_attribute *nvmet_subsys_attrs[] = {
 	&nvmet_subsys_attr_attr_allow_any_host,
 	&nvmet_subsys_attr_attr_version,
 	&nvmet_subsys_attr_attr_serial,
+	&nvmet_subsys_attr_attr_model,
 	NULL,
 };
 
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 28438b833c1b..d3e2a1f58a93 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1394,6 +1394,11 @@ struct nvmet_subsys *nvmet_subsys_alloc(const char *subsysnqn,
 		return ERR_PTR(-ENOMEM);
 
 	subsys->ver = NVME_VS(1, 3, 0); /* NVMe 1.3.0 */
+
+	subsys->model = kstrdup(NVMET_DEFAULT_CTRL_MODEL, GFP_KERNEL);
+	if (!subsys->model)
+		return ERR_PTR(-ENOMEM);
+
 	/* generate a random serial number as our controllers are ephemeral: */
 	get_random_bytes(&subsys->serial, sizeof(subsys->serial));
 
@@ -1435,6 +1440,7 @@ static void nvmet_subsys_free(struct kref *ref)
 	WARN_ON_ONCE(!list_empty(&subsys->namespaces));
 
 	kfree(subsys->subsysnqn);
+	kfree(subsys->model);
 	kfree(subsys);
 }
 
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 46df45e837c9..d5fcfd09658e 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -23,6 +23,7 @@
 #define NVMET_ASYNC_EVENTS		4
 #define NVMET_ERROR_LOG_SLOTS		128
 #define NVMET_NO_ERROR_LOC		((u16)-1)
+#define NVMET_DEFAULT_CTRL_MODEL	"Linux"
 
 /*
  * Supported optional AENs:
@@ -227,6 +228,7 @@ struct nvmet_subsys {
 
 	struct config_group	namespaces_group;
 	struct config_group	allowed_hosts_group;
+	char			*model;
 };
 
 static inline struct nvmet_subsys *to_subsys(struct config_item *item)
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

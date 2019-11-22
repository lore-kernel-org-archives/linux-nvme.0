Return-Path: <SRS0=ia7R=ZO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE10CC432C0
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Nov 2019 07:42:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EE7B20708
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Nov 2019 07:42:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Uj8QFEM8";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="lgHN2v+H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EE7B20708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LBGUbXtX1cti35pD/ViBdrXRq7jUeUtrdGdVBC+awuc=; b=Uj8QFEM8/q7VTl
	7dyzF8RXv91T2pPWRAUojQ2EdL1z9r0s3Z12+Op6p6CmzhETtBQ2tpoHsdPy2BeGVAv54CHLePzJC
	FDqv3WcL1zNwbmmRcW4Pz5DbHo0LEWql2xL2PaaYxSFbiMackUdZ8dDLb8xdl2o3uhRONCx0pmfpj
	M9GtKdLs3VF93j687sXXbgpFF9BbOO47IDL5SYSgjP2FcWtIPvhlGqmdWjetDdurL0MM05vAvCwAB
	1e09VRKBna2AHpgQvlCr1iQZUA1d06iFvV2p5QzoHCD/5tPrIw8+J5aVnfUzBN3f/clJsed2NTqhN
	YlybhscD2srNPiemN63A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iY3aG-0003lw-W1; Fri, 22 Nov 2019 07:42:29 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iY3Zo-0003ML-H7
 for linux-nvme@lists.infradead.org; Fri, 22 Nov 2019 07:42:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1574408520; x=1605944520;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=RiKb9B43ne9pe27bCbCoD60teDIV977wLDIHo7Jdb1I=;
 b=lgHN2v+HlEzeRdEUuI/OoppLB8atmXM8lYRb2XxY8f8R7og1PyndeRXS
 mEgaoGyR+B5aPbrsfyGlB6Y9m4d1GXsPH+UEKBKgNMwCkKDKhlqtlH1Zf
 BPGySLm5Nt3hsYNDvxaL+TaCuevyq51PdU2L0sz0PYVLkLNtgqOax8a3M
 rP13xZ7TzGAwIJKSiskl1kkg+fRvvJRJILgmn0OYaeF+nnjkSgyRNg/0m
 yQmpSxqemEQqK05k29iORb8+TfyX5mHqecirtxvBqVCcN7xffXVfJuvIu
 tCushSFZsNSlWzK32tnspCOy6jxRtYnlFERO8OO9v6F9Hev1u3TZTw/x0 g==;
IronPort-SDR: d4VvrJ2LggwNhEWE9039E0QSCQjZCHvfjzIjaFmxkuchbKHy8azsCibXOJVcFV+upUsHP1BYC7
 /VXNqd3j8yTRqTawx+GMv/yWWKuEGKe+xMHjzqSYDilQb8zIxqa1ZlpjHa5MY9J63RBCvj9ouW
 tkjc7GDlxDugdtVW3DRxEt9BFX9luFz5Z4KdWFeUPeJywDVvtmptcYY7AoYFz7aHo0G+o3TwH0
 XR3bkukEro0KVHfrlVJhIBJHnUHV0gG8gQ8we/A6wZf3mDRO9SDMsnvddfcavDmuYqgGJqT5Q/
 qEc=
X-IronPort-AV: E=Sophos;i="5.69,229,1571673600"; d="scan'208";a="231139193"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 22 Nov 2019 15:41:59 +0800
IronPort-SDR: 0W55KZOfxVBmAIqUp0qc7/HRVrLfn0CfNDQ7ZPzjuRtr14w9Sk78ISSb1/91fGZFQXqz9l0fHz
 JGpOMklo9h2aF6X5yOx+eiQIMK4rYaw1lqbnAYtzOwb6zkSYvN+DJtsno+I5EvkC//pRCKijLi
 T4J+fTn0Jv0nF2NbNuzZMsuEdXuK/OOCrDmafGlUslAhpg16QNtn6AIhCaj2dylzMgkCruFsMc
 ODgEe4oXP7udSYsUssXtuS3L8NdhF74uvhciTn25H0J5kkZoH8QWsHLvYjUIt9QtSq+Wkr4N9x
 QKpkLS2SQAqNtzXieI0IRXXm
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Nov 2019 23:36:45 -0800
IronPort-SDR: yZDL8d3s+XRmrOaLmpTwqlZrCfDfAtYcftx98aYdzYYTZun4ictnj/IpQ3d4xaWIkaaZ8zH4dR
 SSW6NX3o1i9C4WHYyunXE96lOojijzwiCAc+mksuZaHlcvHD/xpDAhYWOE3ZQ8K8oyZ1XVBrbw
 QfqixDiX/alG0JjE27YBja2TPIn4Pq26N/27r+py67oEtUY7LD2kmiVjpRhTyP5dfGavPcg26Z
 D0PQdWB97N4b/iyv+CnsqUDswzFtpiD0s2uQfFjM3roJ2QGOMJBWyI3dhhYWaOWk6/w4CW/xyj
 b40=
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com)
 ([10.6.138.107])
 by uls-op-cesaip01.wdc.com with ESMTP; 21 Nov 2019 23:41:59 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V3 2/2] nvmet: make ctrl model configurable
Date: Thu, 21 Nov 2019 23:41:54 -0800
Message-Id: <20191122074154.12159-3-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20191122074154.12159-1-chaitanya.kulkarni@wdc.com>
References: <20191122074154.12159-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191121_234200_576281_B241511E 
X-CRM114-Status: GOOD (  15.94  )
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
Cc: Mark Ruijter <MRuijter@onestopsystems.com>, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Mark Ruijter <MRuijter@onestopsystems.com>

From: Mark Ruijter <MRuijter@onestopsystems.com>

This patch adds a new target subsys attribute which allows user to
optionally specify model name which then used in the
nvmet_execute_identify_ctrl() to fill up the nvme_id_ctrl structure.

The default value for the model is set to "Linux" for backward
compatibility.

Signed-off-by: Mark Ruijter <MRuijter@onestopsystems.com>
Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
Changes from V2:-

1. Use if else pattern than ternary operators.
2. Change the name nvmet_subsys_model() -> nvmet_model_number().
3. Introduce nvmet_is_ascii() to filter the model characters.
4. Change tmp -> tmp_model in nvmet_subsys_attr_model_store().

Changes from V1:-

1. Don't allocate memory for default subsys model,
2. Use helper to get the default model string from ctrl->subsys in the
   nvmet_execute_identify_ctrl() and nvmet_subsys_attr_model()_show.
   Later is needed so that nvmetcli can display default value Linux
   when the model is not set from the user.
3. Get rid of the extra variable c in the nvmet_subsys_attr_model_store()
   and replace for with while loop without loosing the code redability.
---
 drivers/nvme/target/admin-cmd.c | 12 ++++++--
 drivers/nvme/target/configfs.c  | 50 +++++++++++++++++++++++++++++++++
 drivers/nvme/target/core.c      |  2 ++
 drivers/nvme/target/nvmet.h     |  4 +++
 4 files changed, 66 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 56c21b501185..613e715dc7d3 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -312,12 +312,20 @@ static void nvmet_execute_get_log_page(struct nvmet_req *req)
 	nvmet_req_complete(req, NVME_SC_INVALID_FIELD | NVME_SC_DNR);
 }
 
+const char *nvmet_model_number(struct nvmet_subsys *subsys)
+{
+	if (subsys->model)
+		return subsys->model;
+
+	return NVMET_DEFAULT_CTRL_MODEL;
+}
+
 static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 {
+	const char *model = nvmet_model_number(req->sq->ctrl->subsys);
 	struct nvmet_ctrl *ctrl = req->sq->ctrl;
 	struct nvme_id_ctrl *id;
 	u16 status = 0;
-	const char model[] = "Linux";
 
 	id = kzalloc(sizeof(*id), GFP_KERNEL);
 	if (!id) {
@@ -332,7 +340,7 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 	memset(id->sn, ' ', sizeof(id->sn));
 	bin2hex(id->sn, &ctrl->subsys->serial,
 		min(sizeof(ctrl->subsys->serial), sizeof(id->sn) / 2));
-	memcpy_and_pad(id->mn, sizeof(id->mn), model, sizeof(model) - 1, ' ');
+	memcpy_and_pad(id->mn, sizeof(id->mn), model, strlen(model), ' ');
 	memcpy_and_pad(id->fr, sizeof(id->fr),
 		       UTS_RELEASE, strlen(UTS_RELEASE), ' ');
 
diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 5316cdb1b271..00869b805c6b 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -925,12 +925,62 @@ static ssize_t nvmet_subsys_attr_cntlid_max_store(struct config_item *item,
 }
 CONFIGFS_ATTR(nvmet_subsys_, attr_cntlid_max);
 
+static ssize_t nvmet_subsys_attr_model_show(struct config_item *item,
+					    char *page)
+{
+	struct nvmet_subsys *subsys = to_subsys(item);
+
+	return snprintf(page, PAGE_SIZE, "%s\n",
+			nvmet_model_number(subsys));
+}
+
+/* See Section 1.5 of NVMe 1.4 */
+static bool nvmet_is_ascii(const char c)
+{
+	return c >= 0x20 && c <= 0x7e;
+}
+
+static ssize_t nvmet_subsys_attr_model_store(struct config_item *item,
+					     const char *page, size_t count)
+{
+	struct nvmet_subsys *subsys = to_subsys(item);
+	int ret = -EINVAL, pos = 0, len;
+	char *tmp_model;
+
+	down_write(&nvmet_config_sem);
+	len = strcspn(page, "\n");
+	if (!len)
+		goto out_unlock;
+
+	for (pos = 0; pos < len; pos++) {
+		if (!nvmet_is_ascii(page[pos]))
+			goto out_unlock;
+	}
+
+	tmp_model = kstrndup(page, len, GFP_KERNEL);
+	if (!tmp_model) {
+		ret = -ENOMEM;
+		goto out_unlock;
+	}
+
+	ret = count;
+	kfree(subsys->model);
+	subsys->model = tmp_model;
+
+out_unlock:
+	up_write(&nvmet_config_sem);
+	return ret;
+}
+
+CONFIGFS_ATTR(nvmet_subsys_, attr_model);
+
 static struct configfs_attribute *nvmet_subsys_attrs[] = {
 	&nvmet_subsys_attr_attr_allow_any_host,
 	&nvmet_subsys_attr_attr_version,
 	&nvmet_subsys_attr_attr_serial,
 	&nvmet_subsys_attr_attr_cntlid_min,
 	&nvmet_subsys_attr_attr_cntlid_max,
+	&nvmet_subsys_attr_attr_model,
 	NULL,
 };
 
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 990ad4c7bdfd..a985ca7febd5 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1419,6 +1419,7 @@ struct nvmet_subsys *nvmet_subsys_alloc(const char *subsysnqn,
 		kfree(subsys);
 		return ERR_PTR(-ENOMEM);
 	}
+	subsys->model = NULL;
 	subsys->cntlid_min = NVME_CNTLID_MIN;
 	subsys->cntlid_max = NVME_CNTLID_MAX;
 	kref_init(&subsys->ref);
@@ -1439,6 +1440,7 @@ static void nvmet_subsys_free(struct kref *ref)
 	WARN_ON_ONCE(!list_empty(&subsys->namespaces));
 
 	kfree(subsys->subsysnqn);
+	kfree(subsys->model);
 	kfree(subsys);
 }
 
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 6492d12e626a..c54ce5f66f09 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -23,6 +23,7 @@
 #define NVMET_ASYNC_EVENTS		4
 #define NVMET_ERROR_LOG_SLOTS		128
 #define NVMET_NO_ERROR_LOC		((u16)-1)
+#define NVMET_DEFAULT_CTRL_MODEL	"Linux"
 
 /*
  * Supported optional AENs:
@@ -224,6 +225,7 @@ struct nvmet_subsys {
 	u64			ver;
 	u64			serial;
 	char			*subsysnqn;
+	char			*model;
 
 	struct config_group	group;
 
@@ -489,6 +491,8 @@ u16 nvmet_bdev_flush(struct nvmet_req *req);
 u16 nvmet_file_flush(struct nvmet_req *req);
 void nvmet_ns_changed(struct nvmet_subsys *subsys, u32 nsid);
 
+const char *nvmet_model_number(struct nvmet_subsys *subsys);
+
 static inline u32 nvmet_rw_len(struct nvmet_req *req)
 {
 	return ((u32)le16_to_cpu(req->cmd->rw.length) + 1) <<
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

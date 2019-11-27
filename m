Return-Path: <SRS0=HRbs=ZT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EE66C432C0
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Nov 2019 09:41:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D87F20678
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Nov 2019 09:41:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OHa8QDxg";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="f2Mzdu0q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D87F20678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=z0LmWVyK0sjDqGgezzDlhgL5KgwqLXrj71F3+u69NFs=; b=OHa8QDxgB6glf6
	HToMfJQlLd2JD3cWmBCdFdQfoCzJS0DyeCQ3F9ae7EA/N0QJZ2ZYLM1G9Hpi9uVzdNu0nkdSycc5I
	2YBpZ9eHRmSRsJLVGr8LX0hoKQeXyGHMscci2IA8dwnWprUkUNl03UZjMqoppmtpU7R36chKGJLwl
	mdaUsc/GB4Hgcl4wEjW7He2A4dV+bVjZmHEhMJhDvyJHJvL61N2rwxodr5cKYh4BmfOaHX/Tzp05L
	fE+DYEQ7OSnrv2eC5WOD8JGdMiAbPp+uoC61pG5vJ0cEhXbvmI9QHcgbmXSy3LR/JQoWNqSBsqwt5
	ZDqsd3AISExgGVqzm0Sw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iZtos-0004x1-OR; Wed, 27 Nov 2019 09:41:11 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iZtoQ-0004Ye-Sm
 for linux-nvme@lists.infradead.org; Wed, 27 Nov 2019 09:40:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1574847644; x=1606383644;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=u5Rp1s+uhJYi2VR1VgQiWGHGoB393C6fNqXqD/2qq9A=;
 b=f2Mzdu0q3TrrBX3RG4t52AMDWk9MLClKCRQo4jM1hk8skJSn0A7HvorZ
 b9nIEKVJeLz2X4+HpXEIsroJyAYuB224n9a7r17eqNb+Z0ZO+oyCzIhfC
 1SJsI6c/b4pgEr89qThfLCwsWUGIqyrbbriHPnQ0src5qVdo115YWfHNd
 fec9bikj9Jl8LnMLKdzw6SfT16gqWQftW4uzDnnl69co25pIWYnIM0rMX
 ktuc3yh84paIL276UGflp9g/KrYlTqCP28rzgT2/Gt97FTCadzSdkrj5G
 8CBaBnC18k03Ut4RVSAJDsWbcfhpekhWBk+0hS74EA4/7euP1HBFLSTl9 A==;
IronPort-SDR: NKB8V2bDuQTmtU4RnWso3sgGtnvMl+QqFtSZucV6/1uwvkV3UaRP+q/mT2mfYd6HLU9OqQSvyU
 AwXB2MgCkBRsjwpc46UsrHFRtnbWWZ05NxOe4QC+cCbwkXIIBlCgdvkQRumPvUMam/aN7rIy3o
 wTsDX9dcz8tf81ZUDXMzPEHP0EFOg5COp1G78xl0x7yKDQVN5BwfUKjFiUh3LWsZiuT/+tQH/u
 7akVDvODL0fAlAhdCUOVaAJtH4tNr3/8rbm0jjAUV/jGt5T/TPFggiEP5mh2AerK/zkwgoG2UY
 Qx4=
X-IronPort-AV: E=Sophos;i="5.69,249,1571673600"; d="scan'208";a="124872969"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 27 Nov 2019 17:40:43 +0800
IronPort-SDR: X3I3ToTm4GNI9auMJu4/I0ALy3fABoQGq52/BhIfG9b6uq3P34yyGAV1sdThp6krNPd3ERNzlU
 qH/iQzeIuwfRw1pXYeaEP1jqaTcpyHcuzSEHY1RB82s08zjXvv2k5WE15oVEnl8AnheraI61v7
 LI2aiYDjgLAi328YlbU0YBtlGRKU0p7Ow2wPMjdI0zDVRB6Zp4nyr3O8HdwnfBqRcQPip8Tqy5
 /pF2IG4/d6JNRsrtHgZVlOCu8bxUugOMUrrlvH9koCHwqBhxfwxvkhJqSnNTdNZ4HucQ4um1Xa
 +W8/MCrddIfE8LgUSzGO6OoT
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Nov 2019 01:35:41 -0800
IronPort-SDR: QsYU/UMRAbRtXfR1w+PxLKnYFa/qCDZ51HQ5usgKCtb3dd4DEZcORWxaoG4HjUk/e1REg4odL0
 isb9i02GHl9r5PjaC/B8jkSVpGrXUlj3+ftklukgKd/zg9pZnPMasdQn6jprqZf1wUZeZxQA5t
 oo3jLI9ULqtG3vyCd0wQv2pjEHlM8uA+vNt606R06xOBzufVSdRkCdICEK/C5VEZ1d8UVmK1de
 zyfOzFztZCPvaAlWgruabhu8VcGxhrDGUFW//83/RR5O9P0UtiL4Z1nbQ6KEeu23I6YMglCDk4
 D+E=
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com)
 ([10.6.138.107])
 by uls-op-cesaip01.wdc.com with ESMTP; 27 Nov 2019 01:40:42 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V4 2/3] nvmet: make ctrl model configurable
Date: Wed, 27 Nov 2019 01:40:33 -0800
Message-Id: <20191127094034.12334-3-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20191127094034.12334-1-chaitanya.kulkarni@wdc.com>
References: <20191127094034.12334-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191127_014042_966940_F2C38D8A 
X-CRM114-Status: GOOD (  16.42  )
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
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Mark Ruijter <MRuijter@onestopsystems.com>

This patch adds a new target subsys attribute which allows user to
optionally specify model name which then used in the
nvmet_execute_identify_ctrl() to fill up the nvme_id_ctrl structure.

The default value for the model is set to "Linux" for backward
compatibility.

Signed-off-by: Mark Ruijter <MRuijter@onestopsystems.com>
[use macro for default model, coding style fixes]
Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
Changes from V3:-

1, Update commit description with additional changes on the top of
   original patch.
2. Reduce the size of the lock in nvmet_subsys_attr_model_store().
3. Don't initialize subsys->model = NULL nvmet_subsys_alloc().

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
 drivers/nvme/target/admin-cmd.c | 12 +++++++--
 drivers/nvme/target/configfs.c  | 46 +++++++++++++++++++++++++++++++++
 drivers/nvme/target/core.c      |  1 +
 drivers/nvme/target/nvmet.h     |  4 +++
 4 files changed, 61 insertions(+), 2 deletions(-)

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
index 772a74a7d969..4dea77a7da3e 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -932,12 +932,58 @@ static ssize_t nvmet_subsys_attr_cntlid_max_store(struct config_item *item,
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
+	int pos = 0, len;
+	char *tmp_model;
+
+	len = strcspn(page, "\n");
+	if (!len)
+		return -EINVAL;
+
+	for (pos = 0; pos < len; pos++) {
+		if (!nvmet_is_ascii(page[pos]))
+			return -EINVAL;
+	}
+
+	tmp_model = kstrndup(page, len, GFP_KERNEL);
+	if (!tmp_model)
+		return -ENOMEM;
+
+	down_write(&nvmet_config_sem);
+	kfree(subsys->model);
+	subsys->model = tmp_model;
+	up_write(&nvmet_config_sem);
+
+	return count;
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
index 387628ec7e37..c041d88ed3ea 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1436,6 +1436,7 @@ static void nvmet_subsys_free(struct kref *ref)
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
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

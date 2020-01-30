Return-Path: <SRS0=3CeD=3T=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_DBL_ABUSE_MALW,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EE36C2D0DB
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Jan 2020 18:30:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 439DB20658
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Jan 2020 18:30:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FJRywDPb";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="R3dDUXYi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 439DB20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ryGK1BKHuFSaNpQBKAEWhB8Hia9ZPhnxcOPRiZzeKLo=; b=FJRywDPb1cr1Kn
	1RTQ6kh3upG0jhQj/8kQr7PbLaP8885GdJcQDDh3wO3CJwXj44413hkByzc8VKHeNLbWn/Ku0RFWN
	+ZB9aYqwygfXpB5UT5Rn3mDthb6C0VKsM4Rbrj0J/kVY4RMz/MG+ggkDjK35o6ddPsR6VlfE2rQYJ
	WGAHPF/GNRZF4890x5PsCwljAXktzjC+Up/VOig+LXEVqDR138lJwPXDKkFU9ur+oWI2f9alSX+kb
	DVKmpTS7YQ61HbiCIrEBQ9gupeg3QCeJ1c77EZ83Z2/pMFr6w7C/XouL0utKoZLmmzXZ15MnqohVI
	GMj4H5P5W8qfFcqfkeow==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ixEa0-0006YI-4Z; Thu, 30 Jan 2020 18:30:16 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ixEZb-000531-6e
 for linux-nvme@lists.infradead.org; Thu, 30 Jan 2020 18:29:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1580408991; x=1611944991;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ObVDGWG1sV0Ft856aogOwR0IpabwTyvjextdVETAqvw=;
 b=R3dDUXYifAeowChmOrTUIUP1Q9usfPnDqjeYwzhrJ72SAzqJiatc+ygI
 XBYB5C3D/opj9+7P7yHxmcNTdUlsI5bzcs0nEJEeGXofRLDuoVKtN4vou
 7Sors5laZGK5Z1JV4SksLQm5GX0N6EPLSS/uQCPPNXoi0xZSc2B92i5Zk
 JtiQY0oCOyoas4pbmQ/8zH8e5/XfTnF7QHqXM0jJRSWf8XgN0BxC8XzZC
 QxwweLeaePuPEqFLBLWIbgWYUadedK/TZ59o9JcwIiLpn3VhMmmXQtneB
 N8Zu46xdtvW1vjc6cuuFv9+hGcpBTPCZXOZbcUJOp9zifsVx73PAlPlvN g==;
IronPort-SDR: lNG9YzBhWPpMM1dt0JpVeNhyXVkqbBrat64OM0tSgKVtu+SxFLvvDnMATIWiucLCAMidYgLVFC
 hU6MrGAprWxm13uQchFry0N5IbHBR+5RTCkvxQOANtTOaHj0YsT4KJXCD7vv3JcB2aNCyw+AxX
 K63lg0hY1JI5kQDFCxvxpFfYmWkvUI9I4fXPsWYaM5OxOrdSofSr59ZF4I7BSFE9h2WBcU0Fmv
 n7a1//sw2APZLjtiBCDf9GsKWSuVioPYHrpsouRPoVjJzCEOY9ywnbmW1SD8Smbjk1z0wx0oD4
 4x0=
X-IronPort-AV: E=Sophos;i="5.70,382,1574092800"; d="scan'208";a="133122188"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 31 Jan 2020 02:29:48 +0800
IronPort-SDR: YlpaXA2T+3ccgPTeMvH65w+uBA4gE48u4Ie69iasplcqop0/Cidayps4mnwjiKexSEV0zvPR9D
 cBRMx4wAuyfARx6Il1297iFsaqR3yTT6yje/K7X4h3RWi+YdYUtXTVSVPBeuJH99FfJ2OnIRqK
 TTyNSruytad63DjxiXJFk70ovMM8jR2OL9BJTfRlSQqsszdGtTCEraPowWroMKBhgwvoA6jGcz
 W7OulnNLMoHD9Xdn6a2BCbIhbWkkYherzyJbKXXYmqkr1ozyR5OQH2vdW0GCO3WYptqRBInNMn
 qNR4aDo7V4d+qgNy/xUCDwFx
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jan 2020 10:22:58 -0800
IronPort-SDR: OxbZSKjsoFccJkXZ67s/IfJfg/tQld3PDne1l1uqWoT+1GODQcKl/zXHXLG5xE0oJMKFlh4rQs
 MkiCGyR8tGOVdmxC1/BNqC7mbKJfDOqG9aoXQUOvBlCvsnZ8DDB4TCbw+D0S9ue9xssmj5kuUD
 PdcMgPPQPxRkGHlZWaibmmBrWMY1lQ1BzcKB1KhDi8vjjyWL5bFJRcYX2dWyy6Pv3Dqfj1cpas
 U+d1Lm/Z6XCSgjNfQ5lA9d+Mjf5Zx27OU3aWAFm7j5P4rOn6NgXxolYkAGhBSf+ulBrsm0ylU/
 TIo=
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com)
 ([10.6.138.107])
 by uls-op-cesaip02.wdc.com with ESMTP; 30 Jan 2020 10:29:47 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V6 2/4] nvmet: make ctrl model configurable
Date: Thu, 30 Jan 2020 10:29:32 -0800
Message-Id: <20200130182934.6109-3-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200130182934.6109-1-chaitanya.kulkarni@wdc.com>
References: <20200130182934.6109-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200130_102951_253806_8C94A40C 
X-CRM114-Status: GOOD (  17.53  )
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
Cc: hch@lst.de, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 sagi@grimberg.me
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

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Mark Ruijter <MRuijter@onestopsystems.com>
[chaitanya.kulkarni@wdc.com
 *Use macro for default model, coding style fixes.
 *Use RCU for accessing model in for configfs and in
  nvmet_execute_identify_ctrl().
]
Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
Changes from V5 :-

1. Use correct mutex_is_locked().
2. Move kfree_rcu() out of the nvmet_config_sem.

Changes from V4:-

1. Use rcu_replace_pointer() and kfree_rcu() for subsys model add
   additional structure nvmet_subsys_model needed for rcu.
2. Remove nvmet_model_number() helper as we are using rcu based
   readers for reading model.
3. Add nvmet_id_set_model_number().

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
 drivers/nvme/target/admin-cmd.c | 17 ++++++++-
 drivers/nvme/target/configfs.c  | 66 +++++++++++++++++++++++++++++++++
 drivers/nvme/target/core.c      |  1 +
 drivers/nvme/target/nvmet.h     |  8 ++++
 4 files changed, 90 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 56c21b501185..57c02e41c263 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -312,12 +312,25 @@ static void nvmet_execute_get_log_page(struct nvmet_req *req)
 	nvmet_req_complete(req, NVME_SC_INVALID_FIELD | NVME_SC_DNR);
 }
 
+static void nvmet_id_set_model_number(struct nvme_id_ctrl *id,
+				      struct nvmet_subsys *subsys)
+{
+	const char *model = NVMET_DEFAULT_CTRL_MODEL;
+	struct nvmet_subsys_model *subsys_model;
+
+	rcu_read_lock();
+	subsys_model = rcu_dereference(subsys->model);
+	if (subsys_model)
+		model = subsys_model->number;
+	memcpy_and_pad(id->mn, sizeof(id->mn), model, strlen(model), ' ');
+	rcu_read_unlock();
+}
+
 static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 {
 	struct nvmet_ctrl *ctrl = req->sq->ctrl;
 	struct nvme_id_ctrl *id;
 	u16 status = 0;
-	const char model[] = "Linux";
 
 	id = kzalloc(sizeof(*id), GFP_KERNEL);
 	if (!id) {
@@ -332,7 +345,7 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 	memset(id->sn, ' ', sizeof(id->sn));
 	bin2hex(id->sn, &ctrl->subsys->serial,
 		min(sizeof(ctrl->subsys->serial), sizeof(id->sn) / 2));
-	memcpy_and_pad(id->mn, sizeof(id->mn), model, sizeof(model) - 1, ' ');
+	nvmet_id_set_model_number(id, ctrl->subsys);
 	memcpy_and_pad(id->fr, sizeof(id->fr),
 		       UTS_RELEASE, strlen(UTS_RELEASE), ' ');
 
diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index c62f8b8b3d53..a03d79488943 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -922,12 +922,78 @@ static ssize_t nvmet_subsys_attr_cntlid_max_store(struct config_item *item,
 }
 CONFIGFS_ATTR(nvmet_subsys_, attr_cntlid_max);
 
+static ssize_t nvmet_subsys_attr_model_show(struct config_item *item,
+					    char *page)
+{
+	struct nvmet_subsys *subsys = to_subsys(item);
+	struct nvmet_subsys_model *subsys_model;
+	char *model = NVMET_DEFAULT_CTRL_MODEL;
+	int ret;
+
+	rcu_read_lock();
+	subsys_model = rcu_dereference(subsys->model);
+	if (subsys_model)
+		model = subsys_model->number;
+	ret = snprintf(page, PAGE_SIZE, "%s\n", model);
+	rcu_read_unlock();
+
+	return ret;
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
+	struct nvmet_subsys_model *new_model;
+	char *new_model_number;
+	int pos = 0, len;
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
+	new_model_number = kstrndup(page, len, GFP_KERNEL);
+	if (!new_model_number)
+		return -ENOMEM;
+
+	new_model = kzalloc(sizeof(*new_model) + len + 1, GFP_KERNEL);
+	if (!new_model) {
+		kfree(new_model_number);
+		return -ENOMEM;
+	}
+	memcpy(new_model->number, new_model_number, len);
+
+	down_write(&nvmet_config_sem);
+	mutex_lock(&subsys->lock);
+	new_model = rcu_replace_pointer(subsys->model, new_model,
+					mutex_is_locked(&subsys->lock));
+	mutex_unlock(&subsys->lock);
+	up_write(&nvmet_config_sem);
+
+	kfree_rcu(new_model, rcuhead);
+
+	return count;
+}
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
index 990ad4c7bdfd..72938c8e9fcb 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1439,6 +1439,7 @@ static void nvmet_subsys_free(struct kref *ref)
 	WARN_ON_ONCE(!list_empty(&subsys->namespaces));
 
 	kfree(subsys->subsysnqn);
+	kfree_rcu(subsys->model, rcuhead);
 	kfree(subsys);
 }
 
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 6492d12e626a..7ad022f1f4ac 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -23,6 +23,7 @@
 #define NVMET_ASYNC_EVENTS		4
 #define NVMET_ERROR_LOG_SLOTS		128
 #define NVMET_NO_ERROR_LOC		((u16)-1)
+#define NVMET_DEFAULT_CTRL_MODEL	"Linux"
 
 /*
  * Supported optional AENs:
@@ -202,6 +203,11 @@ struct nvmet_ctrl {
 	struct nvme_error_slot	slots[NVMET_ERROR_LOG_SLOTS];
 };
 
+struct nvmet_subsys_model {
+	struct rcu_head		rcuhead;
+	char			number[];
+};
+
 struct nvmet_subsys {
 	enum nvme_subsys_type	type;
 
@@ -229,6 +235,8 @@ struct nvmet_subsys {
 
 	struct config_group	namespaces_group;
 	struct config_group	allowed_hosts_group;
+
+	struct nvmet_subsys_model	__rcu *model;
 };
 
 static inline struct nvmet_subsys *to_subsys(struct config_item *item)
-- 
2.22.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

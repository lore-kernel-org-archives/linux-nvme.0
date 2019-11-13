Return-Path: <SRS0=s2cI=ZF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D95BC432C3
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Nov 2019 21:59:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5791C206E5
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Nov 2019 21:59:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="U7F+GGT7";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="EftkTfS6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5791C206E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=9Byj1oyZu71oZ7ImkV4Tdn16mchG/XVJC0wAoddwWY0=; b=U7F+GGT75/oy51
	BCdSzEHa3j4AMcQ2vzba0SETzm9PBwFfYJh9UO9d9/H5SYrDMsG/g3gkDWeASNx+KvYaC2sAvdvRe
	YjimmHCY1Ym0wvf6mwU7DnjkJe2iKvDX0AKZ4WM60M9wdE88MXTcDNwnEuMoFTN4/XKTp0tCxp5LY
	a/FgZSgPmmn8D+5cV4g+6mnLb9yeqY4187X+PpNtG29UfnEV67lXiojPASq+N6OdTd68c8tjjTpnW
	2UuMgLMOMii0xQdaa9ZXLyyVuhW4zft/QUBpf7mp7UmnNIYetkrgjkREn+ifWbv6EwpN+FnKBsuGR
	K0h9Euvt+tCF9Y6t4Cxw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iV0f9-000390-N0; Wed, 13 Nov 2019 21:58:55 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iV0f6-00038A-Gd
 for linux-nvme@lists.infradead.org; Wed, 13 Nov 2019 21:58:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1573682333; x=1605218333;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Wic9/6/8lpDnXI2wK74ZaWwC/Mvqkg7Ey/Ix+vApWcQ=;
 b=EftkTfS6fgRj8sp5t4JLsLDc0S6cJErQBVEaQQPrpDKj8B3G2BelOg9u
 5lqK7bmjxaNqUODd7ev827veqiENzirl+0QFPpe/kDuMWNpEkG+VJmFiv
 9/5Wsi4Lry3tZT26ASWv7gNX913bGjeE7PX8hDfCIMf4zF7WakXeAA48q
 dO936fbajypbs59yVfybEWt1qGqH+HQHKfATKgYK9t7DqsODSXiikO/Cq
 euW0SoibKWxfueKu1MhtU7/Fk7I5ApR5/PDJawwyqaUNH7Pk9mUFxNudS
 ACuFccANQiGM7SvTZRs7MxrmieFklJdvCtUL5Fvu5at/j+f0qeZsQ3d+t A==;
IronPort-SDR: RWnnRbnHBb5kIBZHJ79sAuExRdgMiUhRXVSuzYTczMg2bnIJQq67bFw5rCWTK7rWqgMBSUTpPr
 MPEcEUTDZd8ba9yvvA8Gh2MKFkIx0ozYuR1uISrA3WnqGeFfnaQ+b4KRaAMX1ULyySt6dTH00J
 /eooSDzgNErCNXMbNpvHJIpl5NgAujR+O/pCBes7iOuwhXjtelnQXxjDZ/0J0tjGJcQSsh1Jbl
 dKRfP8XGpGkFx9JlfA6vZ2QK8oVbX0zqq7xl/VfxXJLaeONvVLnORTOwKICa5mmyCJrMC9h4LK
 YX8=
X-IronPort-AV: E=Sophos;i="5.68,302,1569254400"; d="scan'208";a="124555168"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 14 Nov 2019 05:58:48 +0800
IronPort-SDR: uALrb8HqCHWiYw9c5N27L0DMVvchWLn3JiKQMt5r/ZhSQSvc6QZfZqiSrT/X4Iy2S0E7XiClvD
 t3hyJpcA7lghPVyjIgRSpCaQM8fDuTwSsPPMRHRkyPq+P1sXRJCF7NMbqwtSGxQdxXvHfw3mWM
 hlOMc8QD7oDLn010gSxkQTr+Ri4iRccRB+dKDCZJ/DsUp9FHVP1lM74v2cB0TtCj7yjdy1iEOL
 q7Qm+/riW6AAE0kpMmAItRiq6ohI7dComE9W7fEdKwzh1TjqDxYubDIdR7Ez8YcWV812X6r+tw
 V93LFp+0yuGvLPiZ2UqTmjW/
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2019 13:53:47 -0800
IronPort-SDR: lTibW8D1Jig9hN95NonIkeP3KvtHYA68Am82jdBHmJfYxrhnxGkVeVWl+Mna6Nrtlz9FU7cJqG
 nBHx6yi0ykMJjvnVhpE+CraNaEibAgyddQ2AkK5JQFSuN7x0YcgJYoDfqmVc4bmlNgXdX+x45p
 QtrdkT2kllmQfppKfCM9RQ3CYKIExoEu0l9xNovIqmWxdlWodUzKNgLi5DwkUeE9lemHi17oaB
 6hv6Mr6u77ek3RC9nxXqDKC9xil0BSQQsYV/qE129uqCi4zOuAIQtThapOIRTr8h+VMpLvzXi2
 I44=
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com)
 ([10.6.138.107])
 by uls-op-cesaip01.wdc.com with ESMTP; 13 Nov 2019 13:58:49 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V2] nvmet: make ctrl model configurable
Date: Wed, 13 Nov 2019 13:58:45 -0800
Message-Id: <20191113215846.22399-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191113_135852_612971_4833A9D7 
X-CRM114-Status: GOOD (  16.69  )
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
Cc: MRuijter@onestopsystems.com, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Mark Ruijter <MRuijter@onestopsystems.com>

This patch adds a new target subsys attribute which allows user to
optionally specify model name which then used in the
nvmet_execute_identify_ctrl() to fill up the nvme_id_ctrl structure.

The default value for the model is set to "Linux" for backward
compatibility.

Signed-off-by: Mark Ruijter <MRuijter@onestopsystems.com>
Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
Changes from V1:-

1. Don't allocate memory for default subsys model,
2. Use helper to get the default model string from ctrl->subsys in the
   nvmet_execute_identify_ctrl() and nvmet_subsys_attr_model()_show.
   Later is needed so that nvmetcli can display default value Linux
   when the model is not set from the user.
3. Get rid of the extra variable c in the nvmet_subsys_attr_model_store()
   and replace for with while loop without loosing the code redability.
---
 drivers/nvme/target/admin-cmd.c |  9 +++++--
 drivers/nvme/target/configfs.c  | 44 +++++++++++++++++++++++++++++++++
 drivers/nvme/target/core.c      |  2 ++
 drivers/nvme/target/nvmet.h     |  4 +++
 4 files changed, 57 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 56c21b501185..81374507099f 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -312,12 +312,17 @@ static void nvmet_execute_get_log_page(struct nvmet_req *req)
 	nvmet_req_complete(req, NVME_SC_INVALID_FIELD | NVME_SC_DNR);
 }
 
+const char *nvmet_subsys_model(struct nvmet_subsys *subsys)
+{
+	return subsys->model ? subsys->model : NVMET_DEFAULT_CTRL_MODEL;
+}
+
 static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 {
+	const char *model = nvmet_subsys_model(req->sq->ctrl->subsys);
 	struct nvmet_ctrl *ctrl = req->sq->ctrl;
 	struct nvme_id_ctrl *id;
 	u16 status = 0;
-	const char model[] = "Linux";
 
 	id = kzalloc(sizeof(*id), GFP_KERNEL);
 	if (!id) {
@@ -332,7 +337,7 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 	memset(id->sn, ' ', sizeof(id->sn));
 	bin2hex(id->sn, &ctrl->subsys->serial,
 		min(sizeof(ctrl->subsys->serial), sizeof(id->sn) / 2));
-	memcpy_and_pad(id->mn, sizeof(id->mn), model, sizeof(model) - 1, ' ');
+	memcpy_and_pad(id->mn, sizeof(id->mn), model, strlen(model), ' ');
 	memcpy_and_pad(id->fr, sizeof(id->fr),
 		       UTS_RELEASE, strlen(UTS_RELEASE), ' ');
 
diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 98613a45bd3b..4580f9d9b07f 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -862,10 +862,54 @@ static ssize_t nvmet_subsys_attr_serial_store(struct config_item *item,
 }
 CONFIGFS_ATTR(nvmet_subsys_, attr_serial);
 
+static ssize_t nvmet_subsys_attr_model_show(struct config_item *item,
+					    char *page)
+{
+	struct nvmet_subsys *subsys = to_subsys(item);
+
+	return snprintf(page, PAGE_SIZE, "%s\n", nvmet_subsys_model(subsys));
+}
+
+static ssize_t nvmet_subsys_attr_model_store(struct config_item *item,
+					     const char *page, size_t count)
+{
+	struct nvmet_subsys *subsys = to_subsys(item);
+	int ret = -EINVAL, pos = 0, len;
+	char *tmp;
+
+	down_write(&nvmet_config_sem);
+	len = strcspn(page, "\n");
+	if (!len)
+		goto out_unlock;
+
+	/* Only 20h (space) until 7eh (~) is allowed */
+	while (pos < len && (page[pos] >= 0x20 && page[pos] <= 0x7e) && ++pos)
+		;
+	if (pos != len)
+		goto out_unlock;
+
+	tmp = kstrndup(page, len, GFP_KERNEL);
+	if (!tmp) {
+		ret = -ENOMEM;
+		goto out_unlock;
+	}
+
+	ret = count;
+	kfree(subsys->model);
+	subsys->model = tmp;
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
+	&nvmet_subsys_attr_attr_model,
 	NULL,
 };
 
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 28438b833c1b..1d17638bbc45 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1416,6 +1416,7 @@ struct nvmet_subsys *nvmet_subsys_alloc(const char *subsysnqn,
 		kfree(subsys);
 		return ERR_PTR(-ENOMEM);
 	}
+	subsys->model = NULL;
 
 	kref_init(&subsys->ref);
 
@@ -1435,6 +1436,7 @@ static void nvmet_subsys_free(struct kref *ref)
 	WARN_ON_ONCE(!list_empty(&subsys->namespaces));
 
 	kfree(subsys->subsysnqn);
+	kfree(subsys->model);
 	kfree(subsys);
 }
 
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 46df45e837c9..7fafb5171037 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -23,6 +23,7 @@
 #define NVMET_ASYNC_EVENTS		4
 #define NVMET_ERROR_LOG_SLOTS		128
 #define NVMET_NO_ERROR_LOC		((u16)-1)
+#define NVMET_DEFAULT_CTRL_MODEL       "Linux"
 
 /*
  * Supported optional AENs:
@@ -222,6 +223,7 @@ struct nvmet_subsys {
 	u64			ver;
 	u64			serial;
 	char			*subsysnqn;
+	char			*model;
 
 	struct config_group	group;
 
@@ -487,6 +489,8 @@ u16 nvmet_bdev_flush(struct nvmet_req *req);
 u16 nvmet_file_flush(struct nvmet_req *req);
 void nvmet_ns_changed(struct nvmet_subsys *subsys, u32 nsid);
 
+const char *nvmet_subsys_model(struct nvmet_subsys *subsys);
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

Return-Path: <SRS0=Vg0R=YZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC3FCA9EC9
	for <linux-nvme@archiver.kernel.org>; Fri,  1 Nov 2019 08:09:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B0F0208E3
	for <linux-nvme@archiver.kernel.org>; Fri,  1 Nov 2019 08:09:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oCSbcUAJ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="UcDyA0p/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B0F0208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=scyQsiNMqiSEsVWxbMOpUWX95P3XjIiYhQvjVgqLQIE=; b=oCSbcUAJ9M+gr8
	6RV2RjoEIlLh/QnwmiKDPwU673V1653+jVDOghsUZFjWldvwKYoD1H199Vv6AmC5lxcDG+7h8AtTi
	1k+iyxhCL6z16LF06e9Sr368WSG72FFXdrwPiH/Tdm+oTL2lKooqm026ACn0+OqOaW4FYb3rALFBJ
	2hcgpk0ZsoftTIeibrwaW1PHBJWpBK4gxksgkPnSwcdyyK9fYCwTWlYaicSY/FVWWcFoj1yAjbDO1
	cGZAUlP+TKaRYdt5y2G3x9/YfquGg5cDfEaaNYgOo607aba284YF2+j7eJ3+IgMeU9E7CXFe1ZTas
	jydAEjoL/qnXRzl4rHoA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iQRzY-0001GO-Mb; Fri, 01 Nov 2019 08:09:08 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iQRzV-0001Fj-IC
 for linux-nvme@lists.infradead.org; Fri, 01 Nov 2019 08:09:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1572595746; x=1604131746;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=A6GVOo2SojprP51oi6Q9+JM0ug7KDUQ7WouLnUN3Y0Y=;
 b=UcDyA0p/QS321SvlgTfU0GVIeeDH9/aPk4KaYHEBYBtEdlFcFkgvhfjK
 8YJ9WvD8mgdtXgVq8ayvW0hBLqTqaNl8u8n4r6DnCzezyipxwgBgLPc6b
 zW8kVZMT2iBZ2m8qvadhsbzftxTOReOx28v8Ox32u7A5d/XMVuBm9NJ2P
 RIvCSNa1EuH40ZBSgkdpVt+vdXMPuSd1zSoKCPvghqiVUZROnVex9Ooyx
 jvEh7KFolQ/I6kvW2XNMYE4xS2EmXfxsKvRrr0OXPWsbp2t6Yw1CeLHUW
 ASOV7StbScPagh5nxxxdjyg2cP3iy8vGi0s0c3alsLqXC9eY1BiHMnyBR Q==;
IronPort-SDR: J7GtZSXt85Uqh6rdXKxCJolnSVsaoGj7IopSHb27hqJGXUQyGZep+IUVMqCmzMfVtQQFw0Q1l3
 JuaJdauE8vlyhqDJK9/MIqYWHtzc0+lRuhYFn3SMyuFaPGPWC3LsXJJYAK66ZOD0YB+UtDyqTj
 b4eXvlPHOq4fqUOQnSwyjdF0KMgJqb7bTcl3GA0q0wU1+khcHfrvPoT+VvmdsqFL7PCky2Wu7z
 /IXUOYqlwpBsTlshckUah+vKFox5K/pgvk+/iGcJNNx2MptqN8i2X15IF3laz8KoS5up6Ry9wu
 BqU=
X-IronPort-AV: E=Sophos;i="5.68,254,1569254400"; d="scan'208";a="126289487"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 01 Nov 2019 16:09:04 +0800
IronPort-SDR: eSIHzTAoR8EI0sGt8K8R+/TT2Bssanqa36KWXIAxUfppiFhlTt3f4mJmUwXrrok7XFsfAM+x3t
 H3AVQk7RcqoqGqxkxdpCY8jbE5YtgvNUMC1T/H+wgYkXg0YRKTq2l7XJ0jZjvMB5oKENNnqkyO
 LR5PXLQJ/l8qV/y6MHr5T/PRGXT9dJIj7UcHi6721TPbo5XY5j4rdjarus5qYGif74cXKzeV6a
 +NYu3qxvz27bhdIjqhdq5uAuSEwzdAWpocY+h+bCJASMOrai5b6yFSSeU6xJYQ/ukQCEY6zacr
 h82aZXz2heSuIVqiyhQxO330
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Nov 2019 01:04:23 -0700
IronPort-SDR: heFCztt/5pYBgr/E7gQvtO1wSxU3b37g0/Frt6VqQiDWQNAXV5X1YR5Kk959ws1e29FX125nPI
 XWzolMLCrl+alzhJSVB/rOgDZVP/lN7HP4lk8MhhZ/jwjo2GCZFEGd3v56uM4xXz7YrAFnddEA
 w+d8p0BbbITiflipXwdn4zDWyPhMoy/ZxGt7ppQJ7IMkIHyWr6uEV8eC3cHXXjMcNzp6MOd1gd
 6OJkTiz7wAZ5rfw9Clpa7sFU1YsUug8HQLGRPNnv0olaAMIhoYmMxCwST7MxcsdYP5t5Hu8n8K
 TAA=
WDCIronportException: Internal
Received: from cvenusqemu.hgst.com ([10.202.66.73])
 by uls-op-cesaip02.wdc.com with ESMTP; 01 Nov 2019 01:09:03 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH] nvmet: make ctrl model configurable
Date: Fri,  1 Nov 2019 01:08:55 -0700
Message-Id: <20191101080855.17970-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191101_010905_618314_0A8ED4A3 
X-CRM114-Status: GOOD (  15.22  )
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
Hi,

This patch is originally posted by Mark and later same day by me with
the same concept. I've merged changes from both patch into one and
cleaned the code to fit the kernel coding standards.

-Regards,
Chaitanya
---
 drivers/nvme/target/admin-cmd.c |  4 +--
 drivers/nvme/target/configfs.c  | 45 +++++++++++++++++++++++++++++++++
 drivers/nvme/target/core.c      |  7 +++++
 drivers/nvme/target/nvmet.h     |  2 ++
 4 files changed, 56 insertions(+), 2 deletions(-)

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
index 98613a45bd3b..faf34b15b975 100644
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
+	return snprintf(page, PAGE_SIZE, "%s\n", subsys->model);
+}
+
+static ssize_t nvmet_subsys_attr_model_store(struct config_item *item,
+					     const char *page, size_t count)
+{
+	struct nvmet_subsys *subsys = to_subsys(item);
+	int ret = -EINVAL, pos, len;
+	char c;
+
+	down_write(&nvmet_config_sem);
+	len = strcspn(page, "\n");
+	if (!len) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
+	/* Only 20h (space) until 7eh (~) is allowed */
+	for (pos = 0; pos < len; pos++) {
+		c = page[pos];
+		if (c < 0x20 || c > 0x7e) {
+			ret = -EINVAL;
+			goto out_unlock;
+		}
+	}
+
+	kfree(subsys->model);
+	subsys->model = kstrndup(page, len, GFP_KERNEL);
+	if (!subsys->model)
+		ret = -ENOMEM;
+
+out_unlock:
+	up_write(&nvmet_config_sem);
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
 
@@ -901,6 +945,7 @@ static struct config_group *nvmet_subsys_make(struct config_group *group,
 	}
 
 	subsys = nvmet_subsys_alloc(name, NVME_NQN_NVME);
+	subsys->model = kstrdup(NVMET_DEFAULT_CTRL_MODEL, GFP_KERNEL);
 	if (IS_ERR(subsys))
 		return ERR_CAST(subsys);
 
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 28438b833c1b..adc1eb667601 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1416,6 +1416,12 @@ struct nvmet_subsys *nvmet_subsys_alloc(const char *subsysnqn,
 		kfree(subsys);
 		return ERR_PTR(-ENOMEM);
 	}
+	subsys->model = kstrdup(NVMET_DEFAULT_CTRL_MODEL, GFP_KERNEL);
+	if (!subsys->model) {
+		kfree(subsys->subsysnqn);
+		kfree(subsys);
+		return ERR_PTR(-ENOMEM);
+	}
 
 	kref_init(&subsys->ref);
 
@@ -1435,6 +1441,7 @@ static void nvmet_subsys_free(struct kref *ref)
 	WARN_ON_ONCE(!list_empty(&subsys->namespaces));
 
 	kfree(subsys->subsysnqn);
+	kfree(subsys->model);
 	kfree(subsys);
 }
 
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 46df45e837c9..afb6116de892 100644
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
 
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

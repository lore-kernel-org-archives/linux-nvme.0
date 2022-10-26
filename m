Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0EACC38A2D
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Oct 2022 08:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jyXYo4hP2c5x/xbFs8p9zLSE35zKSDaiyDawb0vfUvg=; b=qiMCLLceEZGLDUCX84bPem9q3s
	3wsgsc+pVEEzjsGuYfgGtlohL8WKjHhOxA/faUp0kyua84FFH9JOEkCnnTzrzvtUAzZelKFfMownP
	PFp5dhWmC1PqrLMZ7Cm5+ZIr7eKUW/bH+2y/hle6bgDxL7vCIKQis18O/ST9IDKNKN6fGVVFkLCBB
	NwQDnp7pEHrP64iXer5LSRIlrG30AqxDTrcqr5aIb4uT5S1FNhQ31NhwjRbDNYh9x4jdYKmQavLdr
	muXk1xDNPE17QBG4oPLFkos0ftnFOndUcds6pzih72+W7j4k4LWYZXfF3jj3n3WjBjbhNTTgBLxMa
	NHJQNmeg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onbrg-008Zf5-6z; Wed, 26 Oct 2022 08:34:20 +0000
Received: from mta-02.yadro.com ([89.207.88.252] helo=mta-01.yadro.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onbrQ-008ZbV-1i
	for linux-nvme@lists.infradead.org; Wed, 26 Oct 2022 08:34:05 +0000
Received: from localhost (unknown [127.0.0.1])
	by mta-01.yadro.com (Postfix) with ESMTP id B753841220;
	Wed, 26 Oct 2022 08:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
	content-type:content-type:content-transfer-encoding:mime-version
	:references:in-reply-to:x-mailer:message-id:date:date:subject
	:subject:from:from:received:received:received:received; s=
	mta-01; t=1666773241; x=1668587642; bh=dhunXb8tDy6QHtG7l47h+kWwS
	3dD8V+2PW0tWaBN8z0=; b=qpFVPXWyJ20NrWv5ZOW3kcthOfJWzhkkgxEkTAAnD
	1B4rnffsJOMU/bGRig+JEPcnzvrik4Z+G/Da8jtgWyBoaSv1XgtAZdVfnuLHIfNa
	956dVkxZHFbtNjEe22K2Cnh3FNtZOcta9PpA1uygDpCDp22OtZtbjJ31Vsu4h11G
	7A=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
	by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 24yKnXn27dRu; Wed, 26 Oct 2022 11:34:01 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (T-EXCH-02.corp.yadro.com [172.17.10.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by mta-01.yadro.com (Postfix) with ESMTPS id 2AF0E41222;
	Wed, 26 Oct 2022 11:33:49 +0300 (MSK)
Received: from T-Exch-05.corp.yadro.com (172.17.10.109) by
 T-EXCH-02.corp.yadro.com (172.17.10.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.669.32; Wed, 26 Oct 2022 11:33:49 +0300
Received: from yadro.com (10.178.113.226) by T-Exch-05.corp.yadro.com
 (172.17.10.109) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1118.9; Wed, 26 Oct
 2022 11:33:45 +0300
From: Aleksandr Miloserdov <a.miloserdov@yadro.com>
To: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
CC: <linux-nvme@lists.infradead.org>, <linux@yadro.com>, Aleksandr Miloserdov
	<a.miloserdov@yadro.com>, Konstantin Shelekhin <k.shelekhin@yadro.com>,
	Dmitriy Bogdanov <d.bogdanov@yadro.com>
Subject: [PATCH 3/3] nvmet: expose firmware revision to configfs
Date: Wed, 26 Oct 2022 12:31:35 +0400
Message-ID: <20221026083135.77125-4-a.miloserdov@yadro.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20221026083135.77125-1-a.miloserdov@yadro.com>
References: <20221026083135.77125-1-a.miloserdov@yadro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.178.113.226]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-Exch-05.corp.yadro.com (172.17.10.109)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221026_013404_443907_57633D67 
X-CRM114-Status: GOOD (  17.66  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Allow user to set currently active firmware revision

Reviewed-by: Konstantin Shelekhin <k.shelekhin@yadro.com>
Reviewed-by: Dmitriy Bogdanov <d.bogdanov@yadro.com>
Signed-off-by: Aleksandr Miloserdov <a.miloserdov@yadro.com>
---
 drivers/nvme/target/admin-cmd.c |  2 +-
 drivers/nvme/target/configfs.c  | 63 +++++++++++++++++++++++++++++++++
 drivers/nvme/target/core.c      | 15 ++++++--
 drivers/nvme/target/nvmet.h     |  2 ++
 4 files changed, 79 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 0b415335bb5f..92098032c85d 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -370,7 +370,7 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 	memcpy_and_pad(id->mn, sizeof(id->mn), subsys->model_number,
 		       strlen(subsys->model_number), ' ');
 	memcpy_and_pad(id->fr, sizeof(id->fr),
-		       UTS_RELEASE, strlen(UTS_RELEASE), ' ');
+		       subsys->firmware_rev, strlen(subsys->firmware_rev), ' ');
 
 	id->ieee[0] = (subsys->ieee_oui) & 0xff;
 	id->ieee[1] = (subsys->ieee_oui >> 8) & 0xff;
diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index ad62e36ec997..1862b9479347 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -1313,6 +1313,68 @@ static ssize_t nvmet_subsys_attr_ieee_oui_store(struct config_item *item,
 }
 CONFIGFS_ATTR(nvmet_subsys_, attr_ieee_oui);
 
+static ssize_t nvmet_subsys_attr_firmware_show(struct config_item *item,
+					    char *page)
+{
+	struct nvmet_subsys *subsys = to_subsys(item);
+
+	return sysfs_emit(page, "%s\n", subsys->firmware_rev);
+}
+
+static ssize_t nvmet_subsys_attr_firmware_store_locked(struct nvmet_subsys *subsys,
+		const char *page, size_t count)
+{
+	int pos = 0, len;
+	char *val;
+
+	if (subsys->subsys_discovered) {
+		pr_err("Can't set firmware revision. %s is already assigned\n",
+		       subsys->firmware_rev);
+		return -EINVAL;
+	}
+
+	len = strcspn(page, "\n");
+	if (!len)
+		return -EINVAL;
+
+	if (len > NVMET_FR_MAX_SIZE) {
+		pr_err("Firmware revision size can not exceed %d Bytes\n",
+		       NVMET_FR_MAX_SIZE);
+		return -EINVAL;
+	}
+
+	for (pos = 0; pos < len; pos++) {
+		if (!nvmet_is_ascii(page[pos]))
+			return -EINVAL;
+	}
+
+	val = kmemdup_nul(page, len, GFP_KERNEL);
+	if (!val)
+		return -ENOMEM;
+
+	kfree(subsys->firmware_rev);
+
+	subsys->firmware_rev = val;
+
+	return count;
+}
+
+static ssize_t nvmet_subsys_attr_firmware_store(struct config_item *item,
+					     const char *page, size_t count)
+{
+	struct nvmet_subsys *subsys = to_subsys(item);
+	ssize_t ret;
+
+	down_write(&nvmet_config_sem);
+	mutex_lock(&subsys->lock);
+	ret = nvmet_subsys_attr_firmware_store_locked(subsys, page, count);
+	mutex_unlock(&subsys->lock);
+	up_write(&nvmet_config_sem);
+
+	return ret;
+}
+CONFIGFS_ATTR(nvmet_subsys_, attr_firmware);
+
 #ifdef CONFIG_BLK_DEV_INTEGRITY
 static ssize_t nvmet_subsys_attr_pi_enable_show(struct config_item *item,
 						char *page)
@@ -1372,6 +1434,7 @@ static struct configfs_attribute *nvmet_subsys_attrs[] = {
 	&nvmet_subsys_attr_attr_model,
 	&nvmet_subsys_attr_attr_qid_max,
 	&nvmet_subsys_attr_attr_ieee_oui,
+	&nvmet_subsys_attr_attr_firmware,
 #ifdef CONFIG_BLK_DEV_INTEGRITY
 	&nvmet_subsys_attr_attr_pi_enable,
 #endif
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index ec697ceeac56..98d41bbd3f72 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -10,6 +10,8 @@
 #include <linux/pci-p2pdma.h>
 #include <linux/scatterlist.h>
 
+#include <generated/utsrelease.h>
+
 #define CREATE_TRACE_POINTS
 #include "trace.h"
 
@@ -1563,6 +1565,12 @@ struct nvmet_subsys *nvmet_subsys_alloc(const char *subsysnqn,
 
 	subsys->ieee_oui = 0;
 
+	subsys->firmware_rev = kstrndup(UTS_RELEASE, NVMET_FR_MAX_SIZE, GFP_KERNEL);
+	if (!subsys->firmware_rev) {
+		ret = -ENOMEM;
+		goto free_mn;
+	}
+
 	switch (type) {
 	case NVME_NQN_NVME:
 		subsys->max_qid = NVMET_NR_QUEUES;
@@ -1574,14 +1582,14 @@ struct nvmet_subsys *nvmet_subsys_alloc(const char *subsysnqn,
 	default:
 		pr_err("%s: Unknown Subsystem type - %d\n", __func__, type);
 		ret = -EINVAL;
-		goto free_mn;
+		goto free_fr;
 	}
 	subsys->type = type;
 	subsys->subsysnqn = kstrndup(subsysnqn, NVMF_NQN_SIZE,
 			GFP_KERNEL);
 	if (!subsys->subsysnqn) {
 		ret = -ENOMEM;
-		goto free_mn;
+		goto free_fr;
 	}
 	subsys->cntlid_min = NVME_CNTLID_MIN;
 	subsys->cntlid_max = NVME_CNTLID_MAX;
@@ -1594,6 +1602,8 @@ struct nvmet_subsys *nvmet_subsys_alloc(const char *subsysnqn,
 
 	return subsys;
 
+free_fr:
+	kfree(subsys->firmware_rev);
 free_mn:
 	kfree(subsys->model_number);
 free_subsys:
@@ -1613,6 +1623,7 @@ static void nvmet_subsys_free(struct kref *ref)
 
 	kfree(subsys->subsysnqn);
 	kfree(subsys->model_number);
+	kfree(subsys->firmware_rev);
 	kfree(subsys);
 }
 
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 1dc0ff8b2f3f..dd8985b54a84 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -29,6 +29,7 @@
 #define NVMET_DEFAULT_CTRL_MODEL	"Linux"
 #define NVMET_MN_MAX_SIZE		40
 #define NVMET_SN_MAX_SIZE		20
+#define NVMET_FR_MAX_SIZE		8
 
 /*
  * Supported optional AENs:
@@ -265,6 +266,7 @@ struct nvmet_subsys {
 
 	char			*model_number;
 	u32			ieee_oui;
+	char			*firmware_rev;
 
 #ifdef CONFIG_NVME_TARGET_PASSTHRU
 	struct nvme_ctrl	*passthru_ctrl;
-- 
2.37.0



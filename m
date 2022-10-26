Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 642A0C433FE
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Oct 2022 08:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1DSNiUXKMxn3nyzHj7lQR5IV37gqgkHZL2ZBP2c13yY=; b=DSoO8nfCeree8TKTzfQvJDWKQL
	6V7AA6H1VELijs+SZ/HdOSl8QXQxmeslbAUUxWsYyl8s0YVynM3ziSPT4EKppJqAoTkVAmPRDdeun
	IXcmDZjnEJ+F9TOpvEZnK04s7kjrei76tVkkF3wy+fMChvi/Up8SlJqF1Li1u9OxwVQKB9ctzehi8
	oVlzAWJZeCMsMCD5vJgqewgO3itf4JccNvUAh19MbMH9CqT90FZND7iqp4myiQrYUap/3wvZt6sS/
	r/xzIhCHqjfzDFyvCpiMBMqdW+gHUj/gqXrsr60uXF2O1X1brrlL4wIQceiSemBbCsBY35JpmPf9P
	HC4cB/3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onbrW-008Zcn-0S; Wed, 26 Oct 2022 08:34:10 +0000
Received: from mta-02.yadro.com ([89.207.88.252] helo=mta-01.yadro.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onbrO-008Zb5-Hs
	for linux-nvme@lists.infradead.org; Wed, 26 Oct 2022 08:34:04 +0000
Received: from localhost (unknown [127.0.0.1])
	by mta-01.yadro.com (Postfix) with ESMTP id 3E181403C9;
	Wed, 26 Oct 2022 08:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
	content-type:content-type:content-transfer-encoding:mime-version
	:references:in-reply-to:x-mailer:message-id:date:date:subject
	:subject:from:from:received:received:received:received; s=
	mta-01; t=1666773239; x=1668587640; bh=ibyMAYPZ9pO9Prfn8j3/d9Sz0
	9DMXjqqOw63ENBTN6k=; b=Wsfp/xKMKQLVNpeCcip2B/36r7meSZFynm/gi6VKP
	4c0mHwW6nIJVk6rIzw/8Jm+TgiOX2jfj2NuZIJPy2XjK9A7K5NHyN9D8RJfpVIrg
	mSDU7tb6QWWge/CPJD7MoSHEknlW7d5XWn+jT+uf+e0usZAg21dEtzXu21ByCDIy
	kA=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
	by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zSJYnaQGV1t1; Wed, 26 Oct 2022 11:33:59 +0300 (MSK)
Received: from T-EXCH-01.corp.yadro.com (T-EXCH-01.corp.yadro.com [172.17.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by mta-01.yadro.com (Postfix) with ESMTPS id D53F941220;
	Wed, 26 Oct 2022 11:33:45 +0300 (MSK)
Received: from T-Exch-05.corp.yadro.com (172.17.10.109) by
 T-EXCH-01.corp.yadro.com (172.17.10.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.669.32; Wed, 26 Oct 2022 11:33:45 +0300
Received: from yadro.com (10.178.113.226) by T-Exch-05.corp.yadro.com
 (172.17.10.109) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1118.9; Wed, 26 Oct
 2022 11:33:42 +0300
From: Aleksandr Miloserdov <a.miloserdov@yadro.com>
To: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
CC: <linux-nvme@lists.infradead.org>, <linux@yadro.com>, Aleksandr Miloserdov
	<a.miloserdov@yadro.com>, Konstantin Shelekhin <k.shelekhin@yadro.com>,
	Dmitriy Bogdanov <d.bogdanov@yadro.com>
Subject: [PATCH 2/3] nvmet: expose IEEE OUI to configfs
Date: Wed, 26 Oct 2022 12:31:34 +0400
Message-ID: <20221026083135.77125-3-a.miloserdov@yadro.com>
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
X-CRM114-CacheID: sfid-20221026_013402_941760_55BB35B8 
X-CRM114-Status: GOOD (  18.14  )
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

Allow user to set OUI for the controller vendor.

Reviewed-by: Konstantin Shelekhin <k.shelekhin@yadro.com>
Reviewed-by: Dmitriy Bogdanov <d.bogdanov@yadro.com>
Signed-off-by: Aleksandr Miloserdov <a.miloserdov@yadro.com>
---
 drivers/nvme/target/admin-cmd.c |  9 +++---
 drivers/nvme/target/configfs.c  | 49 +++++++++++++++++++++++++++++++++
 drivers/nvme/target/core.c      |  2 ++
 drivers/nvme/target/nvmet.h     |  1 +
 4 files changed, 56 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index c8a061ce3ee5..0b415335bb5f 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -372,6 +372,10 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 	memcpy_and_pad(id->fr, sizeof(id->fr),
 		       UTS_RELEASE, strlen(UTS_RELEASE), ' ');
 
+	id->ieee[0] = (subsys->ieee_oui) & 0xff;
+	id->ieee[1] = (subsys->ieee_oui >> 8) & 0xff;
+	id->ieee[2] = (subsys->ieee_oui >> 16) & 0xff;
+
 	id->rab = 6;
 
 	if (nvmet_is_disc_subsys(ctrl->subsys))
@@ -379,11 +383,6 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 	else
 		id->cntrltype = NVME_CTRL_IO;
 
-	/*
-	 * XXX: figure out how we can assign a IEEE OUI, but until then
-	 * the safest is to leave it as zeroes.
-	 */
-
 	/* we support multiple ports, multiples hosts and ANA: */
 	id->cmic = NVME_CTRL_CMIC_MULTI_PORT | NVME_CTRL_CMIC_MULTI_CTRL |
 		NVME_CTRL_CMIC_ANA;
diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 89242b0f8614..ad62e36ec997 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -1265,6 +1265,54 @@ static ssize_t nvmet_subsys_attr_model_store(struct config_item *item,
 }
 CONFIGFS_ATTR(nvmet_subsys_, attr_model);
 
+static ssize_t nvmet_subsys_attr_ieee_oui_show(struct config_item *item,
+					    char *page)
+{
+	struct nvmet_subsys *subsys = to_subsys(item);
+
+	return sysfs_emit(page, "0x%06x\n", subsys->ieee_oui);
+}
+
+static ssize_t nvmet_subsys_attr_ieee_oui_store_locked(struct nvmet_subsys *subsys,
+		const char *page, size_t count)
+{
+	uint32_t val = 0;
+	int ret;
+
+	if (subsys->subsys_discovered) {
+		pr_err("Can't set IEEE OUI. 0x%06x is already assigned\n",
+		      subsys->ieee_oui);
+		return -EINVAL;
+	}
+
+	ret = kstrtou32(page, 0, &val);
+	if (ret < 0)
+		return ret;
+
+	if (val >= 0x1000000)
+		return -EINVAL;
+
+	subsys->ieee_oui = val;
+
+	return count;
+}
+
+static ssize_t nvmet_subsys_attr_ieee_oui_store(struct config_item *item,
+					     const char *page, size_t count)
+{
+	struct nvmet_subsys *subsys = to_subsys(item);
+	ssize_t ret;
+
+	down_write(&nvmet_config_sem);
+	mutex_lock(&subsys->lock);
+	ret = nvmet_subsys_attr_ieee_oui_store_locked(subsys, page, count);
+	mutex_unlock(&subsys->lock);
+	up_write(&nvmet_config_sem);
+
+	return ret;
+}
+CONFIGFS_ATTR(nvmet_subsys_, attr_ieee_oui);
+
 #ifdef CONFIG_BLK_DEV_INTEGRITY
 static ssize_t nvmet_subsys_attr_pi_enable_show(struct config_item *item,
 						char *page)
@@ -1323,6 +1371,7 @@ static struct configfs_attribute *nvmet_subsys_attrs[] = {
 	&nvmet_subsys_attr_attr_cntlid_max,
 	&nvmet_subsys_attr_attr_model,
 	&nvmet_subsys_attr_attr_qid_max,
+	&nvmet_subsys_attr_attr_ieee_oui,
 #ifdef CONFIG_BLK_DEV_INTEGRITY
 	&nvmet_subsys_attr_attr_pi_enable,
 #endif
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index aecb5853f8da..ec697ceeac56 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1561,6 +1561,8 @@ struct nvmet_subsys *nvmet_subsys_alloc(const char *subsysnqn,
 		goto free_subsys;
 	}
 
+	subsys->ieee_oui = 0;
+
 	switch (type) {
 	case NVME_NQN_NVME:
 		subsys->max_qid = NVMET_NR_QUEUES;
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index dfe3894205aa..1dc0ff8b2f3f 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -264,6 +264,7 @@ struct nvmet_subsys {
 	struct config_group	allowed_hosts_group;
 
 	char			*model_number;
+	u32			ieee_oui;
 
 #ifdef CONFIG_NVME_TARGET_PASSTHRU
 	struct nvme_ctrl	*passthru_ctrl;
-- 
2.37.0



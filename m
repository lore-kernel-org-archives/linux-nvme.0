Return-Path: <SRS0=vW9m=7P=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BF83C433E0
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Jun 2020 14:30:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 440A0206C3
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Jun 2020 14:30:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tnmCZblI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 440A0206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VEd89v+NAFLQX6C3Qpne2jGlx5J4sDdYeWWy+XpDtWA=; b=tnmCZblIgIKv18
	+q5ecmtC8VKrQHeo1nVH1envcCGiwLePKfEY8v6F+WTt5Iulyjeql/zjWc4uAUJOFFDilCHDTTveR
	V3/00NUOzy1bQYvk1+Qa67DigdmujwJlv+8JL/H9VmUH9rE0GjExmJCv1s0ym2AlEk80FvF6PLajx
	EvFAv8yh1Fii7mLKpzgI9VJ/ptXpd2fLzrU/kNBAgx3oZf3wSV/axOc5TV1tzCeoAgr7xnOOyCAQn
	v1TnJwEitoWnNnMurKxrE33HiR3K//AAlabXgPhCkR8EAyDaJ9KQ7CN7+UmRA9F9AkdzkuyX8hbUe
	tLNfV9zEHatEVyeoL/Iw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jg7w0-0000zT-Kv; Tue, 02 Jun 2020 14:30:32 +0000
Received: from mail-il-dmz.mellanox.com ([193.47.165.129] helo=mellanox.co.il)
 by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jg6ll-0003AK-GI
 for linux-nvme@lists.infradead.org; Tue, 02 Jun 2020 13:15:57 +0000
Received: from Internal Mail-Server by MTLPINE1 (envelope-from
 maxg@mellanox.com)
 with ESMTPS (AES256-SHA encrypted); 2 Jun 2020 16:15:46 +0300
Received: from mtr-vdi-031.wap.labs.mlnx. (mtr-vdi-031.wap.labs.mlnx
 [10.209.102.136])
 by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 052DFkVh031311;
 Tue, 2 Jun 2020 16:15:46 +0300
From: Max Gurtovoy <maxg@mellanox.com>
To: sagi@grimberg.me, linux-nvme@lists.infradead.org, kbusch@kernel.org,
 hch@lst.de, james.smart@broadcom.com, chaitanya.kulkarni@wdc.com
Subject: [PATCH 1/5] nvme: introduce nvme-types header file
Date: Tue,  2 Jun 2020 16:15:42 +0300
Message-Id: <20200602131546.51903-2-maxg@mellanox.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200602131546.51903-1-maxg@mellanox.com>
References: <20200602131546.51903-1-maxg@mellanox.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200602_061553_951505_928A9786 
X-CRM114-Status: GOOD (  13.24  )
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
Cc: israelr@mellanox.com, nitzanc@mellanox.com, oren@mellanox.com,
 Max Gurtovoy <maxg@mellanox.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Centralize the mapping between name and type to a common header file
instead of duplicating logic in both NVMe host and target drivers.

Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
Reviewed-by: Israel Rukshin <israelr@mellanox.com>
---
 drivers/nvme/target/configfs.c | 92 ++++++++--------------------------------
 drivers/nvme/target/nvmet.h    |  1 +
 include/linux/nvme-types.h     | 95 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 113 insertions(+), 75 deletions(-)
 create mode 100644 include/linux/nvme-types.h

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 419e0d4..daeb17e 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -20,27 +20,6 @@
 static LIST_HEAD(nvmet_ports_list);
 struct list_head *nvmet_ports = &nvmet_ports_list;
 
-struct nvmet_type_name_map {
-	u8		type;
-	const char	*name;
-};
-
-static struct nvmet_type_name_map nvmet_transport[] = {
-	{ NVMF_TRTYPE_RDMA,	"rdma" },
-	{ NVMF_TRTYPE_FC,	"fc" },
-	{ NVMF_TRTYPE_TCP,	"tcp" },
-	{ NVMF_TRTYPE_LOOP,	"loop" },
-};
-
-static const struct nvmet_type_name_map nvmet_addr_family[] = {
-	{ NVMF_ADDR_FAMILY_PCI,		"pcie" },
-	{ NVMF_ADDR_FAMILY_IP4,		"ipv4" },
-	{ NVMF_ADDR_FAMILY_IP6,		"ipv6" },
-	{ NVMF_ADDR_FAMILY_IB,		"ib" },
-	{ NVMF_ADDR_FAMILY_FC,		"fc" },
-	{ NVMF_ADDR_FAMILY_LOOP,	"loop" },
-};
-
 static bool nvmet_is_port_enabled(struct nvmet_port *p, const char *caller)
 {
 	if (p->enabled)
@@ -56,14 +35,8 @@ static bool nvmet_is_port_enabled(struct nvmet_port *p, const char *caller)
 static ssize_t nvmet_addr_adrfam_show(struct config_item *item, char *page)
 {
 	u8 adrfam = to_nvmet_port(item)->disc_addr.adrfam;
-	int i;
-
-	for (i = 1; i < ARRAY_SIZE(nvmet_addr_family); i++) {
-		if (nvmet_addr_family[i].type == adrfam)
-			return sprintf(page, "%s\n", nvmet_addr_family[i].name);
-	}
 
-	return sprintf(page, "\n");
+	return sprintf(page, "%s\n", nvme_adrfam_type_to_name(adrfam));
 }
 
 static ssize_t nvmet_addr_adrfam_store(struct config_item *item,
@@ -75,8 +48,8 @@ static ssize_t nvmet_addr_adrfam_store(struct config_item *item,
 	if (nvmet_is_port_enabled(port, __func__))
 		return -EACCES;
 
-	for (i = 1; i < ARRAY_SIZE(nvmet_addr_family); i++) {
-		if (sysfs_streq(page, nvmet_addr_family[i].name))
+	for (i = 1; i < ARRAY_SIZE(nvme_addr_family); i++) {
+		if (sysfs_streq(page, nvme_addr_family[i].name))
 			goto found;
 	}
 
@@ -84,7 +57,7 @@ static ssize_t nvmet_addr_adrfam_store(struct config_item *item,
 	return -EINVAL;
 
 found:
-	port->disc_addr.adrfam = nvmet_addr_family[i].type;
+	port->disc_addr.adrfam = nvme_addr_family[i].type;
 	return count;
 }
 
@@ -148,24 +121,12 @@ static ssize_t nvmet_addr_traddr_store(struct config_item *item,
 
 CONFIGFS_ATTR(nvmet_, addr_traddr);
 
-static const struct nvmet_type_name_map nvmet_addr_treq[] = {
-	{ NVMF_TREQ_NOT_SPECIFIED,	"not specified" },
-	{ NVMF_TREQ_REQUIRED,		"required" },
-	{ NVMF_TREQ_NOT_REQUIRED,	"not required" },
-};
-
 static ssize_t nvmet_addr_treq_show(struct config_item *item, char *page)
 {
 	u8 treq = to_nvmet_port(item)->disc_addr.treq &
 		NVME_TREQ_SECURE_CHANNEL_MASK;
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(nvmet_addr_treq); i++) {
-		if (treq == nvmet_addr_treq[i].type)
-			return sprintf(page, "%s\n", nvmet_addr_treq[i].name);
-	}
 
-	return sprintf(page, "\n");
+	return sprintf(page, "%s\n", nvme_treq_type_to_name(treq));
 }
 
 static ssize_t nvmet_addr_treq_store(struct config_item *item,
@@ -178,8 +139,8 @@ static ssize_t nvmet_addr_treq_store(struct config_item *item,
 	if (nvmet_is_port_enabled(port, __func__))
 		return -EACCES;
 
-	for (i = 0; i < ARRAY_SIZE(nvmet_addr_treq); i++) {
-		if (sysfs_streq(page, nvmet_addr_treq[i].name))
+	for (i = 0; i < ARRAY_SIZE(nvme_addr_treq); i++) {
+		if (sysfs_streq(page, nvme_addr_treq[i].name))
 			goto found;
 	}
 
@@ -187,7 +148,7 @@ static ssize_t nvmet_addr_treq_store(struct config_item *item,
 	return -EINVAL;
 
 found:
-	treq |= nvmet_addr_treq[i].type;
+	treq |= nvme_addr_treq[i].type;
 	port->disc_addr.treq = treq;
 	return count;
 }
@@ -282,14 +243,9 @@ static ssize_t nvmet_addr_trtype_show(struct config_item *item,
 		char *page)
 {
 	struct nvmet_port *port = to_nvmet_port(item);
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(nvmet_transport); i++) {
-		if (port->disc_addr.trtype == nvmet_transport[i].type)
-			return sprintf(page, "%s\n", nvmet_transport[i].name);
-	}
 
-	return sprintf(page, "\n");
+	return sprintf(page, "%s\n",
+		       nvme_trtype_to_name(port->disc_addr.trtype));
 }
 
 static void nvmet_port_init_tsas_rdma(struct nvmet_port *port)
@@ -308,8 +264,8 @@ static ssize_t nvmet_addr_trtype_store(struct config_item *item,
 	if (nvmet_is_port_enabled(port, __func__))
 		return -EACCES;
 
-	for (i = 0; i < ARRAY_SIZE(nvmet_transport); i++) {
-		if (sysfs_streq(page, nvmet_transport[i].name))
+	for (i = 0; i < ARRAY_SIZE(nvme_transport); i++) {
+		if (sysfs_streq(page, nvme_transport[i].name))
 			goto found;
 	}
 
@@ -318,7 +274,7 @@ static ssize_t nvmet_addr_trtype_store(struct config_item *item,
 
 found:
 	memset(&port->disc_addr.tsas, 0, NVMF_TSAS_SIZE);
-	port->disc_addr.trtype = nvmet_transport[i].type;
+	port->disc_addr.trtype = nvme_transport[i].type;
 	if (port->disc_addr.trtype == NVMF_TRTYPE_RDMA)
 		nvmet_port_init_tsas_rdma(port);
 	return count;
@@ -1227,27 +1183,13 @@ static struct config_group *nvmet_referral_make(
 	.ct_group_ops	= &nvmet_referral_group_ops,
 };
 
-static struct nvmet_type_name_map nvmet_ana_state[] = {
-	{ NVME_ANA_OPTIMIZED,		"optimized" },
-	{ NVME_ANA_NONOPTIMIZED,	"non-optimized" },
-	{ NVME_ANA_INACCESSIBLE,	"inaccessible" },
-	{ NVME_ANA_PERSISTENT_LOSS,	"persistent-loss" },
-	{ NVME_ANA_CHANGE,		"change" },
-};
-
 static ssize_t nvmet_ana_group_ana_state_show(struct config_item *item,
 		char *page)
 {
 	struct nvmet_ana_group *grp = to_ana_group(item);
 	enum nvme_ana_state state = grp->port->ana_state[grp->grpid];
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(nvmet_ana_state); i++) {
-		if (state == nvmet_ana_state[i].type)
-			return sprintf(page, "%s\n", nvmet_ana_state[i].name);
-	}
 
-	return sprintf(page, "\n");
+	return sprintf(page, "%s\n", nvme_ana_type_to_name(state));
 }
 
 static ssize_t nvmet_ana_group_ana_state_store(struct config_item *item,
@@ -1257,8 +1199,8 @@ static ssize_t nvmet_ana_group_ana_state_store(struct config_item *item,
 	enum nvme_ana_state *ana_state = grp->port->ana_state;
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(nvmet_ana_state); i++) {
-		if (sysfs_streq(page, nvmet_ana_state[i].name))
+	for (i = 0; i < ARRAY_SIZE(nvme_ana_states); i++) {
+		if (sysfs_streq(page, nvme_ana_states[i].name))
 			goto found;
 	}
 
@@ -1267,7 +1209,7 @@ static ssize_t nvmet_ana_group_ana_state_store(struct config_item *item,
 
 found:
 	down_write(&nvmet_ana_sem);
-	ana_state[grp->grpid] = (enum nvme_ana_state) nvmet_ana_state[i].type;
+	ana_state[grp->grpid] = (enum nvme_ana_state) nvme_ana_states[i].type;
 	nvmet_ana_chgcnt++;
 	up_write(&nvmet_ana_sem);
 	nvmet_port_send_ana_event(grp->port);
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 8096912..ce57d5f 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -15,6 +15,7 @@
 #include <linux/mutex.h>
 #include <linux/uuid.h>
 #include <linux/nvme.h>
+#include <linux/nvme-types.h>
 #include <linux/configfs.h>
 #include <linux/rcupdate.h>
 #include <linux/blkdev.h>
diff --git a/include/linux/nvme-types.h b/include/linux/nvme-types.h
new file mode 100644
index 0000000..38ed980
--- /dev/null
+++ b/include/linux/nvme-types.h
@@ -0,0 +1,95 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2020 Mellanox Technologies. All rights reserved.
+ */
+
+#ifndef _LINUX_NVME_TYPES_H
+#define _LINUX_NVME_TYPES_H
+
+#include <linux/kernel.h>
+#include <linux/nvme.h>
+
+struct nvme_type_name_map {
+	u8		type;
+	const char	*name;
+};
+
+static const struct nvme_type_name_map nvme_transport[] = {
+	{ NVMF_TRTYPE_RDMA,	"rdma" },
+	{ NVMF_TRTYPE_FC,	"fc" },
+	{ NVMF_TRTYPE_TCP,	"tcp" },
+	{ NVMF_TRTYPE_LOOP,	"loop" },
+};
+
+static inline const char *nvme_trtype_to_name(u8 type)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(nvme_transport); i++) {
+		if (type == nvme_transport[i].type)
+			return nvme_transport[i].name;
+	}
+
+	return "invalid";
+}
+
+static const struct nvme_type_name_map nvme_addr_family[] = {
+	{ NVMF_ADDR_FAMILY_PCI,		"pcie" },
+	{ NVMF_ADDR_FAMILY_IP4,		"ipv4" },
+	{ NVMF_ADDR_FAMILY_IP6,		"ipv6" },
+	{ NVMF_ADDR_FAMILY_IB,		"ib" },
+	{ NVMF_ADDR_FAMILY_FC,		"fc" },
+	{ NVMF_ADDR_FAMILY_LOOP,	"loop" },
+};
+
+static inline const char *nvme_adrfam_type_to_name(u8 type)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(nvme_addr_family); i++) {
+		if (type == nvme_addr_family[i].type)
+			return nvme_addr_family[i].name;
+	}
+
+	return "invalid";
+}
+
+static const struct nvme_type_name_map nvme_addr_treq[] = {
+	{ NVMF_TREQ_NOT_SPECIFIED,	"not specified" },
+	{ NVMF_TREQ_REQUIRED,		"required" },
+	{ NVMF_TREQ_NOT_REQUIRED,	"not required" },
+};
+
+static inline const char *nvme_treq_type_to_name(u8 type)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(nvme_addr_treq); i++) {
+		if (type == nvme_addr_treq[i].type)
+			return nvme_addr_treq[i].name;
+	}
+
+	return "invalid";
+}
+
+static const struct nvme_type_name_map nvme_ana_states[] = {
+	{ NVME_ANA_OPTIMIZED,		"optimized" },
+	{ NVME_ANA_NONOPTIMIZED,	"non-optimized" },
+	{ NVME_ANA_INACCESSIBLE,	"inaccessible" },
+	{ NVME_ANA_PERSISTENT_LOSS,	"persistent-loss" },
+	{ NVME_ANA_CHANGE,		"change" },
+};
+
+static inline const char *nvme_ana_type_to_name(u8 type)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(nvme_ana_states); i++) {
+		if (type == nvme_ana_states[i].type)
+			return nvme_ana_states[i].name;
+	}
+
+	return "invalid";
+}
+
+#endif /* _LINUX_NVME_TYPES_H */
-- 
1.8.3.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

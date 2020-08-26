Return-Path: <SRS0=GC6h=CE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E63A6C433E1
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Aug 2020 10:49:23 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A67FF206EB
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Aug 2020 10:49:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lfKq9xTp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A67FF206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=qljx5MF85zcpdtQRe23eHgCxdahB23ABIgCF6hl1BUE=; b=lfKq9xTpT1+LWlG+XtWI+P4+il
	uL5EvWflpBML8DLDsBbhXEavOKKakFzaxZF3ZwgIluZdHG3sL1eNQC2B2tUJBkgrmL86g5ZOglZ68
	hqY/nlxzQZlES6YUELRz6HlcDeS3N5ZMj4w91jHMLFnkMfccortYLQFy+yNDERHDyPeIwpQfx0g9l
	XCgOxjrw7ZtX16rNAKRIW/tlRJHM0YsU5saKL/XKiEFMFX7wIdQIzsWR2WOBTXiTKk/K17obj0+Tm
	8UNe1jdlsRLkhnum9nW/ZVC1Yz3RuUSqh6ggE2C40REd1VAYadQrRUmSj0m4IiamW2AFyYdHf6eXu
	3nXFTPNQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kAszT-00087A-Ff; Wed, 26 Aug 2020 10:49:15 +0000
Received: from mail-il-dmz.mellanox.com ([193.47.165.129] helo=mellanox.co.il)
 by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kAszO-00086Z-PD
 for linux-nvme@lists.infradead.org; Wed, 26 Aug 2020 10:49:13 +0000
Received: from Internal Mail-Server by MTLPINE1 (envelope-from
 mgurtovoy@nvidia.com) with SMTP; 26 Aug 2020 13:49:03 +0300
Received: from mtr-vdi-031.wap.labs.mlnx. (mtr-vdi-031.wap.labs.mlnx
 [10.209.102.136])
 by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 07QAn319011170;
 Wed, 26 Aug 2020 13:49:03 +0300
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: sagi@grimberg.me, linux-nvme@lists.infradead.org, kbusch@kernel.org,
 hch@lst.de
Subject: [PATCH 1/1] nvme: add support for non shared namespaces
Date: Wed, 26 Aug 2020 13:49:03 +0300
Message-Id: <20200826104903.85321-1-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200826_064911_140511_F1402E03 
X-CRM114-Status: GOOD (  18.86  )
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
Cc: israelr@nvidia.com, Max Gurtovoy <mgurtovoy@nvidia.com>, nitzanc@nvidia.com,
 oren@nvidia.com, Max Gurtovoy <maxg@mellanox.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Currently, nvme-cli assume that all the namespaces in an NVM subsystem
are shared between all the controllers. There is an option to create
both shared and non-shared namespaces among the controllers in the same
NVM subsystem. For example, in SR-IOV environment, one can attach 1
namespace to each controller that will be private and also 1 namespace
that will be shared among the secondary controllers only. In this case,
the output of "nvme list -v" will be wrong:

NVM Express Subsystems

Subsystem        Subsystem-NQN                                                                                    Controllers
---------------- ------------------------------------------------------------------------------------------------ ----------------
nvme-subsys5     nqn.1994-11.com.samsung:nvme:PM1733:2.5-inch:S4YNNE0N700448                                      nvme18, nvme19, nvme20, nvme21, nvme5

NVM Express Controllers

Device   SN                   MN                                       FR       TxPort Address        Subsystem    Namespaces
-------- -------------------- ---------------------------------------- -------- ------ -------------- ------------ ----------------
nvme18   S4YNNE0N700448       SAMSUNG MZWLJ1T9HBJR-00007               EPK98B5Q pcie   0000:0a:00.1   nvme-subsys5 nvme5n1, nvme5n2, nvme5n3, nvme5n4, nvme5n5, nvme5n6
nvme19   S4YNNE0N700448       SAMSUNG MZWLJ1T9HBJR-00007               EPK98B5Q pcie   0000:0a:00.2   nvme-subsys5 nvme5n1, nvme5n2, nvme5n3, nvme5n4, nvme5n5, nvme5n6
nvme20   S4YNNE0N700448       SAMSUNG MZWLJ1T9HBJR-00007               EPK98B5Q pcie   0000:0a:00.3   nvme-subsys5 nvme5n1, nvme5n2, nvme5n3, nvme5n4, nvme5n5, nvme5n6
nvme21   S4YNNE0N700448       SAMSUNG MZWLJ1T9HBJR-00007               EPK98B5Q pcie   0000:0a:00.4   nvme-subsys5 nvme5n1, nvme5n2, nvme5n3, nvme5n4, nvme5n5, nvme5n6
nvme5    S4YNNE0N700448       SAMSUNG MZWLJ1T9HBJR-00007               EPK98B5Q pcie   0000:0a:00.0   nvme-subsys5 nvme5n1, nvme5n2, nvme5n3, nvme5n4, nvme5n5, nvme5n6

NVM Express Namespaces

Device       NSID     Usage                      Format           Controllers
------------ -------- -------------------------- ---------------- ----------------
nvme5n1      1        343.60  GB / 343.60  GB    512   B +  0 B   nvme18, nvme19, nvme20, nvme21, nvme5
nvme5n2      2        274.88  GB / 274.88  GB    512   B +  0 B   nvme18, nvme19, nvme20, nvme21, nvme5
nvme5n3      3        283.47  GB / 283.47  GB    512   B +  0 B   nvme18, nvme19, nvme20, nvme21, nvme5
nvme5n4      4        292.06  GB / 292.06  GB    512   B +  0 B   nvme18, nvme19, nvme20, nvme21, nvme5
nvme5n5      5        317.83  GB / 317.83  GB    512   B +  0 B   nvme18, nvme19, nvme20, nvme21, nvme5
nvme5n6      6        137.44  GB / 137.44  GB    512   B +  0 B   nvme18, nvme19, nvme20, nvme21, nvme5

After the fix we'll get the following right topology:

NVM Express Subsystems

Subsystem        Subsystem-NQN                                                                                    Controllers
---------------- ------------------------------------------------------------------------------------------------ ----------------
nvme-subsys5     nqn.1994-11.com.samsung:nvme:PM1733:2.5-inch:S4YNNE0N700448                                      nvme18, nvme19, nvme20, nvme21, nvme5

NVM Express Controllers

Device   SN                   MN                                       FR       TxPort Address        Subsystem    Namespaces
-------- -------------------- ---------------------------------------- -------- ------ -------------- ------------ ----------------
nvme18   S4YNNE0N700448       SAMSUNG MZWLJ1T9HBJR-00007               EPK98B5Q pcie   0000:0a:00.1   nvme-subsys5 nvme5n2, nvme5n6
nvme19   S4YNNE0N700448       SAMSUNG MZWLJ1T9HBJR-00007               EPK98B5Q pcie   0000:0a:00.2   nvme-subsys5 nvme5n3, nvme5n6
nvme20   S4YNNE0N700448       SAMSUNG MZWLJ1T9HBJR-00007               EPK98B5Q pcie   0000:0a:00.3   nvme-subsys5 nvme5n4, nvme5n6
nvme21   S4YNNE0N700448       SAMSUNG MZWLJ1T9HBJR-00007               EPK98B5Q pcie   0000:0a:00.4   nvme-subsys5 nvme5n5, nvme5n6
nvme5    S4YNNE0N700448       SAMSUNG MZWLJ1T9HBJR-00007               EPK98B5Q pcie   0000:0a:00.0   nvme-subsys5 nvme5n1

NVM Express Namespaces

Device       NSID     Usage                      Format           Controllers
------------ -------- -------------------------- ---------------- ----------------
nvme5n1      1        343.60  GB / 343.60  GB    512   B +  0 B   nvme5
nvme5n2      2        274.88  GB / 274.88  GB    512   B +  0 B   nvme18
nvme5n3      3        283.47  GB / 283.47  GB    512   B +  0 B   nvme19
nvme5n4      4        292.06  GB / 292.06  GB    512   B +  0 B   nvme20
nvme5n5      5        317.83  GB / 317.83  GB    512   B +  0 B   nvme21
nvme5n6      6        137.44  GB / 137.44  GB    512   B +  0 B   nvme18, nvme19, nvme20, nvme21

Cc: Max Gurtovoy <maxg@mellanox.com>
Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 nvme-filters.c  | 16 ++++++++++++
 nvme-print.c    | 66 +++++++++++++++++++++++++++++++++----------------
 nvme-topology.c | 66 ++++++++++++++++++++++++++++++++++++++-----------
 nvme.h          |  1 +
 4 files changed, 114 insertions(+), 35 deletions(-)

diff --git a/nvme-filters.c b/nvme-filters.c
index a4133f8..17c375f 100644
--- a/nvme-filters.c
+++ b/nvme-filters.c
@@ -7,6 +7,22 @@
 /* global, used for controller specific namespace filter */
 int current_index;
 
+int scan_ctrl_namespace_filter(const struct dirent *d)
+{
+	int c, i, n;
+
+	if (d->d_name[0] == '.')
+		return 0;
+
+	if (strstr(d->d_name, "nvme")) {
+		if (sscanf(d->d_name, "nvme%dc%dn%d", &i, &c, &n) == 3)
+			return 1;
+		if (sscanf(d->d_name, "nvme%dn%d", &i, &n) == 2)
+			return 1;
+	}
+	return 0;
+}
+
 int scan_namespace_filter(const struct dirent *d)
 {
 	int i, n;
diff --git a/nvme-print.c b/nvme-print.c
index f037a28..5e5143a 100644
--- a/nvme-print.c
+++ b/nvme-print.c
@@ -3,6 +3,7 @@
 #include <string.h>
 #include <stdlib.h>
 #include <time.h>
+#include <sys/stat.h>
 
 #include "nvme-print.h"
 #include "util/json.h"
@@ -4670,7 +4671,14 @@ static void nvme_show_list_item(struct nvme_namespace *n)
 	const char *l_suffix = suffix_binary_get(&lba);
 
 	char usage[128];
-	char format[128];
+	char format[128], path[256];
+	struct stat st;
+	int ret;
+
+	sprintf(path, "/dev/%s", n->name);
+	ret = stat(path, &st);
+	if (ret < 0)
+		return;
 
 	sprintf(usage,"%6.2f %2sB / %6.2f %2sB", nuse, u_suffix,
 		nsze, s_suffix);
@@ -4734,17 +4742,29 @@ static void nvme_show_details_ns(struct nvme_namespace *n, bool ctrl)
 		printf("%s", n->ctrl->name);
 	else {
 		struct nvme_subsystem *s = n->ctrl->subsys;
-		int i;
+		int i, j;
+		bool comma = false;
+
+		for (i = 0; i < s->nr_ctrls; i++) {
+			struct nvme_ctrl *c = &s->ctrls[i];
 
-		for (i = 0; i < s->nr_ctrls; i++)
-			printf("%s%s", i ? ", " : "", s->ctrls[i].name);
+			for (j = 0; j < c->nr_namespaces; j++) {
+				struct nvme_namespace *ns = &c->namespaces[j];
+
+				if (ns->nsid == n->nsid) {
+					printf("%s%s", comma ? ", " : "",
+					       c->name);
+					comma = true;
+				}
+			}
+		}
 	}
 	printf("\n");
 }
 
 static void nvme_show_detailed_list(struct nvme_topology *t)
 {
-	int i, j, k;
+	int i, j, k, l;
 
 	printf("NVM Express Subsystems\n\n");
 	printf("%-16s %-96s %-.16s\n", "Subsystem", "Subsystem-NQN", "Controllers");
@@ -4779,13 +4799,14 @@ static void nvme_show_detailed_list(struct nvme_topology *t)
 
 			for (k = 0; k < c->nr_namespaces; k++) {
 				struct nvme_namespace *n = &c->namespaces[k];
-				printf("%s%s", comma ? ", " : "", n->name);
-				comma = true;
-			}
-			for (k = 0; k < s->nr_namespaces; k++) {
-				struct nvme_namespace *n = &s->namespaces[k];
-				printf("%s%s", comma ? ", " : "", n->name);
-				comma = true;
+
+				for (l = 0; l < s->nr_namespaces; l++) {
+					struct nvme_namespace *ns = &s->namespaces[l];
+					if (n->nsid == ns->nsid) {
+						printf("%s%s", comma ? ", " : "", ns->name);
+						comma = true;
+					}
+				}
 			}
 			printf("\n");
 		}
@@ -4798,18 +4819,21 @@ static void nvme_show_detailed_list(struct nvme_topology *t)
 	for (i = 0; i < t->nr_subsystems; i++) {
 		struct nvme_subsystem *s = &t->subsystems[i];
 
-		for (j = 0; j < s->nr_ctrls; j++) {
-			struct nvme_ctrl *c = &s->ctrls[j];
+		if (s->nr_namespaces) {
+			for (j = 0; j < s->nr_namespaces; j++) {
+				struct nvme_namespace *n = &s->namespaces[j];
+				nvme_show_details_ns(n, false);
+			}
+		} else {
+			for (j = 0; j < s->nr_ctrls; j++) {
+				struct nvme_ctrl *c = &s->ctrls[j];
 
-			for (k = 0; k < c->nr_namespaces; k++) {
-				struct nvme_namespace *n = &c->namespaces[k];
-				nvme_show_details_ns(n, true);
+				for (k = 0; k < c->nr_namespaces; k++) {
+					struct nvme_namespace *n = &c->namespaces[k];
+					nvme_show_details_ns(n, true);
+				}
 			}
 		}
-		for (j = 0; j < s->nr_namespaces; j++) {
-			struct nvme_namespace *n = &s->namespaces[j];
-			nvme_show_details_ns(n, false);
-		}
 	}
 }
 
diff --git a/nvme-topology.c b/nvme-topology.c
index d24ef6b..94a4c56 100644
--- a/nvme-topology.c
+++ b/nvme-topology.c
@@ -152,9 +152,11 @@ static int scan_namespace(struct nvme_namespace *n)
 	if (fd < 0)
 		goto free;
 
-	n->nsid = nvme_get_nsid(fd);
-	if (n->nsid < 0)
-		goto close_fd;
+	if (!n->nsid) {
+		n->nsid = nvme_get_nsid(fd);
+		if (n->nsid < 0)
+			goto close_fd;
+	}
 
 	ret = nvme_identify_ns(fd, n->nsid, 0, &n->ns);
 	if (ret < 0)
@@ -248,7 +250,7 @@ static int scan_ctrl(struct nvme_ctrl *c, char *p, __u32 ns_instance)
 	if (ns_instance)
 		c->ana_state = get_nvme_ctrl_path_ana_state(path, ns_instance);
 
-	ret = scandir(path, &ns, scan_namespace_filter, alphasort);
+	ret = scandir(path, &ns, scan_ctrl_namespace_filter, alphasort);
 	if (ret == -1) {
 		fprintf(stderr, "Failed to open %s: %s\n", path, strerror(errno));
 		return errno;
@@ -256,11 +258,36 @@ static int scan_ctrl(struct nvme_ctrl *c, char *p, __u32 ns_instance)
 
 	c->nr_namespaces = ret;
 	c->namespaces = calloc(c->nr_namespaces, sizeof(*n));
-	for (i = 0; i < c->nr_namespaces; i++) {
-		n = &c->namespaces[i];
-		n->name = strdup(ns[i]->d_name);
-		n->ctrl = c;
-		scan_namespace(n);
+	if (c->namespaces) {
+		for (i = 0; i < c->nr_namespaces; i++) {
+			char *ns_path, nsid[16];
+			int ns_fd;
+
+			n = &c->namespaces[i];
+			n->name = strdup(ns[i]->d_name);
+			n->ctrl = c;
+			ret = asprintf(&ns_path, "%s/%s/nsid", path, n->name);
+			if (ret < 0)
+				continue;
+			ns_fd = open(ns_path, O_RDONLY);
+			if (ns_fd < 0) {
+				free(ns_path);
+				continue;
+			}
+			ret = read(ns_fd, nsid, 16);
+			if (ret < 0) {
+				close(ns_fd);
+				free(ns_path);
+				continue;
+			}
+			n->nsid = (unsigned)strtol(nsid, NULL, 10);
+			scan_namespace(n);
+			close(ns_fd);
+			free(ns_path);
+		}
+	} else {
+		i = c->nr_namespaces;
+		c->nr_namespaces = 0;
 	}
 
 	while (i--)
@@ -327,11 +354,16 @@ static int scan_subsystem(struct nvme_subsystem *s, __u32 ns_instance)
 
 	s->nr_namespaces = ret;
 	s->namespaces = calloc(s->nr_namespaces, sizeof(*n));
-	for (i = 0; i < s->nr_namespaces; i++) {
-		n = &s->namespaces[i];
-		n->name = strdup(ns[i]->d_name);
-		n->ctrl = &s->ctrls[0];
-		scan_namespace(n);
+	if (s->namespaces) {
+		for (i = 0; i < s->nr_namespaces; i++) {
+			n = &s->namespaces[i];
+			n->name = strdup(ns[i]->d_name);
+			n->ctrl = &s->ctrls[0];
+			scan_namespace(n);
+		}
+	} else {
+		i = s->nr_namespaces;
+		s->nr_namespaces = 0;
 	}
 
 	while (i--)
@@ -420,6 +452,12 @@ static int legacy_list(struct nvme_topology *t)
 		c->nr_namespaces = scandir(dev, &namespaces, scan_dev_filter,
 					   alphasort);
 		c->namespaces = calloc(c->nr_namespaces, sizeof(*n));
+		if (!c->namespaces) {
+			while (c->nr_namespaces--)
+				free(namespaces[c->nr_namespaces]);
+			free(namespaces);
+			continue;
+		}
 
 		ret = asprintf(&path, "%s%s", dev, c->name);
 		if (ret < 0)
diff --git a/nvme.h b/nvme.h
index ffc3fbd..9a54bdb 100644
--- a/nvme.h
+++ b/nvme.h
@@ -97,6 +97,7 @@ char *nvme_char_from_block(char *block);
 void *mmap_registers(const char *dev);
 
 extern int current_index;
+int scan_ctrl_namespace_filter(const struct dirent *d);
 int scan_namespace_filter(const struct dirent *d);
 int scan_ctrl_paths_filter(const struct dirent *d);
 int scan_ctrls_filter(const struct dirent *d);
-- 
2.25.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21412C36010
	for <linux-nvme@archiver.kernel.org>; Sat,  5 Apr 2025 13:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AVEk2WlG1ou3S7c7EsnPin/pDfyRcSo+0Vv02650DtU=; b=3U2ZurlVgO+pEEfFkSZf2jQLc7
	b+EETjkhzbft/1TBJ/nre0vLNCJVEvF0WbAEcIWTg1SXd7OMxn0Z57rruNtQGxEPcfPA+sPVd876n
	xJR9OgmBkhzJDvYPCRq6y5Kk8mw/agz8yizB1Ir7OUWC2/rKkRfbMq3sNRDLQ6qUgR+y/vOv9Osdg
	NbCaVHR5JNg9z/71B5a12X/jR33MQTPD96e2dDzMxVVBDf/afyGYzK10Hj4hVRTlpGx/jKp0qL09G
	ct5IKwbCBQDQ5c5Rrs+LqERzCbq1TYfG8M6JLkUc0HeB/lmErdhb0m0TXFuMKkqPvQ6aD2yXkD0xw
	+v8GwNaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u13B9-0000000Dy9G-1KVB;
	Sat, 05 Apr 2025 13:03:19 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u13B5-0000000Dy83-2SrU
	for linux-nvme@lists.infradead.org;
	Sat, 05 Apr 2025 13:03:16 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 535ASuqi016250;
	Sat, 5 Apr 2025 13:03:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=AVEk2WlG1ou3S7c7E
	snPin/pDfyRcSo+0Vv02650DtU=; b=LDnK9U1dx3v5y7D+MshWeZJnq0P13wDNd
	2GQL9RfmTLCAfOKwjqtZ2n+y5PAlbwtJI3kX9WivLbU4xiOwgAs7aEoGWF7O+Hfw
	qxhN2HirdDLtz0ztjCL74IEQ/0vosYAHPoMhaK7nrNnZuY3ZGOYWQ04h5A0FZWyX
	IF75mTjGUZS8GhGwyGe9GOicEJaVkVPLEjUdFvU/fF5cmR0b+5X05EIf5qOaENrg
	SCvhx7TheJZU7KU1jJeF3ELJ1F62BqlLSqLO0D9PWhC3oMnTpSSlJgHZlgT7iaUi
	oryKMGHLGbUp+FrXwyDXDQYSeMg+Zj4QtGYL14yz28UQ57JucFvOw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45ttxj9q77-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 05 Apr 2025 13:03:03 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 535AGW8j019464;
	Sat, 5 Apr 2025 13:03:03 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45t2cc7f1v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 05 Apr 2025 13:03:02 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 535D31uu48890252
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 5 Apr 2025 13:03:01 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E5B7A2004B;
	Sat,  5 Apr 2025 13:03:00 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D412220040;
	Sat,  5 Apr 2025 13:02:58 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.171.30.151])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat,  5 Apr 2025 13:02:58 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, hare@kernel.org, kbusch@kernel.org, gjoyce@ibm.com
Subject: [PATCH 1/3] tree: add support for discovering nvme paths using sysfs multipath link
Date: Sat,  5 Apr 2025 18:32:47 +0530
Message-ID: <20250405130255.448345-2-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250405130255.448345-1-nilay@linux.ibm.com>
References: <20250405130255.448345-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: KKs5C6boPDfFDQfiBwnj80b8HgXqyMoz
X-Proofpoint-GUID: KKs5C6boPDfFDQfiBwnj80b8HgXqyMoz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-05_06,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 clxscore=1015 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504050080
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250405_060315_751127_B1D75516 
X-CRM114-Status: GOOD (  27.09  )
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

With kernel v6.14, when NVMe native multipath is enabled, it is possible
to discover all paths to a shared namespace using the sysfs multipath link.
Leverage this functionality to update the path links for each shared NVMe
namespace, simplifying path discovery and management. Please note that
this change is fully backward compatible.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 src/nvme/filters.c |   6 ++
 src/nvme/filters.h |   9 +++
 src/nvme/private.h |   9 ++-
 src/nvme/tree.c    | 162 +++++++++++++++++++++++++++++++--------------
 src/nvme/tree.h    |   9 +++
 5 files changed, 143 insertions(+), 52 deletions(-)

diff --git a/src/nvme/filters.c b/src/nvme/filters.c
index ceaba68f..4a8829db 100644
--- a/src/nvme/filters.c
+++ b/src/nvme/filters.c
@@ -105,3 +105,9 @@ int nvme_scan_ctrl_namespaces(nvme_ctrl_t c, struct dirent ***ns)
 	return scandir(nvme_ctrl_get_sysfs_dir(c), ns,
 		       nvme_namespace_filter, alphasort);
 }
+
+int nvme_scan_ns_head_paths(nvme_ns_head_t head, struct dirent ***paths)
+{
+	return scandir(nvme_ns_head_get_sysfs_dir(head), paths,
+		       nvme_paths_filter, alphasort);
+}
diff --git a/src/nvme/filters.h b/src/nvme/filters.h
index 4ceeffd5..9e9dbb95 100644
--- a/src/nvme/filters.h
+++ b/src/nvme/filters.h
@@ -94,4 +94,13 @@ int nvme_scan_ctrl_namespace_paths(nvme_ctrl_t c, struct dirent ***paths);
  */
 int nvme_scan_ctrl_namespaces(nvme_ctrl_t c, struct dirent ***ns);
 
+/**
+ * nvme_scan_ns_head_paths() - Scan for namespace paths
+ * @head: Namespace head node to scan
+ * @paths : Pointer to array of dirents
+ *
+ * Return: number of entries in @ents
+ */
+int nvme_scan_ns_head_paths(nvme_ns_head_t head, struct dirent ***paths);
+
 #endif /* _LIBNVME_FILTERS_H */
diff --git a/src/nvme/private.h b/src/nvme/private.h
index 33cdd555..f45c5823 100644
--- a/src/nvme/private.h
+++ b/src/nvme/private.h
@@ -36,12 +36,19 @@ struct nvme_path {
 	int grpid;
 };
 
+struct nvme_ns_head {
+	struct list_head paths;
+	struct nvme_ns *n;
+
+	char *sysfs_dir;
+};
+
 struct nvme_ns {
 	struct list_node entry;
-	struct list_head paths;
 
 	struct nvme_subsystem *s;
 	struct nvme_ctrl *c;
+	struct nvme_ns_head *head;
 
 	int fd;
 	__u32 nsid;
diff --git a/src/nvme/tree.c b/src/nvme/tree.c
index b0a4696f..bd7fb53e 100644
--- a/src/nvme/tree.c
+++ b/src/nvme/tree.c
@@ -564,12 +564,12 @@ nvme_ns_t nvme_subsystem_next_ns(nvme_subsystem_t s, nvme_ns_t n)
 
 nvme_path_t nvme_namespace_first_path(nvme_ns_t ns)
 {
-	return list_top(&ns->paths, struct nvme_path, nentry);
+	return list_top(&ns->head->paths, struct nvme_path, nentry);
 }
 
 nvme_path_t nvme_namespace_next_path(nvme_ns_t ns, nvme_path_t p)
 {
-	return p ? list_next(&ns->paths, p, nentry) : NULL;
+	return p ? list_next(&ns->head->paths, p, nentry) : NULL;
 }
 
 static void __nvme_free_ns(struct nvme_ns *n)
@@ -579,6 +579,8 @@ static void __nvme_free_ns(struct nvme_ns *n)
 	free(n->generic_name);
 	free(n->name);
 	free(n->sysfs_dir);
+	free(n->head->sysfs_dir);
+	free(n->head);
 	free(n);
 }
 
@@ -916,25 +918,6 @@ void nvme_free_path(struct nvme_path *p)
 	free(p);
 }
 
-static void nvme_subsystem_set_path_ns(nvme_subsystem_t s, nvme_path_t p)
-{
-	char n_name[32] = { };
-	int i, c, nsid, ret;
-	nvme_ns_t n;
-
-	ret = sscanf(nvme_path_get_name(p), "nvme%dc%dn%d", &i, &c, &nsid);
-	if (ret != 3)
-		return;
-
-	sprintf(n_name, "nvme%dn%d", i, nsid);
-	nvme_subsystem_for_each_ns(s, n) {
-		if (!strcmp(n_name, nvme_ns_get_name(n))) {
-			list_add_tail(&n->paths, &p->nentry);
-			p->n = n;
-		}
-	}
-}
-
 static int nvme_ctrl_scan_path(nvme_root_t r, struct nvme_ctrl *c, char *name)
 {
 	struct nvme_path *p;
@@ -973,7 +956,6 @@ static int nvme_ctrl_scan_path(nvme_root_t r, struct nvme_ctrl *c, char *name)
 	}
 
 	list_node_init(&p->nentry);
-	nvme_subsystem_set_path_ns(c->s, p);
 	list_node_init(&p->entry);
 	list_add_tail(&c->paths, &p->entry);
 	return 0;
@@ -2250,8 +2232,8 @@ nvme_ctrl_t nvme_scan_ctrl(nvme_root_t r, const char *name)
 		return NULL;
 
 	path = NULL;
-	nvme_ctrl_scan_namespaces(r, c);
 	nvme_ctrl_scan_paths(r, c);
+	nvme_ctrl_scan_namespaces(r, c);
 	return c;
 }
 
@@ -2323,6 +2305,11 @@ const char *nvme_ns_get_sysfs_dir(nvme_ns_t n)
 	return n->sysfs_dir;
 }
 
+const char *nvme_ns_head_get_sysfs_dir(nvme_ns_head_t head)
+{
+	return head->sysfs_dir;
+}
+
 const char *nvme_ns_get_name(nvme_ns_t n)
 {
 	return n->name;
@@ -2749,7 +2736,11 @@ static void nvme_ns_set_generic_name(struct nvme_ns *n, const char *name)
 
 static nvme_ns_t nvme_ns_open(const char *sys_path, const char *name)
 {
+	int ret;
 	struct nvme_ns *n;
+	struct nvme_ns_head *head;
+	struct stat arg;
+	_cleanup_free_ char *path = NULL;
 
 	n = calloc(1, sizeof(*n));
 	if (!n) {
@@ -2757,6 +2748,32 @@ static nvme_ns_t nvme_ns_open(const char *sys_path, const char *name)
 		return NULL;
 	}
 
+	head = calloc(1, sizeof(*head));
+	if (!head) {
+		errno = ENOMEM;
+		free(n);
+		return NULL;
+	}
+
+	head->n = n;
+	list_head_init(&head->paths);
+	ret = asprintf(&path, "%s/%s", sys_path, "multipath");
+	if (ret < 0) {
+		errno = ENOMEM;
+		goto free_ns_head;
+	}
+	/*
+	 * The sysfs-dir "multipath" is available only when nvme multipath
+	 * is configured and we're running kernel version >= 6.14.
+	 */
+	ret = stat(path, &arg);
+	if (ret == 0) {
+		head->sysfs_dir = path;
+		path = NULL;
+	} else
+		head->sysfs_dir = NULL;
+
+	n->head = head;
 	n->fd = -1;
 	n->name = strdup(name);
 
@@ -2765,15 +2782,17 @@ static nvme_ns_t nvme_ns_open(const char *sys_path, const char *name)
 	if (nvme_ns_init(sys_path, n) != 0)
 		goto free_ns;
 
-	list_head_init(&n->paths);
 	list_node_init(&n->entry);
 
 	nvme_ns_release_fd(n); /* Do not leak fds */
+
 	return n;
 
 free_ns:
 	free(n->generic_name);
 	free(n->name);
+free_ns_head:
+	free(head);
 	free(n);
 	return NULL;
 }
@@ -2836,6 +2855,71 @@ nvme_ns_t nvme_scan_namespace(const char *name)
 	return __nvme_scan_namespace(nvme_ns_sysfs_dir(), name);
 }
 
+
+static void nvme_ns_head_scan_path(nvme_subsystem_t s, nvme_ns_t n, char *name)
+{
+	nvme_ctrl_t c;
+	nvme_path_t p;
+
+	nvme_subsystem_for_each_ctrl(s, c) {
+		nvme_ctrl_for_each_path(c, p) {
+			if (!strcmp(nvme_path_get_name(p), name)) {
+				list_add_tail(&n->head->paths, &p->nentry);
+				p->n = n;
+				return;
+			}
+		}
+	}
+}
+
+static void nvme_subsystem_set_ns_path(nvme_subsystem_t s, nvme_ns_t n)
+{
+	struct nvme_ns_head *head = n->head;
+
+	if (nvme_ns_head_get_sysfs_dir(head)) {
+		struct dirents paths = {};
+		int i;
+
+		/*
+		 * When multipath is configured on kernel version >= 6.14,
+		 * we use multipath sysfs link to get each path of a namespace.
+		 */
+		paths.num = nvme_scan_ns_head_paths(head, &paths.ents);
+
+		for (i = 0; i < paths.num; i++)
+			nvme_ns_head_scan_path(s, n, paths.ents[i]->d_name);
+	} else {
+		nvme_ctrl_t c;
+		nvme_path_t p;
+		int ns_ctrl, ns_nsid, ret;
+
+		/*
+		 * If multipath is not configured or we're running on kernel
+		 * version < 6.14, fallback to the old way.
+		 */
+		ret = sscanf(nvme_ns_get_name(n), "nvme%dn%d",
+				&ns_ctrl, &ns_nsid);
+		if (ret != 2)
+			return;
+
+		nvme_subsystem_for_each_ctrl(s, c) {
+			nvme_ctrl_for_each_path(c, p) {
+				int p_subsys, p_ctrl, p_nsid;
+
+				ret = sscanf(nvme_path_get_name(p),
+					     "nvme%dc%dn%d",
+					     &p_subsys, &p_ctrl, &p_nsid);
+				if (ret != 3)
+					continue;
+				if (ns_ctrl == p_subsys && ns_nsid == p_nsid) {
+					list_add_tail(&head->paths, &p->nentry);
+					p->n = n;
+				}
+			}
+		}
+	}
+}
+
 static int nvme_ctrl_scan_namespace(nvme_root_t r, struct nvme_ctrl *c,
 				    char *name)
 {
@@ -2861,33 +2945,9 @@ static int nvme_ctrl_scan_namespace(nvme_root_t r, struct nvme_ctrl *c,
 	n->s = c->s;
 	n->c = c;
 	list_add_tail(&c->namespaces, &n->entry);
-	return 0;
-}
-
-static void nvme_subsystem_set_ns_path(nvme_subsystem_t s, nvme_ns_t n)
-{
-	nvme_ctrl_t c;
-	nvme_path_t p;
-	int ns_ctrl, ns_nsid, ret;
-
-	ret = sscanf(nvme_ns_get_name(n), "nvme%dn%d", &ns_ctrl, &ns_nsid);
-	if (ret != 2)
-		return;
+	nvme_subsystem_set_ns_path(c->s, n);
 
-	nvme_subsystem_for_each_ctrl(s, c) {
-		nvme_ctrl_for_each_path(c, p) {
-			int p_subsys, p_ctrl, p_nsid;
-
-			ret = sscanf(nvme_path_get_name(p), "nvme%dc%dn%d",
-				     &p_subsys, &p_ctrl, &p_nsid);
-			if (ret != 3)
-				continue;
-			if (ns_ctrl == p_subsys && ns_nsid == p_nsid) {
-				list_add_tail(&n->paths, &p->nentry);
-				p->n = n;
-			}
-		}
-	}
+	return 0;
 }
 
 static int nvme_subsystem_scan_namespace(nvme_root_t r, nvme_subsystem_t s,
@@ -2917,7 +2977,7 @@ static int nvme_subsystem_scan_namespace(nvme_root_t r, nvme_subsystem_t s,
 			list_del_init(&p->nentry);
 			p->n = NULL;
 		}
-		list_head_init(&_n->paths);
+		list_head_init(&_n->head->paths);
 		__nvme_free_ns(_n);
 	}
 	n->s = s;
diff --git a/src/nvme/tree.h b/src/nvme/tree.h
index 25d4b31b..9f382e9c 100644
--- a/src/nvme/tree.h
+++ b/src/nvme/tree.h
@@ -27,6 +27,7 @@
  */
 
 typedef struct nvme_ns *nvme_ns_t;
+typedef struct nvme_ns_head *nvme_ns_head_t;
 typedef struct nvme_path *nvme_path_t;
 typedef struct nvme_ctrl *nvme_ctrl_t;
 typedef struct nvme_subsystem *nvme_subsystem_t;
@@ -1091,6 +1092,14 @@ void nvme_ctrl_set_dhchap_host_key(nvme_ctrl_t c, const char *key);
  */
 const char *nvme_ctrl_get_dhchap_key(nvme_ctrl_t c);
 
+/**
+ * nvme_ns_head_get_sysfs_dir() - sysfs dir of namespave head
+ * @head: namespace head instance
+ *
+ * Returns: sysfs directory name of @head
+ */
+const char *nvme_ns_head_get_sysfs_dir(nvme_ns_head_t head);
+
 /**
  * nvme_ctrl_set_dhchap_key() - Set controller key
  * @c:		Controller for which the key should be set
-- 
2.49.0



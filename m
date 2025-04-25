Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31110C369D7
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Apr 2025 18:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+SdbXKZSP3P+TzrZtm/Vvbrd0p2tFRTA+0bERHaAnB0=; b=Fj8SQq7Dnk06Scqh/ttj2W/rLN
	WYbUJWwHKxVFS0HPUltu69EFWJuTuQLiA+2fEKwKMWXmVTETZApeB170TbbiCzfexbqjzlFgo/xuh
	V1j4EVpNX8Oi980uPHZbhMyO+NlWGJb8PnHibjGplvPG1q7tFE2+GiXb9ea+rplvOtEb3PG5Nnjma
	DhbBwJ+3SVT5q3u4jyX6SQ9v0BRDqVuQo9cvVVKmgv+e7rKWznWAl9Acmh0Sr/1vFUSsqz+J73OJ+
	sx0Y2wIrmcg/5dJuUa7JPqHjBW4bzRn4C7wupx/otnrjFnPH6fM4KziPc2zaMtdb9sScZxAPe6mDv
	LPppPi9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8ODv-00000000Zkk-1ojs;
	Fri, 25 Apr 2025 18:56:31 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8ODt-00000000Zjf-2auW
	for linux-nvme@lists.infradead.org;
	Fri, 25 Apr 2025 18:56:30 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53PIZGkx004908;
	Fri, 25 Apr 2025 18:56:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=+SdbXK
	ZSP3P+TzrZtm/Vvbrd0p2tFRTA+0bERHaAnB0=; b=dNh9QzKZhQQZLNNFGoGF+T
	HZrnJc6HKQc3Y0P2Sl6GqUEVFyBzumEDIZ9brIb3CZ022KM8xdEbPqhwG9ssG8wS
	TOZmhEFAM58/qn8xn1EJaxEkfMow+ntP4Rx3dJbkCOTmSGFzNUc6+H46811g0PZI
	2M13//JL0ARJzKwXXILElUhFQ7axfi+qs0axOvUTOomgBGppvA2IIGiMJuoPP+SG
	epZOhNRyHS8hVAd9r3qW+H8H5E0gP7YF5uMaWunelnshRYF53ry0imYI6nxM+A9i
	mlOCrXAOTSxCL6bnde4GhB4oksJUKEX1WsKYPrnoJf9hlx+ZdHD/uGQ51SSNDq4A
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 467wew5056-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Apr 2025 18:56:25 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53PG933e000973;
	Fri, 25 Apr 2025 18:56:25 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 466jfy6pr3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Apr 2025 18:56:25 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53PIuNuD57344458
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 18:56:23 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2D9F820049;
	Fri, 25 Apr 2025 18:56:23 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3C39520040;
	Fri, 25 Apr 2025 18:56:21 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.43.102.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 25 Apr 2025 18:56:20 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: hare@suse.de, dwagner@suse.de, kbusch@kernel.org, gjoyce@ibm.com
Subject: [PATCHv3 1/4] tree: add support for discovering nvme paths using sysfs multipath link
Date: Sat, 26 Apr 2025 00:26:06 +0530
Message-ID: <20250425185617.1242994-2-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250425185617.1242994-1-nilay@linux.ibm.com>
References: <20250425185617.1242994-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDEzMiBTYWx0ZWRfX/Juw50G2F7jR 4UKYKJpu4QLFWa2+gtGcyGbQhCgIcLDxryIZy19kZK01RiWBM5BtEk8+h5AWgT+yEoiOBmAwj/Y NkPxt7wJdlGK77zQE/JMedtqGaWuq6I0hNbZVYyxjCcuYn98UpL7uMhvrAFV+B6dRogS40t9B+j
 pL2rjzylPnofsIt0/yAKqBFpqcxT6rMRQoX3QpNuquo6+eDBiLPV8Fwz7hEbcNi8DcnZENRZ5Kw 4XFwdrf51REWYac+7wqf8rgKz8Drnxli15iAc02TVOe1E6AjXHfK/OedJ3S67CctK87i989UNPs SbBy/bxknOSCnQfkXyCo9JVf8C336jjuwdwTRWZvU4I5tTDEDMxw+1fiqt2ZPxqA46aSnnWVnmj
 WgbPcj5peAF3k7MdDhG+PPWWlflDsJBE2VDc7MIDRay2RhJaj6EFvMqchxvNbOKTeP4ilZ5S
X-Proofpoint-ORIG-GUID: bXgNWrbozhoq0QYb4QW4IUzb__pch0jd
X-Authority-Analysis: v=2.4 cv=JLU7s9Kb c=1 sm=1 tr=0 ts=680bdad9 cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=YwT4yjY9AAAA:8 a=2J7IuT7wAAAA:8 a=VnNF1IyMAAAA:8 a=JRVZ9pAxRxE-3evDu1UA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=e64QTKfuJ4O-NP4Vnnd6:22 a=RtgRkGnnZwJf8nmJIBi8:22
X-Proofpoint-GUID: bXgNWrbozhoq0QYb4QW4IUzb__pch0jd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_05,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 priorityscore=1501 adultscore=0 mlxlogscore=846 suspectscore=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 malwarescore=0
 bulkscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504250132
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250425_115629_787976_F8161957 
X-CRM114-Status: GOOD (  29.43  )
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

With the upcoming Linux kernel v6.15, NVMe native multipath now provides
a simplified mechanism for discovering all paths to a shared namespace
through sysfs.

A new "multipath" directory is created under each NVMe head namespace
device in "/sys/block/<head>/multipath/". This directory contains symlinks
to all namespace path devices that access the same shared namespace.

For example, consider a shared namespace accessible via two paths under
nvme-subsys1:

nvme-subsys1 - NQN=nqn.1994-11.com.samsung:nvme:PM1735a:2.5-inch:S6RTNE0R900057
    hostnqn=nqn.2014-08.org.nvmexpress:uuid:41528538-e8ad-4eaf-84a7-9c552917d988
\
 +- ns 1
 \
  +- nvme0 pcie 052e:78:00.0 live optimized
  +- nvme1 pcie 058e:78:00.0 live optimized

The head device `/dev/nvme1n1` will now have the following structure:

/sys/block/nvme1n1/multipath/
├── nvme1c0n1 -> ../../../../../pci052e:78/052e:78:00.0/nvme/nvme0/nvme1c0n1
└── nvme1c1n1 -> ../../../../../pci058e:78/058e:78:00.0/nvme/nvme1/nvme1c1n1

This clearly shows that namespace 1 is accessible through both nvme1c0n1
and nvme1c1n1. This new sysfs structure significantly simplifies multipath
discovery and management, making it easier for tools and scripts to enumerate
and manage NVMe multipath configurations. So leverage this functionality to
update the path links for a shared NVMe namespace, simplifying path discovery
and management.

This change adds a new struct nvme_ns_head to represent the head of a shared
namespace. It contains a list head linking together struct nvme_path objects,
where each path corresponds to a shared namespace instance. Additionally,
struct nvme_ns has been updated to reference its associated nvme_ns_head,
enabling straightforward traversal of all paths to a shared NVMe namespace.

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
index b0a4696f..2f82fd77 100644
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
+		 * When multipath is configured on kernel version >= 6.15,
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
+		 * version < 6.15, fallback to the old way.
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



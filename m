Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4408AE88D98
	for <linux-nvme@archiver.kernel.org>; Sat,  4 Apr 2026 10:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=usnbSOhRsNP/OOW/n0K/KezArA600tXps+eXQnr6yKs=; b=dgEXq/gzYbg/hGkTLp4BPQ+4No
	oMn5US6LzT2S/I3CVlo3N8ikqz2Qr6Akt3fMoqiIhN6pi3dO/SJA67IUcpeGQth1kNiTma6+PKdPS
	fvYtsGxzROCg4bqL+3aVa0cKjPdMuqxvxJlI/TJZrNd6wCImH5ND77CKgfEM9SU7nyd/b5OBXDZ3b
	3jJQkEsy/46k5sN/HTOSMuoe1oon3xwxhgMiBtyPqUz+DyQqfJsOaz64dlM6w8QVOHlfQ0NQkYNwM
	yYBkDLna/6ixF+o50Apq6BfSbp63tvBHDHUTz0tL3xMSg8YGGrCWqC1n78wJCMQ4YHcc9YPJ/eppw
	2ODyksXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8y2J-00000003MHg-1f7V;
	Sat, 04 Apr 2026 10:15:27 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8y2G-00000003MGd-3izh
	for linux-nvme@lists.infradead.org;
	Sat, 04 Apr 2026 10:15:25 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6344sMF63274352;
	Sat, 4 Apr 2026 10:15:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=usnbSOhRsNP/OOW/n
	0K/KezArA600tXps+eXQnr6yKs=; b=B3VCcPC0I8ruk4fOmmof8hUbHQYbldMVG
	SRzk1TdqopskMT5dui919juDfKWmitFL0yJwDe6T+CM29gPs67xuCefjE3ZrMxcl
	2h1v0T6PJgLSstSe2V373CqePUHpSzjdxKzS1Yc3bX8c5ePf1B8rZ7f7FEoZHO5r
	lHlzH7RY2Ll5FCjVj/lkbelAUQbviNGVFmYIkU379u4ALRulQ8IzYw5DLk9IMGnw
	Ybx0WQJpqF+V94gahk3ms2qM9PpBA+o3KzEWvo8cJHeMwzCvPyUl4ga3izTpyqrn
	lcPhyPe3a+5qsjJVi+HV6W6o7/MBSr0vqe40cYt4sREx1svFljMvg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4datc2gqh6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 04 Apr 2026 10:15:23 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6349dS9R008717;
	Sat, 4 Apr 2026 10:15:22 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d6v120vs5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 04 Apr 2026 10:15:22 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 634AFItd50004470
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 4 Apr 2026 10:15:18 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 40B842004E;
	Sat,  4 Apr 2026 10:15:18 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7E0D02004F;
	Sat,  4 Apr 2026 10:15:15 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.124.211.35])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat,  4 Apr 2026 10:15:15 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, hare@suse.com, kbusch@kernel.org, hch@lst.de,
        gjoyce@linux.ibm.com, wenxiong@linux.ibm.com
Subject: [PATCHv2 2/9] libnvme: annotate nvme_path::numa_nodes with !accessors:none
Date: Sat,  4 Apr 2026 15:44:52 +0530
Message-ID: <20260404101504.44539-3-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260404101504.44539-1-nilay@linux.ibm.com>
References: <20260404101504.44539-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA0MDA4OCBTYWx0ZWRfXy63BP4TCcPgS
 IF3MN4JU58HB2mEZ2vFvGv26TOogmoHbVCHZWDSeyOOe3W4S0B4YLtRUQYWDvcDa2CXygwD+Jnv
 d30IkEHpcpI8JjcgoyO0AFNKP+HniXd8kL0vuZSzMwJ0asotr31/owpA6An8qjfyZlQ7BUFny21
 c72BGPDfwCnqnKPJ38LLdxBzUuwUhQEfMs49H5gRT942ddqiLqZTkKgBWdbYISodsTa+ZGH0fQ3
 2+JCr7hNymhPFa252Q8NR8MVHFqYiMkthXl6+t0nCuxsZLfZoxzi+QS0SVfyutpdTvi8D2OVpve
 Idgla7P+eyiOGsTz9U2qimMIrSzNpMmkCPAqz6XU/DNFv3bABvsH8pHuvh2GplBIbgyOf4TjILv
 T9Z8AH7HyiQY6B3UaZzLJjkisBDv4PXKF6DWTKNmKanHaWAlWU1Lm+GqlBMCxifM6sqYSPxSktJ
 RflpVdKJjnptHSnf3wA==
X-Proofpoint-GUID: zvVPeyX2Q_0x8wOmIrI08yVFJ_M1g50r
X-Proofpoint-ORIG-GUID: zvVPeyX2Q_0x8wOmIrI08yVFJ_M1g50r
X-Authority-Analysis: v=2.4 cv=HJvO14tv c=1 sm=1 tr=0 ts=69d0e4bb cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=cXzdoU1T7TFplbsrT5gA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-03_07,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0
 malwarescore=0 spamscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604040088
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260404_031524_949872_92BCF044 
X-CRM114-Status: GOOD (  16.13  )
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

The default accessor generation creates getters that return cached
attribute values. However, for nvme_path::numa_nodes, a real-time
(non-cached) value is required.

This is particularly useful for tools such as nvme-top, which rely on
up-to-date information for displaying a real-time dashboard.

Annotate nvme_path::numa_nodes with "!accessors:none" to disable the
auto-generated accessor, and provide a custom implementation of
nvme_path_get_numa_nodes() that returns the current value.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 libnvme/src/accessors.ld     |  2 --
 libnvme/src/libnvme.ld       |  1 +
 libnvme/src/nvme/accessors.c | 13 -------------
 libnvme/src/nvme/accessors.h | 15 ---------------
 libnvme/src/nvme/private.h   |  2 +-
 libnvme/src/nvme/tree.c      | 15 +++++++++++++++
 libnvme/src/nvme/tree.h      |  8 ++++++++
 7 files changed, 25 insertions(+), 31 deletions(-)

diff --git a/libnvme/src/accessors.ld b/libnvme/src/accessors.ld
index 9e5653b92..433767191 100644
--- a/libnvme/src/accessors.ld
+++ b/libnvme/src/accessors.ld
@@ -14,8 +14,6 @@ LIBNVME_ACCESSORS_3 {
 		nvme_path_set_name;
 		nvme_path_get_sysfs_dir;
 		nvme_path_set_sysfs_dir;
-		nvme_path_get_numa_nodes;
-		nvme_path_set_numa_nodes;
 		nvme_path_get_grpid;
 		nvme_path_set_grpid;
 		nvme_ns_get_nsid;
diff --git a/libnvme/src/libnvme.ld b/libnvme/src/libnvme.ld
index 38625cbf4..f2972f455 100644
--- a/libnvme/src/libnvme.ld
+++ b/libnvme/src/libnvme.ld
@@ -143,6 +143,7 @@ LIBNVME_3 {
 		nvme_path_get_ns;
 		nvme_path_get_queue_depth;
 		nvme_path_get_ana_state;
+		nvme_path_get_numa_nodes;
 		nvme_random_uuid;
 		nvme_read_config;
 		nvme_read_hostid;
diff --git a/libnvme/src/nvme/accessors.c b/libnvme/src/nvme/accessors.c
index 8b095ed4d..a98f26234 100644
--- a/libnvme/src/nvme/accessors.c
+++ b/libnvme/src/nvme/accessors.c
@@ -52,19 +52,6 @@ __public const char *nvme_path_get_sysfs_dir(const struct nvme_path *p)
 	return p->sysfs_dir;
 }
 
-__public void nvme_path_set_numa_nodes(
-		struct nvme_path *p,
-		const char *numa_nodes)
-{
-	free(p->numa_nodes);
-	p->numa_nodes = numa_nodes ? strdup(numa_nodes) : NULL;
-}
-
-__public const char *nvme_path_get_numa_nodes(const struct nvme_path *p)
-{
-	return p->numa_nodes;
-}
-
 __public void nvme_path_set_grpid(struct nvme_path *p, int grpid)
 {
 	p->grpid = grpid;
diff --git a/libnvme/src/nvme/accessors.h b/libnvme/src/nvme/accessors.h
index 3ede23cbc..f9323ad11 100644
--- a/libnvme/src/nvme/accessors.h
+++ b/libnvme/src/nvme/accessors.h
@@ -68,21 +68,6 @@ void nvme_path_set_sysfs_dir(struct nvme_path *p, const char *sysfs_dir);
  */
 const char *nvme_path_get_sysfs_dir(const struct nvme_path *p);
 
-/**
- * nvme_path_set_numa_nodes() - Set numa_nodes.
- * @p: The &struct nvme_path instance to update.
- * @numa_nodes: New string; a copy is stored. Pass NULL to clear.
- */
-void nvme_path_set_numa_nodes(struct nvme_path *p, const char *numa_nodes);
-
-/**
- * nvme_path_get_numa_nodes() - Get numa_nodes.
- * @p: The &struct nvme_path instance to query.
- *
- * Return: The value of the numa_nodes field, or NULL if not set.
- */
-const char *nvme_path_get_numa_nodes(const struct nvme_path *p);
-
 /**
  * nvme_path_set_grpid() - Set grpid.
  * @p: The &struct nvme_path instance to update.
diff --git a/libnvme/src/nvme/private.h b/libnvme/src/nvme/private.h
index 7631c4084..e115c4310 100644
--- a/libnvme/src/nvme/private.h
+++ b/libnvme/src/nvme/private.h
@@ -137,8 +137,8 @@ struct nvme_path { /*!generate-accessors*/
 
 	char *name;
 	char *sysfs_dir;
-	char *numa_nodes;
 	char *ana_state; //!accessors:none
+	char *numa_nodes; //!accessors:none
 	int grpid;
 	int queue_depth; //!accessors:none
 };
diff --git a/libnvme/src/nvme/tree.c b/libnvme/src/nvme/tree.c
index f087d7b03..93982dfd2 100644
--- a/libnvme/src/nvme/tree.c
+++ b/libnvme/src/nvme/tree.c
@@ -821,6 +821,21 @@ __public char *nvme_path_get_ana_state(nvme_path_t p)
 	return p->ana_state;
 }
 
+__public char *nvme_path_get_numa_nodes(nvme_path_t p)
+{
+	_cleanup_free_ char *numa_nodes = NULL;
+
+	numa_nodes = nvme_get_path_attr(p, "numa_nodes");
+	if (numa_nodes) {
+		if (!p->numa_nodes || strcmp(numa_nodes, p->numa_nodes)) {
+			free(p->numa_nodes);
+			p->numa_nodes = strdup(numa_nodes);
+		}
+	}
+
+	return p->numa_nodes;
+}
+
 void nvme_free_path(struct nvme_path *p)
 {
 	list_del_init(&p->entry);
diff --git a/libnvme/src/nvme/tree.h b/libnvme/src/nvme/tree.h
index ec0f4f2e6..1240f3023 100644
--- a/libnvme/src/nvme/tree.h
+++ b/libnvme/src/nvme/tree.h
@@ -687,6 +687,14 @@ int nvme_path_get_queue_depth(nvme_path_t p);
  */
 char *nvme_path_get_ana_state(nvme_path_t p);
 
+/**
+ * nvme_path_get_numa_nodes() - Numa nodes of an nvme_path_t object
+ * @p: &nvme_path_t object
+ *
+ * Return: Numa nodes of @p
+ */
+char *nvme_path_get_numa_nodes(nvme_path_t p);
+
 /**
  * nvme_path_get_ctrl() - Parent controller of an nvme_path_t object
  * @p:	&nvme_path_t object
-- 
2.53.0



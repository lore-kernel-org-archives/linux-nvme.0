Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1304E1094488
	for <linux-nvme@archiver.kernel.org>; Sat, 21 Mar 2026 15:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Q+pw0ziV6HRhXn4P0TToRZdWx7kELmz7mAE1a3PCR70=; b=JwmJmVvCYBF5Vt0s9hdQFjgeoW
	fW0mCAtTEqKC3BGuVcpGt+85rH4js6rhUKLuZsxgpaAQyDTvalwsv1C9tjRe+h8S2t5YPwSwD7SvI
	G2o2EXTG4q6wNqM7O2ML9msJr/BcUhGnTmhB9TdGvgf49denH6QugGd9sdW5PUbHZEPoY1BqYMh6E
	jLTZA4C6/BM1BqMx0N1eAzehH3Fv0Lif2Qi6Zm9E1sfEPDB8CqCOATAnYI+gzCs3FttFkbM6oBVUn
	5WPXtY5d4lbax+Avdd7MHNE8pWglZaFje5bK0vhyBjPvkCdengYWXtrwuD7ec6OyMXxnUoR5G6Kkm
	z0L/RxwA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3yG5-0000000Ea6s-1EWw;
	Sat, 21 Mar 2026 15:29:01 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3yG2-0000000Ea51-09si
	for linux-nvme@lists.infradead.org;
	Sat, 21 Mar 2026 15:28:59 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62L3sFmE4146040;
	Sat, 21 Mar 2026 15:28:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Q+pw0ziV6HRhXn4P0
	TToRZdWx7kELmz7mAE1a3PCR70=; b=nuIttmNnS7N9MVdKIJNzrbZtU0+sqkHx5
	es7EtogiLTqYA+H0SA8PprrsEQ+FCik8mxvyDv+lRDn+fhvfs9HO2iVEGG5HsQ6Z
	e+YeasOtyYo/nj3PEpQd8KCokgjQJkjJTxmpA/EQDsmR0VO+tgayADx6m07TqLbB
	tng7GgudeopbFXvnsv0Qwk0M21/pwKQ9tJpXTnbpqsN+bcwIRiowAIsssbCMiLSC
	xt5IFkVZFTIliAUpPJyxsDe66vHdlyMG/pA2OIxVh5CYL4uLv0dlI4J3GJKOglZe
	WLAmr5e1be/FsF15tQLyIi3Qam2/28iyU0MgU+xLhd0jsGIBvc7Cw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1ktxh8ty-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 21 Mar 2026 15:28:48 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62LA1N5f012180;
	Sat, 21 Mar 2026 15:28:47 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cwj0sv3hk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 21 Mar 2026 15:28:47 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62LFSiuc50135448
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 21 Mar 2026 15:28:44 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0DC4120049;
	Sat, 21 Mar 2026 15:28:44 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7C02D20040;
	Sat, 21 Mar 2026 15:28:38 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.124.222.150])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 21 Mar 2026 15:28:38 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, hare@suse.com, kbusch@kernel.org, hch@lst.de,
        gjoyce@ibm.com, wenxiong@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH 2/9] libnvme: annotate nvme_path::numa_nodes with !accessors:none
Date: Sat, 21 Mar 2026 20:58:01 +0530
Message-ID: <20260321152823.3197870-3-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260321152823.3197870-1-nilay@linux.ibm.com>
References: <20260321152823.3197870-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=IqITsb/g c=1 sm=1 tr=0 ts=69beb930 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=cXzdoU1T7TFplbsrT5gA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIxMDEyOSBTYWx0ZWRfX391QXGF9o6Yi
 lMq3RDcgix+StAXvdJ0QXqxfPvK7ce24Lqj9T0N/mes5c3tnQIuSZN3Jh1eaUuigafIshQ38+SZ
 9uwmIoF0Yj2jBrxeEOmF6Y6wvUGgljN4VftexAjB0QK9dE+QJShrslkm3S5FnEYqmSACwNgAanu
 TBpjZVtGhT3Tw/XLHmBxuwkYocwe8k1sCLIPp1A7mXWvO1TvbYbApLZGuVopN8fjmnTWdL4WmuF
 iPOICPbFs+chZvINxKO1eyVB5ccR3esss6RCO5XCz3fHtxEmBxmuoctbUx577NTiYSg1ZokZp/0
 Z6IUcm7UF+gN3U4eF41GqGoJCfxiw96iyOjrDUM+Fslzvj7aXGXz1kiSlNmhr8XSxxSxLIaeQSv
 AdwOwMwpQ6ir3zOHPd/ZVVPk8XkR5OpGvsBmv4/KNS/kjwhmER3XG4WfhuiIRsPeojoIisdpzyn
 UK/LPgdhdZJC8zhyPVA==
X-Proofpoint-GUID: 96lEfAaDc3_r8FY8n6PP6WMFpa1GvwQl
X-Proofpoint-ORIG-GUID: 96lEfAaDc3_r8FY8n6PP6WMFpa1GvwQl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-21_05,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 spamscore=0 impostorscore=0 suspectscore=0
 phishscore=0 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603210129
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260321_082858_088098_32ADFD23 
X-CRM114-Status: GOOD (  15.99  )
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
index 0fd86be71..41a170083 100644
--- a/libnvme/src/libnvme.ld
+++ b/libnvme/src/libnvme.ld
@@ -143,6 +143,7 @@ LIBNVME_3 {
 		nvme_path_get_ns;
 		nvme_path_get_queue_depth;
 		nvme_path_get_ana_state;
+		nvme_path_get_numa_nodes;
 		nvme_filter_paths;
 		nvme_read_config;
 		nvme_read_key;
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
index 25fec3216..dcd9079dd 100644
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
index 1adc2c57a..2984d0ff7 100644
--- a/libnvme/src/nvme/tree.c
+++ b/libnvme/src/nvme/tree.c
@@ -820,6 +820,21 @@ __public char *nvme_path_get_ana_state(nvme_path_t p)
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



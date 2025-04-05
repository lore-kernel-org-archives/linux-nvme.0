Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BA20C36010
	for <linux-nvme@archiver.kernel.org>; Sat,  5 Apr 2025 13:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KxYyY5AV6G1iarQgkJaWD392kE9JxJuzGEkhgEkJqJY=; b=GlY2XqlAKGmrKjYGG2CRTACQhX
	YExI0XatGI4H7zPKpNyhuQbBfEWzfEig87mlkmXc1Npggi1juMlg2ysn+Pr/sVgYrujOsEd+IYU5K
	nG5/J7l3qyrWuq3MsBj1yCYhPFp4dsmjQRjlNUtfpiOmdYOmE3wUrhzM2kyAlWEvlcU7/OAxxZ4cf
	CY28VgAafRlmFAAYDen9WXzlgtRCcPHFfyOaKpBJffPnbOypkmz5PKDor1Sbgn25F9N0lDY5cirwl
	2CL/CmhYQkh6sLq1GspHleY6KqRglPYZcr4hSCJXOzMdM0TbC/xiMh9P+stR/0ETra73VQoqkVGde
	vMNcpCpQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u13BA-0000000Dy9j-2JJr;
	Sat, 05 Apr 2025 13:03:20 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u13B7-0000000Dy8m-449d
	for linux-nvme@lists.infradead.org;
	Sat, 05 Apr 2025 13:03:19 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5353wWHl014267;
	Sat, 5 Apr 2025 13:03:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=KxYyY5AV6G1iarQgk
	JaWD392kE9JxJuzGEkhgEkJqJY=; b=nZ/7Vr8Af8eEKtZpVW857I9B1vGZl/G7H
	mwGgzxB8jfGCX2u37gz0kR/i9YLVG8E9czzyxw5iFzaRyJ7V3Ey9dhcUvRnoYHag
	0RKgCDDZUrwYWJ3Oxk2dyIm77Ox8ZMj/GmpV43odJlVYREYqgYbcJ7plh+VYWMLs
	Z0y0kLyAjnq2A1C9PJGL/CsTLq0D6A6SXmRuY3ca6KLzmNG+27OrOhGyKgsTtGD3
	qgEjT52waMPa3SWsrX2hiei5hpLLdqGfoRkJXs3dmad9MKp4rBuMRJR+K+Prl3iX
	DVXdTjnutHSgzoFiWdc76voqFQm80Wlx6wkRPJeW3mdcGhK7o52Jw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45tsxp1va6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 05 Apr 2025 13:03:08 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 535AEAkA030473;
	Sat, 5 Apr 2025 13:03:07 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 45t2e4ye6q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 05 Apr 2025 13:03:07 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 535D35fZ60490220
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 5 Apr 2025 13:03:05 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B757920043;
	Sat,  5 Apr 2025 13:03:05 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D99AC20040;
	Sat,  5 Apr 2025 13:03:03 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.171.30.151])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat,  5 Apr 2025 13:03:03 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, hare@kernel.org, kbusch@kernel.org, gjoyce@ibm.com
Subject: [PATCH 3/3] tree: add attribute numa_nodes for NVMe path object
Date: Sat,  5 Apr 2025 18:32:49 +0530
Message-ID: <20250405130255.448345-4-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250405130255.448345-1-nilay@linux.ibm.com>
References: <20250405130255.448345-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: b6y23tPmLBf9LN6cokIN70j_l6HyhC8Q
X-Proofpoint-ORIG-GUID: b6y23tPmLBf9LN6cokIN70j_l6HyhC8Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-05_06,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 malwarescore=0 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504050080
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250405_060318_132574_AC9A5C0D 
X-CRM114-Status: GOOD (  17.03  )
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

Add a new attribute named "numa_nodes" under the NVMe path object. This
attribute is used by the iopolicy "numa". The numa_nodes value is stored
for each NVMe path and represents the NUMA node(s) associated with it.
When the iopolicy is set to "numa", I/O traffic originating from a given
NUMA node will be forwarded through the corresponding NVMe path.

The numa_nodes attribute is useful for observing which NVMe path the
kernel would choose for I/O forwarding based on NUMA affinity. To support
this, export the attribute in libnvme.map so it can be accessed via
nvme-cli.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 src/libnvme.map    |  1 +
 src/nvme/private.h |  1 +
 src/nvme/tree.c    | 10 ++++++++++
 src/nvme/tree.h    |  8 ++++++++
 4 files changed, 20 insertions(+)

diff --git a/src/libnvme.map b/src/libnvme.map
index e53fad6b..ffadc647 100644
--- a/src/libnvme.map
+++ b/src/libnvme.map
@@ -317,6 +317,7 @@ LIBNVME_1_0 {
 		nvme_path_get_ctrl;
 		nvme_path_get_name;
 		nvme_path_get_ns;
+		nvme_path_get_numa_nodes;
 		nvme_path_get_queue_depth;
 		nvme_path_get_sysfs_dir;
 		nvme_paths_filter;
diff --git a/src/nvme/private.h b/src/nvme/private.h
index f94276e2..5bfa027b 100644
--- a/src/nvme/private.h
+++ b/src/nvme/private.h
@@ -33,6 +33,7 @@ struct nvme_path {
 	char *name;
 	char *sysfs_dir;
 	char *ana_state;
+	char *numa_nodes;
 	int grpid;
 	int queue_depth;
 };
diff --git a/src/nvme/tree.c b/src/nvme/tree.c
index b7a38a07..ddb6fd70 100644
--- a/src/nvme/tree.c
+++ b/src/nvme/tree.c
@@ -913,6 +913,11 @@ const char *nvme_path_get_ana_state(nvme_path_t p)
 	return p->ana_state;
 }
 
+const char *nvme_path_get_numa_nodes(nvme_path_t p)
+{
+	return p->numa_nodes;
+}
+
 void nvme_free_path(struct nvme_path *p)
 {
 	list_del_init(&p->entry);
@@ -920,6 +925,7 @@ void nvme_free_path(struct nvme_path *p)
 	free(p->name);
 	free(p->sysfs_dir);
 	free(p->ana_state);
+	free(p->numa_nodes);
 	free(p);
 }
 
@@ -955,6 +961,10 @@ static int nvme_ctrl_scan_path(nvme_root_t r, struct nvme_ctrl *c, char *name)
 	if (!p->ana_state)
 		p->ana_state = strdup("optimized");
 
+	p->numa_nodes = nvme_get_path_attr(p, "numa_nodes");
+	if (!p->numa_nodes)
+		p->numa_nodes = strdup("-1");
+
 	grpid = nvme_get_path_attr(p, "ana_grpid");
 	if (grpid) {
 		sscanf(grpid, "%d", &p->grpid);
diff --git a/src/nvme/tree.h b/src/nvme/tree.h
index a9082f8e..f6116c2b 100644
--- a/src/nvme/tree.h
+++ b/src/nvme/tree.h
@@ -867,6 +867,14 @@ const char *nvme_path_get_sysfs_dir(nvme_path_t p);
  */
 const char *nvme_path_get_ana_state(nvme_path_t p);
 
+/**
+ * nvme_path_get_numa_nodes() - NUMA nodes of an nvme_path_t object
+ * @p : &nvme_path_t object
+ *
+ * Return: NUMA nodes associated to @p
+ */
+const char *nvme_path_get_numa_nodes(nvme_path_t p);
+
 /**
  * nvme_path_get_queue_depth() - Queue depth of an nvme_path_t object
  * @p: &nvme_path_t object
-- 
2.49.0



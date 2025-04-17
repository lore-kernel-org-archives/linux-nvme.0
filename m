Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 282EBC369D0
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Apr 2025 14:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KxYyY5AV6G1iarQgkJaWD392kE9JxJuzGEkhgEkJqJY=; b=Kpz3YSeygw4POV4ZD9p5SbWhak
	lYnZFiV/VDxHZMeheDfzY02tuuJrcJ2vLLcpp6HGAqQ4Y/dWrcgN5AQ6RPlozqL+ySewXH5qkBtgx
	0/TkpaiZQznj7/St67nxm++LeYkhP9bG6IWBdbAuseVtEDu5Lpg/C3N6yvY6rsL+c+b607uyiSXgq
	/+nwF6LfOCnFrONhzw2cWrHIi1vzhJIa9ksVBTvfeI9p07+K0xgxAyRp/2/tX3UUwLql81WjOKmU6
	ltcrJQjy1Nf3J1bAucb3R7vyb4XcWzHY3kVgSVkS2KpP1X5156TI282AUqAlrsYpDHtpfRBb20uMn
	+L921uJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5Po2-0000000DEnW-0upQ;
	Thu, 17 Apr 2025 14:01:30 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5Pmd-0000000DEcd-3Ikq
	for linux-nvme@lists.infradead.org;
	Thu, 17 Apr 2025 14:00:05 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53HAb2P5018090;
	Thu, 17 Apr 2025 14:00:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=KxYyY5AV6G1iarQgk
	JaWD392kE9JxJuzGEkhgEkJqJY=; b=rdyZMCWpH+CWrewminDfxGmCaV0/r//zk
	IEWDMre2Zv+kPC6UHSQkbeNMOlH0CW18c8VgSWbxe4vlEhhxxRNTOoEEx+ZQm45A
	Nm7WlNlDUigwgKShjxEoTD1olJS9Dh3WnFLcMcYbKVwbLLfJ9nUKFC+m/82O3Hfw
	lSwjpnXVPQRp7noi0Um8VUZQazdFkjMin4Fnbm9HrNgZh1agnZjnlTF97D8O9Ox8
	vymXmGKeteteAmv9Rj/RQ6nQqtfyMyc2o1n5Nxja3mp1xBK15mUp7lOr5BU0v7pG
	Cu2/ZnpiXmwxb8G7DU0lP/X7tktmimsWayX1/ICIx9INZqdJ8Ixdw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 462mhu409s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Apr 2025 14:00:01 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53HD4t5w024892;
	Thu, 17 Apr 2025 14:00:00 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4602gtp953-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Apr 2025 14:00:00 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53HDxwS542991938
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Apr 2025 13:59:59 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DC91E20040;
	Thu, 17 Apr 2025 13:59:58 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7F2552004D;
	Thu, 17 Apr 2025 13:59:57 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.111.1.254])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 17 Apr 2025 13:59:57 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, hare@kernel.org, kbusch@kernel.org, gjoyce@ibm.com
Subject: [PATCHv2 3/4] tree: add attribute numa_nodes for NVMe path object
Date: Thu, 17 Apr 2025 19:29:45 +0530
Message-ID: <20250417135951.239447-4-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250417135951.239447-1-nilay@linux.ibm.com>
References: <20250417135951.239447-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Hvd2G1TS c=1 sm=1 tr=0 ts=68010961 cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=XR8D0OoHHMoA:10 a=VnNF1IyMAAAA:8 a=K2osYvVS4dd-3OXIFZAA:9
X-Proofpoint-ORIG-GUID: aZ1RBI_8DadJYrpUVjw_cGW6MCUExu_0
X-Proofpoint-GUID: aZ1RBI_8DadJYrpUVjw_cGW6MCUExu_0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-17_04,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 bulkscore=0 clxscore=1015 impostorscore=0 mlxscore=0
 phishscore=0 priorityscore=1501 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504170101
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250417_070003_828230_0ED21E16 
X-CRM114-Status: GOOD (  16.65  )
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



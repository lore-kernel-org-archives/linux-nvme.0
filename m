Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1DCFC3601A
	for <linux-nvme@archiver.kernel.org>; Sat,  5 Apr 2025 13:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UhFIu5HVdURktam60nNxxbGkq33x6ItCQpMeJA+AaLg=; b=EDoddB2pfvk63ZGHI6jXaND9Nn
	yPNBJuWURe++6X3vVaySGKSuHwSCe2Rnb/M77O2h/OtxHnap30x0RGay6KGfxEuh8lF0zJFODy1Lf
	xEyL7AVYZlFPfSNTJjNgo/1c6h/AmRU+BtGQdW7kXfkUdNeoW3mK8Uie13fpx1ofd1/ofKIWL/whO
	1lfA9NmL6h2myDIaUkhAl4MN9n9PwNjJzBPJekt2IROAh4kkS1HkWi8S1afRvmkdn+4OBPqga1Bj5
	gH0g17R5/5Ne19LeLVozPo5hgCHIRXvhee0FU2q9o4Dn/W3Rggtqp6OmwJOlPYcMx2JSBDlFO7yq1
	qlgOWXaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u13B8-0000000Dy95-3AQ2;
	Sat, 05 Apr 2025 13:03:18 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u13B4-0000000Dy7n-2MoD
	for linux-nvme@lists.infradead.org;
	Sat, 05 Apr 2025 13:03:15 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5353vHXx028662;
	Sat, 5 Apr 2025 13:03:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=UhFIu5HVdURktam60
	nNxxbGkq33x6ItCQpMeJA+AaLg=; b=YySfuez9fycc2G9A5d/m7fKAE8EGyQeFd
	Kl7dqXbHiEOVUFbwluwaIPOpmFZt3b07dC3eGPX6Ql7ZtXYtk0wb4xfXBezMTcn/
	dbRYDZB9i0UjiG380rkT+deL93eJEUUlFJKuS4+xVZBMzLikvGuKQXOo3F6UcdAY
	OYxY09SIl91UPHH3/PwHH3TnNGR2TjOYO67Nr6Cs4mBgnBzYzYAMHS+AYMm/Hx7r
	x9GXi7BUPcxkIN1XzQNKUibzgr3MXN9iZCzvX58Ph3nM+Q+G0SA6FLiDQuD0m83H
	8EOU7M7H482nXyUmsCln7Ydy4vf5ANUgm+kdemMXu6fvZ1TxOEk3w==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45tvw99fh1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 05 Apr 2025 13:03:06 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 535AYeiG003298;
	Sat, 5 Apr 2025 13:03:05 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 45t2cdyfp0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 05 Apr 2025 13:03:05 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 535D33jG54460920
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 5 Apr 2025 13:03:03 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 626A22004E;
	Sat,  5 Apr 2025 13:03:03 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7A6CA20040;
	Sat,  5 Apr 2025 13:03:01 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.171.30.151])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat,  5 Apr 2025 13:03:01 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, hare@kernel.org, kbusch@kernel.org, gjoyce@ibm.com
Subject: [PATCH 2/3] tree: add queue-depth attribute for nvme path object
Date: Sat,  5 Apr 2025 18:32:48 +0530
Message-ID: <20250405130255.448345-3-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250405130255.448345-1-nilay@linux.ibm.com>
References: <20250405130255.448345-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 4-4zhA_RvIjOTcgiwPpnw4zYikXNK4eI
X-Proofpoint-GUID: 4-4zhA_RvIjOTcgiwPpnw4zYikXNK4eI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-05_06,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 adultscore=0
 mlxlogscore=999 phishscore=0 clxscore=1015 mlxscore=0 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504050080
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250405_060314_605454_CC4717DF 
X-CRM114-Status: GOOD (  17.73  )
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

Add a new attribute named "queue_depth" under the NVMe path object. This
attribute is used by the iopolicy "queue-depth", which was introduced in
kernel v6.11. However, the corresponding sysfs attribute for queue depth
was only added in kernel v6.14.

The queue_depth value can be useful for observing which paths are selected
for I/O forwarding, based on the depth of each path. To support this,
export the attribute in libnvme.map so it can be accessed via nvme-cli.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 src/libnvme.map    |  1 +
 src/nvme/private.h |  1 +
 src/nvme/tree.c    | 12 +++++++++++-
 src/nvme/tree.h    |  8 ++++++++
 4 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/src/libnvme.map b/src/libnvme.map
index 4314705f..e53fad6b 100644
--- a/src/libnvme.map
+++ b/src/libnvme.map
@@ -317,6 +317,7 @@ LIBNVME_1_0 {
 		nvme_path_get_ctrl;
 		nvme_path_get_name;
 		nvme_path_get_ns;
+		nvme_path_get_queue_depth;
 		nvme_path_get_sysfs_dir;
 		nvme_paths_filter;
 		nvme_read_config;
diff --git a/src/nvme/private.h b/src/nvme/private.h
index f45c5823..f94276e2 100644
--- a/src/nvme/private.h
+++ b/src/nvme/private.h
@@ -34,6 +34,7 @@ struct nvme_path {
 	char *sysfs_dir;
 	char *ana_state;
 	int grpid;
+	int queue_depth;
 };
 
 struct nvme_ns_head {
diff --git a/src/nvme/tree.c b/src/nvme/tree.c
index bd7fb53e..b7a38a07 100644
--- a/src/nvme/tree.c
+++ b/src/nvme/tree.c
@@ -903,6 +903,11 @@ const char *nvme_path_get_name(nvme_path_t p)
 	return p->name;
 }
 
+int nvme_path_get_queue_depth(nvme_path_t p)
+{
+	return p->queue_depth;
+}
+
 const char *nvme_path_get_ana_state(nvme_path_t p)
 {
 	return p->ana_state;
@@ -921,7 +926,7 @@ void nvme_free_path(struct nvme_path *p)
 static int nvme_ctrl_scan_path(nvme_root_t r, struct nvme_ctrl *c, char *name)
 {
 	struct nvme_path *p;
-	_cleanup_free_ char *path = NULL, *grpid = NULL;
+	_cleanup_free_ char *path = NULL, *grpid = NULL, *queue_depth = NULL;
 	int ret;
 
 	nvme_msg(r, LOG_DEBUG, "scan controller %s path %s\n",
@@ -955,6 +960,11 @@ static int nvme_ctrl_scan_path(nvme_root_t r, struct nvme_ctrl *c, char *name)
 		sscanf(grpid, "%d", &p->grpid);
 	}
 
+	queue_depth = nvme_get_path_attr(p, "queue_depth");
+	if (queue_depth) {
+		sscanf(queue_depth, "%d", &p->queue_depth);
+	}
+
 	list_node_init(&p->nentry);
 	list_node_init(&p->entry);
 	list_add_tail(&c->paths, &p->entry);
diff --git a/src/nvme/tree.h b/src/nvme/tree.h
index 9f382e9c..a9082f8e 100644
--- a/src/nvme/tree.h
+++ b/src/nvme/tree.h
@@ -867,6 +867,14 @@ const char *nvme_path_get_sysfs_dir(nvme_path_t p);
  */
 const char *nvme_path_get_ana_state(nvme_path_t p);
 
+/**
+ * nvme_path_get_queue_depth() - Queue depth of an nvme_path_t object
+ * @p: &nvme_path_t object
+ *
+ * Return: Queue depth of @p
+ */
+int nvme_path_get_queue_depth(nvme_path_t p);
+
 /**
  * nvme_path_get_ctrl() - Parent controller of an nvme_path_t object
  * @p:	&nvme_path_t object
-- 
2.49.0



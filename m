Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 560DCC369C2
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Apr 2025 18:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nv7lOGblhTpU2GRQlWkIJBnvZKwlFGh+yZeu5HDshJs=; b=NXQ+mI6IqQk9AaNulvnZtZp1ll
	vXWuLVGk5zG63//E+lYMQ7irCGLgEfr3xE2f2nlEnEl0nWEZTnh0IZQPFAvJamFUQGQfZhH7IMhqj
	xL1/i8JZxcZOPZrtqth/SPnj5OhE7FdUqF5vcsL41QoFJD/Zyup947mU4fz2C6E7HfGQ2GXFtez6M
	qEQqom8BfG0e2SLfSIbDv8Olsol1dUjmVEfxCUzRXopoqbkVkcNtTRCXU4bCv+DRKhi8xXyU/VF3Z
	IeCY6NjGcqSKpYIgXaNSh2ZckBhiFLCq6GUx9FsJhe+SYb7AWTydBHAKOM0Vz9oYrwqYzeSHqL1XQ
	rlrEGSWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8ODx-00000000ZmI-3Q2W;
	Fri, 25 Apr 2025 18:56:33 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8ODv-00000000ZkB-0iby
	for linux-nvme@lists.infradead.org;
	Fri, 25 Apr 2025 18:56:32 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53PB8IAO026152;
	Fri, 25 Apr 2025 18:56:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=nv7lOGblhTpU2GRQl
	WkIJBnvZKwlFGh+yZeu5HDshJs=; b=NU3BCft8DTvvNA8UBnflinvH8g7rlKS34
	2jvcd+IAV29+d9/8EdTs5a/Wc9JT8T3vSYsMggvE+C3bcDL6sMuyl8f2VKCDF85e
	zF0YeJBe7+dT7xuwz2tpEIHjDJCXNspF3oX0bDuFQ/uEtefSxEIQKRQcYS4/1cX1
	DkKtD2aPJrG/FGmLtnYjIPet3nhvQZ8QyCmi8OGlVDmrx3dkSfbfdzKmsiryZfWr
	s7oYmGdsOGL3P7WJs7x165gg4I2BQZQ2XG3Q8L9SKweWQQtf1+F0i5GoC42PWLcD
	WK6MtJgkHmSY7nfy0P5vlNRCvvFmH6VgdwmjWhtsr6n7A65T4+vaA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 467y90vkew-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Apr 2025 18:56:28 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53PGe0jj022266;
	Fri, 25 Apr 2025 18:56:27 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 466jfxpqfm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Apr 2025 18:56:27 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53PIuPSS51249524
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 18:56:25 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7C79C2004B;
	Fri, 25 Apr 2025 18:56:25 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A694B20040;
	Fri, 25 Apr 2025 18:56:23 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.43.102.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 25 Apr 2025 18:56:23 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: hare@suse.de, dwagner@suse.de, kbusch@kernel.org, gjoyce@ibm.com
Subject: [PATCHv3 2/4] tree: add queue-depth attribute for nvme path object
Date: Sat, 26 Apr 2025 00:26:07 +0530
Message-ID: <20250425185617.1242994-3-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250425185617.1242994-1-nilay@linux.ibm.com>
References: <20250425185617.1242994-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=aZRhnQot c=1 sm=1 tr=0 ts=680bdadc cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=XR8D0OoHHMoA:10 a=VnNF1IyMAAAA:8 a=XaWtqrLIcfE_reSIXwoA:9
X-Proofpoint-GUID: 8Q5fOGjsVgzwtVgSIG9pzRhA32DfH6zU
X-Proofpoint-ORIG-GUID: 8Q5fOGjsVgzwtVgSIG9pzRhA32DfH6zU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDEzMiBTYWx0ZWRfXxGsNPY3LpDCN JWhBZCfYm/fTtTyKgsqxx9ctS/XFihotQ0hypLo4BS+Y8CHb8hYjyfhDjfqX82Unp6nK8odsqFv EUR8rTYDcvFb2q/yCViUZpl7+Pr6y5dNoZY9dMlxaZOxjX6TlEM3b7LUbslvoX31iyYFGPfNx0d
 tlUgUCgJ4/vanTIMrKmKTIcn1/j8lSJtpT4F+s4GiyS2WI6sN0QwFNxVmziYJ3rtV9sd0XGgfXy 5Ir6qdmip+fHvc/FIjyK1yHw9m7NOjOUmV420EByj4DHMMLTuIusXhMeuV6mBbspVCbKQdsFS/Q jK/aG8hDsrz1DLvrd1dWlXQaDBDb7CKIMbI73ltUA9hwYJXUQr8/SQIqi8AyCSy6PhlM73Kvq6h
 s3RTKnXxncETEvCKTSJXm0Y8x/abFnKOErEtqCiidCOoyIHuqPuLOL+SMjwgbokl8oc2NjL6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_05,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 priorityscore=1501
 clxscore=1015 mlxlogscore=853 impostorscore=0 mlxscore=0 malwarescore=0
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504250132
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250425_115631_340436_93FF2933 
X-CRM114-Status: GOOD (  19.58  )
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

Introduce a new sysfs attribute, queue_depth, under the NVMe path object.
This attribute is used by the queue-depth I/O policy introduced in kernel
v6.11, but the sysfs interface for this attribute was only added later in
kernel v6.15.

The queue_depth value is useful for observing which paths are selected
for I/O forwarding based on their current queue depths. To make this
information available to user space tools such as nvme-cli, the attribute
is now exported in libnvme.map.

As queue_depth value could change frequently, nvme_path_get_queue_depth()
is implemented to always fetch the latest queue_depth value, rather than
relying solely on a cached version. If fetching the latest value fails,
the function gracefully falls back to the cached value.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 src/libnvme.map    |  1 +
 src/nvme/private.h |  1 +
 src/nvme/tree.c    | 19 ++++++++++++++++++-
 src/nvme/tree.h    |  8 ++++++++
 4 files changed, 28 insertions(+), 1 deletion(-)

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
index 2f82fd77..20d4c2e2 100644
--- a/src/nvme/tree.c
+++ b/src/nvme/tree.c
@@ -903,6 +903,18 @@ const char *nvme_path_get_name(nvme_path_t p)
 	return p->name;
 }
 
+int nvme_path_get_queue_depth(nvme_path_t p)
+{
+	_cleanup_free_ char *queue_depth = NULL;
+
+	queue_depth = nvme_get_path_attr(p, "queue_depth");
+	if (queue_depth) {
+		sscanf(queue_depth, "%d", &p->queue_depth);
+	}
+
+	return p->queue_depth;
+}
+
 const char *nvme_path_get_ana_state(nvme_path_t p)
 {
 	return p->ana_state;
@@ -921,7 +933,7 @@ void nvme_free_path(struct nvme_path *p)
 static int nvme_ctrl_scan_path(nvme_root_t r, struct nvme_ctrl *c, char *name)
 {
 	struct nvme_path *p;
-	_cleanup_free_ char *path = NULL, *grpid = NULL;
+	_cleanup_free_ char *path = NULL, *grpid = NULL, *queue_depth = NULL;
 	int ret;
 
 	nvme_msg(r, LOG_DEBUG, "scan controller %s path %s\n",
@@ -955,6 +967,11 @@ static int nvme_ctrl_scan_path(nvme_root_t r, struct nvme_ctrl *c, char *name)
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



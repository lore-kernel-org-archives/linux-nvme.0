Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C01ECF8FA8D
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Apr 2026 14:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=r8AOOZmCgaC02wqnDkDwWVZ3Kfri+SSQUq5PaxiEScY=; b=mBNP5Sj0H+T4bQL7RIP8sz1JFt
	vt5Hd3zNuO4wkdu+pky4lSX0mPLjy+Aa/4VO/u/QMlkJVRMZGwSR9MOhJPEcq2eCjAyIMdH0rFNyd
	u+Ic0BmOn6uLlgqMgnpfubf38ulEXWAaXeXVCCh0lT9YifCl33HlWTNKPgx853bX2iHraPx3d5aKG
	uxFVJE8Oqh9pG/F4cy3NOhhYkkbf11cRMG8CX0qtof9Zc/E8nrnkgFE6sU5PVUQ0tELPRlMCQAxLJ
	kPqf43eldtwImKF5VddNSJ8gL9pZaMrx8hRbS7J3VS+D/yQIdXvKeBwVEhSLoRxkm5vXecKymCfyX
	3MLsbYlg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFCRK-00000008liZ-0Wyy;
	Tue, 21 Apr 2026 14:51:02 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFCRE-00000008lfx-21hx
	for linux-nvme@lists.infradead.org;
	Tue, 21 Apr 2026 14:50:57 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63LC24Ag1685435;
	Tue, 21 Apr 2026 14:50:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=r8AOOZmCgaC02wqnD
	kDwWVZ3Kfri+SSQUq5PaxiEScY=; b=SJNkzGKz//WpXoUd0ipBYd0f0wg+oR/BK
	/TOdU23bcsNeCdpWionc3ELjCy5hN7ZhB2esGh0Jiv3VGxuVjNC4OSnq19qlWLy4
	sMZFZFtEPlmINY/6Lxmo7AbPbjcr7HUFufSjNa5sWsDHmfeyL4sJUAIqhDUYSteN
	iswaK62ErF4aF1tETtHZ3VfcZ43WJashIaTYz783bR7R2f8/cVpEzKm5bOW/EP/o
	uCDJ/l9Yc2w4x2VKYOOz7Epr34mCVjKNzXcfB1nUrUIdZtgvkkFR+dkPssuSQXh2
	49FITEdTLJ5WNSstC2qZYhOtTgkjuBW3BsNif4oZj8dJKGezV4cuQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dm2j6mtxh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Apr 2026 14:50:54 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63LEoGYm016644;
	Tue, 21 Apr 2026 14:50:53 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dmm9q18s5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Apr 2026 14:50:53 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63LEoo9646072134
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Apr 2026 14:50:50 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E795D2004B;
	Tue, 21 Apr 2026 14:50:49 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6C16D20043;
	Tue, 21 Apr 2026 14:50:47 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.39.30.130])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 21 Apr 2026 14:50:47 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, hare@suse.com, kbusch@kernel.org, hch@lst.de,
        gjoyce@linux.ibm.com, wenxiong@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCHv3 2/9] libnvme: annotate libnvme_path::numa_nodes with !accessors:none
Date: Tue, 21 Apr 2026 20:20:23 +0530
Message-ID: <20260421145038.3458987-3-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260421145038.3458987-1-nilay@linux.ibm.com>
References: <20260421145038.3458987-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDE0OCBTYWx0ZWRfX509B0m/w8FCi
 QYgI/AowOOtoLjPdXaL1k/spZVghHHMDKfTigN2bh9WR6W3sSyL4HSxQ9Jl/wsn1b2Rza+RG7ie
 1jQLFK7wEdLF25q4nQTa3mbaA2offWaG3OcjnSCfrxNuLg+/dO9Dk/8krHBj3AM010Wldd3YO/d
 Z2UHc8uPWpvhbccKaq99ta0DigAigz7gPSHQMG0fws7fAElkP1IK2/NYaROBUuP2vPFBWcSa+0X
 wC3O5lyNhSKKGn1xkR4xT7FVx48HqCn6kmqP8Ad5z6dfave6lrXFDosKCsICqfgjUnDolCtSwfq
 mneXLlHrTbTiuO4unU65MnSt5TZNRlI3lTGswuK4RMClTtFZFAtJ5EcbM2vK5omrhUQWoRF7xh8
 ENzh1XxmI8zN2LZRyezMF1PErVGJ1/3I2RWeP5PsvM1v398DAo9cPQdd3/l4Ow95U3cbO/Zs32y
 Zq0EjoQXuAJ/Ng3TLlA==
X-Proofpoint-GUID: -SDZYXk-Gza2dHVd2V0IJzbDsqG7DJdE
X-Authority-Analysis: v=2.4 cv=SOJykuvH c=1 sm=1 tr=0 ts=69e78ece cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=fzjDO7tI0B45nDDMH6sA:9
X-Proofpoint-ORIG-GUID: -SDZYXk-Gza2dHVd2V0IJzbDsqG7DJdE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 phishscore=0 suspectscore=0 adultscore=0 impostorscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604210148
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260421_075056_524547_865DA0FB 
X-CRM114-Status: GOOD (  17.20  )
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
attribute values. However, for libnvme_path::numa_nodes, a real-time
(non-cached) value is required.

This is particularly useful for tools such as nvme-top, which rely on
up-to-date information for displaying a real-time dashboard.

Annotate libnvme_path::numa_nodes with "!accessors:none" to disable the
auto-generated accessor, and provide a custom implementation of
libnvme_path_get_numa_nodes() that returns the current value.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 libnvme/src/accessors.ld     |  2 --
 libnvme/src/libnvme.ld       |  1 +
 libnvme/src/nvme/accessors.c | 13 -------------
 libnvme/src/nvme/accessors.h | 17 -----------------
 libnvme/src/nvme/private.h   |  2 +-
 libnvme/src/nvme/tree.c      | 15 +++++++++++++++
 libnvme/src/nvme/tree.h      |  8 ++++++++
 7 files changed, 25 insertions(+), 33 deletions(-)

diff --git a/libnvme/src/accessors.ld b/libnvme/src/accessors.ld
index 73b238ee9..4ccba1a6e 100644
--- a/libnvme/src/accessors.ld
+++ b/libnvme/src/accessors.ld
@@ -168,11 +168,9 @@ LIBNVME_ACCESSORS_3 {
 		libnvme_ns_set_sysfs_dir;
 		libnvme_path_get_grpid;
 		libnvme_path_get_name;
-		libnvme_path_get_numa_nodes;
 		libnvme_path_get_sysfs_dir;
 		libnvme_path_set_grpid;
 		libnvme_path_set_name;
-		libnvme_path_set_numa_nodes;
 		libnvme_path_set_sysfs_dir;
 		libnvme_subsystem_get_application;
 		libnvme_subsystem_get_firmware;
diff --git a/libnvme/src/libnvme.ld b/libnvme/src/libnvme.ld
index 19a7910cb..9b26de5cd 100644
--- a/libnvme/src/libnvme.ld
+++ b/libnvme/src/libnvme.ld
@@ -140,6 +140,7 @@ LIBNVME_3 {
 		libnvme_path_get_ns;
 		libnvme_path_get_queue_depth;
 		libnvme_path_get_ana_state;
+		libnvme_path_get_numa_nodes;
 		libnvme_random_uuid;
 		libnvme_read_config;
 		libnvme_read_hostid;
diff --git a/libnvme/src/nvme/accessors.c b/libnvme/src/nvme/accessors.c
index 675bb7d02..bcae8d578 100644
--- a/libnvme/src/nvme/accessors.c
+++ b/libnvme/src/nvme/accessors.c
@@ -291,19 +291,6 @@ __public const char *libnvme_path_get_sysfs_dir(const struct libnvme_path *p)
 	return p->sysfs_dir;
 }
 
-__public void libnvme_path_set_numa_nodes(
-		struct libnvme_path *p,
-		const char *numa_nodes)
-{
-	free(p->numa_nodes);
-	p->numa_nodes = numa_nodes ? strdup(numa_nodes) : NULL;
-}
-
-__public const char *libnvme_path_get_numa_nodes(const struct libnvme_path *p)
-{
-	return p->numa_nodes;
-}
-
 __public void libnvme_path_set_grpid(struct libnvme_path *p, int grpid)
 {
 	p->grpid = grpid;
diff --git a/libnvme/src/nvme/accessors.h b/libnvme/src/nvme/accessors.h
index 7ff0a274f..7ade91794 100644
--- a/libnvme/src/nvme/accessors.h
+++ b/libnvme/src/nvme/accessors.h
@@ -391,23 +391,6 @@ void libnvme_path_set_sysfs_dir(struct libnvme_path *p, const char *sysfs_dir);
  */
 const char *libnvme_path_get_sysfs_dir(const struct libnvme_path *p);
 
-/**
- * libnvme_path_set_numa_nodes() - Set numa_nodes.
- * @p: The &struct libnvme_path instance to update.
- * @numa_nodes: New string; a copy is stored. Pass NULL to clear.
- */
-void libnvme_path_set_numa_nodes(
-		struct libnvme_path *p,
-		const char *numa_nodes);
-
-/**
- * libnvme_path_get_numa_nodes() - Get numa_nodes.
- * @p: The &struct libnvme_path instance to query.
- *
- * Return: The value of the numa_nodes field, or NULL if not set.
- */
-const char *libnvme_path_get_numa_nodes(const struct libnvme_path *p);
-
 /**
  * libnvme_path_set_grpid() - Set grpid.
  * @p: The &struct libnvme_path instance to update.
diff --git a/libnvme/src/nvme/private.h b/libnvme/src/nvme/private.h
index 9d25373ed..2471495ad 100644
--- a/libnvme/src/nvme/private.h
+++ b/libnvme/src/nvme/private.h
@@ -176,8 +176,8 @@ struct libnvme_path { // !generate-accessors
 
 	char *name;
 	char *sysfs_dir;
-	char *numa_nodes;
 	char *ana_state; //!accessors:none
+	char *numa_nodes; //!accessors:none
 	int grpid;
 	int queue_depth; // !accessors:none
 };
diff --git a/libnvme/src/nvme/tree.c b/libnvme/src/nvme/tree.c
index 46e72ebc4..c2c959871 100644
--- a/libnvme/src/nvme/tree.c
+++ b/libnvme/src/nvme/tree.c
@@ -854,6 +854,21 @@ __public char *libnvme_path_get_ana_state(libnvme_path_t p)
 	return p->ana_state;
 }
 
+__public char *libnvme_path_get_numa_nodes(libnvme_path_t p)
+{
+	__cleanup_free char *numa_nodes = NULL;
+
+	numa_nodes = libnvme_get_path_attr(p, "numa_nodes");
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
 void nvme_free_path(struct libnvme_path *p)
 {
 	if (!p)
diff --git a/libnvme/src/nvme/tree.h b/libnvme/src/nvme/tree.h
index aa983b862..7cd90c620 100644
--- a/libnvme/src/nvme/tree.h
+++ b/libnvme/src/nvme/tree.h
@@ -668,6 +668,14 @@ int libnvme_path_get_queue_depth(libnvme_path_t p);
  */
 char *libnvme_path_get_ana_state(libnvme_path_t p);
 
+/**
+ * libnvme_path_get_numa_nodes() - Numa nodes of an nvme_path_t object
+ * @p: &libnvme_path_t object
+ *
+ * Return: Numa nodes of @p
+ */
+char *libnvme_path_get_numa_nodes(libnvme_path_t p);
+
 /**
  * libnvme_path_get_ctrl() - Parent controller of an libnvme_path_t object
  * @p:	&libnvme_path_t object
-- 
2.53.0



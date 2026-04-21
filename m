Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DBDCF8FA8C
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Apr 2026 14:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mQQn08cNHW9RcwALGAws8djNnuGPlGM0BcMSNqdhsTQ=; b=VCIrmFv9xmG0BCqZa1/uL0/OiV
	GgRp2Q2Zdzm0HpUhR7GbGkOXLP5ooA+YWxbvUT118S2CygmURkVEXwfWRYw/e/drOpHrd1iyswB1v
	6GnofhgJ/NnAqRXDWkJud68TcPmWrchKoLz1euaf5v1d2l5Ck+FvDsP3xXQds+1fuFVtn8SFhNTMQ
	Q4ncuHz2pCUmaeWGc89tfzGVzOBWTP5IBs+i8CeO7Yu76CEoFbV/vbzydzL9PT6pk7P6JOF2t7EUv
	ov1eRbAQnH3wtF8fI9fotkxdL2SM6XLeBAAzpI/3prfFw3NLlTy8OITKxhzmXD0rcmGvP513m0uMn
	dh5EhBmw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFCRJ-00000008li8-22bz;
	Tue, 21 Apr 2026 14:51:01 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFCRD-00000008lfc-1DYv
	for linux-nvme@lists.infradead.org;
	Tue, 21 Apr 2026 14:50:56 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63LBe4UJ1651508;
	Tue, 21 Apr 2026 14:50:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=mQQn08cNHW9RcwALG
	Aws8djNnuGPlGM0BcMSNqdhsTQ=; b=BFS2eKN+vSke1hs6NcUbM0mk4rfcLj9A/
	+1XYTYU0zK+dRhnNvnhAzfEizK7ppey33+Q3uc9NKHCu8ro35TytM0dKPwf+8A9c
	w02PsOkWV/5J1nY4bvQgts13vHxWlrDvX3n4XLSe4lIRxG00Fh5N2wqDlw2jOvfu
	OcgNTrM2KFcYvu7Xw91ROFzWqAhWFOCeUkbdBf5RJv2gHkKKH03YSCHjMjfGpefw
	xTVUd7HSb+HaYFhj8hbdAi0QLIhFbJ6SIyPurhHFwo8Dc8ptF+ywXtVT330pQlMG
	v+H9KzISH2GGG14t06Gz4Ix/Ya1OZ2UyHqebrAicqECBPY80ufR9A==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dm2k54twb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Apr 2026 14:50:52 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63LEgkAo019665;
	Tue, 21 Apr 2026 14:50:50 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dmmnvs7tw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Apr 2026 14:50:50 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63LEolaI59638212
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Apr 2026 14:50:47 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EF5AB2004B;
	Tue, 21 Apr 2026 14:50:46 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7A02D20043;
	Tue, 21 Apr 2026 14:50:44 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.39.30.130])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 21 Apr 2026 14:50:44 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, hare@suse.com, kbusch@kernel.org, hch@lst.de,
        gjoyce@linux.ibm.com, wenxiong@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCHv3 1/9] libnvme: annotate libnvme_path::ana_state with !accessors:none
Date: Tue, 21 Apr 2026 20:20:22 +0530
Message-ID: <20260421145038.3458987-2-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260421145038.3458987-1-nilay@linux.ibm.com>
References: <20260421145038.3458987-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Whk4kogwYjSlGeaMyc4Zqpd2-5uSSSUZ
X-Proofpoint-ORIG-GUID: Whk4kogwYjSlGeaMyc4Zqpd2-5uSSSUZ
X-Authority-Analysis: v=2.4 cv=VP7tWdPX c=1 sm=1 tr=0 ts=69e78ecc cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=6wZF3cyTe5wGATZG74UA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDE0OCBTYWx0ZWRfX1Ashkq3Zqg30
 B8rByAu70d9YtvJRanemVWcpaCHXFsaLHrGpnyPnvyWnCWgNZoqTD2GuFyCq2qiRchW+aEZOh+E
 Yo6PKIyJxFXFrQyoiLrvDdPOBIsELVNyun+6ecx3CsYwimRgwH+IHNgBQqrsQ9UOUVUVFw8WqBE
 JcgbykZ1P1HFTFFVbWxbxy1fl0bCs9YNYoWOb2nOd33vvFVjMdeFVxxIsW4kNALKd1lopB2F4DQ
 4FwRqzyq/9+WQyqVZRJvWaA7bC/XthRZngSHg0jy+8A22sqXIh7TehW7Ug8H9X3ezWvGyvjNI+u
 F4/CpviOWQMKgVcSS0iyn+gZzNB7h7JOwug85KWE0YQjAJxzESQuIY2cgcCLEbkgSnpW+MR3nIM
 GF/FwKlK0UPeKlNCjn8IZ/kqF9nhQmGYESILaC9l4ju4b8TV/aGzs4fS9QgOBe77AXTTw40txHk
 qPU/vX3mSXWwhkE83kw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604210148
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260421_075055_331964_C1811005 
X-CRM114-Status: GOOD (  17.45  )
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
attribute values. However, for libnvme_path::ana_state, a real-time
(non-cached) value is required.

This is particularly useful for tools such as nvme-top, which rely on
up-to-date information for displaying a real-time dashboard.

Annotate libnvme_path::ana_state with "!accessors:none" to disable the
auto-generated accessor, and provide a custom implementation of
libnvme_path_get_ana_state() that returns the current value.

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
index 7d0057218..73b238ee9 100644
--- a/libnvme/src/accessors.ld
+++ b/libnvme/src/accessors.ld
@@ -166,12 +166,10 @@ LIBNVME_ACCESSORS_3 {
 		libnvme_ns_set_name;
 		libnvme_ns_set_nsid;
 		libnvme_ns_set_sysfs_dir;
-		libnvme_path_get_ana_state;
 		libnvme_path_get_grpid;
 		libnvme_path_get_name;
 		libnvme_path_get_numa_nodes;
 		libnvme_path_get_sysfs_dir;
-		libnvme_path_set_ana_state;
 		libnvme_path_set_grpid;
 		libnvme_path_set_name;
 		libnvme_path_set_numa_nodes;
diff --git a/libnvme/src/libnvme.ld b/libnvme/src/libnvme.ld
index 961ca78d3..19a7910cb 100644
--- a/libnvme/src/libnvme.ld
+++ b/libnvme/src/libnvme.ld
@@ -139,6 +139,7 @@ LIBNVME_3 {
 		libnvme_path_get_ctrl;
 		libnvme_path_get_ns;
 		libnvme_path_get_queue_depth;
+		libnvme_path_get_ana_state;
 		libnvme_random_uuid;
 		libnvme_read_config;
 		libnvme_read_hostid;
diff --git a/libnvme/src/nvme/accessors.c b/libnvme/src/nvme/accessors.c
index 026358379..675bb7d02 100644
--- a/libnvme/src/nvme/accessors.c
+++ b/libnvme/src/nvme/accessors.c
@@ -291,19 +291,6 @@ __public const char *libnvme_path_get_sysfs_dir(const struct libnvme_path *p)
 	return p->sysfs_dir;
 }
 
-__public void libnvme_path_set_ana_state(
-		struct libnvme_path *p,
-		const char *ana_state)
-{
-	free(p->ana_state);
-	p->ana_state = ana_state ? strdup(ana_state) : NULL;
-}
-
-__public const char *libnvme_path_get_ana_state(const struct libnvme_path *p)
-{
-	return p->ana_state;
-}
-
 __public void libnvme_path_set_numa_nodes(
 		struct libnvme_path *p,
 		const char *numa_nodes)
diff --git a/libnvme/src/nvme/accessors.h b/libnvme/src/nvme/accessors.h
index ee89f8188..7ff0a274f 100644
--- a/libnvme/src/nvme/accessors.h
+++ b/libnvme/src/nvme/accessors.h
@@ -391,21 +391,6 @@ void libnvme_path_set_sysfs_dir(struct libnvme_path *p, const char *sysfs_dir);
  */
 const char *libnvme_path_get_sysfs_dir(const struct libnvme_path *p);
 
-/**
- * libnvme_path_set_ana_state() - Set ana_state.
- * @p: The &struct libnvme_path instance to update.
- * @ana_state: New string; a copy is stored. Pass NULL to clear.
- */
-void libnvme_path_set_ana_state(struct libnvme_path *p, const char *ana_state);
-
-/**
- * libnvme_path_get_ana_state() - Get ana_state.
- * @p: The &struct libnvme_path instance to query.
- *
- * Return: The value of the ana_state field, or NULL if not set.
- */
-const char *libnvme_path_get_ana_state(const struct libnvme_path *p);
-
 /**
  * libnvme_path_set_numa_nodes() - Set numa_nodes.
  * @p: The &struct libnvme_path instance to update.
diff --git a/libnvme/src/nvme/private.h b/libnvme/src/nvme/private.h
index 8f9e72382..9d25373ed 100644
--- a/libnvme/src/nvme/private.h
+++ b/libnvme/src/nvme/private.h
@@ -176,8 +176,8 @@ struct libnvme_path { // !generate-accessors
 
 	char *name;
 	char *sysfs_dir;
-	char *ana_state;
 	char *numa_nodes;
+	char *ana_state; //!accessors:none
 	int grpid;
 	int queue_depth; // !accessors:none
 };
diff --git a/libnvme/src/nvme/tree.c b/libnvme/src/nvme/tree.c
index b9d8cf39b..46e72ebc4 100644
--- a/libnvme/src/nvme/tree.c
+++ b/libnvme/src/nvme/tree.c
@@ -839,6 +839,21 @@ __public int libnvme_path_get_queue_depth(libnvme_path_t p)
 	return p->queue_depth;
 }
 
+__public char *libnvme_path_get_ana_state(libnvme_path_t p)
+{
+	__cleanup_free char *ana_state = NULL;
+
+	ana_state = libnvme_get_path_attr(p, "ana_state");
+	if (ana_state) {
+		if (!p->ana_state || strcmp(ana_state, p->ana_state)) {
+			free(p->ana_state);
+			p->ana_state = strdup(ana_state);
+		}
+	}
+
+	return p->ana_state;
+}
+
 void nvme_free_path(struct libnvme_path *p)
 {
 	if (!p)
diff --git a/libnvme/src/nvme/tree.h b/libnvme/src/nvme/tree.h
index 403ad43d5..aa983b862 100644
--- a/libnvme/src/nvme/tree.h
+++ b/libnvme/src/nvme/tree.h
@@ -660,6 +660,14 @@ int libnvme_ns_identify_descs(libnvme_ns_t n, struct nvme_ns_id_desc *descs);
  */
 int libnvme_path_get_queue_depth(libnvme_path_t p);
 
+/**
+ * libnvme_path_get_ana_state() - ANA state of an nvme_path_t object
+ * @p: &libnvme_path_t object
+ *
+ * Return: ANA state of @p
+ */
+char *libnvme_path_get_ana_state(libnvme_path_t p);
+
 /**
  * libnvme_path_get_ctrl() - Parent controller of an libnvme_path_t object
  * @p:	&libnvme_path_t object
-- 
2.53.0



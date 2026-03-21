Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2E821094489
	for <linux-nvme@archiver.kernel.org>; Sat, 21 Mar 2026 15:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ibu6t1mkvJZAJRJU4GrbWmPEePLtdH+I/2UeHAL+FAo=; b=0Q/dtBWL/EX2vnnPFYjYcMuRSN
	W/YBsa2dT96yhMwhCkHPSOCl0UJ00m5rue9DIcwkDJCI7bBKMBSZerWzC8JaJzvYAt52k0xkEqtIP
	6Drlkdur9B+J2f1sp7EpQydbYyZoubd4Oe7cUsYfdOmA5MNMrlNnxRHq/XlbjnuI2MXHCnOeoISIn
	ZXq1qtMoVxeitDcUFIBIOoIDI7N7e7hdFQILHPZVn2GABoVA4wP9ycwW8uML9Ynr/jkIrkjiUum0x
	rp4d45C+3oiDLb20gQZV5o3emZB3jTBz9jDo3iDm1VzMTnTlsJH8U2InkAC7OdeMgBLM8x08g4sFU
	aTp7Jiog==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3yFy-0000000Ea4N-3uLC;
	Sat, 21 Mar 2026 15:28:54 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3yFp-0000000Ea0l-3gwY
	for linux-nvme@lists.infradead.org;
	Sat, 21 Mar 2026 15:28:47 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62LEPJ5s1029434;
	Sat, 21 Mar 2026 15:28:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Ibu6t1mkvJZAJRJU4
	GrbWmPEePLtdH+I/2UeHAL+FAo=; b=go2c4+wD4rUsV7E9958Nd4NqGaOsnMMVt
	+MLrPhasLlw+mxytfk818/qhKoxnullVvMWFw/ZLbhg4ourHmyqNflCIIfouv0Nj
	j6aQqR7lCUc3DypVnaLrtwY4EpFXyXtQS0lIBd0NYXn8f+uGdDdqN8Aqi8hwFEvO
	7k3rNiual63X+YPGGKZPhGPHio4AjjcUqNW6V7kXLaYEq+YXd/kw1SpNEC4r86pm
	GNAXbUj0vflpna+DyQRNzwTt2n/AK5n7X9x09moKAyTnIHzRDxhyJzKKTucype5i
	77lkkV332B4tbFm02gWxsVU3JXz0hU0oe/oCXGyMJcWL++JH7lucQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kxys66n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 21 Mar 2026 15:28:42 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62LA73t2006295;
	Sat, 21 Mar 2026 15:28:42 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cwkgkux06-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 21 Mar 2026 15:28:41 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62LFSbYa57082194
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 21 Mar 2026 15:28:38 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DF42B20049;
	Sat, 21 Mar 2026 15:28:37 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 53BD120040;
	Sat, 21 Mar 2026 15:28:35 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.124.222.150])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 21 Mar 2026 15:28:34 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, hare@suse.com, kbusch@kernel.org, hch@lst.de,
        gjoyce@ibm.com, wenxiong@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH 1/9] libnvme: annotate nvme_path::ana_state with !accessors:none
Date: Sat, 21 Mar 2026 20:58:00 +0530
Message-ID: <20260321152823.3197870-2-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260321152823.3197870-1-nilay@linux.ibm.com>
References: <20260321152823.3197870-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIxMDEyOSBTYWx0ZWRfX6LcsShYP+3AO
 23XNM1UepcOqfquS9BbLC1uIJSJMAR4DJyFNApHaipqJGLEWuS8QGGRI5lqJ7b4cW7KFRfJOOer
 IxCLcFeeQ2yBejTJYFvycN1m5PRKbRCuV6A5JqI/O6g0kLNlM5lkObt7KiOzimh0EAn+RNK5UTj
 hbOgTbB9tbq7A4BffCErNbqVNeszMCzLaAJzjO/sWUmGTIyzIZMCdRV4rvCCpfUeWn40csh4MAO
 0pzYDcCSn2lq/Asa091PFf1Obm784Px7wTE9dEKGmxsvZbEiab7UNxlpJxVicOcu6lp2Yf3z9/1
 +DQ07nJIU3Ptq5LHtO+WiyHfLRAR9kul92L1mjbTuuF+zBPzeioZMw4ZgaTqQPiZF67GPrAZGDw
 u8Kulni9jKbSZ1gUi98+nKdR5SKSHIQjk/cCVXpgPwQayYmnMR24snJq6o1TiJ8ECNA+bIX1xWe
 3xnBBgZIhawsbP9Bi1A==
X-Authority-Analysis: v=2.4 cv=JK42csKb c=1 sm=1 tr=0 ts=69beb92a cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=cXzdoU1T7TFplbsrT5gA:9
X-Proofpoint-ORIG-GUID: jRwG3PUYfSIZ7dHrqTMIk0tEoqkb8_2T
X-Proofpoint-GUID: jRwG3PUYfSIZ7dHrqTMIk0tEoqkb8_2T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-21_05,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 malwarescore=0 adultscore=0
 spamscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603210129
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260321_082846_039248_AB44B958 
X-CRM114-Status: GOOD (  17.97  )
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
attribute values. However, for nvme_path::ana_state, a real-time
(non-cached) value is required.

This is particularly useful for tools such as nvme-top, which rely on
up-to-date information for displaying a real-time dashboard.

Annotate nvme_path::ana_state with "!accessors:none" to disable the
auto-generated accessor, and provide a custom implementation of
nvme_path_get_ana_state() that returns the current value.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 libnvme/src/accessors.ld     |  2 --
 libnvme/src/libnvme.ld       |  1 +
 libnvme/src/nvme/accessors.c | 13 -------------
 libnvme/src/nvme/accessors.h | 15 ---------------
 libnvme/src/nvme/private.h   |  2 +-
 libnvme/src/nvme/tree.c      | 16 ++++++++++++++++
 libnvme/src/nvme/tree.h      |  8 ++++++++
 7 files changed, 26 insertions(+), 31 deletions(-)

diff --git a/libnvme/src/accessors.ld b/libnvme/src/accessors.ld
index 3cd26f8f7..9e5653b92 100644
--- a/libnvme/src/accessors.ld
+++ b/libnvme/src/accessors.ld
@@ -14,8 +14,6 @@ LIBNVME_ACCESSORS_3 {
 		nvme_path_set_name;
 		nvme_path_get_sysfs_dir;
 		nvme_path_set_sysfs_dir;
-		nvme_path_get_ana_state;
-		nvme_path_set_ana_state;
 		nvme_path_get_numa_nodes;
 		nvme_path_set_numa_nodes;
 		nvme_path_get_grpid;
diff --git a/libnvme/src/libnvme.ld b/libnvme/src/libnvme.ld
index 6d5d7a0f9..0fd86be71 100644
--- a/libnvme/src/libnvme.ld
+++ b/libnvme/src/libnvme.ld
@@ -142,6 +142,7 @@ LIBNVME_3 {
 		nvme_path_get_ctrl;
 		nvme_path_get_ns;
 		nvme_path_get_queue_depth;
+		nvme_path_get_ana_state;
 		nvme_filter_paths;
 		nvme_read_config;
 		nvme_read_key;
diff --git a/libnvme/src/nvme/accessors.c b/libnvme/src/nvme/accessors.c
index d3c507d7e..8b095ed4d 100644
--- a/libnvme/src/nvme/accessors.c
+++ b/libnvme/src/nvme/accessors.c
@@ -52,19 +52,6 @@ __public const char *nvme_path_get_sysfs_dir(const struct nvme_path *p)
 	return p->sysfs_dir;
 }
 
-__public void nvme_path_set_ana_state(
-		struct nvme_path *p,
-		const char *ana_state)
-{
-	free(p->ana_state);
-	p->ana_state = ana_state ? strdup(ana_state) : NULL;
-}
-
-__public const char *nvme_path_get_ana_state(const struct nvme_path *p)
-{
-	return p->ana_state;
-}
-
 __public void nvme_path_set_numa_nodes(
 		struct nvme_path *p,
 		const char *numa_nodes)
diff --git a/libnvme/src/nvme/accessors.h b/libnvme/src/nvme/accessors.h
index 5c594dd12..3ede23cbc 100644
--- a/libnvme/src/nvme/accessors.h
+++ b/libnvme/src/nvme/accessors.h
@@ -68,21 +68,6 @@ void nvme_path_set_sysfs_dir(struct nvme_path *p, const char *sysfs_dir);
  */
 const char *nvme_path_get_sysfs_dir(const struct nvme_path *p);
 
-/**
- * nvme_path_set_ana_state() - Set ana_state.
- * @p: The &struct nvme_path instance to update.
- * @ana_state: New string; a copy is stored. Pass NULL to clear.
- */
-void nvme_path_set_ana_state(struct nvme_path *p, const char *ana_state);
-
-/**
- * nvme_path_get_ana_state() - Get ana_state.
- * @p: The &struct nvme_path instance to query.
- *
- * Return: The value of the ana_state field, or NULL if not set.
- */
-const char *nvme_path_get_ana_state(const struct nvme_path *p);
-
 /**
  * nvme_path_set_numa_nodes() - Set numa_nodes.
  * @p: The &struct nvme_path instance to update.
diff --git a/libnvme/src/nvme/private.h b/libnvme/src/nvme/private.h
index 82873fcd6..25fec3216 100644
--- a/libnvme/src/nvme/private.h
+++ b/libnvme/src/nvme/private.h
@@ -137,8 +137,8 @@ struct nvme_path { /*!generate-accessors*/
 
 	char *name;
 	char *sysfs_dir;
-	char *ana_state;
 	char *numa_nodes;
+	char *ana_state; //!accessors:none
 	int grpid;
 	int queue_depth; //!accessors:none
 };
diff --git a/libnvme/src/nvme/tree.c b/libnvme/src/nvme/tree.c
index 0d836b436..1adc2c57a 100644
--- a/libnvme/src/nvme/tree.c
+++ b/libnvme/src/nvme/tree.c
@@ -804,6 +804,22 @@ __public int nvme_path_get_queue_depth(nvme_path_t p)
 	return p->queue_depth;
 }
 
+__public char *nvme_path_get_ana_state(nvme_path_t p)
+{
+	_cleanup_free_ char *ana_state = NULL;
+
+	ana_state = nvme_get_path_attr(p, "ana_state");
+	if (ana_state) {
+		if (!p->ana_state || strcmp(ana_state, p->ana_state)) {
+			free(p->ana_state);
+			p->ana_state = strdup(ana_state);
+
+	}
+	}
+
+	return p->ana_state;
+}
+
 void nvme_free_path(struct nvme_path *p)
 {
 	list_del_init(&p->entry);
diff --git a/libnvme/src/nvme/tree.h b/libnvme/src/nvme/tree.h
index 07b75677c..ec0f4f2e6 100644
--- a/libnvme/src/nvme/tree.h
+++ b/libnvme/src/nvme/tree.h
@@ -679,6 +679,14 @@ int nvme_ns_identify_descs(nvme_ns_t n, struct nvme_ns_id_desc *descs);
  */
 int nvme_path_get_queue_depth(nvme_path_t p);
 
+/**
+ * nvme_path_get_ana_state() - ANA state of an nvme_path_t object
+ * @p: &nvme_path_t object
+ *
+ * Return: ANA state of @p
+ */
+char *nvme_path_get_ana_state(nvme_path_t p);
+
 /**
  * nvme_path_get_ctrl() - Parent controller of an nvme_path_t object
  * @p:	&nvme_path_t object
-- 
2.53.0



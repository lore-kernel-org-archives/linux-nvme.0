Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCC4CE88D97
	for <linux-nvme@archiver.kernel.org>; Sat,  4 Apr 2026 10:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/pPYG8jVWXimEn9WGaK8lDKVtoHqYDg+07mPJRsX6mQ=; b=YtBQi7eZ9c5kVh96hWqLiLbjEN
	ao30878Ul3DU305nmo/VHLsVajyIv0Na6WtgY4NCD+I5unniYLQ5SMF+HYFuBaP3DRVp3Xcw7hFti
	crUe4GJIUYMfX8RzJOw0mfdb18NbYWBXiceVB7GaS2c7yBtklT9O07vwn8c1gEyQE+aaRffDTjrWH
	wQQaqUgQJW0hboDtAxsu1cst6rDlRLfRPTPZ0P5Ref/KKBvMSyhfCzx6Nc0QPS6dc5iazcCE7f4eD
	zP/FDCdHrJQdz5xZ1JL5miIObqSAyeigT+OnonxJbiBXCjMRJt0x3G3wPEpZT26grzpHoLCGVE8h7
	+sh2gmuQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8y2H-00000003MGr-0HlT;
	Sat, 04 Apr 2026 10:15:25 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8y2E-00000003MFa-2Zoh
	for linux-nvme@lists.infradead.org;
	Sat, 04 Apr 2026 10:15:23 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6345v9vA3677458;
	Sat, 4 Apr 2026 10:15:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=/pPYG8jVWXimEn9WG
	aK8lDKVtoHqYDg+07mPJRsX6mQ=; b=H+PXwRVg0x0g8aRLjCm4AagAGHzf4d7MV
	N2ldDaj36dxd/Th14+J38lgX83CIQPcqspjSB5cDq+xVQNVQKUwvTw/+kuyFqaW3
	W9Z++rkH2p0Oj7zWEhb09UnwyOlp2aK0Nd2IAMa1ZNaO783VOdPYMyOfuigRX4rB
	HT5VYtcIJGizwYprbg8FE83FXOa7S+NPfeJMztMhTSprMmtmhFqnia1KYFbffdF7
	7ipF9TIoq0xc4g3zIhRv4IoT/QEe6qdXi3i+gHdREa8Pc6hfnrvHxQmYNCdwTC2g
	h7huHE1DkIvPwOw7ElKGuSZuDqBHdHQ0MoioIiCcFPIIuTw+ce+pg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dat51rr5u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 04 Apr 2026 10:15:20 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6348lfPr013919;
	Sat, 4 Apr 2026 10:15:19 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d6ttm122u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 04 Apr 2026 10:15:19 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 634AFFQd27722000
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 4 Apr 2026 10:15:15 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 12D342005A;
	Sat,  4 Apr 2026 10:15:15 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CDAFF2004E;
	Sat,  4 Apr 2026 10:15:11 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.124.211.35])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat,  4 Apr 2026 10:15:10 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, hare@suse.com, kbusch@kernel.org, hch@lst.de,
        gjoyce@linux.ibm.com, wenxiong@linux.ibm.com
Subject: [PATCHv2 1/9] libnvme: annotate nvme_path::ana_state with !accessors:none
Date: Sat,  4 Apr 2026 15:44:51 +0530
Message-ID: <20260404101504.44539-2-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260404101504.44539-1-nilay@linux.ibm.com>
References: <20260404101504.44539-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=J6anLQnS c=1 sm=1 tr=0 ts=69d0e4b8 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=cXzdoU1T7TFplbsrT5gA:9
X-Proofpoint-GUID: shdOx1ky8k7HKOwK6u8zXkUcZ_Sv8jHo
X-Proofpoint-ORIG-GUID: shdOx1ky8k7HKOwK6u8zXkUcZ_Sv8jHo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA0MDA4OCBTYWx0ZWRfX7Y12YGqjuy/9
 yP3rNM1FuXGbauCutVpM70CdMymwW8+Dj0QlVMtnl5UeaaNbJFtuBuhJTQtNzPxlv6mXouHeVQo
 JJgkXnCezScy+dpMhrYbbkqIdM+R6AN6k9ygDPg2FNO3IDpAhEOWY2N9OiJ2HvrTdOIQKUpuRlW
 NC7dngPWabMrPir7RO5Om8G0wXL6nxbRoVTHvvAehdihV3j4AvGQbYEZCpXvvapEW98iRsMX6mr
 irAHIJsbYw893eYfhTniGvq929NjNBLF8QJT14orKsFpCQq6Z/ysUfM/8F+I7RoyGPHM6PMyWh/
 5obz2mfhYWv+l9rqBny2xibu4vnERkO5i5nhEUD1VoiTWYWMpKnNik1UcoqpcC67HCHDpqpTbwl
 e63v7dAwOfO73bD13NDCXmqWKMmnlGCtU2CHkmTQuCbGQf8nw1y7PxzEfrHIOxI3C9V/TPIzVWO
 ITdvx82W9xPI+ZbZSGQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-03_07,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 impostorscore=0 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604040088
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260404_031522_658560_A627E068 
X-CRM114-Status: GOOD (  16.25  )
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
 libnvme/src/nvme/tree.c      | 15 +++++++++++++++
 libnvme/src/nvme/tree.h      |  8 ++++++++
 7 files changed, 25 insertions(+), 31 deletions(-)

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
index 2a34886af..38625cbf4 100644
--- a/libnvme/src/libnvme.ld
+++ b/libnvme/src/libnvme.ld
@@ -142,6 +142,7 @@ LIBNVME_3 {
 		nvme_path_get_ctrl;
 		nvme_path_get_ns;
 		nvme_path_get_queue_depth;
+		nvme_path_get_ana_state;
 		nvme_random_uuid;
 		nvme_read_config;
 		nvme_read_hostid;
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
index c3651fb95..7631c4084 100644
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
index 377f6e8ea..f087d7b03 100644
--- a/libnvme/src/nvme/tree.c
+++ b/libnvme/src/nvme/tree.c
@@ -806,6 +806,21 @@ __public int nvme_path_get_queue_depth(nvme_path_t p)
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
+		}
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



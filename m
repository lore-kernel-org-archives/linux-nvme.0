Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 898B3E88D66
	for <linux-nvme@archiver.kernel.org>; Sat,  4 Apr 2026 10:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YGhekxjWt+Exidi6qzEFEyMo9uDiRhjTpQUyEJ3s9H4=; b=1YNwDy4DFVT7nzBuxys53jz+T4
	aHknrF3MDIX5i1camlixtf5OXDoY+D5NASPDoGF8lLzdRDz57/X9KThu7sEXirItH8ZHTVunvcZJX
	GeVQQyF0X3iRUp4ZQJMIiGPHZhcBe04RE+7GWJ4QEKDPRooSk4LdR39AsQBdphte+oDqZS4nDsjok
	rOiagf4F987V3Ra6yCoPSd5aavjKWpPZyf3UbpJ8z3DVWDroEyDnaIbdcNPih22ZQWyIQpUc3kfO8
	BzicH5a9PCzAiq9vkCUREJFE89EY3qkXNgvm/g//p6v+WB+7j8ov2NcvXde3DXeXaweq/j14p2eUM
	U9fxguEg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8y2O-00000003MJQ-3Ab2;
	Sat, 04 Apr 2026 10:15:32 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8y2M-00000003MIf-22OT
	for linux-nvme@lists.infradead.org;
	Sat, 04 Apr 2026 10:15:31 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6342kDfZ3323759;
	Sat, 4 Apr 2026 10:15:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=YGhekxjWt+Exidi6q
	zEFEyMo9uDiRhjTpQUyEJ3s9H4=; b=s7bE2HoEnC0+iBt7PYVphcNbVYQ8WFQZ4
	JAHu3qaUwVzZXbG2m8L0jQukm0AgLrfYmsP5XaEdsy2KoZEPxxGVOhRKSrATZOOc
	7N2fXxg2xWzbo2Gg+Oe5VnNB97MRuOCyP4sa1Sw0oulefCRXUT0cXu79VLXOW6yl
	nMiAvoXZMpPNcLA+qW4SDslADaaLeG7iTv2t0Gn3OMu/A5xGvrmjTU7PxUNAyfTz
	q6cz2TiE7qpuXbukxqD/DOnqf0EvSZQWKyZkN5wYEXiQJEsiG1KBQBhEGxc2NsSA
	3aDNy+W2XSxj/s5xeBN8mSrhs14SoY1qz487k2ZWcQgrFlqhGvzOQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dat51rr68-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 04 Apr 2026 10:15:28 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 634804Lg013987;
	Sat, 4 Apr 2026 10:15:27 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d6ttm1237-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 04 Apr 2026 10:15:27 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 634AFN0R44695838
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 4 Apr 2026 10:15:23 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 05A3C2004F;
	Sat,  4 Apr 2026 10:15:23 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 51A842004E;
	Sat,  4 Apr 2026 10:15:19 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.124.211.35])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat,  4 Apr 2026 10:15:18 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, hare@suse.com, kbusch@kernel.org, hch@lst.de,
        gjoyce@linux.ibm.com, wenxiong@linux.ibm.com
Subject: [PATCHv2 3/9] libnvme: annotate nvme_subsystem::iopolicy with !accessors:none
Date: Sat,  4 Apr 2026 15:44:53 +0530
Message-ID: <20260404101504.44539-4-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260404101504.44539-1-nilay@linux.ibm.com>
References: <20260404101504.44539-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=J6anLQnS c=1 sm=1 tr=0 ts=69d0e4c0 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=i8JyOrThOiZbpa8wNwIA:9
X-Proofpoint-GUID: quHAsh79oezBVsL0eErH8XEv5I9moAMt
X-Proofpoint-ORIG-GUID: quHAsh79oezBVsL0eErH8XEv5I9moAMt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA0MDA4OCBTYWx0ZWRfX/yF3Xr2ARo/W
 136YI0bX13xPtUnU4h9eyzMuidDbVihxAAbtnJpA9jChXOf6KzZuozmtHOniagrD8d9//xnhF3S
 txTlxhlluC/qv2AXn1XF2JkDLlv+mDz3kqO+Ooiw36hJuk138AOQeFTkzK81MnLfVqUS7/fKxVq
 EzVEYNR0ADT4FsrlblwMApDe/YQIrT867495OeShrxbuOV7eaOput36r8k4Hb3nVFNLiI+miSLN
 EiFYcWtiOyDEkkLSRQh+8bFZrc4/9YbIeNCM1eKC5TKkFcYE4cHxv1mrcRj4OsgqsgJdJgWrvNc
 u89wvWLUSdcx8dk8vRrkKCY7zW1J6U63MoUMSxkQ5q62beTXgMxs8mOi6DjsieNFDr/iyep7rMT
 jVoC7PoPjAXdMe9koC/NJVpdrgVTQZNRBdiX40sPHqfnXaBoP3ORfjRNwz4mzrt3NjS+qj/PP48
 Ge+r82M/QU16/r6Vp6A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-03_07,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 impostorscore=0 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604040088
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260404_031530_533480_9BFFFBB5 
X-CRM114-Status: GOOD (  15.79  )
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
attribute values. However, for nvme_subsystem::iopolicy, a real-time
(non-cached) value is required.

This is particularly useful for tools such as nvme-top, which rely on
up-to-date information for displaying a real-time dashboard.

Annotate nvme_subsystem::iopolicy with "!accessors:none" to disable the
auto-generated accessor, and provide a custom implementation of
nvme_subsystem_get_iopolicy() that returns the current value.

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
index 433767191..56348a7e5 100644
--- a/libnvme/src/accessors.ld
+++ b/libnvme/src/accessors.ld
@@ -77,8 +77,6 @@ LIBNVME_ACCESSORS_3 {
 		nvme_subsystem_get_subsystype;
 		nvme_subsystem_get_application;
 		nvme_subsystem_set_application;
-		nvme_subsystem_get_iopolicy;
-		nvme_subsystem_set_iopolicy;
 		nvme_host_get_hostnqn;
 		nvme_host_get_hostid;
 		nvme_host_get_dhchap_host_key;
diff --git a/libnvme/src/libnvme.ld b/libnvme/src/libnvme.ld
index f2972f455..1ff451d3d 100644
--- a/libnvme/src/libnvme.ld
+++ b/libnvme/src/libnvme.ld
@@ -180,6 +180,7 @@ LIBNVME_3 {
 		nvme_subsystem_first_ctrl;
 		nvme_subsystem_first_ns;
 		nvme_subsystem_get_host;
+		nvme_subsystem_get_iopolicy;
 		nvme_subsystem_lookup_namespace;
 		nvme_subsystem_next_ctrl;
 		nvme_subsystem_next_ns;
diff --git a/libnvme/src/nvme/accessors.c b/libnvme/src/nvme/accessors.c
index a98f26234..55fd11320 100644
--- a/libnvme/src/nvme/accessors.c
+++ b/libnvme/src/nvme/accessors.c
@@ -404,19 +404,6 @@ __public const char *nvme_subsystem_get_application(
 	return p->application;
 }
 
-__public void nvme_subsystem_set_iopolicy(
-		struct nvme_subsystem *p,
-		const char *iopolicy)
-{
-	free(p->iopolicy);
-	p->iopolicy = iopolicy ? strdup(iopolicy) : NULL;
-}
-
-__public const char *nvme_subsystem_get_iopolicy(const struct nvme_subsystem *p)
-{
-	return p->iopolicy;
-}
-
 /****************************************************************************
  * Accessors for: struct nvme_host
  ****************************************************************************/
diff --git a/libnvme/src/nvme/accessors.h b/libnvme/src/nvme/accessors.h
index f9323ad11..9ea96a634 100644
--- a/libnvme/src/nvme/accessors.h
+++ b/libnvme/src/nvme/accessors.h
@@ -575,23 +575,6 @@ void nvme_subsystem_set_application(
  */
 const char *nvme_subsystem_get_application(const struct nvme_subsystem *p);
 
-/**
- * nvme_subsystem_set_iopolicy() - Set iopolicy.
- * @p: The &struct nvme_subsystem instance to update.
- * @iopolicy: New string; a copy is stored. Pass NULL to clear.
- */
-void nvme_subsystem_set_iopolicy(
-		struct nvme_subsystem *p,
-		const char *iopolicy);
-
-/**
- * nvme_subsystem_get_iopolicy() - Get iopolicy.
- * @p: The &struct nvme_subsystem instance to query.
- *
- * Return: The value of the iopolicy field, or NULL if not set.
- */
-const char *nvme_subsystem_get_iopolicy(const struct nvme_subsystem *p);
-
 /****************************************************************************
  * Accessors for: struct nvme_host
  ****************************************************************************/
diff --git a/libnvme/src/nvme/private.h b/libnvme/src/nvme/private.h
index e115c4310..0b8dec81e 100644
--- a/libnvme/src/nvme/private.h
+++ b/libnvme/src/nvme/private.h
@@ -230,7 +230,7 @@ struct nvme_subsystem { /*!generate-accessors*/
 	char *firmware; /*!accessors:readonly*/
 	char *subsystype; /*!accessors:readonly*/
 	char *application;
-	char *iopolicy;
+	char *iopolicy; //!accessors:none
 };
 
 struct nvme_host { /*!generate-accessors*/
diff --git a/libnvme/src/nvme/tree.c b/libnvme/src/nvme/tree.c
index 93982dfd2..ac3779dca 100644
--- a/libnvme/src/nvme/tree.c
+++ b/libnvme/src/nvme/tree.c
@@ -445,6 +445,21 @@ __public nvme_host_t nvme_subsystem_get_host(nvme_subsystem_t s)
 	return s->h;
 }
 
+__public char *nvme_subsystem_get_iopolicy(nvme_subsystem_t s)
+{
+	_cleanup_free_ char *iopolicy = NULL;
+
+	iopolicy = nvme_get_subsys_attr(s, "iopolicy");
+	if (iopolicy) {
+		if (!s->iopolicy || strcmp(iopolicy, s->iopolicy)) {
+			free(s->iopolicy);
+			s->iopolicy = strdup(iopolicy);
+		}
+	}
+
+	return s->iopolicy;
+}
+
 __public nvme_ns_t nvme_subsystem_first_ns(nvme_subsystem_t s)
 {
 	return list_top(&s->namespaces, struct nvme_ns, entry);
diff --git a/libnvme/src/nvme/tree.h b/libnvme/src/nvme/tree.h
index 1240f3023..39d715508 100644
--- a/libnvme/src/nvme/tree.h
+++ b/libnvme/src/nvme/tree.h
@@ -212,6 +212,14 @@ void nvme_free_subsystem(struct nvme_subsystem *s);
  */
 nvme_host_t nvme_subsystem_get_host(nvme_subsystem_t s);
 
+/**
+ * nvme_subsystem_get_iopolicy() - Get subsystem iopolicy name
+ * @s:	subsystem
+ *
+ * Return: The iopolicy configured in subsystem @s
+ */
+char *nvme_subsystem_get_iopolicy(nvme_subsystem_t s);
+
 /**
  * nvme_ctrl_first_ns() - Start namespace iterator
  * @c:	Controller instance
-- 
2.53.0



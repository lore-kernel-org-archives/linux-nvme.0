Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37B251094486
	for <linux-nvme@archiver.kernel.org>; Sat, 21 Mar 2026 15:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pw0w5izld27ewNvRTAjfeZwrkkfdwsQwBiS6RaqHi9s=; b=hktRdGWU2kByZaJ/1nCKCZv1ys
	nB3W5DANlWbEprFGrYEk4iE6yk4uScXI3JjL86s9e5Ize7oJNKaKJ7HyrgG43rgdajpydYRD4/gY6
	iwIFe2x8IwHbId8k4elvv67aUZ84rFSKhk7R+sWmczVEZZ8UmEXWUaqzqF9KNxz3kO/3c5fYJ9vKv
	hH1BRdsKKOrwJSAAixHakRsTTKr7s8TpaTV3yWrKHa9aYUGt/tZ+ulwRwMoFiFI/YJSmlxe+CzQPl
	3ZZt/4Ub7e+nvDGwmH1c3Vi8sLTBypoG6DFiBfl6VhvvZbeCQxKVOX3OkXl7YbFoSYkM+vTihyH/w
	JQv3JHVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3yG7-0000000Ea8F-2aM0;
	Sat, 21 Mar 2026 15:29:03 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3yG4-0000000Ea5e-3RwQ
	for linux-nvme@lists.infradead.org;
	Sat, 21 Mar 2026 15:29:02 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62LBwQKQ861448;
	Sat, 21 Mar 2026 15:28:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=pw0w5izld27ewNvRT
	AjfeZwrkkfdwsQwBiS6RaqHi9s=; b=qXPrcD2t15EkFjPJkJckPE+OCxUsKVSwq
	By0YSK4UfcKEncnoH3CSuydcM21j36qZ4dpDKSrqycz8yY20XnBRZXmYASEKZB2Q
	cwXB0jbccKo2O9VQonY5haAPyBMIK9BlVv+fOokTkFgaYfg8N6btlvQscWaDpyIt
	9xM+DxHOf+DmU01xnAk8bW9DhYRKEXu1Hpfr8M30rPBAZYeil3wf2YT4Vq8Bxpnd
	bfJ7/TYiSVMkgclCJaISUVUfMoCB4ROeBB/sX0GBsnMtqS4i1scYAsprQz8IeMLN
	TIvZZIxuc3DKJ8clubfilDZnKOKt1zcEoFd0mJr78Su9Jsya40WYg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1ktxh8u8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 21 Mar 2026 15:28:52 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62LAU1ux006315;
	Sat, 21 Mar 2026 15:28:51 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cwkgkux0p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 21 Mar 2026 15:28:51 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62LFSlOs26345794
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 21 Mar 2026 15:28:48 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D206720049;
	Sat, 21 Mar 2026 15:28:47 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8ADB820040;
	Sat, 21 Mar 2026 15:28:44 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.124.222.150])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 21 Mar 2026 15:28:44 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, hare@suse.com, kbusch@kernel.org, hch@lst.de,
        gjoyce@ibm.com, wenxiong@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH 3/9] libnvme: annotate nvme_subsystem::iopolicy with !accessors:none
Date: Sat, 21 Mar 2026 20:58:02 +0530
Message-ID: <20260321152823.3197870-4-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260321152823.3197870-1-nilay@linux.ibm.com>
References: <20260321152823.3197870-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=IqITsb/g c=1 sm=1 tr=0 ts=69beb934 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=i8JyOrThOiZbpa8wNwIA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIxMDEyOSBTYWx0ZWRfX2F1Ry9VkPiB9
 y+zT7gzyRvg51AwN3rXHxEVtgp+uy4Slt40bf45QQtTCMykPzqobCwLOMwLg0oBx9uCRmP7dKWr
 kS6DKbYEySWhAZXf0bmoxOt7EhmLoFhmEbW5rZXSlcIqS3o2gjOCWL5Eds59o2XGlgBIlFw1RIo
 P03m1H0dUOm/7wocwh7Vtl4EHK2MqdNSTyFLg1bIPtdpi5dNBeHtPJOaQVWVMCcMPrhbMSzVpL6
 bo1ySepDAay6WQCPwTHdzLny1tAotlQpIO/7QkvQ70Ru6nFdFPrMcvAGzBF4NF7Vo8xdM2WlFye
 ysO69wrRjv+uL8sh5Bh14xMPVb+BtbJCoFFBA8qVjZeBSbqmN/v6bBfk8XFb89JpHfj7JPErdic
 KkOuXAit74NzdERCxsfiPyBuex39lmG6BtDsJ/p0PBjJAHBet1joNp22cdYWXt/GKHPWJsbENvR
 A1fJRoBf6bzXjw8i6Vg==
X-Proofpoint-GUID: 6pHlM2QUzTImg6AphrmtOB07JThkCU7d
X-Proofpoint-ORIG-GUID: 6pHlM2QUzTImg6AphrmtOB07JThkCU7d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-21_05,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 spamscore=0 impostorscore=0 suspectscore=0
 phishscore=0 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603210129
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260321_082901_058330_060CBCB4 
X-CRM114-Status: GOOD (  15.80  )
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
index 41a170083..f842eb770 100644
--- a/libnvme/src/libnvme.ld
+++ b/libnvme/src/libnvme.ld
@@ -176,6 +176,7 @@ LIBNVME_3 {
 		nvme_subsystem_first_ns;
 		nvme_get_subsystem;
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
index dcd9079dd..84852c8b0 100644
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
index 2984d0ff7..18aabe044 100644
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



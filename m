Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63CCCF8FA8E
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Apr 2026 14:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DwxCtJI/y8kbFbOeNLzPy9wzB+SScljPO3qB3J/mq8E=; b=QhqANAc443aQW+sEglqW+IAg7H
	McCqVnCV18+NdEfe+NCgTG3e5piFr0DKOqpEfo9Nu2F0Pu6yLrF+HT1WWeKJ3f9EWfBH8CDDC25IC
	Qe4iwW5xNsOa0ycxDhdt1ZG88dlz7JGa7HaeX4O9clnfEGlg9bed46Xx/hCI+0wzy02BUrVISjVOC
	eh+oivIN0keSjmwIWXWg006ApLJmTr2sGttRIJOvHhSj76pj5sUM5lVo3ARVZbHt3m7AjfeVf65+J
	t/zSi0W0vcmKaqC3hije4QTQDjmFZzYyJMzwq0LOosBcViPMbb62sBUu+Q+9R9ICSSbV9DKm7POY1
	uCy1969Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFCRL-00000008ljh-1emx;
	Tue, 21 Apr 2026 14:51:03 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFCRI-00000008lgw-1XZG
	for linux-nvme@lists.infradead.org;
	Tue, 21 Apr 2026 14:51:01 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63LCP3fs2039443;
	Tue, 21 Apr 2026 14:50:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=DwxCtJI/y8kbFbOeN
	LzPy9wzB+SScljPO3qB3J/mq8E=; b=O3e86Zjboyg4i1+Y2Lkxdg7O3EhLhASPP
	7/PJB+uIVjvULYwD9kYw3cWJcZC9ymRjxwYmTQGZ3LOUJ7By2olvyvl6fwOvtTke
	jfuKKudUSO4lMCX1PyH2JVFDp+vNiY5b30KjmM3JY3nQvAArp+MA8G6AhqWA6KsB
	BA8Ee7p3zhsTnyp3ccU1/7BAF6N8mxyErEiFster7I52JdyCLtG54qRgCGi6X1Yi
	u8ZiChnENQoxR6F6allK40q1UaU0jgku5sWUsfgnEVHLxJvEObO1WbdIiaKYtBYX
	vGl1D4cFhA+9aHvjl97RPuvm2CBR4RJQOGBU/lgIeeRjbEChcqZ5Q==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dm2h9m2tj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Apr 2026 14:50:57 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63LEoG0m001887;
	Tue, 21 Apr 2026 14:50:56 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dmpyy0v6e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Apr 2026 14:50:56 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63LEor0W51970498
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Apr 2026 14:50:53 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E399120043;
	Tue, 21 Apr 2026 14:50:52 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 693BE2004D;
	Tue, 21 Apr 2026 14:50:50 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.39.30.130])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 21 Apr 2026 14:50:50 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, hare@suse.com, kbusch@kernel.org, hch@lst.de,
        gjoyce@linux.ibm.com, wenxiong@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCHv3 3/9] libnvme: annotate libnvme_subsystem::iopolicy with !accessors:none
Date: Tue, 21 Apr 2026 20:20:24 +0530
Message-ID: <20260421145038.3458987-4-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260421145038.3458987-1-nilay@linux.ibm.com>
References: <20260421145038.3458987-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 4GZW7ZynBm3N1kjBw-M6KLkOjJUmMh2v
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDE0OCBTYWx0ZWRfX41i0U38ecaRf
 v3cACygYbQtp/KD2vgu3eKFh/N4uThwwIdWmuqW7b+Pr3/OE1O5rMzlf9Yvq4qfwsZEZWvi/iDy
 CrRJgB0S/an5mHgL0fzMbhylFupnn5Ya17oKnXqnkSJOvkQG0IQVOT0CN7I2c/50y7maU5n4VrK
 1eeKW6dKrXz0eX2chjvr53n+a0wAInjHGCJ5OidMpgarSHhwsWs4gQoytPhvGPe8ldjzEoroCb+
 XWyeBQTDJI/w2o/ggjoUfo/OudHXrAqSHr64Gr6XLsqFGedPvalIDStFLeqa8nc2al4B/73kGBe
 Yj75Q4ti+bn/lyaRW5VNzqVncCV+aRn5OtprX7oL13Rw4AQwAkxXPSdOmZBqfemXpz+jdQBLmiH
 LRhNZHnpF4NlHukTKe0NDapsCOu41zMidN8HXSZ5UiVu5kQa+0WsKv08h2pjBNs4EdOV2z28c7B
 0qyZBYCHmQ8zXyAQp/A==
X-Authority-Analysis: v=2.4 cv=XLYAjwhE c=1 sm=1 tr=0 ts=69e78ed1 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=iUlHePCZVvjaN09WHd8A:9
X-Proofpoint-GUID: 4GZW7ZynBm3N1kjBw-M6KLkOjJUmMh2v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 impostorscore=0 spamscore=0 adultscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604210148
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260421_075100_763067_F82D80E4 
X-CRM114-Status: GOOD (  17.04  )
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
attribute values. However, for libnvme_subsystem::iopolicy, a real-time
(non-cached) value is required.

This is particularly useful for tools such as nvme-top, which rely on
up-to-date information for displaying a real-time dashboard.

Annotate libnvme_subsystem::iopolicy with "!accessors:none" to disable the
auto-generated accessor, and provide a custom implementation of
libnvme_subsystem_get_iopolicy() that returns the current value.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 libnvme/src/accessors.ld     |  2 --
 libnvme/src/libnvme.ld       |  1 +
 libnvme/src/nvme/accessors.c | 14 --------------
 libnvme/src/nvme/accessors.h | 17 -----------------
 libnvme/src/nvme/private.h   |  2 +-
 libnvme/src/nvme/tree.c      | 15 +++++++++++++++
 libnvme/src/nvme/tree.h      |  8 ++++++++
 7 files changed, 25 insertions(+), 34 deletions(-)

diff --git a/libnvme/src/accessors.ld b/libnvme/src/accessors.ld
index 4ccba1a6e..e23d9d7a2 100644
--- a/libnvme/src/accessors.ld
+++ b/libnvme/src/accessors.ld
@@ -174,7 +174,6 @@ LIBNVME_ACCESSORS_3 {
 		libnvme_path_set_sysfs_dir;
 		libnvme_subsystem_get_application;
 		libnvme_subsystem_get_firmware;
-		libnvme_subsystem_get_iopolicy;
 		libnvme_subsystem_get_model;
 		libnvme_subsystem_get_name;
 		libnvme_subsystem_get_serial;
@@ -182,5 +181,4 @@ LIBNVME_ACCESSORS_3 {
 		libnvme_subsystem_get_subsystype;
 		libnvme_subsystem_get_sysfs_dir;
 		libnvme_subsystem_set_application;
-		libnvme_subsystem_set_iopolicy;
 };
diff --git a/libnvme/src/libnvme.ld b/libnvme/src/libnvme.ld
index 9b26de5cd..1ad02034a 100644
--- a/libnvme/src/libnvme.ld
+++ b/libnvme/src/libnvme.ld
@@ -177,6 +177,7 @@ LIBNVME_3 {
 		libnvme_subsystem_first_ctrl;
 		libnvme_subsystem_first_ns;
 		libnvme_subsystem_get_host;
+		libnvme_subsystem_get_iopolicy;
 		libnvme_subsystem_lookup_namespace;
 		libnvme_subsystem_next_ctrl;
 		libnvme_subsystem_next_ns;
diff --git a/libnvme/src/nvme/accessors.c b/libnvme/src/nvme/accessors.c
index bcae8d578..a2729014d 100644
--- a/libnvme/src/nvme/accessors.c
+++ b/libnvme/src/nvme/accessors.c
@@ -661,20 +661,6 @@ __public const char *libnvme_subsystem_get_application(
 	return p->application;
 }
 
-__public void libnvme_subsystem_set_iopolicy(
-		struct libnvme_subsystem *p,
-		const char *iopolicy)
-{
-	free(p->iopolicy);
-	p->iopolicy = iopolicy ? strdup(iopolicy) : NULL;
-}
-
-__public const char *libnvme_subsystem_get_iopolicy(
-		const struct libnvme_subsystem *p)
-{
-	return p->iopolicy;
-}
-
 /****************************************************************************
  * Accessors for: struct libnvme_host
  ****************************************************************************/
diff --git a/libnvme/src/nvme/accessors.h b/libnvme/src/nvme/accessors.h
index 7ade91794..33484c723 100644
--- a/libnvme/src/nvme/accessors.h
+++ b/libnvme/src/nvme/accessors.h
@@ -901,23 +901,6 @@ void libnvme_subsystem_set_application(
 const char *libnvme_subsystem_get_application(
 		const struct libnvme_subsystem *p);
 
-/**
- * libnvme_subsystem_set_iopolicy() - Set iopolicy.
- * @p: The &struct libnvme_subsystem instance to update.
- * @iopolicy: New string; a copy is stored. Pass NULL to clear.
- */
-void libnvme_subsystem_set_iopolicy(
-		struct libnvme_subsystem *p,
-		const char *iopolicy);
-
-/**
- * libnvme_subsystem_get_iopolicy() - Get iopolicy.
- * @p: The &struct libnvme_subsystem instance to query.
- *
- * Return: The value of the iopolicy field, or NULL if not set.
- */
-const char *libnvme_subsystem_get_iopolicy(const struct libnvme_subsystem *p);
-
 /****************************************************************************
  * Accessors for: struct libnvme_host
  ****************************************************************************/
diff --git a/libnvme/src/nvme/private.h b/libnvme/src/nvme/private.h
index 2471495ad..037cde7e2 100644
--- a/libnvme/src/nvme/private.h
+++ b/libnvme/src/nvme/private.h
@@ -269,7 +269,7 @@ struct libnvme_subsystem { // !generate-accessors
 	char *firmware; // !accessors:readonly
 	char *subsystype; // !accessors:readonly
 	char *application;
-	char *iopolicy;
+	char *iopolicy; //!accessors:none
 };
 
 struct libnvme_host { // !generate-accessors
diff --git a/libnvme/src/nvme/tree.c b/libnvme/src/nvme/tree.c
index c2c959871..9e8c18da4 100644
--- a/libnvme/src/nvme/tree.c
+++ b/libnvme/src/nvme/tree.c
@@ -464,6 +464,21 @@ __public libnvme_host_t libnvme_subsystem_get_host(libnvme_subsystem_t s)
 	return s->h;
 }
 
+__public char *libnvme_subsystem_get_iopolicy(libnvme_subsystem_t s)
+{
+	__cleanup_free char *iopolicy = NULL;
+
+	iopolicy = libnvme_get_subsys_attr(s, "iopolicy");
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
 __public libnvme_ns_t libnvme_subsystem_first_ns(libnvme_subsystem_t s)
 {
 	return list_top(&s->namespaces, struct libnvme_ns, entry);
diff --git a/libnvme/src/nvme/tree.h b/libnvme/src/nvme/tree.h
index 7cd90c620..93140fcb0 100644
--- a/libnvme/src/nvme/tree.h
+++ b/libnvme/src/nvme/tree.h
@@ -214,6 +214,14 @@ void libnvme_free_subsystem(struct libnvme_subsystem *s);
  */
 libnvme_host_t libnvme_subsystem_get_host(libnvme_subsystem_t s);
 
+/**
+ * libnvme_subsystem_get_iopolicy() - Get subsystem iopolicy name
+ * @s:	subsystem
+ *
+ * Return: The iopolicy configured in subsystem @s
+ */
+char *libnvme_subsystem_get_iopolicy(libnvme_subsystem_t s);
+
 /**
  * libnvme_ctrl_first_ns() - Start namespace iterator
  * @c:	Controller instance
-- 
2.53.0



Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A88BCF8FA8C
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Apr 2026 14:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pdC7xKGTP57Ojm++N7XaQeJ9IGXv5wyyJYhxkPyE8d0=; b=cpkU690h11n2rDYeGaPgOZvqSr
	mFeD0QIbyrSYh9MWM+4kwU2l/qMKL4K/SWuo3OXt76da6IjmgrCPebtqgUuPXV5mRsVg+PipabhO2
	m8Cyjy0djH9AMDil8oJKP0lIJJN0aXVn+kiAJkIqpuv11hib5+oXoVLdJyNzE6tYTwfOusPvTxzXF
	z24opBViMpvVjvyJqjMXD7JJVf0aR5xvlDFfYMi+25X8p+2qpnSCbRpd5F55dj/y2GCl+J6/KyJsB
	0q0pVNtCbxkZXZjCvVij6nRhR9wPorfKsfV+/JwHZwWiyzEj5IdU0oeEgLoM+KZqWhNj4SJbmhz7P
	bsNdeEVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFCRW-00000008lsy-3ANf;
	Tue, 21 Apr 2026 14:51:14 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFCRR-00000008lnh-1MCl
	for linux-nvme@lists.infradead.org;
	Tue, 21 Apr 2026 14:51:10 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63LCSpxT1651159;
	Tue, 21 Apr 2026 14:51:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=pdC7xKGTP57Ojm++N
	7XaQeJ9IGXv5wyyJYhxkPyE8d0=; b=TW3i6z4sKv1NFrfDWkJKF8m5xz5WK9HAP
	f7NgL5fAGywFc3e7SqWbU0/LECRdNUHDeUiEbRI6ZTA6GwygAqeun04xtUlrDAtm
	Y8tHLsV1hEhn/s1QhCUjCP/6PPJ8WvsV5/2JKqQ0EqeZwJm1WOOl0jj/X0enhBZ9
	7ECGyTjyUkepf1vETMUt69s4AvdqNw191tG/t3KMdHZupHICoFEExcRBcOulutCV
	BwbXWNz2gzB4+4jO9GNg7QoA5d6crlNTAtko86pVlPjtv4NlG1b5XiH3kk+G5fOJ
	owp3KieGzSv4AO0PUDy/ex5zJQAPeL75XtEBkulr4r8W91B1SFhQQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dm2k54txk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Apr 2026 14:51:06 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63LEoF3U012926;
	Tue, 21 Apr 2026 14:51:05 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dmpgg8y0g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Apr 2026 14:51:05 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63LEp2Sd30802584
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Apr 2026 14:51:02 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 208EF2004E;
	Tue, 21 Apr 2026 14:51:02 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 565912004D;
	Tue, 21 Apr 2026 14:50:59 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.39.30.130])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 21 Apr 2026 14:50:59 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, hare@suse.com, kbusch@kernel.org, hch@lst.de,
        gjoyce@linux.ibm.com, wenxiong@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCHv3 6/9] libnvme: add support for per-path diagnostic counters
Date: Tue, 21 Apr 2026 20:20:27 +0530
Message-ID: <20260421145038.3458987-7-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260421145038.3458987-1-nilay@linux.ibm.com>
References: <20260421145038.3458987-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Cbw0X7v_ZGb7hwExRi8FPjFQwcy5a8NN
X-Proofpoint-ORIG-GUID: Cbw0X7v_ZGb7hwExRi8FPjFQwcy5a8NN
X-Authority-Analysis: v=2.4 cv=VP7tWdPX c=1 sm=1 tr=0 ts=69e78eda cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=NKCsueVTR_sD4m4h2I0A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDE0OCBTYWx0ZWRfX+RiIVHnnM6C2
 stXrSR0QTowCdON9B9sfJxdW8vSFFTEvp7NfO6/T0A6f64pcaiEqNo3LYJzxb0g+VWVTFTY4uJt
 TI3vOdhoRv6QCWs436Ex7yWB+QI6VtgcgNgdjZazpLmc+agNorgAX8JIptZv/K00bHlZhhk971K
 wHTNXfT4EJYflQ6FjH20re0LyFrQCMfjRhjCxfshUVynsnoHwLikZgJld9lThnXJKaiqwGSlhN3
 PsjmjGFYj3MxCZ6QARtQ/ofwNnaGG6mnxCkaxWglVrsNZhVwzIfjFKnGUAr8skpGpXn4u3M+gg+
 18kgQSxHzbk1myGgM7NzeSwxbOw74RaeBh7haqll/fbv4GDVQma5iSVJpOBl3JlFrwUIDr3Aapg
 8fp+jzkhpXQhVx1bsOfmyEziU1WLt915S6bN9Xw8SmWfZCpO8kZDwOlV9C5iOJSe1ytcCYmTg/Q
 OWHZOe5PO8TYKHsfG9A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604210148
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260421_075109_457043_B6503235 
X-CRM114-Status: GOOD (  16.77  )
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

Add support for retrieving per-path diagnostic counters such as
command_retry_count, command_error_count, and multipath_failover_count.
These counters improve visibility into NVMe native multipath behavior
and can be useful for tools such as nvme-top to display real-time
statistics.

Unlike other sysfs attributes, these counters can change dynamically.
Annotate them with "!accessors:none" and provide custom implementations
to always retrieve the latest (non-cached) values.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 libnvme/src/libnvme.ld     |  3 +++
 libnvme/src/nvme/private.h |  5 ++++-
 libnvme/src/nvme/tree.c    | 33 +++++++++++++++++++++++++++++++++
 libnvme/src/nvme/tree.h    | 27 +++++++++++++++++++++++++++
 4 files changed, 67 insertions(+), 1 deletion(-)

diff --git a/libnvme/src/libnvme.ld b/libnvme/src/libnvme.ld
index ce85c960e..85ff00e55 100644
--- a/libnvme/src/libnvme.ld
+++ b/libnvme/src/libnvme.ld
@@ -163,6 +163,9 @@ LIBNVME_3 {
 		libnvme_path_get_write_sectors;
 		libnvme_path_reset_stat;
 		libnvme_path_update_stat;
+		libnvme_path_get_command_retry_count;
+		libnvme_path_get_command_error_count;
+		libnvme_path_get_multipath_failover_count;
 		libnvme_random_uuid;
 		libnvme_read_config;
 		libnvme_read_hostid;
diff --git a/libnvme/src/nvme/private.h b/libnvme/src/nvme/private.h
index 08b35e002..7f01f8a7d 100644
--- a/libnvme/src/nvme/private.h
+++ b/libnvme/src/nvme/private.h
@@ -209,7 +209,10 @@ struct libnvme_path { // !generate-accessors
 	char *ana_state; //!accessors:none
 	char *numa_nodes; //!accessors:none
 	int grpid;
-	int queue_depth; // !accessors:none
+	int queue_depth; //!accessors:none
+	long multipath_failover_count; //!accessors:none
+	long command_retry_count; //!accessors:none
+	long command_error_count; //!accessors:none
 };
 
 struct libnvme_ns_head {
diff --git a/libnvme/src/nvme/tree.c b/libnvme/src/nvme/tree.c
index ca716bde7..a603c2fde 100644
--- a/libnvme/src/nvme/tree.c
+++ b/libnvme/src/nvme/tree.c
@@ -885,6 +885,39 @@ __public char *libnvme_path_get_numa_nodes(libnvme_path_t p)
 	return p->numa_nodes;
 }
 
+__public long libnvme_path_get_multipath_failover_count(libnvme_path_t p)
+{
+	__cleanup_free char *failover_count = NULL;
+
+	failover_count = libnvme_get_path_attr(p, "multipath_failover_count");
+	if (failover_count)
+		sscanf(failover_count, "%ld", &p->multipath_failover_count);
+
+	return p->multipath_failover_count;
+}
+
+__public long libnvme_path_get_command_retry_count(libnvme_path_t p)
+{
+	__cleanup_free char *retry_count = NULL;
+
+	retry_count = libnvme_get_path_attr(p, "command_retry_count");
+	if (retry_count)
+		sscanf(retry_count, "%ld", &p->command_retry_count);
+
+	return p->command_retry_count;
+}
+
+__public long libnvme_path_get_command_error_count(libnvme_path_t p)
+{
+	__cleanup_free char *error_count = NULL;
+
+	error_count = libnvme_get_path_attr(p, "command_error_count");
+	if (error_count)
+		sscanf(error_count, "%ld", &p->command_error_count);
+
+	return p->command_error_count;
+}
+
 static libnvme_stat_t libnvme_path_get_stat(libnvme_path_t p, unsigned int idx)
 {
 	if (idx > 1)
diff --git a/libnvme/src/nvme/tree.h b/libnvme/src/nvme/tree.h
index a166d9df6..2eb4cea0e 100644
--- a/libnvme/src/nvme/tree.h
+++ b/libnvme/src/nvme/tree.h
@@ -685,6 +685,33 @@ char *libnvme_path_get_ana_state(libnvme_path_t p);
  */
 char *libnvme_path_get_numa_nodes(libnvme_path_t p);
 
+/**
+ * libnvme_path_get_multipath_failover_count() - Get multipath failover count
+ * @p: &libnvme_path_t object
+ *
+ * Return: Number of times I/Os have to be failed over to another active path
+ * from path @p maybe due to any transient error observed on path @p
+ */
+long libnvme_path_get_multipath_failover_count(libnvme_path_t p);
+
+/**
+ * libnvme_path_get_command_retry_count() - Get command retry count
+ * @p: &libnvme_path_t object
+ *
+ * Return: Number of times any command issued to the namespace represented by
+ * path @p has to be retried
+ */
+long libnvme_path_get_command_retry_count(libnvme_path_t p);
+
+/**
+ * libnvme_path_get_command_error_count() - Get command error count
+ * @p: &libnvme_path_t object
+ *
+ * Return: Number of times command issued to the namespace represented by path
+ * @p returns non-zero status or error
+ */
+long libnvme_path_get_command_error_count(libnvme_path_t p);
+
 /**
  * libnvme_path_get_ctrl() - Parent controller of an libnvme_path_t object
  * @p:	&libnvme_path_t object
-- 
2.53.0



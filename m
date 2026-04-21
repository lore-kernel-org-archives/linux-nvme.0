Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DA12F8FA8C
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Apr 2026 14:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+Pboa7GUKSFInP2Ll2f1ZfBgU2aW8jiB8RWm+3uFKy8=; b=C81zOq2zFLnuO5rqTzQKRlnbJi
	WhmtxsmX+lIpLfF6b8SjePwZ1l7L/5A/FjVfHnpru8geYI04hEG3JPhbRuyidzUQCT7p8r602FMdq
	OdvIxaAIzorj17qxirR5VxXolKuvzFqXz4MqSA2DRNUbfxf5yQ3Sg3v2xyhzdSeOd5RmxvdgQyyCk
	oB8kM2tClKjRREy1Ku/qCdLzrKSPaOuRYqlV44c0dzApXTk++Qg49s0k0Erv36tpJylo0t1HHX9QR
	ji/FDTO7POiXs++d2yHHRdY96KqgWPedoq9HLt4eEUgPv4fWHLnXWDYmUjjomIg3zibwqsvhlwkS7
	F6JgXkIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFCRa-00000008ly6-0bC6;
	Tue, 21 Apr 2026 14:51:18 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFCRX-00000008ltt-1LQ4
	for linux-nvme@lists.infradead.org;
	Tue, 21 Apr 2026 14:51:16 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63LCFIT91650615;
	Tue, 21 Apr 2026 14:51:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=+Pboa7GUKSFInP2Ll
	2f1ZfBgU2aW8jiB8RWm+3uFKy8=; b=YWTQB1xFN+GmZEBv/w0pAqNUAEgHwRAOM
	9wZBkF9Pu0TB16Al+36dFmK7Hth5uNWU0YneOc3Q7BQM0HdnUZr2kgngYvZKP4VR
	NNz0rpIhWmIjFArzrwcctxmocCe3Txq63omXLlrahP0gb5Ky30qJ6+AqRvJnVmkd
	NGeFgcLU5AoWWy8jTcgJwqXOxc/7+jLA1XFaRokR3jfLZ1xAOEqmWhBoXc1DJLeR
	LpPgQQi6Olf+kTxGK3kOO4qQfSEauUa8i6zwv5Bxv3TilKPTyXnPNSzpW9wRUYeA
	zskpMdDYZRCny8BQs2Xg/quzk1QzZa5kdsaQ76PXQz3C3urkqSKow==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dm2k54ty9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Apr 2026 14:51:13 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63LEoH9O022715;
	Tue, 21 Apr 2026 14:51:12 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dmn9k139k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Apr 2026 14:51:12 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63LEp8wT55116074
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Apr 2026 14:51:08 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7535A20043;
	Tue, 21 Apr 2026 14:51:08 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BCE3F20040;
	Tue, 21 Apr 2026 14:51:05 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.39.30.130])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 21 Apr 2026 14:51:05 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, hare@suse.com, kbusch@kernel.org, hch@lst.de,
        gjoyce@linux.ibm.com, wenxiong@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCHv3 8/9] libnvme: add support for nshead diagnostic counters
Date: Tue, 21 Apr 2026 20:20:29 +0530
Message-ID: <20260421145038.3458987-9-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260421145038.3458987-1-nilay@linux.ibm.com>
References: <20260421145038.3458987-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: LgxF_a6-Tu8wUGs6NRWuw_z0F7JOUM8p
X-Proofpoint-ORIG-GUID: LgxF_a6-Tu8wUGs6NRWuw_z0F7JOUM8p
X-Authority-Analysis: v=2.4 cv=VP7tWdPX c=1 sm=1 tr=0 ts=69e78ee1 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=sN_bMOALZ3zET2-YLtMA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDE0OCBTYWx0ZWRfX68xt8EnjEBx4
 L8hJBGFV2qRtXURWFVJUkTwVC+CnKs824dMESLQGCKb6EiM8gPSmLw1WhcVDXgh9AfvRIxdJy+T
 C1qCWmeZqzFkbPB09AMOjsA7WOeI0Tpq/4PUNocQ6gHapnjUb5CBxwW68lWpuZnOoT/QwbN93Wc
 nOurDr0Ar5IbXBMDq0jXxU89dXdYpF2+QcDgYEJnIWC1MFUj/utJAJop9195Lf5FFXBp54p5AVG
 /1Y86BZyPrYiuAc2iUPRrYHRMUe35VOvqKG+uarlE9Kcse0Y0w0IspnQ6S4C0JFBq1HNEtJsb7S
 BSHzd2FU6+Ry7sm15wtlyYOKsDDMr6lR5lXU2fOaZhqXS8p/IDTRYlV8WECb7esUuuye4d2TC/P
 d04SOJxpBAup9CNjVrwag6ZarYvVtnEL0/oY3GuFrlgIgUcCeVq0+VKiBtYXiX3xS3QjfEs2Skw
 RGAgTB+lwr6KwWXpGVQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604210148
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260421_075115_368695_CCE1C7F1 
X-CRM114-Status: GOOD (  13.75  )
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

Add support for retrieving nshead diagnostic counters such as requeue_
no_usable_path_count and fail_no_available_path_count.

The requeue_no_usable_path_count counter represents the number of I/Os
requeued to the namespace head when no usable path is available (for
example, due to transient link issues). The fail_no_available_path_count
counter represents the number of I/Os failed when no I/O path is
available (for example, when all paths are removed).

These counters improve visibility into NVMe native multipath behavior
and can be useful for tools such as nvme-top to display real-time
statistics.

Unlike other sysfs attributes, these counters can change dynamically.
Annotate them with "!accessors:none" and provide custom implementations
to always retrieve the latest (non-cached) values.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 libnvme/src/libnvme.ld     |  2 ++
 libnvme/src/nvme/private.h |  2 ++
 libnvme/src/nvme/tree.c    | 22 ++++++++++++++++++++++
 libnvme/src/nvme/tree.h    | 17 +++++++++++++++++
 4 files changed, 43 insertions(+)

diff --git a/libnvme/src/libnvme.ld b/libnvme/src/libnvme.ld
index 2fafd333c..c9841e45c 100644
--- a/libnvme/src/libnvme.ld
+++ b/libnvme/src/libnvme.ld
@@ -142,6 +142,8 @@ LIBNVME_3 {
 		libnvme_ns_get_io_ticks;
 		libnvme_ns_get_command_retry_count;
 		libnvme_ns_get_command_error_count;
+		libnvme_ns_get_requeue_no_usable_path_count;
+		libnvme_ns_get_fail_no_available_path_count;
 		libnvme_ns_identify;
 		libnvme_ns_read;
 		libnvme_ns_verify;
diff --git a/libnvme/src/nvme/private.h b/libnvme/src/nvme/private.h
index ec0e1e848..170445927 100644
--- a/libnvme/src/nvme/private.h
+++ b/libnvme/src/nvme/private.h
@@ -254,6 +254,8 @@ struct libnvme_ns { // !generate-accessors
 
 	long command_retry_count; //!accessors:none
 	long command_error_count; //!accessors:none
+	long requeue_no_usable_path_count; //!accessors:none
+	long fail_no_available_path_count; //!accessors:none
 };
 
 struct libnvme_ctrl { // !generate-accessors
diff --git a/libnvme/src/nvme/tree.c b/libnvme/src/nvme/tree.c
index f1a1311b7..085d79558 100644
--- a/libnvme/src/nvme/tree.c
+++ b/libnvme/src/nvme/tree.c
@@ -2633,6 +2633,28 @@ __public long libnvme_ns_get_command_error_count(libnvme_ns_t n)
 	return n->command_error_count;
 }
 
+__public long libnvme_ns_get_requeue_no_usable_path_count(libnvme_ns_t n)
+{
+	__cleanup_free char *requeue_count = NULL;
+
+	requeue_count = libnvme_get_ns_attr(n, "requeue_no_usable_path_count");
+	if (requeue_count)
+		sscanf(requeue_count, "%ld", &n->requeue_no_usable_path_count);
+
+	return n->requeue_no_usable_path_count;
+}
+
+__public long libnvme_ns_get_fail_no_available_path_count(libnvme_ns_t n)
+{
+	__cleanup_free char *fail_count = NULL;
+
+	fail_count = libnvme_get_ns_attr(n, "fail_no_available_path_count");
+	if (fail_count)
+		sscanf(fail_count, "%ld", &n->fail_no_available_path_count);
+
+	return n->fail_no_available_path_count;
+}
+
 __public int libnvme_ns_identify(libnvme_ns_t n, struct nvme_id_ns *ns)
 {
 	struct libnvme_transport_handle *hdl;
diff --git a/libnvme/src/nvme/tree.h b/libnvme/src/nvme/tree.h
index 63cd20838..6bfc8cf98 100644
--- a/libnvme/src/nvme/tree.h
+++ b/libnvme/src/nvme/tree.h
@@ -527,6 +527,23 @@ long libnvme_ns_get_command_retry_count(libnvme_ns_t n);
  */
 long libnvme_ns_get_command_error_count(libnvme_ns_t n);
 
+/**
+ * libnvme_ns_get_requeue_no_usable_path_count() - Get num of I/O requeue count
+ * @n: &libnvme_ns_t object
+ *
+ * Return: Number of I/Os which are re-queued due to the unavalibility of
+ * any usable path (maybe path is currently experiencing transinet link failure)
+ */
+long libnvme_ns_get_requeue_no_usable_path_count(libnvme_ns_t n);
+
+/**
+ * libnvme_ns_get_fail_no_available_path_count() - Get num of I/Os forced to fail
+ * @n: &libnvme_ns_t object
+ *
+ * Return: Number of I/Os which are forced to fail due to no path available
+ */
+long libnvme_ns_get_fail_no_available_path_count(libnvme_ns_t n);
+
 /**
  * libnvme_ns_get_generic_name() - Returns name of generic namespace chardev.
  * @n:	Namespace instance
-- 
2.53.0



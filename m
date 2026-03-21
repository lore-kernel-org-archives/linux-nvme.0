Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB4391094486
	for <linux-nvme@archiver.kernel.org>; Sat, 21 Mar 2026 15:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tXMUC3LA3L/FsZ7ycI4/QYxxuBtY50aCRyLo+4cXLSc=; b=Nsr3PrnfuB4XTVv8TSlW/ZkNJQ
	FWnWrgvcnCqyOhwly7Pf96scRcQk1H3fRN2AuNICuZcN4sV1qWck6+u2wcBxi4YFnRAafu4RCTRvd
	/Zq1upCxfB+tAhiPXHynM7qysWMDkSwvGvSK1yN6vy/1EsUUTApiaM+bOYGjESqHt7tTEAab7kScd
	SBiR0xCFMmCO9G6OnVG9A1/9113gcGilPFx26+CO5Lo+1jDZjDD1kWEX2PKvZN56WYft5ZIn4ibfz
	lIgj5zYKSDOIrCrqFd6+J5SvYdj7MpYg0BMKxcy5h7tclIIHvVkMmqJ194juBMCVHe79Xd0tchOEo
	FtnC5uRg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3yGH-0000000EaOO-26zP;
	Sat, 21 Mar 2026 15:29:13 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3yGF-0000000EaHP-3VXg
	for linux-nvme@lists.infradead.org;
	Sat, 21 Mar 2026 15:29:12 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62LBvT7j1146261;
	Sat, 21 Mar 2026 15:29:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=tXMUC3LA3L/FsZ7yc
	I4/QYxxuBtY50aCRyLo+4cXLSc=; b=fBlZpG7yPGOH4O89NLx9/xBVerlJvYunA
	KbU/dfXhrV+SYKH6iq3wcZCVxUORR1Yiw9jE8EvHXxnyyesgp+OE6t+D3BnYYgWx
	0ohH9Xsegp946YvthaUfY0MWkLGVpunduA0PbZmPG4vhfkp2OSlnny8UbXIVd9Xv
	E41VYDCCJi5F4jFXL4x42kqO4jvTXdIYPzpCLea68LcEZJPQzDVwgsUWOOXTcYMo
	mNriTRUL2vo9jeO9TGqzD/m1tGrQkSdcuGHJ5hoHcq72q+jlteAP9J19tU9ZgQTl
	vOVT/Z3g+PDNF60MDEGluY/CtMx3Db7hpU2McrvW8X8Ebw3Umevjg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kxq18rp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 21 Mar 2026 15:29:08 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62LA5FKG016254;
	Sat, 21 Mar 2026 15:29:08 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cwm7kbspg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 21 Mar 2026 15:29:07 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62LFT4A047448504
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 21 Mar 2026 15:29:04 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 161142004B;
	Sat, 21 Mar 2026 15:29:04 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8E08120040;
	Sat, 21 Mar 2026 15:29:01 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.124.222.150])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 21 Mar 2026 15:29:01 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, hare@suse.com, kbusch@kernel.org, hch@lst.de,
        gjoyce@ibm.com, wenxiong@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH 8/9] libnvme: add support for nshead diagnostic counters
Date: Sat, 21 Mar 2026 20:58:07 +0530
Message-ID: <20260321152823.3197870-9-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260321152823.3197870-1-nilay@linux.ibm.com>
References: <20260321152823.3197870-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: qyqTjhNYHs70yyROOBApOlrTIQAKr_ig
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIxMDEyOSBTYWx0ZWRfXyzPvR2V/yUpY
 hzcnWjaJCL8kAXz0cMx9Jj+iqgRXxVcZk7UrA7qBIdEoApD2Lqa7Ol6uWWrVNWS3uBCk/b1Xnd/
 OMM+n6pTwt0I1d3yrYiW00pAqmrLa4ZZ6FIbEScmq3oKW4ih70O4pKp8PXESoRVtthk39CrgQhl
 ul1aFXNXIrXSvbNoyWi41fQMNzwnU5TptT0Xw3SOY7Kq2BnxvniBfHe9ShsAYPb24jl/r7CCxwc
 BZgodcGUMBfiyV7/tHVbfgER2J/jwlnRWzfslZXielncmG+va9ZzlWeYvbHJi2E1Icm4iupTBW9
 88LdeJrYVR8gsj++FPyV9ydQukGbtmeH+H2dcMDE9dtrjyccQhFTBbHj6tSupGD0hAaqRU7SWgc
 wh+9FevgVFTinvPXXDyN60c7zHq//sxOtiKtvHSIxjPO2oOpvNlU8T3JcYtyavGBp6q6TA6S2qP
 j4gaG9TNlsUN/ihcBYg==
X-Authority-Analysis: v=2.4 cv=bLEb4f+Z c=1 sm=1 tr=0 ts=69beb944 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=uStK5EqEp8Qg-lq-ovIA:9
X-Proofpoint-GUID: qyqTjhNYHs70yyROOBApOlrTIQAKr_ig
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-21_05,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603210129
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260321_082911_877255_05F0B042 
X-CRM114-Status: GOOD (  13.48  )
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
index a767eca5e..e3d2ca1bb 100644
--- a/libnvme/src/libnvme.ld
+++ b/libnvme/src/libnvme.ld
@@ -143,6 +143,8 @@ LIBNVME_3 {
 		nvme_ns_get_io_ticks;
 		nvme_ns_get_command_retry_count;
 		nvme_ns_get_command_error_count;
+		nvme_ns_get_requeue_no_usable_path_count;
+		nvme_ns_get_fail_no_available_path_count;
 		nvme_ns_identify;
 		nvme_ns_read;
 		nvme_rescan_ns;
diff --git a/libnvme/src/nvme/private.h b/libnvme/src/nvme/private.h
index f58b13bd7..f7f8b4f76 100644
--- a/libnvme/src/nvme/private.h
+++ b/libnvme/src/nvme/private.h
@@ -209,6 +209,8 @@ struct nvme_ns { /*!generate-accessors*/
 
 	long command_retry_count; //!accessors:none
 	long command_error_count; //!accessors:none
+	long requeue_no_usable_path_count; //!accessors:none
+	long fail_no_available_path_count; //!accessors:none
 };
 
 struct nvme_ctrl { /*!generate-accessors*/
diff --git a/libnvme/src/nvme/tree.c b/libnvme/src/nvme/tree.c
index f82ea4c02..0f0761005 100644
--- a/libnvme/src/nvme/tree.c
+++ b/libnvme/src/nvme/tree.c
@@ -2570,6 +2570,28 @@ __public long nvme_ns_get_command_error_count(nvme_ns_t n)
 	return n->command_error_count;
 }
 
+__public long nvme_ns_get_requeue_no_usable_path_count(nvme_ns_t n)
+{
+	_cleanup_free_ char *requeue_count = NULL;
+
+	requeue_count = nvme_get_ns_attr(n, "requeue_no_usable_path_count");
+	if (requeue_count)
+		sscanf(requeue_count, "%ld", &n->requeue_no_usable_path_count);
+
+	return n->requeue_no_usable_path_count;
+}
+
+__public long nvme_ns_get_fail_no_available_path_count(nvme_ns_t n)
+{
+	_cleanup_free_ char *fail_count = NULL;
+
+	fail_count = nvme_get_ns_attr(n, "fail_no_available_path_count");
+	if (fail_count)
+		sscanf(fail_count, "%ld", &n->fail_no_available_path_count);
+
+	return n->fail_no_available_path_count;
+}
+
 __public int nvme_ns_identify(nvme_ns_t n, struct nvme_id_ns *ns)
 {
 	struct nvme_transport_handle *hdl;
diff --git a/libnvme/src/nvme/tree.h b/libnvme/src/nvme/tree.h
index 6cff114bb..a34a31601 100644
--- a/libnvme/src/nvme/tree.h
+++ b/libnvme/src/nvme/tree.h
@@ -546,6 +546,23 @@ long nvme_ns_get_command_retry_count(nvme_ns_t n);
  */
 long nvme_ns_get_command_error_count(nvme_ns_t n);
 
+/**
+ * nvme_ns_get_requeue_no_usable_path_count() - Get num of I/O requeue count
+ * @n: &nvme_ns_t object
+ *
+ * Return: Number of I/Os which are re-queued due to the unavalibility of
+ * any usable path (maybe path is currently experiencing transinet link failure)
+ */
+long nvme_ns_get_requeue_no_usable_path_count(nvme_ns_t n);
+
+/**
+ * nvme_ns_get_fail_no_available_path_count() - Get num of I/Os forced to fail
+ * @n: &nvme_ns_t object
+ *
+ * Return: Number of I/Os which are forced to fail due to no path available
+ */
+long nvme_ns_get_fail_no_available_path_count(nvme_ns_t n);
+
 /**
  * nvme_ns_get_generic_name() - Returns name of generic namespace chardev.
  * @n:	Namespace instance
-- 
2.53.0



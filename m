Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FDE4E88D97
	for <linux-nvme@archiver.kernel.org>; Sat,  4 Apr 2026 10:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FahiNG1w5oJ71Z9uQ+Fzn5UJ8hMX8X2Bwwl2Q7H11yM=; b=wfIZn2IBEszbPRQRzrHfPbo43u
	BVYzsouKuQzPJ5Y7L8bu658gt9bZCZn6wVkrMeATW/33Bnif0d0f+H/khYIWQKy16KihlGlQvkgRV
	uUJ7UUuPSFueMpoWwd6TUDPcKxaIl2Ou0/2jlZUiH0Pdhg8LrJ07hn2CxM36ga+Dss2077hJd70k6
	DytlpAvCEyvzH30/MLk1I/s550kQs7eeCgZzzRAUvNNQvbLUXaZWjxRg98VvY3BqdLTjs0icajIl3
	sXIm7far/V/SL8QIPFOQ6vIygBF3xgO5N4hGK/7kJhJw1UqgDgQU4qubVz2LBMYpSitecCIvThDSw
	inqOAGzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8y2l-00000003MaF-36lh;
	Sat, 04 Apr 2026 10:15:55 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8y2j-00000003MYe-2qXD
	for linux-nvme@lists.infradead.org;
	Sat, 04 Apr 2026 10:15:54 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6344de0L3164469;
	Sat, 4 Apr 2026 10:15:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=FahiNG1w5oJ71Z9uQ
	+Fzn5UJ8hMX8X2Bwwl2Q7H11yM=; b=n5XjusqK200IQf2LddlpnNbN2O48cfpTD
	d1wB1i2AnQwqGXnPn+xckaRL0kS1Nlb2+K3Jgw0PXn/Ezlb0xrGu/Z10Hq1je8g3
	e49DWyxlQq4pr7QCIHQFHpENPK0KpR+0L/Qyq2DYzZO22IiuOzC9fWE2qplASheY
	HA/ju7GOsX3qBlynPd2dcv98jgERA34mxVctvnL7dNlb3ArS1fGcRlopf6dTkeY2
	oevXXPnq8i0pvwkhHGtyCvJjWGdXrIAyH11xc7blAYYF6r6EdzdRJ6qpzXChqY6d
	NFIu1huGrgP+pjcUz1BJR0CI/9m51GXUzQgGL5ca3KVMH+WPLBGiQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4das2brt7k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 04 Apr 2026 10:15:50 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6342ikWP008698;
	Sat, 4 Apr 2026 10:15:49 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d6v120vsw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 04 Apr 2026 10:15:49 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 634AFj1d61735224
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 4 Apr 2026 10:15:45 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5965C2004F;
	Sat,  4 Apr 2026 10:15:45 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EB40C2004E;
	Sat,  4 Apr 2026 10:15:40 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.124.211.35])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat,  4 Apr 2026 10:15:40 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, hare@suse.com, kbusch@kernel.org, hch@lst.de,
        gjoyce@linux.ibm.com, wenxiong@linux.ibm.com
Subject: [PATCHv2 8/9] libnvme: add support for nshead diagnostic counters
Date: Sat,  4 Apr 2026 15:44:58 +0530
Message-ID: <20260404101504.44539-9-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260404101504.44539-1-nilay@linux.ibm.com>
References: <20260404101504.44539-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: kfgJYJ2tQpI5JxNWCog2l5Fa2316TigW
X-Proofpoint-GUID: kfgJYJ2tQpI5JxNWCog2l5Fa2316TigW
X-Authority-Analysis: v=2.4 cv=U9qfzOru c=1 sm=1 tr=0 ts=69d0e4d6 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=uStK5EqEp8Qg-lq-ovIA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA0MDA4OCBTYWx0ZWRfX4uPdgB/xcwBO
 ROW44sDIGnoLonmuC86quSw59C5YIG43OHruMexzCcTQztPkK+H8SVfCIs1P4+VTQnqQjY4hVN0
 l38DG/1KvPRiDjh11cdBnyaYI4n3qj/aIv7MSziwfTx7JD8mnnvm1ZeQS4ZvdK6bB0QyXjhSbY/
 a8GegUcWrCAC++UxYtzhduGoYtvEx8Otw07zKQBlAo1jJvJP3m/RYj6LwWxjexxPLywSqAFufpB
 nRgwXxbIR9YY2Yjb50a+NSp+EkpEy3el+v1VV9xKABfZ8YtBXL2V+oE49hkGLNOwH48h8Wks0N/
 VEIKfK+SUJLnNPAAqf9+rhgtrqwwQwOTUAG7kJuYvHX9KV5sLD53qf9JxJ9Dfw8djwZft6OySuZ
 hV9D/jBVkKwjGsT7aWuScvcXAzJ7EKvgm1qOfUB4ASJR0cRsZoX2EjsjUS3Z2mbHdiFw3atA9ul
 M9C0GN0VnpNwW7taPWA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-03_07,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 clxscore=1015 adultscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604040088
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260404_031553_833985_8A4DC395 
X-CRM114-Status: GOOD (  13.56  )
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
index aa24adf59..13bd3995c 100644
--- a/libnvme/src/libnvme.ld
+++ b/libnvme/src/libnvme.ld
@@ -144,6 +144,8 @@ LIBNVME_3 {
 		nvme_ns_get_io_ticks;
 		nvme_ns_get_command_retry_count;
 		nvme_ns_get_command_error_count;
+		nvme_ns_get_requeue_no_usable_path_count;
+		nvme_ns_get_fail_no_available_path_count;
 		nvme_ns_identify;
 		nvme_ns_read;
 		nvme_ns_verify;
diff --git a/libnvme/src/nvme/private.h b/libnvme/src/nvme/private.h
index b2ba1948a..ae0b8507e 100644
--- a/libnvme/src/nvme/private.h
+++ b/libnvme/src/nvme/private.h
@@ -214,6 +214,8 @@ struct nvme_ns { /*!generate-accessors*/
 
 	long command_retry_count; //!accessors:none
 	long command_error_count; //!accessors:none
+	long requeue_no_usable_path_count; //!accessors:none
+	long fail_no_available_path_count; //!accessors:none
 };
 
 struct nvme_ctrl { /*!generate-accessors*/
diff --git a/libnvme/src/nvme/tree.c b/libnvme/src/nvme/tree.c
index a8069072d..77aed7eee 100644
--- a/libnvme/src/nvme/tree.c
+++ b/libnvme/src/nvme/tree.c
@@ -2614,6 +2614,28 @@ __public long nvme_ns_get_command_error_count(nvme_ns_t n)
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
index ea5dc09a5..e6a26efb1 100644
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



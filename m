Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91AC3C369D1
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Apr 2025 12:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KqFdPecrayYnecCFk666EkqKL4jMfv3H7u66r4u4XhM=; b=LjxN+c7TCSkTEg7EMeu/YRzx+N
	vnnANhEVr0TsRgg9yyVE3zGZ6TUS6kn9WcVsvtvmBdntgVpRXiKMTbRLdvWgDYFOVg9Kv7ls2U5aT
	Y2IYvHQe1v89jJw5SgGekM1EO+uLzB/iOMguxhjG/Cz30dwuMvUihvcpBb0xP9kItKaLsE3gQ7MYW
	ZavfLPZiQqAJgKXP+grNjUpagQBemgidYv2kPUVAfgObDyIyroGDixKZOMXNdyCpvIRbcCCusgJE+
	loj130o+cNLOFuHQLlrjhWB3I8VtvsIdxDAS3eAkkO98xrn/Q7W/k6F18ZTcyEcndKR9jqnrMB0Do
	P4PizmAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8Hz6-0000000H5iO-45f3;
	Fri, 25 Apr 2025 12:16:48 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8GNO-0000000GkvS-23VI
	for linux-nvme@lists.infradead.org;
	Fri, 25 Apr 2025 10:33:47 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53P9VXrk000354;
	Fri, 25 Apr 2025 10:33:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=KqFdPecrayYnecCFk
	666EkqKL4jMfv3H7u66r4u4XhM=; b=tGWW8ftq+CzJSYlx5+7KTwJuddGMAupZB
	kwBqDknIQqXtIKnypeZ/QiUiTqRiNmCjS0Vdcwvzrv/osvR9KvfTPe0dVKC6PTgb
	fQNxelsRn3batChOPGbY4fzfP4eQ+Zlq5RZuizIQ6ekKgYMyQO5D/ZsTlG4rRdDU
	F0oP+CjvPKp+3vcAdAx+ekmT6C0xo3jlpqZf7E3nKbgAvYv5LiS0NdaaIQfwM9cb
	0nwxyScDCaGdmH37KahsEmWYXPVi7QNYXhlLYKfhdp28r9qR9PH/GNRJaI1NwSro
	ZxuSG5oMXCHxqqjkFWCA5DzEyXhsL6VPhLa/vkxxIesk9/RRsYcbg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 467vvktuwg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Apr 2025 10:33:35 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53P8sCuU028426;
	Fri, 25 Apr 2025 10:33:34 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 466jfvvrma-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Apr 2025 10:33:34 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53PAXW7T53477826
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 10:33:32 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 30E932004D;
	Fri, 25 Apr 2025 10:33:32 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E14F120040;
	Fri, 25 Apr 2025 10:33:28 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.43.102.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 25 Apr 2025 10:33:28 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Cc: hch@lst.de, kbusch@kernel.org, hare@suse.de, sagi@grimberg.me,
        jmeneghi@redhat.com, axboe@kernel.dk, martin.petersen@oracle.com,
        gjoyce@ibm.com
Subject: [RFC PATCHv2 2/3] nvme: introduce multipath_head_always module param
Date: Fri, 25 Apr 2025 16:03:09 +0530
Message-ID: <20250425103319.1185884-3-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250425103319.1185884-1-nilay@linux.ibm.com>
References: <20250425103319.1185884-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDA3MyBTYWx0ZWRfX5ydzEWveadDG k1TH/QRkfkNhjiVKGoywqjIMq4KlTYe3BGa5wbFePcl3Knh3bbdN//GcDJvDHfRru+pq4fBwhOY 2LixOwNg83b+4AH8YmZfPJ733Tk3scIde1+vEQmQ/A+scAWWNeGGLR4GlNgBQlLpTNAg+LbbmYt
 TZaykZAaF+R7JKNM4yo6JaZb63NiUWKsKVrB+RTzs5TK/IiidQsxJpH6xlpJQJohCVQvCfoKvic 1qeulzh0Ungs0CJcnzC83V/QbXg2ib9CqClUsjNdnBE8xdR6AU7nczYi8t6mE7+dvyx90/U4H3J XfkjG9ngVUWUunBiXUmQsZbgF821aktyjuawOCqg614YKqNHRLfk0fMADj+D34YtVZNx3IfAxg5
 6xzyHEFjU3gRuoJxWiRxgCu0xKjBhkbgcCsNVDgkYL6fqvk/zQcSlUIli/lcjVTn9Sr+w2o5
X-Proofpoint-ORIG-GUID: AIf-9ocvIS9kpQUrjQpYBBfAWaZGa-g6
X-Proofpoint-GUID: AIf-9ocvIS9kpQUrjQpYBBfAWaZGa-g6
X-Authority-Analysis: v=2.4 cv=HoF2G1TS c=1 sm=1 tr=0 ts=680b64ff cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=XR8D0OoHHMoA:10 a=VnNF1IyMAAAA:8 a=YAlafS6B6ijdj31roQ0A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_02,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 clxscore=1015 impostorscore=0 adultscore=0
 bulkscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 mlxscore=0
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504250073
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250425_033346_532685_8376B8E9 
X-CRM114-Status: GOOD (  19.25  )
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

Currently, a multipath head disk node is not created for single-ported
NVMe adapters or private namespaces. However, creating a head node in
these cases can help transparently handle transient PCIe link failures.
Without a head node, features like delayed removal cannot be leveraged,
making it difficult to tolerate such link failures. To address this,
this commit introduces nvme_core module parameter multipath_head_always.

When this param is set to true, it forces the creation of a multipath
head node regardless NVMe disk or namespace type. So this option allows
the use of delayed removal of head node functionality even for single-
ported NVMe disks and private namespaces and thus helps transparently
handling transient PCIe link failures.

By default multipath_head_always is set to false, thus preserving the
existing behavior. Setting it to true enables improved fault tolerance
in PCIe setups. Moreover, please note that enabling this option would
also implicitly enable nvme_core.multipath.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/multipath.c | 70 +++++++++++++++++++++++++++++++----
 1 file changed, 63 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 68318337c275..1acdbbddfe01 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -10,10 +10,59 @@
 #include "nvme.h"
 
 bool multipath = true;
-module_param(multipath, bool, 0444);
+bool multipath_head_always;	/* default is flase */
+
+static int multipath_param_set(const char *val, const struct kernel_param *kp)
+{
+	int ret;
+
+	ret = param_set_bool(val, kp);
+	if (ret)
+		return ret;
+
+	if (multipath_head_always && !*(bool *)kp->arg) {
+		pr_err("Can't disable multipath when multipath_head_always is configured.\n");
+		*(bool *)kp->arg = true;
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static const struct kernel_param_ops multipath_param_ops = {
+	.set = multipath_param_set,
+	.get = param_get_bool,
+};
+
+module_param_cb(multipath, &multipath_param_ops, &multipath, 0444);
 MODULE_PARM_DESC(multipath,
 	"turn on native support for multiple controllers per subsystem");
 
+static int multipath_head_always_set(const char *val,
+		const struct kernel_param *kp)
+{
+	int ret;
+
+	ret = param_set_bool(val, kp);
+	if (ret < 0)
+		return ret;
+
+	if (*(bool *)kp->arg)
+		multipath = true;
+
+	return 0;
+}
+
+static const struct kernel_param_ops multipath_head_always_param_ops = {
+	.set = multipath_head_always_set,
+	.get = param_get_bool,
+};
+
+module_param_cb(multipath_head_always, &multipath_head_always_param_ops,
+		&multipath_head_always, 0444);
+MODULE_PARM_DESC(multipath_head_always,
+	"create multipath head node always; note that this also implicitly enables native multipath support");
+
 static const char *nvme_iopolicy_names[] = {
 	[NVME_IOPOLICY_NUMA]	= "numa",
 	[NVME_IOPOLICY_RR]	= "round-robin",
@@ -681,13 +730,20 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
 	head->delayed_removal_secs = 0;
 
 	/*
-	 * Add a multipath node if the subsystems supports multiple controllers.
-	 * We also do this for private namespaces as the namespace sharing flag
-	 * could change after a rescan.
+	 * If multipath_head_always is configured then we add a multipath head
+	 * disk node irrespective of disk is single/multi ported or namespace is
+	 * shared/private.
 	 */
-	if (!(ctrl->subsys->cmic & NVME_CTRL_CMIC_MULTI_CTRL) ||
-	    !nvme_is_unique_nsid(ctrl, head) || !multipath)
-		return 0;
+	if (!multipath_head_always) {
+		/*
+		 * Add a multipath node if the subsystems supports multiple
+		 * controllers. We also do this for private namespaces as the
+		 * namespace sharing flag could change after a rescan.
+		 */
+		if (!(ctrl->subsys->cmic & NVME_CTRL_CMIC_MULTI_CTRL) ||
+		    !nvme_is_unique_nsid(ctrl, head) || !multipath)
+			return 0;
+	}
 
 	blk_set_stacking_limits(&lim);
 	lim.dma_alignment = 3;
-- 
2.49.0



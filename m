Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3F07C3ABAC
	for <linux-nvme@archiver.kernel.org>; Sun,  4 May 2025 17:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oK1I/9FVp0RyEdcyAGr/TjP0s+/01muDjFmsBqAv+NQ=; b=LnVO1p6aTFEYZ57vYw54LInNHd
	zPlETFJB0aLyLf9JW4ppwRnNKvt+2qYeu7EBxVlp+XmKf8iF0Fc5Z1yoh5isWVn4Nntr5wl+ITlcE
	hPEDz6F7VbyFp22kHFhuwZnLTDxIr8B52UUAxQkzuMKfwAMeIMez/D5XWY0haTSp0Bu6bxWhtNu71
	L6WfxN1kS9WPy64OfzM87Ful+8pZXRiBCbz46ZagkSoKXjUv/e9KDhGnV7x/BbFoQl+8B7JpbSewt
	qO+RCwhcl7XlQxw5Z5A7eVg6n561OxErS7ShLftBbw8F0TKco11FQHNPdrptz6efAHal81kmJQGix
	pFGzpUPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uBdX7-00000005m72-3hPz;
	Sun, 04 May 2025 17:53:45 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uBdUn-00000005lnL-34Vn
	for linux-nvme@lists.infradead.org;
	Sun, 04 May 2025 17:51:22 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 544CofY8029492;
	Sun, 4 May 2025 17:51:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=oK1I/9FVp0RyEdcyA
	Gr/TjP0s+/01muDjFmsBqAv+NQ=; b=fTTgiK9fs2OvXtJTeAO3A1Nf4vKEIIHkn
	C5+VntFQqUx4q6Fz5FwrJfALJTF6OQ35pyNccxcJVTrWpb+kk27rmGWwJOnyjOZZ
	XbLN1KRLDtviJNLdkgzemlkrgFvbk8vyEk4zzhvBbn+r0mWKuBQQqw9CB1qjcrs9
	kczZLn2Mr2Wb9Vx+1b7p/Ci01gk40b6aGiBImNsRmi3Y7afstDZgWCSgsPQqgI+y
	ZFS8cdbX/9osHAcJygl7Ze+qlAPFxW5iCyqf5UPlfsmAuewt84TXa/s/lacy7+QF
	UquvdT+VRuXdVK9dtZtcfGVGTNgEgSnpkPCLeC2DF+VqgC9FCM0Gw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46e6pr8w3e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 04 May 2025 17:51:09 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 544HI8Qx002734;
	Sun, 4 May 2025 17:51:09 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46dxfnjqa8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 04 May 2025 17:51:09 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 544Hp7LT50528562
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 4 May 2025 17:51:07 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3F7E520040;
	Sun,  4 May 2025 17:51:07 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 439EA2004B;
	Sun,  4 May 2025 17:51:03 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.67.80.251])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun,  4 May 2025 17:51:02 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, hare@suse.de,
        jmeneghi@redhat.com, axboe@kernel.dk, martin.petersen@oracle.com,
        gjoyce@ibm.com
Subject: [RFC PATCHv3 2/3] nvme: introduce multipath_always_on module param
Date: Sun,  4 May 2025 23:20:40 +0530
Message-ID: <20250504175051.2208162-3-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250504175051.2208162-1-nilay@linux.ibm.com>
References: <20250504175051.2208162-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Cu2/cm4D c=1 sm=1 tr=0 ts=6817a90e cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=YAlafS6B6ijdj31roQ0A:9
X-Proofpoint-GUID: BcLXmiB96Tb58DdidymfcjTZzaGTc3eH
X-Proofpoint-ORIG-GUID: BcLXmiB96Tb58DdidymfcjTZzaGTc3eH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA0MDE2NiBTYWx0ZWRfX1gtfaah/J7JA VXunyW0XtxdbQzH0I5k5ibvK/5suQyW+wU2ALmM29OD6uwBIFU5Af2yERNzD9huW4F5dNwjrBZo oNJbEf5JKBq8JWjlU4MElALmfwoN1g8DyqDirRuVX2WZlUya1Vm+6jI2KiUDmvuO9W94u+ATiuX
 2newFdbyBu2qDUNYq0KP/IxF/fuPEGbnShTwkz4XxxE1U0JisODhF5i+hH9Y/OVee9Frv+OgDA3 CSVzR592w/R97+9qcXtZkB5qZxV11HmZ8q1hwWMullISzfY+4YjmdlfjQRqDnL8qUkEPYL7ujcw BOnLcBjAMT7kIWuKZVn6Eoy3DCTAz1ocX9u+0ln93eWHPjoYTaIQtaE4B0WvfKxjkPHcPMWzZeC
 z54ulHI99T1n/ZNMbemq73/hAAElXTOzeqODJ4s6s6vmxHWWDk7VJw98i7C0SBH1TEit6j6z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-04_07,2025-04-30_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 spamscore=0 mlxlogscore=999 malwarescore=0 phishscore=0 adultscore=0
 impostorscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505040166
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250504_105121_892394_3781CB84 
X-CRM114-Status: GOOD (  19.65  )
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
this commit introduces nvme_core module parameter multipath_always_on.

When this param is set to true, it forces the creation of a multipath
head node regardless NVMe disk or namespace type. So this option allows
the use of delayed removal of head node functionality even for single-
ported NVMe disks and private namespaces and thus helps transparently
handling transient PCIe link failures.

By default multipath_always_on is set to false, thus preserving the
existing behavior. Setting it to true enables improved fault tolerance
in PCIe setups. Moreover, please note that enabling this option would
also implicitly enable nvme_core.multipath.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/multipath.c | 72 +++++++++++++++++++++++++++++++----
 1 file changed, 65 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index f3f981c9f3ec..bc115b79eb13 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -10,10 +10,61 @@
 #include "nvme.h"
 
 bool multipath = true;
-module_param(multipath, bool, 0444);
+bool multipath_always_on;	/* default is flase */
+
+static int multipath_param_set(const char *val, const struct kernel_param *kp)
+{
+	int ret;
+	bool *arg = kp->arg;
+
+	ret = param_set_bool(val, kp);
+	if (ret)
+		return ret;
+
+	if (multipath_always_on && !*arg) {
+		pr_err("Can't disable multipath when multipath_always_on is configured.\n");
+		*arg = true;
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
 
+static int multipath_always_on_set(const char *val,
+		const struct kernel_param *kp)
+{
+	int ret;
+	bool *arg = kp->arg;
+
+	ret = param_set_bool(val, kp);
+	if (ret < 0)
+		return ret;
+
+	if (*arg)
+		multipath = true;
+
+	return 0;
+}
+
+static const struct kernel_param_ops multipath_always_on_ops = {
+	.set = multipath_always_on_set,
+	.get = param_get_bool,
+};
+
+module_param_cb(multipath_always_on, &multipath_always_on_ops,
+		&multipath_always_on, 0444);
+MODULE_PARM_DESC(multipath_always_on,
+	"create multipath node always; note that this also implicitly enables native multipath support");
+
 static const char *nvme_iopolicy_names[] = {
 	[NVME_IOPOLICY_NUMA]	= "numa",
 	[NVME_IOPOLICY_RR]	= "round-robin",
@@ -681,13 +732,20 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
 	head->delayed_removal_secs = 0;
 
 	/*
-	 * Add a multipath node if the subsystems supports multiple controllers.
-	 * We also do this for private namespaces as the namespace sharing flag
-	 * could change after a rescan.
+	 * If multipath_always_on is configured then we add a multipath head
+	 * disk node irrespective of disk is single/multi ported or namespace
+	 * is shared/private.
 	 */
-	if (!(ctrl->subsys->cmic & NVME_CTRL_CMIC_MULTI_CTRL) ||
-	    !nvme_is_unique_nsid(ctrl, head) || !multipath)
-		return 0;
+	if (!multipath_always_on) {
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



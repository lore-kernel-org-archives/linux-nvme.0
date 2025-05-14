Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D555AC3ABD8
	for <linux-nvme@archiver.kernel.org>; Wed, 14 May 2025 13:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZIWmxgzKDQkfcTFRTN0dmgu1Sjju2adZXGc9FbyHLZE=; b=j4pD0RCR9OtaRAJOIR3suULsEU
	TU9sLsWvbex6W3Xxs49e84ta7T9QPdRMk8dwwClvjgjxGUa/E+LVtOo/+IGK4e+WwQZqeQaM6Fuxs
	LNC2NEbrWPlshxUJ0XwprndOjikXkPOiqgCda2/n2DgSdDCxq4NgOn8C+mXm0QxEMPP/MP0gChJGs
	DoPznKpFOHYcrmGI8ftgAfKky2klSMU3t2GafZkONrl5jexZPNX8f7GbXwWyLyIhmhmlYSkdtBCrQ
	FmvG8pTjN0bdBRNuwkob5Ge62GQfU/0stTdfqc0xotEPjPovy6K4sfxBLXTpr3BBiHzrXZM1bFyr+
	G1+R98Ew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFCZI-0000000FJfr-32vk;
	Wed, 14 May 2025 13:54:44 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFBm6-0000000F9hH-3IiQ
	for linux-nvme@bombadil.infradead.org;
	Wed, 14 May 2025 13:03:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=ZIWmxgzKDQkfcTFRTN0dmgu1Sjju2adZXGc9FbyHLZE=; b=jWF+W+NGPcMLVpfvFPRWFGYJpG
	CHXis9X9NMPXuT423tBhdr5S9QzlVV3Q56t74gJTqeiy1sLTV4/Vei97QL3w4yOLtnRz3faOETc6F
	SYcLilNy+56+JP8x2M3BEb6O64eDiWHV5Ry8DCVXfMlkeFlSDhrFQns7hchiE7SxD2H7HLPke+yh/
	tkeLgkSJYvmrjIy5+araTcX6z0OtMdptFl1lx6JxNY+/5DwK6f8b4nnDKpbYWE+cgfCIEeoZ9F6nG
	ZMFPGK50Z64eKqP8XfVe1NODireN6YKSYR3DY7eOFgXzEoSYJxWnDHZSNnaqN4s8vsU6sK0TA4EuL
	oLKwHkYg==;
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by desiato.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1uFBm3-0000000HAHM-2ZXV
	for linux-nvme@lists.infradead.org;
	Wed, 14 May 2025 13:03:53 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54E8pR0H029722;
	Wed, 14 May 2025 13:03:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ZIWmxgzKDQkfcTFRT
	N0dmgu1Sjju2adZXGc9FbyHLZE=; b=GO83av4K2d60zu6jNUhFY96y5IQRVbBLM
	8X2DOBIzrG+4yjBJfRCY6EPP0j44Ukj8g9pw0NftCzZyXrps1PEvv/w9V6eZ/2Bl
	F212dXV3qEbzhJT1wHuRNE5RJTUTBKu/13/qkkK/z9TkDwoU3Dqw5D9emCie2+/e
	ocTufOVxj0mONIV7RCa1t3qYxUoA56SziSofFbzlIPs0AlA5c0rgnHDIAfp2Zsv4
	DObfxLBu2FAbkPBot5FaZ/HhfdPBh+E2yLK5GjR0kJmJhQ/ycbu36YXyDSGCgCZQ
	0MAcq+MPguXayId0O+/aBva9Qo3Qn31Oy+woJiwggZJ4ghjJwmqng==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46mr1gh5uq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 May 2025 13:03:43 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54E9pVO3021424;
	Wed, 14 May 2025 13:03:41 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46mbfrm8tg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 May 2025 13:03:41 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54ED3dwp21627592
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 May 2025 13:03:39 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4786120043;
	Wed, 14 May 2025 13:03:39 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 460272004D;
	Wed, 14 May 2025 13:03:35 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.67.82.218])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 14 May 2025 13:03:34 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, hare@suse.de, kbusch@kernel.org, sagi@grimberg.me,
        jmeneghi@redhat.com, axboe@kernel.dk, martin.petersen@oracle.com,
        gjoyce@ibm.com
Subject: [RFC PATCHv5 2/3] nvme: introduce multipath_always_on module param
Date: Wed, 14 May 2025 18:33:16 +0530
Message-ID: <20250514130322.393656-3-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250514130322.393656-1-nilay@linux.ibm.com>
References: <20250514130322.393656-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: GASH8qr6nDQGwzuoDHTSF8o-YwHVd8_m
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDExMSBTYWx0ZWRfX/+y+8lGO2C0q 6aEj6BcIiS3giarCDWdpfHTmnQLtN5NslbGQ+GB+W6z7Jo+VuVdTXjY+VArS1meO+3bdRjueBwK vxgS32ddj6J/CQ/xFLc/CwHwUNRE4uD5Kf6cjbbzqLkn4wmFaq2WUO9S8wPToWtsim6e6Si2VQp
 7RMQTXlOt566DRSNSmcc79kzHSwJjANknJRB8nBRmnc830RdzLFAqSnhDx7RKT66RueLbGglQCM syE2WV/y2ftmZlHjFFGnrOAbVesmQvZZ/e0Xj1+0Eix+q1BuhiiVRMKkdRUH+hcjVY7shLU5wrF yoK+v72wtR06CGCSfcz9QgqtnUqd47vcAeA4YL4oDoJ0ahDJM/9TSk4HPFjQ4Wt5yy3vkVaoC2w
 vch5MwE7B1SPGQDABGTDHwhKBDZpZqtaYvZI/7+mrobeWshQ6+TiThD+B/vLiMa+WphI9hmN
X-Proofpoint-GUID: GASH8qr6nDQGwzuoDHTSF8o-YwHVd8_m
X-Authority-Analysis: v=2.4 cv=QOxoRhLL c=1 sm=1 tr=0 ts=682494af cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=UCEK6jFp2ah0_TK5WXUA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_04,2025-05-14_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 phishscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 clxscore=1015 mlxscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=999
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505140111
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250514_140352_129431_064E47AD 
X-CRM114-Status: GOOD (  22.21  )
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

Currently, a multipath head disk node is not created for single-
ported NVMe adapters or private namespaces with non-unique NSID.
However, creating a head node in these cases can help transparently
handle transient PCIe link failures. Without a head node, features
like delayed removal cannot be leveraged, making it difficult to
tolerate such link failures. To address this, this commit introduces
nvme_core module parameter multipath_always_on.

When multipath_always_on is set to true, it forces the creation of a
multipath head node regardless NVMe disk or namespace type. So this
option allows the use of delayed removal of head node functionality
even for single-ported NVMe disks and private namespaces with a unique
NSID and thus helps transparently handle transient PCIe link failures.

By default multipath_always_on is set to false, thus preserving the
existing behavior. Setting it to true enables improved fault tolerance
in PCIe setups. Moreover, please note that enabling this option would
also implicitly enable nvme_core.multipath.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/multipath.c | 72 ++++++++++++++++++++++++++++++++---
 1 file changed, 66 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 2db326d6114f..0453d272c638 100644
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
+	"create multipath node always except for private namespace with non-unique nsid; note that this also implicitly enables native multipath support");
+
 static const char *nvme_iopolicy_names[] = {
 	[NVME_IOPOLICY_NUMA]	= "numa",
 	[NVME_IOPOLICY_RR]	= "round-robin",
@@ -674,12 +725,21 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
 	head->delayed_removal_secs = 0;
 
 	/*
-	 * Add a multipath node if the subsystems supports multiple controllers.
-	 * We also do this for private namespaces as the namespace sharing flag
-	 * could change after a rescan.
+	 * If "multipath_always_on" is enabled, a multipath node is added
+	 * regardless of whether the disk is single/multi ported, and whether
+	 * the namespace is shared or private. If "multipath_always_on" is not
+	 * enabled, a multipath node is added only if the subsystem supports
+	 * multiple controllers and the "multipath" option is configured. In
+	 * either case, for private namespaces, we ensure that the NSID is
+	 * unique.
 	 */
-	if (!(ctrl->subsys->cmic & NVME_CTRL_CMIC_MULTI_CTRL) ||
-	    !nvme_is_unique_nsid(ctrl, head) || !multipath)
+	if (!multipath_always_on) {
+		if (!(ctrl->subsys->cmic & NVME_CTRL_CMIC_MULTI_CTRL) ||
+				!multipath)
+			return 0;
+	}
+
+	if (!nvme_is_unique_nsid(ctrl, head))
 		return 0;
 
 	blk_set_stacking_limits(&lim);
-- 
2.49.0



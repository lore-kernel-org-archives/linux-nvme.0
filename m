Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53D1CC3ABCC
	for <linux-nvme@archiver.kernel.org>; Fri,  9 May 2025 20:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3jFIwwOAnZdu0BAbIVNDfq6pYPJMscKto+0M7p9ryXE=; b=avse8M22AQ6RbsNHHIIIinsW5w
	kqDAtyKzKrKXUcEEqlKPb+chUgsW6mfaEA/i5CCMcmkzxdsVZ2kwMwWlnQqXhlQVJnrWPYo2lnvRL
	G/Gib2JEKvot42GLN4QXp5he1qIczjl6zLt6jEfqSa4VHAWpyOyFegLxTq2zu8/IFHIet1RIBVu7L
	vFuIwKHa1nR2MhPHnucmC8r+iShxlauVQawr2RolCzSFnLqOAJJuTZOVAyt0uPLM7uG13Z9nfsO+z
	1B/NPhpCIUmslcBrofiJh8AbFD62YsO197+DSC850Cy+/BHHyRvwmGbqNix1z7BEOrGZ1d9sBHGCv
	2nL5bykA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDUJf-00000004oWx-1QJ1;
	Fri, 09 May 2025 20:27:31 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDRu0-00000004UyD-1zUx
	for linux-nvme@bombadil.infradead.org;
	Fri, 09 May 2025 17:52:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=3jFIwwOAnZdu0BAbIVNDfq6pYPJMscKto+0M7p9ryXE=; b=YACe8zSkTL92XGdUPibXnV5Eu8
	reux07O2hhhHxbpYHUQ+XBQv+C0CiVK4Wi2G6JWkZD5KzRbFyH49QS9eCbvTogxxbylQ2KEogS4EH
	yYjotUBKg7GiDbnRpeMd9ahSHcVOgmRf6fGmeEXJgsbvPWzR30rjAgBk97w0+KR04BiOyqVE6fVHL
	GLv2H0vOVxdguf7hhTsO44n1+A611ULRt+XjZ1BeROfnxXJTSYrmWxDmzn4m2XdZaTqOsuRRUdyjZ
	v+F/AXOZLG/0ruB8yupYG8Ljpp5Pv2bRNY7bxzWQnJDXl+yoYv8ayqc98VYQWPYy+gOq2OurHrBd5
	yr9jXETw==;
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by desiato.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1uDRtq-0000000GK12-3yHj
	for linux-nvme@lists.infradead.org;
	Fri, 09 May 2025 17:52:48 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 549CH9O8017232;
	Fri, 9 May 2025 17:52:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=3jFIwwOAnZdu0BAbI
	VNDfq6pYPJMscKto+0M7p9ryXE=; b=agh52smDjZjEFBV3xSIaSyFaaI+bJehhK
	t/yKv+Zq/WERhcb6z5P67Pf4bSBmRS6XjGHgEuHUrYT2PPihqrKXG7cJ16Q3mrRU
	Qd0Acrhf1M9BVCFy9XTUNNcKiRcdn9NpN/JM/WbEdoxWY4qPCDqCTN0DY9Z8MjAU
	c2c+O5UMwaKcXgqLw5vQdKDHzDW1kS1hS0fnED7//5gX4HoN63lty15DEHGidp4I
	tqMVxuHVSGQcOGtSNcgxCpLnQgYwfJBrXgfw02FPfmNAGl1IRakt1DpuVuZNinuA
	W7B+6QGEx+t9RlBlS//Audj5cjiIkfTVlNB6Rw5a4NGxWdSntTYOg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46h46kwhk4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 May 2025 17:52:18 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 549FuH3u002729;
	Fri, 9 May 2025 17:52:17 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46dxfpcppu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 May 2025 17:52:17 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 549HqFca19399124
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 9 May 2025 17:52:15 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0A66E2013E;
	Fri,  9 May 2025 17:52:15 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EEBCB2013C;
	Fri,  9 May 2025 17:52:10 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.67.130.163])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  9 May 2025 17:52:10 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, hare@suse.de, kbusch@kernel.org, sagi@grimberg.me,
        jmeneghi@redhat.com, axboe@kernel.dk, martin.petersen@oracle.com,
        gjoyce@ibm.com
Subject: [RFC PATCHv4 2/3] nvme: introduce multipath_always_on module param
Date: Fri,  9 May 2025 23:21:49 +0530
Message-ID: <20250509175158.2753396-3-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250509175158.2753396-1-nilay@linux.ibm.com>
References: <20250509175158.2753396-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=LaM86ifi c=1 sm=1 tr=0 ts=681e40d2 cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=JwotYBOOUyP4u1sqkoYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA5MDE3NSBTYWx0ZWRfX8d9Nmvy2UmWl H+7U4se/ey0aHufBzDwzP/m/Dn49E0okDn3ZXuD1pUVw8Xi3dxomxswgTCh8JRflSbkmapxF3Mi lgQ/uHy4KVslC+Myf2OheoCBXv+2LhGCtyYDKP7FteKskvIVJRnA+0jMLYWDg/Js8/jDreSgOFh
 I3lqP5vxGGXSVdIuE+VG4XwXcOTVPBtY8nN8X6ZYWFQNBevn5k/LLKehfyCh+XUTyXAfXBqcqr9 Mmqu54cybXDl55LEjhBTHeWF7WnFl033FXhXBT9+YRDIddaHX//9iygX/PLoXowc8PopBdxtELM wdlVM6ZHqqsj9QDKLCLVlRXqaZNTHFzAwbtjwHXXRv9ltnOnMkDzi8j0+N0d8fXF5rvn4Oe87TS
 2C4ISuiSYV/n9oaGS60uFfG/kbjYFYiepTbeN1APOksq8LrcMAIP/NcCnIZ8EYCMEDS6P8U8
X-Proofpoint-ORIG-GUID: ZHO6NgAU-8wwrgydu1CaZbxP6LCg3gz4
X-Proofpoint-GUID: ZHO6NgAU-8wwrgydu1CaZbxP6LCg3gz4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-09_06,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505090175
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250509_185243_582672_58A23F68 
X-CRM114-Status: GOOD (  20.78  )
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

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/multipath.c | 72 +++++++++++++++++++++++++++++++----
 1 file changed, 65 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 2db326d6114f..e85c8e258a4e 100644
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
@@ -674,13 +725,20 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
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



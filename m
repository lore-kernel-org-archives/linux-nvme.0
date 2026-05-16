Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0829CCD4F49
	for <linux-nvme@archiver.kernel.org>; Sat, 16 May 2026 18:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TLDFpy8HPDevLqtIUtvvu4uNyZkn3Nsk7PhqEV4ZPqU=; b=ggJWSSS2amVZ36zSTMXNvqC+EM
	Zxo1u+4qHWFr4W9lkAvFcWRbACbH7mswSShKtuKIeq6+O8zWooY3dXthtDGIua2qru3MuB9LFON9V
	kkhFNtDyTP18AAFORwipqmxnHdf45fiRDzxWK7I9DvejbI2XvmGChJJfCDFF3QxVWrKMeWCi6mgAe
	ezcoOg+tmA57mHETHojL5WxoA9s/ftrhEBqiAyqG6ZvZF4KpwlvVLhQlUmK5Q/H/vfJpAdAAyOY4l
	ifs/lqnISckfX2gmHeBXW1QLDOMP9XnSXa5HFlpLrfsOVvHrQ/TQZsQZAmUK2Jg61nANtf8m1Q1FN
	xO9SsKEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOJtS-0000000BDlh-2G3q;
	Sat, 16 May 2026 18:37:46 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOJtL-0000000BDjc-48VM
	for linux-nvme@lists.infradead.org;
	Sat, 16 May 2026 18:37:41 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64G4570Q1249301;
	Sat, 16 May 2026 18:37:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=TLDFpy8HPDevLqtIU
	tvvu4uNyZkn3Nsk7PhqEV4ZPqU=; b=YvGDt6jM/4aMudKDvq0fkC2N5lZb5uj8/
	BP8BPlD4zlntrtRuQamGEdSdEDqW9jyDzWie+4GxMg5RQzQ8B4CywA/BWPm5QmMV
	UviNzJP7ZOpfbRWKR8pC0MdMQ9AooOCdBcpKcwfx7So/Auz6efdKrAcevUGqK9uv
	PuT4SS6gtP8WuA3bL6rtCGxjJB/ANZJrkgQ0BmQc1orzCA/7MnfrjaPq1EcZ87Rs
	Mj95OfQgo1rxInqzPjX8L22FVmKTdR8bYnMwqMxhu7AlN3meKeCFBsk6ueenu4am
	hC8e4J1TwXBFelvt3eG3eXtKeoPIEIjmIUUfKPdDgBJqqDYw8o+gg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h881ryf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 May 2026 18:37:34 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64GIOAPW024346;
	Sat, 16 May 2026 18:37:33 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e5kvd0sp8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 May 2026 18:37:33 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64GIbT1W16777586
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 16 May 2026 18:37:29 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 32A0D20043;
	Sat, 16 May 2026 18:37:29 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4E50520040;
	Sat, 16 May 2026 18:37:25 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.111.59.249])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 16 May 2026 18:37:25 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, hare@suse.com, kbusch@kernel.org, hch@lst.de,
        sagi@grimberg.me, axboe@kernel.dk, chaitanyak@nvidia.com,
        venkat88@linux.ibm.com, gjoyce@linux.ibm.com, wenxiong@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCHv4 1/8] nvme: add diag attribute group under sysfs
Date: Sun, 17 May 2026 00:06:48 +0530
Message-ID: <20260516183709.269937-2-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260516183709.269937-1-nilay@linux.ibm.com>
References: <20260516183709.269937-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3VheefKoUDgGmeN4OlIpkGl3aE6B42gU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE2MDE4NiBTYWx0ZWRfXyh4mtDSnMDYk
 c8cfOi/URwxsJcbnw9hFxiyad3jPps2t3o+n9Gq/sL2D6uKfqqTWsY2e5h0U3kZ5mijsJQ1nnoN
 sF+ga57BEXFUA++bpQtXfgpyANL4RnKYSBjeQhxTBGXsKHR7/aRmwZt08WL6LLBgJuAvXXth8c2
 dwzgWU8XYg6KPxFoqXysr+L6La5qo1L/vrmprgYkL1ECoHR65kxOF/CvARGj+qzUbYRSgdUA7xX
 cmgszXXkyEHXJYo7QmuzsVenj//FjWhAyA40s4mmqP+5ZzDgJjFulxbNCcpwC+J13QFLvp0iV3r
 +hy7Y4nU/sLW15yhIgxaGIqe4K+uk+U48rJnZVSmquuGoekaDClxuSU/V3IyqyUImQxporm5i8Y
 ANyc1EYu/Ur6F+PYerqWn4JgYB6zRF03fFvWvNp12Qx52zHrI9yrXOXuHS5CSw7Q3cD1VVbl7py
 u3HgPT5WTtWmj4JgwAA==
X-Proofpoint-GUID: 3VheefKoUDgGmeN4OlIpkGl3aE6B42gU
X-Authority-Analysis: v=2.4 cv=apyCzyZV c=1 sm=1 tr=0 ts=6a08b96e cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=8jxpeZBLhksey1iINlEA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-16_02,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605160186
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260516_113740_146519_90DF81CC 
X-CRM114-Status: GOOD (  12.12  )
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

Add a new diag attribute group under:
/sys/class/nvme/<ctrl>/
/sys/block/<nvme-path-dev>/
/sys/block/<ns-head-dev>/

This new sysfs attribute group will be used to organize NVMe diagnostic
and telemetry-related counters under it.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/nvme.h  |  1 +
 drivers/nvme/host/pci.c   |  1 +
 drivers/nvme/host/sysfs.c | 35 +++++++++++++++++++++++++++++++++++
 3 files changed, 37 insertions(+)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index ccd5e05dac98..c8225d594252 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -1012,6 +1012,7 @@ extern const struct attribute_group nvme_ns_mpath_attr_group;
 extern const struct pr_ops nvme_pr_ops;
 extern const struct block_device_operations nvme_ns_head_ops;
 extern const struct attribute_group nvme_dev_attrs_group;
+extern const struct attribute_group nvme_dev_diag_attrs_group;
 extern const struct attribute_group *nvme_subsys_attrs_groups[];
 extern const struct attribute_group *nvme_dev_attr_groups[];
 extern const struct block_device_operations nvme_bdev_ops;
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 9fd04cd7c5cb..3f7bdf0fa786 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2810,6 +2810,7 @@ static const struct attribute_group nvme_pci_dev_attrs_group = {
 static const struct attribute_group *nvme_pci_dev_attr_groups[] = {
 	&nvme_dev_attrs_group,
 	&nvme_pci_dev_attrs_group,
+	&nvme_dev_diag_attrs_group,
 	NULL,
 };
 
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index e59758616f27..cc569c8556f3 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -351,11 +351,28 @@ const struct attribute_group nvme_ns_mpath_attr_group = {
 };
 #endif
 
+static struct attribute *nvme_ns_diag_attrs[] = {
+	NULL,
+};
+
+static umode_t nvme_ns_diag_attrs_are_visible(struct kobject *kobj,
+		struct attribute *a, int n)
+{
+	return a->mode;
+}
+
+const struct attribute_group nvme_ns_diag_attr_group = {
+	.name		= "diag",
+	.attrs		= nvme_ns_diag_attrs,
+	.is_visible	= nvme_ns_diag_attrs_are_visible,
+};
+
 const struct attribute_group *nvme_ns_attr_groups[] = {
 	&nvme_ns_attr_group,
 #ifdef CONFIG_NVME_MULTIPATH
 	&nvme_ns_mpath_attr_group,
 #endif
+	&nvme_ns_diag_attr_group,
 	NULL,
 };
 
@@ -937,11 +954,29 @@ static const struct attribute_group nvme_tls_attrs_group = {
 };
 #endif
 
+static struct attribute *nvme_dev_diag_attrs[] = {
+	NULL,
+};
+
+static umode_t nvme_dev_diag_attrs_are_visible(struct kobject *kobj,
+		struct attribute *a, int n)
+{
+	return a->mode;
+}
+
+const struct attribute_group nvme_dev_diag_attrs_group = {
+	.name		= "diag",
+	.attrs		= nvme_dev_diag_attrs,
+	.is_visible	= nvme_dev_diag_attrs_are_visible,
+};
+EXPORT_SYMBOL_GPL(nvme_dev_diag_attrs_group);
+
 const struct attribute_group *nvme_dev_attr_groups[] = {
 	&nvme_dev_attrs_group,
 #ifdef CONFIG_NVME_TCP_TLS
 	&nvme_tls_attrs_group,
 #endif
+	&nvme_dev_diag_attrs_group,
 	NULL,
 };
 
-- 
2.53.0



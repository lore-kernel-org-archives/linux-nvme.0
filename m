Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9477DCD4851
	for <linux-nvme@archiver.kernel.org>; Sat, 16 May 2026 18:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cTGuAefByJQUpn31vFvCSNG/YLazt8v34z1KnTh0EGk=; b=0MmBxNkFT37Imsh53btiHNSIBk
	/zFLUV8UPVJvD1oVf6MMsN/UpGx97QNYXnOS9xtSjt8PO/pSBGJT/YIt4qZQvzWKqtuxTZjzbRlcS
	VBf4R2xnY2BctzMDhL1H/542qzykGSdegZL/KjtKEmylzniwEEIpEswvsMSFhXc3HBbP4Nd6oqvEf
	8NDCxPye3u4ykN39bI/toTwuDSL4IK3rKNAjDOm1/PfSqJhchWOpL/V8n0hFpNxn8GB8zebOfqmYH
	GwFmDsNBYb/RPey0urqLmTkax6DsMwrm0fBEastaLAfEH43EPXn0IDpgk7/Dgc6hcm3c1K+UszKQW
	i5yMNwdw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOJtb-0000000BDry-3y13;
	Sat, 16 May 2026 18:37:55 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOJtZ-0000000BDqD-22fM
	for linux-nvme@lists.infradead.org;
	Sat, 16 May 2026 18:37:54 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64G8gl6E454467;
	Sat, 16 May 2026 18:37:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=cTGuAefByJQUpn31v
	FvCSNG/YLazt8v34z1KnTh0EGk=; b=qS633DB+9wCVxW0OyighUTvHY1sr9Nsys
	c9TBM1U4xqjvvi2JGTnIQJm5bW+N8vONoAGd1SI/MFy1Kgw5N5QEHC98YJCiEnzM
	Vdai0poGCKbBfbsVcjRqXc7LYbYX8rl3r7hXZn7onb2kVZrHao0O0no3ZWOGEx/i
	1dcS2gWNBbEkCjaKJIwJFj/yI4GMgTfhOFcWIph9j3hwIcbBTEsMZomNkK/6plOy
	jjgf55555AA5t2aNW0GcCNN0txWt43YEewcsAuTxbLayK/afXyU2seWM4eM8ERqt
	R4abmy1alr1O3ytx5upjZ1+2HzXZa17ybtM+kcfM+FzUlfUyP3NuQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h74hvcs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 May 2026 18:37:38 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64GIOAdb024349;
	Sat, 16 May 2026 18:37:37 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e5kvd0spk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 May 2026 18:37:37 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64GIbXcY45023612
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 16 May 2026 18:37:33 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 767BB20043;
	Sat, 16 May 2026 18:37:33 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B392F20040;
	Sat, 16 May 2026 18:37:29 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.111.59.249])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 16 May 2026 18:37:29 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, hare@suse.com, kbusch@kernel.org, hch@lst.de,
        sagi@grimberg.me, axboe@kernel.dk, chaitanyak@nvidia.com,
        venkat88@linux.ibm.com, gjoyce@linux.ibm.com, wenxiong@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCHv4 2/8] nvme: export command retry count via sysfs
Date: Sun, 17 May 2026 00:06:49 +0530
Message-ID: <20260516183709.269937-3-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260516183709.269937-1-nilay@linux.ibm.com>
References: <20260516183709.269937-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=ffCdDUQF c=1 sm=1 tr=0 ts=6a08b973 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=93_06-CiGp8Lcqv6eA0A:9
X-Proofpoint-ORIG-GUID: YszqByOrFUk8fL72NfFlUCF9Uxr-hLYy
X-Proofpoint-GUID: YszqByOrFUk8fL72NfFlUCF9Uxr-hLYy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE2MDE4NiBTYWx0ZWRfX1q9rmxo8FTyj
 KFqr71SpxcNyvFS4bDel0y4foGKbW5i/FxzSm9F9JK1gK5hoSBtq2+vyHoWaxjgrNKZa4h5pf0S
 9WaeM4qE2MmmL5duclOymNxNDoUqbvVQcRslKSp7VOtcp4T4bx2rlVJCSvNVHU0ZfSMHao5ex9r
 0OqeDhl3tEcjwrf6Tt3DRlE2hsYLXWyDYWyPLYz6LVLSLig6uh3dScSign0tc2r1YH5KaXW1ZXW
 PVWyACdKiXuSjwozVX9mp1AQ1DzpXr2218cZzoUmBZzltYQ8kpf/1I4nNR+W4e2uqgu59YiFeMS
 gZ2wfJzRsFMuZw/JvrHiGfKqCw1tZViyLVogrTaF2PO2fMyokuBoMOA428m+JpXiqxpzNlbemFK
 27VfQ67f6iQqYA2SvAp1YN3XnpoNcCkAJnh5ND5cLkCBnZYYF5kztemXuxm5y2g6h1wBEeGNSFA
 2j1K75XfSnPBiKkOm8g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-16_02,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 suspectscore=0 adultscore=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605160186
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260516_113753_533912_5DB6A98D 
X-CRM114-Status: GOOD (  19.55  )
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

When Advanced Command Retry Enable (ACRE) is configured, a controller
may interrupt command execution and return a completion status
indicating command interrupted with the DNR bit cleared. In this case,
the driver retries the command based on the Command Retry Delay (CRD)
value provided in the completion status.

Currently, these command retries are handled entirely within the NVMe
driver and are not visible to userspace. As a result, there is no
observability into retry behavior, which can be a useful diagnostic
signal.

Expose a per-namespace sysfs attribute command_retries_count, under
diag attribute group to provide visibility into retry activity. This
information can help identify controller-side congestion under load
and enables comparison across paths in multipath setups (for example,
detecting cases where one path experiences significantly more retries
than another under identical workloads).

This exported metric is intended for diagnostics and monitoring tools
such as nvme-top, and does not change command retry behavior. A new
sysfs attribute named "command_retries_count" is added for this purpose.
This attribute is both readable as well as writable. So user could
reset this counter if needed.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/core.c  |  4 ++++
 drivers/nvme/host/nvme.h  |  1 +
 drivers/nvme/host/sysfs.c | 33 +++++++++++++++++++++++++++++++++
 3 files changed, 38 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index dc388e24caad..bacd5e45c322 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -323,6 +323,7 @@ static void nvme_retry_req(struct request *req)
 {
 	unsigned long delay = 0;
 	u16 crd;
+	struct nvme_ns *ns = req->q->queuedata;
 
 	/* The mask and shift result must be <= 3 */
 	crd = (nvme_req(req)->status & NVME_STATUS_CRD) >> 11;
@@ -330,6 +331,9 @@ static void nvme_retry_req(struct request *req)
 		delay = nvme_req(req)->ctrl->crdt[crd - 1] * 100;
 
 	nvme_req(req)->retries++;
+	if (ns)
+		atomic_long_inc(&ns->retries);
+
 	blk_mq_requeue_request(req, false);
 	blk_mq_delay_kick_requeue_list(req->q, delay);
 }
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index c8225d594252..7538153fa61c 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -590,6 +590,7 @@ struct nvme_ns {
 	enum nvme_ana_state ana_state;
 	u32 ana_grpid;
 #endif
+	atomic_long_t retries;
 	struct list_head siblings;
 	struct kref kref;
 	struct nvme_ns_head *head;
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index cc569c8556f3..46071e87079f 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -351,13 +351,46 @@ const struct attribute_group nvme_ns_mpath_attr_group = {
 };
 #endif
 
+static ssize_t command_retries_count_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct nvme_ns *ns = nvme_get_ns_from_dev(dev);
+
+	return sysfs_emit(buf, "%lu\n", atomic_long_read(&ns->retries));
+}
+
+static ssize_t command_retries_count_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	unsigned long retries;
+	int err;
+	struct nvme_ns *ns = nvme_get_ns_from_dev(dev);
+
+	err = kstrtoul(buf, 0, &retries);
+	if (err)
+		return -EINVAL;
+
+	atomic_long_set(&ns->retries, retries);
+
+	return count;
+}
+static DEVICE_ATTR_RW(command_retries_count);
+
 static struct attribute *nvme_ns_diag_attrs[] = {
+	&dev_attr_command_retries_count.attr,
 	NULL,
 };
 
 static umode_t nvme_ns_diag_attrs_are_visible(struct kobject *kobj,
 		struct attribute *a, int n)
 {
+	struct device *dev = container_of(kobj, struct device, kobj);
+
+	if (a == &dev_attr_command_retries_count.attr) {
+		if (nvme_disk_is_ns_head(dev_to_disk(dev)))
+			return 0;
+	}
+
 	return a->mode;
 }
 
-- 
2.53.0



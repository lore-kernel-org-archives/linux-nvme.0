Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B553BEC1EB1
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Feb 2026 12:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cElKkU2McC7OxoyN0Q/YGoEzvue/OvrYK33OvWbtdoE=; b=wCBn+onraqpwVJaqMy9HNPrFau
	vSGx8jQ1t6M2pdSWxdstJXxmr4va+9uGkzOSe9VGqSNyFCHr171APLdfwtFnC6yYCHhopOtHxfvB3
	Qbah9fuXCUpdvxS/37YF5cyev3GjrkQveY754XujO5HMbGE5BfXkQMhuwOsCF5+o53Y/uqjVeVj38
	T68alx7vtHww+jw3oibVudLsPei8Nm8qRPxmQx0NwAw3BuNt42wQ0TCKSThySvUaQIIk8bTlyu9Yu
	qycNUFV93DM/MZA6ZuYuU9Zxig4rv4lk2j7DtcvbdHK0TkDyihc4CAXtIgu6iobL3YLLpUdSTc3R2
	BCZGzCFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnymr-00000009thR-0SUU;
	Thu, 05 Feb 2026 12:48:45 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnyml-00000009tf1-04bk
	for linux-nvme@lists.infradead.org;
	Thu, 05 Feb 2026 12:48:40 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 6152HfXS030762;
	Thu, 5 Feb 2026 12:48:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=cElKkU2McC7OxoyN0
	Q/YGoEzvue/OvrYK33OvWbtdoE=; b=rVrNNtUOEWKxLW7NpaIvb+8/M5u/j069m
	/2Pmwxw3tUzJ9MGfGYikdqe6my0pyT1eI5MrVUFUz7jS6ZCRsEEHnDJp8kh2dO9M
	z0dvfNJy/XthK0RYq1HK6oV9f+Y5CTQS+01v41USUuXwL9Ak+MMTjaDgRYAuDzW2
	BaplxhowGtoBtoD6FnDUKRkD8dkKQdNtSGbN4os8F343Vsy46hmny+RtwpzB0Lhw
	AXUj4qFukzdZmeAmhaf9wMJvdxE8w5gK6YIeebDmFFSs4bQLVTeJiE/U2StzgtFY
	6PGuo1SzTuARnrdDISADMYpo9AjKzq/n2ZE/M4+twXSOzpGgU8l1w==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c1986ps8j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Feb 2026 12:48:30 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 615C0hnh025735;
	Thu, 5 Feb 2026 12:48:29 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4c1w2n1red-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Feb 2026 12:48:29 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 615CmPp829295022
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 5 Feb 2026 12:48:25 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 01EB520043;
	Thu,  5 Feb 2026 12:48:25 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EA37120040;
	Thu,  5 Feb 2026 12:48:22 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.in.ibm.com (unknown [9.109.198.179])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  5 Feb 2026 12:48:22 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
        hare@suse.de, dwagner@suse.de, wenxiong@linux.ibm.com, gjoyce@ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCHv2 1/7] nvme: export command retry count via sysfs
Date: Thu,  5 Feb 2026 18:18:00 +0530
Message-ID: <20260205124810.682559-2-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260205124810.682559-1-nilay@linux.ibm.com>
References: <20260205124810.682559-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDA5MiBTYWx0ZWRfXxn8bUTDQxy2z
 YYeBgg2o/LCgI9OUTwe/KovKqG5AEcioOywa/Pe6iAV0Kz8XDCHYcjmDbu53YK3naH1SIKN9xkT
 NoJ4lUoJPtHBpxRErACV/xiokhNWWQaiqL6SYvZ6FlY7ZolYyFxBkxjKylPOe45n0RBKZQXaqnN
 Da/xRg9SetFZ1Ym09qAoxH/D4kqd2QoR8VqjXpQXoWZ1yeRn4cOhaD2jHjXCgDgq0O4b5PQdLam
 xkVB7QzAcUTp1pmdSppUtAe3NUccEYe+9vJDb+MTW5+9zww1OgXKRfIkPD/Jqc5Mtaac+Kdapdq
 uXHxjsg228tTPp7Pq1nzEaCtUC73oCiQaUbCrzw2IhGnMaSiTiXkeQphILSDM0NqZW5dGF2wNJs
 UNEjY7LAQHcCd4dRojhd7jbmW9U0sT/IqztE1NkOoLKRHd2wdTiQ/cnp+pjPNPv/cxrs6oMOkkq
 3qsVBpjWr+A1K6CyTnA==
X-Proofpoint-GUID: ld7Ffmbv4QFH-tZjJ-HLB73M-5hnzVAT
X-Authority-Analysis: v=2.4 cv=DbAaa/tW c=1 sm=1 tr=0 ts=6984919e cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=93_06-CiGp8Lcqv6eA0A:9
X-Proofpoint-ORIG-GUID: ld7Ffmbv4QFH-tZjJ-HLB73M-5hnzVAT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_02,2026-02-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 adultscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2602050092
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260205_044839_482044_494F9B56 
X-CRM114-Status: GOOD (  20.51  )
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

Expose the command retries count through sysfs to provide visibility
into retry activity. This information can help identify controller-side
congestion under load and enables comparison across paths in multipath
setups (for example, detecting cases where one path experiences
significantly more retries than another under identical workloads).

This exported metric is intended for diagnostics and monitoring tools
such as nvme-top, and does not change command retry behavior.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/core.c  |  4 ++++
 drivers/nvme/host/nvme.h  |  2 +-
 drivers/nvme/host/sysfs.c | 14 ++++++++++++++
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 7bf228df6001..d2c430ec0077 100644
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
+		ns->retries = size_add(ns->retries, 1);
+
 	blk_mq_requeue_request(req, false);
 	blk_mq_delay_kick_requeue_list(req->q, delay);
 }
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 9a5f28c5103c..237829cdc151 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -359,7 +359,6 @@ struct nvme_ctrl {
 	unsigned long ka_last_check_time;
 	struct work_struct fw_act_work;
 	unsigned long events;
-
 #ifdef CONFIG_NVME_MULTIPATH
 	/* asymmetric namespace access: */
 	u8 anacap;
@@ -535,6 +534,7 @@ struct nvme_ns {
 	enum nvme_ana_state ana_state;
 	u32 ana_grpid;
 #endif
+	size_t retries;
 	struct list_head siblings;
 	struct kref kref;
 	struct nvme_ns_head *head;
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 29430949ce2f..174d099246b4 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -246,6 +246,15 @@ static ssize_t nuse_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RO(nuse);
 
+static ssize_t command_retries_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct nvme_ns *ns = nvme_get_ns_from_dev(dev);
+
+	return sysfs_emit(buf, "%lu\n", ns->retries);
+}
+static DEVICE_ATTR_RO(command_retries);
+
 static struct attribute *nvme_ns_attrs[] = {
 	&dev_attr_wwid.attr,
 	&dev_attr_uuid.attr,
@@ -263,6 +272,7 @@ static struct attribute *nvme_ns_attrs[] = {
 	&dev_attr_delayed_removal_secs.attr,
 #endif
 	&dev_attr_io_passthru_err_log_enabled.attr,
+	&dev_attr_command_retries.attr,
 	NULL,
 };
 
@@ -285,6 +295,10 @@ static umode_t nvme_ns_attrs_are_visible(struct kobject *kobj,
 		if (!memchr_inv(ids->eui64, 0, sizeof(ids->eui64)))
 			return 0;
 	}
+	if (a == &dev_attr_command_retries.attr) {
+		if (nvme_disk_is_ns_head(dev_to_disk(dev)))
+			return 0;
+	}
 #ifdef CONFIG_NVME_MULTIPATH
 	if (a == &dev_attr_ana_grpid.attr || a == &dev_attr_ana_state.attr) {
 		/* per-path attr */
-- 
2.52.0



Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EA5DC5AD44
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Feb 2026 17:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pVEvmJNDgYNcO7HkPozXvuFrVkc8org3rKr/+FwtYSM=; b=LrRpzR9+pMifSyKfCrV4gry7u5
	o7vMXqYcg7OMtkMXonycxVLjOcesXvvV2XvRpAg1a6Jo05jkDxK75Nzl27apus6lTYY+SAuvnwrLh
	2OhzYbasPoFqqeQM8JKEjJdzGyF91XAtLI60Fl7V6S2wMaYe/xi4I6vKwkp8VLbEmI6f2igU/GZrU
	NCI7eqMjVj/q87NDm/Rm4pshU27YVcbihqjmgCatuThZ4hEcKS0LXjDo6wRwo0FbmC0J7moPMxWC4
	ns7QAHWn6ciwkuApxuoTjM+3iY0WB+rQMyMtn51/Y3FCLg1r79Om4fjaxUZT1x4mRclLlKmZ2xLYh
	2bRMeENA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtUeZ-0000000FOy3-3yuR;
	Fri, 20 Feb 2026 17:50:59 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtUeW-0000000FOwf-3Erw
	for linux-nvme@lists.infradead.org;
	Fri, 20 Feb 2026 17:50:57 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61KD3tXq1601567;
	Fri, 20 Feb 2026 17:50:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=pVEvmJNDgYNcO7HkP
	ozXvuFrVkc8org3rKr/+FwtYSM=; b=eBkMwbRXY5KRxdQxvtV78iz5S78uJbwYE
	sbQBnHl1qPn5637pAn2GjhtoTV+ESngDT+BQPoSDsjP/2XC5dq0eaIzMY9VIUAXZ
	kYUoe0SjVudscVYu6zuQ17gmCCR+XA/M1WpEZgjdTbBqBW6+RUK7gWLn5J+uo+3R
	TJmQCRa+npDCetvucUH+nfMJNq1IUYH7aEvDQ9f7zNVDvz6S+mG6ctn04A3LCDwW
	YsJh1esXJJaKAGd5KHemzSpBLJatAygqrwOCIuvrdaYy2pkycMBUi+wdp0hO3j95
	ZFKD6ML1VlX+lXOk6WGvLQFZpxTkv5DC0nnA4cxKMmA9HoOf67eJQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cajcrccx2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Feb 2026 17:50:51 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61KELvhA015670;
	Fri, 20 Feb 2026 17:50:50 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ccb45hbm1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Feb 2026 17:50:50 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61KHojf050463082
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Feb 2026 17:50:46 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CC8492004E;
	Fri, 20 Feb 2026 17:50:45 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F084F2004B;
	Fri, 20 Feb 2026 17:50:40 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.111.6.227])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 20 Feb 2026 17:50:40 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
        hare@suse.de, dwagner@suse.de, wenxiong@linux.ibm.com, gjoyce@ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCHv3 1/7] nvme: export command retry count via sysfs
Date: Fri, 20 Feb 2026 23:18:46 +0530
Message-ID: <20260220175024.292898-2-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260220175024.292898-1-nilay@linux.ibm.com>
References: <20260220175024.292898-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 8nK6IVguZpgPW60ghDHdhND2tGeulAah
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIwMDE1MSBTYWx0ZWRfX6tuD6m2ino4A
 L/m5B5PF2/Kfsr5VgOumrD2QOKTMMEcIr784Cff0m4RX5DQS7tU84bJk4rDFitmIhGDwS26vSLQ
 8S3z5lcJrCYehuoJ82PVbS8C/wP8+wjSuz67GIxVERcYo+fi1Omw7SvU9tcGnAkgJylmYXFdk1t
 Lyslw2VMrjhgKoWn0MV9r3KFOX8QtBHNz2+zEIDK+AzIv4sAVUvJV3D2xlW+r71FALVcDZO8YM3
 NWSoTd+0OYfr5g7B7fBSucNn9apPv528uQJYVbz747UzlvxzDRY+P5kXrtW7D4/oevfAzH9FiJ/
 QkyxkrCQZjJOtdBChCh9obkRQa89Kukd7tgIcvuCqwF8LjeonaJ1/1NOd3G5pzUmQPgvFOeJWBr
 FMGMMNF4/leSwilpS/ZXSHqoZJpLZpZyamUyGVuLgX2f4s489yeAsQydGd95JWtgay9TLr6CEo4
 OMaNkFbXWgPgIdnPbaA==
X-Authority-Analysis: v=2.4 cv=UPXQ3Sfy c=1 sm=1 tr=0 ts=69989efb cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8 a=noCWAxjomXri9jzC5r4A:9
X-Proofpoint-ORIG-GUID: 8nK6IVguZpgPW60ghDHdhND2tGeulAah
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-20_02,2026-02-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 impostorscore=0 adultscore=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602200151
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260220_095056_815662_F567436E 
X-CRM114-Status: GOOD (  20.63  )
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
such as nvme-top, and does not change command retry behavior. A new
sysfs attribute named "command_retries" is added for this purpose.
This attribute is both readable as well as writable. So user could
reset this counter if needed.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/core.c  |  4 ++++
 drivers/nvme/host/nvme.h  |  2 +-
 drivers/nvme/host/sysfs.c | 30 ++++++++++++++++++++++++++++++
 3 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 19b67cf5d550..212dabc807bb 100644
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
+		WRITE_ONCE(ns->retries, size_add(READ_ONCE(ns->retries), 1));
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
index 29430949ce2f..11e7016954a7 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -246,6 +246,31 @@ static ssize_t nuse_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RO(nuse);
 
+static ssize_t command_retries_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct nvme_ns *ns = nvme_get_ns_from_dev(dev);
+
+	return sysfs_emit(buf, "%lu\n", READ_ONCE(ns->retries));
+}
+
+static ssize_t command_retries_store(struct device *dev,
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
+	WRITE_ONCE(ns->retries, retries);
+
+	return count;
+}
+static DEVICE_ATTR_RW(command_retries);
+
 static struct attribute *nvme_ns_attrs[] = {
 	&dev_attr_wwid.attr,
 	&dev_attr_uuid.attr,
@@ -263,6 +288,7 @@ static struct attribute *nvme_ns_attrs[] = {
 	&dev_attr_delayed_removal_secs.attr,
 #endif
 	&dev_attr_io_passthru_err_log_enabled.attr,
+	&dev_attr_command_retries.attr,
 	NULL,
 };
 
@@ -285,6 +311,10 @@ static umode_t nvme_ns_attrs_are_visible(struct kobject *kobj,
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



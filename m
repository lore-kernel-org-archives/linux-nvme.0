Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B9CAEC1EAD
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Feb 2026 12:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ovZSYfD6rvqkPnKOBSkUFLNa8nwzQ4djOryapP4OK5Y=; b=hJFNb9URSf4vLpdHQFM0lfFXFz
	Db+NAXejADuZIz7UzzJx00zZ5vV7FVCkqvri+hEXMwmlVhGE6bVx4Q9BuWtWNYJdd7/ANbPapjl6q
	9ijfJ8g5mcukT0fobOrQdlPJLFLUh7Qj0pd2rXlKQxwl4ZimXme/xhJExX7P2ZrpF57Eyqt26LT/3
	4hnZ9+6XY15/0M1/I7QSGqWZ6B107j0iJpkR/fOh4viIart+X2xdcNETupvyHZQPrj7LUDJ4Y3LAE
	+3LKZhSCjDlWfJIKC9qcletthNd7bZNc3bAwbCU5HrQomlhqE1coS04YKEIyasczAzH+eFPXUZZoy
	TcBCdH7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnymr-00000009tht-3Dl6;
	Thu, 05 Feb 2026 12:48:45 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnymn-00000009tft-1PaL
	for linux-nvme@lists.infradead.org;
	Thu, 05 Feb 2026 12:48:42 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 614M5Trr025173;
	Thu, 5 Feb 2026 12:48:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ovZSYfD6rvqkPnKOB
	SkUFLNa8nwzQ4djOryapP4OK5Y=; b=n48zFSXFFT7lKIZTceRsz/Q/uFIi7xGZL
	9+axOSQReeImvN367aQDM3wGMrx6D4pHiXyAb3QCQer15tSU3IL79OLw9AXf8Vxc
	i/tZtjSxHZDTxz8htImOkzPGziqIbv3RJHeHHbHVvFlyF/F1tudgy5BpuT2NCXV5
	irbDoMsFQG4wZrTqxV6T8B+iO9T6dLBnAEL1R8lr41WaVXPEPEGqPGgN5X6TbIS1
	PGomnUIFecwbSoX3DqIZBo0rDanHlvvKj8oY96wtav2a00DfpUWllAlTHK5AsQAe
	dD2AzruSbuAHBnMcZreninCJ2/XIgLfJK+mmFtXG2CSjij1e1Ai4g==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c19dtenq0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Feb 2026 12:48:35 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 615AmsZN015359;
	Thu, 5 Feb 2026 12:48:34 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4c4gsgt3vn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Feb 2026 12:48:34 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 615CmUUX59638116
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 5 Feb 2026 12:48:30 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 060FB20040;
	Thu,  5 Feb 2026 12:48:30 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EED3C20043;
	Thu,  5 Feb 2026 12:48:27 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.in.ibm.com (unknown [9.109.198.179])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  5 Feb 2026 12:48:27 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
        hare@suse.de, dwagner@suse.de, wenxiong@linux.ibm.com, gjoyce@ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCHv2 3/7] nvme: export command error counters via sysfs
Date: Thu,  5 Feb 2026 18:18:02 +0530
Message-ID: <20260205124810.682559-4-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260205124810.682559-1-nilay@linux.ibm.com>
References: <20260205124810.682559-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDA5MiBTYWx0ZWRfX8KHQsIS01Yc0
 Ci3Zff2SHeIZFSC9521KLgwbTHq2Tu5T2oV8oyiOd1Qmn+D7jdUjLQhnoFtF2GhpFpqukfuzXr7
 Jw9SnQm7upaY3+OBfWHCu7p8RCu8gvG0iY1gmoqeYTjjE2HSJR7dl0XJ5dcTCsGx8D+DMqAZQdc
 Kk5MeJFNq29yg2FNSlqh5UqENMdeio3fF5s0m2WVVAzf/Jry57h1MMNHMZU7QJf6ewoTfVcxZQn
 1P7pJQ7ozrTBJJ8VxxU0OB/AYAWBemWpsvP0iB5hU+Rmye7xfY9rkhsxh/u4af1LTCsv34RvzmJ
 iLfP8sPsXZBbxN2AdxEl0j0AqBBH1YS1yKAJ9CK7rNqBK/2ykiC7PQM4w5b7gHqTo1zjw9wobrn
 Nwgdd64TNNHqbrHyHPdEc/Y0zslRrTDusBNshHj+3m6qeibvx2GGH+FrFtrzghdgV2/tFKeHUMG
 Kpj2K+E3HnOt8nq/1Og==
X-Proofpoint-GUID: Z0JV6ShZhydCpLYaB93RKL2X9Wv3l0PV
X-Proofpoint-ORIG-GUID: Z0JV6ShZhydCpLYaB93RKL2X9Wv3l0PV
X-Authority-Analysis: v=2.4 cv=LesxKzfi c=1 sm=1 tr=0 ts=698491a3 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=HzLeVaNsDn8A:10 a=sWKEhP36mHoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=Xc1L59ySNgCl9VeoIVgA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_02,2026-02-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015
 adultscore=0 suspectscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2602050092
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260205_044841_440525_17465F06 
X-CRM114-Status: GOOD (  20.28  )
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

When an NVMe command completes with an error status, the driver
logs the error to the kernel log. However, these messages may be
lost or overwritten over time since dmesg is a circular buffer.

Expose per-path and ctrl command error counters through sysfs to
provide persistent visibility into error occurrences. This allows
users to observe the total number of commands that have failed on
a given path over time, which can be useful for diagnosing path
health and stability.

These counters can also be consumed by observability tools such as
nvme-top to provide additional insight into NVMe error behavior.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/core.c  | 10 +++++++++-
 drivers/nvme/host/nvme.h  |  2 ++
 drivers/nvme/host/sysfs.c | 29 +++++++++++++++++++++++++++++
 3 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d2c430ec0077..11eb28117501 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -438,11 +438,19 @@ static inline void nvme_end_req_zoned(struct request *req)
 
 static inline void __nvme_end_req(struct request *req)
 {
-	if (unlikely(nvme_req(req)->status && !(req->rq_flags & RQF_QUIET))) {
+	struct nvme_ns *ns = req->q->queuedata;
+	struct nvme_request *nr = nvme_req(req);
+
+	if (unlikely(nr->status && !(req->rq_flags & RQF_QUIET))) {
 		if (blk_rq_is_passthrough(req))
 			nvme_log_err_passthru(req);
 		else
 			nvme_log_error(req);
+
+		if (ns)
+			ns->errors = size_add(ns->errors, 1);
+		else
+			nr->ctrl->errors = size_add(nr->ctrl->errors, 1);
 	}
 	nvme_end_req_zoned(req);
 	nvme_trace_bio_complete(req);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 6307243fd216..83b102a0ad89 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -359,6 +359,7 @@ struct nvme_ctrl {
 	unsigned long ka_last_check_time;
 	struct work_struct fw_act_work;
 	unsigned long events;
+	size_t errors;
 #ifdef CONFIG_NVME_MULTIPATH
 	/* asymmetric namespace access: */
 	u8 anacap;
@@ -536,6 +537,7 @@ struct nvme_ns {
 	size_t failover;
 #endif
 	size_t retries;
+	size_t errors;
 	struct list_head siblings;
 	struct kref kref;
 	struct nvme_ns_head *head;
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 34dcb6db9b5c..4690ef9a1948 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/nvme-auth.h>
+#include <linux/blkdev.h>
 
 #include "nvme.h"
 #include "fabrics.h"
@@ -255,6 +256,16 @@ static ssize_t command_retries_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(command_retries);
 
+static ssize_t nvme_io_errors_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct nvme_ns *ns = nvme_get_ns_from_dev(dev);
+
+	return sysfs_emit(buf, "%lu\n", ns->errors);
+}
+struct device_attribute dev_attr_io_errors =
+	__ATTR(command_error_count, 0444, nvme_io_errors_show, NULL);
+
 static struct attribute *nvme_ns_attrs[] = {
 	&dev_attr_wwid.attr,
 	&dev_attr_uuid.attr,
@@ -274,6 +285,7 @@ static struct attribute *nvme_ns_attrs[] = {
 #endif
 	&dev_attr_io_passthru_err_log_enabled.attr,
 	&dev_attr_command_retries.attr,
+	&dev_attr_io_errors.attr,
 	NULL,
 };
 
@@ -300,6 +312,12 @@ static umode_t nvme_ns_attrs_are_visible(struct kobject *kobj,
 		if (nvme_disk_is_ns_head(dev_to_disk(dev)))
 			return 0;
 	}
+	if (a == &dev_attr_io_errors.attr) {
+		struct gendisk *disk = dev_to_disk(dev);
+
+		if (nvme_disk_is_ns_head(disk))
+			return 0;
+	}
 #ifdef CONFIG_NVME_MULTIPATH
 	if (a == &dev_attr_ana_grpid.attr || a == &dev_attr_ana_state.attr) {
 		/* per-path attr */
@@ -620,6 +638,16 @@ static ssize_t dctype_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(dctype);
 
+static ssize_t nvme_adm_errors_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%lu\n", ctrl->errors);
+}
+struct device_attribute dev_attr_adm_errors =
+	__ATTR(command_error_count, 0444, nvme_adm_errors_show, NULL);
+
 #ifdef CONFIG_NVME_HOST_AUTH
 static ssize_t nvme_ctrl_dhchap_secret_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
@@ -766,6 +794,7 @@ static struct attribute *nvme_dev_attrs[] = {
 	&dev_attr_dhchap_ctrl_secret.attr,
 #endif
 	&dev_attr_adm_passthru_err_log_enabled.attr,
+	&dev_attr_adm_errors.attr,
 	NULL
 };
 
-- 
2.52.0



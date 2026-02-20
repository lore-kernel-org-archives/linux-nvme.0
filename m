Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4478C5AD44
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Feb 2026 18:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JHF5EzMlL3zO1/MoR4hxEu9n5u0S32qeK1hWxfVC7ek=; b=ZdoOdTVvtMST4LYEArUNIEje3A
	8fhgglRKhX7kRDjJwuyjzTZhFpTTJ7RTBjLpbJKoUlBdlEn4G+u4W9xvleePYsCSceP2i85SM14LI
	70yA9YL5oSMZL46909rXkpJ7/9EED5nL9gP12SrS4JCfizKbHzKJlu/YxlgWjNXBzWM/m4/aVRNyK
	IknBa+FKKPy8JRd8n3WXFAAFXjhEaZIxG6siXbfhJJCszSG04i62SaKX/fg15Xdg0it7+O9ckq2SC
	Zl0c0GMDnCSjeewRd1OlTyDeObbcL0ZPQeQeqHzX6Xa7rle1HX7pXp1LBi05aJmeSvEsuWeVVj8Kh
	zRKTjKbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtV0V-0000000FRBI-2qeq;
	Fri, 20 Feb 2026 18:13:39 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtV0T-0000000FRAt-0ADq
	for linux-nvme@lists.infradead.org;
	Fri, 20 Feb 2026 18:13:38 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61KEU2jp1294764;
	Fri, 20 Feb 2026 18:13:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=JHF5EzMlL3zO1/MoR
	4hxEu9n5u0S32qeK1hWxfVC7ek=; b=eY9vwpKmkgHJaZ+XRJDYNoY/MlSfL17bD
	NeuWR9aBkfA9lAihkD06q/XJyPLH+23XI+qmBRm9PSB5wK+BvkVzZ+Czq99P3XJi
	IVrA0XKtGgW/S8fSGGMUb559YpLa622UagYH7DS6yMzmOTNXFv0JmlMdxVoz/Ser
	j31XZjhSxmgnexlIUuX58IzBnrCcV4PMYSjmd/ZBSihNw8xzxQMSDlY8ydW4UjGq
	IFdinWf2hvcP6mgKoIUkBTnjYQzHEdQQVhDfoUg6YHOoC0EbbhPncc5g2hGcDhfb
	yyveCHdDgz3yn0sPHpmdqe8XqB+lQZMfYFSvNtxuqfKP4xstRAnBQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4caj64jwc5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Feb 2026 18:13:22 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61KE5fou011916;
	Fri, 20 Feb 2026 18:13:22 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ccb279gxr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Feb 2026 18:13:21 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61KIDIJv21365194
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Feb 2026 18:13:18 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DD27E2004D;
	Fri, 20 Feb 2026 17:50:56 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 111D720043;
	Fri, 20 Feb 2026 17:50:52 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.111.6.227])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 20 Feb 2026 17:50:51 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
        hare@suse.de, dwagner@suse.de, wenxiong@linux.ibm.com, gjoyce@ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCHv3 3/7] nvme: export command error counters via sysfs
Date: Fri, 20 Feb 2026 23:18:48 +0530
Message-ID: <20260220175024.292898-4-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260220175024.292898-1-nilay@linux.ibm.com>
References: <20260220175024.292898-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: KHOgXeewxJmQv39SZYXCrdNkqgakg8cz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIwMDE1MyBTYWx0ZWRfXySb8n1to9ANC
 PbIjjIgsC1nYl3EzOrnyTgw3quxz94n6OlnnPeAvTcyicTLtRGOODP79J4jThlPZske/PDvxgHf
 MKooIbEXsM7Ffq8RFy0sJrhDl5ZalPkjYBMnX7gkOFGxOSHw90I0XZ+bJzU8QwqTyxQXmMhlTUO
 3wcZ1qDLATJTke9EfCXn/lEWAkEyAF+s8RTjnqu0XdK7ZeNX0FEbM9OsWj9q+peo/m11mR3jdw0
 tf6YTJhj0AH4JE/ukB8ccG3JdaqqbTcQB+JXUC6V7vrb600+ISj4sq5mS3c+dqVsCcfxivfILcO
 AF5MZfW8kK7z/T8atpu8th9qEVjckE8Z9tEJEIbuf3NEzX40VQnYvzUhRKEfUswJte+gZ6nfrtu
 hl997KA7fgGCybob0DR1+vqA4xjRWdPJxCqTHOtnLjv0jmgTjZITw6foxZosQCuSbysYxp/3DF2
 iqcO0yfx9fGqIGwLuJw==
X-Proofpoint-GUID: KHOgXeewxJmQv39SZYXCrdNkqgakg8cz
X-Authority-Analysis: v=2.4 cv=U+mfzOru c=1 sm=1 tr=0 ts=6998a442 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=HzLeVaNsDn8A:10 a=sWKEhP36mHoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8
 a=lxPUUVkMrx1MXXP1jp4A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-20_02,2026-02-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 impostorscore=0 malwarescore=0 spamscore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602200153
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260220_101337_220223_5875F1AC 
X-CRM114-Status: GOOD (  21.59  )
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

Add new sysfs attribute named "command_error_count" per-path and
ctrl which is both readable and writable thus allowing user to reset
these counters. These counters can also be consumed by observability
tools such as nvme-top to provide additional insight into NVMe error
behavior.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/core.c  | 12 +++++++-
 drivers/nvme/host/nvme.h  |  2 ++
 drivers/nvme/host/sysfs.c | 65 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 78 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 212dabc807bb..d07e2ed9e494 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -438,11 +438,21 @@ static inline void nvme_end_req_zoned(struct request *req)
 
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
+			WRITE_ONCE(ns->errors,
+				size_add(READ_ONCE(ns->errors), 1));
+		else
+			WRITE_ONCE(nr->ctrl->errors,
+				size_add(READ_ONCE(nr->ctrl->errors), 1));
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
index 78c3a6f78ef8..4012123be507 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/nvme-auth.h>
+#include <linux/blkdev.h>
 
 #include "nvme.h"
 #include "fabrics.h"
@@ -271,6 +272,34 @@ static ssize_t command_retries_store(struct device *dev,
 }
 static DEVICE_ATTR_RW(command_retries);
 
+static ssize_t nvme_io_errors_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct nvme_ns *ns = nvme_get_ns_from_dev(dev);
+
+	return sysfs_emit(buf, "%lu\n", READ_ONCE(ns->errors));
+}
+
+static ssize_t nvme_io_errors_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	unsigned long errors;
+	int err;
+	struct nvme_ns *ns = nvme_get_ns_from_dev(dev);
+
+	err = kstrtoul(buf, 0, &errors);
+	if (err)
+		return -EINVAL;
+
+	WRITE_ONCE(ns->errors, errors);
+
+	return count;
+}
+
+struct device_attribute dev_attr_io_errors =
+	__ATTR(command_error_count, 0644,
+			nvme_io_errors_show, nvme_io_errors_store);
+
 static struct attribute *nvme_ns_attrs[] = {
 	&dev_attr_wwid.attr,
 	&dev_attr_uuid.attr,
@@ -290,6 +319,7 @@ static struct attribute *nvme_ns_attrs[] = {
 #endif
 	&dev_attr_io_passthru_err_log_enabled.attr,
 	&dev_attr_command_retries.attr,
+	&dev_attr_io_errors.attr,
 	NULL,
 };
 
@@ -316,6 +346,12 @@ static umode_t nvme_ns_attrs_are_visible(struct kobject *kobj,
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
@@ -636,6 +672,34 @@ static ssize_t dctype_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(dctype);
 
+static ssize_t nvme_adm_errors_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%lu\n", READ_ONCE(ctrl->errors));
+}
+
+static ssize_t nvme_adm_errors_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	unsigned long errors;
+	int err;
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+
+	err = kstrtoul(buf, 0, &errors);
+	if (err)
+		return -EINVAL;
+
+	WRITE_ONCE(ctrl->errors, errors);
+
+	return count;
+}
+
+struct device_attribute dev_attr_adm_errors =
+	__ATTR(command_error_count, 0644,
+			nvme_adm_errors_show, nvme_adm_errors_store);
+
 #ifdef CONFIG_NVME_HOST_AUTH
 static ssize_t nvme_ctrl_dhchap_secret_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
@@ -782,6 +846,7 @@ static struct attribute *nvme_dev_attrs[] = {
 	&dev_attr_dhchap_ctrl_secret.attr,
 #endif
 	&dev_attr_adm_passthru_err_log_enabled.attr,
+	&dev_attr_adm_errors.attr,
 	NULL
 };
 
-- 
2.52.0



Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCB21CD4F49
	for <linux-nvme@archiver.kernel.org>; Sat, 16 May 2026 18:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5Lmv8N80QARLxb6QR6LQE5Ov7DTGY0qmYyL7cDeD18M=; b=oTOQsTcWwHW+bUdAFBDtgGmvtN
	a8lqcKYz2BvU4Mh/2hLvfyZYArOg2e5mmf3LYKkEvgz6ubPFzby5SjQhk8NhNoKBluTqX29DsMaJv
	yiTeO3tMBswjJu+4We8Hbaeq3LUE6toErZbnyDmU7bl7s+6z7ttp6CC4Gj2cn0KgTZiB0iYtYqDvd
	TIpNiuyz52YCSpuyU1wh1BlgylYXSGtChHIWdtBQz4kJwvZ1rqlUCm0RFNnF8QX2+23isUwqAtd07
	SfptDat79V6AkKgXe2z6P97XICucfeNTy7qWktTWHNtNZJza0qPE98VH33WZdwB1CxehPkc7q5YQN
	QPGcHwXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOJtc-0000000BDsX-0fDL;
	Sat, 16 May 2026 18:37:56 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOJta-0000000BDqL-0Rmh
	for linux-nvme@lists.infradead.org;
	Sat, 16 May 2026 18:37:55 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64G4BQXv146427;
	Sat, 16 May 2026 18:37:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=5Lmv8N80QARLxb6QR
	6LQE5Ov7DTGY0qmYyL7cDeD18M=; b=IHLhxLxVbLyoYmmynj8RaOnydEwJqIAvM
	py8x1TPP2n+wxohv+6fh7XSudQ4s0zp7o3whHSTteb+YvFXCp8faGpnUJd/nVOnH
	spndZCy0f31SnAtjj+DQSE9cJrlyQ4OJW++93c5eKMi+8SQt3GY7nKSDgs6XjuiC
	qCucSiRz1M3yis4DRX5eq8Z0qtmYiF1SmFFArzyFsmBlPxViMV3GLgW7tcUihlyX
	Clk0EPb4wemJVt6xzy2cQ9YCrc5b3CzHkUTB0MWzobjPRvieMxykq/YW2C5YSFW+
	W2RDSKxy9kyqcRLV5+qTAZcwu9IdRoEUIZuGt5fFGyGl4iGqa41IQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6havsrat-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 May 2026 18:37:46 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64GIO9NM024343;
	Sat, 16 May 2026 18:37:46 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e5kvd0sqb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 May 2026 18:37:45 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64GIbgu648824800
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 16 May 2026 18:37:42 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1ED3E20043;
	Sat, 16 May 2026 18:37:42 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5B3EB20040;
	Sat, 16 May 2026 18:37:38 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.111.59.249])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 16 May 2026 18:37:38 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, hare@suse.com, kbusch@kernel.org, hch@lst.de,
        sagi@grimberg.me, axboe@kernel.dk, chaitanyak@nvidia.com,
        venkat88@linux.ibm.com, gjoyce@linux.ibm.com, wenxiong@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCHv4 4/8] nvme: export command error counters via sysfs
Date: Sun, 17 May 2026 00:06:51 +0530
Message-ID: <20260516183709.269937-5-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260516183709.269937-1-nilay@linux.ibm.com>
References: <20260516183709.269937-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE2MDE4NiBTYWx0ZWRfX/DCPb6ghyTQF
 qLAtoR8TiEmz9OgO+NVHDcupxE7nHtS7INZk79G9GWPf6vPLygfLrBy8FVnzEjt6KD/1sL3Rqn4
 LCjTDv2yRzTww0fn0PY6XSK/qW9kUi6FJ9DrR/1fGagA15Vn+1+cB1r6IVCPPQ+3uEWEOjBpa7d
 VXpil2pIuMa/kgczO60QGlpeURbiwjx1OIxjz+j1Jvc8kncS+WwgqJxhovETdKK7x+MPZ6zcKmD
 hOy7rhYJMjqk3+qOeCdrVFtEjXmtrQaFKPTNSJNTCLZ67tgM5oOgp8oyKTzU1SZT5N4+hwekyuS
 kjPZhSaQ0CeP2R0frNzVr2y4XSGjU9pT/npu/RSbevudBJt8PS6QQd0DEGTJBrMEJr+0odEk+XF
 WC3JogQ5HsaBPjZSaeGkci4/WhB7JKW2JQ84rUBeBeaJpZk4U3nZmv1RemWH6HvSfaJ9eAhaFdK
 iY6/6AekDS7uy5fnWUA==
X-Authority-Analysis: v=2.4 cv=Np/htcdJ c=1 sm=1 tr=0 ts=6a08b97a cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=NGcC8JguVDcA:10 a=sWKEhP36mHoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=gf3pdzQGlrpykD0IcMEA:9
X-Proofpoint-ORIG-GUID: vdjc_Lq-nI8-tcYOxDY8d3PomY02aMan
X-Proofpoint-GUID: vdjc_Lq-nI8-tcYOxDY8d3PomY02aMan
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-16_02,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605160186
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260516_113754_263231_39C705FE 
X-CRM114-Status: GOOD (  19.57  )
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

Expose per-path and ctrl sysfs attribute command_error_count, under
diag attribute group to provide persistent visibility into error
occurrences. This allows users to observe the total number of commands
that have failed on a given path over time, which can be useful for
diagnosing path health and stability.

This attribute is both readable and writable thus allowing user to reset
these counters. These counters can also be consumed by observability
tools such as nvme-top to provide additional insight into NVMe error
behavior.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/core.c  | 10 +++++-
 drivers/nvme/host/nvme.h  |  2 ++
 drivers/nvme/host/sysfs.c | 66 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 77 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index bacd5e45c322..3b2f7a972941 100644
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
+			atomic_long_inc(&ns->errors);
+		else
+			atomic_long_inc(&nr->ctrl->errors);
 	}
 	nvme_end_req_zoned(req);
 	nvme_trace_bio_complete(req);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 68c9df4f457a..b83d702dbb92 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -413,6 +413,7 @@ struct nvme_ctrl {
 	unsigned long ka_last_check_time;
 	struct work_struct fw_act_work;
 	unsigned long events;
+	atomic_long_t errors;
 
 #ifdef CONFIG_NVME_MULTIPATH
 	/* asymmetric namespace access: */
@@ -592,6 +593,7 @@ struct nvme_ns {
 	atomic_long_t failover;
 #endif
 	atomic_long_t retries;
+	atomic_long_t errors;
 	struct list_head siblings;
 	struct kref kref;
 	struct nvme_ns_head *head;
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 35a42fd4aec4..789518f21f40 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/nvme-auth.h>
+#include <linux/blkdev.h>
 
 #include "nvme.h"
 #include "fabrics.h"
@@ -376,8 +377,37 @@ static ssize_t command_retries_count_store(struct device *dev,
 }
 static DEVICE_ATTR_RW(command_retries_count);
 
+static ssize_t nvme_io_errors_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct nvme_ns *ns = nvme_get_ns_from_dev(dev);
+
+	return sysfs_emit(buf, "%lu\n", atomic_long_read(&ns->errors));
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
+	atomic_long_set(&ns->errors, errors);
+
+	return count;
+}
+
+struct device_attribute dev_attr_io_errors =
+	__ATTR(command_error_count, 0644,
+		nvme_io_errors_show, nvme_io_errors_store);
+
 static struct attribute *nvme_ns_diag_attrs[] = {
 	&dev_attr_command_retries_count.attr,
+	&dev_attr_io_errors.attr,
 #ifdef CONFIG_NVME_MULTIPATH
 	&dev_attr_multipath_failover_count.attr,
 #endif
@@ -393,6 +423,12 @@ static umode_t nvme_ns_diag_attrs_are_visible(struct kobject *kobj,
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
 	if (a == &dev_attr_multipath_failover_count.attr) {
 		if (nvme_disk_is_ns_head(dev_to_disk(dev)))
@@ -995,7 +1031,37 @@ static const struct attribute_group nvme_tls_attrs_group = {
 };
 #endif
 
+static ssize_t nvme_adm_errors_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%lu\n",
+			(unsigned long)atomic_long_read(&ctrl->errors));
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
+	atomic_long_set(&ctrl->errors, errors);
+
+	return count;
+}
+
+struct device_attribute dev_attr_adm_errors =
+	__ATTR(command_error_count, 0644,
+		nvme_adm_errors_show, nvme_adm_errors_store);
+
 static struct attribute *nvme_dev_diag_attrs[] = {
+	&dev_attr_adm_errors.attr,
 	NULL,
 };
 
-- 
2.53.0



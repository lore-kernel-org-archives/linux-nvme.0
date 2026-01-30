Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 773A1E6BF2F
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Jan 2026 18:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=skPjQVbxueH/8JAwpjQmSFYuzZTgj8wnhjgcfi1D858=; b=BApt21e54k+rxmCkkaeHRdMBsF
	ypfk3/eK85dT4rXtsNuBGoHNDmXNjC7mi7imeZdnkgjYbOeHzZP/NoFAYNFlBJs05axIwoFSJ+XOA
	0XdRznv9RU1NDU4mPpAaVF4bgHwl6ac/gSpYn0Oeejx+BQGPypxrme8MJsCZd+5vTGbo+lIX+yw/l
	XTQCCcajoTpeW1/umdMvN+k28rgoUvYnbYVKkHcro7qw/Y7iBsu+wTHRxG0lahcp5qPu3BMDHzQz5
	e5b/uPiq1iacmPh28C0y1sYVd6bdSIo8qhTYbskpfpikZ+vFyttu7WoUJNgcpQHwpBpIewc6EI42h
	rv1Gh94Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlt7K-00000001p2P-2qjw;
	Fri, 30 Jan 2026 18:21:14 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlt7H-00000001p10-0Wsb
	for linux-nvme@lists.infradead.org;
	Fri, 30 Jan 2026 18:21:13 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60UHODb9024617;
	Fri, 30 Jan 2026 18:21:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=skPjQVbxueH/8JAwp
	jQmSFYuzZTgj8wnhjgcfi1D858=; b=LeMgtrQm2OawYBI3n0PTgIJ6UgLCBzjBs
	b3tfr9jgsP9fUDPtu5qIVuqTI/RD2kmbq/ceGOytD4h3WU1IjeCffHHvN68Ij2qS
	TgD+ptzQ/cUqo7uYYeFhaGqdpy+dx0HUcRs/m5j0BZZrhbez5a0AIuBCjXr3Fb52
	rDnUlUOoYt0RlXE/nUT+APvxd22410dLKYUTpsBkM8VPRgj34ewyelxcybQlKa5X
	TsxwbjBM7YBfyzetK4li/K2sBcrJtyenzNzLNVSmbbrIJrvFMSQ4hStjpWYGU/bx
	UETlp3Ohy1B/b9Pm05G0C+cLaU24EL+daOk0QdVrDI0vTBqVJ2UWg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvnrty8n3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Jan 2026 18:21:03 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60UH5dt1017960;
	Fri, 30 Jan 2026 18:21:02 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bwb4272gb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Jan 2026 18:21:02 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60UIKx9Z50856232
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Jan 2026 18:20:59 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EC68C20043;
	Fri, 30 Jan 2026 18:20:58 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 20A8C20040;
	Fri, 30 Jan 2026 18:20:55 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.87.154.17])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 30 Jan 2026 18:20:54 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
        hare@suse.de, dwagner@suse.de, wenxiong@linux.ibm.com, gjoyce@ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH 3/7] nvme: export command error counters via sysfs
Date: Fri, 30 Jan 2026 23:50:20 +0530
Message-ID: <20260130182028.885089-4-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260130182028.885089-1-nilay@linux.ibm.com>
References: <20260130182028.885089-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -CuLkXE__alXk3bc_NClNNTAmqCoj5fT
X-Authority-Analysis: v=2.4 cv=Uptu9uwB c=1 sm=1 tr=0 ts=697cf68f cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=vUbySO9Y5rIA:10 a=sWKEhP36mHoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=Xc1L59ySNgCl9VeoIVgA:9
X-Proofpoint-ORIG-GUID: -CuLkXE__alXk3bc_NClNNTAmqCoj5fT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMwMDE1MCBTYWx0ZWRfX7ZULJy0JG3qU
 2q97UoixIH1K+0QmyH6opB/exPp4H+z3bYwsiLaIK+PHLjlLo5rW6LeY1FXexmliKiZbUgHGZPU
 j0aIpyNyBBIlX8PV8umxqvXm+t1IWJYi0U/SGwjB5VlNlUeIYpFhmH1VDShRNz9PXKPzffnoaJ0
 dOYokPCxkTLG5DZ2e7qNwfxZklKObVJPWkAVFHvkk01adOG94qIYh5E8LQU+A8pg6JJdv+oKiWD
 4vwI4IR6EYge7Pj7HGwEBdG311oZpk7EBJ4A4ZD20J/O3j7bXJPV0/M67Vn27a4aTQ0lAbHaQDa
 Eb4LD9Nm699Ag8aFXqWiGPwyCIUOWjcJeXkFgTjFtROvTNU7UHDbwQbVFYa4LVIwlSnnipu5anW
 nMyl1zHyrHYDdNE3jRm8o36d7AjYNaYac+qxzWa7IAeFPN5KlAuGXPIkfqdZFgLN0t7XaaWU0PE
 6/2g7JZbsbp8l7SaYDg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-30_02,2026-01-30_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 clxscore=1015 lowpriorityscore=0
 phishscore=0 adultscore=0 impostorscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601300150
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260130_102112_135092_65E74C0E 
X-CRM114-Status: GOOD (  21.34  )
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
 drivers/nvme/host/core.c  | 16 ++++++++++++++--
 drivers/nvme/host/nvme.h  |  2 ++
 drivers/nvme/host/sysfs.c | 29 +++++++++++++++++++++++++++++
 3 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d6490cc2a8e3..d16a3f4cc466 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -440,11 +440,23 @@ static inline void nvme_end_req_zoned(struct request *req)
 
 static inline void __nvme_end_req(struct request *req)
 {
+	struct nvme_ns *ns = req->q->queuedata;
+
 	if (unlikely(nvme_req(req)->status && !(req->rq_flags & RQF_QUIET))) {
-		if (blk_rq_is_passthrough(req))
+		if (blk_rq_is_passthrough(req)) {
 			nvme_log_err_passthru(req);
-		else
+			if (ns)
+				ns->errors++;
+			else {
+				struct nvme_request *nr = nvme_req(req);
+				struct nvme_ctrl *ctrl = nr->ctrl;
+
+				ctrl->errors++;
+			}
+		} else {
 			nvme_log_error(req);
+			ns->errors++;
+		}
 	}
 	nvme_end_req_zoned(req);
 	nvme_trace_bio_complete(req);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 119ba2344039..b7e46bdd2d59 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -360,6 +360,7 @@ struct nvme_ctrl {
 	struct work_struct fw_act_work;
 	unsigned long events;
 	u64 retries;
+	u64 errors;
 #ifdef CONFIG_NVME_MULTIPATH
 	/* asymmetric namespace access: */
 	u8 anacap;
@@ -537,6 +538,7 @@ struct nvme_ns {
 	u64 failover;
 #endif
 	u64 retries;
+	u64 errors;
 	struct list_head siblings;
 	struct kref kref;
 	struct nvme_ns_head *head;
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 8fc593c36b74..41218fa5081f 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/nvme-auth.h>
+#include <linux/blkdev.h>
 
 #include "nvme.h"
 #include "fabrics.h"
@@ -257,6 +258,16 @@ static struct device_attribute dev_attr_io_command_retries =
 	__ATTR(command_retry_count, 0444,
 		nvme_io_command_retries_show, NULL);
 
+static ssize_t nvme_io_errors_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct nvme_ns *ns = nvme_get_ns_from_dev(dev);
+
+	return sysfs_emit(buf, "%llu\n", ns->errors);
+}
+struct device_attribute dev_attr_io_errors =
+	__ATTR(command_error_count, 0444, nvme_io_errors_show, NULL);
+
 static struct attribute *nvme_ns_attrs[] = {
 	&dev_attr_wwid.attr,
 	&dev_attr_uuid.attr,
@@ -276,6 +287,7 @@ static struct attribute *nvme_ns_attrs[] = {
 #endif
 	&dev_attr_io_passthru_err_log_enabled.attr,
 	&dev_attr_io_command_retries.attr,
+	&dev_attr_io_errors.attr,
 	NULL,
 };
 
@@ -301,6 +313,12 @@ static umode_t nvme_ns_attrs_are_visible(struct kobject *kobj,
 	if (a == &dev_attr_io_command_retries.attr) {
 		struct gendisk *disk = dev_to_disk(dev);
 
+		if (nvme_disk_is_ns_head(disk))
+			return 0;
+	}
+	if (a == &dev_attr_io_errors.attr) {
+		struct gendisk *disk = dev_to_disk(dev);
+
 		if (nvme_disk_is_ns_head(disk))
 			return 0;
 	}
@@ -635,6 +653,16 @@ static struct device_attribute dev_attr_adm_command_retries =
 	__ATTR(command_retry_count, 0444,
 		nvme_adm_command_retries_show, NULL);
 
+static ssize_t nvme_adm_errors_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%llu\n", ctrl->errors);
+}
+struct device_attribute dev_attr_adm_errors =
+	__ATTR(command_error_count, 0444, nvme_adm_errors_show, NULL);
+
 #ifdef CONFIG_NVME_HOST_AUTH
 static ssize_t nvme_ctrl_dhchap_secret_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
@@ -782,6 +810,7 @@ static struct attribute *nvme_dev_attrs[] = {
 #endif
 	&dev_attr_adm_passthru_err_log_enabled.attr,
 	&dev_attr_adm_command_retries.attr,
+	&dev_attr_adm_errors.attr,
 	NULL
 };
 
-- 
2.52.0



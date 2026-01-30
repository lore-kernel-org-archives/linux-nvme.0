Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69188E6BF30
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Jan 2026 18:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LYeh01SqdazeYlse8Z0oRkXa1O77PdIjX1Yu8Rj+p9c=; b=P9RN87M0uCCG82T7C6ZSE3TNOp
	E8e8wa/MznMZRz9MMzK6sDDMRYo2RLIGdtOZNmWNgK/8zCXaYVdD1fsu3u/bdv8fxn5TTmZ6HxMbC
	o7EZX+8s8j9chp54YcGXO6dDrtrVjkWZ7uI7VTZ4BcKFIJ2Lb1G3Z5WZLVHdIprKfkAsBB2UQ6Um4
	wYNWqfTxpVHK9MOhNVYjJcw7Y8C0fcgeoeqmWBczv6cpqMFQj+cwsLpOtk/X/vjIwp9Ygx0wfQRHJ
	YQV5ouaI+EEg9K091kSijJtoV+7tY4RclNYCuE8fQgsREKcJcZv/V3+8jbk9zONiCa+ZKFRt/WOSL
	ey9RUxwg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlt7I-00000001p1N-2GoP;
	Fri, 30 Jan 2026 18:21:12 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlt7A-00000001oxW-2PBk
	for linux-nvme@lists.infradead.org;
	Fri, 30 Jan 2026 18:21:07 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60U3v4pO022842;
	Fri, 30 Jan 2026 18:20:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=LYeh01SqdazeYlse8
	Z0oRkXa1O77PdIjX1Yu8Rj+p9c=; b=ZIQ0yJxIuTcb+hKgxZRROVxJ/KS7kUdGc
	eKz6H6OxyiXUiBs7dDcRPg/Fw8CZ9+OEhXqJ63utKYeWQLwEj8udMrhnYIpsXpq8
	/IGVclCWcB0jOCSv6fHRuZPVcocI1VvDL9hTiTYybYzCWtnhYf20RZ7hKKdf5KrP
	IX0m5L4uPLuXk3rePVY2w+bNtnPEHNwYAeCKel/4h2GSkdavaOo2ijbanTRQgoV6
	frlNTBxcopmuwxa+UMgPwOJTVuGcKW1jZdJ9pDeN5DDF49V9Y1NgLt/Vs38+3TP5
	1CQj7DLcGjtgba/MKkPB5YjpZQFb2WTcXh+9927k4RLUgI/O6T+MA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvkgn47ge-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Jan 2026 18:20:54 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60UGH5TB023679;
	Fri, 30 Jan 2026 18:20:53 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bwamk75uv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Jan 2026 18:20:53 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60UIKo2M29557482
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Jan 2026 18:20:50 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F243920040;
	Fri, 30 Jan 2026 18:20:49 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 202F720043;
	Fri, 30 Jan 2026 18:20:46 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.87.154.17])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 30 Jan 2026 18:20:45 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
        hare@suse.de, dwagner@suse.de, wenxiong@linux.ibm.com, gjoyce@ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH 1/7] nvme: export command retry count via sysfs
Date: Fri, 30 Jan 2026 23:50:18 +0530
Message-ID: <20260130182028.885089-2-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260130182028.885089-1-nilay@linux.ibm.com>
References: <20260130182028.885089-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Gr1PO01C c=1 sm=1 tr=0 ts=697cf686 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=noCWAxjomXri9jzC5r4A:9
X-Proofpoint-GUID: o81CihleLwKpCB47BH6IMCcCKl4h_v1z
X-Proofpoint-ORIG-GUID: o81CihleLwKpCB47BH6IMCcCKl4h_v1z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMwMDE1MCBTYWx0ZWRfX6y3Leg7QH7MR
 tjWBgcGKr72Kb7yvaFtSYERtKuxQ1KvTrBWMqzbLeUG/8vMUmjDsB8K1HJFHXr91Ml7cCm7YZjj
 CRCsFq9HdTfMlpkumHjOMaQ8nMj9s/PFGXB/ZlenLW7VpjTCbfC2reb4zne3KVQmE4qAS75PXSH
 9rsA6WgimDDUjXUtCeKaLm7OsfTnnYE3/chw11d+B17UvN/IsFkKNvxo92ivbxYCVolI0ZaZtW7
 I+fdiPyxlqof2qcigGYw18OT96mk+kVgobXpOhYx9u2HxZrf3ij8OzfhtDlCSjpo9Yrkl56AXpY
 t9dxeLTOCOZa7G5hkyuveapbGV6iMSIBwJgMewdpYFBMyUZ+E+nJyi3h8U5ewQ3QDOW1NHzcnWL
 t2SXGdl6PAhC2J7IZ8jIbxV9lk4T2mz9tiYBNT16tTzX7xwfSx57SQvlSnUPbcrBRyCC0rpzpVc
 m0b8j+mqDOTPRP4N90Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-30_02,2026-01-30_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 suspectscore=0
 impostorscore=0 phishscore=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601300150
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260130_102104_733014_612B9DD3 
X-CRM114-Status: GOOD (  21.25  )
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
 drivers/nvme/host/core.c  |  6 ++++++
 drivers/nvme/host/nvme.h  |  3 ++-
 drivers/nvme/host/sysfs.c | 30 ++++++++++++++++++++++++++++++
 3 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 7bf228df6001..d6490cc2a8e3 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -323,6 +323,7 @@ static void nvme_retry_req(struct request *req)
 {
 	unsigned long delay = 0;
 	u16 crd;
+	struct nvme_ns *ns = req->q->queuedata;
 
 	/* The mask and shift result must be <= 3 */
 	crd = (nvme_req(req)->status & NVME_STATUS_CRD) >> 11;
@@ -330,6 +331,11 @@ static void nvme_retry_req(struct request *req)
 		delay = nvme_req(req)->ctrl->crdt[crd - 1] * 100;
 
 	nvme_req(req)->retries++;
+	if (ns)
+		ns->retries++;
+	else
+		nvme_req(req)->ctrl->retries++;
+
 	blk_mq_requeue_request(req, false);
 	blk_mq_delay_kick_requeue_list(req->q, delay);
 }
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 9a5f28c5103c..d8a2831ed34c 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -359,7 +359,7 @@ struct nvme_ctrl {
 	unsigned long ka_last_check_time;
 	struct work_struct fw_act_work;
 	unsigned long events;
-
+	u64 retries;
 #ifdef CONFIG_NVME_MULTIPATH
 	/* asymmetric namespace access: */
 	u8 anacap;
@@ -535,6 +535,7 @@ struct nvme_ns {
 	enum nvme_ana_state ana_state;
 	u32 ana_grpid;
 #endif
+	u64 retries;
 	struct list_head siblings;
 	struct kref kref;
 	struct nvme_ns_head *head;
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 29430949ce2f..c1e27088a053 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -246,6 +246,17 @@ static ssize_t nuse_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RO(nuse);
 
+static ssize_t nvme_io_command_retries_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct nvme_ns *ns = nvme_get_ns_from_dev(dev);
+
+	return sysfs_emit(buf, "%llu\n", ns->retries);
+}
+static struct device_attribute dev_attr_io_command_retries =
+	__ATTR(command_retry_count, 0444,
+		nvme_io_command_retries_show, NULL);
+
 static struct attribute *nvme_ns_attrs[] = {
 	&dev_attr_wwid.attr,
 	&dev_attr_uuid.attr,
@@ -263,6 +274,7 @@ static struct attribute *nvme_ns_attrs[] = {
 	&dev_attr_delayed_removal_secs.attr,
 #endif
 	&dev_attr_io_passthru_err_log_enabled.attr,
+	&dev_attr_io_command_retries.attr,
 	NULL,
 };
 
@@ -285,6 +297,12 @@ static umode_t nvme_ns_attrs_are_visible(struct kobject *kobj,
 		if (!memchr_inv(ids->eui64, 0, sizeof(ids->eui64)))
 			return 0;
 	}
+	if (a == &dev_attr_io_command_retries.attr) {
+		struct gendisk *disk = dev_to_disk(dev);
+
+		if (nvme_disk_is_ns_head(disk))
+			return 0;
+	}
 #ifdef CONFIG_NVME_MULTIPATH
 	if (a == &dev_attr_ana_grpid.attr || a == &dev_attr_ana_state.attr) {
 		/* per-path attr */
@@ -601,6 +619,17 @@ static ssize_t dctype_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(dctype);
 
+static ssize_t nvme_adm_command_retries_show(struct device *dev,
+			   struct device_attribute *attr, char *buf)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%llu\n", ctrl->retries);
+}
+static struct device_attribute dev_attr_adm_command_retries =
+	__ATTR(command_retry_count, 0444,
+		nvme_adm_command_retries_show, NULL);
+
 #ifdef CONFIG_NVME_HOST_AUTH
 static ssize_t nvme_ctrl_dhchap_secret_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
@@ -747,6 +776,7 @@ static struct attribute *nvme_dev_attrs[] = {
 	&dev_attr_dhchap_ctrl_secret.attr,
 #endif
 	&dev_attr_adm_passthru_err_log_enabled.attr,
+	&dev_attr_adm_command_retries.attr,
 	NULL
 };
 
-- 
2.52.0



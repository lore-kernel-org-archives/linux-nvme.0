Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4099EC1EAF
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Feb 2026 12:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=I1D5lsOtLAyDMzbDf0twgkxh/s2zbjPcyaSH6yZGLXM=; b=Le+32onRtRvXO1N0fbEzK7Dh4Q
	ytmYSWo7O5GDFS3Nrm/5XMKcrj7vOi1oCW4JZ76XsEfe6YDZSFSzcxnuWW5iNhUWPXWCkdmYvcXXu
	F0M9y90gXpDpJBZmV04JvXB7M04Fs++t7zjDiiJ8kKlsMDGueI8oY2yEAB5F2bbllE2GC0R6lTyS3
	oZhjuqEDIABVqDQQtdo+LdgduXR/yhPJFYBkf+3wAGZdNPSojPqBupByinPMDBcfE4I/9uIpWqniR
	udKoTHp2CxH1dyPsRC8tlBaNoqmmSiQv9ZndLyQCKkmvXu4Bn1zOXEvnI8KCaBGv0x9v9BczDwR61
	CyQpRakg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnyms-00000009tiO-3Yzq;
	Thu, 05 Feb 2026 12:48:46 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnymr-00000009thQ-0YDL
	for linux-nvme@lists.infradead.org;
	Thu, 05 Feb 2026 12:48:46 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 61576Z68030911;
	Thu, 5 Feb 2026 12:48:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=I1D5lsOtLAyDMzbDf
	0twgkxh/s2zbjPcyaSH6yZGLXM=; b=FsqJ/QuKTguBaA166D9V16gbTDUpBJIfE
	JjcTleE9h3MOe5dTeBe2SdDTWF0+G5q5sNQImdUWcTZRNflIn2TCiO0t4KTS3rOT
	U6oCVLyLV/sLErwBYnLqFKAexMFfLwgWZZokxT+8GjMBIj/XSKDBvktzR+rwyzyt
	4gZiSbG5E1Tg6meEaWnoGeEekh3l6/udh12D0VOdCXq7gmRhkKOqsditM/vShQTa
	pnk1+WcXuCpkPwcJh0M+Okzjs3TL/6oxz8ZE3CZ1K/Xjh4w/QoBfzXDTlz0aOZW6
	GEeskS6eDFatiXHE4FHzN5q2Z+KPefhqXiEkMXGcRPAplaWMFnz+A==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c19f6ptbv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Feb 2026 12:48:40 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 615AaSuf009544;
	Thu, 5 Feb 2026 12:48:38 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4c1vey9vq2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Feb 2026 12:48:38 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 615CmYXw50201086
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 5 Feb 2026 12:48:34 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9CB1120043;
	Thu,  5 Feb 2026 12:48:34 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 94F6520040;
	Thu,  5 Feb 2026 12:48:32 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.in.ibm.com (unknown [9.109.198.179])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  5 Feb 2026 12:48:32 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
        hare@suse.de, dwagner@suse.de, wenxiong@linux.ibm.com, gjoyce@ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCHv2 5/7] nvme: export I/O failure count when no path is available via sysfs
Date: Thu,  5 Feb 2026 18:18:04 +0530
Message-ID: <20260205124810.682559-6-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260205124810.682559-1-nilay@linux.ibm.com>
References: <20260205124810.682559-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _E7RI9WvyKFHZqHrvUDldE8XvVB9CAIk
X-Authority-Analysis: v=2.4 cv=drTWylg4 c=1 sm=1 tr=0 ts=698491a8 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=HzLeVaNsDn8A:10 a=sWKEhP36mHoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=6zb8lMvYnNi-4QC_6R8A:9
X-Proofpoint-ORIG-GUID: _E7RI9WvyKFHZqHrvUDldE8XvVB9CAIk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDA5MiBTYWx0ZWRfX+0j9A//YsG9H
 oHAbDychTckKAlzoLowiWUBZUCX3YhoVHFUmHS9e1GCb4bCe2bj55sm7epuLuGWKSNWBrO3vJQ6
 tCD0UWDB5r3xLNIyHtZREhgp+1iS8978pOJHWy87yfJrgzcz1mhKNt9fwS6BxNnP/lVlPxSBN9t
 iImRi32P5wyVcjcyP1UOwWZ81fIw4r0faBksKR5Eq3L9UkPJyYMnqUhKLNJ9R6cyq657d5U/NE9
 av9HZDyAh4j8giGSWuPBwgIrlvYBGfV8GF6BoirqD9BIxCTmZAs2BNriubqhaLC5zp0OncXF1hp
 IQaclkouieWS4QkS2taErqNQPffZHviJFFSf5S0KooFt7rawHvJDzZMitkEG1ZS23uRyNUx4Ds2
 corJPlod1t3sYjXhf/HEXSVa6mNgrji2TS3tUb89vnG5gXV5A1GdDQM2lbdrrkNufRC3xlyrCu7
 KLCn8+uwhR2wvpmf26Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_02,2026-02-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 spamscore=0 malwarescore=0 bulkscore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2602050092
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260205_044845_187608_E00FBDF8 
X-CRM114-Status: GOOD (  19.54  )
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

When I/O is submitted to the NVMe namespace head and no available path
can handle the request, the driver fails the I/O immediately. Currently,
such failures are only reported via kernel log messages, which may be
lost over time since dmesg is a circular buffer.

Add a new sysfs counter, fail_no_available_path, to expose the number of
I/Os that failed due to the absence of an available path. This provides
persistent visibility into path-related I/O failures and can help users
diagnose the cause of I/O errors.

This counter can also be consumed by monitoring tools such as nvme-top.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/multipath.c | 12 ++++++++++++
 drivers/nvme/host/nvme.h      |  2 ++
 drivers/nvme/host/sysfs.c     |  5 +++++
 3 files changed, 19 insertions(+)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index e0bfbc659963..9984221bcec0 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -545,6 +545,8 @@ static void nvme_ns_head_submit_bio(struct bio *bio)
 		dev_warn_ratelimited(dev, "no available path - failing I/O\n");
 
 		bio_io_error(bio);
+		head->fail_no_available_path =
+				size_add(head->fail_no_available_path, 1);
 	}
 
 	srcu_read_unlock(&head->srcu, srcu_idx);
@@ -1190,6 +1192,16 @@ static ssize_t requeue_no_usable_path_show(struct device *dev,
 }
 DEVICE_ATTR_RO(requeue_no_usable_path);
 
+static ssize_t fail_no_available_path_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct gendisk *disk = dev_to_disk(dev);
+	struct nvme_ns_head *head = disk->private_data;
+
+	return sysfs_emit(buf, "%lu\n", head->fail_no_available_path);
+}
+DEVICE_ATTR_RO(fail_no_available_path);
+
 static int nvme_lookup_ana_group_desc(struct nvme_ctrl *ctrl,
 		struct nvme_ana_group_desc *desc, void *data)
 {
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 39e5b5c7885b..b1ce2857899a 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -509,6 +509,7 @@ struct nvme_ns_head {
 	struct delayed_work	remove_work;
 	unsigned int		delayed_removal_secs;
 	size_t			requeue_no_usable_path;
+	size_t			fail_no_available_path;
 #define NVME_NSHEAD_DISK_LIVE		0
 #define NVME_NSHEAD_QUEUE_IF_NO_PATH	1
 	struct nvme_ns __rcu	*current_path[];
@@ -1006,6 +1007,7 @@ extern struct device_attribute dev_attr_numa_nodes;
 extern struct device_attribute dev_attr_delayed_removal_secs;
 extern struct device_attribute dev_attr_multipath_failover_count;
 extern struct device_attribute dev_attr_requeue_no_usable_path;
+extern struct device_attribute dev_attr_fail_no_available_path;
 extern struct device_attribute subsys_attr_iopolicy;
 
 static inline bool nvme_disk_is_ns_head(struct gendisk *disk)
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index a6b8539074ee..c1e2b93f7ae8 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -283,6 +283,7 @@ static struct attribute *nvme_ns_attrs[] = {
 	&dev_attr_delayed_removal_secs.attr,
 	&dev_attr_multipath_failover_count.attr,
 	&dev_attr_requeue_no_usable_path.attr,
+	&dev_attr_fail_no_available_path.attr,
 #endif
 	&dev_attr_io_passthru_err_log_enabled.attr,
 	&dev_attr_command_retries.attr,
@@ -345,6 +346,10 @@ static umode_t nvme_ns_attrs_are_visible(struct kobject *kobj,
 		if (!nvme_disk_is_ns_head(dev_to_disk(dev)))
 			return 0;
 	}
+	if (a == &dev_attr_fail_no_available_path.attr) {
+		if (!nvme_disk_is_ns_head(dev_to_disk(dev)))
+			return 0;
+	}
 #endif
 	return a->mode;
 }
-- 
2.52.0



Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE0D6E6BF30
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Jan 2026 18:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bvOsRrPBXI3AHIg+aHHHPvaBx9a6L2ABw3zogevfK6g=; b=4bV+KC6aQiAcN2hKmhFvDvTsb/
	sXSnPb86+NvEL84OHdb+1JR4yWSHAm0cLww8wfk0/QNuKJdussSbYFcbaPLQdY5R/uQV7YwJudhS0
	os4/HbZTM5vAMssUps7/MigmHxdGNANL3n3T+QY66C7kXErjr6fhIpVq7nG93YIT3tJYWFa/03IG5
	ORBP6iqzsiVQCrucwbzT82ARuic4eKpvEzkrRWP0/RZBxL+DjVrKZAm4yB2f1yYj3yxyp5I7LlG7I
	IcxHQGCQ37EJEmLX3z3EAEzIxK9SiiK7emlruKtGL/BrfsP4isizE9A0rccNf53jT+cJX0YRUuLIZ
	N6cZYkrg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlt7M-00000001p3R-46uo;
	Fri, 30 Jan 2026 18:21:16 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlt7K-00000001p1y-15we
	for linux-nvme@lists.infradead.org;
	Fri, 30 Jan 2026 18:21:15 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60UHLEcG029943;
	Fri, 30 Jan 2026 18:21:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=bvOsRrPBXI3AHIg+a
	HHHPvaBx9a6L2ABw3zogevfK6g=; b=H1hfaSKeBHffSK9nTAe9ODYu3yobyisla
	Y5XFkNM9lc9JYmb82MQJHi5GUT8ANTTbj/sRjMO4aKL7S1CEamU17fUuxl+BVNOA
	XCGKCF6BIN2prHfSTYiUpcNL4WxgoOffe6ltDAG5j3/SGB7qT3l+Vl03nExIUzOR
	D49Vc4Eq3fCmoaiteOYC+MsB7YA28jKAe1hS5Sr2oMRDVhlYBBmJzsMcx199CONR
	xDXGSbgtBv4r5j9exdgyjZXRSuxVJy08tV5IcD3F34LACDNPArCrClqMqR7TZEA7
	XxLF/IP25iysI5nWGfZxzsEfCawNN54mV5wusrJI/QjsqB8jyF5+g==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvnt87d7y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Jan 2026 18:21:07 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60UFoQlo031024;
	Fri, 30 Jan 2026 18:21:07 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bw8dsyd26-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Jan 2026 18:21:06 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60UIL3SC45613486
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Jan 2026 18:21:03 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5FE5D20043;
	Fri, 30 Jan 2026 18:21:03 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9268C20040;
	Fri, 30 Jan 2026 18:20:59 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.87.154.17])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 30 Jan 2026 18:20:59 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
        hare@suse.de, dwagner@suse.de, wenxiong@linux.ibm.com, gjoyce@ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH 4/7] nvme: export I/O requeue count when no path is available via sysfs
Date: Fri, 30 Jan 2026 23:50:21 +0530
Message-ID: <20260130182028.885089-5-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260130182028.885089-1-nilay@linux.ibm.com>
References: <20260130182028.885089-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: yLd9zbpUIDkKCphlLpvCOBD0OlW8UPDJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMwMDE1MCBTYWx0ZWRfXxIIpWUjDCCMY
 ZqNlUiS2CQrnrbz0UxGtPTndSSjxvkkrQTDpK70XQMsIhc5dAqYtQyJseIbl3ucwVKIbSPx4r8G
 NoKmsS/izRPL/kDUIqk9bM394J6jmjsqGdpASFvQD6cuPliqUY5ztskHHJNJveKHN5uXEmUqq5l
 BN7GiHkR2D3Kw3mtHzwRr/CPJHGiRPHpL+lrjKyTbCgwni5oK4+P92r0mzdzzTBAo0Hxa+OE0jR
 qS3gTeg3CNoZkQVI7ddT9dp6pNXuu03D1TWDP7aFQtfm4ydfsZUKUP0ISe+QUHV9JcarZ3PGZd9
 X2EzOYf0ekaRKIk7DnWIiWF0eveX3kH9zhB6Y/uYJzvZ2afKJEgTsDeSx8pK5BKBxCCjD4hqPgG
 LdWgPB8wMKfIV5FlfZusFIl5dD6MG6/bdCNUuwQFsFb6qspqJvzve28MY/C+MDC2ohdxa2acL+B
 0CNB4G1Svc08ID1BklQ==
X-Authority-Analysis: v=2.4 cv=Zs3g6t7G c=1 sm=1 tr=0 ts=697cf693 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=vUbySO9Y5rIA:10 a=sWKEhP36mHoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=OdKbmu6maCxnhc5y6U8A:9
X-Proofpoint-ORIG-GUID: yLd9zbpUIDkKCphlLpvCOBD0OlW8UPDJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-30_02,2026-01-30_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 phishscore=0 suspectscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2601300150
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260130_102114_325023_28A3E1F2 
X-CRM114-Status: GOOD (  18.18  )
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

When the NVMe namespace head determines that there is no currently
available path to handle I/O (for example, while a controller is
resetting/connecting or due to a transient link failure), incoming
I/Os are added to the requeue list.

Currently, there is no visibility into how many I/Os have been requeued
in this situation. Add a new sysfs counter, requeue_no_available_path,
to expose the number of I/Os that were requeued due to the absence of
an available path.

This statistic can help users understand I/O slowdowns or stalls caused
by temporary path unavailability, and can be consumed by monitoring
tools such as nvme-top for real-time observability.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/multipath.c | 11 +++++++++++
 drivers/nvme/host/nvme.h      |  2 ++
 drivers/nvme/host/sysfs.c     |  5 +++++
 3 files changed, 18 insertions(+)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 366b820e654a..4e5f8523ca40 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -539,6 +539,7 @@ static void nvme_ns_head_submit_bio(struct bio *bio)
 		spin_lock_irq(&head->requeue_lock);
 		bio_list_add(&head->requeue_list, bio);
 		spin_unlock_irq(&head->requeue_lock);
+		head->requeue_no_usable_path++;
 	} else {
 		dev_warn_ratelimited(dev, "no available path - failing I/O\n");
 
@@ -1178,6 +1179,16 @@ static ssize_t multipath_failover_count_show(struct device *dev,
 }
 DEVICE_ATTR_RO(multipath_failover_count);
 
+static ssize_t requeue_no_usable_path_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct gendisk *disk = dev_to_disk(dev);
+	struct nvme_ns_head *head = disk->private_data;
+
+	return sysfs_emit(buf, "%llu\n", head->requeue_no_usable_path);
+}
+DEVICE_ATTR_RO(requeue_no_usable_path);
+
 static int nvme_lookup_ana_group_desc(struct nvme_ctrl *ctrl,
 		struct nvme_ana_group_desc *desc, void *data)
 {
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index b7e46bdd2d59..5836e4c557a2 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -509,6 +509,7 @@ struct nvme_ns_head {
 	unsigned long		flags;
 	struct delayed_work	remove_work;
 	unsigned int		delayed_removal_secs;
+	u64			requeue_no_usable_path;
 #define NVME_NSHEAD_DISK_LIVE		0
 #define NVME_NSHEAD_QUEUE_IF_NO_PATH	1
 	struct nvme_ns __rcu	*current_path[];
@@ -1005,6 +1006,7 @@ extern struct device_attribute dev_attr_queue_depth;
 extern struct device_attribute dev_attr_numa_nodes;
 extern struct device_attribute dev_attr_delayed_removal_secs;
 extern struct device_attribute dev_attr_multipath_failover_count;
+extern struct device_attribute dev_attr_requeue_no_usable_path;
 extern struct device_attribute subsys_attr_iopolicy;
 
 static inline bool nvme_disk_is_ns_head(struct gendisk *disk)
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 41218fa5081f..84d33445a578 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -284,6 +284,7 @@ static struct attribute *nvme_ns_attrs[] = {
 	&dev_attr_numa_nodes.attr,
 	&dev_attr_delayed_removal_secs.attr,
 	&dev_attr_multipath_failover_count.attr,
+	&dev_attr_requeue_no_usable_path.attr,
 #endif
 	&dev_attr_io_passthru_err_log_enabled.attr,
 	&dev_attr_io_command_retries.attr,
@@ -344,6 +345,10 @@ static umode_t nvme_ns_attrs_are_visible(struct kobject *kobj,
 		if (nvme_disk_is_ns_head(dev_to_disk(dev)))
 			return 0;
 	}
+	if (a == &dev_attr_requeue_no_usable_path.attr) {
+		if (!nvme_disk_is_ns_head(dev_to_disk(dev)))
+			return 0;
+	}
 #endif
 	return a->mode;
 }
-- 
2.52.0



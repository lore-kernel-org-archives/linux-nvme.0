Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E249CCD4F4A
	for <linux-nvme@archiver.kernel.org>; Sat, 16 May 2026 18:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=O+y2ZCUX2d6jDLR4gTX9q2ecLgvoyRbkFMmjzVolxMA=; b=pG2ct9CG1HgXzfUlg57K+Zo+G3
	v1wP15gy8xpnJ7IV27bLPGkPOF/97tqmxMssc8jwvz82BZG0+XclCX5VbknG5njbQWKQ+CQ9MyXIf
	tgu33cDKFujcqTATAMrTSfH/DMJB38ybeXvW5IZ6+eI9antYvc6yUR4dmnCQHWIgwfbRww4A4BCcS
	i6EaU7S+DeG946t1XKyFfO7qag3gKkdYU4RmK1SgXuIb3zE55R4rkZHkSAVsXpop00qM8VJAEkEhZ
	JEZpSENAxn7ZXHcXa6fi1du7ocT15DXXbLYl/t9y2tyMzioGZDLRSyPtq6ok5PEMF+IW5Kyg71zo/
	QJcEAK4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOJte-0000000BDvS-1EzH;
	Sat, 16 May 2026 18:37:58 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOJtc-0000000BDrx-1gq4
	for linux-nvme@lists.infradead.org;
	Sat, 16 May 2026 18:37:57 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64G9viKv1518027;
	Sat, 16 May 2026 18:37:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=O+y2ZCUX2d6jDLR4g
	TX9q2ecLgvoyRbkFMmjzVolxMA=; b=Ix1iwzCm23kfGZPmH0EzGp+MsBrUHetGK
	feXuA2BtO38r2UwKBKh5Buf01y//Zh5+7zFvRHdb50WqGaST6YBUv3INwhkZGVGR
	cPzjoX70ioaXsAnP4pJZJ/iyAvjE/y4/3ATTiSBVVfDClOC+t4/wgZjarqM+Ty0e
	0jJv01BJnazA/cSRycly3XEbr3AfK9HC8xB3DM5mzwO2cm8vpyT+mocYvr0IbUAs
	tcpWnS+uReRnM0NQGQWiXLOCIBlNdfZtJcIkrq54DbmlvzvigjMvtMz2UK0PA1RY
	sNTcYe1ntI1s8FDBGbFz44MjWgD3hNfP8xNCSYbqMEKw3bLhcFtrw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6hb81rdr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 May 2026 18:37:51 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64GIOHsW003302;
	Sat, 16 May 2026 18:37:50 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e5kvcrsj7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 May 2026 18:37:50 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64GIbk6N30474752
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 16 May 2026 18:37:46 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8BFA620040;
	Sat, 16 May 2026 18:37:46 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A091420043;
	Sat, 16 May 2026 18:37:42 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.111.59.249])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 16 May 2026 18:37:42 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, hare@suse.com, kbusch@kernel.org, hch@lst.de,
        sagi@grimberg.me, axboe@kernel.dk, chaitanyak@nvidia.com,
        venkat88@linux.ibm.com, gjoyce@linux.ibm.com, wenxiong@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCHv4 5/8] nvme: export I/O requeue count when no path is usable via sysfs
Date: Sun, 17 May 2026 00:06:52 +0530
Message-ID: <20260516183709.269937-6-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260516183709.269937-1-nilay@linux.ibm.com>
References: <20260516183709.269937-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE2MDE4NiBTYWx0ZWRfX9pQh8oezDsJ2
 q999ovtVftdkpcsjB0FB3+oybBovrLFyzaqpbX66REmu3wwfZR30UmBoSU82OuMghtdyDxjqMm9
 PUDpzk6KGPQe45oldar3PGa+PgecUVlDa/M9jKmBzNvWnKRTvVEwpDbRTGqEeitdzR9LHph7nRL
 BXmuBtSnA1hEgMQQEGAiKXooNebuZUdHhe3mmcD4nQqoYvlVOIN6WO4sMzfQwJbyiQ6uHeXD2eH
 iDU+aaKmFThJJmRZwjQQfBdKsLvENtMzr/VVNXBZ/gyIwbT69+vAx1h3xQo1FT/JsEuM5lJDoX9
 D6cCQz6VrB8B8HXcPIhOlbeKu/n5TXZIs2lMSouX5vO4f7yZsJ07bsnkCf6lqGFh3b5Pc8xRzIH
 Q2UFFyeQby35lZ/8ErXzUqcZB4gfdnPqVBEfQywMIWYp7VXmPzGpn/T8yTnEKz7QCZfjrjGJ9b1
 YcLgTt8yZCq5+EI+iYw==
X-Proofpoint-GUID: RuiCS1FCMAnjJFf5mV8atDzqYpvGZhwh
X-Proofpoint-ORIG-GUID: RuiCS1FCMAnjJFf5mV8atDzqYpvGZhwh
X-Authority-Analysis: v=2.4 cv=aYBRWxot c=1 sm=1 tr=0 ts=6a08b97f cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=N8iKQp9KpBaqfCmgdWYA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-16_02,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605160186
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260516_113756_596686_AA843515 
X-CRM114-Status: GOOD (  17.10  )
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
in this situation. Add a new ns-head sysfs counter
io_requeue_no_usable_path_count, under diag attribute group to expose
the number of I/Os that were requeued due to the absence of an available
path. This counter is also writable thus allowing user to reset it, if
needed.

This statistic can help users understand I/O slowdowns or stalls caused
by temporary path unavailability, and can be consumed by monitoring
tools such as nvme-top for real-time observability.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/multipath.c | 30 ++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h      |  2 ++
 drivers/nvme/host/sysfs.c     |  5 +++++
 3 files changed, 37 insertions(+)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 032595502165..f72a687daa8f 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -522,6 +522,7 @@ static void nvme_ns_head_submit_bio(struct bio *bio)
 		spin_lock_irq(&head->requeue_lock);
 		bio_list_add(&head->requeue_list, bio);
 		spin_unlock_irq(&head->requeue_lock);
+		atomic_long_inc(&head->io_requeue_no_usable_path_count);
 	} else {
 		dev_warn_ratelimited(dev, "no available path - failing I/O\n");
 
@@ -1178,6 +1179,35 @@ static ssize_t multipath_failover_count_store(struct device *dev,
 
 DEVICE_ATTR_RW(multipath_failover_count);
 
+static ssize_t io_requeue_no_usable_path_count_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct gendisk *disk = dev_to_disk(dev);
+	struct nvme_ns_head *head = disk->private_data;
+
+	return sysfs_emit(buf, "%lu\n",
+		    atomic_long_read(&head->io_requeue_no_usable_path_count));
+}
+
+static ssize_t io_requeue_no_usable_path_count_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	int err;
+	unsigned long requeue_cnt;
+	struct gendisk *disk = dev_to_disk(dev);
+	struct nvme_ns_head *head = disk->private_data;
+
+	err = kstrtoul(buf, 0, &requeue_cnt);
+	if (err)
+		return -EINVAL;
+
+	atomic_long_set(&head->io_requeue_no_usable_path_count, requeue_cnt);
+
+	return count;
+}
+
+DEVICE_ATTR_RW(io_requeue_no_usable_path_count);
+
 static int nvme_lookup_ana_group_desc(struct nvme_ctrl *ctrl,
 		struct nvme_ana_group_desc *desc, void *data)
 {
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index b83d702dbb92..845e338449ce 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -564,6 +564,7 @@ struct nvme_ns_head {
 	unsigned long		flags;
 	struct delayed_work	remove_work;
 	unsigned int		delayed_removal_secs;
+	atomic_long_t		io_requeue_no_usable_path_count;
 #define NVME_NSHEAD_DISK_LIVE		0
 #define NVME_NSHEAD_QUEUE_IF_NO_PATH	1
 	struct nvme_ns __rcu	*current_path[];
@@ -1067,6 +1068,7 @@ extern struct device_attribute dev_attr_queue_depth;
 extern struct device_attribute dev_attr_numa_nodes;
 extern struct device_attribute dev_attr_delayed_removal_secs;
 extern struct device_attribute dev_attr_multipath_failover_count;
+extern struct device_attribute dev_attr_io_requeue_no_usable_path_count;
 extern struct device_attribute subsys_attr_iopolicy;
 
 static inline bool nvme_disk_is_ns_head(struct gendisk *disk)
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 789518f21f40..9fe3a74b2bef 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -410,6 +410,7 @@ static struct attribute *nvme_ns_diag_attrs[] = {
 	&dev_attr_io_errors.attr,
 #ifdef CONFIG_NVME_MULTIPATH
 	&dev_attr_multipath_failover_count.attr,
+	&dev_attr_io_requeue_no_usable_path_count.attr,
 #endif
 	NULL,
 };
@@ -434,6 +435,10 @@ static umode_t nvme_ns_diag_attrs_are_visible(struct kobject *kobj,
 		if (nvme_disk_is_ns_head(dev_to_disk(dev)))
 			return 0;
 	}
+	if (a == &dev_attr_io_requeue_no_usable_path_count.attr) {
+		if (!nvme_disk_is_ns_head(dev_to_disk(dev)))
+			return 0;
+	}
 #endif
 	return a->mode;
 }
-- 
2.53.0



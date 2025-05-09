Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39C24C3ABBC
	for <linux-nvme@archiver.kernel.org>; Fri,  9 May 2025 20:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vtD2mnjy/G9g6L6fZs1DxVwWNGOwkj1zheS6eYeI4wQ=; b=Bqg3ZeMlrPjiq7mvgd13mmIiea
	UPyLyzbjyD1DHD9GQ16g5tSNlu4NPgmhEC2B2WslbYpS6hTJLqDjCNBG26L5IQA08cWMjX3tOl5ku
	1gIxUuZ8yhmCP3KKy7T0c7YfufYo2rtp9GRUdfr7RA9YsGHOZ4fVfso2UOEwZugVoU2k5istEPFH5
	jc7pYfPgPIMBwVkHUzVfRcGgQqsjw6INUHL4ALhl6tdFXXwU7y/Ej3/ETMhDyYEkDcFJNDzOrflKc
	YqAvcOpHDlGWLaYwFUE+L43mzFkwfPn/lGMZRN8KNedcXKN3eSVgkdVOZgYCWBI/HzyyInzYkVsfy
	AqJ9yJfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDUJe-00000004oWc-0YNM;
	Fri, 09 May 2025 20:27:30 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDRtT-00000004Unh-2kvu
	for linux-nvme@lists.infradead.org;
	Fri, 09 May 2025 17:52:21 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 549ENeHu029523;
	Fri, 9 May 2025 17:52:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=vtD2mnjy/G9g6L6fZ
	s1DxVwWNGOwkj1zheS6eYeI4wQ=; b=WI3fm8TYM5w+sIrqo8cbXsnCCAMls4w74
	W18U2uVKsrHlGWsbulUuvX5dNf7uOjTjHcV+q4M2AFZU+DQUiyZQW0Xckfmp/yKr
	KtES9TxIHDj72dDibtHSKXp7Y8JchjSjLvqjkVpQatsLhwzwTvE/LRk0NNwd0Grn
	qSg51Sgx2cSBDkAfo2wtEkzzsgBUf7ujPX97W4WUfVWh5kMtLV9Yq0+3WZEINOw9
	mu08B3eof/QRCzrIMSyPyYKKk4oLlomMIi+3Ex1tjXSwtbIzyu59MqHAAErPmC7+
	f4TfTcgbZesf8HHeta6uU16pm/ub8K8HOtlCbP+XnkWS9tNcaX2FQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46h6k0myu8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 May 2025 17:52:12 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 549FL1ou001324;
	Fri, 9 May 2025 17:52:12 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 46dwftvwe0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 May 2025 17:52:11 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 549HqAoa60162394
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 9 May 2025 17:52:10 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3B2E42013C;
	Fri,  9 May 2025 17:52:10 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 24E7A200C5;
	Fri,  9 May 2025 17:52:06 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.67.130.163])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  9 May 2025 17:52:05 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, hare@suse.de, kbusch@kernel.org, sagi@grimberg.me,
        jmeneghi@redhat.com, axboe@kernel.dk, martin.petersen@oracle.com,
        gjoyce@ibm.com
Subject: [RFC PATCHv4 1/3] nvme-multipath: introduce delayed removal of the multipath head node
Date: Fri,  9 May 2025 23:21:48 +0530
Message-ID: <20250509175158.2753396-2-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250509175158.2753396-1-nilay@linux.ibm.com>
References: <20250509175158.2753396-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: f89tvcKipl4fZck2Wn-iuHea3nZ4PPWE
X-Proofpoint-ORIG-GUID: f89tvcKipl4fZck2Wn-iuHea3nZ4PPWE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA5MDE3NSBTYWx0ZWRfX6ABDenNUZn4S pM4bxoTg8/cyh7LZdAJKeMMrJTPVZIKiBZ59P7D9z2vvXSvx7wqsFD6IZ4tDhTdG8DjZDvQHKGx r0CyZ8A75an5ZxDUBB++iKV6hLjkcqXaVj2blLczdhN4TBSfMROqIEiid443kEPke5JQZs+qo0J
 YgbhIDn1hmvfBv24bLFaxselk4VKRpt6Dmw8O6CMoVbokqUFY2oDwLoseE8zD7zFNWGNSIhYRJ7 jcC+099kwQqDtgs0OTtRLyxiVWCzXPHH3cF77zBCb4AhPU91l/c11mCfK3niF4fqJekVC4Eg8su xgxIq1SFAVKvgNDKbaly7t4dm4roFIs40J5va8frc3HaBxKGHisUop/PhLQsO5Mu7e9MEylTQY9
 iA42rrxYRMRVNnhSVhWhWtyV+X1hnfp9htjUVuIbhxRuidSWxGJ1ykfEUeKSrjnrpxRp4AT+
X-Authority-Analysis: v=2.4 cv=OcCYDgTY c=1 sm=1 tr=0 ts=681e40cc cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8 a=9r6QK0OtAAAA:8 a=VnNF1IyMAAAA:8 a=xef1Py_XYEMHfdka8lQA:9
 a=1CNFftbPRP8L7MoqJWF3:22 a=TxIH8fH_K59pr5-VUUuU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-09_06,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 clxscore=1015 mlxscore=0 priorityscore=1501 adultscore=0
 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505090175
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250509_105219_821408_04F7A7A5 
X-CRM114-Status: GOOD (  32.51  )
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

Currently, the multipath head node of an NVMe disk is removed
immediately as soon as all paths of the disk are removed. However,
this can cause issues in scenarios where:

- The disk hot-removal followed by re-addition.
- Transient PCIe link failures that trigger re-enumeration,
  temporarily removing and then restoring the disk.

In these cases, removing the head node prematurely may lead to a head
disk node name change upon re-addition, requiring applications to
reopen their handles if they were performing I/O during the failure.

To address this, introduce a delayed removal mechanism of head disk
node. During transient failure, instead of immediate removal of head
disk node, the system waits for a configurable timeout, allowing the
disk to recover.

During transient disk failure, if application sends any IO then we
queue it instead of failing such IO immediately. If the disk comes back
online within the timeout, the queued IOs are resubmitted to the disk
ensuring seamless operation. In case disk couldn't recover from the
failure then queued IOs are failed to its completion and application
receives the error.

So this way, if disk comes back online within the configured period,
the head node remains unchanged, ensuring uninterrupted workloads
without requiring applications to reopen device handles.

A new sysfs attribute, named "delayed_removal_secs" is added under head
disk blkdev for user who wish to configure time for the delayed removal
of head disk node. The default value of this attribute is set to zero
second ensuring no behavior change unless explicitly configured.

Link: https://lore.kernel.org/linux-nvme/Y9oGTKCFlOscbPc2@infradead.org/
Link: https://lore.kernel.org/linux-nvme/Y+1aKcQgbskA2tra@kbusch-mbp.dhcp.thefacebook.com/
Suggested-by: Keith Busch <kbusch@kernel.org>
Suggested-by: Christoph Hellwig <hch@infradead.org>
[nilay: reworked based on the original idea/POC from Christoph and Keith]
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/core.c      |   8 ++-
 drivers/nvme/host/multipath.c | 130 +++++++++++++++++++++++++++++++---
 drivers/nvme/host/nvme.h      |  16 ++++-
 drivers/nvme/host/sysfs.c     |   7 ++
 4 files changed, 147 insertions(+), 14 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index a8444d1e8398..0b7139d0ea9f 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3743,7 +3743,7 @@ static struct nvme_ns_head *nvme_find_ns_head(struct nvme_ctrl *ctrl,
 		 */
 		if (h->ns_id != nsid || !nvme_is_unique_nsid(ctrl, h))
 			continue;
-		if (!list_empty(&h->list) && nvme_tryget_ns_head(h))
+		if (nvme_tryget_ns_head(h))
 			return h;
 	}
 
@@ -3987,7 +3987,8 @@ static int nvme_init_ns_head(struct nvme_ns *ns, struct nvme_ns_info *info)
 		}
 	} else {
 		ret = -EINVAL;
-		if (!info->is_shared || !head->shared) {
+		if ((!info->is_shared || !head->shared) &&
+		    !list_empty(&head->list)) {
 			dev_err(ctrl->device,
 				"Duplicate unshared namespace %d\n",
 				info->nsid);
@@ -4191,7 +4192,8 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 	mutex_lock(&ns->ctrl->subsys->lock);
 	list_del_rcu(&ns->siblings);
 	if (list_empty(&ns->head->list)) {
-		list_del_init(&ns->head->entry);
+		if (!nvme_mpath_queue_if_no_path(ns->head))
+			list_del_init(&ns->head->entry);
 		last_path = true;
 	}
 	mutex_unlock(&ns->ctrl->subsys->lock);
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 250f3da67cc9..2db326d6114f 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -442,7 +442,17 @@ static bool nvme_available_path(struct nvme_ns_head *head)
 			break;
 		}
 	}
-	return false;
+
+	/*
+	 * If "head->delayed_removal_secs" is configured (i.e., non-zero), do
+	 * not immediately fail I/O. Instead, requeue the I/O for the configured
+	 * duration, anticipating that if there's a transient link failure then
+	 * it may recover within this time window. This parameter is exported to
+	 * userspace via sysfs, and its default value is zero. It is internally
+	 * mapped to NVME_NSHEAD_QUEUE_IF_NO_PATH. When delayed_removal_secs is
+	 * non-zero, this flag is set to true. When zero, the flag is cleared.
+	 */
+	return nvme_mpath_queue_if_no_path(head);
 }
 
 static void nvme_ns_head_submit_bio(struct bio *bio)
@@ -617,6 +627,40 @@ static void nvme_requeue_work(struct work_struct *work)
 	}
 }
 
+static void nvme_remove_head(struct nvme_ns_head *head)
+{
+	if (test_and_clear_bit(NVME_NSHEAD_DISK_LIVE, &head->flags)) {
+		/*
+		 * requeue I/O after NVME_NSHEAD_DISK_LIVE has been cleared
+		 * to allow multipath to fail all I/O.
+		 */
+		kblockd_schedule_work(&head->requeue_work);
+
+		nvme_cdev_del(&head->cdev, &head->cdev_device);
+		synchronize_srcu(&head->srcu);
+		del_gendisk(head->disk);
+		nvme_put_ns_head(head);
+	}
+}
+
+static void nvme_remove_head_work(struct work_struct *work)
+{
+	struct nvme_ns_head *head = container_of(to_delayed_work(work),
+			struct nvme_ns_head, remove_work);
+	bool shutdown = false;
+
+	mutex_lock(&head->subsys->lock);
+	if (list_empty(&head->list)) {
+		list_del_init(&head->entry);
+		shutdown = true;
+	}
+	mutex_unlock(&head->subsys->lock);
+	if (shutdown)
+		nvme_remove_head(head);
+
+	module_put(THIS_MODULE);
+}
+
 int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
 {
 	struct queue_limits lim;
@@ -626,6 +670,8 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
 	spin_lock_init(&head->requeue_lock);
 	INIT_WORK(&head->requeue_work, nvme_requeue_work);
 	INIT_WORK(&head->partition_scan_work, nvme_partition_scan_work);
+	INIT_DELAYED_WORK(&head->remove_work, nvme_remove_head_work);
+	head->delayed_removal_secs = 0;
 
 	/*
 	 * Add a multipath node if the subsystems supports multiple controllers.
@@ -659,6 +705,7 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
 	set_bit(GD_SUPPRESS_PART_SCAN, &head->disk->state);
 	sprintf(head->disk->disk_name, "nvme%dn%d",
 			ctrl->subsys->instance, head->instance);
+	nvme_tryget_ns_head(head);
 	return 0;
 }
 
@@ -1015,6 +1062,49 @@ static ssize_t numa_nodes_show(struct device *dev, struct device_attribute *attr
 }
 DEVICE_ATTR_RO(numa_nodes);
 
+static ssize_t delayed_removal_secs_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct gendisk *disk = dev_to_disk(dev);
+	struct nvme_ns_head *head = disk->private_data;
+	int ret;
+
+	mutex_lock(&head->subsys->lock);
+	ret = sysfs_emit(buf, "%u\n", head->delayed_removal_secs);
+	mutex_unlock(&head->subsys->lock);
+	return ret;
+}
+
+static ssize_t delayed_removal_secs_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct gendisk *disk = dev_to_disk(dev);
+	struct nvme_ns_head *head = disk->private_data;
+	unsigned int sec;
+	int ret;
+
+	ret = kstrtouint(buf, 0, &sec);
+	if (ret < 0)
+		return ret;
+
+	mutex_lock(&head->subsys->lock);
+	head->delayed_removal_secs = sec;
+	if (sec)
+		set_bit(NVME_NSHEAD_QUEUE_IF_NO_PATH, &head->flags);
+	else
+		clear_bit(NVME_NSHEAD_QUEUE_IF_NO_PATH, &head->flags);
+	mutex_unlock(&head->subsys->lock);
+	/*
+	 * Ensure that update to NVME_NSHEAD_QUEUE_IF_NO_PATH is seen
+	 * by its reader.
+	 */
+	synchronize_srcu(&head->srcu);
+
+	return count;
+}
+
+DEVICE_ATTR_RW(delayed_removal_secs);
+
 static int nvme_lookup_ana_group_desc(struct nvme_ctrl *ctrl,
 		struct nvme_ana_group_desc *desc, void *data)
 {
@@ -1138,18 +1228,38 @@ void nvme_mpath_add_disk(struct nvme_ns *ns, __le32 anagrpid)
 
 void nvme_mpath_shutdown_disk(struct nvme_ns_head *head)
 {
-	if (!head->disk)
-		return;
-	if (test_and_clear_bit(NVME_NSHEAD_DISK_LIVE, &head->flags)) {
-		nvme_cdev_del(&head->cdev, &head->cdev_device);
+	bool shutdown = false;
+
+	mutex_lock(&head->subsys->lock);
+	/*
+	 * We are called when all paths have been removed, and at that point
+	 * head->list is expected to be empty. However, nvme_remove_ns() and
+	 * nvme_init_ns_head() can run concurrently and so if head->delayed_
+	 * removal_secs is configured, it is possible that by the time we reach
+	 * this point, head->list may no longer be empty. Therefore, we recheck
+	 * head->list here. If it is no longer empty then we skip enqueuing the
+	 * delayed head removal work.
+	 */
+	if (!list_empty(&head->list))
+		goto out;
+
+	if (head->delayed_removal_secs) {
 		/*
-		 * requeue I/O after NVME_NSHEAD_DISK_LIVE has been cleared
-		 * to allow multipath to fail all I/O.
+		 * Ensure that no one could remove this module while the head
+		 * remove work is pending.
 		 */
-		synchronize_srcu(&head->srcu);
-		kblockd_schedule_work(&head->requeue_work);
-		del_gendisk(head->disk);
+		if (!try_module_get(THIS_MODULE))
+			goto out;
+		queue_delayed_work(nvme_wq, &head->remove_work,
+				head->delayed_removal_secs * HZ);
+	} else {
+		list_del_init(&head->entry);
+		shutdown = true;
 	}
+out:
+	mutex_unlock(&head->subsys->lock);
+	if (shutdown)
+		nvme_remove_head(head);
 }
 
 void nvme_mpath_remove_disk(struct nvme_ns_head *head)
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 7aad581271c7..f20076f6f06a 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -506,7 +506,10 @@ struct nvme_ns_head {
 	struct work_struct	partition_scan_work;
 	struct mutex		lock;
 	unsigned long		flags;
-#define NVME_NSHEAD_DISK_LIVE	0
+	struct delayed_work	remove_work;
+	unsigned int		delayed_removal_secs;
+#define NVME_NSHEAD_DISK_LIVE		0
+#define NVME_NSHEAD_QUEUE_IF_NO_PATH	1
 	struct nvme_ns __rcu	*current_path[];
 #endif
 };
@@ -989,12 +992,19 @@ extern struct device_attribute dev_attr_ana_grpid;
 extern struct device_attribute dev_attr_ana_state;
 extern struct device_attribute dev_attr_queue_depth;
 extern struct device_attribute dev_attr_numa_nodes;
+extern struct device_attribute dev_attr_delayed_removal_secs;
 extern struct device_attribute subsys_attr_iopolicy;
 
 static inline bool nvme_disk_is_ns_head(struct gendisk *disk)
 {
 	return disk->fops == &nvme_ns_head_ops;
 }
+static inline bool nvme_mpath_queue_if_no_path(struct nvme_ns_head *head)
+{
+	if (test_bit(NVME_NSHEAD_QUEUE_IF_NO_PATH, &head->flags))
+		return true;
+	return false;
+}
 #else
 #define multipath false
 static inline bool nvme_ctrl_use_ana(struct nvme_ctrl *ctrl)
@@ -1082,6 +1092,10 @@ static inline bool nvme_disk_is_ns_head(struct gendisk *disk)
 {
 	return false;
 }
+static inline bool nvme_mpath_queue_if_no_path(struct nvme_ns_head *head)
+{
+	return false;
+}
 #endif /* CONFIG_NVME_MULTIPATH */
 
 int nvme_ns_get_unique_id(struct nvme_ns *ns, u8 id[16],
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 6d31226f7a4f..a48d30c31d51 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -260,6 +260,7 @@ static struct attribute *nvme_ns_attrs[] = {
 	&dev_attr_ana_state.attr,
 	&dev_attr_queue_depth.attr,
 	&dev_attr_numa_nodes.attr,
+	&dev_attr_delayed_removal_secs.attr,
 #endif
 	&dev_attr_io_passthru_err_log_enabled.attr,
 	NULL,
@@ -296,6 +297,12 @@ static umode_t nvme_ns_attrs_are_visible(struct kobject *kobj,
 		if (nvme_disk_is_ns_head(dev_to_disk(dev)))
 			return 0;
 	}
+	if (a == &dev_attr_delayed_removal_secs.attr) {
+		struct gendisk *disk = dev_to_disk(dev);
+
+		if (!nvme_disk_is_ns_head(disk))
+			return 0;
+	}
 #endif
 	return a->mode;
 }
-- 
2.49.0



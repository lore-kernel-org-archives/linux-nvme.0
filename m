Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C829C3ABDF
	for <linux-nvme@archiver.kernel.org>; Wed, 14 May 2025 13:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hOaDO5FwGQg82JmxoO0lqsaglW4Mk37ygR5HJhw6YDI=; b=KoyZ1/5MianJ7cIR0KQXO4RTHz
	kualET9rZZEO52LOCY8pjlBdPr4YnPrjCuJbt1Azg40/bOHTLYPbk897r+dO7UevPFbaRhnSg9Etx
	/Vse+Le+7IiAnMJpByraf6bfnE5o8ch3Hw6JbaXxSOsZQzi8hmywBVJlP/wXBp6YWueTsQGjFvJUn
	F9poQQgXMGQq9iL/zNZmuJb8omGiYzEOl8VMaS85djbr7XzCO8R3NK+6vpSfnpAKcchd51GtvJdgU
	fzfXA3ZZ6/X6NHcbuS6n3LJelm6SACbqLJJhcaOleDjT3NnLHaHVeVvBa/KzkVid8T9qjEGh0ypu4
	H/zK+ezg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFCZD-0000000FJZT-3sAB;
	Wed, 14 May 2025 13:54:39 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFBly-0000000F9gE-3C9O
	for linux-nvme@lists.infradead.org;
	Wed, 14 May 2025 13:03:48 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54E9F5EA012963;
	Wed, 14 May 2025 13:03:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=hOaDO5FwGQg82Jmxo
	O0lqsaglW4Mk37ygR5HJhw6YDI=; b=VxGOTIvbZ6kTbCSbWf1YstY0ajSelIzNE
	8F8bXCnm+vDpNGS/gFeeDNTCbQUJPRgBkWKZ67FkHtLWhfsW+M0uE8Dctjvlnc43
	HUmnld3eCEtLKi4HjXmWe5cv8zDMCAYu/OiU2pRO4fCbqYXRPzVZI9MWaw8wamI9
	AqNll+D3tsUvodVYvHUM8pT/l43QA3aF4jg38HB1qtk7BAZ0+jm5tE+MSb1cINPX
	a/PuGbwRU9nP+fVgljyzubCm5KAxTSPRhsofstWvXrVdkDsOljbz9ho+iEJrShkc
	dqPI+0/NXigZ+qj/rMCwl36dCv3VJA9C51zNpJ1Q+sZ4Q8jIRQTmw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46mrcj91tx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 May 2025 13:03:37 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54E9gL8N021828;
	Wed, 14 May 2025 13:03:36 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46mbfpm9d6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 May 2025 13:03:36 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54ED3YGn35062526
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 May 2025 13:03:34 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 66FC720040;
	Wed, 14 May 2025 13:03:34 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 673092004D;
	Wed, 14 May 2025 13:03:30 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.67.82.218])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 14 May 2025 13:03:30 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, hare@suse.de, kbusch@kernel.org, sagi@grimberg.me,
        jmeneghi@redhat.com, axboe@kernel.dk, martin.petersen@oracle.com,
        gjoyce@ibm.com
Subject: [RFC PATCHv5 1/3] nvme-multipath: introduce delayed removal of the multipath head node
Date: Wed, 14 May 2025 18:33:15 +0530
Message-ID: <20250514130322.393656-2-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250514130322.393656-1-nilay@linux.ibm.com>
References: <20250514130322.393656-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=ZYgdNtVA c=1 sm=1 tr=0 ts=682494a9 cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8 a=9r6QK0OtAAAA:8 a=VnNF1IyMAAAA:8 a=xef1Py_XYEMHfdka8lQA:9
 a=1CNFftbPRP8L7MoqJWF3:22 a=TxIH8fH_K59pr5-VUUuU:22
X-Proofpoint-ORIG-GUID: ZV-V0cqHH44cCPUj1uJbSWvydrmRjy8b
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDExMSBTYWx0ZWRfXxo1zK+Xe8QyI Bfr4XvswPW/UOqa7TLkyZPLV5/QDofTj0+rnGkBJ1Kf+kOf9pELCzSVDXwRKjAeEmaXyJ3NzULf xu+5FeOv+QpTOwaCEHfLJBrKaj/nhgxth47aUKteTuZvvizNz9a5qOTjdlhecwgmE9aptGvjAN0
 fwcEXtMWQ26dM6P3bLvLyukC1HD4aMYEpeQ4WQYuPhLAgdfp0UrBtaOF633TJCRZeiHW4bP3uOz rzn/Yf4+K/Q7Poy/jBO3/KmqQ5QcsEi3PKaxoLPQy+iVmRGXFdPqwLOlGYaradUiSJrVz6E1qGN bg/McQV12wPsX/JEFcevzG8qHQ84gxmTryOjSJiqLn+KvZdmjz/rM5YgcRLk/mhKjp9ChaeZ0cw
 GSv9gGAb4Cg7Z+IpTLGvhpdjrsK5yaocsvgthJFw4RIb7VhNTqVC1iTSyOh3X1BcLDkumoU9
X-Proofpoint-GUID: ZV-V0cqHH44cCPUj1uJbSWvydrmRjy8b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_04,2025-05-14_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 mlxscore=0 spamscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505140111
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250514_060346_923885_E008595A 
X-CRM114-Status: GOOD (  31.99  )
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
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/core.c      |   8 ++-
 drivers/nvme/host/multipath.c | 130 +++++++++++++++++++++++++++++++---
 drivers/nvme/host/nvme.h      |  16 ++++-
 drivers/nvme/host/sysfs.c     |   7 ++
 4 files changed, 147 insertions(+), 14 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index af871d268fcb..6d11f8b19633 100644
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



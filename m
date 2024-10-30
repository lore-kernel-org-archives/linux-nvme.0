Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BF5ED5CC8E
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Oct 2024 10:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UkJxJhp5O9O99+VuxeH9eNQO4V54SHwU6OrlD4y68g4=; b=vDau042gbAQ4AfwZV1t+w+c86a
	zEs0trnCUKf6EqDMoK1fumfU0U0yTKkVPuYlNdY2i62aTPSfKfBC68cP3CGsufMDAVEI1U73s5wvl
	A0naVnku7QWhNtRZhWZ3sGFHizLSii6U5z612WuxKrm3mcpcigbLuGoUer3wy/UU2pXs2TGn/eJ2L
	H35UFmWIQk2D5O18hX4kEwtiSRz77KAe5zu2rxO75pOc+ylvDCBXTo2gIof7mm0w28kbMhirDHuin
	jy2QNV3AJ7Bi5WMGMAUp2+dHGOnUzZp0LfmBae0c6e338ItVOeYY3VN+SLpeKg8LxMmST9s+tv4P7
	6aqlwmvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t66Nn-000000002Ib-2cbO;
	Wed, 30 Oct 2024 10:56:59 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t669W-0000000Hakb-1vGw
	for linux-nvme@lists.infradead.org;
	Wed, 30 Oct 2024 10:42:15 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49U2d3Lr025618;
	Wed, 30 Oct 2024 10:42:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=UkJxJhp5O9O99+Vux
	eH9eNQO4V54SHwU6OrlD4y68g4=; b=d3XsVvdyMaaqR9HHPfZubCPW0KbnkxGfh
	UrfAoUlSEECly2ouAAyeOzpNEpogNpdJ9j+xozdDjkgMBhGfdlWNcjZwJscTL7xX
	b6EUtfUqQYE1Mxh1Ydn+xvfbaF7xbWhqRAzSSyFMncYmILqUiZUejqPsu2igHGir
	zdYQJcYPnYvR8Vh+v6Y2nuNE9DxBqLghK8XofPUCdzp8ltIG8jhbraB7rvLSra9s
	JAWmO5y2aI079wzEk4nnkpZfPEKWo8Y6XBl0+F/tLjFXiR4em5CMrdrb0f10aKmD
	cMhVTAB3PU5I8vnwKhWtI0StBXdVNyuaxGyzA7DIacmoSXCh+ADTA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42jb65j0km-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Oct 2024 10:42:06 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49U9r8OD015843;
	Wed, 30 Oct 2024 10:42:06 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 42hdf1f8yq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Oct 2024 10:42:06 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49UAg23K34472588
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Oct 2024 10:42:02 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 807FF2004B;
	Wed, 30 Oct 2024 10:42:02 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 834C62004E;
	Wed, 30 Oct 2024 10:42:00 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.171.67.17])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 30 Oct 2024 10:42:00 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, sagi@grimberg.me, hare@suse.de, kbusch@kernel.org,
        hch@lst.de, =axboe@fb.com, gjoyce@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCHv5 RFC 1/3] nvme-multipah: Add visibility for round-robin io-policy
Date: Wed, 30 Oct 2024 16:11:41 +0530
Message-ID: <20241030104156.747675-2-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241030104156.747675-1-nilay@linux.ibm.com>
References: <20241030104156.747675-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: _cQ2vZGrWYJk00MsitFr4EIfU7PdGyj-
X-Proofpoint-GUID: _cQ2vZGrWYJk00MsitFr4EIfU7PdGyj-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=999
 impostorscore=0 spamscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410300080
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241030_034214_648096_F71E9A97 
X-CRM114-Status: GOOD (  27.66  )
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

This patch helps add nvme native multipath visibility for round-robin
io-policy. It creates a "multipath" sysfs directory under head gendisk
device node directory and then from "multipath" directory it adds a link
to each namespace path device the head node refers.

For instance, if we have a shared namespace accessible from two different
controllers/paths then we create a soft link to each path device from head
disk node as shown below:

$ ls -l /sys/block/nvme1n1/multipath/
nvme1c1n1 -> ../../../../../pci052e:78/052e:78:00.0/nvme/nvme1/nvme1c1n1
nvme1c3n1 -> ../../../../../pci058e:78/058e:78:00.0/nvme/nvme3/nvme1c3n1

In the above example, nvme1n1 is head gendisk node created for a shared
namespace and the namespace is accessible from nvme1c1n1 and nvme1c3n1
paths.

For round-robin I/O policy, we could easily infer from the above output
that I/O workload targeted to nvme1n1 would toggle across paths nvme1c1n1
and nvme1c3n1.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/core.c      |  3 ++
 drivers/nvme/host/multipath.c | 81 +++++++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h      | 18 ++++++--
 drivers/nvme/host/sysfs.c     | 14 ++++++
 4 files changed, 112 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 84cb859a911d..c923bd2c5468 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3940,6 +3940,9 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 
 	if (!nvme_ns_head_multipath(ns->head))
 		nvme_cdev_del(&ns->cdev, &ns->cdev_device);
+
+	nvme_mpath_remove_sysfs_link(ns);
+
 	del_gendisk(ns->disk);
 
 	mutex_lock(&ns->ctrl->namespaces_lock);
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 6a15873055b9..43c87a946cc7 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -682,6 +682,8 @@ static void nvme_mpath_set_live(struct nvme_ns *ns)
 		kblockd_schedule_work(&head->partition_scan_work);
 	}
 
+	nvme_mpath_add_sysfs_link(ns->head);
+
 	mutex_lock(&head->lock);
 	if (nvme_path_is_optimized(ns)) {
 		int node, srcu_idx;
@@ -764,6 +766,25 @@ static void nvme_update_ns_ana_state(struct nvme_ana_group_desc *desc,
 	if (nvme_state_is_live(ns->ana_state) &&
 	    nvme_ctrl_state(ns->ctrl) == NVME_CTRL_LIVE)
 		nvme_mpath_set_live(ns);
+	else {
+		/*
+		 * Add sysfs link from multipath head gendisk node to path
+		 * device gendisk node.
+		 * If path's ana state is live (i.e. state is either optimized
+		 * or non-optimized) while we alloc the ns then sysfs link would
+		 * be created from nvme_mpath_set_live(). In that case we would
+		 * not fallthrough this code path. However for the path's ana
+		 * state other than live, we call nvme_mpath_set_live() only
+		 * after ana state transitioned to the live state. But we still
+		 * want to create the sysfs link from head node to a path device
+		 * irrespctive of the path's ana state.
+		 * If we reach through here then it means that path's ana state
+		 * is not live but still create the sysfs link to this path from
+		 * head node if head node of the path has already come alive.
+		 */
+		if (test_bit(NVME_NSHEAD_DISK_LIVE, &ns->head->flags))
+			nvme_mpath_add_sysfs_link(ns->head);
+	}
 }
 
 static int nvme_update_ana_state(struct nvme_ctrl *ctrl,
@@ -962,6 +983,66 @@ static int nvme_lookup_ana_group_desc(struct nvme_ctrl *ctrl,
 	return -ENXIO; /* just break out of the loop */
 }
 
+void nvme_mpath_add_sysfs_link(struct nvme_ns_head *head)
+{
+	struct device *target;
+	int rc, srcu_idx;
+	struct nvme_ns *ns;
+	struct kobject *kobj = &disk_to_dev(head->disk)->kobj;
+
+	/*
+	 * loop through each ns chained through the head->list and create the
+	 * sysfs link from head node to the ns path node
+	 */
+	srcu_idx = srcu_read_lock(&head->srcu);
+
+	list_for_each_entry_rcu(ns, &head->list, siblings) {
+		/*
+		 * Avoid creating link if it already exists for the given path.
+		 * When path ana state transitions from optimized to non-
+		 * optimized or vice-versa, the nvme_mpath_set_live() is
+		 * invoked which in truns call this function. Now if the sysfs
+		 * link already exists for the given path and we attempt to re-
+		 * create the link then sysfs code would warn about it loudly.
+		 * So we evaluate NVME_NS_SYSFS_ATTR_LINK flag here to ensure
+		 * that we're not creating duplicate link.
+		 */
+		if (test_bit(NVME_NS_SYSFS_ATTR_LINK, &ns->flags))
+			continue;
+
+		target = disk_to_dev(ns->disk);
+		/*
+		 * Create sysfs link from head gendisk kobject @kobj to the
+		 * ns path gendisk kobject @target->kobj.
+		 */
+		rc = sysfs_add_link_to_group(kobj, nvme_ns_mpath_attr_group.name,
+				&target->kobj, dev_name(target));
+		if (unlikely(rc)) {
+			dev_err(disk_to_dev(ns->head->disk),
+					"failed to create link to %s\n",
+					dev_name(target));
+		} else
+			set_bit(NVME_NS_SYSFS_ATTR_LINK, &ns->flags);
+	}
+
+	srcu_read_unlock(&head->srcu, srcu_idx);
+}
+
+void nvme_mpath_remove_sysfs_link(struct nvme_ns *ns)
+{
+	struct device *target;
+	struct kobject *kobj;
+
+	if (!test_bit(NVME_NS_SYSFS_ATTR_LINK, &ns->flags))
+		return;
+
+	target = disk_to_dev(ns->disk);
+	kobj = &disk_to_dev(ns->head->disk)->kobj;
+	sysfs_remove_link_from_group(kobj, nvme_ns_mpath_attr_group.name,
+			dev_name(target));
+	clear_bit(NVME_NS_SYSFS_ATTR_LINK, &ns->flags);
+}
+
 void nvme_mpath_add_disk(struct nvme_ns *ns, __le32 anagrpid)
 {
 	if (nvme_ctrl_use_ana(ns->ctrl)) {
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 093cb423f536..ff234bce58ef 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -528,10 +528,11 @@ struct nvme_ns {
 	struct nvme_ns_head *head;
 
 	unsigned long flags;
-#define NVME_NS_REMOVING	0
-#define NVME_NS_ANA_PENDING	2
-#define NVME_NS_FORCE_RO	3
-#define NVME_NS_READY		4
+#define NVME_NS_REMOVING		0
+#define NVME_NS_ANA_PENDING		2
+#define NVME_NS_FORCE_RO		3
+#define NVME_NS_READY			4
+#define NVME_NS_SYSFS_ATTR_LINK	5
 
 	struct cdev		cdev;
 	struct device		cdev_device;
@@ -927,6 +928,7 @@ int nvme_getgeo(struct block_device *bdev, struct hd_geometry *geo);
 int nvme_dev_uring_cmd(struct io_uring_cmd *ioucmd, unsigned int issue_flags);
 
 extern const struct attribute_group *nvme_ns_attr_groups[];
+extern const struct attribute_group nvme_ns_mpath_attr_group;
 extern const struct pr_ops nvme_pr_ops;
 extern const struct block_device_operations nvme_ns_head_ops;
 extern const struct attribute_group nvme_dev_attrs_group;
@@ -949,6 +951,8 @@ void nvme_mpath_default_iopolicy(struct nvme_subsystem *subsys);
 void nvme_failover_req(struct request *req);
 void nvme_kick_requeue_lists(struct nvme_ctrl *ctrl);
 int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl,struct nvme_ns_head *head);
+void nvme_mpath_add_sysfs_link(struct nvme_ns_head *ns);
+void nvme_mpath_remove_sysfs_link(struct nvme_ns *ns);
 void nvme_mpath_add_disk(struct nvme_ns *ns, __le32 anagrpid);
 void nvme_mpath_remove_disk(struct nvme_ns_head *head);
 int nvme_mpath_init_identify(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id);
@@ -1003,6 +1007,12 @@ static inline void nvme_mpath_add_disk(struct nvme_ns *ns, __le32 anagrpid)
 static inline void nvme_mpath_remove_disk(struct nvme_ns_head *head)
 {
 }
+static inline void nvme_mpath_add_sysfs_link(struct nvme_ns *ns)
+{
+}
+static inline void nvme_mpath_remove_sysfs_link(struct nvme_ns *ns)
+{
+}
 static inline bool nvme_mpath_clear_current_path(struct nvme_ns *ns)
 {
 	return false;
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index b68a9e5f1ea3..5a23e23b0d01 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -299,8 +299,22 @@ static const struct attribute_group nvme_ns_attr_group = {
 	.is_visible	= nvme_ns_attrs_are_visible,
 };
 
+#ifdef CONFIG_NVME_MULTIPATH
+static struct attribute *nvme_ns_mpath_attrs[] = {
+	NULL,
+};
+
+const struct attribute_group nvme_ns_mpath_attr_group = {
+	.name           = "multipath",
+	.attrs		= nvme_ns_mpath_attrs,
+};
+#endif
+
 const struct attribute_group *nvme_ns_attr_groups[] = {
 	&nvme_ns_attr_group,
+#ifdef CONFIG_NVME_MULTIPATH
+	&nvme_ns_mpath_attr_group,
+#endif
 	NULL,
 };
 
-- 
2.45.2



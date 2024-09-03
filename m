Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 691FDCD3436
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Sep 2024 13:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6juB5fvie7J7EBZQ11UI5cVoDkIqL1lSw74p5Lii1JA=; b=Ngvad5MSl68BBo4OMJgdL4Cwcs
	uBhKT4o6/SO98AMfwfCynVy/AdiXKE06KIHHBwn5NNZY9ut7L2dE8MGduvl0+c9+Z9I3xYADi9XwL
	O8VfGYqZrapBywfjUxll3npqhx0wfocHW97pNtrI/ScmQTI2nNSyjIOa5QqEFaQexHb7II5ByiCpN
	rtyexKMC19j4OVSHZtNFC8EeGqdFjJPJ5dujGa8xARkilafZrNSx901LDtXO+l7ftnK7w2W5aNVSo
	iEoqZ76tMnCnZblZV9sNoodlHpLA3vDAdHYEmOYx9oH4dM23/D1RiGyDl3ndOiojlBlAi48KroDaP
	Cl/oiDiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slTxp-00000000Qig-3ePc;
	Tue, 03 Sep 2024 13:52:57 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slTxm-00000000Qhn-3yE1
	for linux-nvme@lists.infradead.org;
	Tue, 03 Sep 2024 13:52:56 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 483BmxLB032345;
	Tue, 3 Sep 2024 13:52:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=6juB5fvie7J7E
	BZQ11UI5cVoDkIqL1lSw74p5Lii1JA=; b=HuojRDm8rtGtJEvGMQbJfcEXjTnfw
	CCF0m3QYxyCtUNdNVW3XlP9QGfmfjFnvjnsrjahmCLtq6iQDTYNKen8Fp21KgoWb
	h2giYBxNKczGr48ka//6IlgOA/jzY9NaTpha/z7EiV8KkARl7ylOYjL6czS+tGvx
	fRkXyWAUrFcMKvLH8II5fzkNJibMLsXgdN5xrkfSOpzJ31oIFB8GGd7TeanBLV7g
	uXj036FStiAkgJT6w3MtL2VbQVwtNEW5kAjbwdbpHdrUfSuql2VESa1QxB+3hoB+
	DA6RaFcCtMxhgtwoTdKfsyN2mchs7Nqr5gVrbU96Rlgu/KGEK9oJlXJeg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41btuwx0rt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Sep 2024 13:52:42 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 483ATKY8000854;
	Tue, 3 Sep 2024 13:52:41 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 41cdguk7sb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Sep 2024 13:52:41 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 483DqcKq50201002
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 3 Sep 2024 13:52:38 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0ED9E2004D;
	Tue,  3 Sep 2024 13:52:38 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1AF4820040;
	Tue,  3 Sep 2024 13:52:36 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.179.29.238])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  3 Sep 2024 13:52:35 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, hch@lst.de, kbusch@kernel.org, sagi@grimberg.me,
        axboe@fb.com, gjoyce@linux.ibm.com, Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCHv3 RFC 1/1] nvme-multipath: Add sysfs attributes for showing multipath info
Date: Tue,  3 Sep 2024 19:22:19 +0530
Message-ID: <20240903135228.283820-2-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240903135228.283820-1-nilay@linux.ibm.com>
References: <20240903135228.283820-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: crJV7YsDLJHyLFnKPYNyVSvK-UWhe3i6
X-Proofpoint-ORIG-GUID: crJV7YsDLJHyLFnKPYNyVSvK-UWhe3i6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-03_01,2024-09-03_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 mlxlogscore=999 mlxscore=0 priorityscore=1501 adultscore=0 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2409030110
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240903_065255_021993_FA3F9906 
X-CRM114-Status: GOOD (  25.10  )
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

NVMe native multipath supports different IO policies for selecting I/O
path, however we don't have any visibility about which path is being
selected by multipath code for forwarding I/O.
This patch helps add that visibility by adding new sysfs attribute files
named "numa_nodes" and "queue_depth" under each namespace block device
path /sys/block/nvmeXcYnZ/. We also create a "multipath" sysfs directory
under head disk node and then from this directory add a link to each
namespace path device this head disk node points to.

For instance, /sys/block/nvmeXnY/multipath/ would create a soft link to
each path the head disk node <nvmeXnY> points to:

$ ls -1 /sys/block/nvme1n1/
nvme1c1n1 -> ../../../../../pci052e:78/052e:78:00.0/nvme/nvme1/nvme1c1n1
nvme1c3n1 -> ../../../../../pci058e:78/058e:78:00.0/nvme/nvme3/nvme1c3n1

For round-robin I/O policy, we could easily infer from the above output
that I/O workload targeted to nvme3n1 would toggle across paths nvme1c1n1
and nvme1c3n1.

For numa I/O policy, the "numa_nodes" attribute file shows the numa nodes
being preferred by the respective block device path. The numa nodes value
is comma delimited list of nodes or A-B range of nodes.

For queue-depth I/O policy, the "queue_depth" attribute file shows the
number of active/in-flight I/O requests currently queued for each path.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/core.c      |  3 ++
 drivers/nvme/host/multipath.c | 69 +++++++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h      | 20 ++++++++--
 drivers/nvme/host/sysfs.c     | 20 ++++++++++
 4 files changed, 108 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 0dc8bcc664f2..e48a317d70b6 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3951,6 +3951,9 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 
 	if (!nvme_ns_head_multipath(ns->head))
 		nvme_cdev_del(&ns->cdev, &ns->cdev_device);
+
+	nvme_mpath_remove_sysfs_link(ns);
+
 	del_gendisk(ns->disk);
 
 	mutex_lock(&ns->ctrl->namespaces_lock);
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 91d9eb3c22ef..00e30adbe382 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -652,6 +652,8 @@ static void nvme_mpath_set_live(struct nvme_ns *ns)
 		nvme_add_ns_head_cdev(head);
 	}
 
+	nvme_mpath_add_sysfs_link(ns);
+
 	mutex_lock(&head->lock);
 	if (nvme_path_is_optimized(ns)) {
 		int node, srcu_idx;
@@ -920,6 +922,37 @@ static ssize_t ana_state_show(struct device *dev, struct device_attribute *attr,
 }
 DEVICE_ATTR_RO(ana_state);
 
+static ssize_t queue_depth_show(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	struct nvme_ns *ns = nvme_get_ns_from_dev(dev);
+
+	return sysfs_emit(buf, "%d\n", atomic_read(&ns->ctrl->nr_active));
+}
+DEVICE_ATTR_RO(queue_depth);
+
+static ssize_t numa_nodes_show(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	int node;
+	nodemask_t numa_nodes;
+	struct nvme_ns *current_ns;
+	struct nvme_ns *ns = nvme_get_ns_from_dev(dev);
+	struct nvme_ns_head *head = ns->head;
+
+	nodes_clear(numa_nodes);
+
+	for_each_node(node) {
+		current_ns = srcu_dereference(head->current_path[node],
+				&head->srcu);
+		if (ns == current_ns)
+			node_set(node, numa_nodes);
+	}
+
+	return sysfs_emit(buf, "%*pbl\n", nodemask_pr_args(&numa_nodes));
+}
+DEVICE_ATTR_RO(numa_nodes);
+
 static int nvme_lookup_ana_group_desc(struct nvme_ctrl *ctrl,
 		struct nvme_ana_group_desc *desc, void *data)
 {
@@ -932,6 +965,42 @@ static int nvme_lookup_ana_group_desc(struct nvme_ctrl *ctrl,
 	return -ENXIO; /* just break out of the loop */
 }
 
+void nvme_mpath_add_sysfs_link(struct nvme_ns *ns)
+{
+	struct device *target;
+	struct kobject *kobj;
+	int rc;
+
+	if (test_bit(NVME_NS_SYSFS_ATTR_LINK, &ns->flags))
+		return;
+
+	target = disk_to_dev(ns->disk);
+	kobj = &disk_to_dev(ns->head->disk)->kobj;
+	rc = sysfs_add_link_to_group(kobj, nvme_ns_mpath_attr_group.name,
+			&target->kobj, dev_name(target));
+	if (unlikely(rc)) {
+		dev_err(disk_to_dev(ns->head->disk),
+				"failed to create link to %s\n",
+				dev_name(target));
+	} else
+		set_bit(NVME_NS_SYSFS_ATTR_LINK, &ns->flags);
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
index da57947130cc..dfd3b23bcc6f 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -522,10 +522,11 @@ struct nvme_ns {
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
@@ -921,6 +922,7 @@ int nvme_getgeo(struct block_device *bdev, struct hd_geometry *geo);
 int nvme_dev_uring_cmd(struct io_uring_cmd *ioucmd, unsigned int issue_flags);
 
 extern const struct attribute_group *nvme_ns_attr_groups[];
+extern const struct attribute_group nvme_ns_mpath_attr_group;
 extern const struct pr_ops nvme_pr_ops;
 extern const struct block_device_operations nvme_ns_head_ops;
 extern const struct attribute_group nvme_dev_attrs_group;
@@ -943,6 +945,8 @@ void nvme_mpath_default_iopolicy(struct nvme_subsystem *subsys);
 void nvme_failover_req(struct request *req);
 void nvme_kick_requeue_lists(struct nvme_ctrl *ctrl);
 int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl,struct nvme_ns_head *head);
+void nvme_mpath_add_sysfs_link(struct nvme_ns *ns);
+void nvme_mpath_remove_sysfs_link(struct nvme_ns *ns);
 void nvme_mpath_add_disk(struct nvme_ns *ns, __le32 anagrpid);
 void nvme_mpath_remove_disk(struct nvme_ns_head *head);
 int nvme_mpath_init_identify(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id);
@@ -968,6 +972,8 @@ static inline void nvme_trace_bio_complete(struct request *req)
 extern bool multipath;
 extern struct device_attribute dev_attr_ana_grpid;
 extern struct device_attribute dev_attr_ana_state;
+extern struct device_attribute dev_attr_queue_depth;
+extern struct device_attribute dev_attr_numa_nodes;
 extern struct device_attribute subsys_attr_iopolicy;
 
 static inline bool nvme_disk_is_ns_head(struct gendisk *disk)
@@ -997,6 +1003,12 @@ static inline void nvme_mpath_add_disk(struct nvme_ns *ns, __le32 anagrpid)
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
index ba05faaac562..92bcdd4f6072 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -258,6 +258,8 @@ static struct attribute *nvme_ns_attrs[] = {
 #ifdef CONFIG_NVME_MULTIPATH
 	&dev_attr_ana_grpid.attr,
 	&dev_attr_ana_state.attr,
+	&dev_attr_queue_depth.attr,
+	&dev_attr_numa_nodes.attr,
 #endif
 	&dev_attr_io_passthru_err_log_enabled.attr,
 	NULL,
@@ -290,6 +292,10 @@ static umode_t nvme_ns_attrs_are_visible(struct kobject *kobj,
 		if (!nvme_ctrl_use_ana(nvme_get_ns_from_dev(dev)->ctrl))
 			return 0;
 	}
+	if (a == &dev_attr_queue_depth.attr || a == &dev_attr_numa_nodes.attr) {
+		if (nvme_disk_is_ns_head(dev_to_disk(dev)))
+			return 0;
+	}
 #endif
 	return a->mode;
 }
@@ -299,8 +305,22 @@ static const struct attribute_group nvme_ns_attr_group = {
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



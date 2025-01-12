Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1A9AE77188
	for <linux-nvme@archiver.kernel.org>; Sun, 12 Jan 2025 12:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fHsCavdLSoIDOZfNhNX6GsB6f0RcqI81Q2NuoQq5X5M=; b=QiKRLG/o/gvYYEDrtPglsQGNQ/
	BhTUovMVDJh8t41+udK/cHAw78lxfk6GZ94vy+yMV0ddB8jZcuw9Y3vaJjB6UVdMZGownRrBvUYwm
	LvKKiyHHV99NW4y4fDyPyQeSoT1f7sbxyRCcV24e70V1es40Ju8OAId29FEc8149f997bV1u36VdZ
	0542gKB21G3ILmJLNUwqo2sGVdw2fGXM7er/eFo+gBLDKqAGS9CaJPXcZxPWu2tiNbKr+duow0XLV
	qGS5VqzbgwKltxerxzYVYatsolHl3G9KsLfstZRYFrGpwN/gBjzo8tvsL5nPZrjr3e7/aZ0j3MOGW
	Yznosh/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tWxJ0-00000002h10-48xo;
	Sun, 12 Jan 2025 12:43:02 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tWxIE-00000002gq8-20zM
	for linux-nvme@lists.infradead.org;
	Sun, 12 Jan 2025 12:42:16 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50CCH19T012339;
	Sun, 12 Jan 2025 12:42:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=fHsCavdLSoIDOZfNh
	NX6GsB6f0RcqI81Q2NuoQq5X5M=; b=hBXy2EV/NampJ0nl2vpjYwMXtjUoxWd6z
	erqoBOlPzJT4gs/xSf55sAls0Ye3oKB3u/skpPNvQj2embBMEDky93gz1xV7Lte2
	vRBmFNrQ3GgWjPsVpXOUQCMQULAfXPpnXh+5Vsh6/oV7qgTgnKbkGimKKvIUDwq6
	0nUDBvAcx9TQa47N9bc3dNmn66ZRf3OlAa2iUMQqQdcteXxxBdgvujaaDD0umN5B
	pspQo6gp3hcAYOMaERm0Wpm+FNAh0Xwgy1tdLKJzb3Q+WHXYTnrIEaAxo0/XeCyG
	9Vwsph5BaAG/gLDB4hj0FDtH70tBdZUEXhcI4E2+UGmZLedJwbqAg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44467h939k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 12 Jan 2025 12:42:03 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50CBSHQT002666;
	Sun, 12 Jan 2025 12:42:01 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4443bxswm6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 12 Jan 2025 12:42:01 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50CCfxDR38535576
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 12 Jan 2025 12:41:59 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C80DA20043;
	Sun, 12 Jan 2025 12:41:59 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D4ADF20040;
	Sun, 12 Jan 2025 12:41:57 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.171.76.196])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 12 Jan 2025 12:41:57 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, sagi@grimberg.me, hch@lst.de, dwagner@suse.de,
        hare@suse.de, chaitanyak@nvidia.com, axboe@fb.com,
        gjoyce@linux.ibm.com
Subject: [PATCHv7 RFC 1/3] nvme-multipath: Add visibility for round-robin io-policy
Date: Sun, 12 Jan 2025 18:11:44 +0530
Message-ID: <20250112124154.60690-2-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250112124154.60690-1-nilay@linux.ibm.com>
References: <20250112124154.60690-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: VYvm-zyQMYp5XSP05qhpbSIs1Yixq9KI
X-Proofpoint-ORIG-GUID: VYvm-zyQMYp5XSP05qhpbSIs1Yixq9KI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 mlxscore=0 spamscore=0
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501120111
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250112_044214_543425_5A942E1D 
X-CRM114-Status: GOOD (  28.82  )
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
 drivers/nvme/host/multipath.c | 99 +++++++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h      | 18 +++++--
 drivers/nvme/host/sysfs.c     | 14 +++++
 4 files changed, 130 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index a970168a3014..f1aa4aa41d17 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3982,6 +3982,9 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 
 	if (!nvme_ns_head_multipath(ns->head))
 		nvme_cdev_del(&ns->cdev, &ns->cdev_device);
+
+	nvme_mpath_remove_sysfs_link(ns);
+
 	del_gendisk(ns->disk);
 
 	mutex_lock(&ns->ctrl->namespaces_lock);
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index a85d190942bd..eccc26616e38 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -686,6 +686,8 @@ static void nvme_mpath_set_live(struct nvme_ns *ns)
 		kblockd_schedule_work(&head->partition_scan_work);
 	}
 
+	nvme_mpath_add_sysfs_link(ns->head);
+
 	mutex_lock(&head->lock);
 	if (nvme_path_is_optimized(ns)) {
 		int node, srcu_idx;
@@ -768,6 +770,25 @@ static void nvme_update_ns_ana_state(struct nvme_ana_group_desc *desc,
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
@@ -967,6 +988,84 @@ static int nvme_lookup_ana_group_desc(struct nvme_ctrl *ctrl,
 	return -ENXIO; /* just break out of the loop */
 }
 
+void nvme_mpath_add_sysfs_link(struct nvme_ns_head *head)
+{
+	struct device *target;
+	int rc, srcu_idx;
+	struct nvme_ns *ns;
+	struct kobject *kobj;
+
+	/*
+	 * Ensure head disk node is already added otherwise we may get invalid
+	 * kobj for head disk node
+	 */
+	if (!test_bit(GD_ADDED, &head->disk->state))
+		return;
+
+	kobj = &disk_to_dev(head->disk)->kobj;
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
+		 * The test_and_set_bit() is used because it is protecting
+		 * against multiple nvme paths being simultaneously added.
+		 */
+		if (test_and_set_bit(NVME_NS_SYSFS_ATTR_LINK, &ns->flags))
+			continue;
+
+		/*
+		 * Ensure that ns path disk node is already added otherwise we
+		 * may get invalid kobj name for target
+		 */
+		if (!test_bit(GD_ADDED, &ns->disk->state))
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
+			clear_bit(NVME_NS_SYSFS_ATTR_LINK, &ns->flags);
+		}
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
index c4bb8dfe1a45..643bf580bd09 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -534,10 +534,11 @@ struct nvme_ns {
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
@@ -933,6 +934,7 @@ int nvme_getgeo(struct block_device *bdev, struct hd_geometry *geo);
 int nvme_dev_uring_cmd(struct io_uring_cmd *ioucmd, unsigned int issue_flags);
 
 extern const struct attribute_group *nvme_ns_attr_groups[];
+extern const struct attribute_group nvme_ns_mpath_attr_group;
 extern const struct pr_ops nvme_pr_ops;
 extern const struct block_device_operations nvme_ns_head_ops;
 extern const struct attribute_group nvme_dev_attrs_group;
@@ -955,6 +957,8 @@ void nvme_mpath_default_iopolicy(struct nvme_subsystem *subsys);
 void nvme_failover_req(struct request *req);
 void nvme_kick_requeue_lists(struct nvme_ctrl *ctrl);
 int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl,struct nvme_ns_head *head);
+void nvme_mpath_add_sysfs_link(struct nvme_ns_head *ns);
+void nvme_mpath_remove_sysfs_link(struct nvme_ns *ns);
 void nvme_mpath_add_disk(struct nvme_ns *ns, __le32 anagrpid);
 void nvme_mpath_remove_disk(struct nvme_ns_head *head);
 int nvme_mpath_init_identify(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id);
@@ -1009,6 +1013,12 @@ static inline void nvme_mpath_add_disk(struct nvme_ns *ns, __le32 anagrpid)
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
2.47.1



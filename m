Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C270AC3DA5D
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Jul 2024 09:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bgO9191JP/4vbSOiiQhDUI4Jhx0puEZaqVyOjCpTOcs=; b=fM+Y9ao3C/H50b4bTvWZvTKKBl
	7CERyuVpdbgXbe3HG2B1XZ9yasLpX3l9daUNhGK7xfX5XWuunE/w8B+Q3cppzCe7KHP+S2dr1gKGT
	ksiMSDXpCL7TlYk74a/+5IS8UKnKXqsquu8IiNUHZmiJdaxoXerG0ICh+eIE2uugEENFc+5o/qofn
	7zIXZzKQGrGRvoV6YUc82XRVN+b7ddo6KmJ82B4C3ABEMaKUptGOLTgJnjZej4Cww9x0udnlfWPXH
	spAlVpvK41ZDzke40CaSeVMBxNEbeLfP+LFqSma3+tXLh9Veu1LZ5s2GNTVB4cbYoSwXd9tIlP+lU
	VA0+UF7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sVpOl-000000093GH-1lET;
	Mon, 22 Jul 2024 09:32:03 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sVpOh-000000093FU-3PNI
	for linux-nvme@lists.infradead.org;
	Mon, 22 Jul 2024 09:32:01 +0000
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46M9Qpvw028340;
	Mon, 22 Jul 2024 09:31:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=bgO9191JP/4vb
	SOiiQhDUI4Jhx0puEZaqVyOjCpTOcs=; b=jZMD6dya/JGb3Bae/GKUlvqR8fk/m
	ckc2+xRK0ikirlE/3+sgmJSV2RfZiXANOAsPHYvaTLX+9/NNBci5aaKI6YO07yN+
	4FLD+cUnkEiAoSd97jDZ9wXRjtOvKUtdHzdhC+YbMgWq6FzbA3jPfLv1TboiE0lQ
	lzYwO3523GD5TcaqKlCJi4eAMEAKQb/hZxLNcgWEq11KsdacP7ZIsEMwRhmqarRV
	iErwUgcsyudLrrjquHdRX9dxcLzHw0KE1UOM22zecL0bpcXiU4o3PjygeZeS/tfo
	EZVVAxBvMb0hUvboIslMINTWmCBebFTgw7ZgyZbrIt11awU8JNwFgc9Kw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40grpsthga-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jul 2024 09:31:44 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46M8JYJ8009115;
	Mon, 22 Jul 2024 09:31:43 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 40gt935gbj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jul 2024 09:31:43 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46M9Vcua56164786
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Jul 2024 09:31:40 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E4A082004B;
	Mon, 22 Jul 2024 09:31:37 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 15AA620071;
	Mon, 22 Jul 2024 09:31:36 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.in.ibm.com (unknown [9.109.198.253])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 22 Jul 2024 09:31:35 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com,
        gjoyce@linux.ibm.com, Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH RFC 1/1] nvme-multipath: Add debugfs entry for showing multipath info
Date: Mon, 22 Jul 2024 15:01:10 +0530
Message-ID: <20240722093124.42581-3-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240722093124.42581-1-nilay@linux.ibm.com>
References: <20240722093124.42581-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 2OInp_dWFwolM7WJgi0VPvp52bDuSdd_
X-Proofpoint-ORIG-GUID: 2OInp_dWFwolM7WJgi0VPvp52bDuSdd_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-22_05,2024-07-18_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 phishscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407220072
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240722_023200_188237_A46E0038 
X-CRM114-Status: GOOD (  20.14  )
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

NVMe native multipath supports different io policies for selecting 
I/O path, however, we don't have any visibility about which path is 
being selected by multipath code for forwarding I/O. This patch helps 
add that visibility by adding a debugfs file for each head disk node 
on the system. It creates a file named "multipath" under 
"/sys/kernel/debug/block/nvmeXnY/". This file shows the information 
about current selected "io-policy" as well as it prints a "table" 
showing information about each online node and it's respective I/O 
path, controller name, ana-state and optionally queue depth of each 
path (if selected io-policy is queue-depth).

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/multipath.c | 90 +++++++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h      |  1 +
 2 files changed, 91 insertions(+)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 91d9eb3c22ef..143d4b279b43 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -6,6 +6,7 @@
 #include <linux/backing-dev.h>
 #include <linux/moduleparam.h>
 #include <linux/vmalloc.h>
+#include <linux/debugfs.h>
 #include <trace/events/block.h>
 #include "nvme.h"
 
@@ -628,6 +629,91 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
 			ctrl->subsys->instance, head->instance);
 	return 0;
 }
+static void nvme_mpath_numa_show(struct seq_file *m, struct nvme_ns_head *head)
+{
+	int node;
+	struct nvme_ns *ns;
+
+	seq_printf(m, "%-4s  %-12s  %-6s  %s\n",
+			"node", "current-path", "ctrl", "ana-state");
+
+	for_each_online_node(node) {
+		ns = srcu_dereference(head->current_path[node], &head->srcu);
+		if (ns)
+			seq_printf(m, "%-4d  %-12s  %-6s  %s\n",
+					node, ns->disk->disk_name,
+					dev_name(ns->ctrl->device),
+					nvme_ana_state_names[ns->ana_state]);
+	}
+}
+
+static void nvme_mpath_rr_show(struct seq_file *m, struct nvme_ns_head *head)
+{
+	int node;
+	struct nvme_ns *ns;
+
+	seq_printf(m, "%-4s  %-12s  %-6s  %s\n",
+			"node", "rr-path", "ctrl", "ana-state");
+
+	for_each_online_node(node) {
+		list_for_each_entry_rcu(ns, &head->list, siblings) {
+			seq_printf(m, "%-4d  %-12s  %-6s  %s\n",
+					node, ns->disk->disk_name,
+					dev_name(ns->ctrl->device),
+					nvme_ana_state_names[ns->ana_state]);
+		}
+	}
+}
+
+static void nvme_mpath_qd_show(struct seq_file *m, struct nvme_ns_head *head)
+{
+	int node;
+	struct nvme_ns *ns;
+
+	seq_printf(m, "%-4s  %-12s  %-6s  %-10s  %s\n",
+			"node", "path", "ctrl", "qdepth", "ana-state");
+
+	for_each_online_node(node) {
+		list_for_each_entry_rcu(ns, &head->list, siblings) {
+			seq_printf(m, "%-4d  %-12s  %-6s  %-10d  %s\n",
+					node, ns->disk->disk_name,
+					dev_name(ns->ctrl->device),
+					atomic_read(&ns->ctrl->nr_active),
+					nvme_ana_state_names[ns->ana_state]);
+
+		}
+	}
+}
+
+static int nvme_mpath_show(struct seq_file *m, void *p)
+{
+	struct nvme_ns_head *head = m->private;
+	int iopolicy = READ_ONCE(head->subsys->iopolicy);
+
+	seq_printf(m, "io-policy: %s\n", nvme_iopolicy_names[iopolicy]);
+
+	seq_puts(m, "io-path:\n");
+	seq_puts(m, "--------\n");
+
+	if (iopolicy == NVME_IOPOLICY_NUMA)
+		nvme_mpath_numa_show(m, head);
+	else if (iopolicy == NVME_IOPOLICY_RR)
+		nvme_mpath_rr_show(m, head);
+	else if (iopolicy == NVME_IOPOLICY_QD)
+		nvme_mpath_qd_show(m, head);
+
+	return 0;
+}
+
+static int nvme_mpath_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, nvme_mpath_show, inode->i_private);
+}
+static const struct file_operations nvme_mpath_fops = {
+	.open = nvme_mpath_open,
+	.read = seq_read,
+	.release = single_release
+};
 
 static void nvme_mpath_set_live(struct nvme_ns *ns)
 {
@@ -650,6 +736,9 @@ static void nvme_mpath_set_live(struct nvme_ns *ns)
 			return;
 		}
 		nvme_add_ns_head_cdev(head);
+		head->debugfs = debugfs_create_file("multipath", 0400,
+					head->disk->queue->debugfs_dir, head,
+					&nvme_mpath_fops);
 	}
 
 	mutex_lock(&head->lock);
@@ -969,6 +1058,7 @@ void nvme_mpath_shutdown_disk(struct nvme_ns_head *head)
 		return;
 	kblockd_schedule_work(&head->requeue_work);
 	if (test_bit(NVME_NSHEAD_DISK_LIVE, &head->flags)) {
+		debugfs_remove(head->debugfs);
 		nvme_cdev_del(&head->cdev, &head->cdev_device);
 		del_gendisk(head->disk);
 	}
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index f900e44243ae..5b4c0b70cedf 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -493,6 +493,7 @@ struct nvme_ns_head {
 	struct work_struct	requeue_work;
 	struct mutex		lock;
 	unsigned long		flags;
+	struct dentry		*debugfs;
 #define NVME_NSHEAD_DISK_LIVE	0
 	struct nvme_ns __rcu	*current_path[];
 #endif
-- 
2.45.2



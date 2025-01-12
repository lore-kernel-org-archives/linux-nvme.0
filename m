Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD7E4E7719E
	for <linux-nvme@archiver.kernel.org>; Sun, 12 Jan 2025 12:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+RkbM6xn9qpZN1MPchNBvtvDmEXB0zWcy8cnXsZr5hM=; b=gjdxmoLddD39qOU7zcFNHTVpD5
	uUg3RtJ/nmq+La5+6317baqBw8Mrg/BqHmqFgBIsNcK/sFKDrKT6a37A2mwckh8ibQNxNCmQ/fdQi
	GF2w9vNSyF/4CeNuFHkazMZTV01JYK9ZCsJd7nHFHL9mNEtVqBP10+WVLfyIgAUNN1yugojalcLS/
	QsbNMDnHTegNCWyA2aXoEouvZSYQLR1XZomNdVun5DcOW8OxVn9NSRNnraVKFZBaktYZgKUWyelXa
	UyGMIZjYd6HyDqH3utz2rL6KUh6TY1yj7cmAEUIIwrPiciFiDrdCQqyDxYFjRh6/5Z2qdHkQ37swW
	WK1u6o2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tWxJ2-00000002h2H-1Ms5;
	Sun, 12 Jan 2025 12:43:04 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tWxIF-00000002grD-3SCW
	for linux-nvme@lists.infradead.org;
	Sun, 12 Jan 2025 12:42:17 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50C6Gda4005430;
	Sun, 12 Jan 2025 12:42:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=+RkbM6xn9qpZN1MPc
	hNBvtvDmEXB0zWcy8cnXsZr5hM=; b=Vsv5mJVCWzeu3Q/oVpsB6+aZqjC9YPdBk
	qtTE7P95bcBDW81AOTjEZGYbzBHvjyZlQP83J5ZFNmGr6WQ7DpIslGg47oHvisBS
	1kUX0+KjPLFBI0ywMy6nmtEDtih+hw63ae2WBa2NwVfuZnXn4AtpV9Vf8xu8VdUu
	sqkk2dTQn4aIg/kiaCn+22MaInumYRXIjZpVWFckl5HNX1OI5YlTWGvz5EqtZ+Hi
	0ZwWAICms5TNDD7d0SB97QYeBbOYZARHiuzx0wb9DfH1JzD86nLpZOfTFSDaIQjE
	r1Rz1XutIxI8MnfSjBUs3aFFBiEtMaf7apUub48+Nsp200XgSnXvg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44467h939m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 12 Jan 2025 12:42:05 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50CC6mdX007462;
	Sun, 12 Jan 2025 12:42:04 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4443ymssr2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 12 Jan 2025 12:42:03 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50CCg14F14549266
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 12 Jan 2025 12:42:02 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DEDBF20043;
	Sun, 12 Jan 2025 12:42:01 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1EFF420040;
	Sun, 12 Jan 2025 12:42:00 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.171.76.196])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 12 Jan 2025 12:41:59 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, sagi@grimberg.me, hch@lst.de, dwagner@suse.de,
        hare@suse.de, chaitanyak@nvidia.com, axboe@fb.com,
        gjoyce@linux.ibm.com
Subject: [PATCHv7 RFC 2/3] nvme-multipath: Add visibility for numa io-policy
Date: Sun, 12 Jan 2025 18:11:45 +0530
Message-ID: <20250112124154.60690-3-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250112124154.60690-1-nilay@linux.ibm.com>
References: <20250112124154.60690-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Phr71sH9E7C5QnWS4ilzgGIyWWw1ZpZo
X-Proofpoint-ORIG-GUID: Phr71sH9E7C5QnWS4ilzgGIyWWw1ZpZo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 mlxscore=0 spamscore=0
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501120111
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250112_044215_972984_94A1FE92 
X-CRM114-Status: GOOD (  19.48  )
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

This patch helps add nvme native multipath visibility for numa io-policy.
It adds a new attribute file named "numa_nodes" under namespace gendisk
device path node which prints the list of numa nodes preferred by the
given namespace path. The numa nodes value is comma delimited list of
nodes or A-B range of nodes.

For instance, if we have a shared namespace accessible from two different
controllers/paths then accessing head node of the shared namespace would
show the following output:

$ ls -l /sys/block/nvme1n1/multipath/
nvme1c1n1 -> ../../../../../pci052e:78/052e:78:00.0/nvme/nvme1/nvme1c1n1
nvme1c3n1 -> ../../../../../pci058e:78/058e:78:00.0/nvme/nvme3/nvme1c3n1

In the above example, nvme1n1 is head gendisk node created for a shared
namespace and this namespace is accessible from nvme1c1n1 and nvme1c3n1
paths. For numa io-policy we can then refer the "numa_nodes" attribute
file created under each namespace path:

$ cat /sys/block/nvme1n1/multipath/nvme1c1n1/numa_nodes
0-1

$ cat /sys/block/nvme1n1/multipath/nvme1c3n1/numa_nodes
2-3

>From the above output, we infer that I/O workload targeted at nvme1n1
and running on numa nodes 0 and 1 would prefer using path nvme1c1n1.
Similarly, I/O workload running on numa nodes 2 and 3 would prefer
using path nvme1c3n1. Reading "numa_nodes" file when configured
io-policy is anything but numa would show no output.

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/multipath.c | 27 +++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h      |  1 +
 drivers/nvme/host/sysfs.c     |  5 +++++
 3 files changed, 33 insertions(+)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index eccc26616e38..3f402a7f4af7 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -976,6 +976,33 @@ static ssize_t ana_state_show(struct device *dev, struct device_attribute *attr,
 }
 DEVICE_ATTR_RO(ana_state);
 
+static ssize_t numa_nodes_show(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	int node, srcu_idx;
+	nodemask_t numa_nodes;
+	struct nvme_ns *current_ns;
+	struct nvme_ns *ns = nvme_get_ns_from_dev(dev);
+	struct nvme_ns_head *head = ns->head;
+
+	if (head->subsys->iopolicy != NVME_IOPOLICY_NUMA)
+		return 0;
+
+	nodes_clear(numa_nodes);
+
+	srcu_idx = srcu_read_lock(&head->srcu);
+	for_each_node(node) {
+		current_ns = srcu_dereference(head->current_path[node],
+				&head->srcu);
+		if (ns == current_ns)
+			node_set(node, numa_nodes);
+	}
+	srcu_read_unlock(&head->srcu, srcu_idx);
+
+	return sysfs_emit(buf, "%*pbl\n", nodemask_pr_args(&numa_nodes));
+}
+DEVICE_ATTR_RO(numa_nodes);
+
 static int nvme_lookup_ana_group_desc(struct nvme_ctrl *ctrl,
 		struct nvme_ana_group_desc *desc, void *data)
 {
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 643bf580bd09..fd9f2070d86f 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -984,6 +984,7 @@ static inline void nvme_trace_bio_complete(struct request *req)
 extern bool multipath;
 extern struct device_attribute dev_attr_ana_grpid;
 extern struct device_attribute dev_attr_ana_state;
+extern struct device_attribute dev_attr_numa_nodes;
 extern struct device_attribute subsys_attr_iopolicy;
 
 static inline bool nvme_disk_is_ns_head(struct gendisk *disk)
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 5a23e23b0d01..5a5ee0beb166 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -258,6 +258,7 @@ static struct attribute *nvme_ns_attrs[] = {
 #ifdef CONFIG_NVME_MULTIPATH
 	&dev_attr_ana_grpid.attr,
 	&dev_attr_ana_state.attr,
+	&dev_attr_numa_nodes.attr,
 #endif
 	&dev_attr_io_passthru_err_log_enabled.attr,
 	NULL,
@@ -290,6 +291,10 @@ static umode_t nvme_ns_attrs_are_visible(struct kobject *kobj,
 		if (!nvme_ctrl_use_ana(nvme_get_ns_from_dev(dev)->ctrl))
 			return 0;
 	}
+	if (a == &dev_attr_numa_nodes.attr) {
+		if (nvme_disk_is_ns_head(dev_to_disk(dev)))
+			return 0;
+	}
 #endif
 	return a->mode;
 }
-- 
2.47.1



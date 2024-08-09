Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B1B2C52D7C
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Aug 2024 17:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cEZ1PPuJW/WyUQn30RI8ns8vwbAGlVuwX3aMMbJMELQ=; b=CuxO8nymKWp2yd9o420pDg8O5T
	SLu0h4ueGAWU2+AvXzhn9kL2VLUKJoZQ4OdUV9k3JjltiWsNlmrTVkIca6oQZxqDoX7mkSsvLCwEP
	d5tEBX4kvKL5a1aDOd9qtepj1Pd7ZmxLovkoP3/7G6uFNdocXQZrtax9Ft+rEViv14KVzUAA4sJ0i
	Kp6t8jaacCyoPlha/xQRNQVN55GvFsqPTYogitypo7gTb1+cy2V3VjoEKQtbmzQE6A/OSn/nG/r2r
	djTDlPm7OeG150qNeHIZJqfx4+iuWlej12c2OCInB5ZQs3B1CVrPMiom9p3XUKaqn9Brzb7gzR21T
	HUzx1MCQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1scTT3-0000000C52u-49J0;
	Fri, 09 Aug 2024 17:31:58 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1scTSb-0000000C4uI-280M
	for linux-nvme@lists.infradead.org;
	Fri, 09 Aug 2024 17:31:31 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4790loRr001841;
	Fri, 9 Aug 2024 17:30:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=cEZ1PPuJW/WyU
	Qn30RI8ns8vwbAGlVuwX3aMMbJMELQ=; b=mAcQ9VEoYaXqUO6/vidCKBpPUhprX
	AUrJGrBllg6lM8J5WdElrK1xO/iYCOFZHGYhGS/H9zEjeKOXolyNuK0vAAct06dX
	7l9QObDvaANY/2lPr60MV9wAtiYz7YJEr4KJUM/Nz/fN9a3d6emif8Gs1MfEW8rg
	P+XEq+hfOVqcFgJ1MtwIMx3CE/oMohZ8fdSzMVtMhbQ+mWHyO8AdXq95hPG71uON
	jG9FsgKZ4ME1qFaH1+MSLDCRwCdLjRFlzu+3bQa9Hl1vsteO2iXUNRgYfaMx9+dC
	G4tJiwrdnNagzw/js8MWCz+15IeIpx4fsyWZ0djv08f3ICjjoQ/44QW5w==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40vwkbuj7r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Aug 2024 17:30:57 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 479EFSvH030487;
	Fri, 9 Aug 2024 17:30:57 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 40t1k3m84h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Aug 2024 17:30:56 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 479HUplO55116226
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 9 Aug 2024 17:30:53 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5D1F62004D;
	Fri,  9 Aug 2024 17:30:51 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6FED720040;
	Fri,  9 Aug 2024 17:30:49 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.171.5.214])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  9 Aug 2024 17:30:49 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, hch@lst.de, kbusch@kernel.org, sagi@grimberg.me,
        axboe@fb.com, gjoyce@linux.ibm.com, Nilay Shroff <nilay@linux.ibm.com>
Subject: [RFC PATCH v2 1/1] nvme-multipath: Add sysfs attributes for showing multipath info
Date: Fri,  9 Aug 2024 22:59:57 +0530
Message-ID: <20240809173030.2281021-2-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240809173030.2281021-1-nilay@linux.ibm.com>
References: <20240809173030.2281021-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: pkESsK3ntj3zZ2H4B_1sHDThg9WRXZVF
X-Proofpoint-ORIG-GUID: pkESsK3ntj3zZ2H4B_1sHDThg9WRXZVF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-09_13,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 mlxscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0 mlxlogscore=877
 suspectscore=0 spamscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408090122
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240809_103129_580897_41C8144E 
X-CRM114-Status: GOOD (  21.01  )
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
selected by multipath code for forwarding I/O. This patch helps add that
visibility by adding three new sysfs attribute files named "numa",
"round_robin", and "queue_depth" under each namespace head block path
/sys/block/<nvmeXnY>/multipath. As the name suggests, "numa" attribute
file shows the information about multipath I/O for numa policy,
"round_robin" attribute file shows the information about multipath I/O
for round-robin policy and "queue_depth" attribute file shows the
information about multipath I/O for queue-depth IO policy.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/multipath.c |   2 +-
 drivers/nvme/host/nvme.h      |   1 +
 drivers/nvme/host/sysfs.c     | 108 ++++++++++++++++++++++++++++++++++
 3 files changed, 110 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 91d9eb3c22ef..1a5ca3e7cd5c 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -292,7 +292,7 @@ static struct nvme_ns *__nvme_find_path(struct nvme_ns_head *head, int node)
 	return found;
 }
 
-static struct nvme_ns *nvme_next_ns(struct nvme_ns_head *head,
+struct nvme_ns *nvme_next_ns(struct nvme_ns_head *head,
 		struct nvme_ns *ns)
 {
 	ns = list_next_or_null_rcu(&head->list, &ns->siblings, struct nvme_ns,
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index f900e44243ae..3fe5fac5067f 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -955,6 +955,7 @@ void nvme_mpath_stop(struct nvme_ctrl *ctrl);
 bool nvme_mpath_clear_current_path(struct nvme_ns *ns);
 void nvme_mpath_revalidate_paths(struct nvme_ns *ns);
 void nvme_mpath_clear_ctrl_paths(struct nvme_ctrl *ctrl);
+struct nvme_ns *nvme_next_ns(struct nvme_ns_head *head, struct nvme_ns *ns);
 void nvme_mpath_shutdown_disk(struct nvme_ns_head *head);
 void nvme_mpath_start_request(struct request *rq);
 void nvme_mpath_end_request(struct request *rq);
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index ba05faaac562..06f30c65ee27 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -294,6 +294,113 @@ static umode_t nvme_ns_attrs_are_visible(struct kobject *kobj,
 	return a->mode;
 }
 
+static ssize_t queue_depth_show(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	struct nvme_ns *ns;
+	struct nvme_ns_head *head;
+	int srcu_idx, len = 0;
+
+	head = dev_to_ns_head(dev);
+
+	srcu_idx = srcu_read_lock(&head->srcu);
+
+	list_for_each_entry_rcu(ns, &head->list, siblings) {
+		len += sysfs_emit_at(buf, len, "%s %d\n",
+			    ns->disk->disk_name,
+			    atomic_read(&ns->ctrl->nr_active));
+	}
+
+	srcu_read_unlock(&head->srcu, srcu_idx);
+
+	return len;
+}
+DEVICE_ATTR_RO(queue_depth);
+
+static ssize_t numa_show(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	struct nvme_ns_head *head;
+	struct nvme_ns *ns;
+	int node, len = 0;
+
+	head = dev_to_ns_head(dev);
+
+	for_each_node(node) {
+		ns = head->current_path[node];
+		if (unlikely(!ns))
+			continue;
+
+		len += sysfs_emit_at(buf, len, "node%d: %s\n",
+				node, ns->disk->disk_name);
+	}
+
+	return len;
+}
+DEVICE_ATTR_RO(numa);
+
+static ssize_t round_robin_show(struct device *dev,
+		struct device_attribute *attr,
+		char *buf)
+{
+	struct nvme_ns *ns, *tmp_ns;
+	struct nvme_ns_head *head;
+	int srcu_idx, node, len = 0;
+
+	head = dev_to_ns_head(dev);
+
+	srcu_idx = srcu_read_lock(&head->srcu);
+	for_each_node(node) {
+		ns = tmp_ns = head->current_path[node];
+
+		if (unlikely(!ns))
+			continue;
+
+		len += sysfs_emit_at(buf, len, "node%d: ", node);
+		do {
+			ns = nvme_next_ns(head, ns);
+			if (!ns)
+				break;
+			len += sysfs_emit_at(buf, len, "%s ",
+					ns->disk->disk_name);
+		} while (ns != tmp_ns);
+
+		len += sysfs_emit_at(buf, len, "\n");
+	}
+	srcu_read_unlock(&head->srcu, srcu_idx);
+
+	return len;
+}
+DEVICE_ATTR_RO(round_robin);
+
+static umode_t nvme_ns_mpath_attrs_are_visible(struct kobject *kobj,
+		struct attribute *attr, int n)
+{
+	struct device *dev;
+	struct gendisk *disk;
+
+	dev = container_of(kobj, struct device, kobj);
+	disk = dev_to_disk(dev);
+
+	if (!nvme_disk_is_ns_head(disk))
+		return SYSFS_GROUP_INVISIBLE;
+
+	return attr->mode;
+}
+
+static struct attribute *nvme_ns_mpath_attrs[] = {
+	&dev_attr_queue_depth.attr,
+	&dev_attr_numa.attr,
+	&dev_attr_round_robin.attr,
+	NULL
+};
+
+static const struct attribute_group nvme_ns_mpath_attr_group = {
+	.name           = "multipath",
+	.attrs		= nvme_ns_mpath_attrs,
+	.is_visible     = nvme_ns_mpath_attrs_are_visible,
+};
+
 static const struct attribute_group nvme_ns_attr_group = {
 	.attrs		= nvme_ns_attrs,
 	.is_visible	= nvme_ns_attrs_are_visible,
@@ -301,6 +408,7 @@ static const struct attribute_group nvme_ns_attr_group = {
 
 const struct attribute_group *nvme_ns_attr_groups[] = {
 	&nvme_ns_attr_group,
+	&nvme_ns_mpath_attr_group,
 	NULL,
 };
 
-- 
2.45.2



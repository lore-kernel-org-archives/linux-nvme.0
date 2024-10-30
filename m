Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1EF8D5CC92
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Oct 2024 10:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sg7gd7fYvWfuZRXCK2FCjqw+Mx8eIxP6hh3U86ELs9A=; b=IpM+/sQQCSiwq9Bnzfs9rh2wl4
	3MByFPWGguNIM/QTY7nPolm5NBBjKkvtFuRSZt7kt5cqpjyWs4iPCfTg8NEFu9vVcN8XSEN/aaYpz
	i0FknAyPSCISjz6jAw8FUFDSYVTm30XBmQX8nt81nZM44ZaWWoPDtSelKGvJ6CE6/tlj5hKFP5VkJ
	C2t/sY6HRSYNXM6vtAnKObDPjt/8Tx3kaRJABLm3QgsYFDWgrAhxw6xSPGNRUF9R+CW91O6EPI2W6
	WTn7Qyv1EME2VPKIycrVrOEewTJpSGMPfo9tgb9x1GtTWVIrGBrGm6SOQcvqVNcoLb1Ia65heDGnT
	QFCr3C+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t66Np-000000002JS-0yE4;
	Wed, 30 Oct 2024 10:57:01 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t669Y-0000000HalO-17rB
	for linux-nvme@lists.infradead.org;
	Wed, 30 Oct 2024 10:42:17 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49U2d3T5030042;
	Wed, 30 Oct 2024 10:42:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=sg7gd7fYvWfuZRXCK
	2FCjqw+Mx8eIxP6hh3U86ELs9A=; b=rv6dOBh+mRKnE76AYt9VBA9vLtimB7CNo
	eOQXAkeEznLYR8ab1f5RGs06V2Wz/wzZb9IkWZfq4rtm6a8/0E1nYPUr0/L8lN3W
	PCocFG+3HTzPHirEMCLvogiAzac2avXqEQ/gPIXSAlt8MyU4pvWOBrhVwb5zCUHx
	3lDtbXBqWFcawIjWnzxdOqIx3RVEm+W4c+ED9j5Bdiv+8RWfMseZxk+4wX+NT1qK
	BdzbC/cGHtyXsEkzUzhPDqNOBHWVQGInWQq2/tPdb8H1eVPHgxwmQ9P/3b5r5O8h
	ri3sm4q1Q53Sn7HemPMkDAt6ntmrj+g6YMscVdeMwYwfJLpZXBtOw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42js0h84m0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Oct 2024 10:42:12 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49U7Gj3E013520;
	Wed, 30 Oct 2024 10:42:11 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42hbrmym7m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Oct 2024 10:42:11 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49UAg75u50463148
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Oct 2024 10:42:07 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3979B20043;
	Wed, 30 Oct 2024 10:42:07 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4D8C920040;
	Wed, 30 Oct 2024 10:42:05 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.171.67.17])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 30 Oct 2024 10:42:05 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, sagi@grimberg.me, hare@suse.de, kbusch@kernel.org,
        hch@lst.de, =axboe@fb.com, gjoyce@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCHv5 RFC 3/3] nvme-multipath: Add visibility for queue-depth io-policy
Date: Wed, 30 Oct 2024 16:11:43 +0530
Message-ID: <20241030104156.747675-4-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241030104156.747675-1-nilay@linux.ibm.com>
References: <20241030104156.747675-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: wru-KFjm2ZRX0bYkPJtc1KYCaXj6kRUy
X-Proofpoint-ORIG-GUID: wru-KFjm2ZRX0bYkPJtc1KYCaXj6kRUy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 phishscore=0 impostorscore=0 adultscore=0 clxscore=1015 mlxlogscore=999
 bulkscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410300080
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241030_034216_396897_2DBF296E 
X-CRM114-Status: GOOD (  19.64  )
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

This patch helps add nvme native multipath visibility for queue-depth
io-policy. It adds a new attribute file named "queue_depth" under
namespace device path node which would print the number of active/
in-flight I/O requests currently queued for the given path.

For instance, if we have a shared namespace accessible from two different
controllers/paths then accessing head block node of the shared namespace
would show the following output:

$ ls -l /sys/block/nvme1n1/multipath/
nvme1c1n1 -> ../../../../../pci052e:78/052e:78:00.0/nvme/nvme1/nvme1c1n1
nvme1c3n1 -> ../../../../../pci058e:78/058e:78:00.0/nvme/nvme3/nvme1c3n1

In the above example, nvme1n1 is head gendisk node created for a shared
namespace and the namespace is accessible from nvme1c1n1 and nvme1c3n1
paths. For queue-depth io-policy we can then refer the "queue_depth"
attribute file created under each namespace path:

$ cat /sys/block/nvme1n1/multipath/nvme1c1n1/queue_depth
518

$cat /sys/block/nvme1n1/multipath/nvme1c3n1/queue_depth
504

From the above output, we can infer that I/O workload targeted at nvme1n1
uses two paths nvme1c1n1 and nvme1c3n1 and the current queue depth of each
path is 518 and 504 respectively. Reading "queue_depth" file when
configured io-policy is anything but queue-depth would show no output.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/multipath.c | 12 ++++++++++++
 drivers/nvme/host/nvme.h      |  1 +
 drivers/nvme/host/sysfs.c     |  3 ++-
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 7bfba6637916..4f0381a0b191 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -971,6 +971,18 @@ static ssize_t ana_state_show(struct device *dev, struct device_attribute *attr,
 }
 DEVICE_ATTR_RO(ana_state);
 
+static ssize_t queue_depth_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct nvme_ns *ns = nvme_get_ns_from_dev(dev);
+
+	if (ns->head->subsys->iopolicy != NVME_IOPOLICY_QD)
+		return 0;
+
+	return sysfs_emit(buf, "%d\n", atomic_read(&ns->ctrl->nr_active));
+}
+DEVICE_ATTR_RO(queue_depth);
+
 static ssize_t numa_nodes_show(struct device *dev, struct device_attribute *attr,
 		char *buf)
 {
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 02c0eb7b462c..792820261db1 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -978,6 +978,7 @@ static inline void nvme_trace_bio_complete(struct request *req)
 extern bool multipath;
 extern struct device_attribute dev_attr_ana_grpid;
 extern struct device_attribute dev_attr_ana_state;
+extern struct device_attribute dev_attr_queue_depth;
 extern struct device_attribute dev_attr_numa_nodes;
 extern struct device_attribute subsys_attr_iopolicy;
 
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 5a5ee0beb166..498659efacba 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -258,6 +258,7 @@ static struct attribute *nvme_ns_attrs[] = {
 #ifdef CONFIG_NVME_MULTIPATH
 	&dev_attr_ana_grpid.attr,
 	&dev_attr_ana_state.attr,
+	&dev_attr_queue_depth.attr,
 	&dev_attr_numa_nodes.attr,
 #endif
 	&dev_attr_io_passthru_err_log_enabled.attr,
@@ -291,7 +292,7 @@ static umode_t nvme_ns_attrs_are_visible(struct kobject *kobj,
 		if (!nvme_ctrl_use_ana(nvme_get_ns_from_dev(dev)->ctrl))
 			return 0;
 	}
-	if (a == &dev_attr_numa_nodes.attr) {
+	if (a == &dev_attr_queue_depth.attr || a == &dev_attr_numa_nodes.attr) {
 		if (nvme_disk_is_ns_head(dev_to_disk(dev)))
 			return 0;
 	}
-- 
2.45.2



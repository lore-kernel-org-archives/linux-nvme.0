Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B6E1C46CCD
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Dec 2023 23:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5AbMtdYOGo1fhl+G42pKobVSmDePppHlBmE4stx7gHo=; b=du+1mArgxXYbmMiBHQjllM3iDI
	NobKzoamMkUks1Nk+Z4VDJLchKIJoa+E7rYJFGPU4vG8ZdSegzctIRKjaRIqQhtOXnx5XbxoH+mmE
	gG7MKMiDed3WJoayADLmMVYqlMO1JQL6E/7FrOj1X9j7W5NyEv/IYoLaOQcoyXzrKpu7K/hbx1ED+
	fHvnSokWAb4f6Dr9Z/FMwvbMIHNtdunJYhrqb+R0rfBvtg8cgnBNide3dgNhY4MVBZ9IgICw99msi
	VSFMqtdSTxTe5RrDbDS9ZOK4Nm3TUNWoCOP99CRy0aLqJlH0B36Bx6KKQZneJlJJ3EXI9KTucTAXf
	HrZdICpw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rGSBK-004OSh-2O;
	Thu, 21 Dec 2023 23:10:22 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rGSBH-004OKF-1N
	for linux-nvme@lists.infradead.org;
	Thu, 21 Dec 2023 23:10:21 +0000
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BLMhnkr018248;
	Thu, 21 Dec 2023 23:09:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=5AbMtdYOGo1fhl+G42pKobVSmDePppHlBmE4stx7gHo=;
 b=EL4sr9BFtZYsP+WlrI1V57qsKxuomVywabYQF1gKiHlmcDitEfhELZksQb/aoqJoFtDl
 Q15RBzIGSfcNFjSe+8rwJKMNZ4nMlvL32BHeamXzsXyVKlxUL78RLsctWCy6CZVwFiHD
 o9s5+EZ3rhRhTwgXsgpKOpgv9V5X2EGG+FDoPMuX/hHMutGKyuMHALYApOUDGEALpFOu
 ZOEsiLkBDMqJn8DK1YBQ8/uFKZz1lFXz/uh5oCLAlmdctwvmXT6g7iq7bqxkH4JaaTWZ
 WVO0nQMoz7OePKuoKuwsZDNgRDOyTdtbBylWZTN4AbpurwZzvdeHhqZ4jnKeW6jvMfa1 qg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3v13xdmku0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Dec 2023 23:09:29 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BLMkIho024918;
	Thu, 21 Dec 2023 23:09:29 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3v12bj6d80-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Dec 2023 23:09:29 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BLN9RdK038754;
	Thu, 21 Dec 2023 23:09:28 GMT
Received: from ca-dev94.us.oracle.com (ca-dev94.us.oracle.com [10.129.136.30])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3v12bj6d5h-2;
	Thu, 21 Dec 2023 23:09:28 +0000
From: Alan Adamson <alan.adamson@oracle.com>
To: linux-nvme@lists.infradead.org
Cc: alan.adamson@oracle.com, kch@nvidia.com, kbusch@kernel.org, hch@lst.de,
        sagi@grimberg.me
Subject: [RFC 1/1] nvme: Add NVMe LBA Fault Injection
Date: Thu, 21 Dec 2023 15:10:43 -0800
Message-Id: <20231221231043.3597368-2-alan.adamson@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231221231043.3597368-1-alan.adamson@oracle.com>
References: <20231221231043.3597368-1-alan.adamson@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-21_11,2023-12-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312210177
X-Proofpoint-GUID: rk_Gi3BjjfJGBGJYcdYKbaBi254vdk8n
X-Proofpoint-ORIG-GUID: rk_Gi3BjjfJGBGJYcdYKbaBi254vdk8n
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231221_151019_604888_DA08C5C0 
X-CRM114-Status: GOOD (  31.20  )
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

Add support for injecting a fault when reading or writing a specific
Logical Block Address (LBA).

Steps to setup a fault on a LBA access.

1. Setup the attributes: probability, times, and status according to
the original NVMe fault injector.

echo 100 > /sys/kernel/debug/nvme0n1/fault_inject/probability
echo 1 > /sys/kernel/debug/nvme0n1/fault_inject/times
echo 1 > /sys/kernel/debug/nvme0n1/fault_inject/status

2. Specify one or more LBAs: To configure a LBA, set the lba-inject-set
attribute to the LBA.

echo 0x22 > /sys/kernel/debug/nvme0n1/fault_inject/lba-inject-set

3. Enable the LBA injector: by setting the lba-inject-enable attribute
to on.

echo on > /sys/kernel/debug/nvme0n1/fault_inject/lba-inject-enable

To display the LBAs configured:

cat /sys/kernel/debug/nvme0n1/fault_inject/lba-inject-show
LBA  Status
22   1

To stop injecting a fault on a LBA:

echo 1 > /sys/kernel/debug/nvme0n1/fault_inject/lba-inject-clear
echo 0x22 > /sys/kernel/debug/nvme0n1/fault_inject/lba-inject-set

Signed-off-by: Alan Adamson <alan.adamson@oracle.com>
---
 .../fault-injection/nvme-fault-injection.rst  |  28 ++++
 drivers/nvme/host/core.c                      |   4 +-
 drivers/nvme/host/fault_inject.c              | 145 ++++++++++++++++--
 drivers/nvme/host/nvme.h                      |  16 +-
 4 files changed, 178 insertions(+), 15 deletions(-)

diff --git a/Documentation/fault-injection/nvme-fault-injection.rst b/Documentation/fault-injection/nvme-fault-injection.rst
index 1d4427890d75..e17f49886fc4 100644
--- a/Documentation/fault-injection/nvme-fault-injection.rst
+++ b/Documentation/fault-injection/nvme-fault-injection.rst
@@ -176,3 +176,31 @@ Message from dmesg::
    secondary_startup_64+0xa4/0xb0
   nvme nvme0: Could not set queue count (16385)
   nvme nvme0: IO queues not created
+
+Example 4: Inject an error when reading or writing Logical Block Addrss (LBA) 0x22
+----------------------------------------------------------------------------------
+
+::
+
+  echo 1 > /sys/kernel/debug/nvme0n1/fault_inject/times
+  echo 100 > /sys/kernel/debug/nvme0n1/fault_inject/probability
+  echo 1 > /sys/kernel/debug/nvme0n1/fault_inject/status
+  echo 1 > /sys/kernel/debug/nvme0n1/fault_inject/dont_retry
+  echo 0x22 > /sys/kernel/debug/nvme0n1/fault_inject/lba-inject-set
+  cat /sys/kernel/debug/nvme0n1/fault_inject/lba-inject-show
+  LBA	Status
+  21	1
+
+  echo 1 > /sys/kernel/debug/nvme0n1/fault_inject/lba-inject-enable
+  dd if=/dev/nvme0n1 of=/dev/null iflag=direct count=100
+  dd: error reading '/dev/nvme0n1': Operation not supported
+  33+0 records in
+  33+0 records out
+  16896 bytes (17 kB, 16 KiB) copied, 0.00711112 s, 2.4 MB/s
+
+  echo 1 > /sys/kernel/debug/nvme0n1/fault_inject/lba-inject-clear
+  echo 0x22 > /sys/kernel/debug/nvme0n1/fault_inject/lba-inject-set
+  cat /sys/kernel/debug/nvme0n1/fault_inject/lba-inject-show
+  LBA   Status
+
+  echo 0 > /sys/kernel/debug/nvme0n1/fault_inject/lba-inject-enable
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 8ebdfd623e0f..435ef8b475c0 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3681,7 +3681,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
 		nvme_add_ns_cdev(ns);
 
 	nvme_mpath_add_disk(ns, info->anagrpid);
-	nvme_fault_inject_init(&ns->fault_inject, ns->disk->disk_name);
+	nvme_fault_inject_init(&ns->fault_inject, ns->disk->disk_name, 1);
 
 	return;
 
@@ -4548,7 +4548,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	dev_pm_qos_update_user_latency_tolerance(ctrl->device,
 		min(default_ps_max_latency_us, (unsigned long)S32_MAX));
 
-	nvme_fault_inject_init(&ctrl->fault_inject, dev_name(ctrl->device));
+	nvme_fault_inject_init(&ctrl->fault_inject, dev_name(ctrl->device), 0);
 	nvme_mpath_init_ctrl(ctrl);
 	ret = nvme_auth_init_ctrl(ctrl);
 	if (ret)
diff --git a/drivers/nvme/host/fault_inject.c b/drivers/nvme/host/fault_inject.c
index 1ba10a5c656d..81107ab66e21 100644
--- a/drivers/nvme/host/fault_inject.c
+++ b/drivers/nvme/host/fault_inject.c
@@ -5,6 +5,8 @@
  * Copyright (c) 2018, Oracle and/or its affiliates
  */
 
+#include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/moduleparam.h>
 #include "nvme.h"
 
@@ -15,8 +17,88 @@ static DECLARE_FAULT_ATTR(fail_default_attr);
 static char *fail_request;
 module_param(fail_request, charp, 0000);
 
+static void nvme_free_lba_block(struct lba_blk *lba_block)
+{
+	list_del(&lba_block->node);
+	kfree(lba_block);
+}
+
+static void nvme_free_all_lba_blocks(struct nvme_fault_inject *fault_inj)
+{
+	struct lba_blk *lba_block;
+	struct list_head *list_ptr, *tmp;
+
+	list_for_each_prev_safe(list_ptr, tmp, &fault_inj->lba_list) {
+		lba_block = list_entry(list_ptr, struct lba_blk, node);
+		list_del(list_ptr);
+		kfree(lba_block);
+	}
+}
+
+static int nvme_lba_inject_set(void *data, u64 val)
+{
+	struct nvme_fault_inject *fault_inj = data;
+	struct lba_blk *lba_block;
+	int lba;
+	int ret = 0;
+
+	lba =  val;
+	mutex_lock(&fault_inj->lba_block_lock);
+	if (fault_inj->lba_clear) {
+		list_for_each_entry(lba_block,
+		    &fault_inj->lba_list, node) {
+			if (lba_block->lba == lba) {
+				nvme_free_lba_block(lba_block);
+				fault_inj->lba_clear = 0;
+				mutex_unlock(&fault_inj->lba_block_lock);
+				return ret;
+			}
+		}
+		fault_inj->lba_clear = 0;
+		mutex_unlock(&fault_inj->lba_block_lock);
+		return ret;
+	}
+
+	list_for_each_entry(lba_block, &fault_inj->lba_list, node) {
+		if (lba_block->lba == lba) {
+			lba_block->status = fault_inj->status;
+			mutex_unlock(&fault_inj->lba_block_lock);
+			return ret;
+		}
+	}
+
+	lba_block = kmalloc(sizeof(struct lba_blk), GFP_KERNEL);
+	lba_block->lba = lba;
+	lba_block->status = fault_inj->status;
+
+	list_add(&lba_block->node, &fault_inj->lba_list);
+
+	mutex_unlock(&fault_inj->lba_block_lock);
+	return ret;
+}
+
+static int nvme_lba_inject_show(struct seq_file *file, void *data)
+{
+	struct nvme_fault_inject *fault_inj = file->private;
+	struct lba_blk *lba_block;
+
+	seq_printf(file, "LBA	Status\n");
+	mutex_lock(&fault_inj->lba_block_lock);
+	list_for_each_entry(lba_block, &fault_inj->lba_list, node) {
+		seq_printf(file, "%llx	%x\n",
+		    lba_block->lba, lba_block->status);
+	}
+	mutex_unlock(&fault_inj->lba_block_lock);
+
+	return 0;
+}
+
+DEFINE_SHOW_ATTRIBUTE(nvme_lba_inject);
+DEFINE_DEBUGFS_ATTRIBUTE(nvme_lba_inject_set_fops, NULL,
+			 nvme_lba_inject_set, "%llu\n");
+
 void nvme_fault_inject_init(struct nvme_fault_inject *fault_inj,
-			    const char *dev_name)
+			    const char *dev_name, bool lba_inject)
 {
 	struct dentry *dir, *parent;
 	struct fault_attr *attr = &fault_inj->attr;
@@ -41,15 +123,34 @@ void nvme_fault_inject_init(struct nvme_fault_inject *fault_inj,
 	}
 	fault_inj->parent = parent;
 
+	INIT_LIST_HEAD(&fault_inj->lba_list);
+
 	/* create debugfs for status code and dont_retry */
 	fault_inj->status = NVME_SC_INVALID_OPCODE;
 	fault_inj->dont_retry = true;
+	fault_inj->lba_clear = 0;
+	fault_inj->lba_inject_enable = false;
+	mutex_init(&fault_inj->lba_block_lock);
+
 	debugfs_create_x16("status", 0600, dir,	&fault_inj->status);
 	debugfs_create_bool("dont_retry", 0600, dir, &fault_inj->dont_retry);
+	if (lba_inject) {
+		debugfs_create_bool("lba-inject-clear", 0600, dir, &fault_inj->lba_clear);
+		debugfs_create_bool("lba-inject-enable", 0600, dir,
+		    &fault_inj->lba_inject_enable);
+		debugfs_create_file("lba-inject-show", 0600, dir,
+		    fault_inj, &nvme_lba_inject_fops);
+		debugfs_create_file_unsafe("lba-inject-set", 0600, dir,
+		    fault_inj, &nvme_lba_inject_set_fops);
+	}
 }
 
 void nvme_fault_inject_fini(struct nvme_fault_inject *fault_inject)
 {
+        mutex_lock(&fault_inject->lba_block_lock);
+	nvme_free_all_lba_blocks(fault_inject);
+        mutex_unlock(&fault_inject->lba_block_lock);
+
 	/* remove debugfs directories */
 	debugfs_remove_recursive(fault_inject->parent);
 }
@@ -58,25 +159,47 @@ void nvme_should_fail(struct request *req)
 {
 	struct gendisk *disk = req->q->disk;
 	struct nvme_fault_inject *fault_inject = NULL;
+	struct nvme_ns *ns = NULL;
+	struct lba_blk *lba_block = NULL;
 	u16 status;
 
 	if (disk) {
-		struct nvme_ns *ns = disk->private_data;
-
+		ns = disk->private_data;
 		if (ns)
 			fault_inject = &ns->fault_inject;
 		else
 			WARN_ONCE(1, "No namespace found for request\n");
-	} else {
+	} else
 		fault_inject = &nvme_req(req)->ctrl->fault_inject;
-	}
 
-	if (fault_inject && should_fail(&fault_inject->attr, 1)) {
-		/* inject status code and DNR bit */
-		status = fault_inject->status;
-		if (fault_inject->dont_retry)
-			status |= NVME_SC_DNR;
-		nvme_req(req)->status =	status;
+	if (!fault_inject || !should_fail(&fault_inject->attr, 1))
+		return;
+
+	mutex_lock(&fault_inject->lba_block_lock);
+
+	if (fault_inject->lba_inject_enable) {
+		u64 req_lba_start, req_lba_end;
+
+		req_lba_start = blk_rq_pos(req);
+		req_lba_end = req_lba_start + blk_rq_sectors(req) - 1;
+
+		list_for_each_entry(lba_block, &fault_inject->lba_list, node) {
+			if ((lba_block->lba >= req_lba_start) &&
+			    (lba_block->lba <= req_lba_end))
+				goto inject_fault;
+		}
+
+		mutex_unlock(&fault_inject->lba_block_lock);
+		return;
 	}
+
+inject_fault:
+	mutex_unlock(&fault_inject->lba_block_lock);
+
+	/* inject status code and DNR bit */
+	status = fault_inject->status;
+	if (fault_inject->dont_retry)
+		status |= NVME_SC_DNR;
+	nvme_req(req)->status =	status;
 }
 EXPORT_SYMBOL_GPL(nvme_should_fail);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index e7411dac00f7..447ce832613c 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -16,6 +16,7 @@
 #include <linux/rcupdate.h>
 #include <linux/wait.h>
 #include <linux/t10-pi.h>
+#include <linux/list.h>
 
 #include <trace/events/block.h>
 
@@ -245,7 +246,11 @@ struct nvme_fault_inject {
 	struct fault_attr attr;
 	struct dentry *parent;
 	bool dont_retry;	/* DNR, do not retry */
+	bool lba_clear;
+	bool lba_inject_enable;
 	u16 status;		/* status code */
+	struct mutex		lba_block_lock;
+	struct list_head	lba_list;
 #endif
 };
 
@@ -484,6 +489,13 @@ enum nvme_ns_features {
 	NVME_NS_DEAC,		/* DEAC bit in Write Zeores supported */
 };
 
+typedef struct lba_blk {
+	u64			lba;
+	u16			status;
+	u32			times;
+	struct list_head	node;
+} lba_blk_t;
+
 struct nvme_ns {
 	struct list_head list;
 
@@ -621,12 +633,12 @@ static inline void nvme_print_device_info(struct nvme_ctrl *ctrl)
 
 #ifdef CONFIG_FAULT_INJECTION_DEBUG_FS
 void nvme_fault_inject_init(struct nvme_fault_inject *fault_inj,
-			    const char *dev_name);
+			    const char *dev_name, bool lba_inject);
 void nvme_fault_inject_fini(struct nvme_fault_inject *fault_inject);
 void nvme_should_fail(struct request *req);
 #else
 static inline void nvme_fault_inject_init(struct nvme_fault_inject *fault_inj,
-					  const char *dev_name)
+					  const char *dev_name, bool lba_inject)
 {
 }
 static inline void nvme_fault_inject_fini(struct nvme_fault_inject *fault_inj)
-- 
2.39.3



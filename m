Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20380C6FD1C
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Mar 2023 23:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YcavsdJWPA4MTJZ/cNmo3EVSGVSYvVVCEr65W91kM5E=; b=EWadjM393ahFE9OSxWaiq6WvT+
	wPIHS6/OizTJOhgRF7dwCPsUgSgCoe/0DuCelwTMZNINiG/SUoSHd2mpukPnTs8UMpKgtSpCCO8gp
	P7XGT57C0xzEwYgxpq3Durq5go2jhBDhhLcxoxJu3W02lbkWw6s6c2a6Huryt9Uo2f9oUKKJ1mOF9
	Mp/nGeYGDy/Yol0knY/gpdx0g2MDv52SUviVAYygwa+K008pYekG87i7KQe3O+iPW/rxd9XXxQJ4x
	yLG1fo9zDgriGMn47zNLVAZ5FI+vuEIM8sffoXQq0RnbkY8WYiFobySdmapvbWuF9JCy9JO/kNv4+
	leg/OnjQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pfTyj-0039v2-2b;
	Thu, 23 Mar 2023 23:04:17 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pfTyb-0039qx-18
	for linux-nvme@lists.infradead.org;
	Thu, 23 Mar 2023 23:04:15 +0000
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32NMsrON021936;
	Thu, 23 Mar 2023 23:03:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2022-7-12;
 bh=YcavsdJWPA4MTJZ/cNmo3EVSGVSYvVVCEr65W91kM5E=;
 b=LOpjawFXyaNBl31toJpEPIOYht6+zSDOLuAHFoJsLJlYQcgneET9jxe3mCvXfq3SVdas
 0oMU4JLboDXNghEf+X/6fpcGt8fnwi4iaa8pN9tmGXW2dm2acMsC1jmemb5zVhAQO++t
 vqWTC1/K+AA0g07E83CwslfXcTBrXPgQxmpj+RnS91sZ2kXSA/I9x+pBGuhwiaGYBiGi
 jDdYETxy6FlTEdCzjfqQQRk0qM2DQ3g6JvdgSktuvFWEzin5ERXNq7DzP3HdFe/aP7SZ
 RETjC1BDXtbsVsmLsJPI5MKWjMPDct8WhEjhuiiuSGBbs7beR9mMEdqHX9q3C0b+pag6 Kw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pgyyn80at-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Mar 2023 23:03:55 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32NLJQhv001643;
	Thu, 23 Mar 2023 23:03:42 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3pgxk3aky5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Mar 2023 23:03:42 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32NN3fh5040061;
	Thu, 23 Mar 2023 23:03:42 GMT
Received: from ca-dev94.us.oracle.com (ca-dev94.us.oracle.com [10.129.136.30])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3pgxk3akmn-2;
	Thu, 23 Mar 2023 23:03:42 +0000
From: Alan Adamson <alan.adamson@oracle.com>
To: linux-nvme@lists.infradead.org
Cc: alan.adamson@oracle.com, p.raghav@samsung.com, kbusch@kernel.org,
        hch@lst.de, sagi@grimberg.me
Subject: [RFC v2 1/3] nvme: move fault injector to nvme-debugfs.c
Date: Thu, 23 Mar 2023 16:03:14 -0700
Message-Id: <20230323230316.2914077-2-alan.adamson@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230323230316.2914077-1-alan.adamson@oracle.com>
References: <20230323230316.2914077-1-alan.adamson@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-23_13,2023-03-23_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 adultscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303230168
X-Proofpoint-GUID: fx5C-ws8LHQAz2l_wcSPpffXSCrkSmXo
X-Proofpoint-ORIG-GUID: fx5C-ws8LHQAz2l_wcSPpffXSCrkSmXo
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230323_160410_227226_1D96EE83 
X-CRM114-Status: GOOD (  26.04  )
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

Move the nvme fault injector code associated with debugfs into
nvme-debugfs.c (new file) so all nvme debugfs associated can
reside in a common place.

CONFIG_NVME_FAULT_INJECTION_DEBUG_FS needs to be enabled to
be able to use fault injection.

Signed-off-by: Alan Adamson <alan.adamson@oracle.com>
---
 drivers/nvme/host/Kconfig                     |  6 ++
 drivers/nvme/host/Makefile                    |  2 +-
 drivers/nvme/host/core.c                      | 11 ++--
 .../host/{fault_inject.c => nvme-debugfs.c}   | 56 +++++++++----------
 drivers/nvme/host/nvme.h                      | 31 +++++-----
 5 files changed, 59 insertions(+), 47 deletions(-)
 rename drivers/nvme/host/{fault_inject.c => nvme-debugfs.c} (60%)

diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
index 2f6a7f8c94e8..70f380c1ccae 100644
--- a/drivers/nvme/host/Kconfig
+++ b/drivers/nvme/host/Kconfig
@@ -32,6 +32,12 @@ config NVME_VERBOSE_ERRORS
 	   error translation table will grow the kernel image size by
 	   about 4 KB.
 
+config NVME_FAULT_INJECTION_DEBUG_FS
+	bool "NVMe Fault Injection"
+	depends on FAULT_INJECTION_DEBUG_FS
+	help
+	   This enables NVMe Fault Injection through debugfs.
+
 config NVME_HWMON
 	bool "NVMe hardware monitoring"
 	depends on (NVME_CORE=y && HWMON=y) || (NVME_CORE=m && HWMON)
diff --git a/drivers/nvme/host/Makefile b/drivers/nvme/host/Makefile
index e27202d22c7d..c232d7703b65 100644
--- a/drivers/nvme/host/Makefile
+++ b/drivers/nvme/host/Makefile
@@ -15,7 +15,7 @@ nvme-core-$(CONFIG_NVME_VERBOSE_ERRORS)	+= constants.o
 nvme-core-$(CONFIG_TRACING)		+= trace.o
 nvme-core-$(CONFIG_NVME_MULTIPATH)	+= multipath.o
 nvme-core-$(CONFIG_BLK_DEV_ZONED)	+= zns.o
-nvme-core-$(CONFIG_FAULT_INJECTION_DEBUG_FS)	+= fault_inject.o
+nvme-core-$(CONFIG_FAULT_INJECTION_DEBUG_FS)	+= nvme-debugfs.o
 nvme-core-$(CONFIG_NVME_HWMON)		+= hwmon.o
 nvme-core-$(CONFIG_NVME_AUTH)		+= auth.o
 
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d4be525f8100..679d87d4f5e8 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4336,7 +4336,9 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
 		nvme_add_ns_cdev(ns);
 
 	nvme_mpath_add_disk(ns, info->anagrpid);
-	nvme_fault_inject_init(&ns->fault_inject, ns->disk->disk_name);
+
+	nvme_debugfs_init(&ns->debugfs, ns->disk->disk_name);
+	nvme_fault_inject_init(&ns->debugfs);
 
 	return;
 
@@ -4367,7 +4369,7 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 
 	clear_bit(NVME_NS_READY, &ns->flags);
 	set_capacity(ns->disk, 0);
-	nvme_fault_inject_fini(&ns->fault_inject);
+	nvme_debugfs_remove(&ns->debugfs);
 
 	/*
 	 * Ensure that !NVME_NS_READY is seen by other threads to prevent
@@ -5064,7 +5066,7 @@ EXPORT_SYMBOL_GPL(nvme_start_ctrl);
 void nvme_uninit_ctrl(struct nvme_ctrl *ctrl)
 {
 	nvme_hwmon_exit(ctrl);
-	nvme_fault_inject_fini(&ctrl->fault_inject);
+	nvme_debugfs_remove(&ctrl->debugfs);
 	dev_pm_qos_hide_latency_tolerance(ctrl->device);
 	cdev_device_del(&ctrl->cdev, ctrl->device);
 	nvme_put_ctrl(ctrl);
@@ -5189,7 +5191,8 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	dev_pm_qos_update_user_latency_tolerance(ctrl->device,
 		min(default_ps_max_latency_us, (unsigned long)S32_MAX));
 
-	nvme_fault_inject_init(&ctrl->fault_inject, dev_name(ctrl->device));
+	nvme_debugfs_init(&ctrl->debugfs, dev_name(ctrl->device));
+	nvme_fault_inject_init(&ctrl->debugfs);
 	nvme_mpath_init_ctrl(ctrl);
 	ret = nvme_auth_init_ctrl(ctrl);
 	if (ret)
diff --git a/drivers/nvme/host/fault_inject.c b/drivers/nvme/host/nvme-debugfs.c
similarity index 60%
rename from drivers/nvme/host/fault_inject.c
rename to drivers/nvme/host/nvme-debugfs.c
index 83d2e6860d38..87f78b864225 100644
--- a/drivers/nvme/host/fault_inject.c
+++ b/drivers/nvme/host/nvme-debugfs.c
@@ -1,13 +1,27 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * fault injection support for nvme.
- *
- * Copyright (c) 2018, Oracle and/or its affiliates
+ * Copyright (c) 2023, Oracle and/or its affiliates
  */
 
+#include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/moduleparam.h>
 #include "nvme.h"
 
+#ifdef CONFIG_FAULT_INJECTION_DEBUG_FS
+void nvme_debugfs_init(struct nvme_debugfs *debugfs,
+		  const char *dev_name)
+{
+	/* create debugfs directory */
+	debugfs->parent = debugfs_create_dir(dev_name, NULL);
+}
+
+void nvme_debugfs_remove(struct nvme_debugfs *debugfs)
+{
+	/* remove debugfs directories */
+	debugfs_remove_recursive(debugfs->parent);
+}
+#ifdef CONFIG_NVME_FAULT_INJECTION_DEBUG_FS
 static DECLARE_FAULT_ATTR(fail_default_attr);
 /* optional fault injection attributes boot time option:
  * nvme_core.fail_request=<interval>,<probability>,<space>,<times>
@@ -15,31 +29,20 @@ static DECLARE_FAULT_ATTR(fail_default_attr);
 static char *fail_request;
 module_param(fail_request, charp, 0000);
 
-void nvme_fault_inject_init(struct nvme_fault_inject *fault_inj,
-			    const char *dev_name)
+void nvme_fault_inject_init(struct nvme_debugfs *debugfs)
 {
-	struct dentry *dir, *parent;
+	struct nvme_fault_inject *fault_inj = &debugfs->fault_inject;
+	struct dentry *dir;
 	struct fault_attr *attr = &fault_inj->attr;
 
 	/* set default fault injection attribute */
 	if (fail_request)
 		setup_fault_attr(&fail_default_attr, fail_request);
 
-	/* create debugfs directory and attribute */
-	parent = debugfs_create_dir(dev_name, NULL);
-	if (!parent) {
-		pr_warn("%s: failed to create debugfs directory\n", dev_name);
-		return;
-	}
-
 	*attr = fail_default_attr;
-	dir = fault_create_debugfs_attr("fault_inject", parent, attr);
-	if (IS_ERR(dir)) {
-		pr_warn("%s: failed to create debugfs attr\n", dev_name);
-		debugfs_remove_recursive(parent);
+	dir = fault_create_debugfs_attr("fault_inject", debugfs->parent, attr);
+	if (IS_ERR(dir))
 		return;
-	}
-	fault_inj->parent = parent;
 
 	/* create debugfs for status code and dont_retry */
 	fault_inj->status = NVME_SC_INVALID_OPCODE;
@@ -48,12 +51,6 @@ void nvme_fault_inject_init(struct nvme_fault_inject *fault_inj,
 	debugfs_create_bool("dont_retry", 0600, dir, &fault_inj->dont_retry);
 }
 
-void nvme_fault_inject_fini(struct nvme_fault_inject *fault_inject)
-{
-	/* remove debugfs directories */
-	debugfs_remove_recursive(fault_inject->parent);
-}
-
 void nvme_should_fail(struct request *req)
 {
 	struct gendisk *disk = req->q->disk;
@@ -64,12 +61,11 @@ void nvme_should_fail(struct request *req)
 		struct nvme_ns *ns = disk->private_data;
 
 		if (ns)
-			fault_inject = &ns->fault_inject;
+			fault_inject = &ns->debugfs.fault_inject;
 		else
 			WARN_ONCE(1, "No namespace found for request\n");
-	} else {
-		fault_inject = &nvme_req(req)->ctrl->fault_inject;
-	}
+	} else
+		fault_inject = &nvme_req(req)->ctrl->debugfs.fault_inject;
 
 	if (fault_inject && should_fail(&fault_inject->attr, 1)) {
 		/* inject status code and DNR bit */
@@ -80,3 +76,5 @@ void nvme_should_fail(struct request *req)
 	}
 }
 EXPORT_SYMBOL_GPL(nvme_should_fail);
+#endif /* CONFIG_NVME_FAULT_INJECTION_DEBUG_FS */
+#endif /* CONFIG_FAULT_INJECTION_DEBUG_FS */
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index bf46f122e9e1..53d61723ca59 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -231,12 +231,16 @@ enum nvme_ctrl_state {
 struct nvme_fault_inject {
 #ifdef CONFIG_FAULT_INJECTION_DEBUG_FS
 	struct fault_attr attr;
-	struct dentry *parent;
 	bool dont_retry;	/* DNR, do not retry */
 	u16 status;		/* status code */
 #endif
 };
 
+struct nvme_debugfs {
+	struct dentry *parent;
+	struct nvme_fault_inject fault_inject;
+};
+
 enum nvme_ctrl_flags {
 	NVME_CTRL_FAILFAST_EXPIRED	= 0,
 	NVME_CTRL_ADMIN_Q_STOPPED	= 1,
@@ -370,7 +374,7 @@ struct nvme_ctrl {
 	struct page *discard_page;
 	unsigned long discard_page_busy;
 
-	struct nvme_fault_inject fault_inject;
+	struct nvme_debugfs debugfs;
 
 	enum nvme_ctrl_type cntrltype;
 	enum nvme_dctype dctype;
@@ -496,8 +500,7 @@ struct nvme_ns {
 	struct cdev		cdev;
 	struct device		cdev_device;
 
-	struct nvme_fault_inject fault_inject;
-
+	struct nvme_debugfs debugfs;
 };
 
 /* NVMe ns supports metadata actions by the controller (generate/strip) */
@@ -598,21 +601,23 @@ static inline void nvme_print_device_info(struct nvme_ctrl *ctrl)
 }
 
 #ifdef CONFIG_FAULT_INJECTION_DEBUG_FS
-void nvme_fault_inject_init(struct nvme_fault_inject *fault_inj,
-			    const char *dev_name);
-void nvme_fault_inject_fini(struct nvme_fault_inject *fault_inject);
+void nvme_debugfs_init(struct nvme_debugfs *debugfs,
+		       const char *dev_name);
+void nvme_debugfs_remove(struct nvme_debugfs *debugfs);
+#else
+static inline void nvme_debugfs_init(struct nvme_debugfs *debugfs,
+			const char *dev_name) {}
+static inline void nvme_debugfs_remove(struct nvme_debugfs *debugfs) {}
+#endif
+#ifdef CONFIG_NVME_FAULT_INJECTION_DEBUG_FS
+void nvme_fault_inject_init(struct nvme_debugfs *debugfs);
 void nvme_should_fail(struct request *req);
 #else
-static inline void nvme_fault_inject_init(struct nvme_fault_inject *fault_inj,
-					  const char *dev_name)
-{
-}
-static inline void nvme_fault_inject_fini(struct nvme_fault_inject *fault_inj)
+static inline void nvme_fault_inject_init(struct nvme_debugfs *debugfs)
 {
 }
 static inline void nvme_should_fail(struct request *req) {}
 #endif
-
 bool nvme_wait_reset(struct nvme_ctrl *ctrl);
 int nvme_try_sched_reset(struct nvme_ctrl *ctrl);
 
-- 
2.31.1



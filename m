Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2E1BC6FD1F
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Mar 2023 23:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LNvOeoQcMO6uXBr1eWTL9wfo8ylld4hXHFnObvxMY9o=; b=Nrg2WYBTrixwLuBqEeaW9WgYSG
	IUtSICNIn9wri+kdsGw4W8dLmc5LNZUflc74x3pWO29h5JEImap6/YRL+MGwyDDh9voZVbzjye05L
	7k7qfxjRFVwQEu2vJ+6f8797vHwuCNyrC7qLN2xoaKd1SqDf6zV8JBABRav2gZySPz/bKWVvW5NSO
	zPR48+x9FjiQ1OaRWn3Eyxxd45fTEPKaBIBSGtLPeA2pxf8kdCOB0OvwYzSW/cO4/2k31tn+MHu5B
	Df3sE8EUW3dOpfpK/24da2Ey5+G1VR4r82WVQokGDrPfGFdCbi8CAfYQEPdoBbmu8NW1IpbbAg6ps
	EB0J3jmg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pcxMl-000MIQ-0b;
	Thu, 16 Mar 2023 23:50:39 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pcxMi-000MH7-0S
	for linux-nvme@lists.infradead.org;
	Thu, 16 Mar 2023 23:50:37 +0000
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32GNIlc6016618;
	Thu, 16 Mar 2023 23:50:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2022-7-12;
 bh=LNvOeoQcMO6uXBr1eWTL9wfo8ylld4hXHFnObvxMY9o=;
 b=YD2A8lukbKk1RNkkRbIwXwufolAJUzX6jR5Y0YkTtBTXxc50sbZYe9Er/vWvfQvtyrVG
 7b+V3VgRGHXLWzxN5+MmRgJFEQUHieS07Qv5eT/o9+LP2M+Y+l/17GzlG+8t2N24VDef
 PnhrgYpTFvFBa/7Cu9GB9Vq9ezE7UReQjhmsJAuai/EoimcBjD2iTu+GYCtkqtoJEYIZ
 OtDl2OdE6BI5IgF+Xsx6VtPKm/Pm0OjYc7WPeA04b3+5nAz4nq2ndmfUYIo8OwGwa+mv
 ADAgTc+3y7YoIdcVo9o3ACLv4C7yyVcBBQhz5JeDKPQ9i3yapv0jVZdbkV4G9UfagZ0N Sw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pbs29th4h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Mar 2023 23:50:09 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32GMAZrL020550;
	Thu, 16 Mar 2023 23:50:09 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pbq471uww-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Mar 2023 23:50:08 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32GNnxeg029512;
	Thu, 16 Mar 2023 23:50:08 GMT
Received: from ca-dev94.us.oracle.com (ca-dev94.us.oracle.com [10.129.136.30])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3pbq471ute-3;
	Thu, 16 Mar 2023 23:50:01 +0000
From: Alan Adamson <alan.adamson@oracle.com>
To: linux-nvme@lists.infradead.org
Cc: alan.adamson@oracle.com, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me
Subject: [RFC 2/2] nvme: add error logging opt-in
Date: Thu, 16 Mar 2023 16:49:58 -0700
Message-Id: <20230316234958.1486700-3-alan.adamson@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230316234958.1486700-1-alan.adamson@oracle.com>
References: <20230316234958.1486700-1-alan.adamson@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-16_15,2023-03-16_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 suspectscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303160177
X-Proofpoint-GUID: ZWxjXdWLxtHiJvBp0fvqIPb1e9cR8eQ-
X-Proofpoint-ORIG-GUID: ZWxjXdWLxtHiJvBp0fvqIPb1e9cR8eQ-
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230316_165036_569159_3F8FDC67 
X-CRM114-Status: GOOD (  21.15  )
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

Commit d7ac8dca938c ("nvme: quiet user passthrough command errors") disabled error
logging for user passthrough commands.  This commit adds the ability to opt-in
to passthrough error logging.

To enable passthrough error logging:
	echo Y > /sys/kernel/debug/nvme0/error-logging

To disable passthrough error logging:
	echo N > /sys/kernel/debug/nvme0/error-logging

By default, passthrough error logging will remain disabled.

CONFIG_NVME_ERROR_LOGGING_DEBUG_FS needs to be enabled to
to enable passthrough error logging.

Signed-off-by: Alan Adamson <alan.adamson@oracle.com>
---
 drivers/nvme/host/Kconfig        |  6 ++++++
 drivers/nvme/host/core.c         | 13 +++++++++++--
 drivers/nvme/host/ioctl.c        |  1 +
 drivers/nvme/host/nvme-debugfs.c |  6 ++++++
 drivers/nvme/host/nvme.h         |  8 ++++++++
 5 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
index 70f380c1ccae..5677292727bf 100644
--- a/drivers/nvme/host/Kconfig
+++ b/drivers/nvme/host/Kconfig
@@ -38,6 +38,12 @@ config NVME_FAULT_INJECTION_DEBUG_FS
 	help
 	   This enables NVMe Fault Injection through debugfs.
 
+config NVME_ERROR_LOGGING_DEBUG_FS
+	bool "NVMe Pass Thru Error Logging"
+	depends on FAULT_INJECTION_DEBUG_FS
+	help
+	   This enables NVMe Pass Thru command error logging.
+
 config NVME_HWMON
 	bool "NVMe hardware monitoring"
 	depends on (NVME_CORE=y && HWMON=y) || (NVME_CORE=m && HWMON)
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index cf5db19d50a5..eb8d7caf2887 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -666,6 +666,8 @@ static inline void nvme_clear_nvme_request(struct request *req)
 /* initialize a passthrough request */
 void nvme_init_request(struct request *req, struct nvme_command *cmd)
 {
+	struct nvme_request *nr = nvme_req(req);
+
 	if (req->q->queuedata)
 		req->timeout = NVME_IO_TIMEOUT;
 	else /* no queuedata implies admin queue */
@@ -678,8 +680,11 @@ void nvme_init_request(struct request *req, struct nvme_command *cmd)
 	if (req->mq_hctx->type == HCTX_TYPE_POLL)
 		req->cmd_flags |= REQ_POLLED;
 	nvme_clear_nvme_request(req);
-	req->rq_flags |= RQF_QUIET;
-	memcpy(nvme_req(req)->cmd, cmd, sizeof(*cmd));
+
+	if (!nr->ctrl->debugfs.error_logging)
+		req->rq_flags |= RQF_QUIET;
+
+	memcpy(nr->cmd, cmd, sizeof(*cmd));
 }
 EXPORT_SYMBOL_GPL(nvme_init_request);
 
@@ -5183,6 +5188,10 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 
 	nvme_debugfs_init(&ctrl->debugfs, dev_name(ctrl->device));
 	nvme_fault_inject_init(&ctrl->debugfs);
+
+	ctrl->debugfs.error_logging = false;
+	nvme_error_logging_init(&ctrl->debugfs);
+
 	nvme_mpath_init_ctrl(ctrl);
 	ret = nvme_auth_init_ctrl(ctrl);
 	if (ret)
diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 723e7d5b778f..55d3f86524bf 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -243,6 +243,7 @@ static int nvme_submit_user_cmd(struct request_queue *q,
 	ctrl = nvme_req(req)->ctrl;
 
 	effects = nvme_passthru_start(ctrl, ns, cmd->common.opcode);
+
 	ret = nvme_execute_rq(req, false);
 	if (result)
 		*result = le64_to_cpu(nvme_req(req)->result.u64);
diff --git a/drivers/nvme/host/nvme-debugfs.c b/drivers/nvme/host/nvme-debugfs.c
index 87f78b864225..09953626a1dd 100644
--- a/drivers/nvme/host/nvme-debugfs.c
+++ b/drivers/nvme/host/nvme-debugfs.c
@@ -77,4 +77,10 @@ void nvme_should_fail(struct request *req)
 }
 EXPORT_SYMBOL_GPL(nvme_should_fail);
 #endif /* CONFIG_NVME_FAULT_INJECTION_DEBUG_FS */
+#ifdef CONFIG_NVME_ERROR_LOGGING_DEBUG_FS
+void nvme_error_logging_init(struct nvme_debugfs *debugfs)
+{
+	debugfs_create_bool("error-logging", 0600, debugfs->parent, &debugfs->error_logging);
+}
+#endif /* CONFIG_NVME_ERROR_LOGGING_DEBUG_FS */
 #endif /* CONFIG_FAULT_INJECTION_DEBUG_FS */
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 53d61723ca59..74bdf5fd9abd 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -239,6 +239,7 @@ struct nvme_fault_inject {
 struct nvme_debugfs {
 	struct dentry *parent;
 	struct nvme_fault_inject fault_inject;
+	bool error_logging;
 };
 
 enum nvme_ctrl_flags {
@@ -618,6 +619,13 @@ static inline void nvme_fault_inject_init(struct nvme_debugfs *debugfs)
 }
 static inline void nvme_should_fail(struct request *req) {}
 #endif
+#ifdef CONFIG_NVME_ERROR_LOGGING_DEBUG_FS
+void nvme_error_logging_init(struct nvme_debugfs *debugfs);
+#else
+static inline void nvme_error_logging_init(struct nvme_debugfs *debugfs)
+{
+}
+#endif /* CONFIG_NVME_ERROR_LOGGING_DEBUG_FS */
 bool nvme_wait_reset(struct nvme_ctrl *ctrl);
 int nvme_try_sched_reset(struct nvme_ctrl *ctrl);
 
-- 
2.31.1



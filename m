Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 586A4C761AF
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Mar 2023 23:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YjEhF+a1LmtpIvKy4p1k20bYWBSjqSMCDcptlENNGic=; b=UrYtmwUruWIBY2H33lnqJlI0/L
	QqXdBftDHjPH03VkKCLHUhWs/y5xtz6vJL6+89tWsZ5O6ZYFsdn1Ef46Gu0JU+W4/raRtlQU9jUUS
	YpA6ZNO0gHaJl3MWfOt5ypn+ECkl1+vgqU/l/FZ++d617zUg3QlkozVl8mSExPyNVVPlou3AFlhr6
	KtgsKACGpO8BD5yKbC8VxHadN5U1750WwqQgb/Q8kQKQr3+lULGgzd1H/A40kGkT9jVMDsNQenECc
	Fl/IATRx4Y5QSEs63q3OCIhoF0nm0YnNhi8LDk2YtHVdbQbzQBvYH9EcAhHtZt+tjY6YtjeYliZbU
	J/H+I0Ag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pfTyi-0039ub-2T;
	Thu, 23 Mar 2023 23:04:16 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pfTyb-0039qh-17
	for linux-nvme@lists.infradead.org;
	Thu, 23 Mar 2023 23:04:14 +0000
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32NMsrOM021936;
	Thu, 23 Mar 2023 23:03:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2022-7-12;
 bh=YjEhF+a1LmtpIvKy4p1k20bYWBSjqSMCDcptlENNGic=;
 b=otv8DqERJoqkPt36BwU2nVwZ8TaJt5J6DlsNeyUEQ91By8ESKkzrHUbkvSXZEawRiwAu
 jHWecFksTU4qLpTl/hT1cDk8ZBHcbgmFp0bGAH7TqPlWCpauHA2cgVq35bfStvBg0reL
 WoeMdo8VYCv3DbYd/nflrTVabw+KeEH4b2Ojt9dJTgy5D7CexHok7Jv466gW+oP+BYSj
 AebXKUFLLunbT8gGmkZaEHbYiUlLKcFpGjPb/j5uT2HhT1hlK2ZDzAGgWsiCtXfrtQdj
 LEyCD2GAgA/wFCm3QC4Bc+cpo8i4FMqDcQIMshpLSArmkLKNptUZ0OQLF7CIJDnrPUD5 5w== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pgyyn80au-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Mar 2023 23:03:55 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32NLJLlh001364;
	Thu, 23 Mar 2023 23:03:43 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3pgxk3akyb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Mar 2023 23:03:43 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32NN3fh7040061;
	Thu, 23 Mar 2023 23:03:42 GMT
Received: from ca-dev94.us.oracle.com (ca-dev94.us.oracle.com [10.129.136.30])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3pgxk3akmn-3;
	Thu, 23 Mar 2023 23:03:42 +0000
From: Alan Adamson <alan.adamson@oracle.com>
To: linux-nvme@lists.infradead.org
Cc: alan.adamson@oracle.com, p.raghav@samsung.com, kbusch@kernel.org,
        hch@lst.de, sagi@grimberg.me
Subject: [RFC v2 2/3] nvme: add error logging opt-in
Date: Thu, 23 Mar 2023 16:03:15 -0700
Message-Id: <20230323230316.2914077-3-alan.adamson@oracle.com>
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
X-Proofpoint-GUID: RRFF4n0kI7VM-Z_gZQOG9BSVqUUqH1u_
X-Proofpoint-ORIG-GUID: RRFF4n0kI7VM-Z_gZQOG9BSVqUUqH1u_
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230323_160410_231059_805955CC 
X-CRM114-Status: GOOD (  19.72  )
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
        echo 1 > /sys/kernel/debug/nvme0/error-logging

To disable passthrough error logging:
        echo 0 > /sys/kernel/debug/nvme0/error-logging

By default, passthrough error logging will remain disabled.

CONFIG_NVME_ERROR_LOGGING_DEBUG_FS needs to be enabled to
to enable passthrough error logging.

Signed-off-by: Alan Adamson <alan.adamson@oracle.com>
---
 drivers/nvme/host/Kconfig        |  6 ++++++
 drivers/nvme/host/core.c         | 14 ++++++++++++--
 drivers/nvme/host/nvme-debugfs.c |  7 +++++--
 drivers/nvme/host/nvme.h         |  2 ++
 4 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
index 70f380c1ccae..def7940f6444 100644
--- a/drivers/nvme/host/Kconfig
+++ b/drivers/nvme/host/Kconfig
@@ -38,6 +38,12 @@ config NVME_FAULT_INJECTION_DEBUG_FS
 	help
 	   This enables NVMe Fault Injection through debugfs.
 
+config NVME_ERROR_LOGGING_DEBUG_FS
+	bool "NVMe Passthrough Error Logging"
+	depends on FAULT_INJECTION_DEBUG_FS
+	help
+	   This enables NVMe Passthrough command error logging.
+
 config NVME_HWMON
 	bool "NVMe hardware monitoring"
 	depends on (NVME_CORE=y && HWMON=y) || (NVME_CORE=m && HWMON)
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 679d87d4f5e8..48e9abacd80b 100644
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
+	if (!nr->ctrl->error_logging)
+		req->rq_flags |= RQF_QUIET;
+
+	memcpy(nr->cmd, cmd, sizeof(*cmd));
 }
 EXPORT_SYMBOL_GPL(nvme_init_request);
 
@@ -5193,6 +5198,11 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 
 	nvme_debugfs_init(&ctrl->debugfs, dev_name(ctrl->device));
 	nvme_fault_inject_init(&ctrl->debugfs);
+
+	ctrl->error_logging = false;
+	if (IS_ENABLED(CONFIG_NVME_ERROR_LOGGING_DEBUG_FS))
+		nvme_error_logging_init(ctrl);
+
 	nvme_mpath_init_ctrl(ctrl);
 	ret = nvme_auth_init_ctrl(ctrl);
 	if (ret)
diff --git a/drivers/nvme/host/nvme-debugfs.c b/drivers/nvme/host/nvme-debugfs.c
index 87f78b864225..58dadbbfd67c 100644
--- a/drivers/nvme/host/nvme-debugfs.c
+++ b/drivers/nvme/host/nvme-debugfs.c
@@ -8,7 +8,6 @@
 #include <linux/moduleparam.h>
 #include "nvme.h"
 
-#ifdef CONFIG_FAULT_INJECTION_DEBUG_FS
 void nvme_debugfs_init(struct nvme_debugfs *debugfs,
 		  const char *dev_name)
 {
@@ -77,4 +76,8 @@ void nvme_should_fail(struct request *req)
 }
 EXPORT_SYMBOL_GPL(nvme_should_fail);
 #endif /* CONFIG_NVME_FAULT_INJECTION_DEBUG_FS */
-#endif /* CONFIG_FAULT_INJECTION_DEBUG_FS */
+void nvme_error_logging_init(struct nvme_ctrl *ctrl)
+{
+	debugfs_create_bool("error-logging", 0600, ctrl->debugfs.parent,
+		&ctrl->error_logging);
+}
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 53d61723ca59..30eb9715e086 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -252,6 +252,7 @@ struct nvme_ctrl {
 	bool comp_seen;
 	enum nvme_ctrl_state state;
 	bool identified;
+	bool error_logging;
 	spinlock_t lock;
 	struct mutex scan_lock;
 	const struct nvme_ctrl_ops *ops;
@@ -618,6 +619,7 @@ static inline void nvme_fault_inject_init(struct nvme_debugfs *debugfs)
 }
 static inline void nvme_should_fail(struct request *req) {}
 #endif
+void nvme_error_logging_init(struct nvme_ctrl *ctrl);
 bool nvme_wait_reset(struct nvme_ctrl *ctrl);
 int nvme_try_sched_reset(struct nvme_ctrl *ctrl);
 
-- 
2.31.1



Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAAF8CA0FE2
	for <linux-nvme@archiver.kernel.org>; Thu, 31 Aug 2023 23:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0/0HCldJlNW9RGD9PzX6DAuIZoRrXRhAV33cFZkML/M=; b=Y3FqBDg1Rz6+PZGGlELsLczgEC
	R2UM+wOh47KbEl6lQGZfg45K0IC6w4hHgcMTdGwh2NIpLAl2u+2JF8Sf/JFS275m1qYK8vO1OqUb2
	BgagmZCIy0FD/RDn4pivtggi/yQ06JvKiOssWrGHPFB/FisXEMFrj19frBeBzbHJyawX0sZA75bz+
	1d69gWR2A1eVyUjMyYhgno81HJcnQvyTG8VM2lY2AxIHxIXk7yBjDdGhURROUj7ITorsWna3i4KTL
	j8wSagPBAUHjV7HqDj0z8oiyCvryvC6mhBwaCq2NzTLpdCersDRWwsmuRaZEr2ykU0KkCf5ETGhHh
	2alNxPEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qbqw1-00Fx73-02;
	Thu, 31 Aug 2023 23:18:45 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qbqvy-00Fx6c-0K
	for linux-nvme@lists.infradead.org;
	Thu, 31 Aug 2023 23:18:43 +0000
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37VMxo7i021807;
	Thu, 31 Aug 2023 23:18:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=0/0HCldJlNW9RGD9PzX6DAuIZoRrXRhAV33cFZkML/M=;
 b=I3fIADV+0MQgfp/ARntbL2tDOVCHDwQHuDtkxgY3XMj/mUUzcppcqqh6LjR1oFf0hetp
 WU6kyUfAGon7tGiugIDxC2Qo56Nk1rQEowb84pluJqgwQZGiIN/zc5UUJFl7qkiz6AGi
 RVOxCd3ThQFH6/msdA32P9EyXWz+QzbeHOGPPbIzXmtOALUPxLn8aE3eMd9sBigeEsvj
 KZmDfxw/gSErIYIz27KiNbxGN5+09JjZeQq5FBJnjALXEC9MTeoacuQz7JFBfL2a8VUp
 OuEDd2yGqOJYvjLenShyStxlDU11ltGUncp9g06+2KlvS9uQn1EKyLlIC+deCf2J0EQ8 CA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sq9xtb0dm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 31 Aug 2023 23:18:35 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37VLbmjv024397;
	Thu, 31 Aug 2023 23:18:34 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sr6drmphq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 31 Aug 2023 23:18:34 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37VNIWXg032008;
	Thu, 31 Aug 2023 23:18:33 GMT
Received: from ca-dev94.us.oracle.com (ca-dev94.us.oracle.com [10.129.136.30])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3sr6drmpds-2;
	Thu, 31 Aug 2023 23:18:33 +0000
From: Alan Adamson <alan.adamson@oracle.com>
To: linux-nvme@lists.infradead.org
Cc: alan.adamson@oracle.com, kch@nvidia.com, kbusch@kernel.org, hch@lst.de,
        sagi@grimberg.me
Subject: [PATCH V7 1/1] nvme: allow passthru cmd error logging
Date: Thu, 31 Aug 2023 16:18:27 -0700
Message-Id: <20230831231827.3896883-2-alan.adamson@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230831231827.3896883-1-alan.adamson@oracle.com>
References: <20230831231827.3896883-1-alan.adamson@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-31_20,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308310208
X-Proofpoint-ORIG-GUID: DN_cv6fvl9b-hO5qDowPNzGz_xgFLecQ
X-Proofpoint-GUID: DN_cv6fvl9b-hO5qDowPNzGz_xgFLecQ
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230831_161842_179179_BD86EA6E 
X-CRM114-Status: GOOD (  24.19  )
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

Commit d7ac8dca938c ("nvme: quiet user passthrough command errors")
disabled error logging for user passthrough commands.  This commit
adds the ability to opt-in to passthrough admin error logging. IO
commands initiated as passthrough will always be logged.

The logging output for passthrough commands (Admin and IO) has been
changed to include CDWXX fields.

nvme0n1: Read(0x2), LBA Out of Range (sct 0x0 / sc 0x80) DNR cdw10=0x0 cdw11=0x1
        cdw12=0x70000 cdw13=0x0 cdw14=0x0 cdw15=0x0

Add a helper function nvme_log_err_passthru() which allows us to log
error for passthru commands by decoding cdw10-cdw15 values of nvme
command.

Add a new sysfs attr passthru_err_log_enabled that allows user to conditionally
enable passthru command logging, by default it is disabled.

To enable passthrough admin error logging:
        echo 1 > /sys/class/nvme/nvme0/passthru_err_log_enabled

To disable passthrough admin error logging:
        echo 0 > /sys/class/nvme/nvme0/passthru_err_log_enabled

Signed-off-by: Alan Adamson <alan.adamson@oracle.com>
[kch] fix sevaral nits and trim down code, details in cover-letter.
Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/host/core.c  | 43 ++++++++++++++++++++++++++++++++++-----
 drivers/nvme/host/nvme.h  |  1 +
 drivers/nvme/host/sysfs.c | 29 ++++++++++++++++++++++++++
 3 files changed, 68 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f3a01b79148c..1bf933c886fd 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -337,6 +337,30 @@ static void nvme_log_error(struct request *req)
 			   nr->status & NVME_SC_DNR  ? "DNR "  : "");
 }
 
+static void nvme_log_err_passthru(struct request *req)
+{
+	struct nvme_ns *ns = req->q->queuedata;
+	struct nvme_request *nr = nvme_req(req);
+
+	pr_err_ratelimited("%s: %s(0x%x), %s (sct 0x%x / sc 0x%x) %s%s"
+		"cdw10=0x%x cdw11=0x%x cdw12=0x%x cdw13=0x%x cdw14=0x%x cdw15=0x%x\n",
+		ns ? ns->disk->disk_name : dev_name(nr->ctrl->device),
+		ns ? nvme_get_opcode_str(nr->cmd->common.opcode) :
+		     nvme_get_admin_opcode_str(nr->cmd->common.opcode),
+		nr->cmd->common.opcode,
+		nvme_get_error_status_str(nr->status),
+		nr->status >> 8 & 7,	/* Status Code Type */
+		nr->status & 0xff,	/* Status Code */
+		nr->status & NVME_SC_MORE ? "MORE " : "",
+		nr->status & NVME_SC_DNR  ? "DNR "  : "",
+		nr->cmd->common.cdw10,
+		nr->cmd->common.cdw11,
+		nr->cmd->common.cdw12,
+		nr->cmd->common.cdw13,
+		nr->cmd->common.cdw14,
+		nr->cmd->common.cdw14);
+}
+
 enum nvme_disposition {
 	COMPLETE,
 	RETRY,
@@ -381,8 +405,12 @@ static inline void nvme_end_req(struct request *req)
 {
 	blk_status_t status = nvme_error_status(nvme_req(req)->status);
 
-	if (unlikely(nvme_req(req)->status && !(req->rq_flags & RQF_QUIET)))
-		nvme_log_error(req);
+	if (unlikely(nvme_req(req)->status && !(req->rq_flags & RQF_QUIET))) {
+		if (blk_rq_is_passthrough(req))
+			nvme_log_err_passthru(req);
+		else
+			nvme_log_error(req);
+	}
 	nvme_end_req_zoned(req);
 	nvme_trace_bio_complete(req);
 	if (req->cmd_flags & REQ_NVME_MPATH)
@@ -675,10 +703,15 @@ static inline void nvme_clear_nvme_request(struct request *req)
 /* initialize a passthrough request */
 void nvme_init_request(struct request *req, struct nvme_command *cmd)
 {
+	struct nvme_request *nr = nvme_req(req);
+
 	if (req->q->queuedata)
 		req->timeout = NVME_IO_TIMEOUT;
-	else /* no queuedata implies admin queue */
+	else { /* no queuedata implies admin queue */
 		req->timeout = NVME_ADMIN_TIMEOUT;
+		if (!nr->ctrl->passthru_err_log_enabled)
+			req->rq_flags |= RQF_QUIET;
+	}
 
 	/* passthru commands should let the driver set the SGL flags */
 	cmd->common.flags &= ~NVME_CMD_SGL_ALL;
@@ -687,8 +720,7 @@ void nvme_init_request(struct request *req, struct nvme_command *cmd)
 	if (req->mq_hctx->type == HCTX_TYPE_POLL)
 		req->cmd_flags |= REQ_POLLED;
 	nvme_clear_nvme_request(req);
-	req->rq_flags |= RQF_QUIET;
-	memcpy(nvme_req(req)->cmd, cmd, sizeof(*cmd));
+	memcpy(nr->cmd, cmd, sizeof(*cmd));
 }
 EXPORT_SYMBOL_GPL(nvme_init_request);
 
@@ -4415,6 +4447,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	int ret;
 
 	ctrl->state = NVME_CTRL_NEW;
+	ctrl->passthru_err_log_enabled = false;
 	clear_bit(NVME_CTRL_FAILFAST_EXPIRED, &ctrl->flags);
 	spin_lock_init(&ctrl->lock);
 	mutex_init(&ctrl->scan_lock);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index f35647c470af..7da6285fc30a 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -256,6 +256,7 @@ enum nvme_ctrl_flags {
 struct nvme_ctrl {
 	bool comp_seen;
 	bool identified;
+	bool passthru_err_log_enabled;
 	enum nvme_ctrl_state state;
 	spinlock_t lock;
 	struct mutex scan_lock;
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 212e1b05d298..fbca06a4e4ce 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -35,6 +35,34 @@ static ssize_t nvme_sysfs_rescan(struct device *dev,
 }
 static DEVICE_ATTR(rescan_controller, S_IWUSR, NULL, nvme_sysfs_rescan);
 
+static ssize_t nvme_passthru_err_log_enabled_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, ctrl->passthru_err_log_enabled ? "on" : "off");
+}
+
+static ssize_t nvme_passthru_err_log_enabled_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+	int err;
+	bool passthru_err_log_enabled;
+
+	err = kstrtobool(buf, &passthru_err_log_enabled);
+	if (err)
+		return -EINVAL;
+
+	ctrl->passthru_err_log_enabled = passthru_err_log_enabled;
+
+	return count;
+}
+
+static DEVICE_ATTR(passthru_err_log_enabled, S_IRUGO | S_IWUSR,
+	nvme_passthru_err_log_enabled_show,
+	nvme_passthru_err_log_enabled_store);
+
 static inline struct nvme_ns_head *dev_to_ns_head(struct device *dev)
 {
 	struct gendisk *disk = dev_to_disk(dev);
@@ -554,6 +582,7 @@ static struct attribute *nvme_dev_attrs[] = {
 	&dev_attr_dhchap_secret.attr,
 	&dev_attr_dhchap_ctrl_secret.attr,
 #endif
+	&dev_attr_passthru_err_log_enabled.attr,
 	NULL
 };
 
-- 
2.39.3



Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08F4EC47DA9
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Jan 2024 00:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=t6yd8tdlUIDzHB9ZreSiveVXAFRmn/5t5Wkj3UfPNOY=; b=BfYQEnpWWKTzMiA69mku71oCPS
	jHCH5Cv2FrUz+WbLDShh61366+aEgeAKBvbkvWT3wJJeTV/pE6+TRz5W0Jauk6sy2nE8+D/e1WFdS
	9ioOJMLhHV0cUKh0vob3YttVXjNNIngukcHEvEwvCOTQkbSqkPpK1XNG0sv7ckp8vkUNFJYStT7hB
	+eNUJ+APa/ITEYHCJPI8XUZGAML0aD7jL1NgMnjJo5kT/YJBbnXjPIvC0c+b1O+NXkqoyxjeEg4zG
	rSBEWXHMxR3PktNuM9p5QvrTKBs3fgN3Lmyk5zWv3j6+hfV1kmv0D0uBlqJg/EIGSNHh3wuD03n9a
	6gWJt64w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUbpo-0000000EgEy-3UfO;
	Tue, 30 Jan 2024 00:18:40 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUbpl-0000000EgE5-0i0X
	for linux-nvme@lists.infradead.org;
	Tue, 30 Jan 2024 00:18:38 +0000
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40TJidPZ030876;
	Tue, 30 Jan 2024 00:18:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=t6yd8tdlUIDzHB9ZreSiveVXAFRmn/5t5Wkj3UfPNOY=;
 b=MMUn756dTVB2J9e452oxbAp4HtcqvAqGYzn3J1g5bwB/OvU0ekvv83PBqgpDCqR/AjOw
 KKI/gJ+GHHGXti11Jp2xGQtNQeyyYBBV+PBxxPUXF2tfv6Xw0xNm6CkbTWShLHLJ8I+t
 q9UK1RRMIYEUVrPY09y9lq9DnL7jUfVEsRI43+edQ2Efx3cJmvpokQsBaBz9VqMLlj5c
 FI38e81xr+AEdk6o98qR2ArQXSPXRHIXvIMfZr4LIBKYy6pJs0vldXA/76yOIonjldGn
 +Fi7dKyxU+yqDgoktJJPRioTySaAhXi60OagOf0eg0570difSMi/M5yjS7DGpAOFK7fN HQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvrrcdd9f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jan 2024 00:18:27 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40TNtWbU014634;
	Tue, 30 Jan 2024 00:18:26 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vvr9cnnkm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jan 2024 00:18:26 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40U0IOrX028387;
	Tue, 30 Jan 2024 00:18:26 GMT
Received: from ca-dev94.us.oracle.com (ca-dev94.us.oracle.com [10.129.136.30])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3vvr9cnne3-2;
	Tue, 30 Jan 2024 00:18:25 +0000
From: Alan Adamson <alan.adamson@oracle.com>
To: linux-nvme@lists.infradead.org
Cc: alan.adamson@oracle.com, kch@nvidia.com, kbusch@kernel.org, hch@lst.de,
        sagi@grimberg.me
Subject: [PATCH V9 1/1] nvme: allow passthru cmd error logging
Date: Mon, 29 Jan 2024 16:19:38 -0800
Message-Id: <20240130001938.1103354-2-alan.adamson@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240130001938.1103354-1-alan.adamson@oracle.com>
References: <20240130001938.1103354-1-alan.adamson@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-29_15,2024-01-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 bulkscore=0 malwarescore=0 suspectscore=0 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401300001
X-Proofpoint-ORIG-GUID: fPwRGFDNbmysesaSWtv3_T3E1v6LbQ1S
X-Proofpoint-GUID: fPwRGFDNbmysesaSWtv3_T3E1v6LbQ1S
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240129_161837_442728_669BB06E 
X-CRM114-Status: GOOD (  25.92  )
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
enable passthrough command logging for either passthrough Admin commands sent to
the controller or passthrough IO commands sent to a namespace.

By default, passthrough error logging is disabled.

To enable passthrough admin error logging:
        echo 1 > /sys/class/nvme/nvme0/passthru_err_log_enabled

To disable passthrough admin error logging:
        echo 0 > /sys/class/nvme/nvme0/passthru_err_log_enabled

To enable passthrough io error logging:
        echo 1 > /sys/class/nvme/nvme0/nvme0n1/passthru_err_log_enabled

To disable passthrough io error logging:
        echo 0 > /sys/class/nvme/nvme0/nvme0n1/passthru_err_log_enabled

Signed-off-by: Alan Adamson <alan.adamson@oracle.com>
[kch] fix sevaral nits and trim down code, details in cover-letter.
Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/host/core.c  | 59 +++++++++++++++++++++++++++++++++++----
 drivers/nvme/host/nvme.h  |  3 +-
 drivers/nvme/host/sysfs.c | 57 +++++++++++++++++++++++++++++++++++++
 3 files changed, 112 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 85ab0fcf9e88..76bf72e4b2ff 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -338,6 +338,30 @@ static void nvme_log_error(struct request *req)
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
@@ -385,8 +409,12 @@ static inline void nvme_end_req(struct request *req)
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
@@ -679,10 +707,21 @@ static inline void nvme_clear_nvme_request(struct request *req)
 /* initialize a passthrough request */
 void nvme_init_request(struct request *req, struct nvme_command *cmd)
 {
-	if (req->q->queuedata)
+	struct nvme_request *nr = nvme_req(req);
+	bool logging_enabled;
+
+	if (req->q->queuedata) {
+		struct nvme_ns *ns = req->q->disk->private_data;
+
+		logging_enabled = ns->passthru_err_log_enabled;
 		req->timeout = NVME_IO_TIMEOUT;
-	else /* no queuedata implies admin queue */
+	} else { /* no queuedata implies admin queue */
+		logging_enabled = nr->ctrl->passthru_err_log_enabled;
 		req->timeout = NVME_ADMIN_TIMEOUT;
+	}
+
+	if (!logging_enabled)
+		req->rq_flags |= RQF_QUIET;
 
 	/* passthru commands should let the driver set the SGL flags */
 	cmd->common.flags &= ~NVME_CMD_SGL_ALL;
@@ -691,8 +730,7 @@ void nvme_init_request(struct request *req, struct nvme_command *cmd)
 	if (req->mq_hctx->type == HCTX_TYPE_POLL)
 		req->cmd_flags |= REQ_POLLED;
 	nvme_clear_nvme_request(req);
-	req->rq_flags |= RQF_QUIET;
-	memcpy(nvme_req(req)->cmd, cmd, sizeof(*cmd));
+	memcpy(nr->cmd, cmd, sizeof(*cmd));
 }
 EXPORT_SYMBOL_GPL(nvme_init_request);
 
@@ -3651,6 +3689,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
 
 	ns->disk = disk;
 	ns->queue = disk->queue;
+	ns->passthru_err_log_enabled = false;
 
 	if (ctrl->opts && ctrl->opts->data_digest)
 		blk_queue_flag_set(QUEUE_FLAG_STABLE_WRITES, ns->queue);
@@ -3714,6 +3753,13 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
 	nvme_mpath_add_disk(ns, info->anagrpid);
 	nvme_fault_inject_init(&ns->fault_inject, ns->disk->disk_name);
 
+	/*
+	 * Set ns->disk->device->driver_data to ns so we can access
+	 * ns->logging_enabled in nvme_passthru_err_log_enabled_store() and
+	 * nvme_passthru_err_log_enabled_show().
+	 */
+	dev_set_drvdata(disk_to_dev(ns->disk), ns);
+
 	return;
 
  out_cleanup_ns_from_list:
@@ -4514,6 +4560,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	int ret;
 
 	WRITE_ONCE(ctrl->state, NVME_CTRL_NEW);
+	ctrl->passthru_err_log_enabled = false;
 	clear_bit(NVME_CTRL_FAILFAST_EXPIRED, &ctrl->flags);
 	spin_lock_init(&ctrl->lock);
 	mutex_init(&ctrl->scan_lock);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 030c80818240..7f9f2a7472e1 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -263,6 +263,7 @@ enum nvme_ctrl_flags {
 struct nvme_ctrl {
 	bool comp_seen;
 	bool identified;
+	bool passthru_err_log_enabled;
 	enum nvme_ctrl_state state;
 	spinlock_t lock;
 	struct mutex scan_lock;
@@ -522,7 +523,7 @@ struct nvme_ns {
 	struct device		cdev_device;
 
 	struct nvme_fault_inject fault_inject;
-
+	bool			passthru_err_log_enabled;
 };
 
 /* NVMe ns supports metadata actions by the controller (generate/strip) */
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 754e91111042..c038531a5a06 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -35,6 +35,61 @@ static ssize_t nvme_sysfs_rescan(struct device *dev,
 }
 static DEVICE_ATTR(rescan_controller, S_IWUSR, NULL, nvme_sysfs_rescan);
 
+static ssize_t nvme_adm_passthru_err_log_enabled_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, ctrl->passthru_err_log_enabled ? "on" : "off");
+}
+
+static ssize_t nvme_adm_passthru_err_log_enabled_store(struct device *dev,
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
+static ssize_t nvme_io_passthru_err_log_enabled_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct nvme_ns *n = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, n->passthru_err_log_enabled ? "on\n" : "off\n");
+}
+
+static ssize_t nvme_io_passthru_err_log_enabled_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct nvme_ns *ns = dev_get_drvdata(dev);
+	int err;
+	bool passthru_err_log_enabled;
+
+	err = kstrtobool(buf, &passthru_err_log_enabled);
+	if (err)
+		return -EINVAL;
+	ns->passthru_err_log_enabled = passthru_err_log_enabled;
+
+	return count;
+}
+
+static struct device_attribute dev_attr_adm_passthru_err_log_enabled = \
+	__ATTR(passthru_err_log_enabled, S_IRUGO | S_IWUSR, \
+	nvme_adm_passthru_err_log_enabled_show, nvme_adm_passthru_err_log_enabled_store);
+
+static struct device_attribute dev_attr_io_passthru_err_log_enabled = \
+	__ATTR(passthru_err_log_enabled, S_IRUGO | S_IWUSR, \
+	nvme_io_passthru_err_log_enabled_show, nvme_io_passthru_err_log_enabled_store);
+
 static inline struct nvme_ns_head *dev_to_ns_head(struct device *dev)
 {
 	struct gendisk *disk = dev_to_disk(dev);
@@ -208,6 +263,7 @@ static struct attribute *nvme_ns_attrs[] = {
 	&dev_attr_ana_grpid.attr,
 	&dev_attr_ana_state.attr,
 #endif
+	&dev_attr_io_passthru_err_log_enabled.attr,
 	NULL,
 };
 
@@ -655,6 +711,7 @@ static struct attribute *nvme_dev_attrs[] = {
 #ifdef CONFIG_NVME_TCP_TLS
 	&dev_attr_tls_key.attr,
 #endif
+	&dev_attr_adm_passthru_err_log_enabled.attr,
 	NULL
 };
 
-- 
2.39.3



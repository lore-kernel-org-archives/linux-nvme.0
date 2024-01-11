Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C09FAC47073
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Jan 2024 00:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1Ls+X1v7PEqG6XPb4VIHkf0gZg82DijQIEb6VvNmSYs=; b=AsZqLyUUn05qgO50+Xl8aYAfUk
	yc9FcvoMPKKy2/E0p4V2WJLa+qA/nKGkUfBVHoiZXk4YLEzPSl/DISfNc8kUA3oq0q0AhLhM2Jc+u
	/K/uVIjuVfrafmzatLMHxVU+S357CtexRm6wdBNLN8bU5DDJLEOIlU2kk9Pjrrox5SZ1jcp2p+4qO
	wZ15e4cVs19M1FRrghyeMtrO2Mtnv4wIXXDH0B4Jg/wzesBQoSGWHDvTNQ0cNVfcYbRioxJ7rdJVW
	2+lpEE1O3TWPx+/7k/D7MiZ/+raY5sQnSv1ZagFVa74EuqPhlNlDHDcfy0zCHVl0VN7ueKAK5keTg
	b68GMs9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rNibt-00EqVw-33;
	Thu, 11 Jan 2024 00:07:49 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rNibq-00EqTA-01
	for linux-nvme@lists.infradead.org;
	Thu, 11 Jan 2024 00:07:48 +0000
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40ANSxoW006573;
	Thu, 11 Jan 2024 00:07:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=1Ls+X1v7PEqG6XPb4VIHkf0gZg82DijQIEb6VvNmSYs=;
 b=XRJS/QZrT1+dgfsCMOguk1zkblvVbSTTc6D1n3OPEA4+xLKxLfjdkETg5iaXXV1N3iAx
 3Ge2WyBT8wpN3Ngkv6eWoutSpB49NYMxPa1NflOmhsdCaATh1Ai6NveT9+0hxF11+pjI
 tDK+Mx9hfsb0DK4rm260/WSWFG9TOW7Z1WvKsUZafP/2TENWs9LAdMU7+79mLrzDTepu
 Q0efOp2FQaAx61VUmQIfyGKXopLT987rLbSrpSTGm6VlLWPTo46TBCzkryPjJSBrSi4B
 GlyYaJuyGXQAQy2j48En4yUWBoHwCAgXy4TF/Q1mRNmCxEqt6vqYZMNk/lwOMDrkJ/q6 Xg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vhx8q0xmf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jan 2024 00:07:37 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40B00Fxo012174;
	Thu, 11 Jan 2024 00:07:36 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vfuwk62bc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jan 2024 00:07:36 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40B02aXn024177;
	Thu, 11 Jan 2024 00:07:36 GMT
Received: from ca-dev94.us.oracle.com (ca-dev94.us.oracle.com [10.129.136.30])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3vfuwk62a1-2;
	Thu, 11 Jan 2024 00:07:36 +0000
From: Alan Adamson <alan.adamson@oracle.com>
To: linux-nvme@lists.infradead.org
Cc: alan.adamson@oracle.com, kch@nvidia.com, kbusch@kernel.org, hch@lst.de,
        sagi@grimberg.me
Subject: [PATCH V8 1/1] nvme: allow passthru cmd error logging
Date: Wed, 10 Jan 2024 16:08:55 -0800
Message-Id: <20240111000855.1800481-2-alan.adamson@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240111000855.1800481-1-alan.adamson@oracle.com>
References: <20240111000855.1800481-1-alan.adamson@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-10_13,2024-01-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401100191
X-Proofpoint-GUID: 3DorMyoOiLNrmy2I689RwKP6WJimqDtd
X-Proofpoint-ORIG-GUID: 3DorMyoOiLNrmy2I689RwKP6WJimqDtd
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240110_160746_164097_6E4939CC 
X-CRM114-Status: GOOD (  26.59  )
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
 drivers/nvme/host/core.c  | 52 ++++++++++++++++++++++++++++++++++-----
 drivers/nvme/host/nvme.h  |  2 ++
 drivers/nvme/host/sysfs.c | 44 +++++++++++++++++++++++++++++++++
 include/linux/device.h    |  1 +
 4 files changed, 93 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 60f14019f981..9bca08bf9e67 100644
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
@@ -675,10 +703,19 @@ static inline void nvme_clear_nvme_request(struct request *req)
 /* initialize a passthrough request */
 void nvme_init_request(struct request *req, struct nvme_command *cmd)
 {
-	if (req->q->queuedata)
+	struct nvme_request *nr = nvme_req(req);
+	struct device *device;
+
+	if (req->q->queuedata) {
 		req->timeout = NVME_IO_TIMEOUT;
-	else /* no queuedata implies admin queue */
+		device = disk_to_dev(req->q->disk);
+	} else { /* no queuedata implies admin queue */
 		req->timeout = NVME_ADMIN_TIMEOUT;
+		device = nr->ctrl->device;
+	}
+
+	if (!device->logging_enabled)
+		req->rq_flags |= RQF_QUIET;
 
 	/* passthru commands should let the driver set the SGL flags */
 	cmd->common.flags &= ~NVME_CMD_SGL_ALL;
@@ -687,8 +724,7 @@ void nvme_init_request(struct request *req, struct nvme_command *cmd)
 	if (req->mq_hctx->type == HCTX_TYPE_POLL)
 		req->cmd_flags |= REQ_POLLED;
 	nvme_clear_nvme_request(req);
-	req->rq_flags |= RQF_QUIET;
-	memcpy(nvme_req(req)->cmd, cmd, sizeof(*cmd));
+	memcpy(nr->cmd, cmd, sizeof(*cmd));
 }
 EXPORT_SYMBOL_GPL(nvme_init_request);
 
@@ -3682,6 +3718,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
 
 	nvme_mpath_add_disk(ns, info->anagrpid);
 	nvme_fault_inject_init(&ns->fault_inject, ns->disk->disk_name);
+	nvme_sysfs_add_passthru_err_log(disk_to_dev(ns->disk));
 
 	return;
 
@@ -3712,6 +3749,7 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 
 	clear_bit(NVME_NS_READY, &ns->flags);
 	set_capacity(ns->disk, 0);
+	nvme_sysfs_remove_passthru_err_log(disk_to_dev(ns->disk));
 	nvme_fault_inject_fini(&ns->fault_inject);
 
 	/*
@@ -4423,6 +4461,7 @@ EXPORT_SYMBOL_GPL(nvme_start_ctrl);
 void nvme_uninit_ctrl(struct nvme_ctrl *ctrl)
 {
 	nvme_hwmon_exit(ctrl);
+	nvme_sysfs_remove_passthru_err_log(ctrl->device);
 	nvme_fault_inject_fini(&ctrl->fault_inject);
 	dev_pm_qos_hide_latency_tolerance(ctrl->device);
 	cdev_device_del(&ctrl->cdev, ctrl->device);
@@ -4550,6 +4589,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 		min(default_ps_max_latency_us, (unsigned long)S32_MAX));
 
 	nvme_fault_inject_init(&ctrl->fault_inject, dev_name(ctrl->device));
+	nvme_sysfs_add_passthru_err_log(ctrl->device);
 	nvme_mpath_init_ctrl(ctrl);
 	ret = nvme_auth_init_ctrl(ctrl);
 	if (ret)
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index e7411dac00f7..7d09437f35b9 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -1101,6 +1101,8 @@ void nvme_passthru_end(struct nvme_ctrl *ctrl, struct nvme_ns *ns, u32 effects,
 struct nvme_ctrl *nvme_ctrl_from_file(struct file *file);
 struct nvme_ns *nvme_find_get_ns(struct nvme_ctrl *ctrl, unsigned nsid);
 void nvme_put_ns(struct nvme_ns *ns);
+int nvme_sysfs_add_passthru_err_log(struct device *dev);
+void nvme_sysfs_remove_passthru_err_log(struct device *dev);
 
 static inline bool nvme_multi_css(struct nvme_ctrl *ctrl)
 {
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index c6b7fbd4d34d..2128df9df0d4 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -35,6 +35,31 @@ static ssize_t nvme_sysfs_rescan(struct device *dev,
 }
 static DEVICE_ATTR(rescan_controller, S_IWUSR, NULL, nvme_sysfs_rescan);
 
+static ssize_t nvme_passthru_err_log_enabled_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, dev->logging_enabled ? "on" : "off");
+}
+
+static ssize_t nvme_passthru_err_log_enabled_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	int err;
+	bool passthru_err_log_enabled;
+
+	err = kstrtobool(buf, &passthru_err_log_enabled);
+	if (err)
+		return -EINVAL;
+
+	dev->logging_enabled = passthru_err_log_enabled;
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
@@ -167,6 +192,25 @@ const struct attribute_group *nvme_ns_id_attr_groups[] = {
 	NULL,
 };
 
+static struct attribute *nvme_log_attrs[] = {
+	&dev_attr_passthru_err_log_enabled.attr,
+	NULL,
+};
+
+static const struct attribute_group nvme_log_attr_group = {
+	.attrs		= nvme_log_attrs,
+};
+
+int nvme_sysfs_add_passthru_err_log(struct device *dev)
+{
+	return sysfs_create_group(&dev->kobj, &nvme_log_attr_group);
+}
+
+void nvme_sysfs_remove_passthru_err_log(struct device *dev)
+{
+	sysfs_remove_group(&dev->kobj, &nvme_log_attr_group);
+}
+
 #define nvme_show_str_function(field)						\
 static ssize_t  field##_show(struct device *dev,				\
 			    struct device_attribute *attr, char *buf)		\
diff --git a/include/linux/device.h b/include/linux/device.h
index 6c83294395ac..30162059756e 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -805,6 +805,7 @@ struct device {
 #ifdef CONFIG_DMA_OPS_BYPASS
 	bool			dma_ops_bypass : 1;
 #endif
+	bool			logging_enabled:1;
 };
 
 /**
-- 
2.39.3



Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18AEBC761A6
	for <linux-nvme@archiver.kernel.org>; Fri, 31 Mar 2023 22:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NHkmmoBXSJpHit5NTl37q6cXTKeTsu4p6oyohpOwb28=; b=2lpYeFMH+C95o3iZelHxgGOrbf
	Wh0g8wALnFTn7KRJdan6c98tQOu8jBWDsDXS7kVuGbD1uhB0mfggiTrB3wxSh8Pyng1ujFy5uqgj4
	bTx2/ImAsMojWduAQWwwFNXFRq+0FdbEffrvNvWTg/TxoGhIo57nsW8omUyr2ZB6CGFVkL+YuDeLh
	w/Z0ZhoRyud2eNdvjTAxrSfwlr+cgRMLUUgEtGin37ukz7ireaEqSikz79uFSsQDW5TZR4KpYOE7/
	8uSQFK1aLOrM4LYP4L5dA/hoqX9C8XH3hDea9sPXpjJoU7fjl8NBmjRi10gmWUX0iGWmIe2erEbxg
	DJCFtQyQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1piN4x-0092WZ-39;
	Fri, 31 Mar 2023 22:18:40 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1piN4s-0092Vk-2u
	for linux-nvme@lists.infradead.org;
	Fri, 31 Mar 2023 22:18:37 +0000
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32VKrXJH001603;
	Fri, 31 Mar 2023 22:18:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2022-7-12;
 bh=NHkmmoBXSJpHit5NTl37q6cXTKeTsu4p6oyohpOwb28=;
 b=WairMDVkg8beX9VqhI7Cg6dfsAuINEH81O7VyStsT8WC0Kijm2aPFVABZ1ggKdFDfrtb
 YoaAm9u/cBfJtRv5lUX2Bq4HXiIa4C7+txwSDKJ6zZnVfO+U6zE7YZQFov8/xCDNLm81
 4IMjx/F53rWww/Uvnl950hZCDuaTtUorbItO7DyQ0/b6YUq6gGDl7adipSwgNZKXLYd6
 ownAAm0G1scxESQjrb1tOBT4Rkm2pseYjzbUtv71sZlZMDkvJClIwI7+V0C9+gY2zX67
 ZimshS9SV6CaF2mJ98CmdK1tVG6dp4PDccAZZeyXwIjfYhRPre2FZCZc1xxapM3vHbNW UA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pmq56y55j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Mar 2023 22:18:28 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32VJo3Ih023439;
	Fri, 31 Mar 2023 22:18:27 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3phqdkhm8v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Mar 2023 22:18:27 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32VMIPaG003191;
	Fri, 31 Mar 2023 22:18:26 GMT
Received: from ca-dev94.us.oracle.com (ca-dev94.us.oracle.com [10.129.136.30])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3phqdkhm7h-2;
	Fri, 31 Mar 2023 22:18:26 +0000
From: Alan Adamson <alan.adamson@oracle.com>
To: linux-nvme@lists.infradead.org
Cc: alan.adamson@oracle.com, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me
Subject: [RFC v3 1/1] nvme: add passthrough error logging opt-in
Date: Fri, 31 Mar 2023 15:18:23 -0700
Message-Id: <20230331221823.2806192-2-alan.adamson@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230331221823.2806192-1-alan.adamson@oracle.com>
References: <20230331221823.2806192-1-alan.adamson@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-31_07,2023-03-31_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 spamscore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2303310182
X-Proofpoint-GUID: k2CnjTwspumB4av4r6Xl3jSukZ0ZADTK
X-Proofpoint-ORIG-GUID: k2CnjTwspumB4av4r6Xl3jSukZ0ZADTK
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230331_151835_246041_747DDE54 
X-CRM114-Status: GOOD (  22.81  )
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
        echo 1 > /sys/class/nvme/nvme0/passthrough_logging

To disable passthrough error logging:
        echo 0 > /sys/class/nvme/nvme0/passthrough_logging

By default, passthrough error logging will remain disabled.

Signed-off-by: Alan Adamson <alan.adamson@oracle.com>
---
 drivers/nvme/host/core.c | 93 ++++++++++++++++++++++++++++++++++++++--
 drivers/nvme/host/nvme.h |  1 +
 2 files changed, 90 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 53ef028596c6..82d4f8235a8f 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -337,6 +337,49 @@ static void nvme_log_error(struct request *req)
 			   nr->status & NVME_SC_DNR  ? "DNR "  : "");
 }
 
+static void nvme_log_error_passthrough(struct request *req)
+{
+	struct nvme_ns *ns = req->q->queuedata;
+	struct nvme_request *nr = nvme_req(req);
+
+	if (ns) {
+		pr_err_ratelimited("%s: %s(0x%x), %s (sct 0x%x / sc 0x%x) %s%s"
+			"cdw10=0x%x cdw11=0x%x cdw12=0x%x cdw13=0x%x cdw14=0x%x cdw15=0x%x\n",
+			ns->disk ? ns->disk->disk_name : "?",
+			nvme_get_opcode_str(nr->cmd->common.opcode),
+			nr->cmd->common.opcode,
+			nvme_get_error_status_str(nr->status),
+			nr->status >> 8 & 7,	/* Status Code Type */
+			nr->status & 0xff,	/* Status Code */
+			nr->status & NVME_SC_MORE ? "MORE " : "",
+			nr->status & NVME_SC_DNR  ? "DNR "  : "",
+			nr->cmd->common.cdw10,
+			nr->cmd->common.cdw11,
+			nr->cmd->common.cdw12,
+			nr->cmd->common.cdw13,
+			nr->cmd->common.cdw14,
+			nr->cmd->common.cdw14);
+		return;
+	}
+
+	pr_err_ratelimited("%s: %s(0x%x), %s (sct 0x%x / sc 0x%x) %s%s"
+			"cdw10=0x%x cdw11=0x%x cdw12=0x%x cdw13=0x%x cdw14=0x%x cdw15=0x%x\n",
+			dev_name(nr->ctrl->device),
+			nvme_get_admin_opcode_str(nr->cmd->common.opcode),
+			nr->cmd->common.opcode,
+			nvme_get_error_status_str(nr->status),
+			nr->status >> 8 & 7,	/* Status Code Type */
+			nr->status & 0xff,	/* Status Code */
+			nr->status & NVME_SC_MORE ? "MORE " : "",
+			nr->status & NVME_SC_DNR  ? "DNR "  : "",
+			nr->cmd->common.cdw10,
+			nr->cmd->common.cdw11,
+			nr->cmd->common.cdw12,
+			nr->cmd->common.cdw13,
+			nr->cmd->common.cdw14,
+			nr->cmd->common.cdw14);
+}
+
 enum nvme_disposition {
 	COMPLETE,
 	RETRY,
@@ -381,8 +424,12 @@ static inline void nvme_end_req(struct request *req)
 {
 	blk_status_t status = nvme_error_status(nvme_req(req)->status);
 
-	if (unlikely(nvme_req(req)->status && !(req->rq_flags & RQF_QUIET)))
-		nvme_log_error(req);
+	if (unlikely(nvme_req(req)->status && !(req->rq_flags & RQF_QUIET))) {
+		if (blk_rq_is_passthrough(req))
+			nvme_log_error_passthrough(req);
+		else
+			nvme_log_error(req);
+	}
 	nvme_end_req_zoned(req);
 	nvme_trace_bio_complete(req);
 	if (req->cmd_flags & REQ_NVME_MPATH)
@@ -666,6 +713,8 @@ static inline void nvme_clear_nvme_request(struct request *req)
 /* initialize a passthrough request */
 void nvme_init_request(struct request *req, struct nvme_command *cmd)
 {
+	struct nvme_request *nr = nvme_req(req);
+
 	if (req->q->queuedata)
 		req->timeout = NVME_IO_TIMEOUT;
 	else /* no queuedata implies admin queue */
@@ -678,8 +727,10 @@ void nvme_init_request(struct request *req, struct nvme_command *cmd)
 	if (req->mq_hctx->type == HCTX_TYPE_POLL)
 		req->cmd_flags |= REQ_POLLED;
 	nvme_clear_nvme_request(req);
-	req->rq_flags |= RQF_QUIET;
-	memcpy(nvme_req(req)->cmd, cmd, sizeof(*cmd));
+	if (!nr->ctrl->error_logging)
+		req->rq_flags |= RQF_QUIET;
+
+	memcpy(nr->cmd, cmd, sizeof(*cmd));
 }
 EXPORT_SYMBOL_GPL(nvme_init_request);
 
@@ -3418,6 +3469,38 @@ static ssize_t nvme_sysfs_rescan(struct device *dev,
 }
 static DEVICE_ATTR(rescan_controller, S_IWUSR, NULL, nvme_sysfs_rescan);
 
+static ssize_t nvme_passthrough_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+
+	if (ctrl->error_logging)
+		return sysfs_emit(buf, "on\n");
+	else
+		return sysfs_emit(buf, "off\n");
+}
+
+static ssize_t nvme_passthrough_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+	int passthrough_enable, err;
+
+	err = kstrtoint(buf, 10, &passthrough_enable);
+	if (err)
+		return -EINVAL;
+
+	if (passthrough_enable)
+		ctrl->error_logging = true;
+	else
+		ctrl->error_logging = false;
+
+	return count;
+}
+
+static DEVICE_ATTR(passthrough_logging, S_IRUGO | S_IWUSR,
+	nvme_passthrough_show, nvme_passthrough_store);
+
 static inline struct nvme_ns_head *dev_to_ns_head(struct device *dev)
 {
 	struct gendisk *disk = dev_to_disk(dev);
@@ -3926,6 +4009,7 @@ static struct attribute *nvme_dev_attrs[] = {
 	&dev_attr_dhchap_secret.attr,
 	&dev_attr_dhchap_ctrl_secret.attr,
 #endif
+	&dev_attr_passthrough_logging.attr,
 	NULL
 };
 
@@ -5125,6 +5209,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	int ret;
 
 	ctrl->state = NVME_CTRL_NEW;
+	ctrl->error_logging = false;
 	clear_bit(NVME_CTRL_FAILFAST_EXPIRED, &ctrl->flags);
 	spin_lock_init(&ctrl->lock);
 	mutex_init(&ctrl->scan_lock);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index bf46f122e9e1..dce5e6f7260c 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -248,6 +248,7 @@ struct nvme_ctrl {
 	bool comp_seen;
 	enum nvme_ctrl_state state;
 	bool identified;
+	bool error_logging;
 	spinlock_t lock;
 	struct mutex scan_lock;
 	const struct nvme_ctrl_ops *ops;
-- 
2.31.1



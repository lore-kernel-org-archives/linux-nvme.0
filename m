Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02A1BC77B74
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Apr 2023 21:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ig5mHuDFfFiUvS4u/elbW2SuVYcFIumqB8ozJ7law70=; b=B7zW1BmX/rPi0A15aGqjbxrbgx
	s6ysS1r2y2i+pxNun447TFVHkYvx3uuxP4pYRobTkgTYVrf9mH7fWVKFpAePcnk/ooNiGij9A0O35
	bpnhy/Ehj5yhneVBSP4kiNZ8gbhsEy9SObbxP8/ZVedj9yxTwnqEVNfhi49sNxLSygzKhq7VOplJ/
	Va8joqdUoWlPrggilt1SzQQP9OcSgYEBD459JPrQwXaWhSROXjaribKpeUIeZkdtHp25NYqwtyTaX
	eoMm8wa6mOz2jb5fNmGj9yGBgNYtRHwCFFv5YoGzR4tI7dRQD1T0x0m9qZHmT97+k/BLisoEcVacZ
	t3HSPASA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pkXaJ-008hFa-2d;
	Thu, 06 Apr 2023 21:55:59 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pkXaF-008hEK-0Q
	for linux-nvme@lists.infradead.org;
	Thu, 06 Apr 2023 21:55:56 +0000
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 336ElPVd009832;
	Thu, 6 Apr 2023 21:55:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2022-7-12;
 bh=ig5mHuDFfFiUvS4u/elbW2SuVYcFIumqB8ozJ7law70=;
 b=EKZ6qWZtIWMBePfzxroV3bUplTv/WrH0V+5NNFmP4mMcSFCYQtBDs3ovCpkNjKBBJE5y
 RMZPnucqJlRcVk3+VY3VPDZOiBYat9BE7D+mvnzorGB4VJuRAc5NU2fI/wwH/CDM7Udw
 QiQY+EKWZ3DGqI1DgW03qD4XlW9d9dvhWDuE3igXAVi5TaBQCjUUIb7GwSg8nBCzgkZB
 DM4UTXlhrj61AtpiEJ0XDfsFMhHB/BjXTwrT05kYpOdOVAXFw1kc43pLldB+wlHPc6ZW
 voT2FlnmuyQhjMROeL6lXjweSfjsEwwP3AzIZra2SEyZFuwRsIjj6UbUlkVF7magwko3 /Q== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ppcnd40vt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Apr 2023 21:55:47 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 336KxC7k036535;
	Thu, 6 Apr 2023 21:55:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pptpawvj2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Apr 2023 21:55:46 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 336LpxEm034232;
	Thu, 6 Apr 2023 21:55:46 GMT
Received: from ca-dev94.us.oracle.com (ca-dev94.us.oracle.com [10.129.136.30])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3pptpawvgb-2;
	Thu, 06 Apr 2023 21:55:46 +0000
From: Alan Adamson <alan.adamson@oracle.com>
To: linux-nvme@lists.infradead.org
Cc: alan.adamson@oracle.com, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me
Subject: [RFC v4 1/1] nvme: add passthrough admin error logging opt-in
Date: Thu,  6 Apr 2023 14:55:44 -0700
Message-Id: <20230406215544.113127-2-alan.adamson@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230406215544.113127-1-alan.adamson@oracle.com>
References: <20230406215544.113127-1-alan.adamson@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-06_12,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304060193
X-Proofpoint-GUID: 1boFaD3IygICgBqN7d9eLhDVBGXWgP5L
X-Proofpoint-ORIG-GUID: 1boFaD3IygICgBqN7d9eLhDVBGXWgP5L
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230406_145555_289616_D02591B4 
X-CRM114-Status: GOOD (  24.49  )
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
to passthrough admin error logging. IO commands initiated as passthrough will always
be logged.

The logging output for passthrough commands (Admin and IO) has been changed to include
CDWXX fields.

nvme0n1: Read(0x2), LBA Out of Range (sct 0x0 / sc 0x80) DNR cdw10=0x0 cdw11=0x1
        cdw12=0x70000 cdw13=0x0 cdw14=0x0 cdw15=0x0

To enable passthrough admin error logging:
        echo 1 > /sys/class/nvme/nvme0/passthru_admin_err_logging

To disable passthrough admin error logging:
        echo 0 > /sys/class/nvme/nvme0/passthru_admin_err_logging

By default, passthrough admin error logging will be disabled.

Signed-off-by: Alan Adamson <alan.adamson@oracle.com>
---
 drivers/nvme/host/core.c | 97 +++++++++++++++++++++++++++++++++++++---
 drivers/nvme/host/nvme.h |  1 +
 2 files changed, 93 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 53ef028596c6..a17a24f4c8af 100644
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
@@ -666,10 +713,15 @@ static inline void nvme_clear_nvme_request(struct request *req)
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
+		if (!nr->ctrl->error_logging)
+			req->rq_flags |= RQF_QUIET;
+	}
 
 	/* passthru commands should let the driver set the SGL flags */
 	cmd->common.flags &= ~NVME_CMD_SGL_ALL;
@@ -678,8 +730,8 @@ void nvme_init_request(struct request *req, struct nvme_command *cmd)
 	if (req->mq_hctx->type == HCTX_TYPE_POLL)
 		req->cmd_flags |= REQ_POLLED;
 	nvme_clear_nvme_request(req);
-	req->rq_flags |= RQF_QUIET;
-	memcpy(nvme_req(req)->cmd, cmd, sizeof(*cmd));
+
+	memcpy(nr->cmd, cmd, sizeof(*cmd));
 }
 EXPORT_SYMBOL_GPL(nvme_init_request);
 
@@ -3418,6 +3470,39 @@ static ssize_t nvme_sysfs_rescan(struct device *dev,
 }
 static DEVICE_ATTR(rescan_controller, S_IWUSR, NULL, nvme_sysfs_rescan);
 
+static ssize_t nvme_passthru_admin_err_logging_show(struct device *dev,
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
+static ssize_t nvme_passthru_admin_err_logging_store(struct device *dev,
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
+static DEVICE_ATTR(passthru_admin_err_logging, S_IRUGO | S_IWUSR,
+	nvme_passthru_admin_err_logging_show,
+	nvme_passthru_admin_err_logging_store);
+
 static inline struct nvme_ns_head *dev_to_ns_head(struct device *dev)
 {
 	struct gendisk *disk = dev_to_disk(dev);
@@ -3926,6 +4011,7 @@ static struct attribute *nvme_dev_attrs[] = {
 	&dev_attr_dhchap_secret.attr,
 	&dev_attr_dhchap_ctrl_secret.attr,
 #endif
+	&dev_attr_passthru_admin_err_logging.attr,
 	NULL
 };
 
@@ -5125,6 +5211,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
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



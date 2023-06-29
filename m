Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3D80EB64D7
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Jun 2023 01:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7M4slCcoxBjUTbsKucFDSuMi5Tve9dT9YKVsAr33EM8=; b=oM55OcldR4yHuEcuLng8Xbxtc0
	44fPHxHdBF2Tykv0e/pSmesEsA1c/zLHjFACCtNU0zChHwNyMZ18iKo/DjTUca46OV2AQQ71St1uF
	tIj2Mv+gWR8yjW4eP3JNcoJbndl2x5VNh5hiRn36REIWkrzyuZUfPwkkEqGRg/kuWxYTPOQVISh5M
	A7yTI8JPa5+F1i5E8d8WVTH2k/lqUe/1pAUaPbDWX5cc60m0sZ/m6TDg3YUe0cy4uGykDO3hX9L/o
	RAygIeyIzz/8MvWTL/Eehjoj+owtLR02I6lWzCvOxD4CoimEyU4phiTAmphQrYOPnTSLGP8dumt0x
	I3+xh4wQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qEgIJ-00HDy6-0F;
	Thu, 29 Jun 2023 01:17:59 +0000
Received: from mail-bn8nam04on20610.outbound.protection.outlook.com ([2a01:111:f400:7e8d::610] helo=NAM04-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qEgIF-00HDxB-2W
	for linux-nvme@lists.infradead.org;
	Thu, 29 Jun 2023 01:17:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Go5skd8aR4wbqWTeJ2a7vMc30dZ6KaMC6ON5ZP14V5zPG+QPPbAElCcLnGLWuEqW8LtvY2AK7eFP3E85yHnCHmP5hAIklEd5niiOcFxYoQnxJdTe3zIDPM/xIFHstWy0Pt8KOwXcMBIoDRJEpyXps22b508spcG0czMSSaFEmsn+9XNXF1+tbYcnvebDKQNiXUjVnCc5sfvNVbXgDApPz0KqnvtKzTEn2xzziu/xKUXvP+Et7GGL8eIORCGxENoArZ7qS0qKfTQ8d5iGyg6puVhjUINnBK3hJ9gWOjX+k0TiFEwoZwR29dt0wJ12WCrWhWP2Zkel61OoMswv6Mh7Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7M4slCcoxBjUTbsKucFDSuMi5Tve9dT9YKVsAr33EM8=;
 b=LGvYqg+lWqsauMyYfGnmJ2TS6/nVp5FeADeBmFo7z49wRdfbY47HhFUGPPCfI91YX/rxdThlRKEOcEdvHa9RyaSWMVUwCCyaU4gYVTwQ2RW2vvUIQC4sA349I4JXINI0vL1PXQ68Ez7giCGLslWU8asVFDnB6Kgr2Z5ONohtdWEDTfaVfU0MyNdEdC/rsJ8nI5J+cDu/EMY648r17PrLl2Db3rIwMLhSJjngliM1jWEK/zngUlDEBBEgCSaVdDAqL4NqxLmqhij1fkxqnB4otiJhcCpWf+mpmQ3J9YiQ2ouw2Huen4F4CORC/OCzkvN9vxwQeDYmoxaNk4DSX/zpRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7M4slCcoxBjUTbsKucFDSuMi5Tve9dT9YKVsAr33EM8=;
 b=pYBV8xXMfLHJrGDL1DCIsIbzQXVaRMR79krlKixV4cWVksCEqBcS6g44/jnxWFNeissW1qt0LGkZO0qr0fgYUCetZ35tTFehbLTH1C5bY4BYiOPgynz+2euo5m+MerDVBw/Iy1diYjcfsErQpnbAeVVFcbiFq5kFgPR+TUv4g+qe6sC6M1LuY6e65Ya+ZQFfOGrjjwAXfED2jZYYSLazQWGvSW3DTF56ocXO5e4X//bUTBKXdGmG+dVrKCFHoYLAUbGLfRxqkAY15uMjLMsZoWD8mhSpMQvIMVLb1PV4Zsyan55AeCgd+AWDVX1lB3qKDl/A4PiUMlrk6H+LIuMPZw==
Received: from BN1PR12CA0029.namprd12.prod.outlook.com (2603:10b6:408:e1::34)
 by SA1PR12MB6971.namprd12.prod.outlook.com (2603:10b6:806:24e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Thu, 29 Jun
 2023 01:17:51 +0000
Received: from BN8NAM11FT093.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e1:cafe::3a) by BN1PR12CA0029.outlook.office365.com
 (2603:10b6:408:e1::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.20 via Frontend
 Transport; Thu, 29 Jun 2023 01:17:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT093.mail.protection.outlook.com (10.13.177.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.48 via Frontend Transport; Thu, 29 Jun 2023 01:17:51 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 28 Jun 2023
 18:17:34 -0700
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 28 Jun
 2023 18:17:34 -0700
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>,
	<alan.adamson@oracle.com>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH V6 1/1] nvme: allow passthru cmd error logging
Date: Wed, 28 Jun 2023 18:17:13 -0700
Message-ID: <20230629011713.28554-2-kch@nvidia.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230629011713.28554-1-kch@nvidia.com>
References: <20230629011713.28554-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT093:EE_|SA1PR12MB6971:EE_
X-MS-Office365-Filtering-Correlation-Id: b6667f56-2a9b-4a7d-0c15-08db783ea8b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i4EgmLlX3OH270EZpkrXVt7aHRD0qcmF4wJyjo2ePN/VFEEHnU2cYfR3Y1iLd8CX4AYuCy1kPwbd44DIZCHi4SimHRzTvsPHlSF8KPO+0y48jy0OIMxV3hukgzcuw/z3Zz9dxO8AnHl7YDRlYBaqIyiaFhjgbNi+lqBFeUIrYZPr6L0G+F3Vc2drxzg4tgrFYiOjhmqFjiGR/vFeqbMVfmzpEPDw1wjBQZhjtTFaGYWdWaOtMfudunRTVxjsUdrWZwYlkNYC/WarRrkImmI62rq2eUBxhO/Omo6z18uUxw0kLlUWPRASuUKEuU2CXGWED2qEwPfu8rnwQVMCHl+pclFW2ZCA/75hp3tDD+GXVbkgRh/04tj4YEaauBK/RTbQJmpLviFM9cMJUhf/N3XjdcQT06falBYEG6cjHA3LSadiJU+uAX89A6G1d5vw5FEU9WabbajvbVLKQpTnClOnnAcruqknejTQga0QlVq0faWZVUChonM6BRsshNliku1A6esaj0H7uX5C5dN3DUsu9N/sinXTlE/wi5li559ltgUGTSZdA78/vQelMvEdr8k65aF4YZols1diy66kdRCUDZ0nPFjtCjGN4xlB8UI6wmR9HABzEhXBMpQAC6yiUQtuzF0vGNRZR/NvGBPtFDeYXyDQR1UPdPhzjn1xWcPt3o73cYIN9BtGAeRB66mI7jkZUDqv6D9cs8ij4Jyo6w9AXyxyqcP3OMKE0T2ekdeW7Aw=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(396003)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(16526019)(40460700003)(2906002)(186003)(7696005)(40480700001)(82310400005)(107886003)(2616005)(82740400003)(83380400001)(7636003)(47076005)(6666004)(426003)(26005)(336012)(356005)(1076003)(36860700001)(41300700001)(54906003)(70206006)(478600001)(316002)(36756003)(4326008)(6916009)(70586007)(5660300002)(8676002)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 01:17:51.5031
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6667f56-2a9b-4a7d-0c15-08db783ea8b9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT093.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6971
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230628_181755_823652_8B0E3330 
X-CRM114-Status: GOOD (  19.26  )
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

From: Alan Adamson <alan.adamson@oracle.com>

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

Add a new sysfs attr passthru_err_log that allows user to conditionally
enable passthru command logging, by default it is disabled.

To enable passthrough admin error logging:
        echo 1 > /sys/class/nvme/nvme0/passthru_err_log

To disable passthrough admin error logging:
        echo 0 > /sys/class/nvme/nvme0/passthru_err_log

Signed-off-by: Alan Adamson <alan.adamson@oracle.com>
[kch] fix sevaral nits and trim down code, details in cover-letter.
Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/host/core.c  | 43 ++++++++++++++++++++++++++++++++++-----
 drivers/nvme/host/nvme.h  |  1 +
 drivers/nvme/host/sysfs.c | 39 +++++++++++++++++++++++++++++++++++
 3 files changed, 78 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 4b7f9edab5e8..62cb9d011b89 100644
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
@@ -666,10 +694,15 @@ static inline void nvme_clear_nvme_request(struct request *req)
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
+		if (!nr->ctrl->passthru_log_err)
+			req->rq_flags |= RQF_QUIET;
+	}
 
 	/* passthru commands should let the driver set the SGL flags */
 	cmd->common.flags &= ~NVME_CMD_SGL_ALL;
@@ -678,8 +711,7 @@ void nvme_init_request(struct request *req, struct nvme_command *cmd)
 	if (req->mq_hctx->type == HCTX_TYPE_POLL)
 		req->cmd_flags |= REQ_POLLED;
 	nvme_clear_nvme_request(req);
-	req->rq_flags |= RQF_QUIET;
-	memcpy(nvme_req(req)->cmd, cmd, sizeof(*cmd));
+	memcpy(nr->cmd, cmd, sizeof(*cmd));
 }
 EXPORT_SYMBOL_GPL(nvme_init_request);
 
@@ -4483,6 +4515,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	int ret;
 
 	ctrl->state = NVME_CTRL_NEW;
+	ctrl->passthru_log_err = false;
 	clear_bit(NVME_CTRL_FAILFAST_EXPIRED, &ctrl->flags);
 	spin_lock_init(&ctrl->lock);
 	mutex_init(&ctrl->scan_lock);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index f3182134487a..fe305d4a9f1b 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -249,6 +249,7 @@ enum nvme_ctrl_flags {
 struct nvme_ctrl {
 	bool comp_seen;
 	bool identified;
+	bool passthru_log_err;
 	enum nvme_ctrl_state state;
 	spinlock_t lock;
 	struct mutex scan_lock;
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 45e91811f905..2dca06378998 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -35,6 +35,44 @@ static ssize_t nvme_sysfs_rescan(struct device *dev,
 }
 static DEVICE_ATTR(rescan_controller, S_IWUSR, NULL, nvme_sysfs_rescan);
 
+static ssize_t nvme_passthru_err_log_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+
+	if (ctrl->passthru_log_err)
+		return sysfs_emit(buf, "on\n");
+
+	return sysfs_emit(buf, "off\n");
+}
+
+static ssize_t nvme_passthru_err_log_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+	int passthru_enable, err;
+
+	err = kstrtoint(buf, 10, &passthru_enable);
+	if (err)
+		return -EINVAL;
+
+	switch (passthru_enable) {
+	case true:
+	case false:
+		ctrl->passthru_log_err = passthru_enable;
+		break;
+	default:
+		pr_err("invlid value %d for admin error logging [on:1 off:0]\n",
+			passthru_enable);
+		break;
+	}
+	return count;
+}
+
+static DEVICE_ATTR(passthru_err_log, S_IRUGO | S_IWUSR,
+	nvme_passthru_err_log_show,
+	nvme_passthru_err_log_store);
+
 static inline struct nvme_ns_head *dev_to_ns_head(struct device *dev)
 {
 	struct gendisk *disk = dev_to_disk(dev);
@@ -554,6 +592,7 @@ static struct attribute *nvme_dev_attrs[] = {
 	&dev_attr_dhchap_secret.attr,
 	&dev_attr_dhchap_ctrl_secret.attr,
 #endif
+	&dev_attr_passthru_err_log.attr,
 	NULL
 };
 
-- 
2.40.0



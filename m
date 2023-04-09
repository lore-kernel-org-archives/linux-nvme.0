Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C4B7C77B61
	for <linux-nvme@archiver.kernel.org>; Sun,  9 Apr 2023 21:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=c/B5+vHUY8TitiQKMB2QraUoXr/wx2zCj0LA4uIkfLw=; b=geJPm4jAeIRiQrJ3ffh0PhTPJt
	AaIRKMoxQAA/7cHm0SZ2UaTMMgH9WnZ05d2VmMaBCOtwUUWbfZnjaqmOrfImQ819O9S8yXFkeKNto
	8928ZD2Ju+Qvvkad2M8ix4BmSB7NBGqowgZ/kflGlN1IkCG+mpUjWYZsGzDEJW1um9NHMnbCAmB84
	vTzFOT19NGMwJoUFo2demXicyd/bN0Mo7OvFZn53e8rDphSd6MHGW4dKCV6SZW1Re8JO56+R0RaqU
	fquJtB8d9eDwd2SgvsowiG+skLzxBgU6NS+p1vnvc2Qftq1ttniejPHIwC0rCIa5CL313RYYsPwF+
	mr+yc7WQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1plcYG-00EGk9-1a;
	Sun, 09 Apr 2023 21:26:20 +0000
Received: from mail-mw2nam12on2060d.outbound.protection.outlook.com ([2a01:111:f400:fe5a::60d] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1plcYC-00EGjD-2q
	for linux-nvme@lists.infradead.org;
	Sun, 09 Apr 2023 21:26:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VztMKM03TCILKNiVi85ZYDUsP6bORCDdEhToOQlFg+7qmbgvrkqBdp8P+E5FRngIjII/UTWi9Xw3Nv40DEk57ibXg1NHsPFDu9D/EtiaKs6ZyghpaFwlUS/lOJeGcREh7aGjAiS86s9pm8elnYhBihqf/VUhUOtT9tyyqZukaEeEC0E605gSlQcP+NtXSchYogZt/UrX/hL6lWREiYAIZOVKvrCmwDDigeix5M2/0UvrboKqbgerv7fQu+HZH14mjqVLntoDS3dAzL9F+us1orT5qZhODVqbk14Q8eBa2M3OFSoedP83sw6iVST67Ku+3mrKb71e6783vFWEgYYmEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c/B5+vHUY8TitiQKMB2QraUoXr/wx2zCj0LA4uIkfLw=;
 b=XhWfW/rzcIQiNvi9J6en+YUSZNA9tQ9RCe6cNzednN8P7fOw5wL37w37uh/HJg7ZE9A+4BVHRcwaLxMQcFL4YphKv9UXvWBshqZQe/xNS7TjeXkiV2isyDXEev1IpT1RYXrbO1hDfJUo7IIvEPwSand808EyYf34HuPJrSQpLuKO6bSkTru93TpDn5MENplTJWnywVg8/pBqd7XKxwtV40h5tY+Fu8loDshhk3nMlLy6qEJitnTVYd8qyY4h31yjqHCk3y7GIzjoZCZUgmR2ZglSkB09Dgx89vVXb/JQ2SijAmgC/YjOzm/iJ6GSrmT5wRzuA4goZa+SN0RC+B8IMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=oracle.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c/B5+vHUY8TitiQKMB2QraUoXr/wx2zCj0LA4uIkfLw=;
 b=ruHZKrurfIuPqy0zzttVXxhOJInfIUjWvKu4+Wc+nHSWJjFgOcTcicz22YUuGIzdje+iphVo6w25qbANRi1R3IqZzRqPFlaBBK1qR4W31RpoWw5PpENLtCrXNAFSIBUVnCUDErDYbkewmn3dTlT3Pd+MIVizGUkIW16Rc2LpNsq1OSL6yjNNGJDlp/dntksb84qz1XquMOOM3tcqp9nvV401+LyuwLFtrkwxqwqX9ww8cc2NTmA0jHBwQRPNJlFMsSW/Rkn2bfbr8uzqFANXQEohmLQ5aS15ibFk0J1dwECPXaLVqfCiy7/fHcf8303Quk5rrX4z+vlYJucAl44O5A==
Received: from MW3PR05CA0025.namprd05.prod.outlook.com (2603:10b6:303:2b::30)
 by DM4PR12MB5071.namprd12.prod.outlook.com (2603:10b6:5:38a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Sun, 9 Apr
 2023 21:26:12 +0000
Received: from CO1NAM11FT101.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2b:cafe::7a) by MW3PR05CA0025.outlook.office365.com
 (2603:10b6:303:2b::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.26 via Frontend
 Transport; Sun, 9 Apr 2023 21:26:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT101.mail.protection.outlook.com (10.13.175.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6298.20 via Frontend Transport; Sun, 9 Apr 2023 21:26:12 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Sun, 9 Apr 2023
 14:25:57 -0700
Received: from dev.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Sun, 9 Apr 2023
 14:25:56 -0700
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <alan.adamson@oracle.com>
CC: <linux-nvme@lists.infradead.org>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH V5 1/1] nvme: allow passthru cmd error logging
Date: Sun, 9 Apr 2023 14:25:38 -0700
Message-ID: <20230409212538.18647-2-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20230409212538.18647-1-kch@nvidia.com>
References: <20230409212538.18647-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT101:EE_|DM4PR12MB5071:EE_
X-MS-Office365-Filtering-Correlation-Id: d7abad80-1140-4c97-01b7-08db39410afc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	rleqMWGf74rgFTqGisOfLmf4UEIoJa5D1I5BGTAlitBt5wtOE8vVZwuZJb9CDHQSUO3dYoG8F/dPK/reI6ABFyONtdBHKXnBZ/7BzIu8T1jOpGIstb4eaJvZ6oaaH4FwTEo7jpIhYlUIaTGlq/cM2lMGkI+Sx1h10auCvMVcWgfoamD5CGnGTrftQhaphMnkhFafwTTiJfZzWVz4VBhuE5gJC4AaRJDAvU++wCJ8fq8N+FJCDQPmr+54Bq6jB32xoZYpcFIy5rY1LD1YaBPA54mpRUJzC+aurMJ0hsWvmvocKXNh7Ck9p98A2EFFlHcEDF4ulW0nUz1zJOn8eKlFSoxzWobBFtzidFB8ia+ngNNJ0U3dhAp7Nr2aJEa0fpfFUXnxdVqeYllTQWJ83nh9QgA7EPzGZ36MqZPDtqXV958NGOdJyqO1m5o/C+KBPxBcEpFiHIVBWwQOjjx45pWDuE5jYltFU/zTzja4ZAyyxHXR2dpifqr6gPiIAzgJE3qk3CuOdCovhCvfJzL8ROnZDZALIMJEVIBKxCVJaUaHCNnnlq8v3tYIo1w2Tfu5erIukDaZ0w4XZzROVQ9liBfkIMYY2RYjiyB1cyojrGaOF7x8UuixJBoEMYgZ4wcE87GTTcFh+5K000RTbIQMXvSf4FIf9qWcM1M1u/aqFT5YMluCRnD2JW6wkxxOMVBUwbSKqkq4GRb7+3WSBdCacpjTGvi+MchdCfrSxDGBWNgB/2fIFCd/hUyMxAPBIlV+N7VQ
X-Forefront-Antispam-Report: 	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(396003)(39860400002)(376002)(451199021)(40470700004)(36840700001)(46966006)(478600001)(7696005)(54906003)(316002)(1076003)(26005)(16526019)(186003)(107886003)(6666004)(2906002)(4326008)(70586007)(70206006)(5660300002)(8676002)(6916009)(41300700001)(8936002)(82310400005)(7636003)(356005)(82740400003)(40480700001)(36756003)(40460700003)(47076005)(83380400001)(2616005)(426003)(336012)(36860700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2023 21:26:12.1439
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7abad80-1140-4c97-01b7-08db39410afc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: 	CO1NAM11FT101.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5071
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230409_142616_922940_70B58614 
X-CRM114-Status: GOOD (  19.92  )
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
 drivers/nvme/host/core.c | 83 +++++++++++++++++++++++++++++++++++++---
 drivers/nvme/host/nvme.h |  1 +
 2 files changed, 79 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 954641a45e55..e32265adc034 100644
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
@@ -678,8 +711,8 @@ void nvme_init_request(struct request *req, struct nvme_command *cmd)
 	if (req->mq_hctx->type == HCTX_TYPE_POLL)
 		req->cmd_flags |= REQ_POLLED;
 	nvme_clear_nvme_request(req);
-	req->rq_flags |= RQF_QUIET;
-	memcpy(nvme_req(req)->cmd, cmd, sizeof(*cmd));
+
+	memcpy(nr->cmd, cmd, sizeof(*cmd));
 }
 EXPORT_SYMBOL_GPL(nvme_init_request);
 
@@ -3417,6 +3450,44 @@ static ssize_t nvme_sysfs_rescan(struct device *dev,
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
@@ -3925,6 +3996,7 @@ static struct attribute *nvme_dev_attrs[] = {
 	&dev_attr_dhchap_secret.attr,
 	&dev_attr_dhchap_ctrl_secret.attr,
 #endif
+	&dev_attr_passthru_err_log.attr,
 	NULL
 };
 
@@ -5124,6 +5196,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	int ret;
 
 	ctrl->state = NVME_CTRL_NEW;
+	ctrl->passthru_log_err = false;
 	clear_bit(NVME_CTRL_FAILFAST_EXPIRED, &ctrl->flags);
 	spin_lock_init(&ctrl->lock);
 	mutex_init(&ctrl->scan_lock);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index bf46f122e9e1..f5721ad8264c 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -248,6 +248,7 @@ struct nvme_ctrl {
 	bool comp_seen;
 	enum nvme_ctrl_state state;
 	bool identified;
+	bool passthru_log_err;
 	spinlock_t lock;
 	struct mutex scan_lock;
 	const struct nvme_ctrl_ops *ops;
-- 
2.29.0



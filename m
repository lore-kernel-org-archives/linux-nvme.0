Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D057C433EF
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Jun 2022 01:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=u8vQ+NYat/wPWtrSZPBL4dGQGhVCgEmsn5TUMWi3g4A=; b=gRMRi7v5UK+4Hwoz85LudDb6kz
	fQeJ9tiHTsGIlDKbhkvCN9J7z/G1DjFZrzdeoqNncq0wxqSXCE1PUB1KUMN0ST1WXm+r987YGbBrY
	nEac2Zn26B/MZUlpjD98s1AckJrmmVkXkWNqy7fgl1yk2t6TlMldpoQZdWaKJD+TcuzjoHtb8zmNk
	zG4rUxynLkQXFVxmF32Dygrut2SAHMkzD+iSMkJ1Rq2DPH5dB4C37/Z0oMEuYArf+WtH+SrFFfIUY
	vNiRFiydsErrj7U64N5J+8IrLIlHQBzzRQ9an96JK9FYisW17RhAZA6ub71z0SbfrL+s4WJ8jAUBj
	V9JTXZcQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nyNqk-003yAU-FH; Tue, 07 Jun 2022 01:17:38 +0000
Received: from mail-bn8nam11on2061e.outbound.protection.outlook.com ([2a01:111:f400:7eae::61e] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nyNqg-003y9B-Mz
	for linux-nvme@lists.infradead.org; Tue, 07 Jun 2022 01:17:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nXMv3vRRqORq1UVdiCzMjSZSku5zwqLcPPbwzjFURTXmeY6qmKU++xO4aQVl56ztKq90JxzjEa8xEM8WWJDa1gSj/GugPVCKEMpMScjHcLS1NR7umvGQI4lQAeffwosnwmDTdaiejEcY6tMUoa8Qz1sYULkd4m23D5K46YyUiBtf1j0lJKbgjHrNopfNBdhBQ4ZWgdyvgGUisx2eXQJp/SQCgutEtw6eZxABxborfH1S9JHvzjvqBID38ONq52yijaI30U4njcSzlrrdJu9TAn0bIlpBMeHcHlfi0E1EM1087BeRO5CVMW6KXG0N7nfUS53/C1LAovNWMsC42YbQCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u8vQ+NYat/wPWtrSZPBL4dGQGhVCgEmsn5TUMWi3g4A=;
 b=UycPyAu135/so+ClU5rd/oYyy0c7J6gZ0d0r7i/9Hkz63ZOmBvkb5vRt0G4gk4mHvtat6rA+2vGm+1QF9TONTMBq4b+rhG9bIc1P5m6ylsRchWU+RndSbgZtAwXuax8OruXh65OqCmqLDvg8exPRBz4JVvdqt1bj/f8JITJe6uKbEh88SvP8D7nct/lIqk2EBev0BFSVNJmaVCFCfCOd1ueXS36oNq2GTPkVINxhIzmBlfbAtJyfouwHVAnbO2ER7PgVpBpqDo8X0z78cESSXZq6jZYYxcHFvU2D+gqVoiVLHm3AcY7bbKv6NvV9nPc9TgLRF1VSo8AzcYHtR6MjEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u8vQ+NYat/wPWtrSZPBL4dGQGhVCgEmsn5TUMWi3g4A=;
 b=VvJA1Uw58qiiUohCGy1sxELi9vtazkMCisDLDGA9S16on7OceinPuhQzQbfUc4owzbjPrHW+stJwpIGfDhmShVBlLoFIXSNJe9xwrNOMNwIRgD7wV7ZgEyZUyloyCEqbWuSVTzrdZkaoC34OEmabg6apTIcd6GLKPx4ALGNKMt4NR+n3FMQyObKk491h4RwCHK35Cbk38jclp22w+f5abTf24EI667+qjBOQxWgVLY4oU+AojmTPJKTBc3v6yns3lu3rkViCKe9+4SOmtnv6Pd/KIQiDmPLRFPGe8RfBsQrktLKYppQ3R54KnXA8vLdJ4f21wCVDHvha2nh5Rq0QOg==
Received: from DM5PR07CA0100.namprd07.prod.outlook.com (2603:10b6:4:ae::29) by
 BYAPR12MB3607.namprd12.prod.outlook.com (2603:10b6:a03:dd::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5314.17; Tue, 7 Jun 2022 01:17:29 +0000
Received: from DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ae:cafe::dd) by DM5PR07CA0100.outlook.office365.com
 (2603:10b6:4:ae::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13 via Frontend
 Transport; Tue, 7 Jun 2022 01:17:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.238) by
 DM6NAM11FT004.mail.protection.outlook.com (10.13.172.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5314.12 via Frontend Transport; Tue, 7 Jun 2022 01:17:28 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Tue, 7 Jun
 2022 01:17:28 +0000
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 6 Jun 2022
 18:17:27 -0700
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>,
	<james.smart@broadcom.com>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 3/6] nvme-core: remove qid parameter
Date: Mon, 6 Jun 2022 18:16:44 -0700
Message-ID: <20220607011647.24105-4-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220607011647.24105-1-kch@nvidia.com>
References: <20220607011647.24105-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b86a6ac1-3b51-4fb5-0dfb-08da48237d0f
X-MS-TrafficTypeDiagnostic: BYAPR12MB3607:EE_
X-Microsoft-Antispam-PRVS: 	<BYAPR12MB36079BAB3E7D74062202DD4AA3A59@BYAPR12MB3607.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	l88J+DruLX3rEDdHKex10FpnGkKwO3S7K/fY53IiTakdtKNYIDb6OXqrconm3iZi3mvsFz2Q6pebGDym3R5s0VSyS2/7u8cdSvUWGeCzN8rlzhUQzBvLJsUaJcLy/MyuoS8OTUyixx5AkThlod4VrTt2/5UwcShQ7prM1sYumoIf4YUYuV6gQJjJzGFOCiGpE10DTVB7A5b/C92L4CM6I2IvWEFFMK6X0FLxgPo44JJwupcmWjjmuhpPE0rkR4jLOwQXp7fXttwoO4+dTi+JtH5J3sSKR+covibmHkVfTC+Zf2HLKBWqHFq+zIyCmmK8xFDFRvKlq7+OXTiY9zog4tGXt9rGWWG0DC44y2dnkJY/hvUJHuY9ZJTVUa1H1D9UB5NRaFtPfSxfsiJ3eKeq/jQpGN153ucfvhlUz7mTGOmOsP7KTDndj2Whn2Ie8626/CgZDXM9w2xmdUejyWc6x/XroQOK6ZbROnsu1PlV7mznUD3VCJ+bGpPY5cYOmCfBLSl6cG3753bhtxYKE5qBfptIEEpmfUImmn9XD/Fwr1zm189xOUAxe6ZgpY9WTuT5Ob2dNEexdAKiWx66a1hnDAMbZuTAh3DQyIIrZsTWDDWQlBUd0bhuumT/97vLKzWwXBG8Dkz/+/9h7PWs37zGnWG9SdkuQSNh8PQMKbGNw33zJuz7+FWLsICQQysj3tLEoYAMUxixlXnHhreDlq/9HQ==
X-Forefront-Antispam-Report: 	CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(2906002)(7696005)(40460700003)(316002)(36756003)(81166007)(356005)(5660300002)(186003)(26005)(36860700001)(70586007)(107886003)(2616005)(8936002)(70206006)(6666004)(8676002)(47076005)(83380400001)(4326008)(426003)(16526019)(54906003)(336012)(6916009)(82310400005)(508600001)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2022 01:17:28.4290
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b86a6ac1-3b51-4fb5-0dfb-08da48237d0f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: 	DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3607
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220606_181734_798542_2CD5A5CC 
X-CRM114-Status: GOOD (  15.98  )
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

The only caller of __nvme_submit_sync_cmd() sets the qid value that
is different from NVME_QID_ANY is nvmf_connect_io_queue() :-

        Callers                 |   qid value
--------------------------------------------------
nvme_submit_sync_cmd()          | NVME_QID_ANY
nvme_features()                 | NVME_QID_ANY
nvme_sec_submit()               | NVME_QID_ANY
nvmf_reg_read32()               | NVME_QID_ANY
nvmf_reg_read64()               | NVME_QID_ANY
nvmf_reg_write32()              | NVME_QID_ANY
nvmf_connect_admin_queue()      | NVME_QID_ANY
nvmf_connect_io_queue()         |   qid > 0

We can easily derive the qid value from the nvme_command parameter of
the function __nvme_submit_sync_cmd() when its caller is
nvmf_connect_io_queue().

Remove the qid function parameter from __nvme_submit_sync_cmd() and
derive the value from nvme_command if the caller is
nvmf_connect_io_queue() and adjust the rest of code accordingly.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/host/core.c    | 21 +++++++++++++++++----
 drivers/nvme/host/fabrics.c | 10 +++++-----
 drivers/nvme/host/nvme.h    |  3 +--
 3 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 36943e245acf..95800aa9c83f 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -984,17 +984,30 @@ static int nvme_execute_rq(struct request *rq, bool at_head)
 	return blk_status_to_errno(status);
 }
 
+static inline bool is_fabrics_io_connect_cmd(struct nvme_command *cmd)
+{
+	return cmd->connect.opcode == nvme_fabrics_command &&
+	       cmd->connect.fctype == nvme_fabrics_type_connect &&
+	       le16_to_cpu(cmd->connect.qid) > 0;
+}
+
 /*
  * Returns 0 on success.  If the result is negative, it's a Linux error code;
  * if the result is positive, it's an NVM Express status code
  */
 int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 		union nvme_result *result, void *buffer, unsigned bufflen,
-		int qid, int at_head, blk_mq_req_flags_t flags)
+		int at_head, blk_mq_req_flags_t flags)
 {
+	int qid = NVME_QID_ANY;
 	struct request *req;
 	int ret;
 
+	if (is_fabrics_io_connect_cmd(cmd)) {
+		/* nvmf io connect command has qid in nvme_command set */
+		qid = le16_to_cpu(cmd->connect.qid);
+	}
+
 	if (qid == NVME_QID_ANY)
 		req = blk_mq_alloc_request(q, nvme_req_op(cmd), flags);
 	else
@@ -1025,7 +1038,7 @@ int nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 		void *buffer, unsigned bufflen)
 {
 	return __nvme_submit_sync_cmd(q, cmd, NULL, buffer, bufflen,
-			NVME_QID_ANY, 0, 0);
+			0, 0);
 }
 EXPORT_SYMBOL_GPL(nvme_submit_sync_cmd);
 
@@ -1461,7 +1474,7 @@ static int nvme_features(struct nvme_ctrl *dev, u8 op, unsigned int fid,
 	c.features.dword11 = cpu_to_le32(dword11);
 
 	ret = __nvme_submit_sync_cmd(dev->admin_q, &c, &res,
-			buffer, buflen, NVME_QID_ANY, 0, 0);
+			buffer, buflen, 0, 0);
 	if (ret >= 0 && result)
 		*result = le32_to_cpu(res.u32);
 	return ret;
@@ -2099,7 +2112,7 @@ int nvme_sec_submit(void *data, u16 spsp, u8 secp, void *buffer, size_t len,
 	cmd.common.cdw11 = cpu_to_le32(len);
 
 	return __nvme_submit_sync_cmd(ctrl->admin_q, &cmd, NULL, buffer, len,
-			NVME_QID_ANY, 1, 0);
+			1, 0);
 }
 EXPORT_SYMBOL_GPL(nvme_sec_submit);
 #endif /* CONFIG_BLK_SED_OPAL */
diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 0a0512300f1b..7ad8c4438318 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -153,7 +153,7 @@ int nvmf_reg_read32(struct nvme_ctrl *ctrl, u32 off, u32 *val)
 	cmd.prop_get.offset = cpu_to_le32(off);
 
 	ret = __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, &res, NULL, 0,
-			NVME_QID_ANY, 0, 0);
+			0, 0);
 
 	if (ret >= 0)
 		*val = le64_to_cpu(res.u64);
@@ -199,7 +199,7 @@ int nvmf_reg_read64(struct nvme_ctrl *ctrl, u32 off, u64 *val)
 	cmd.prop_get.offset = cpu_to_le32(off);
 
 	ret = __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, &res, NULL, 0,
-			NVME_QID_ANY, 0, 0);
+			0, 0);
 
 	if (ret >= 0)
 		*val = le64_to_cpu(res.u64);
@@ -244,7 +244,7 @@ int nvmf_reg_write32(struct nvme_ctrl *ctrl, u32 off, u32 val)
 	cmd.prop_set.value = cpu_to_le64(val);
 
 	ret = __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, NULL, NULL, 0,
-			NVME_QID_ANY, 0, 0);
+			0, 0);
 	if (unlikely(ret))
 		dev_err(ctrl->device,
 			"Property Set error: %d, offset %#x\n",
@@ -389,7 +389,7 @@ int nvmf_connect_admin_queue(struct nvme_ctrl *ctrl)
 	strncpy(data->hostnqn, ctrl->opts->host->nqn, NVMF_NQN_SIZE);
 
 	ret = __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, &res,
-			data, sizeof(*data), NVME_QID_ANY, 1,
+			data, sizeof(*data), 1,
 			BLK_MQ_REQ_RESERVED | BLK_MQ_REQ_NOWAIT);
 	if (ret) {
 		nvmf_log_connect_error(ctrl, ret, le32_to_cpu(res.u32),
@@ -450,7 +450,7 @@ int nvmf_connect_io_queue(struct nvme_ctrl *ctrl, u16 qid)
 	strncpy(data->hostnqn, ctrl->opts->host->nqn, NVMF_NQN_SIZE);
 
 	ret = __nvme_submit_sync_cmd(ctrl->connect_q, &cmd, &res,
-			data, sizeof(*data), qid, 1,
+			data, sizeof(*data), 1,
 			BLK_MQ_REQ_RESERVED | BLK_MQ_REQ_NOWAIT);
 	if (ret) {
 		nvmf_log_connect_error(ctrl, ret, le32_to_cpu(res.u32),
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 88bd147b8048..3beb3ebb220e 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -752,8 +752,7 @@ int nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 		void *buf, unsigned bufflen);
 int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 		union nvme_result *result, void *buffer, unsigned bufflen,
-		int qid, int at_head,
-		blk_mq_req_flags_t flags);
+		int at_head, blk_mq_req_flags_t flags);
 int nvme_set_features(struct nvme_ctrl *dev, unsigned int fid,
 		      unsigned int dword11, void *buffer, size_t buflen,
 		      u32 *result);
-- 
2.29.0



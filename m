Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAC7DC433EF
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Jun 2022 01:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Z/Vtc6/4NdowuwrDDlAxKVnP2ZXYSTQ3tYCZUAJWk8c=; b=I8ZfByWWi+Smn6AjHn+F+jaMNs
	OR8r1Uebndyb9F9R6y2wy58S9XARPqjFtGD7/GbQ8RKJiGeDr0tfkPvKJtMg6tVPX1YxSlw/dL2S/
	AbQ3olNkS+Th9KBECVDmHOYkyFcmSSNOLiYxrYvnV7J8XhtrMkH3o+HQqbpEUw+yFyrPP+ntordl8
	AksOxHxDate/hJfYxWvwaNHeHNiezkjlUC8o7RVvqtFuyol2oz8vR8z+Ktz1asZF8kTbSD9/KB/3f
	0xq1qfs7yyhwKWgrTYMbSqz2SL3VCU7HtcOYEwWpGMoH6ZQIGaSQpoJYRf0/tjwqrrYVsH8Ei6uiP
	Cr8UWm5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nyNqu-003yDU-L9; Tue, 07 Jun 2022 01:17:48 +0000
Received: from mail-dm6nam12on2060a.outbound.protection.outlook.com ([2a01:111:f400:fe59::60a] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nyNqr-003yBl-Ci
	for linux-nvme@lists.infradead.org; Tue, 07 Jun 2022 01:17:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UQIAA92XR1on5mgyLDt2WS8EFMiKks9mHJbpG9X8nOW7Csdp7Bfox4OzpxPe89FTeOU4ZPYWOdD1+crK10P11i7HjDtvRg8f9/ijBnDYMW2Y46revYnDAmL0C0r1oCf/hDoSqwBpNMjAKdYBR9RDfkSf1EfPtsZKznwdcARvzsM5DQcM6FKqiCiy33RfNKwFHV0B9LSSrCPSZqsQ8vUx79zJG8nBn2K2b64b/YBb/PRU/OW+xzXtyDg5L+7SPiBp3h5Xdf36FTjOVPxxUUJ7x/q8X5ciL++KxVKAL7t/+EKigJhRooFU4HOUsRnVWoFVNV29KrSZcXcAiEKrVbPa5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z/Vtc6/4NdowuwrDDlAxKVnP2ZXYSTQ3tYCZUAJWk8c=;
 b=IGoyqtqrvH99d8J/R6JwsHS5xYieboyoyeAcv49GhISqt7iIyhAHSTpmw1STgLQksZ6SddStDITKp/hLIiQWFQn7VX89kiajVt0cSqHFY9ohIpGQvzoF9xXSnr7jfySATItm0BpAjzGLGCy2M4m1+4v6NqYvQqsMz9yfjOq2cWE/rSg5GwGU0M089pNYCMi2soLQQkMzUGDFUwHXivq93XoMCxL0XXF7Leh03sEc+RzXZDbP+0959fqUh4DJlIHr9rNSTAJxp80eV3IGBaZqGgW4SJld0iWCUZlbhlpiGFqd5wRfMjj56TySr+/xlmAmRhXk3w7Sn/qT8vvpdQTahQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z/Vtc6/4NdowuwrDDlAxKVnP2ZXYSTQ3tYCZUAJWk8c=;
 b=o8xEHT/Dt5LKgNmWJSRK0BfHPLJikH8xUqZyfSHZEKu8KmW8cIEBkSib/0v79YVzcRMzr8ligNzDsWM8CEFU97g5Dp3V28f910i8Zvp6VE/EVxTxMLsMXTlmHfuiS4ted/wEsNVWWV35MMCw+NMATdQsBAOjsqA5AmQAplB+sZp4zHsYL0dLQc3bvsThUJ6yumyJ1QFAuB9Q+x+ME5MAkjkrOQEa3C3kW0VFz+HThDkN3izSKk7Ol+Zxa7LJ235tHicUllFToCUZBnL2+4HjZc36n1qbtyVNIn4L5OdB1ZT3+tPA5Z8rDDDXgEcgZyEjlbPA71o6j49BpwQvTyFe6g==
Received: from MWHPR2001CA0017.namprd20.prod.outlook.com
 (2603:10b6:301:15::27) by BYAPR12MB2613.namprd12.prod.outlook.com
 (2603:10b6:a03:69::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.18; Tue, 7 Jun
 2022 01:17:39 +0000
Received: from CO1NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:15:cafe::49) by MWHPR2001CA0017.outlook.office365.com
 (2603:10b6:301:15::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.19 via Frontend
 Transport; Tue, 7 Jun 2022 01:17:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.235) by
 CO1NAM11FT030.mail.protection.outlook.com (10.13.174.125) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5314.12 via Frontend Transport; Tue, 7 Jun 2022 01:17:39 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Tue, 7 Jun
 2022 01:17:39 +0000
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 6 Jun 2022
 18:17:38 -0700
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>,
	<james.smart@broadcom.com>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 4/6] nvme-core: remove flags parameter
Date: Mon, 6 Jun 2022 18:16:45 -0700
Message-ID: <20220607011647.24105-5-kch@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: ec59eb69-fcd3-4609-b55d-08da482383a1
X-MS-TrafficTypeDiagnostic: BYAPR12MB2613:EE_
X-Microsoft-Antispam-PRVS: 	<BYAPR12MB2613D4CB46F414074D991C80A3A59@BYAPR12MB2613.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	ytS3/hCjpZ3jTJ7hi/AM/JA0aGSqEaRHS5TO5n/N+GtuyS4cJR41jvHVRhcAlZ5Z6paf1dRHivPQr4SpsMOByfsdG4Rk1s/uIBANrf6oPQvqfOhTICfR4UMn4BO2jf542PCGq+TQS26z0xi2TrmE6hZ3lB/i1khFr3BE1KeDWpbdkvwJvr5P8Uknd+/apdWqIgOA91ajWJnN8Sb9LfNsGytyfZGUEh2O2IfEHquGzJ0bXDycJ9Lft9IR/mLiWJ34JdDddX6aP5dYm54PqH+PPDecSiG+Sh84HPUmF9d5AudwsBzejBV5gHFThWYMYSCZJnItn4fK0kYh5DIff0F6EUvSwW5TE8D8vMBcK06JKk83xPwWKC0sZ87Vz/N2XrC3vF96lPJsVM3IVoYYnju/7IYiHzCMTAHZzfemIYUzms+qRpk2OrM1TcVu1T3BA7Qe7C83Ym7Z0Ts7qBSOUx7oSUxh2yP5jMRmN5ZWydUPtFg9eD1GE2ZzYrYuLC6c3bPwh9GH+jJluLmWwWSxfiVgWzrJhlwjXtdGIeBnCzKlqIN1599o0mFryOlLs+/gf5VFlFUMAHrsfElDLGh5coDNAkopoo5/tBI4R1IlXRHWzoF/1EB6MlttQeQjHbNaPF3A9ZCTfSFPKOmafDOoTI+qTdlSiY1t3UpLe3TkxACQNP5CT41FjsHLyz5SvJ73CwMRR1L7kIOep5flGspRdB0tPw==
X-Forefront-Antispam-Report: 	CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(426003)(336012)(36860700001)(5660300002)(356005)(83380400001)(2906002)(81166007)(40460700003)(70206006)(70586007)(316002)(6916009)(54906003)(8936002)(8676002)(107886003)(47076005)(508600001)(26005)(2616005)(1076003)(16526019)(186003)(82310400005)(36756003)(6666004)(7696005)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2022 01:17:39.4564
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec59eb69-fcd3-4609-b55d-08da482383a1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: 	CO1NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2613
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220606_181745_462842_888B7254 
X-CRM114-Status: GOOD (  12.82  )
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

The function __nvme_submit_sync_cmd() has following list of callers
that sets the blk_mq_req_flags_t flags value :-

        Callers             |             blk_mq_req_flags_t
----------------------------------------------------------------------
nvme_submit_sync_cmd()      |                    0
nvme_feature()              |                    0
nvme_sec_submit()           |                    0
nvmf_reg_read32()           |                    0
nvmf_reg_read64()           |                    0
nvmf_reg_write32()          |                    0
nvmf_connect_admin_queue()  | BLK_MQ_REQ_RESERVED | BLK_MQ_REQ_NOWAIT
nvmf_connect_io_queue()     | BLK_MQ_REQ_RESERVED | BLK_MQ_REQ_NOWAIT

Remove the flag function parameter from __nvme_submit_sync_cmd() and
and derive from nvme_command if the caller is nvmf_connect_admin_queue()
or nvmf_connect_io_queue() and adjust the rest of code accordingly.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/host/core.c    | 19 +++++++++++++------
 drivers/nvme/host/fabrics.c | 15 +++++----------
 drivers/nvme/host/nvme.h    |  2 +-
 3 files changed, 19 insertions(+), 17 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 95800aa9c83f..b8daf3ab9a22 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -984,6 +984,11 @@ static int nvme_execute_rq(struct request *rq, bool at_head)
 	return blk_status_to_errno(status);
 }
 
+static inline bool is_fabrics_admin_connect_cmd(struct nvme_command *cmd)
+{
+	return cmd->connect.opcode == nvme_fabrics_command &&
+	       cmd->connect.fctype == nvme_fabrics_type_connect;
+}
 static inline bool is_fabrics_io_connect_cmd(struct nvme_command *cmd)
 {
 	return cmd->connect.opcode == nvme_fabrics_command &&
@@ -997,12 +1002,16 @@ static inline bool is_fabrics_io_connect_cmd(struct nvme_command *cmd)
  */
 int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 		union nvme_result *result, void *buffer, unsigned bufflen,
-		int at_head, blk_mq_req_flags_t flags)
+		int at_head)
 {
+	blk_mq_req_flags_t flags = 0;
 	int qid = NVME_QID_ANY;
 	struct request *req;
 	int ret;
 
+	if (is_fabrics_io_connect_cmd(cmd) || is_fabrics_io_connect_cmd(cmd))
+		flags = BLK_MQ_REQ_RESERVED | BLK_MQ_REQ_NOWAIT;
+
 	if (is_fabrics_io_connect_cmd(cmd)) {
 		/* nvmf io connect command has qid in nvme_command set */
 		qid = le16_to_cpu(cmd->connect.qid);
@@ -1037,8 +1046,7 @@ EXPORT_SYMBOL_GPL(__nvme_submit_sync_cmd);
 int nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 		void *buffer, unsigned bufflen)
 {
-	return __nvme_submit_sync_cmd(q, cmd, NULL, buffer, bufflen,
-			0, 0);
+	return __nvme_submit_sync_cmd(q, cmd, NULL, buffer, bufflen, 0);
 }
 EXPORT_SYMBOL_GPL(nvme_submit_sync_cmd);
 
@@ -1473,8 +1481,7 @@ static int nvme_features(struct nvme_ctrl *dev, u8 op, unsigned int fid,
 	c.features.fid = cpu_to_le32(fid);
 	c.features.dword11 = cpu_to_le32(dword11);
 
-	ret = __nvme_submit_sync_cmd(dev->admin_q, &c, &res,
-			buffer, buflen, 0, 0);
+	ret = __nvme_submit_sync_cmd(dev->admin_q, &c, &res, buffer, buflen, 0);
 	if (ret >= 0 && result)
 		*result = le32_to_cpu(res.u32);
 	return ret;
@@ -2112,7 +2119,7 @@ int nvme_sec_submit(void *data, u16 spsp, u8 secp, void *buffer, size_t len,
 	cmd.common.cdw11 = cpu_to_le32(len);
 
 	return __nvme_submit_sync_cmd(ctrl->admin_q, &cmd, NULL, buffer, len,
-			1, 0);
+			1);
 }
 EXPORT_SYMBOL_GPL(nvme_sec_submit);
 #endif /* CONFIG_BLK_SED_OPAL */
diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 7ad8c4438318..3ca1a10cfb1c 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -152,8 +152,7 @@ int nvmf_reg_read32(struct nvme_ctrl *ctrl, u32 off, u32 *val)
 	cmd.prop_get.fctype = nvme_fabrics_type_property_get;
 	cmd.prop_get.offset = cpu_to_le32(off);
 
-	ret = __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, &res, NULL, 0,
-			0, 0);
+	ret = __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, &res, NULL, 0, 0);
 
 	if (ret >= 0)
 		*val = le64_to_cpu(res.u64);
@@ -198,8 +197,7 @@ int nvmf_reg_read64(struct nvme_ctrl *ctrl, u32 off, u64 *val)
 	cmd.prop_get.attrib = 1;
 	cmd.prop_get.offset = cpu_to_le32(off);
 
-	ret = __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, &res, NULL, 0,
-			0, 0);
+	ret = __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, &res, NULL, 0, 0);
 
 	if (ret >= 0)
 		*val = le64_to_cpu(res.u64);
@@ -243,8 +241,7 @@ int nvmf_reg_write32(struct nvme_ctrl *ctrl, u32 off, u32 val)
 	cmd.prop_set.offset = cpu_to_le32(off);
 	cmd.prop_set.value = cpu_to_le64(val);
 
-	ret = __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, NULL, NULL, 0,
-			0, 0);
+	ret = __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, NULL, NULL, 0, 0);
 	if (unlikely(ret))
 		dev_err(ctrl->device,
 			"Property Set error: %d, offset %#x\n",
@@ -389,8 +386,7 @@ int nvmf_connect_admin_queue(struct nvme_ctrl *ctrl)
 	strncpy(data->hostnqn, ctrl->opts->host->nqn, NVMF_NQN_SIZE);
 
 	ret = __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, &res,
-			data, sizeof(*data), 1,
-			BLK_MQ_REQ_RESERVED | BLK_MQ_REQ_NOWAIT);
+			data, sizeof(*data), 1);
 	if (ret) {
 		nvmf_log_connect_error(ctrl, ret, le32_to_cpu(res.u32),
 				       &cmd, data);
@@ -450,8 +446,7 @@ int nvmf_connect_io_queue(struct nvme_ctrl *ctrl, u16 qid)
 	strncpy(data->hostnqn, ctrl->opts->host->nqn, NVMF_NQN_SIZE);
 
 	ret = __nvme_submit_sync_cmd(ctrl->connect_q, &cmd, &res,
-			data, sizeof(*data), 1,
-			BLK_MQ_REQ_RESERVED | BLK_MQ_REQ_NOWAIT);
+			data, sizeof(*data), 1);
 	if (ret) {
 		nvmf_log_connect_error(ctrl, ret, le32_to_cpu(res.u32),
 				       &cmd, data);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 3beb3ebb220e..3e1c5fbf5603 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -752,7 +752,7 @@ int nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 		void *buf, unsigned bufflen);
 int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 		union nvme_result *result, void *buffer, unsigned bufflen,
-		int at_head, blk_mq_req_flags_t flags);
+		int at_head);
 int nvme_set_features(struct nvme_ctrl *dev, unsigned int fid,
 		      unsigned int dword11, void *buffer, size_t buflen,
 		      u32 *result);
-- 
2.29.0



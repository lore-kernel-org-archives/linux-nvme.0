Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 840DEC433EF
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Jun 2022 01:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=S9Iu2UtUw2ldbPLI1l0mtqliCMwGHwdPPbPTA+fNEj8=; b=2x/QhcRjqoRBs9kdAJ5Rwuguqt
	I9zzhSjjRQ3fKeMqCzjodUMXM+7yk1xaa9drURpqNzyyVeHie+2YY5CWMjEdm49z6EkujV5KVXyNw
	tNDXxvq5XJpd4mHHcsLaZfTagjcz4k3i1DDV5CnMr1mLTQVwBakrJMg8Ekxx5dBl/Dri6jyupmwi1
	Qc+9dwtRNRXaTZIeSo0Sam2PRGxL8EMFexm8cz73thYdDv3e24RsvW5M3FpTWG0Bi1L8pDV4Kn1Iq
	m4kz5rh9ZJB66CA9LpScG5ksJKvJRd6ai3BSNQlOJq/r6P4tqGRX0d311ZTjIMJ9zmosjJzy6/+U6
	1250zyXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nyNqS-003y6l-EM; Tue, 07 Jun 2022 01:17:20 +0000
Received: from mail-dm6nam12on2062a.outbound.protection.outlook.com ([2a01:111:f400:fe59::62a] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nyNqO-003y4v-KK
	for linux-nvme@lists.infradead.org; Tue, 07 Jun 2022 01:17:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MUCWMiEVPPq+duS73HPR2AeVZHEt1hw6AT4NuAE4AtSmLe9x2t3/0KkHGKimtaL2W1crd4SUz4johF1YX69nio7NpsXueMTErl5AGUkg1lVnCC/wYJQ3wP0Ko4d4HPJxXD4iebdS7nCrBzApAWyzgxnhci2OuGRHzqD4AwYBurplktiKYv3VPJMd6a3gFS03zpJMU8XY7/CkJFMOoy8jkbV3NrJgz8tBAy3WsT7W1U/ditOWJwqlfneLkeB0tPMceRdD/DGoMdMrUqfZMM8qJJFoy26CInXW+0rjpvyza1sbG/cCq7uMkAOHc5+5EkryZwqiY0vja4UqqsMXUS6uGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S9Iu2UtUw2ldbPLI1l0mtqliCMwGHwdPPbPTA+fNEj8=;
 b=j64IjCCcxs4XkTaJYYbDqY0FxtBkpG5Mkpd4NDSR59GBfuMVtPlbF0Dj53rjAp+V4b7GT8HBeh76QZf5OHZ5KrSjd0BQXIuVbED5KcfCESn1lcVZ7G1NY5YF2goN69Z+KfjoPIQIZEzDTq79xpxFJN7qt3dz3c2P/45O3q04yI3Wkw0wXTHd/C64Hl4rw4GttsUp1Rmo5BCo7xKAjBPQOThtLPXGy7iz9EHxP3quL4IgcxvVNWTUqNCD/0w6V2Q/UBHguDkh4/2bd8RzbrrREJjUTrnOkW/4MCGiLhrtHZz2Ug5Mo+4A1Xj/tHOgZ/efPCfKYF0WcOYRYdDxoY/drg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S9Iu2UtUw2ldbPLI1l0mtqliCMwGHwdPPbPTA+fNEj8=;
 b=EEJKrGzkQWSJ0tTYrMMNpQkjScHqRR2EsaWSG0bVwmbh6s7K0S6q4dki4jlj+kw8BSfCC5l0oul2WrJhZAuzvK51k7EEtxQFwt6ac4rfxBdV239Zc/KitiHqA9jsTcencCwpv2r+UZQ2eSNT4ZV+X/g/DzXZkrnuh4p931V+H3Sg/66Y+8BhzXrSo4Yd7nFIIOHJ5PmhMSWL9MNQBAVkIofMwVGOY+LEBKdlON7rpC451vBjj9KSx8z7BJKsCTrDtErmpDaWE7pLZ0v7MDQ1huUAgZvkOoZVhtMhO/6lUOAFQ1wgN7Dhvq0cdIqRLv1w8rGlolw6DsExraDMPwNnQw==
Received: from DM3PR12CA0131.namprd12.prod.outlook.com (2603:10b6:0:51::27) by
 DM4PR12MB6182.namprd12.prod.outlook.com (2603:10b6:8:a8::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5314.19; Tue, 7 Jun 2022 01:17:06 +0000
Received: from DM6NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:51:cafe::70) by DM3PR12CA0131.outlook.office365.com
 (2603:10b6:0:51::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13 via Frontend
 Transport; Tue, 7 Jun 2022 01:17:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.236) by
 DM6NAM11FT039.mail.protection.outlook.com (10.13.172.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5314.12 via Frontend Transport; Tue, 7 Jun 2022 01:17:06 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Tue, 7 Jun
 2022 01:17:05 +0000
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 6 Jun 2022
 18:17:04 -0700
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>,
	<james.smart@broadcom.com>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 1/6] nvme-core: remove unused timeout parameter
Date: Mon, 6 Jun 2022 18:16:42 -0700
Message-ID: <20220607011647.24105-2-kch@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: d470f4ba-79b9-4ac8-cfaf-08da48236ffa
X-MS-TrafficTypeDiagnostic: DM4PR12MB6182:EE_
X-Microsoft-Antispam-PRVS: 	<DM4PR12MB6182DEDB8BA4DF323A996CEFA3A59@DM4PR12MB6182.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	avS6rS/FVdiFn10tC1prUMABa4edfME1df92EcUsKvAEevu2z13ENjgInjO3fj1pxDenYQ1Pg0sfg9ymi9mAB44k72QG0RWuBlSesXaHW139kW0Xf0wrkIjj5ee7y4dRWlgNDsjrtCbAmLqpc0mAEe+4boJ3sg3pJfMp6splFRo1uPsa6PwmpwfdWmsC3kKEyUzCaLECDGGnTjECKCM6C1ihw+yDBKAhE89J7NHnUoWNFwvL8Jz2vPh3xUi0vmhKSV1bsaT1d0gGNpqORMd71RE+xzX2YuJFty6TzwHN8Ni+Uh1TydIOIbBLSyn1QOViPpRaagJxB/t5Csb2iOafcgwKfL9NsZEaX5YWzjfeSyS92OADjWDL9iOxOD8LNjEagO9F5wHsgqryKtZwqZjL2xV7/F00mAgWeyxPvyLIiUj+k5Wws7cAZcRikVZjK3xMP4y/dZ6D2TOKSwWWwzvyDGrQ7mg9GBlYutalgtKPnS2Gn+QlItatLWNBx3FK0U+qeepXMEZqw+cHxsaLGMb4GaRdvEpVlNONwYHLIFF7vFxzEKWdL2e/Z0PLwwnT3oce0sX9d7BWn85oL2FhS2RsBN/zuv1S10BfHds68dEUvuiAOKSGlyBPg5ezCxKOLvtk0V6a/HMrs5a8OVs6hbfN9RVP/NssPneixmff61mgbEKtPXgN3+XdVx3Dg1xzaDsom0pEN/OFIwwcvZFyKMKk4A==
X-Forefront-Antispam-Report: 	CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(36756003)(70586007)(70206006)(36860700001)(8936002)(5660300002)(83380400001)(47076005)(2906002)(316002)(54906003)(107886003)(4326008)(8676002)(26005)(82310400005)(426003)(336012)(16526019)(186003)(356005)(40460700003)(6666004)(2616005)(7696005)(1076003)(81166007)(508600001)(6916009)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2022 01:17:06.4859
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d470f4ba-79b9-4ac8-cfaf-08da48236ffa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: 	DM6NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6182
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220606_181716_728348_4682CFC4 
X-CRM114-Status: GOOD (  12.11  )
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
that sets the timeout value to 0 :-

        Callers               |   Timeout value
------------------------------------------------
nvme_submit_sync_cmd()        |        0
nvme_features()               |        0
nvme_sec_submit()             |        0
nvmf_reg_read32()             |        0
nvmf_reg_read64()             |        0
nvmf_reg_write32()            |        0
nvmf_connect_admin_queue()    |        0
nvmf_connect_io_queue()       |        0

Remove the timeout function parameter from __nvme_submit_sync_cmd() and
adjust the rest of code accordingly.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/host/core.c    | 12 ++++--------
 drivers/nvme/host/fabrics.c | 10 +++++-----
 drivers/nvme/host/nvme.h    |  2 +-
 3 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 98e343cb4a12..f46b0d37f45d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -990,8 +990,7 @@ static int nvme_execute_rq(struct request *rq, bool at_head)
  */
 int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 		union nvme_result *result, void *buffer, unsigned bufflen,
-		unsigned timeout, int qid, int at_head,
-		blk_mq_req_flags_t flags)
+		int qid, int at_head, blk_mq_req_flags_t flags)
 {
 	struct request *req;
 	int ret;
@@ -1006,9 +1005,6 @@ int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 		return PTR_ERR(req);
 	nvme_init_request(req, cmd);
 
-	if (timeout)
-		req->timeout = timeout;
-
 	if (buffer && bufflen) {
 		ret = blk_rq_map_kern(q, req, buffer, bufflen, GFP_KERNEL);
 		if (ret)
@@ -1028,7 +1024,7 @@ EXPORT_SYMBOL_GPL(__nvme_submit_sync_cmd);
 int nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 		void *buffer, unsigned bufflen)
 {
-	return __nvme_submit_sync_cmd(q, cmd, NULL, buffer, bufflen, 0,
+	return __nvme_submit_sync_cmd(q, cmd, NULL, buffer, bufflen,
 			NVME_QID_ANY, 0, 0);
 }
 EXPORT_SYMBOL_GPL(nvme_submit_sync_cmd);
@@ -1465,7 +1461,7 @@ static int nvme_features(struct nvme_ctrl *dev, u8 op, unsigned int fid,
 	c.features.dword11 = cpu_to_le32(dword11);
 
 	ret = __nvme_submit_sync_cmd(dev->admin_q, &c, &res,
-			buffer, buflen, 0, NVME_QID_ANY, 0, 0);
+			buffer, buflen, NVME_QID_ANY, 0, 0);
 	if (ret >= 0 && result)
 		*result = le32_to_cpu(res.u32);
 	return ret;
@@ -2102,7 +2098,7 @@ int nvme_sec_submit(void *data, u16 spsp, u8 secp, void *buffer, size_t len,
 	cmd.common.cdw10 = cpu_to_le32(((u32)secp) << 24 | ((u32)spsp) << 8);
 	cmd.common.cdw11 = cpu_to_le32(len);
 
-	return __nvme_submit_sync_cmd(ctrl->admin_q, &cmd, NULL, buffer, len, 0,
+	return __nvme_submit_sync_cmd(ctrl->admin_q, &cmd, NULL, buffer, len,
 			NVME_QID_ANY, 1, 0);
 }
 EXPORT_SYMBOL_GPL(nvme_sec_submit);
diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index ee79a6d639b4..0a0512300f1b 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -152,7 +152,7 @@ int nvmf_reg_read32(struct nvme_ctrl *ctrl, u32 off, u32 *val)
 	cmd.prop_get.fctype = nvme_fabrics_type_property_get;
 	cmd.prop_get.offset = cpu_to_le32(off);
 
-	ret = __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, &res, NULL, 0, 0,
+	ret = __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, &res, NULL, 0,
 			NVME_QID_ANY, 0, 0);
 
 	if (ret >= 0)
@@ -198,7 +198,7 @@ int nvmf_reg_read64(struct nvme_ctrl *ctrl, u32 off, u64 *val)
 	cmd.prop_get.attrib = 1;
 	cmd.prop_get.offset = cpu_to_le32(off);
 
-	ret = __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, &res, NULL, 0, 0,
+	ret = __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, &res, NULL, 0,
 			NVME_QID_ANY, 0, 0);
 
 	if (ret >= 0)
@@ -243,7 +243,7 @@ int nvmf_reg_write32(struct nvme_ctrl *ctrl, u32 off, u32 val)
 	cmd.prop_set.offset = cpu_to_le32(off);
 	cmd.prop_set.value = cpu_to_le64(val);
 
-	ret = __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, NULL, NULL, 0, 0,
+	ret = __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, NULL, NULL, 0,
 			NVME_QID_ANY, 0, 0);
 	if (unlikely(ret))
 		dev_err(ctrl->device,
@@ -389,7 +389,7 @@ int nvmf_connect_admin_queue(struct nvme_ctrl *ctrl)
 	strncpy(data->hostnqn, ctrl->opts->host->nqn, NVMF_NQN_SIZE);
 
 	ret = __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, &res,
-			data, sizeof(*data), 0, NVME_QID_ANY, 1,
+			data, sizeof(*data), NVME_QID_ANY, 1,
 			BLK_MQ_REQ_RESERVED | BLK_MQ_REQ_NOWAIT);
 	if (ret) {
 		nvmf_log_connect_error(ctrl, ret, le32_to_cpu(res.u32),
@@ -450,7 +450,7 @@ int nvmf_connect_io_queue(struct nvme_ctrl *ctrl, u16 qid)
 	strncpy(data->hostnqn, ctrl->opts->host->nqn, NVMF_NQN_SIZE);
 
 	ret = __nvme_submit_sync_cmd(ctrl->connect_q, &cmd, &res,
-			data, sizeof(*data), 0, qid, 1,
+			data, sizeof(*data), qid, 1,
 			BLK_MQ_REQ_RESERVED | BLK_MQ_REQ_NOWAIT);
 	if (ret) {
 		nvmf_log_connect_error(ctrl, ret, le32_to_cpu(res.u32),
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 81c4f5379c0c..88bd147b8048 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -752,7 +752,7 @@ int nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 		void *buf, unsigned bufflen);
 int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 		union nvme_result *result, void *buffer, unsigned bufflen,
-		unsigned timeout, int qid, int at_head,
+		int qid, int at_head,
 		blk_mq_req_flags_t flags);
 int nvme_set_features(struct nvme_ctrl *dev, unsigned int fid,
 		      unsigned int dword11, void *buffer, size_t buflen,
-- 
2.29.0



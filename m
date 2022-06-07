Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D328BC43334
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Jun 2022 01:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ww1j1RH95XgBMINzqWRuBSea+Ng/xGCWGawYFMWjVNQ=; b=01/4+2Mb7yDhLr01wJsSZjqruL
	5UNnkFWUV08yLwSzGHB0zsGh835o5jJs9JqnKH3CG8qnrzq856OH2ylcHI9pJlLzRNFLEGdvXKo5P
	0O0VAxr0BQkHL+B+zR1eKH+dW6XDKDx3QUkXEciYuSnUqyG1P1iCl2dp8N968zqH3jUG5r7cQ3pvw
	Yz1mMLbNuSPyKsLUF9FkS0FDgf3h8DdmHu5nETOPGRBPqWfDIWuS5JP3LFA+Wy8pkb9jnYrN3gjeP
	Nr7aLSh+NzxXDcnG2unsiS85FQYUfET0+VEBxN4UqR3ludD5vuT7KSBNHTCYGLuRJBBP7Nhq1ia6v
	Fcrob9kA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nyNr4-003yH1-MQ; Tue, 07 Jun 2022 01:17:58 +0000
Received: from mail-dm6nam11on20609.outbound.protection.outlook.com ([2a01:111:f400:7eaa::609] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nyNr2-003yFG-BM
	for linux-nvme@lists.infradead.org; Tue, 07 Jun 2022 01:17:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VUe+w/jzQGGy945pbwBju16shFUwF4sQOFqtpdxQmARRYnadMqOS8R0fBQVE+V6VmBo2DB8ZwbIguNNI8I2jkqIMZlI42MA+gCBGdYUK1bhvy3oKCYz1NTcGIbPxy55Qg2lRQSIDBtk6mvI4l9g0U8gSudRI4T3lDBSkQndS2gSUBPZzhhza1T+QErlwTTxdumo9j1U5SmB6scUrdEza9Edw0YPtvz9r3UAr2bXAKIBe/UwOwKTZ6ZRSobQg3rkc5zodUS32LweMRi11WsbEASW+ycu7DJiz/p6URYk4KXkNuwDct6rWk5ICYn7S2qWHDRdmHjF2OHcBzZiQ7gu3gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ww1j1RH95XgBMINzqWRuBSea+Ng/xGCWGawYFMWjVNQ=;
 b=mfJQ7HyHvXx2EUsVVhEeIQA/QueHQeHEcxCKuafIfL+BvhMbz2Z0O7+hpqoVGxMSOo9f/KXybX9A2jMs6B0v67OiLn1osOR34OSsj60VoSfZcxVRWFvLc0TkNCA77p/XX0tp79JIYIs3Lm57iZ1ji7EjI2YrbuP6x4B+e5lVSWevtCkEc28p0Oo9lUg4fF8RN+tSVkKTZv6mpAYl4PVqttxBc384ZYHJWEvkHJM1+eYA2785DNWzEj9zjLOHGoQ88QwKlmvtccf+dhM01Xv80Di+3IaOovLKX5m6z4iqvFHR9YRH/oPHvLa10AMzOzqlO8/3EHN2IZfYSGRwiI5TeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ww1j1RH95XgBMINzqWRuBSea+Ng/xGCWGawYFMWjVNQ=;
 b=UpIkNetwZkdLg1CEdRFs09XcQ+ubDwYlaaMjkQilVbbtQ+zi0mk690Fkir6HIeEW6X3wrUs275/wKKjqfIB6QCIG2lYJWF8QiYEbHI0CXk/G3TvWjhR+Opv9f1E1nFGw8Zc9bz9Ey3lXJzJBSaV/x+RHXvicrbUI4czcCiwUxelAeLSyqw8SDjpOaEIMB5v1sh7AVB/GaGQ46gFzP7WoFFBqUMl/MjKMj7ZGo5WE1+lG/hJgU+rznz9zUG6rIwzcaenRDr6xrI2NKe7iu6wMPJzwXFT2mLRmPUurQTTuIiB9EgT5DR3YrJcFv08TD9kdsmkmuktQpQbSWRH2PurPHw==
Received: from BN6PR2001CA0024.namprd20.prod.outlook.com
 (2603:10b6:404:b4::34) by MWHPR12MB1470.namprd12.prod.outlook.com
 (2603:10b6:301:f::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Tue, 7 Jun
 2022 01:17:51 +0000
Received: from BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:b4:cafe::b2) by BN6PR2001CA0024.outlook.office365.com
 (2603:10b6:404:b4::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19 via Frontend
 Transport; Tue, 7 Jun 2022 01:17:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.234) by
 BN8NAM11FT040.mail.protection.outlook.com (10.13.177.166) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5314.12 via Frontend Transport; Tue, 7 Jun 2022 01:17:50 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Tue, 7 Jun
 2022 01:17:50 +0000
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 6 Jun 2022
 18:17:49 -0700
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>,
	<james.smart@broadcom.com>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 5/6] nvme-core: remove at_head parameter
Date: Mon, 6 Jun 2022 18:16:46 -0700
Message-ID: <20220607011647.24105-6-kch@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: 255b3b9d-05bf-430b-f995-08da48238a71
X-MS-TrafficTypeDiagnostic: MWHPR12MB1470:EE_
X-Microsoft-Antispam-PRVS: 	<MWHPR12MB14700569C5BCAB9C72A673A1A3A59@MWHPR12MB1470.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	HFOr2r0A+LHMWCyA+Tz27JH9JE3h17JnL6KFnp8PUeq1G1csfNBH4WKufyHDNkGnideoG8EqIXlS5uHqolmQf+VfIos5lHbJ3sClA6RCa/qzJRd3i0XMbnQnpEhLk8kcjsH2Zr1ozpQQUe9zSZiKuSxJDmost55OYVt3C4oNHexeAUjEHQ5EwKZlf6FHIvf6rMu8spQWv13ql654f5dmx89RhRbBiQwKlIne5nK4IoP4aWCFf3MY/GFdSUs3wDWQqFxSDo0PP+6h/unl3XaEShZZGa2PEqduE/ZGV5H96J1PCL+4nqv6/rF1Bu/TR0ysbcYCohLiiWbvAvxhc5mTru8yOHhbXyIWbrSkl8P2NLBsXn2r59zlF/aIfkmDUoKYJVEBwXO0ocVtV07/o7Twdd25y1mNMtclnGAaZ3AF71stLXapfc0gWkEmQa3/aXHeqxM5DwV+CBcv5p0ppTg0vpnDEeOqKhsoM1KyrP3fnMD4gZdefOpYrrPnOott8dvjsPygoGazHmy4AjweyZffbYoJN/BN5FLyvygKIPKgc9Y4lUxFmtTbqOIRyfqwXT8yfijwsDAUmo/2Tza+5hZD7FaaAKuDCDNKeRjCBRzAPd37TeAWUtrFBb8GsHZK0cEUe0+1tadDOUfyinkKhg/et0ljbCLBpvTx1MR7kFr2PISeKhVLJhUR99NdTofhHhtZ9f11VThYUd8IYmHrXiSp/A==
X-Forefront-Antispam-Report: 	CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(54906003)(7696005)(70586007)(70206006)(8936002)(16526019)(186003)(508600001)(5660300002)(4326008)(8676002)(2616005)(1076003)(107886003)(40460700003)(426003)(82310400005)(81166007)(356005)(26005)(6916009)(6666004)(2906002)(47076005)(336012)(36756003)(316002)(83380400001)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2022 01:17:50.8408
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 255b3b9d-05bf-430b-f995-08da48238a71
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: 	BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1470
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220606_181756_434847_E8D7C632 
X-CRM114-Status: GOOD (  12.93  )
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
that sets the at_head value :-

Callers                         |   at_head value
----------------------------------------------
nvme_submit_sync_cmd()          |       0
nvme_features()                 |       0
nvme_sec_submit()               |       1
nvmf_reg_read32()               |       0
nvmf_reg_read64()               |       0
nvmf_reg_write32()              |       0
nvmf_connect_admin_queue()      |       1
nvmf_connect_io_queue()         |       1

Remove the at_head function parameter from __nvme_submit_sync_cmd() and
and derive from nvme_command if the caller is nvmf_connect_admin_queue()
or nvmf_connect_io_queue() or nvme_sec_submit() and adjust the rest
of code accordingly.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/host/core.c    | 20 +++++++++++++-------
 drivers/nvme/host/fabrics.c | 10 +++++-----
 drivers/nvme/host/nvme.h    |  3 +--
 3 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index b8daf3ab9a22..41c0045ceb5e 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -996,13 +996,20 @@ static inline bool is_fabrics_io_connect_cmd(struct nvme_command *cmd)
 	       le16_to_cpu(cmd->connect.qid) > 0;
 }
 
+static inline bool is_at_head(struct nvme_command *cmd)
+{
+	return (is_fabrics_admin_connect_cmd(cmd) ||
+	       is_fabrics_io_connect_cmd(cmd) ||
+	       cmd->common.opcode == nvme_admin_security_send ||
+	       cmd->common.opcode == nvme_admin_security_recv) ? true : false;
+}
+
 /*
  * Returns 0 on success.  If the result is negative, it's a Linux error code;
  * if the result is positive, it's an NVM Express status code
  */
 int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
-		union nvme_result *result, void *buffer, unsigned bufflen,
-		int at_head)
+		union nvme_result *result, void *buffer, unsigned bufflen)
 {
 	blk_mq_req_flags_t flags = 0;
 	int qid = NVME_QID_ANY;
@@ -1034,7 +1041,7 @@ int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 	}
 
 	req->rq_flags |= RQF_QUIET;
-	ret = nvme_execute_rq(req, at_head);
+	ret = nvme_execute_rq(req, is_at_head(cmd));
 	if (result && ret >= 0)
 		*result = nvme_req(req)->result;
  out:
@@ -1046,7 +1053,7 @@ EXPORT_SYMBOL_GPL(__nvme_submit_sync_cmd);
 int nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 		void *buffer, unsigned bufflen)
 {
-	return __nvme_submit_sync_cmd(q, cmd, NULL, buffer, bufflen, 0);
+	return __nvme_submit_sync_cmd(q, cmd, NULL, buffer, bufflen);
 }
 EXPORT_SYMBOL_GPL(nvme_submit_sync_cmd);
 
@@ -1481,7 +1488,7 @@ static int nvme_features(struct nvme_ctrl *dev, u8 op, unsigned int fid,
 	c.features.fid = cpu_to_le32(fid);
 	c.features.dword11 = cpu_to_le32(dword11);
 
-	ret = __nvme_submit_sync_cmd(dev->admin_q, &c, &res, buffer, buflen, 0);
+	ret = __nvme_submit_sync_cmd(dev->admin_q, &c, &res, buffer, buflen);
 	if (ret >= 0 && result)
 		*result = le32_to_cpu(res.u32);
 	return ret;
@@ -2118,8 +2125,7 @@ int nvme_sec_submit(void *data, u16 spsp, u8 secp, void *buffer, size_t len,
 	cmd.common.cdw10 = cpu_to_le32(((u32)secp) << 24 | ((u32)spsp) << 8);
 	cmd.common.cdw11 = cpu_to_le32(len);
 
-	return __nvme_submit_sync_cmd(ctrl->admin_q, &cmd, NULL, buffer, len,
-			1);
+	return __nvme_submit_sync_cmd(ctrl->admin_q, &cmd, NULL, buffer, len);
 }
 EXPORT_SYMBOL_GPL(nvme_sec_submit);
 #endif /* CONFIG_BLK_SED_OPAL */
diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 3ca1a10cfb1c..0d620e5285cf 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -152,7 +152,7 @@ int nvmf_reg_read32(struct nvme_ctrl *ctrl, u32 off, u32 *val)
 	cmd.prop_get.fctype = nvme_fabrics_type_property_get;
 	cmd.prop_get.offset = cpu_to_le32(off);
 
-	ret = __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, &res, NULL, 0, 0);
+	ret = __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, &res, NULL, 0);
 
 	if (ret >= 0)
 		*val = le64_to_cpu(res.u64);
@@ -197,7 +197,7 @@ int nvmf_reg_read64(struct nvme_ctrl *ctrl, u32 off, u64 *val)
 	cmd.prop_get.attrib = 1;
 	cmd.prop_get.offset = cpu_to_le32(off);
 
-	ret = __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, &res, NULL, 0, 0);
+	ret = __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, &res, NULL, 0);
 
 	if (ret >= 0)
 		*val = le64_to_cpu(res.u64);
@@ -241,7 +241,7 @@ int nvmf_reg_write32(struct nvme_ctrl *ctrl, u32 off, u32 val)
 	cmd.prop_set.offset = cpu_to_le32(off);
 	cmd.prop_set.value = cpu_to_le64(val);
 
-	ret = __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, NULL, NULL, 0, 0);
+	ret = __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, NULL, NULL, 0);
 	if (unlikely(ret))
 		dev_err(ctrl->device,
 			"Property Set error: %d, offset %#x\n",
@@ -386,7 +386,7 @@ int nvmf_connect_admin_queue(struct nvme_ctrl *ctrl)
 	strncpy(data->hostnqn, ctrl->opts->host->nqn, NVMF_NQN_SIZE);
 
 	ret = __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, &res,
-			data, sizeof(*data), 1);
+			data, sizeof(*data));
 	if (ret) {
 		nvmf_log_connect_error(ctrl, ret, le32_to_cpu(res.u32),
 				       &cmd, data);
@@ -446,7 +446,7 @@ int nvmf_connect_io_queue(struct nvme_ctrl *ctrl, u16 qid)
 	strncpy(data->hostnqn, ctrl->opts->host->nqn, NVMF_NQN_SIZE);
 
 	ret = __nvme_submit_sync_cmd(ctrl->connect_q, &cmd, &res,
-			data, sizeof(*data), 1);
+			data, sizeof(*data));
 	if (ret) {
 		nvmf_log_connect_error(ctrl, ret, le32_to_cpu(res.u32),
 				       &cmd, data);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 3e1c5fbf5603..3dbbc4b1a1c2 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -751,8 +751,7 @@ static inline bool nvme_is_unique_nsid(struct nvme_ctrl *ctrl,
 int nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 		void *buf, unsigned bufflen);
 int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
-		union nvme_result *result, void *buffer, unsigned bufflen,
-		int at_head);
+		union nvme_result *result, void *buffer, unsigned bufflen);
 int nvme_set_features(struct nvme_ctrl *dev, unsigned int fid,
 		      unsigned int dword11, void *buffer, size_t buflen,
 		      u32 *result);
-- 
2.29.0



Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6EC3C433EF
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Jun 2022 01:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yV3s/yn5cvV1/R4hLi8LFrc8oMp6FdPk0CYxib797YM=; b=qXTkkV1NwrxSarWULEQINFkTyf
	I3544ZaGPiUjGZAF/53q441Ltirdhr9bTFRCYROM+JH9ss5gedNqcVq6MsihWAikIPCS2+tTiZrM2
	YnLEAlxj/QvJ7WYpEJ05XfgSSfMHGZw2Cs7KnNnyg5mmpTdrPn2Vr0QOKp+DjdX5Qlfqs8CUeZeHa
	6nO6aDCqQvq1MiEGkDrXD/6gm0mDdVRBsDM64hciRvw9N2g5rt4Y+nwCUo4gCMsdw6Q0jod20WQNf
	7XK3y4Y2XaylNx/cMFIHoZpOkenDtypQ/3lkBm8xA51cX1YY3HhqImOgmPgLRuy6B3dBYPUhHAJ7h
	KYbDeQEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nyNrI-003yN5-GM; Tue, 07 Jun 2022 01:18:12 +0000
Received: from mail-mw2nam12on20614.outbound.protection.outlook.com ([2a01:111:f400:fe5a::614] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nyNrE-003yKu-55
	for linux-nvme@lists.infradead.org; Tue, 07 Jun 2022 01:18:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LDPGxI4X3g7AXCeZ/LfMpQJK9z7+qY5s8mmmtAQc+xEmD5NToTKmNix4Mx/0bxwDvs5+7BQbeLE9JkfeQ7KR7pXMG4JDEhl68sHkHw6NUsDCT8j94zOEFei81VjRZeg7D2tVHTFchPow6gVAsbj5Y2ZeAf5ewy2NhCv97YwdBVo/JmMfIZstq9T47k53j8RDoQPyQE1DkBLJCX2Q6rYNbOsRQUT0S+lpdH8aVTbVHvUZLGQPPtUf+T74QOPRDsTKIAqrSdzrzLCUFxEVCna6jAVcChE8offzk3VyXwZ2EmPVPcMAUdl41jkmNASahxyCN+vkuf8QFGc05NbliqPhEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yV3s/yn5cvV1/R4hLi8LFrc8oMp6FdPk0CYxib797YM=;
 b=GH0Em4GcyutvAFuK8tGU1ss9lFjv6u9BfCKeBswVP2CybdpMjjI69hrWSJRe9X7Y5HLeJ3kmzHKrFSbiP9AOchRUtrpBMrJh4Na9TVS805iP2AmXJ5FMNb/UcX7JpCwxWxXlXP3pq2kdrZCayXKEdwmEtoGBzND+mkx60uPqlF5J2oqbkQLoYiN5B5/OcXMGy2PUcyz+o+x1avn8TWU5Mnkmb8WxjvCEPD23hAguTlvzu8yOQ9vSaa5dun53mf2fBEfTpOB9f4AUOILqMTo58XtKEYbQvfWqYoYuoiYTWG8UcWTLdDdFDF4M/NAoYBbfEc/JAS1CpVYQ4zMQbgTpxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yV3s/yn5cvV1/R4hLi8LFrc8oMp6FdPk0CYxib797YM=;
 b=OxE3WKAUuh61zma0DPbtJLK/uQ6fNKFQiOHw/eOFPU+UCbrCs6hrFocbC3moks/+JSZS7SSf2Z90Wxmdn5anK6z/rM2MNgeYyGGIGO1jKq8zIvPMPCMHELJijT1JY3slwHv2hcEtz+emZhvo6bnmh4rBosxmnpsc26VE9YlkfDZKYQ+m+/cY3LgHKNndwKufLLddOkioRYmfdRu1ThxxSXVuoFR+LVMle/v+uYbvvAr3TDyNwO5NqnB7aclSQwwnxUCuok3cmcS+1AGiys2lYTuTTukrKk7F60Bb/V6qSV7vjH9or0TMZc6Wy8uEINaz8T2ge9g7/xp+q3N7WLSH+A==
Received: from BN6PR14CA0016.namprd14.prod.outlook.com (2603:10b6:404:79::26)
 by BY5PR12MB3922.namprd12.prod.outlook.com (2603:10b6:a03:195::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.15; Tue, 7 Jun
 2022 01:18:02 +0000
Received: from BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:79:cafe::f6) by BN6PR14CA0016.outlook.office365.com
 (2603:10b6:404:79::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12 via Frontend
 Transport; Tue, 7 Jun 2022 01:18:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.234) by
 BN8NAM11FT012.mail.protection.outlook.com (10.13.177.55) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5314.12 via Frontend Transport; Tue, 7 Jun 2022 01:18:01 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Tue, 7 Jun
 2022 01:18:00 +0000
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 6 Jun 2022
 18:18:00 -0700
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>,
	<james.smart@broadcom.com>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 6/6] nvme-core: remove __nvme_submit_sync_cmd() wrapper
Date: Mon, 6 Jun 2022 18:16:47 -0700
Message-ID: <20220607011647.24105-7-kch@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: b06264e9-216e-4611-79ff-08da482390fd
X-MS-TrafficTypeDiagnostic: BY5PR12MB3922:EE_
X-Microsoft-Antispam-PRVS: 	<BY5PR12MB392214F4ABB1BA316208F9DBA3A59@BY5PR12MB3922.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	jT5W4RPfziyHedNvbIfJRZaXgQUMOAQ9cknaLtBXDWI/Q7LWyum+SJSlO3vWja2AzgXPZrrSWSD7EHU6dgPPhdvG1IJzEhjXum4rQ5RkTZsvG0gsKX6nYipdfuM9c5uRClraH27Jxp4AadBmIveivtEbbzHXK7OgAdNJSk7E6e+8qnlAfrvl7ckRdBz8Hc5TuMViIWxBAZ3aAYXm95Kv1CZJun2pB5m68XOv2SXTMuH8jbsVaKOcFEjqnoqMy2jTp2rbVPxChc7EUN+Q7D102XOY9QHwDet4G3jSJvPGHeCayNSZb9/g+XBkbuHWEmGvFnxJmzcM8/bi+Ehu5GwGKc1MAMUe/KaB7/puUqFpEE5c4er/lqGlRAyi/sSLiYJnmd2O/bxi0JiZcK8pY6aSRMKZmfICCysu6YmiEBiPw8cv0skSFDGXd97kiHGYUyXDk0ZlPcOsFnDCuFIpIZVW2bQffif3dNS4ctVYHko7fogE7l0HR/iqEjWNoIpwNo8GW8TQE1Z4Votc7cqxYjz9rEmP+/mXWBc31KPlIeG3kosF6Bb32cpYjpZYww5rOUwS1TYJVPR7gObuk4btjYuEj1PxCvtf63FKH2pohdTRzaZm3Rw8w3lOavqA2RUTuV7X6xd+zbN9ktN4yH4VxRWHej/alY7qPJGmUsrlMtluhF/JPCGa9dRcyg4ra8a1nA7MFsxOajgWaM+mLRpZoi053g==
X-Forefront-Antispam-Report: 	CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(81166007)(26005)(356005)(107886003)(5660300002)(2906002)(8936002)(7696005)(30864003)(82310400005)(83380400001)(36860700001)(6666004)(508600001)(426003)(336012)(47076005)(16526019)(1076003)(40460700003)(186003)(2616005)(6916009)(54906003)(70206006)(8676002)(4326008)(36756003)(70586007)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2022 01:18:01.7432
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b06264e9-216e-4611-79ff-08da482390fd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: 	BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3922
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220606_181808_324511_692EDFBA 
X-CRM114-Status: GOOD (  12.04  )
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

Now that __nvme_submit_sync_cmd() has small number of function
parameters remove nvme_submit_sync_cmd() wrapper, rename
__nvme_submit_sync_cmd() to nvme_submit_sync_cmd() and adjust the
callsites.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/host/core.c    | 35 +++++++++++++++--------------------
 drivers/nvme/host/fabrics.c | 10 +++++-----
 drivers/nvme/host/nvme.h    |  2 --
 drivers/nvme/host/pci.c     | 10 +++++-----
 drivers/nvme/host/zns.c     |  7 ++++---
 5 files changed, 29 insertions(+), 35 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 41c0045ceb5e..b5a040296aa5 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1008,7 +1008,7 @@ static inline bool is_at_head(struct nvme_command *cmd)
  * Returns 0 on success.  If the result is negative, it's a Linux error code;
  * if the result is positive, it's an NVM Express status code
  */
-int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
+int nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 		union nvme_result *result, void *buffer, unsigned bufflen)
 {
 	blk_mq_req_flags_t flags = 0;
@@ -1048,13 +1048,6 @@ int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 	blk_mq_free_request(req);
 	return ret;
 }
-EXPORT_SYMBOL_GPL(__nvme_submit_sync_cmd);
-
-int nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
-		void *buffer, unsigned bufflen)
-{
-	return __nvme_submit_sync_cmd(q, cmd, NULL, buffer, bufflen);
-}
 EXPORT_SYMBOL_GPL(nvme_submit_sync_cmd);
 
 static u32 nvme_known_admin_effects(u8 opcode)
@@ -1293,7 +1286,7 @@ static int nvme_identify_ctrl(struct nvme_ctrl *dev, struct nvme_id_ctrl **id)
 	if (!*id)
 		return -ENOMEM;
 
-	error = nvme_submit_sync_cmd(dev->admin_q, &c, *id,
+	error = nvme_submit_sync_cmd(dev->admin_q, &c, NULL, *id,
 			sizeof(struct nvme_id_ctrl));
 	if (error)
 		kfree(*id);
@@ -1373,7 +1366,7 @@ static int nvme_identify_ns_descs(struct nvme_ctrl *ctrl, unsigned nsid,
 	if (!data)
 		return -ENOMEM;
 
-	status = nvme_submit_sync_cmd(ctrl->admin_q, &c, data,
+	status = nvme_submit_sync_cmd(ctrl->admin_q, &c, NULL, data,
 				      NVME_IDENTIFY_DATA_SIZE);
 	if (status) {
 		dev_warn(ctrl->device,
@@ -1421,7 +1414,8 @@ static int nvme_identify_ns(struct nvme_ctrl *ctrl, unsigned nsid,
 	if (!*id)
 		return -ENOMEM;
 
-	error = nvme_submit_sync_cmd(ctrl->admin_q, &c, *id, sizeof(**id));
+	error = nvme_submit_sync_cmd(ctrl->admin_q, &c, NULL, *id,
+				     sizeof(**id));
 	if (error) {
 		dev_warn(ctrl->device, "Identify namespace failed (%d)\n", error);
 		goto out_free_id;
@@ -1465,7 +1459,7 @@ static int nvme_identify_ns_cs_indep(struct nvme_ctrl *ctrl, unsigned nsid,
 	if (!*id)
 		return -ENOMEM;
 
-	ret = nvme_submit_sync_cmd(ctrl->admin_q, &c, *id, sizeof(**id));
+	ret = nvme_submit_sync_cmd(ctrl->admin_q, &c, NULL, *id, sizeof(**id));
 	if (ret) {
 		dev_warn(ctrl->device,
 			 "Identify namespace (CS independent) failed (%d)\n",
@@ -1488,7 +1482,7 @@ static int nvme_features(struct nvme_ctrl *dev, u8 op, unsigned int fid,
 	c.features.fid = cpu_to_le32(fid);
 	c.features.dword11 = cpu_to_le32(dword11);
 
-	ret = __nvme_submit_sync_cmd(dev->admin_q, &c, &res, buffer, buflen);
+	ret = nvme_submit_sync_cmd(dev->admin_q, &c, &res, buffer, buflen);
 	if (ret >= 0 && result)
 		*result = le32_to_cpu(res.u32);
 	return ret;
@@ -1729,7 +1723,8 @@ static int nvme_init_ms(struct nvme_ns *ns, struct nvme_id_ns *id)
 	c.identify.cns = NVME_ID_CNS_CS_NS;
 	c.identify.csi = NVME_CSI_NVM;
 
-	ret = nvme_submit_sync_cmd(ns->ctrl->admin_q, &c, nvm, sizeof(*nvm));
+	ret = nvme_submit_sync_cmd(ns->ctrl->admin_q, &c, NULL, nvm,
+				   sizeof(*nvm));
 	if (ret)
 		goto free_data;
 
@@ -2022,7 +2017,7 @@ static int nvme_send_ns_head_pr_command(struct block_device *bdev,
 
 	if (ns) {
 		c->common.nsid = cpu_to_le32(ns->head->ns_id);
-		ret = nvme_submit_sync_cmd(ns->queue, c, data, 16);
+		ret = nvme_submit_sync_cmd(ns->queue, c, NULL, data, 16);
 	}
 	srcu_read_unlock(&head->srcu, srcu_idx);
 	return ret;
@@ -2032,7 +2027,7 @@ static int nvme_send_ns_pr_command(struct nvme_ns *ns, struct nvme_command *c,
 		u8 data[16])
 {
 	c->common.nsid = cpu_to_le32(ns->head->ns_id);
-	return nvme_submit_sync_cmd(ns->queue, c, data, 16);
+	return nvme_submit_sync_cmd(ns->queue, c, NULL, data, 16);
 }
 
 static int nvme_pr_command(struct block_device *bdev, u32 cdw10,
@@ -2125,7 +2120,7 @@ int nvme_sec_submit(void *data, u16 spsp, u8 secp, void *buffer, size_t len,
 	cmd.common.cdw10 = cpu_to_le32(((u32)secp) << 24 | ((u32)spsp) << 8);
 	cmd.common.cdw11 = cpu_to_le32(len);
 
-	return __nvme_submit_sync_cmd(ctrl->admin_q, &cmd, NULL, buffer, len);
+	return nvme_submit_sync_cmd(ctrl->admin_q, &cmd, NULL, buffer, len);
 }
 EXPORT_SYMBOL_GPL(nvme_sec_submit);
 #endif /* CONFIG_BLK_SED_OPAL */
@@ -2893,7 +2888,7 @@ int nvme_get_log(struct nvme_ctrl *ctrl, u32 nsid, u8 log_page, u8 lsp, u8 csi,
 	c.get_log_page.lpou = cpu_to_le32(upper_32_bits(offset));
 	c.get_log_page.csi = csi;
 
-	return nvme_submit_sync_cmd(ctrl->admin_q, &c, log, size);
+	return nvme_submit_sync_cmd(ctrl->admin_q, &c, NULL, log, size);
 }
 
 static int nvme_get_effects_log(struct nvme_ctrl *ctrl, u8 csi,
@@ -2968,7 +2963,7 @@ static int nvme_init_non_mdts_limits(struct nvme_ctrl *ctrl)
 	c.identify.cns = NVME_ID_CNS_CS_CTRL;
 	c.identify.csi = NVME_CSI_NVM;
 
-	ret = nvme_submit_sync_cmd(ctrl->admin_q, &c, id, sizeof(*id));
+	ret = nvme_submit_sync_cmd(ctrl->admin_q, &c, NULL, id, sizeof(*id));
 	if (ret)
 		goto free_data;
 
@@ -4257,7 +4252,7 @@ static int nvme_scan_ns_list(struct nvme_ctrl *ctrl)
 			.identify.nsid		= cpu_to_le32(prev),
 		};
 
-		ret = nvme_submit_sync_cmd(ctrl->admin_q, &cmd, ns_list,
+		ret = nvme_submit_sync_cmd(ctrl->admin_q, &cmd, NULL, ns_list,
 					    NVME_IDENTIFY_DATA_SIZE);
 		if (ret) {
 			dev_warn(ctrl->device,
diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 0d620e5285cf..8036038eafd3 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -152,7 +152,7 @@ int nvmf_reg_read32(struct nvme_ctrl *ctrl, u32 off, u32 *val)
 	cmd.prop_get.fctype = nvme_fabrics_type_property_get;
 	cmd.prop_get.offset = cpu_to_le32(off);
 
-	ret = __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, &res, NULL, 0);
+	ret = nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, &res, NULL, 0);
 
 	if (ret >= 0)
 		*val = le64_to_cpu(res.u64);
@@ -197,7 +197,7 @@ int nvmf_reg_read64(struct nvme_ctrl *ctrl, u32 off, u64 *val)
 	cmd.prop_get.attrib = 1;
 	cmd.prop_get.offset = cpu_to_le32(off);
 
-	ret = __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, &res, NULL, 0);
+	ret = nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, &res, NULL, 0);
 
 	if (ret >= 0)
 		*val = le64_to_cpu(res.u64);
@@ -241,7 +241,7 @@ int nvmf_reg_write32(struct nvme_ctrl *ctrl, u32 off, u32 val)
 	cmd.prop_set.offset = cpu_to_le32(off);
 	cmd.prop_set.value = cpu_to_le64(val);
 
-	ret = __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, NULL, NULL, 0);
+	ret = nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, NULL, NULL, 0);
 	if (unlikely(ret))
 		dev_err(ctrl->device,
 			"Property Set error: %d, offset %#x\n",
@@ -385,7 +385,7 @@ int nvmf_connect_admin_queue(struct nvme_ctrl *ctrl)
 	strncpy(data->subsysnqn, ctrl->opts->subsysnqn, NVMF_NQN_SIZE);
 	strncpy(data->hostnqn, ctrl->opts->host->nqn, NVMF_NQN_SIZE);
 
-	ret = __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, &res,
+	ret = nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, &res,
 			data, sizeof(*data));
 	if (ret) {
 		nvmf_log_connect_error(ctrl, ret, le32_to_cpu(res.u32),
@@ -445,7 +445,7 @@ int nvmf_connect_io_queue(struct nvme_ctrl *ctrl, u16 qid)
 	strncpy(data->subsysnqn, ctrl->opts->subsysnqn, NVMF_NQN_SIZE);
 	strncpy(data->hostnqn, ctrl->opts->host->nqn, NVMF_NQN_SIZE);
 
-	ret = __nvme_submit_sync_cmd(ctrl->connect_q, &cmd, &res,
+	ret = nvme_submit_sync_cmd(ctrl->connect_q, &cmd, &res,
 			data, sizeof(*data));
 	if (ret) {
 		nvmf_log_connect_error(ctrl, ret, le32_to_cpu(res.u32),
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 3dbbc4b1a1c2..75e5420c1e6e 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -749,8 +749,6 @@ static inline bool nvme_is_unique_nsid(struct nvme_ctrl *ctrl,
 }
 
 int nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
-		void *buf, unsigned bufflen);
-int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 		union nvme_result *result, void *buffer, unsigned bufflen);
 int nvme_set_features(struct nvme_ctrl *dev, unsigned int fid,
 		      unsigned int dword11, void *buffer, size_t buflen,
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index cb4adc0c2284..b3eeff7905c9 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -325,7 +325,7 @@ static void nvme_dbbuf_set(struct nvme_dev *dev)
 	c.dbbuf.prp1 = cpu_to_le64(dev->dbbuf_dbs_dma_addr);
 	c.dbbuf.prp2 = cpu_to_le64(dev->dbbuf_eis_dma_addr);
 
-	if (nvme_submit_sync_cmd(dev->ctrl.admin_q, &c, NULL, 0)) {
+	if (nvme_submit_sync_cmd(dev->ctrl.admin_q, &c, NULL, NULL, 0)) {
 		dev_warn(dev->ctrl.device, "unable to set dbbuf\n");
 		/* Free memory and continue on */
 		nvme_dbbuf_dma_free(dev);
@@ -1217,7 +1217,7 @@ static int adapter_delete_queue(struct nvme_dev *dev, u8 opcode, u16 id)
 	c.delete_queue.opcode = opcode;
 	c.delete_queue.qid = cpu_to_le16(id);
 
-	return nvme_submit_sync_cmd(dev->ctrl.admin_q, &c, NULL, 0);
+	return nvme_submit_sync_cmd(dev->ctrl.admin_q, &c, NULL, NULL, 0);
 }
 
 static int adapter_alloc_cq(struct nvme_dev *dev, u16 qid,
@@ -1240,7 +1240,7 @@ static int adapter_alloc_cq(struct nvme_dev *dev, u16 qid,
 	c.create_cq.cq_flags = cpu_to_le16(flags);
 	c.create_cq.irq_vector = cpu_to_le16(vector);
 
-	return nvme_submit_sync_cmd(dev->ctrl.admin_q, &c, NULL, 0);
+	return nvme_submit_sync_cmd(dev->ctrl.admin_q, &c, NULL, NULL, 0);
 }
 
 static int adapter_alloc_sq(struct nvme_dev *dev, u16 qid,
@@ -1269,7 +1269,7 @@ static int adapter_alloc_sq(struct nvme_dev *dev, u16 qid,
 	c.create_sq.sq_flags = cpu_to_le16(flags);
 	c.create_sq.cqid = cpu_to_le16(qid);
 
-	return nvme_submit_sync_cmd(dev->ctrl.admin_q, &c, NULL, 0);
+	return nvme_submit_sync_cmd(dev->ctrl.admin_q, &c, NULL, NULL, 0);
 }
 
 static int adapter_delete_cq(struct nvme_dev *dev, u16 cqid)
@@ -1989,7 +1989,7 @@ static int nvme_set_host_mem(struct nvme_dev *dev, u32 bits)
 	c.features.dword14	= cpu_to_le32(upper_32_bits(dma_addr));
 	c.features.dword15	= cpu_to_le32(dev->nr_host_mem_descs);
 
-	ret = nvme_submit_sync_cmd(dev->ctrl.admin_q, &c, NULL, 0);
+	ret = nvme_submit_sync_cmd(dev->ctrl.admin_q, &c, NULL, NULL, 0);
 	if (ret) {
 		dev_warn(dev->ctrl.device,
 			 "failed to set host mem (err %d, flags %#x).\n",
diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
index 9f81beb4df4e..6a3b6eee6d14 100644
--- a/drivers/nvme/host/zns.c
+++ b/drivers/nvme/host/zns.c
@@ -32,7 +32,7 @@ static int nvme_set_max_append(struct nvme_ctrl *ctrl)
 	c.identify.cns = NVME_ID_CNS_CS_CTRL;
 	c.identify.csi = NVME_CSI_ZNS;
 
-	status = nvme_submit_sync_cmd(ctrl->admin_q, &c, id, sizeof(*id));
+	status = nvme_submit_sync_cmd(ctrl->admin_q, &c, NULL, id, sizeof(*id));
 	if (status) {
 		kfree(id);
 		return status;
@@ -84,7 +84,8 @@ int nvme_update_zone_info(struct nvme_ns *ns, unsigned lbaf)
 	c.identify.cns = NVME_ID_CNS_CS_NS;
 	c.identify.csi = NVME_CSI_ZNS;
 
-	status = nvme_submit_sync_cmd(ns->ctrl->admin_q, &c, id, sizeof(*id));
+	status = nvme_submit_sync_cmd(ns->ctrl->admin_q, &c, NULL, id,
+				      sizeof(*id));
 	if (status)
 		goto free_data;
 
@@ -202,7 +203,7 @@ int nvme_ns_report_zones(struct nvme_ns *ns, sector_t sector,
 		memset(report, 0, buflen);
 
 		c.zmr.slba = cpu_to_le64(nvme_sect_to_lba(ns, sector));
-		ret = nvme_submit_sync_cmd(ns->queue, &c, report, buflen);
+		ret = nvme_submit_sync_cmd(ns->queue, &c, NULL, report, buflen);
 		if (ret) {
 			if (ret > 0)
 				ret = -EIO;
-- 
2.29.0



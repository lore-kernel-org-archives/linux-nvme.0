Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFEADC76196
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Mar 2023 03:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FS+biuliwFrJRdQKF5tKxstoc9hig36s8ykAdZEoVS0=; b=P794nTh5XXllhhNLNiH5BegMXJ
	2pCDSqCY+RG7HgC5C1Cg4K8/BQgcBBii9z2dXZDResb0S4ivJ2sY2WxvUHg0Pf4hbyOf1+7dE43ti
	Fn7z75QpWUl42uF9C+G+/Nmg6dOwsHkprFQRBJslnB/Tewg6uIgpqp/u0EcCx9daZws0kqPwxeb9d
	koJUrHgyi1LuPm1iygOE+/4u0EvM3XanRkHTMwL/3XHiyejsgpPrq2cO44I3ZVEUrhoRBKJpWwCPs
	Pa/zRdtVOXOA9l3kxSPpGyQhx1vQrTp6T+BCIz7gCJ2dll3CiLsZaIZISDjT4u3H6wEoOrsRBFClJ
	YI1hb4/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pfBmi-000eTO-0U;
	Thu, 23 Mar 2023 03:38:40 +0000
Received: from mail-co1nam11on20617.outbound.protection.outlook.com ([2a01:111:f400:7eab::617] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pfBmd-000ePc-1G
	for linux-nvme@lists.infradead.org;
	Thu, 23 Mar 2023 03:38:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gk/6aaaIz0QfOX8d2ZWpgf8AMpFfirW4k7tqs2nn1cQUFlGUcZVK3wxK9YKx3n+qgmnQnyE9O5iujXHXQj3cDhwc6LNE8ODXHb9B4HZxP3UjeQDBL2eY6cmYDnozanfCVUTVQsjZXWiv5HDQ7dPT7qxaoW+J81af5jfUXnVitlo9ArzvpZ3HvxOUXBJYV48ExBRzddRIlQ2zm5qAuMI/d/Yil5GkY/KA88ibCMD/IXpd3S1los6FG7iZbJITEaFC8OHBUOn88N1xSZ4uoWN1zHMbLb2gL2tYC4QLt371fsHWYpgD031PyOttUcw7gW9VnPTL5IusRAV7Z83DjRDWCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FS+biuliwFrJRdQKF5tKxstoc9hig36s8ykAdZEoVS0=;
 b=GdK6VnD+afxBNx9dGXE6sJRPwPrkh0nqy87lT2Nfxid00dQNhvt8Wq+zlndrVBqtYKLefUQBw8zAHP+vOctJNaRIRsNQb7TW3o+iL5ejeKrJ7fX5g7XgzSBeR8okWkNZAXyTDbF7eVZxXgG53DjIQ0WVJOQ9dv2NOhOcC3Lg442FIStKoc3LfX3/8b55CmUfINP11oRfFUuok27PXWb4YP57bvjMnjPG6r92Rped0ypFQVPdcqYMRmVxggpe+ANxw+m893idPphf/V6Q1QCRJm2YB0LoJPWpEr4gDOIpzjscc7kSQqiG8LmghTJPfFwgNWMuR3liQJRu4xgQr/WxfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FS+biuliwFrJRdQKF5tKxstoc9hig36s8ykAdZEoVS0=;
 b=beQi8JgDyp1wpaxN//8btXgCdkIPHxLY1wyXtZgVkcJdU0pP+WYVusSU79XQMkHnPYzdjMrhyS99VGvFX6P827TbGrsUmYNNLeRmz/WDYcFzlMAgWMYjFJG91V9/+EOZLH3hKY10nGlMNeiWp6VTEhhPVoUSCdXOim5f8IvppXFUSHNOpc9Zf5AL4BdmautTQkNS3rVTHV9+B7pEPg30aXAlM2+eeu92fsteV3z2MTJY+J7SgalNO6qpeZI3AOC3jFGI0Y5kOPmggBV3Y1oA/MIIwb+5Wx4tbCkJDHrwXIibowhP2lSxHZAjn5ISYqAjncudQq1Kn4Y420BGdEWZGA==
Received: from BN0PR04CA0158.namprd04.prod.outlook.com (2603:10b6:408:eb::13)
 by SJ0PR12MB6736.namprd12.prod.outlook.com (2603:10b6:a03:47a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Thu, 23 Mar
 2023 03:38:31 +0000
Received: from BN8NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:eb:cafe::1d) by BN0PR04CA0158.outlook.office365.com
 (2603:10b6:408:eb::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38 via Frontend
 Transport; Thu, 23 Mar 2023 03:38:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT058.mail.protection.outlook.com (10.13.177.58) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.17 via Frontend Transport; Thu, 23 Mar 2023 03:38:30 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 22 Mar 2023
 20:38:24 -0700
Received: from zion.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 22 Mar
 2023 20:38:23 -0700
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>, <hare@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 9/9] nvme-core: fix nvme_submit_sync_cmd() args
Date: Wed, 22 Mar 2023 20:36:36 -0700
Message-ID: <20230323033636.812758-10-kch@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230323033636.812758-1-kch@nvidia.com>
References: <20230323033636.812758-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT058:EE_|SJ0PR12MB6736:EE_
X-MS-Office365-Filtering-Correlation-Id: dd8bc2fe-02b1-47ed-b6e0-08db2b50124d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	gF02BIBS0Z0bWk2tX9dBofZvoBnWdDhh5WJA+PUn8bpl2DVAovZbgRUSrb8vgEyFO7DbP/BoR95bldF8LDZM1yWbiJxuoVIGML+ur1SpS2Xc3fBgckF9JQrrs+M82tShPGtCpSA1ViZdx9eUzVXobdfV4HE8A9ugyCuvOPMTQmls+8sm0AgnJMzRmdFzOYe4Msr2SPaK7bHqUOaD2RdVQsG4aF3Ief6r4cgbsMIbrzKhubSVRHRqaMLpxR+nHsbK2iKrW9aL3w4NN3/WErUdCXmWsWEjZf6CU0OyI6duPtqMGeMTGA9lsaCMLjiC4n/K9cX+SL5CzXk0rNeDYVnJPdcHz5iOv4ZK2BoffNsVwzo9JN8JpN6+bWbOKw6mRFHZF0uvL7bqSdxBs2IK3tHQ6r6ydypt31/my6G/Cj6zUXyWmBPsytl0WRVUQxMYwrDv4VGNbv1JzzhyPtILzmcwAAZgB6VmxB6BxM9hBw6dDopniS+zsCLoVBac1cD5gVUbagWRJLi90emn8NLo6WXHSHntpY69qZPbpp6jKhG7LyGs4uHp4/eg1pRQH2FEIe/tEMsxVd7ilCiH58DbeYnWmU9kZJ4ohPS8H7o2rjKJMV5g3pu9P8x6EOv68UqEHMdhxAwDXOcC8/ASwdpsU1bpXoIMjqFRim8rbPtx9twgUhBf48cgSUi7Zru+o2+3RbUoHrSL2Dwzkz5b/ABXHI8/kI8A9Ta9hG2svMdZulmiKlRybLf5Lcm1alTgepqkeMtd
X-Forefront-Antispam-Report: 	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(346002)(376002)(136003)(451199018)(40470700004)(46966006)(36840700001)(36756003)(36860700001)(82740400003)(7636003)(356005)(2906002)(40460700003)(41300700001)(8676002)(6916009)(4326008)(5660300002)(8936002)(30864003)(40480700001)(82310400005)(2616005)(336012)(186003)(16526019)(83380400001)(426003)(47076005)(1076003)(54906003)(70586007)(70206006)(316002)(478600001)(6666004)(26005)(107886003)(7696005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 03:38:30.5487
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd8bc2fe-02b1-47ed-b6e0-08db2b50124d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: 	BN8NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6736
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230322_203835_478479_BA8D0BB9 
X-CRM114-Status: GOOD (  18.73  )
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

The __nvme_submit_sync_cmd() function currently has a long list of
eight arguments, which can make it difficult to read and debug,
particularly when the function is commonly used from different parts
of the codebase. This complexity can also increase when extending the
functionality of the function, resulting in more arguments being added.

To address this issue, we can create a new structure called
nvme_submit_cmd_data and move all the existing arguments into this
structure. By doing this, we can pass the structure as a single argument
to the __nvme_submit_sync_cmd() function. This approach simplifies the
code and makes it more readable, and also provides a way to add future
arguments to the structure without increasing the number of function
arguments.

This pattern of using a structure for arguments is commonly used in the
block layer code:-

blk_mq_rq_cache_fill()
	struct blk_mq_allocate_data data = { ... }
	__blk_mq_alloc_request(data)
		blk_mq_rq_ctx_init(data)

blk_mq_alloc_and_init_hctx()
	blk_mq_alloc_request_hctx()
		struct blk_mq_allocate_data data = { ... }
 		blk_mq_rq_ctx_init(data)

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/host/auth.c    | 13 ++++++--
 drivers/nvme/host/core.c    | 61 +++++++++++++++++++++++++------------
 drivers/nvme/host/fabrics.c | 60 ++++++++++++++++++++++++++++--------
 drivers/nvme/host/nvme.h    | 16 +++++++---
 4 files changed, 112 insertions(+), 38 deletions(-)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index ea16a0aba679..48257cc4fc24 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -64,6 +64,15 @@ static int nvme_auth_submit(struct nvme_ctrl *ctrl, int qid,
 	struct nvme_command cmd = {};
 	blk_mq_req_flags_t flags = nvme_auth_flags_from_qid(qid);
 	struct request_queue *q = nvme_auth_queue_from_qid(ctrl, qid);
+	struct nvme_submit_cmd_data d = {
+		.q = q,
+		.cmd = &cmd,
+		.buffer = data,
+		.bufflen = data_len,
+		.qid = qid == 0 ? NVME_QID_ANY : qid,
+		.at_head = false,
+		.flags = flags,
+	};
 	int ret;
 
 	cmd.auth_common.opcode = nvme_fabrics_command;
@@ -78,9 +87,7 @@ static int nvme_auth_submit(struct nvme_ctrl *ctrl, int qid,
 		cmd.auth_receive.al = cpu_to_le32(data_len);
 	}
 
-	ret = __nvme_submit_sync_cmd(q, &cmd, NULL, data, data_len,
-				     qid == 0 ? NVME_QID_ANY : qid,
-				     0, flags);
+	ret = __nvme_submit_sync_cmd(&d);
 	if (ret > 0)
 		dev_warn(ctrl->device,
 			"qid %d auth_send failed with status %d\n", qid, ret);
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 481a326e80f7..9d4fdaa12063 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1025,32 +1025,30 @@ EXPORT_SYMBOL_NS_GPL(nvme_execute_rq, NVME_TARGET_PASSTHRU);
  * Returns 0 on success.  If the result is negative, it's a Linux error code;
  * if the result is positive, it's an NVM Express status code
  */
-int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
-		union nvme_result *result, void *buffer, unsigned bufflen,
-		int qid, int at_head, blk_mq_req_flags_t flags)
+int __nvme_submit_sync_cmd(struct nvme_submit_cmd_data *d)
 {
 	struct request *req;
 	int ret;
 
-	if (qid == NVME_QID_ANY)
-		req = blk_mq_alloc_request(q, nvme_req_op(cmd), flags);
+	if (d->qid == NVME_QID_ANY)
+		req = blk_mq_alloc_request(d->q, nvme_req_op(d->cmd), d->flags);
 	else
-		req = blk_mq_alloc_request_hctx(q, nvme_req_op(cmd), flags,
-						qid - 1);
+		req = blk_mq_alloc_request_hctx(d->q, nvme_req_op(d->cmd), d->flags,
+						d->qid - 1);
 
 	if (IS_ERR(req))
 		return PTR_ERR(req);
-	nvme_init_request(req, cmd);
+	nvme_init_request(req, d->cmd);
 
-	if (buffer && bufflen) {
-		ret = blk_rq_map_kern(q, req, buffer, bufflen, GFP_KERNEL);
+	if (d->buffer && d->bufflen) {
+		ret = blk_rq_map_kern(d->q, req, d->buffer, d->bufflen, GFP_KERNEL);
 		if (ret)
 			goto out;
 	}
 
-	ret = nvme_execute_rq(req, at_head);
-	if (result && ret >= 0)
-		*result = nvme_req(req)->result;
+	ret = nvme_execute_rq(req, d->at_head);
+	if (d->result && ret >= 0)
+		*(d->result) = nvme_req(req)->result;
  out:
 	blk_mq_free_request(req);
 	return ret;
@@ -1060,8 +1058,16 @@ EXPORT_SYMBOL_GPL(__nvme_submit_sync_cmd);
 int nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 		void *buffer, unsigned bufflen)
 {
-	return __nvme_submit_sync_cmd(q, cmd, NULL, buffer, bufflen,
-			NVME_QID_ANY, 0, 0);
+	struct nvme_submit_cmd_data d = {
+		.q = q,
+		.cmd = cmd,
+		.buffer = buffer,
+		.bufflen = bufflen,
+		.qid = NVME_QID_ANY,
+		.at_head = false,
+		.flags = 0,
+	};
+	return __nvme_submit_sync_cmd(&d);
 }
 EXPORT_SYMBOL_GPL(nvme_submit_sync_cmd);
 
@@ -1480,14 +1486,23 @@ static int nvme_features(struct nvme_ctrl *dev, u8 op, unsigned int fid,
 {
 	union nvme_result res = { 0 };
 	struct nvme_command c = { };
+	struct nvme_submit_cmd_data d = {
+		.q = dev->admin_q,
+		.cmd = &c,
+		.result = &res,
+		.buffer = buffer,
+		.bufflen = buflen,
+		.qid = NVME_QID_ANY,
+		.at_head = false,
+		.flags = 0,
+	};
 	int ret;
 
 	c.features.opcode = op;
 	c.features.fid = cpu_to_le32(fid);
 	c.features.dword11 = cpu_to_le32(dword11);
 
-	ret = __nvme_submit_sync_cmd(dev->admin_q, &c, &res,
-			buffer, buflen, NVME_QID_ANY, 0, 0);
+	ret = __nvme_submit_sync_cmd(&d);
 	if (ret >= 0 && result)
 		*result = le32_to_cpu(res.u32);
 	return ret;
@@ -2209,6 +2224,15 @@ static int nvme_sec_submit(void *data, u16 spsp, u8 secp, void *buffer, size_t l
 {
 	struct nvme_ctrl *ctrl = data;
 	struct nvme_command cmd = { };
+	struct nvme_submit_cmd_data d = {
+		.q = ctrl->admin_q,
+		.cmd = &cmd,
+		.buffer = buffer,
+		.bufflen = len,
+		.qid = NVME_QID_ANY,
+		.at_head = true,
+		.flags = 0,
+	};
 
 	if (send)
 		cmd.common.opcode = nvme_admin_security_send;
@@ -2218,8 +2242,7 @@ static int nvme_sec_submit(void *data, u16 spsp, u8 secp, void *buffer, size_t l
 	cmd.common.cdw10 = cpu_to_le32(((u32)secp) << 24 | ((u32)spsp) << 8);
 	cmd.common.cdw11 = cpu_to_le32(len);
 
-	return __nvme_submit_sync_cmd(ctrl->admin_q, &cmd, NULL, buffer, len,
-			NVME_QID_ANY, 1, 0);
+	return __nvme_submit_sync_cmd(&d);
 }
 
 static void nvme_configure_opal(struct nvme_ctrl *ctrl, bool was_suspended)
diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index bbaa04a0c502..56d0c41b659b 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -146,14 +146,21 @@ int nvmf_reg_read32(struct nvme_ctrl *ctrl, u32 off, u32 *val)
 {
 	struct nvme_command cmd = { };
 	union nvme_result res;
+	struct nvme_submit_cmd_data d = {
+		.q = ctrl->fabrics_q,
+		.cmd = &cmd,
+		.result = &res,
+		.qid = NVME_QID_ANY,
+		.at_head = false,
+		.flags = 0,
+	};
 	int ret;
 
 	cmd.prop_get.opcode = nvme_fabrics_command;
 	cmd.prop_get.fctype = nvme_fabrics_type_property_get;
 	cmd.prop_get.offset = cpu_to_le32(off);
 
-	ret = __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, &res, NULL, 0,
-			NVME_QID_ANY, 0, 0);
+	ret = __nvme_submit_sync_cmd(&d);
 
 	if (ret >= 0)
 		*val = le64_to_cpu(res.u64);
@@ -191,6 +198,14 @@ int nvmf_reg_read64(struct nvme_ctrl *ctrl, u32 off, u64 *val)
 {
 	struct nvme_command cmd = { };
 	union nvme_result res;
+	struct nvme_submit_cmd_data d = {
+		.q = ctrl->fabrics_q,
+		.cmd = &cmd,
+		.result = &res,
+		.qid = NVME_QID_ANY,
+		.at_head = false,
+		.flags = 0,
+	};
 	int ret;
 
 	cmd.prop_get.opcode = nvme_fabrics_command;
@@ -198,8 +213,7 @@ int nvmf_reg_read64(struct nvme_ctrl *ctrl, u32 off, u64 *val)
 	cmd.prop_get.attrib = 1;
 	cmd.prop_get.offset = cpu_to_le32(off);
 
-	ret = __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, &res, NULL, 0,
-			NVME_QID_ANY, 0, 0);
+	ret = __nvme_submit_sync_cmd(&d);
 
 	if (ret >= 0)
 		*val = le64_to_cpu(res.u64);
@@ -235,6 +249,13 @@ EXPORT_SYMBOL_GPL(nvmf_reg_read64);
 int nvmf_reg_write32(struct nvme_ctrl *ctrl, u32 off, u32 val)
 {
 	struct nvme_command cmd = { };
+	struct nvme_submit_cmd_data d = {
+		.q = ctrl->fabrics_q,
+		.cmd = &cmd,
+		.qid = NVME_QID_ANY,
+		.at_head = false,
+		.flags = 0,
+	};
 	int ret;
 
 	cmd.prop_set.opcode = nvme_fabrics_command;
@@ -243,8 +264,7 @@ int nvmf_reg_write32(struct nvme_ctrl *ctrl, u32 off, u32 val)
 	cmd.prop_set.offset = cpu_to_le32(off);
 	cmd.prop_set.value = cpu_to_le64(val);
 
-	ret = __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, NULL, NULL, 0,
-			NVME_QID_ANY, 0, 0);
+	ret = __nvme_submit_sync_cmd(&d);
 	if (unlikely(ret))
 		dev_err(ctrl->device,
 			"Property Set error: %d, offset %#x\n",
@@ -374,6 +394,15 @@ int nvmf_connect_admin_queue(struct nvme_ctrl *ctrl)
 	struct nvme_command cmd = { };
 	union nvme_result res;
 	struct nvmf_connect_data *data;
+	struct nvme_submit_cmd_data d = {
+		.q = ctrl->fabrics_q,
+		.cmd = &cmd,
+		.result = &res,
+		.bufflen = sizeof(*data),
+		.qid = NVME_QID_ANY,
+		.at_head = true,
+		.flags = BLK_MQ_REQ_RESERVED | BLK_MQ_REQ_NOWAIT,
+	};
 	int ret;
 	u32 result;
 
@@ -394,14 +423,13 @@ int nvmf_connect_admin_queue(struct nvme_ctrl *ctrl)
 	if (!data)
 		return -ENOMEM;
 
+	d.buffer = data;
 	uuid_copy(&data->hostid, &ctrl->opts->host->id);
 	data->cntlid = cpu_to_le16(0xffff);
 	strncpy(data->subsysnqn, ctrl->opts->subsysnqn, NVMF_NQN_SIZE);
 	strncpy(data->hostnqn, ctrl->opts->host->nqn, NVMF_NQN_SIZE);
 
-	ret = __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, &res,
-			data, sizeof(*data), NVME_QID_ANY, 1,
-			BLK_MQ_REQ_RESERVED | BLK_MQ_REQ_NOWAIT);
+	ret = __nvme_submit_sync_cmd(&d);
 	if (ret) {
 		nvmf_log_connect_error(ctrl, ret, le32_to_cpu(res.u32),
 				       &cmd, data);
@@ -465,6 +493,15 @@ int nvmf_connect_io_queue(struct nvme_ctrl *ctrl, u16 qid)
 	struct nvme_command cmd = { };
 	struct nvmf_connect_data *data;
 	union nvme_result res;
+	struct nvme_submit_cmd_data d = {
+		.q = ctrl->connect_q,
+		.cmd = &cmd,
+		.result = &res,
+		.bufflen = sizeof(*data),
+		.qid = qid,
+		.at_head = true,
+		.flags = BLK_MQ_REQ_RESERVED | BLK_MQ_REQ_NOWAIT,
+	};
 	int ret;
 	u32 result;
 
@@ -480,14 +517,13 @@ int nvmf_connect_io_queue(struct nvme_ctrl *ctrl, u16 qid)
 	if (!data)
 		return -ENOMEM;
 
+	d.buffer = data;
 	uuid_copy(&data->hostid, &ctrl->opts->host->id);
 	data->cntlid = cpu_to_le16(ctrl->cntlid);
 	strncpy(data->subsysnqn, ctrl->opts->subsysnqn, NVMF_NQN_SIZE);
 	strncpy(data->hostnqn, ctrl->opts->host->nqn, NVMF_NQN_SIZE);
 
-	ret = __nvme_submit_sync_cmd(ctrl->connect_q, &cmd, &res,
-			data, sizeof(*data), qid, 1,
-			BLK_MQ_REQ_RESERVED | BLK_MQ_REQ_NOWAIT);
+	ret = __nvme_submit_sync_cmd(&d);
 	if (ret) {
 		nvmf_log_connect_error(ctrl, ret, le32_to_cpu(res.u32),
 				       &cmd, data);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index bf46f122e9e1..4982cfda7e85 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -811,12 +811,20 @@ static inline bool nvme_is_unique_nsid(struct nvme_ctrl *ctrl,
 		(ctrl->ctratt & NVME_CTRL_CTRATT_NVM_SETS);
 }
 
+struct nvme_submit_cmd_data {
+	struct request_queue *q;
+	struct nvme_command *cmd;
+	union nvme_result *result;
+	void *buffer;
+	unsigned int bufflen;
+	int qid;
+	bool at_head;
+	blk_mq_req_flags_t flags;
+};
+
 int nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 		void *buf, unsigned bufflen);
-int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
-		union nvme_result *result, void *buffer, unsigned bufflen,
-		int qid, int at_head,
-		blk_mq_req_flags_t flags);
+int __nvme_submit_sync_cmd(struct nvme_submit_cmd_data *d);
 int nvme_set_features(struct nvme_ctrl *dev, unsigned int fid,
 		      unsigned int dword11, void *buffer, size_t buflen,
 		      u32 *result);
-- 
2.29.0



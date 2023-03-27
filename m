Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A61FDC76195
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Mar 2023 06:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Hf4KkrVHOfssDm4LI21a1W0JkjPqkE7uy3angLyx4e4=; b=oSIKUWtkXjReuGd2edh3LoJJIm
	cj2d4X5g1PWQ3IdC/TyMWuGHr9YRT6vY6aMzRcIgyUyIOgt1fVbVaTTUnZd9K2qqvgbip2b9pU9aq
	uDqVueCH0jK0Mse/SDARnWvqocQF3NU6EZU5fFmFMOwb5Kmyv7CC24XUsmiCoX/sy3/XQbdC7zFb2
	6hav24ABOeZSzc8wjuA3vzj2K+F2Zox+1Ds4CyFRcaHLKNx1M/xFbYX7bFNj+Vvk4AFeDEcogcHgy
	GgdPF3mtHxPz4whk4S+YmeH1ibGmvAWQWH/IjAoiD7Z42gkA5gvp9tOEestqWpYk+84HxN1JiZVJg
	MMpvRAEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pgfzy-009ua1-1w;
	Mon, 27 Mar 2023 06:06:30 +0000
Received: from mail-dm6nam11on20626.outbound.protection.outlook.com ([2a01:111:f400:7eaa::626] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pgfzu-009uWN-1F
	for linux-nvme@lists.infradead.org;
	Mon, 27 Mar 2023 06:06:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZhCKB1rrZEO3sI7t4NKhrSflJvbtbIcIu7rr+kATCvK47uuvwg6T62LB2sBJNduwZeRImymiSMNhXy8isSPEAhqQyV67pcoid3eucGkEmNzjRuHK8HXF0faC9VuXPh2hC9/nWE5wV8OAR9eUsJCQ/6WijnYSuZXQyjB8o2Ik/H3R+XUqDO0kBZyR0c/eUe4/dspMxWVn2I6/yT/bCZE0Dbk8I++5z4W8MMXxgBsW/cIGx/d6a2aYo1yZGGVZhf14tpoUWwBNR2U5BAYanz7cgYecYi0DWyYfuerNLPRuCX2G4EfDluQfKD8V1G9p2fGZMjHtz6xtyKK4ZM9OePGMxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hf4KkrVHOfssDm4LI21a1W0JkjPqkE7uy3angLyx4e4=;
 b=UuLNiz8v05L+dUPlI6KZmJqsRl3leMW1yua2IGodCKTLt50JOZh1BBkWCt2HTzmup2W4e/M0I7KJUNuH8h9X3yozYtCXhmfuls/ubIVjbiV/BrcSwGh/0hF4JpgHUnL16WneSnj3SYA+2suqAUWaMYKLrCbe3ZjCJ25Fa+/862BQpt2XcgQPLT11svxQd5fI2Dl/ZXV5NJGsEfMGsHBf3tfVRuahm0fnXRVzpD89EgL+me8W+7xBYdM6qThqOkytzseaqRGwc7rhfxf2de0BOfBvzA2R0BYcIzMjxVyZqLzfRvNAUNIpfFcrDt8b8AMBGCZeEMuPTNZRQKwYyWQ+Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hf4KkrVHOfssDm4LI21a1W0JkjPqkE7uy3angLyx4e4=;
 b=c7xPOkG8+GuEYCz14un9qPX2NO+sT51lazhDamQFWuOAQZhpQUXMpl1j+sVCLjOK3PWT0NTe/3QwF1Rj5enVVg+/tXfK3lKRAKqmRfnVJuE8/Jq846EwVOn3Z4CW3SAciWmKMYKOJDW+W08UEcgYPEZhCn/ZbIKiPKW9Wsow5tapdlnGlz61LHHZmy4RQ7/foAJlKmdnLsy5b40KdSqvY8tlQFOUGpHJS08aMO1PefQgUFhpp/yZn2EGPVJv1UrvnYwDpPf6rBbB/xFpbh/yGlvK1N6Z+q+ft40dJ6Ru3TpwsMTRr5LduFEQ1Z2mAPrTVWbBE/abt3RKrwOz7fl55g==
Received: from BL0PR02CA0097.namprd02.prod.outlook.com (2603:10b6:208:51::38)
 by CY5PR12MB6131.namprd12.prod.outlook.com (2603:10b6:930:25::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Mon, 27 Mar
 2023 06:06:22 +0000
Received: from BL02EPF0000C406.namprd05.prod.outlook.com
 (2603:10b6:208:51:cafe::56) by BL0PR02CA0097.outlook.office365.com
 (2603:10b6:208:51::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41 via Frontend
 Transport; Mon, 27 Mar 2023 06:06:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0000C406.mail.protection.outlook.com (10.167.241.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.30 via Frontend Transport; Mon, 27 Mar 2023 06:06:21 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Sun, 26 Mar 2023
 23:06:05 -0700
Received: from dev.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Sun, 26 Mar
 2023 23:06:04 -0700
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>, <hare@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH V2 8/8] nvme-core: fix nvme_submit_sync_cmd() args
Date: Sun, 26 Mar 2023 23:04:18 -0700
Message-ID: <20230327060418.86655-9-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20230327060418.86655-1-kch@nvidia.com>
References: <20230327060418.86655-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000C406:EE_|CY5PR12MB6131:EE_
X-MS-Office365-Filtering-Correlation-Id: b4c0ccbc-eb9b-4b88-55e9-08db2e896358
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	1kCA+0H1xRshBZlnC+qc9b4IMjl2p5sZd17IXQCXj5L7y7L5HQX8uqA+naxi/au/lEnox5A3j2Ciz5vaBrsh9YBQrr4CSQLSeN4vfIE++b09jNsTCUb+FzU0OAyItSuYxKJJuSGp32y/bu9K7Ho/1LyH4Lcdl0Xn9C/ydLyEXo/5Lcl6ti+m5cTplEqHXVThHP2bqkG8AJq1FyKLupoJhZm3f5fDOCH5CFTLPcRFJgReBligqSx8E1SFeYf8HBJrtZUFZKH4qbU9sVY6bvkk86wsQTKLqq8MBmdgWjYlaFq2deW3V0Jfb5eJs6E/ggfBeHY9ZuTBc2x0WxEem8EU99NWR9JPKtBRjZOoQDpvVf4j3jSoy3sOuoUiDU35y8r0XLi7A8O3QacoFklD4Gy1JezdS+Wdg2sPkar2vTs/ROgQ4pO2oU1q75MpjgZ6kV/D2zUbwxlnuVwRHloug+bdfVAeAkR39FADd3XqURksRnsChUzfHAna1Xh/TAZma2OYEEt6gYxmwyNVgI0RVcUD3bLrnd/9ut1uMzwpL8zxvBTeYMBdJ3MU81+qcZGsVBgXC+JM8wpsoLtlLhV2QMh0rRJyNaMQaL+chBgfGFFg8yh6QM7DCUbvZ+QZdIjojuX1JSfGMHQLeK5pJ0DrJRcEsBnnqfKqwcNtoNIWT/OEw9GWschIHwKtbGK9mJdbqY1Grp4vdq2P+Nx9BKK+syKqMMwKHa+rvDhAUKzA1MP/V/YNN5GWipGmgI9z/YwG14qv
X-Forefront-Antispam-Report: 	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(396003)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(54906003)(7696005)(478600001)(6666004)(107886003)(40480700001)(1076003)(26005)(316002)(8676002)(16526019)(70586007)(70206006)(4326008)(6916009)(41300700001)(40460700003)(2616005)(7636003)(82740400003)(8936002)(186003)(336012)(36860700001)(5660300002)(30864003)(36756003)(83380400001)(2906002)(82310400005)(356005)(426003)(47076005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 06:06:21.3156
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4c0ccbc-eb9b-4b88-55e9-08db2e896358
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: 	BL02EPF0000C406.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6131
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230326_230626_489992_E7075686 
X-CRM114-Status: GOOD (  18.34  )
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
nvme_submit_cmd_args and move all the existing arguments into this
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
index ea16a0aba679..a18c0c7ce0b7 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -64,6 +64,15 @@ static int nvme_auth_submit(struct nvme_ctrl *ctrl, int qid,
 	struct nvme_command cmd = {};
 	blk_mq_req_flags_t flags = nvme_auth_flags_from_qid(qid);
 	struct request_queue *q = nvme_auth_queue_from_qid(ctrl, qid);
+	struct nvme_submit_cmd_args d = {
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
index fda851e8b7c6..105c5655410f 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1025,32 +1025,30 @@ EXPORT_SYMBOL_NS_GPL(nvme_execute_rq, NVME_TARGET_PASSTHRU);
  * Returns 0 on success.  If the result is negative, it's a Linux error code;
  * if the result is positive, it's an NVM Express status code
  */
-int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
-		union nvme_result *result, void *buffer, unsigned bufflen,
-		int qid, int at_head, blk_mq_req_flags_t flags)
+int __nvme_submit_sync_cmd(struct nvme_submit_cmd_args *d)
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
+	struct nvme_submit_cmd_args d = {
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
+	struct nvme_submit_cmd_args d = {
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
+	struct nvme_submit_cmd_args d = {
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
index bbaa04a0c502..4036da49a18d 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -146,14 +146,21 @@ int nvmf_reg_read32(struct nvme_ctrl *ctrl, u32 off, u32 *val)
 {
 	struct nvme_command cmd = { };
 	union nvme_result res;
+	struct nvme_submit_cmd_args d = {
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
+	struct nvme_submit_cmd_args d = {
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
+	struct nvme_submit_cmd_args d = {
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
+	struct nvme_submit_cmd_args d = {
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
+	struct nvme_submit_cmd_args d = {
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
index bf46f122e9e1..0b0b6e0468aa 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -811,12 +811,20 @@ static inline bool nvme_is_unique_nsid(struct nvme_ctrl *ctrl,
 		(ctrl->ctratt & NVME_CTRL_CTRATT_NVM_SETS);
 }
 
+struct nvme_submit_cmd_args {
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
+int __nvme_submit_sync_cmd(struct nvme_submit_cmd_args *d);
 int nvme_set_features(struct nvme_ctrl *dev, unsigned int fid,
 		      unsigned int dword11, void *buffer, size_t buflen,
 		      u32 *result);
-- 
2.29.0



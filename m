Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C4A2C6FD1F
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Mar 2023 03:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5yV/k+wsMpzambZBRxNxx7o4mghV3hp571mxlRQ3iJM=; b=x5dan6Qwi1TCMD8WlrvyZZAkxq
	KOFZxGUhjq6QGV7aKtjLTgxY8+GK8GDqec3ERu/k+rWYuQ86wa3YzerS6VAuMLHUfYfbx+S4DwgGK
	lOdV9ttBpyItnOCExH/xCQNtb0nJhZCuqMB2RBw+r8tVsYuWFNvtZckc1zXfBhSXwAF/0RKC7GrMM
	77fTErIjoEh3COesr+0ehD2yfYTkElJYU7w1BXm1/09LXJ2QpDHfYCq8lagKJ+d8t3DC1f8HPWHdx
	vUCBEXikh5rAikW/MD3jV81byUfKjprKiGHw3Ek56WHIADHSlwR2s5B59ld0yaWwF3CrNC/Xafi7c
	j6XZpwSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pfBlx-000e72-1C;
	Thu, 23 Mar 2023 03:37:53 +0000
Received: from mail-dm6nam04on20621.outbound.protection.outlook.com ([2a01:111:f400:7e8b::621] helo=NAM04-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pfBlt-000e4Q-0R
	for linux-nvme@lists.infradead.org;
	Thu, 23 Mar 2023 03:37:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MLDml+kTYBbWPkW5xCQA6xvM2xtLQQQPTXNRztqxHqK+9j5CQToBzweOZ7oBLQFXVueTcwtfydU7uGBYZOw4lC+PrKd+d1mmAPhXpC4cDb4lFnaWO5jcKucNL6wW8kKf1uVlQfCUOe/hKkck6Tf57sJg+LCyGGkGGeeapjD40yrw1z2916WaCosOcD3Xy9vgHi7k7Py8NwLC7D5wggjXHbom2f+rzC4xzsTkb+i2dPelE/NovY/YhAxuwDWflcglEAitC2O1MTxmGlgj+fNt8gcZ4zJ/b8q1OvlGjt8CzgtN2GqnmKcJH3oFkQmbi+S8UC6y0RseG0V5k4SEewxiuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5yV/k+wsMpzambZBRxNxx7o4mghV3hp571mxlRQ3iJM=;
 b=Mll6FJdEwlbS390D/lrDF+fZsEQoW7e6AiMt+JEiVRIPr8AQmrKYnI67Yez7dLEz7SrQAQHM6Dku0CW5LowE2t8CFFpKEHIw1tdog2d/KaTiRd31nevshKiSSKZAyrd2FW7/G4ROAt/FqJrnNhJrCFm/vUGT6WSq2dyfhBxOEcJyf0GlT0pgvSHzCM5n5p0XCMw4LfXW0VHfZq4EwETK75bqAKr1G+BYktivYaoXCWGkU8al62R1JnKuV0hR9QcB1a/eGeknAC16DIQ9s2PpDIuiCUm0HzMxVDyCKfFQaNtfSCgOaaLPCHEcTX/LJRUNyuqYiDEaLcdFVsdgu0sXZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5yV/k+wsMpzambZBRxNxx7o4mghV3hp571mxlRQ3iJM=;
 b=Sa8gP01COgrEBK1KXZjgQsRTGDisEvgMkc/dQ7l5gomUH1MoLhe3woyIRxTxg4yxMOIKOGBhVStKw7Wm3wRIiHqwSFdhkIn4JcxRTt0XnR4s7FFSHzTYVCkkwRuVRyYUU3zXxIZtn/KhAv27cYi387vK/oP9QQQfOsGES7ibsjEpbOZ1fGRj6cCLz8MdMk3Foek9n6rFsOaHq7mSGgL2Nu4Di1Qmtbp6mgX4xNqG+CJvn7jx04WkTGTO8L8iyO48iq7nxx2hy0NQabQbVZXp4SM4EZchx4ToJF3pd/w3ByWxnmEc/9+v7ZcQM3M8znU9VuExFiBnr81knLsIBkxFgA==
Received: from BN9PR03CA0174.namprd03.prod.outlook.com (2603:10b6:408:f4::29)
 by PH7PR12MB7842.namprd12.prod.outlook.com (2603:10b6:510:27a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Thu, 23 Mar
 2023 03:37:43 +0000
Received: from BN8NAM11FT075.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f4:cafe::a2) by BN9PR03CA0174.outlook.office365.com
 (2603:10b6:408:f4::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37 via Frontend
 Transport; Thu, 23 Mar 2023 03:37:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT075.mail.protection.outlook.com (10.13.176.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.17 via Frontend Transport; Thu, 23 Mar 2023 03:37:42 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 22 Mar 2023
 20:37:28 -0700
Received: from zion.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 22 Mar
 2023 20:37:27 -0700
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>, <hare@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 4/9] nvme-core: code cleanup for __nvme_check_ready()
Date: Wed, 22 Mar 2023 20:36:31 -0700
Message-ID: <20230323033636.812758-5-kch@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230323033636.812758-1-kch@nvidia.com>
References: <20230323033636.812758-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT075:EE_|PH7PR12MB7842:EE_
X-MS-Office365-Filtering-Correlation-Id: 46fd6be4-1cca-4124-8c2b-08db2b4ff5d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	O6KWoLGl07liZdAPuADSwyJKiQHPAKxm1NY4hddvhjhjSp6ryhLfo4qVvw30DGEvhss5sur1eGe4nyAR6vcmwy9C05hGmc6akGOJdh1qW+pB491vup/d32Et3cwjoPstyveMUhLA2N7ptb8qDSFyz94l4P/oaHkKGUxwK3sb8t4Bw92DA9GpbwN5ks9SdlBkLTUl1ShWgP1IY8YH8d0m+OveN7J1VAY6Up/r31CDAfSF2ikYLBF7dBFBgnzr6IG8vhwjH9nbamtJjGTXX8HNybPcP8wpAPzbQ801cvDRgyE6D8t0nDQTVJPc8EdiC7kxppaq0tN58F2uRl6t+z7bOQ9UR9j+tq5DeucbE+Z4ozfTIZufBsrJbnQmwa/6R834732eqYwtsTD7siRSObRxzdIHXIWnG8U+FHzY5D5baNRuaglf3/K2rleuzn7e3LHqjVudlxUX/GP9m5cRwbvqwhlES0l+E2JGMM5Gc1rmxNnCWjz7EEz5Op3Hcc6uvc1Mz0fzMssSbL1dxx5gTkyob66YjG3KfWiIn0/oVUFWYjfpvoLJlfeYs4nGWHlZzJeC0IrFAb5ThVHhThXTDhWe0Pfcq2Gvg52BQNJ/qKz+SrTYvarzLHBIrDlv64zQdx5Py1cQ5Z00my4pb0LeZgXyENmBd7LaNY5U2JgiNd/u3t5rC4fDJAidIu4+daJfR0djXtgmNQpSKto3JSIk5DhmsFQMNAeh2OnUS9Na841PDNJgKbnH5nmSgnuoYR1JaNYD
X-Forefront-Antispam-Report: 	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(346002)(396003)(376002)(39860400002)(136003)(451199018)(40470700004)(46966006)(36840700001)(41300700001)(4326008)(36756003)(8676002)(36860700001)(40480700001)(7636003)(2906002)(82740400003)(6916009)(70206006)(70586007)(8936002)(356005)(107886003)(2616005)(336012)(26005)(6666004)(1076003)(426003)(7696005)(47076005)(54906003)(82310400005)(186003)(5660300002)(40460700003)(83380400001)(16526019)(478600001)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 03:37:42.7587
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46fd6be4-1cca-4124-8c2b-08db2b4ff5d1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: 	BN8NAM11FT075.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7842
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230322_203749_176950_412E07D5 
X-CRM114-Status: GOOD (  16.54  )
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

We can avoid using nested indentation by returning early if the
controller is not fabrics. Additionally, instead of using comparisons,
we can use a switch statement to determine if the required command is
connect/auth_send/auth_recv. This will also help to reduce the length of
the lines in the code and makes code easy to read since we don't have to
verify three different comparisons. Lastly, fix the spelling of
"appropriate" in the second comment.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/host/core.c | 41 +++++++++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 17 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c2fb7a0eba3d..a380938f5a06 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -721,25 +721,32 @@ bool __nvme_check_ready(struct nvme_ctrl *ctrl, struct request *rq,
 	if (rq->q == ctrl->admin_q && (req->flags & NVME_REQ_USERCMD))
 		return false;
 
-	if (ctrl->ops->flags & NVME_F_FABRICS) {
-		/*
-		 * Only allow commands on a live queue, except for the connect
-		 * command, which is require to set the queue live in the
-		 * appropinquate states.
-		 */
-		switch (ctrl->state) {
-		case NVME_CTRL_CONNECTING:
-			if (blk_rq_is_passthrough(rq) && nvme_is_fabrics(req->cmd) &&
-			    (req->cmd->fabrics.fctype == nvme_fabrics_type_connect ||
-			     req->cmd->fabrics.fctype == nvme_fabrics_type_auth_send ||
-			     req->cmd->fabrics.fctype == nvme_fabrics_type_auth_receive))
+	if (!(ctrl->ops->flags & NVME_F_FABRICS))
+		return queue_live;
+
+	/*
+	 * Only allow commands on a live queue, except for connect/auth_send/
+	 * auth_recv commands which are require to set the queue live in the
+	 * appropriate states.
+	 */
+	switch (ctrl->state) {
+	case NVME_CTRL_CONNECTING:
+		if (blk_rq_is_passthrough(rq) &&
+		    nvme_is_fabrics(req->cmd)) {
+			switch (req->cmd->fabrics.fctype) {
+			case nvme_fabrics_type_connect:
+			case nvme_fabrics_type_auth_send:
+			case nvme_fabrics_type_auth_receive:
 				return true;
-			break;
-		default:
-			break;
-		case NVME_CTRL_DEAD:
-			return false;
+			default:
+				break;
+			}
 		}
+		break;
+	default:
+		break;
+	case NVME_CTRL_DEAD:
+		return false;
 	}
 
 	return queue_live;
-- 
2.29.0



Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EB30C48297
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Feb 2024 08:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=LoIFBXkX44idk0pcpwzUPQdEXg4Z6ngmfuyGJu9Xok8=; b=3EG1ZoR/NL/THJvHXJh+aVQfzC
	+jcZFQAl+u6mSAlHlZRb6bysrnZOXKDlJ6Pzi/4HSlWJrifgwEtmtu4vZwumnWjfojKrB+XM4NEJQ
	3vE52epIGl68zrUjtht8AobBD/julrJUS7k7OFkyyVfFaAySyl5G9osT7W31FQximumvlmfAEe9JM
	TMWuotohw4gCcEkHuvJXn8mq9M0Nt04EYNTOu3BK/3TaiWhIRF8yLZNfk3P+pduOX4//jMvde/I7Z
	imbMkTGm9Eof86SAmIAjRWeD7qNFD1+yrldA+68NcZ2oDQ1dVzBAPOW+mqjdJYgaQ6Pdw5/dN3+R6
	eDBHuE2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rYMQk-0000000GT8U-3zRO;
	Fri, 09 Feb 2024 08:40:18 +0000
Received: from mail-dm6nam12on20600.outbound.protection.outlook.com ([2a01:111:f403:2417::600] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rYMQh-0000000GT6v-3IPq
	for linux-nvme@lists.infradead.org;
	Fri, 09 Feb 2024 08:40:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m/FdfejK/gP+94gMoLRTIO25a4EQ3ImtmY0ZED4chvqx+l2elNLU+hgaTE6mPGFOMtCYAg3aZfLr5xgV1wly/Dm7U1oB2I4iUPabmye3UeIdYRC/Ah4O3k+Z//q6/JeFPvmh8RMa5udRWnYjBIroJjq6kbVubBrXixoMrZj1lZoXOnI5wpNor0LiR6HqaspVgVUN+WR3wZJMX0OdJLjQBO/XnrUO5vR1vFkX+8wJFSeEgI66h6ILvb+IFVk9dPhocGQPdydeds/cta8D1D9InbdvSJDCm8nFT2xG5xHDHEenRFk1zaES1dS2Cpriiqbcl44U9J1cvzgOkR8XE0E5IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LoIFBXkX44idk0pcpwzUPQdEXg4Z6ngmfuyGJu9Xok8=;
 b=NefkMCXBJx1kK1F6UVyJwf7LjiQqMn3FhLCjh/4a9+uvk6nXtfX1P1g+1KN9d046FEQqXZ89uEwBglu8P1liHeI1VNPinat4yaysuVapvyv1Qd3fiWV9BhYorBTL8dwLH6EZKEtbQASsYkFc9Q20qJsm9T7PUCB4vrwqBp5ucg40mTt70o5w7njAXrdKvImUPwf8fo0JQolNpUU7CYg1B8opQyq4whioVrjLXZ1sJaBQQ9ENcDBwaca6H7s8OOkzjN1RGlgKz0eLNZJTbJnU5GxK98g5TW/qjcfPUP9mT6mjGNceo6ko4E2pSwkqLMYQmD0MWc6ozHKCb1MAD7rLhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LoIFBXkX44idk0pcpwzUPQdEXg4Z6ngmfuyGJu9Xok8=;
 b=MZhor1kM6qEFrcN9glECuo1AWSQf+rfNKGIjR20ABDl8u/9kzBLTNggz+bzOVyphoNF/4kx1ZvD5OOOutFpO7ui1UBgdqasraYNzWWtIFkunZ4xQfQVv8W54kIRE6MpD/Si3sfxqGdAVBxEiJWkdd+LOagA5p7jhIQ99Ld5wrnZVfPYDfuXI7wkxOB5SGzvdSKtWHz3uPcUKP2IOi+zWoTCSNJ/i+kYlZZCwOcu/aX7b5k1iN17sMC/eorYFF/bWxHqfH7hAjDpd9KyFPf7MoWsHJK+Q/SbLG5gKl8bn4N0+izcBdReOiLvYCgUEGL7LH5WitaA3ZTC1K7yFgHXFRg==
Received: from BN8PR16CA0013.namprd16.prod.outlook.com (2603:10b6:408:4c::26)
 by DS7PR12MB6240.namprd12.prod.outlook.com (2603:10b6:8:94::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.13; Fri, 9 Feb
 2024 08:39:57 +0000
Received: from BN3PEPF0000B075.namprd04.prod.outlook.com
 (2603:10b6:408:4c:cafe::e6) by BN8PR16CA0013.outlook.office365.com
 (2603:10b6:408:4c::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.24 via Frontend
 Transport; Fri, 9 Feb 2024 08:39:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF0000B075.mail.protection.outlook.com (10.167.243.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.19 via Frontend Transport; Fri, 9 Feb 2024 08:39:56 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 9 Feb 2024
 00:39:43 -0800
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Fri, 9 Feb
 2024 00:39:43 -0800
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>, Chaitanya Kulkarni
	<kch@nvidia.com>
Subject: [PATCH] nvmet: remove ineffective initialization
Date: Fri, 9 Feb 2024 00:39:35 -0800
Message-ID: <20240209083935.5094-1-kch@nvidia.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B075:EE_|DS7PR12MB6240:EE_
X-MS-Office365-Filtering-Correlation-Id: 30775d4f-dca6-4ec6-cf97-08dc294ab202
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2XQVwdzzsKfWNsMAanss57VDwjLS6YRP438slwOMLRBhM9e6Y876uRTNCaEcZaliLiHViEkql9hkCi9Pay0Qa9IZpLOtt2ogHmNPipLv0ojDayUjxVXQutDTcqmSE2Fhwex2RVHiDiG4LOvIvUYqaYiQadQhcltRq0abd52E4VEo8kGpW4i4rSOuMBpd3tnEWE4ovFvKSJS1n0Q0Bq1yJTJwWI0i2WMgaOgeU7QmdBGPqjPi8BDSrMQzU8QowPIRqQI9udJ9vG3ITwuxwHC767z2y7zp5/uvtVqAb9/+BkfLTB5fLlCXmcLEhQTNHnS68sOs8+DZn3HZvm0LMw8hRaKkMElLslOOFq5AauZfQWEVFdv9nXmY3roKLBRiCChW6s8HsnE/nzM9GH4KYXFBHDXapSIuFDpJkD7uyatM+f/6p2DOkeLYlc3gBIrapBk/ElGUZAh9pF4jddBNsLH9BFGZw1IIrZufN2mxgvuhBXhreK3anfOsLVhRrGleJzbxWDhlsXgVobVT+5kWQZ0sWfHjcc8VTUidnRzP+JvVk338qczMmd1iQdjWqH5n/FJwi8KBR9sPmANv3NBgv5m16eHpiEWo0dx+PN/HE9IQYeg=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(39860400002)(136003)(376002)(230922051799003)(64100799003)(186009)(451199024)(82310400011)(1800799012)(36840700001)(46966006)(40470700004)(316002)(6916009)(70206006)(70586007)(54906003)(36756003)(4326008)(8936002)(8676002)(356005)(7636003)(82740400003)(26005)(83380400001)(426003)(107886003)(2616005)(1076003)(336012)(16526019)(478600001)(7696005)(6666004)(5660300002)(41300700001)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 08:39:56.8583
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30775d4f-dca6-4ec6-cf97-08dc294ab202
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B075.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6240
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240209_004015_931274_54C0663F 
X-CRM114-Status: UNSURE (   9.86  )
X-CRM114-Notice: Please train this message.
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

Remove ineffective initialization of status variable in
nvmet_execute_admin_connect() and nvmet_execute_io_connect(), since it
is overwritten by nvmet_copy_from_sgl() and it is not used before that
anywhere in respective functions.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/target/fabrics-cmd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/fabrics-cmd.c b/drivers/nvme/target/fabrics-cmd.c
index d8da840a1c0e..9964ffe347d2 100644
--- a/drivers/nvme/target/fabrics-cmd.c
+++ b/drivers/nvme/target/fabrics-cmd.c
@@ -209,7 +209,7 @@ static void nvmet_execute_admin_connect(struct nvmet_req *req)
 	struct nvmf_connect_command *c = &req->cmd->connect;
 	struct nvmf_connect_data *d;
 	struct nvmet_ctrl *ctrl = NULL;
-	u16 status = 0;
+	u16 status;
 	int ret;
 
 	if (!nvmet_check_transfer_len(req, sizeof(struct nvmf_connect_data)))
@@ -290,7 +290,7 @@ static void nvmet_execute_io_connect(struct nvmet_req *req)
 	struct nvmf_connect_data *d;
 	struct nvmet_ctrl *ctrl;
 	u16 qid = le16_to_cpu(c->qid);
-	u16 status = 0;
+	u16 status;
 
 	if (!nvmet_check_transfer_len(req, sizeof(struct nvmf_connect_data)))
 		return;
-- 
2.40.0



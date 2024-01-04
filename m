Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 025E3C47074
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Jan 2024 09:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XQNNLOqNIMMp3/aHm/mW7jo8XwYUHlKnBcNCTjsmvsw=; b=IOIIyQrmrk/vIq5FCN1oM1BmiG
	oPKJ0ClF/HOg+hTTzjSEEzSNJ1rAryk1+XyOcH1oqEky8F8ELMHA4JkGMo8MFurWxitsLjHLSSyjM
	YXTxEpF8HZcuA/JSk9/0/vGvZp0z2GD1bIyHGU1l/KTJAfeKKIaM8g1HAFvWkSxgMHIDoYiCHav7D
	mT8J6LZAJmqOhzL4T6VN7/TqubqQdTnPyx8kEnkZvmc59n4ew4Ba+CeRM1kReBzsmrUAofrEBR4Hj
	tRs8ZzJZ2Um8qxGBhE9Q+z0UP5zow/PmN+xz90QqXHGYtzPqIvdc9vEh5i2ZMOOEBLMnS8AXjI+Fa
	YZNH6Vaw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rLJzV-00DMLU-2Q;
	Thu, 04 Jan 2024 09:26:17 +0000
Received: from mail-mw2nam12on20630.outbound.protection.outlook.com ([2a01:111:f400:fe5a::630] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rLJzS-00DMKB-2S
	for linux-nvme@lists.infradead.org;
	Thu, 04 Jan 2024 09:26:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D6rhh53N6qnnCXOYffFc5EAvzTNQ/PEnEQtE3RWFF3jvmRZUOuSUNIBVfmSRFJASqJyzwKBliwFyvkldWa09mD7mg0Uh0ZG9huZOHZGzVcJxmTdcfRM+GYjtZ/m5c6n71wtlJqM+D1ETSdiBDiFuRNvlL4voyhUbrHo/u0l6E23fuwBW0X3rNbail7i3BX+m3XKV601Mr72P6pTT1wRHpKNoZC4Wm1kbe6Xv4xyo67uaMQgit37UC5KQ/vMg+8Cw3PSLWoQ9omTwinKcGfn5X4FpulLqeNL8f5e4nY393bYAr+RBNO8ocDYN7va7tkomUgJDzFpzUhud8HA7kfFvhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XQNNLOqNIMMp3/aHm/mW7jo8XwYUHlKnBcNCTjsmvsw=;
 b=M0CZSAB+FFrAGxBN4grGzmz3iZuaci3MygwY2zTPV0X/nMzif3op7rG/RpYpce+9/bNIElpwg51F43JTRxqgPTuv9ufgwjshb0O39IVkzH1llTh4dK179rakaM5akDL7saDSuwrK6Fgsw+moYmFEKwveQRWWGHWxd1jG9wUBpWOeENJXRC380flehLZk8fsz04aQQbCS6WQp5s6e7HExCyn7G3DiYD8e7wUqeLiY7CazSWjb4pHdDG9fdDTC/z0D4582h40E5CbsT4uZCGT8RhMEndFJCKAHZCuQitcUj1stIAfY5eEVX5IGm+FsTqrNPx8LEtdD6tmZ9PeA8bpSdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XQNNLOqNIMMp3/aHm/mW7jo8XwYUHlKnBcNCTjsmvsw=;
 b=MnBHTwAfvmI4OBEPw2I9iFxNpiE93vpDkhVlxduX7+535jcqbml4r/QRncWqQUYXNJ0griLDZwGaJQ6+QJs/w96Oh/B7OX3Bzv08/b2qJCzAP8Pn75EhGTlDWg2Q/bhdNMVZgfuDQOWgAtSizj2jSrshLyVx6e4+UADElV7IVy5eGmdCtifJ2/F1iAKcRdT7KVNh0jtj28qRpjfyEr+mq7ZN+K7zmDYsPW1fgP7rAAasyFWORqvQIAG3hHFWI9SyojNMNNN7OMAsoGgcU3ZDIzVqhSJrPORJFG/9z18UBhJ7vMJy1Csox67o4dVVWjmtODlVsaG3a2C4P4CP4Rp/WA==
Received: from MN2PR05CA0029.namprd05.prod.outlook.com (2603:10b6:208:c0::42)
 by DM4PR12MB5358.namprd12.prod.outlook.com (2603:10b6:5:39c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.16; Thu, 4 Jan
 2024 09:26:09 +0000
Received: from BL6PEPF0001AB53.namprd02.prod.outlook.com
 (2603:10b6:208:c0:cafe::f3) by MN2PR05CA0029.outlook.office365.com
 (2603:10b6:208:c0::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.8 via Frontend
 Transport; Thu, 4 Jan 2024 09:26:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL6PEPF0001AB53.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7159.9 via Frontend Transport; Thu, 4 Jan 2024 09:26:09 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 4 Jan 2024
 01:25:57 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Thu, 4 Jan 2024 01:25:56 -0800
Received: from r-arch-stor03.mtr.labs.mlnx (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Thu, 4 Jan 2024 01:25:54 -0800
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>,
	<linux-nvme@lists.infradead.org>
CC: <israelr@nvidia.com>, <kch@nvidia.com>, <oren@nvidia.com>, Max Gurtovoy
	<mgurtovoy@nvidia.com>
Subject: [PATCH 2/8] nvmet: compare mqes and sqsize only for IO SQ
Date: Thu, 4 Jan 2024 11:25:43 +0200
Message-ID: <20240104092549.25721-3-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20240104092549.25721-1-mgurtovoy@nvidia.com>
References: <20240104092549.25721-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB53:EE_|DM4PR12MB5358:EE_
X-MS-Office365-Filtering-Correlation-Id: 14a59948-f099-44ae-823d-08dc0d072fa7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xUx+7kr6aqRSdOSz/Tnh7De2hUyxToy+XXjZyWozgdifVRh2Vxz1kkDXkEVBuprhHQp3QVa6T2AT4WJ6jsXfz0kU0hiSymwRRFyDoJuYaEggIYyP/Ceji/qC8qtJeUR8Bi45xJT3SOaUm/MMWw69P0zNpcEIVcBZvVN+szOdgTNRibXJ9qsLwT3KaqxgHwcqcQexNw1ktVQ0VVBg6jSfO1SV5g5A/0+AS+TjLPg+Y3qfQJC5CQMGh6DxHkju6B4DVL5Rkq/2c8RxOxMKKihVah1M7vkpJZ7ip1bHMDIz05glpk8gc8F6hStnYRhALSiTrQn+E03ux+gHghMlOBGs0KmXDu23RXouH/atuqDgZ/vUnmnLEw0BESy9uOPB8FvTWyGhSKXj0k6GRfu16cCgj4ROWSaSV5dGtCSFTPC4WGyVQI/swwn01AQWiVfEyGPtQqNHdk6pPleLw8YusWyAwq0uYB5tApabMZff5Jdd6qyiCyZcDEGXT1sn1PLnAi8loH8LuQk0cyUfyskj3GBuoIGIrT02hUDUuyHwTJbWoo9MtRNudFfI6tkvsguWk6/U6apYp7ZlkZEBhJIz63SdqkGeExn8K0Ei9CHt8cfJnVnRKS+EZ8BEwjZpLecPqF7hwfowpZVSltx6OiVHRu5gqtAUqTB2pQkCHFTLtYS9Ab6OgpGBvRdLRz2z28b+HHq1wkTIz+LOJDoREWBMxwahr0BJV3JU+A1Q29XsECZbgUUph0ZXMyDcMvhhYLXaQV68
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(136003)(376002)(346002)(230922051799003)(1800799012)(82310400011)(64100799003)(186009)(451199024)(46966006)(40470700004)(36840700001)(2906002)(356005)(5660300002)(7636003)(4326008)(8676002)(8936002)(316002)(336012)(426003)(107886003)(1076003)(2616005)(83380400001)(36860700001)(26005)(40460700003)(40480700001)(36756003)(82740400003)(86362001)(41300700001)(70586007)(6666004)(110136005)(478600001)(70206006)(47076005)(54906003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 09:26:09.3331
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14a59948-f099-44ae-823d-08dc0d072fa7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB53.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5358
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240104_012614_806876_08113D76 
X-CRM114-Status: GOOD (  11.86  )
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

According to the NVMe Spec:
"
MQES: This field indicates the maximum individual queue size that the
controller supports. For NVMe over PCIe implementations, this value
applies to the I/O Submission Queues and I/O Completion Queues that the
host creates. For NVMe over Fabrics implementations, this value applies
to only the I/O Submission Queues that the host creates.
"

Align the target code to compare mqes and sqsize as mentioned in the
NVMe Spec.

Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/nvme/target/fabrics-cmd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/fabrics-cmd.c b/drivers/nvme/target/fabrics-cmd.c
index d8da840a1c0e..4d014c5d0b6a 100644
--- a/drivers/nvme/target/fabrics-cmd.c
+++ b/drivers/nvme/target/fabrics-cmd.c
@@ -157,7 +157,8 @@ static u16 nvmet_install_queue(struct nvmet_ctrl *ctrl, struct nvmet_req *req)
 		return NVME_SC_CMD_SEQ_ERROR | NVME_SC_DNR;
 	}
 
-	if (sqsize > mqes) {
+	/* for fabrics, this value applies to only the I/O Submission Queues */
+	if (qid && sqsize > mqes) {
 		pr_warn("sqsize %u is larger than MQES supported %u cntlid %d\n",
 				sqsize, mqes, ctrl->cntlid);
 		req->error_loc = offsetof(struct nvmf_connect_command, sqsize);
-- 
2.18.1



Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC7D4C433F5
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Apr 2022 02:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AK/RbU1wu/slwjDXqYfMeL2kb0/SWp336c0aVBMqIPc=; b=X9VjDK/2lMCvXECEeaOHkwalGP
	wlvyTESHA0YLnpFr9LoK5v7m0t2fUxOmCqVMz9Rw33y7FzOB2SjMZN9RT9gynx9X/LzXNgchxzc0O
	hdUnySfnfWUjSM7jQ7aKaocGcYrIMFWeueO8XXXWtG8b2X9CY6z4Xn4PFEw9ePHDGtqcLLYhW063q
	z7VEDDQTXkBOB1kWScaQgzGpE/aBDTPDfkIQO3MBeAfmuKgd/XhgAlOpQhFjtlo7o36OkEEwlc82C
	MvLvwgN0xfGPhYetgxyYdYieKQ8B45ddN0XqtdNoXuXIW4rJ0kHXhmo6gg12VRIknIS5fzG6pBC1J
	GU2SrlDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ncen3-00Ei08-QS; Fri, 08 Apr 2022 02:56:01 +0000
Received: from mail-dm6nam12on20628.outbound.protection.outlook.com
 ([2a01:111:f400:fe59::628]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ncen1-00Ehyu-4w
 for linux-nvme@lists.infradead.org; Fri, 08 Apr 2022 02:56:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g9cDtx9PizzQpEo1nL3N8ODMu1B2sa23AEbdXmVrngrK+BxDO4KBzNQEAUmFejLomNniibBn1L/GBBDhK/Ew20Ib/mGN0gdETLaflOHbye3KwlMOSQ4U6p8mBEUAgZH7Es4zQNj1cXD7EYqdm+DYv5pgagSAmEvc4fTYV7QHauZgwpny4z3WJH6fNDU8HsaP6soY9TIjiGSXPp4AKD5iEIh/MeuB/EXVE8VkqiQYSlNv1siOEfu5NF8pjM/6PNa2RDO97cuIRPh1R8AzuM0EPuoFuAQO98t3WGZUviS9+JiD4ZXsAcCUg5yh3TJQu/JhQk/S48ZFHiFbB7HQy6VRuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AK/RbU1wu/slwjDXqYfMeL2kb0/SWp336c0aVBMqIPc=;
 b=cNyUkM5jnbFEtp9bH56QcNIky1ISsKminJBfY2dOQTOTju/H9fBLuVye/UUeiyQCKFD+93GJDSH02vIpZlLvkarQox0rLKsO1QbE1ekOXuWlNwqpdFm1PTyN26afWli8J5Ib9qUQ2cHtYWozhrWsHtEeVZeZSUvaBEwE1G/1L+68WHblan98pr00ydLTZuQ2A5XplYPDrTomLYn2FHN0kGATI6Uj2s7zIELkg9wFCYhkDw2S6M+37Kiqiz5NI7LOCk92nREoYgGJ0YBinvL1oHbmjGJ8REeM0YUsWZAmyLlmhtT8L3KREzzyv7rtmO/IMk90tjSJlxrlPyVRQc8ATw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AK/RbU1wu/slwjDXqYfMeL2kb0/SWp336c0aVBMqIPc=;
 b=EOkoW8TVGniRYjuKTgavEYVjwTCt6TE9q5NEJ7Mvl25A7f0BXTBeEGj55NfW0ILwRFMn0EBXinkYEXsT4K/V6NuE+WY5ZT7iorGUl4Dyv1VQD8/PqYKj4RVvI9eELmq54tMTIEDQnFMblShG1J/fkhfEj3dHbFMa+m0iDpC9zOAieSIibginiGY9rExtJ8yftUWa7oGPb8/W6Q81Ym44pABuhEG7BJH0KR48PRNtE0vQTiC7PYkBTaMxltcj0Bzmf66T/oI6RE75vEHlf89VQdFkNcXaTPCOzVmdOGLTaKGGkqvuXaTeKAcQBo35zD+neWqrqaMyPr88J2g5ISwIjQ==
Received: from DS7PR03CA0346.namprd03.prod.outlook.com (2603:10b6:8:55::9) by
 DM6PR12MB4880.namprd12.prod.outlook.com (2603:10b6:5:1bc::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5144.22; Fri, 8 Apr 2022 02:40:03 +0000
Received: from DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:55:cafe::3d) by DS7PR03CA0346.outlook.office365.com
 (2603:10b6:8:55::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.22 via Frontend
 Transport; Fri, 8 Apr 2022 02:40:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 DM6NAM11FT018.mail.protection.outlook.com (10.13.172.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5144.20 via Frontend Transport; Fri, 8 Apr 2022 02:40:03 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.32;
 Fri, 8 Apr 2022 02:40:02 +0000
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 7 Apr 2022
 19:40:01 -0700
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 2/2] nvmet: handle disc default command set identifier
Date: Thu, 7 Apr 2022 19:39:30 -0700
Message-ID: <20220408023930.85774-3-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220408023930.85774-1-kch@nvidia.com>
References: <20220408023930.85774-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2f83c976-4eda-4ee6-6b84-08da190915c7
X-MS-TrafficTypeDiagnostic: DM6PR12MB4880:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB488031F9A7A9EA6B4BBCBA90A3E99@DM6PR12MB4880.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: evQ+73wkEbT6cgmI1R5SWLhnrwjH8ZGIz7DeKEq3KJehYiuwWJhh4WMCSpGVgHiK74xu/iRHTLJi+l8cmzNgWKguAUMnPAYckRwgSYyIUlGmCjfvis2N8QPgyy9JPEtkpZHyFRjVdtQJlgqYk293rFGwWGl9FPsrWn34acOn270ROYUVXm4X7ZIKDa672KKsjzqHk4FGg5uPdkVSMj7Jx76YJTuWeqkI3fqw+J0uQvaPD62yy/smtoKZFdntkdS2iFMZXlCg9RVbtRp1v1BYtcW5FnZGNTTCG3jyf5kIRsLBlYT7Ki+dzattHatnzkkc2i5wEO14X4jSPpmY+Vps/I474r+Nd8KjRXVCw9badoOM+vOn0OLoXmKaH4U+203dChaYHVGX/P6HuLs08chaPHIrFMhr7nsYsDj6kvMKBJnDmnnHKsPJudHmQpTa0fafIx9JLxchzKORV5joF8leQn6JE7u+NTtIh2jEAIzwVOkb87FvY8ETCk46pcbFsPlppGNeLYAAFvZbDF8Tw/X7OlaoCzMwE8d+wUMRRcSn2hjt/ML0f/6ACLBT7F4I3seaNaqr0vO5q0f9f6TjEAk/pMj44RLQpDaKOtLzS4MvOMEtEtMLOkwmusfZgLIO+4jdIejN/0+fPfIRvoDhC4AnAVeTaV8oLDtHXSIJVXAQ6f9ac9gTZkJ56/19eKbnN2CP7UsP0Py19t3lEHhvz1tMyw==
X-Forefront-Antispam-Report: CIP:12.22.5.236; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:mail.nvidia.com; PTR:InfoNoRecords; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(6666004)(6916009)(5660300002)(54906003)(40460700003)(7696005)(2906002)(82310400005)(508600001)(81166007)(356005)(8936002)(4744005)(83380400001)(107886003)(26005)(1076003)(2616005)(316002)(36756003)(16526019)(186003)(8676002)(4326008)(70206006)(70586007)(336012)(426003)(47076005)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2022 02:40:03.5731 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f83c976-4eda-4ee6-6b84-08da190915c7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[12.22.5.236];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4880
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220407_195559_217700_9D03D547 
X-CRM114-Status: UNSURE (   9.71  )
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

Similar to previous patch handle identify command cns value
NVME_ID_CNS_CS_CTRL when executing nvme_admin_identify for discovery
controller.

This is needed to mask out the errors reported by the blktest nvme/002.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/target/discovery.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/discovery.c b/drivers/nvme/target/discovery.c
index c2162eef8ce1..34c7ed055674 100644
--- a/drivers/nvme/target/discovery.c
+++ b/drivers/nvme/target/discovery.c
@@ -254,7 +254,11 @@ static void nvmet_execute_disc_identify(struct nvmet_req *req)
 	if (!nvmet_check_transfer_len(req, NVME_IDENTIFY_DATA_SIZE))
 		return;
 
-	if (req->cmd->identify.cns != NVME_ID_CNS_CTRL) {
+	switch (req->cmd->identify.cns) {
+	case NVME_ID_CNS_CTRL:
+	case NVME_ID_CNS_CS_CTRL:
+		break;
+	default:
 		req->error_loc = offsetof(struct nvme_identify, cns);
 		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
 		goto out;
-- 
2.29.0



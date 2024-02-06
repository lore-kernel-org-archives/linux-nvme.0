Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F978C48286
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Feb 2024 05:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=VrcVdgHURkueVtTcf7Ji8RdeMhmiSgqkviSCDiOUv3o=; b=K1WegQWjsFTaYk+wLY81isyppY
	s+MOHxe4DVKKa+A6BoK86bZ43jCet6Kl33Y12z9DJeWFk85We440RLXfu50owOWYoeJVYXJEar8vp
	QU91s4kLDDzyCWwLpxG0nBE9j9i6Y7cG4VBg1W7qNNCMzwS8hjtcVhUTrb6gJIu95QL4gf9sTxDTn
	4Z9Cp8sY/Y+cvOk4re+GI0DumesAX3S9zC7kSgdBZCJGBPc5BTnnBmiD7zHxlbXhR1qsD3hcqdNU+
	DgKclPTBPDnPaTPC6XASAr9fuErt1cxDrGAkYRal6j6BHxWU5ftWjTspcq0YNB+TNQeiXqDu1mpc3
	qxWx0ojA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXE7v-000000068Em-1Q0C;
	Tue, 06 Feb 2024 05:36:11 +0000
Received: from mail-dm6nam10on20612.outbound.protection.outlook.com ([2a01:111:f400:7e88::612] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXE7m-000000068Dj-30DV
	for linux-nvme@lists.infradead.org;
	Tue, 06 Feb 2024 05:36:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WOlOj0yyhBTsa3p142omMoSx7Rgbgms6JGGzuWgwH4XGdyeY9k695V4kcdqOmLBxMM++v65EVdAj668bPK7iC1QjxlUIv6fJ/P42PlskWhO2yjpRXbeDjyR8/aa5FWoolLoF9pfqPUoDPIy9NCZeg4idW9GqrS5UKdtPxo93xcUPRHErfJxlHxckeYjRAYZ7SSCDrSuNneG3Uh40DSutcigxGnwKDFTtSYOSiA8sBTvOBGY5wKTYTdAcSYonsUn6eXR8Ckh4lZ2U3MMaR7PVjJvN4lnDLat0wM2xfma0X7JJSOkUSpTcrddaYX28RNytRx1ydmv/Iy/VMC5RoK7IGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VrcVdgHURkueVtTcf7Ji8RdeMhmiSgqkviSCDiOUv3o=;
 b=i5o408Kev/UVMXAmBuOoPaDQcQDgTcuvukYR5vy8MlIKnFUE64meXHj6bjSVejPdDp1r1hMzBrH9XE3dBDa9osWvHUBRKzXNgAfeAhlO/DswQykmPLGZWTb/LKPAC89zrYtZxuG0xffehDFVTmJ9QqfvtvZ+rWO1Ez7fv/UzaeFrkBI4FVY5D/gTfylynY+Cffc7iW835KFdg7tGqkEQxWKJZfKFyylCR0jdhNAwp12yssUBlZ9fHHD48e84OGYx7phMZ7GvMpP8Y0LqKNLd6b3uS5VUdm7Tfsxpzi4FjQdFyMTFVQSug6fl8W1dmmeQjduhXw48+YDhJMgTrU9ejQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VrcVdgHURkueVtTcf7Ji8RdeMhmiSgqkviSCDiOUv3o=;
 b=nfe0blMAPshR+GuL3lMUFUqE2ROuXqJ8a7VdqcGdI0FmNVxqctwrw9s4+u3grudUcu/atbTz0KTuy1qA+hf1slBOAh2Hr+7W2WgcTzkiJry+UaFKCwpXji776tBek9S3v9oE5yTB4nZiIOkNfAdidZuIrk6oik8vWiO4XP/XYItIobFgEynWm9yiYROi35k2PgF6B6rj2Rajo1eM73O7jtlubxF9Fqxzqin9hwrLG5vVCTb0qNSCrKxetkWCW8Ld/wGwS/o3KxxI9fRg5+/eFDOOkOOMtsb5xcLxAPfGCcgapZ+zKcvlEmfhhcsGHfLx08GOSGQXnd2eiteH904Vxw==
Received: from MN2PR16CA0015.namprd16.prod.outlook.com (2603:10b6:208:134::28)
 by DM4PR12MB7765.namprd12.prod.outlook.com (2603:10b6:8:113::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.17; Tue, 6 Feb
 2024 05:35:52 +0000
Received: from BL02EPF0001A107.namprd05.prod.outlook.com
 (2603:10b6:208:134:cafe::45) by MN2PR16CA0015.outlook.office365.com
 (2603:10b6:208:134::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36 via Frontend
 Transport; Tue, 6 Feb 2024 05:35:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0001A107.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.16 via Frontend Transport; Tue, 6 Feb 2024 05:35:51 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 5 Feb 2024
 21:35:37 -0800
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Mon, 5 Feb
 2024 21:35:37 -0800
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <alan.adamson@oracle.com>, <kbusch@kernel.org>, <hch@lst.de>,
	<sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH V2] nvme-core: fix comment to reflect right functions
Date: Mon, 5 Feb 2024 21:35:30 -0800
Message-ID: <20240206053530.50831-1-kch@nvidia.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A107:EE_|DM4PR12MB7765:EE_
X-MS-Office365-Filtering-Correlation-Id: 60f3839f-506d-40a3-6de8-08dc26d57b68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /fjIrJi2x6P7dSFyN9FSqbLCrC50mrdqM3mRjW2Zqi4BC2WMkO10fkYwDeO+NwzjcLDyznExoorrrGnEPv1+/zFnmWnWWM3iGlR4LC3f4LJw0huT4ck61N0gRf4UR59ZIUzxnKOQVM6yGyMqDjPkWxJ6vxaJ6XjJobzKJwU2/IrL4Uk7bj94Mj5yRcHYQjkE/TRUA4j0NHxmWMGg1+SbjAh21KJKBuuZiTg6eHxIGmtnxNapl+Mzj+2z+FJYyVGzQuSHTe2+qWPGo7gOusa39CzHtQ67nPdf4PoKs7RrO9Neqj2pLBe8m8G595XphZkKgb2ThnZQrpHFoT1bS61+HTCoWQBGXVZ2zit19UpL5JlePhJmyS1FSzrAePnOrhItYr/93y9dVdctAbvMLwZuGJMXXKJQxZbyj6JgZST6wM8BDWs7mKpmNnKW5JziApGVoNyRqwwEynmP3qh27Ax9+XWjmMxExUdRfuPqiTe1NIe35iP758V3DiT9RoOgt2/bUHYsEpb/1MkQxpl5GwB/Vk28W+ikNXz9NBjXIl0sxcM6uF5D6O8GZqs5oOvPnncOreWZVsletgSC8Z+r3AquCZvw78dtogmVSba5DmTLJ8ZD6mRMGfeV89vOtmndKW0IlC0+nWwAS5HmeiPWTGUkXiDtnpC+yN0cMw+VLYw6jaKYG2IdwNa2RTJHNqelbVOe7h8f9VkCTm+SJHCX6uliSxFrWGWNncQrOWGwanER8QI=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(396003)(136003)(346002)(230922051799003)(64100799003)(82310400011)(186009)(1800799012)(451199024)(40470700004)(46966006)(36840700001)(41300700001)(36756003)(2906002)(70586007)(54906003)(8936002)(5660300002)(4326008)(70206006)(8676002)(6916009)(47076005)(7636003)(82740400003)(316002)(356005)(36860700001)(478600001)(7696005)(6666004)(83380400001)(336012)(2616005)(1076003)(426003)(16526019)(26005)(40480700001)(40460700003)(107886003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 05:35:51.8067
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60f3839f-506d-40a3-6de8-08dc26d57b68
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A107.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7765
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240205_213602_782703_8488D247 
X-CRM114-Status: UNSURE (   8.80  )
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

The functions and attribute listed in the comment doesn't exists in
the code :- ns->logging_enabled, nvme_passthru_err_log_enabled_store()
and nvme_passthru_err_log_enabled_show()).

Update the comment with right function names and attribute :-
ns->passthru_err_log_enabled, nvme_io_passthru_err_log_enabled_store()
and nvme_io_passthru_err_log_enabled_show().

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Alan Adamson <alan.adamson@oracle.com>
---
V2:- Add reviewed-by and update commit log.

 drivers/nvme/host/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 975245527c1f..7db700b2ed00 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3762,8 +3762,8 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
 
 	/*
 	 * Set ns->disk->device->driver_data to ns so we can access
-	 * ns->logging_enabled in nvme_passthru_err_log_enabled_store() and
-	 * nvme_passthru_err_log_enabled_show().
+	 * ns->passthru_err_log_enabled in
+	 * nvme_io_passthru_err_log_enabled_[store | show]().
 	 */
 	dev_set_drvdata(disk_to_dev(ns->disk), ns);
 
-- 
2.40.0



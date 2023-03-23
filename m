Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59546C6FD1D
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Mar 2023 07:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=luk/djkWGgDCOYJgP49UuxwVTZSlq6Au8MEOI44T2X4=; b=fu3Jvg75dCD+txMPU0nyuFh2HU
	w3UunPwuDUG+SnNm2gJ2dhgvf4txLD8mfmxnVg/fJc67zJ41LfokyvGbjZ5TclkgpPg2YbN6x9pvz
	EzRnFcOUqQB2nVva94k1ya9h42HNl7IHBLHKhI7x+Sgm3miFB1jeFFmbW6WUwrAy4Chch6sEsgPMQ
	E+axjyUvxp8ZwZBobqhpr0WdUnyYCiq3/tYe5UxxCxOgBqMcqQThYrL6GhuRktVUyxrMbH4xsjwcT
	UWIwkLBSLZhichcqjoBOfslSrLp6WOrfbwrdavykMd7OEOyAPBZ0DtS6i1oeYMad4x0LMa4ObowAA
	Smvfpeqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pfFlj-001AWw-29;
	Thu, 23 Mar 2023 07:53:55 +0000
Received: from mail-bn8nam04on20621.outbound.protection.outlook.com ([2a01:111:f400:7e8d::621] helo=NAM04-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pfFlg-001AU7-2f
	for linux-nvme@lists.infradead.org;
	Thu, 23 Mar 2023 07:53:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fbNS2NO9+Pe/SfQ5VCfWFPc9DYe3n6BJkzw43pqEFk69uNOlrQgt1ug1sxf2UpavLC744CMhejdAvT3SPassF40Cmfa/l5tZIKef76KX4RTzqETBSnFyjrMRyvbRk422RPOGHTd7+vrKDXLxwyGoWJjuFKANJgiYygfS+DMLWJa1tyv0m/eQfczNyD9xz5EjFnXG/1UcKMSNqlupavA+eusymTOdaCF3T9H00gUFalGiKvNfHI4BOBymj02rIPqcrhLVOh4FrQqSjLNkrI0gjG19qVTKcZGMug4CvW1swRd+lePmLn71BfpKL/Mdnq3mYMSfHy4aTrAUyVTsvC5yIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=luk/djkWGgDCOYJgP49UuxwVTZSlq6Au8MEOI44T2X4=;
 b=cTOYAs6ppynEJofHdfu/Y58oiJKtunteBO5jGwZk0nJkTvnX6odaHTwWmQYxLMbXqFxA81vx/aPLScyLswHaLzY1xsvMI+zOtt57jpjFxhkNjAjzcF06jKp4z/zK1i2AKxZyxTZQCm6ir/0f1JRvbVZ12mXdmtRaPoCtrNPy6MOqJtz+8MzRPMGx7sxELpKRwBluLNeOnF+aJPRRv3P3s98+BawxYVCRlirWfL5qzH4VKZc8kfcbrtsnrswmwlI0WLCvxPuTE6QSdBvA5IuQQtAbzfcj8U9HdfNXm1qOmrSCbdXQhcAHqRehFjphu2jyMhbDJxbwf2AEyQpR4MABIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=luk/djkWGgDCOYJgP49UuxwVTZSlq6Au8MEOI44T2X4=;
 b=CRR0z50xtjGc9y21DOU/5+KH/8coBuQgEjTvmTOc/tpuR/RVflZFhLecLidqSSgFtQrSRB7hNkOZztd28E453hvlJw/+iib5wmOy9eu4HboCuN33vQa5JkIGHfz71EnBLKNhUrW315ICxpe84H19FOFNzN+vbV/n+TyV3yYsluhat+3yqb8GI+8IgG1smRKXslLT4cLvbmiDqFiFwlWYOb1wuM9zXIWxAsPxRUw4zr/v8OKXHnnwOxxrcUZGns9+r9qp9tnOTFmH5AUGsT4V+a/eKsPln+c+Kgz2pK/q8rr0Ehe9Rf+lsrsvLclqDnxYt97Pq9+6eXH0HEblFoMrlA==
Received: from BN9P221CA0025.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::22)
 by IA1PR12MB6188.namprd12.prod.outlook.com (2603:10b6:208:3e4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Thu, 23 Mar
 2023 07:53:46 +0000
Received: from BN8NAM11FT076.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10a:cafe::17) by BN9P221CA0025.outlook.office365.com
 (2603:10b6:408:10a::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38 via Frontend
 Transport; Thu, 23 Mar 2023 07:53:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT076.mail.protection.outlook.com (10.13.176.174) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.17 via Frontend Transport; Thu, 23 Mar 2023 07:53:46 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 23 Mar 2023
 00:53:30 -0700
Received: from zion.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 23 Mar
 2023 00:53:29 -0700
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>, Chaitanya Kulkarni
	<kch@nvidia.com>
Subject: [PATCH 7/7] nvmet: centralize req completion for ana log
Date: Thu, 23 Mar 2023 00:52:03 -0700
Message-ID: <20230323075203.824096-8-kch@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230323075203.824096-1-kch@nvidia.com>
References: <20230323075203.824096-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT076:EE_|IA1PR12MB6188:EE_
X-MS-Office365-Filtering-Correlation-Id: 693d4586-2591-405a-c4c5-08db2b73bb2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	wXj3GK9ThlvgFmLtZ9/LITokMlww4DVRCHXPNTgAth92Q/xn/6xfaDeSpXnpW+XM+FVSBLxh6v48ujePYPUgDGImDBVLcu5HQmNdSoQ1x0FHiHcjQ4dgzk6lGi3wlHHE+Z3tHnlgqHPYE4jUAtTPRDVUS2hg8Oy/OkX9PEj3bHa9ZQOd58NzI6iLtpnPijo2O/19wORBsTkNTOggR7cgbe889fyfHPCZJTV1Rqi/iqhEexkJJ16aP1eCIcryNqdF23oQTA51POzM6SVcWcY8U+e2c2ckWZ0s1NUfykX3Tq/iMw/PDC6b1pRHf5ssf2RcibuUoYD50sd1etcbPdWxwtYSk844c+s1Oh1IBxZekjNe59DW6YsvZiRIKg8x8U75VGUMGGvR5aqectLf4ziOq+9db2DWcKTfVNyfbQbxSzuBm1clPcEPOkK2JDrWbhGneu09dYUbID9ZoGmczVeUs/ErnFPhmpnXcjQDSxs4TZ0w9JLN2v8VdKL0BJkQhGqKrQzc48XVwSsc2AiIYKKkmdiK9KwhgvVWBjYE/lbxG6yQyR2eCFnm9WhlMLKEcSpuqOxT8VCFegkSQFO8zVDQZQ0nzvVMpJmrv8MTPp3pKLI2B1Ou9FBXUwsAWzsz4NHIQarWvGsfKfwhUzWtXsr2RAeaAm/jyT7s8pGZbPDmL3y/4TWTDyzxYPI3tEZYCHvJKV9HMasgpF/DsTpMf5B/TXtIdPFAWdzpF28YCYJvqpDWCIY+cI7y+OUHsgQrXzHs
X-Forefront-Antispam-Report: 	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(346002)(136003)(376002)(396003)(451199018)(40470700004)(46966006)(36840700001)(2616005)(426003)(47076005)(16526019)(26005)(107886003)(1076003)(336012)(40460700003)(6666004)(7696005)(70206006)(478600001)(316002)(186003)(54906003)(83380400001)(82310400005)(5660300002)(4326008)(36756003)(8676002)(41300700001)(6916009)(356005)(70586007)(82740400003)(36860700001)(40480700001)(8936002)(2906002)(7636003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 07:53:46.2729
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 693d4586-2591-405a-c4c5-08db2b73bb2f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: 	BN8NAM11FT076.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6188
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230323_005352_863915_4EC86D97 
X-CRM114-Status: GOOD (  12.55  )
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

Remove nvmet_req_completion() call from nvmet_execute_get_log_page_ana()
and use the one that is in the caller nvmet_execute_get_log_page().

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/target/admin-cmd.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 3fc187580c8d..7bbb211ab1a1 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -268,7 +268,7 @@ static u32 nvmet_format_ana_group(struct nvmet_req *req, u32 grpid,
 	return struct_size(desc, nsids, count);
 }
 
-static void nvmet_execute_get_log_page_ana(struct nvmet_req *req)
+static u16 nvmet_execute_get_log_page_ana(struct nvmet_req *req)
 {
 	struct nvme_ana_rsp_hdr hdr = { 0, };
 	struct nvme_ana_group_desc *desc;
@@ -282,7 +282,7 @@ static void nvmet_execute_get_log_page_ana(struct nvmet_req *req)
 	desc = kmalloc(struct_size(desc, nsids, NVMET_MAX_NAMESPACES),
 		       GFP_KERNEL);
 	if (!desc)
-		goto out;
+		return status;
 
 	down_read(&nvmet_ana_sem);
 	for (grpid = 1; grpid <= NVMET_MAX_ANAGRPS; grpid++) {
@@ -309,8 +309,7 @@ static void nvmet_execute_get_log_page_ana(struct nvmet_req *req)
 
 	/* copy the header last once we know the number of groups */
 	status = nvmet_copy_to_sgl(req, 0, &hdr, sizeof(hdr));
-out:
-	nvmet_req_complete(req, status);
+	return status;
 }
 
 static void nvmet_execute_get_log_page(struct nvmet_req *req)
@@ -342,7 +341,8 @@ static void nvmet_execute_get_log_page(struct nvmet_req *req)
 		status = nvmet_execute_get_log_cmd_effects_ns(req);
 		break;
 	case NVME_LOG_ANA:
-		return nvmet_execute_get_log_page_ana(req);
+		status = nvmet_execute_get_log_page_ana(req);
+		break;
 	default:
 		pr_debug("unhandled lid %d on qid %d\n",
 			 req->cmd->get_log_page.lid, req->sq->qid);
-- 
2.29.0



Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B93CC47258
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jan 2024 14:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qDpTwm8jePtg3PnoUpoA3StzLYrO4pIsAZ22Mf3CGyA=; b=XBzfocg/ENby5KoPUUX4iFD7H3
	MkIC4RzgykInJ3U3SsjILJW2nsMleCA//UsOikeSON4bWIjtZsfSzimwJFFBfzl3bLOeVDncyQr4s
	KizPyk146rguwhrpzD45gjolTJiG6rqadLW7uS9u17PtVs7YovoofkgQ/Z7H4K9neRUqvqRDpZo3g
	akCpMDG+uCAig6CH5yklDOQ5wKIa6TFFHEi9bEtwqjFnhMvJK3ldow26BV6D84rHkYhkAAkN/3+LH
	vtOJ0CbbLfEEJYkuCJC2vQblKhC3Bouonv3I7Cxz6BCrFUebhjp5TChF01aD1/hIbDIcuAuJJIL9X
	5dpDX8WA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rSHxc-00GquB-1I;
	Tue, 23 Jan 2024 14:41:08 +0000
Received: from mail-bn8nam11on20601.outbound.protection.outlook.com ([2a01:111:f400:7eae::601] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rSHxZ-00Gqqm-2H
	for linux-nvme@lists.infradead.org;
	Tue, 23 Jan 2024 14:41:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kHmj+63oCfFJSBldehqmIlwpj18VU/h8I0KtzyPvsF00bThLtvVcNLnZMI2IB3Fh5xFXCbuUUdXa4fzEueHNni0ewlIQSPitl/vHe93rePREN11VR7uxNdh3j/ZFqSWhc0R1ln17+HDFWoOlbfaJAQotuj9KLOQKlEEvEzHBr9h+s3/auxGG01CuMCMd+ZkkxnCDOa/1TuP0RZMCj+qOVxkmF9EQvc75QrYRL6fvnxqbqDYpEjJp5k69L8yk/dL8syB2XhUx5hqKCHu/nl24rQmMcFBJ6gyr3cDJUX7EIBQmEoAges6FCrngI1sv00MFlKEbrnXThXevSBo92f3HGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qDpTwm8jePtg3PnoUpoA3StzLYrO4pIsAZ22Mf3CGyA=;
 b=M8IhsVjXtNKuwojFtrEZcMVpO16GNPcD8Hi0A+63Ix0+MYJUHHQKu7iVKhE8/XYpIEfjClDeYhRG8T+u7A66vI5Hw4oc53EOue9C/9U7OS/kD2f5d35Ixtc8evkVJuxi+AMGtuz5ySafuuo0i1lJ9TqjapxHniqMLDpfbozZ/kBQmDitvyC4lmtUW+73lQxcS2Fuf028NhXY7aJ/2j4vSf1IM2EZyk7XS8usZtlG7OqIE0eKR3Vju5gfvDMZHTgOgxCSRt3KQqgEDBUSfWI1rMh36B/dZGOJUbm/mawcC1pYDyzBswbtRJZYxLIu+huly6H3e6HyrG8Z005ehygX5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qDpTwm8jePtg3PnoUpoA3StzLYrO4pIsAZ22Mf3CGyA=;
 b=JYZxO1wKn7pUgqn06d+FsNUZPoyH0SIMAYsUzxkzm7/aeacPzSKQ9efaYgx72uZ3UBDL+FGrAr+pL09PFbFPZ4bbRx7H6epdRcV2nFTKydBa8ECJN6WUn5lTiV4DOwI+TA4EigDAvg4C5+6MuStl1pV3pnTWWbbgDGQhG3zaY+sV+0x4GrNj57lU8N3CNBBnc2my/rb9Ljs2ZyDQ6Ucm2xUlljqQRv0+cjqr6kNoK5Ym85zKkAKcIcze+ZYcJ72CGX0gKnwZ8DeasoijPG9D9Ow92V+bIucxlooirzlyAwsFpNXHdKpH6ivN6dAnQx+uG7cgywQTx3qlIArzG+s94Q==
Received: from MN2PR05CA0049.namprd05.prod.outlook.com (2603:10b6:208:236::18)
 by SJ1PR12MB6196.namprd12.prod.outlook.com (2603:10b6:a03:456::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23; Tue, 23 Jan
 2024 14:40:55 +0000
Received: from BL6PEPF0001AB57.namprd02.prod.outlook.com
 (2603:10b6:208:236:cafe::d5) by MN2PR05CA0049.outlook.office365.com
 (2603:10b6:208:236::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.21 via Frontend
 Transport; Tue, 23 Jan 2024 14:40:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL6PEPF0001AB57.mail.protection.outlook.com (10.167.241.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7181.14 via Frontend Transport; Tue, 23 Jan 2024 14:40:55 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 23 Jan
 2024 06:40:43 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Tue, 23 Jan 2024 06:40:43 -0800
Received: from r-arch-stor03.mtr.labs.mlnx (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Tue, 23 Jan 2024 06:40:41 -0800
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>,
	<linux-nvme@lists.infradead.org>, <kch@nvidia.com>
CC: <oren@nvidia.com>, <israelr@nvidia.com>, Max Gurtovoy
	<mgurtovoy@nvidia.com>
Subject: [PATCH 3/8] nvmet: set maxcmd to be per controller
Date: Tue, 23 Jan 2024 16:40:27 +0200
Message-ID: <20240123144032.27801-4-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20240123144032.27801-1-mgurtovoy@nvidia.com>
References: <20240123144032.27801-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB57:EE_|SJ1PR12MB6196:EE_
X-MS-Office365-Filtering-Correlation-Id: 2328d0e2-e907-4fab-c120-08dc1c214e73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xyAZv4/QAklaEg6YwlFUoBR2fIIN6X4i6saHQ2IY1DbeBEPu3+DGvnwa4kmmtUjWvOyImZsgM9YGElab2r3Rxw8O+JZ3Hf3xpBDKpJyKxEfbutQ43D4CO/Y7QyiJxlZFKg3NoKIYTSkMCkaREPXWPCiaDzXiugy/QCtcMtorkJlsjMRcX8nlQMGT1YLI8xKAJkKeiPpTk/OjwA05jPz4YKV13flJGFNbIb/Rc+/TCIbKwkgvKmrHVetOtdUpNWcSls2S1iPCYc+e6ReUsGR1z/9xrlLOPOgCq5dTAjdBw9DhnymPyu0vhJUzDt82NzGxKIVL2V++foCUZhO0DVTiRNgb5ohcecAm+kmO7MZ5GBDCePKl8tAot9tWVfrOUIj7URAuhmQV9JlCjFin2LxnPtJjSYmgc0YPCS9UaAO9rWIdmxpsbewkMesWxcJsCU3ZOWSae2JCJLEdnZALNs6yYoLtOmPzfV3zzYVBbp9A57vDHzOIHNSEIMT+NA6VHURF+pDzSVffJiJXBmKY6F476V2kUEWxFG30DQ1uNvlFnNdCw64mI5/T/VuQVQ9uk6FiqkLO4SobBXQMB/E3cetEWm3iw8ws7TS0aR+yAsGcVUs0rLCjQjSljr2VhcueENgd/pEGxhepSOiJ8DYr/tdccn4grqG683fHJZVK/dSeaLIWvYNpHLyo7jSX3l/1P9nSxQZRt3YMQrWpz57ANRJwSkSedygAlktOssNAWItQ8f1cxIRIRRafpv3LrARbSOQg
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(136003)(396003)(39860400002)(230922051799003)(186009)(82310400011)(64100799003)(1800799012)(451199024)(46966006)(40470700004)(36840700001)(54906003)(70206006)(36860700001)(47076005)(316002)(8676002)(110136005)(1076003)(83380400001)(70586007)(107886003)(6666004)(2616005)(8936002)(41300700001)(2906002)(5660300002)(4326008)(426003)(26005)(478600001)(36756003)(6636002)(82740400003)(356005)(7636003)(86362001)(336012)(40480700001)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 14:40:55.3600
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2328d0e2-e907-4fab-c120-08dc1c214e73
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB57.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6196
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240123_064105_751024_3CA2966F 
X-CRM114-Status: GOOD (  12.87  )
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

This is a preparation for having a dynamic configuration of max queue
size for a controller. Make sure that the maxcmd field stays the same as
the MQES (+1) value as we do today.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Israel Rukshin <israelr@nvidia.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/nvme/target/admin-cmd.c | 2 +-
 drivers/nvme/target/discovery.c | 2 +-
 drivers/nvme/target/nvmet.h     | 2 +-
 drivers/nvme/target/passthru.c  | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 39cb570f833d..f5b7054a4a05 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -428,7 +428,7 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 	id->cqes = (0x4 << 4) | 0x4;
 
 	/* no enforcement soft-limit for maxcmd - pick arbitrary high value */
-	id->maxcmd = cpu_to_le16(NVMET_MAX_CMD);
+	id->maxcmd = cpu_to_le16(NVMET_MAX_CMD(ctrl));
 
 	id->nn = cpu_to_le32(NVMET_MAX_NAMESPACES);
 	id->mnan = cpu_to_le32(NVMET_MAX_NAMESPACES);
diff --git a/drivers/nvme/target/discovery.c b/drivers/nvme/target/discovery.c
index 668d257fa986..0d5014905069 100644
--- a/drivers/nvme/target/discovery.c
+++ b/drivers/nvme/target/discovery.c
@@ -282,7 +282,7 @@ static void nvmet_execute_disc_identify(struct nvmet_req *req)
 	id->lpa = (1 << 2);
 
 	/* no enforcement soft-limit for maxcmd - pick arbitrary high value */
-	id->maxcmd = cpu_to_le16(NVMET_MAX_CMD);
+	id->maxcmd = cpu_to_le16(NVMET_MAX_CMD(ctrl));
 
 	id->sgls = cpu_to_le32(1 << 0);	/* we always support SGLs */
 	if (ctrl->ops->flags & NVMF_KEYED_SGLS)
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 6c8acebe1a1a..144aca2fa6ad 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -545,7 +545,7 @@ void nvmet_add_async_event(struct nvmet_ctrl *ctrl, u8 event_type,
 
 #define NVMET_QUEUE_SIZE	1024
 #define NVMET_NR_QUEUES		128
-#define NVMET_MAX_CMD		NVMET_QUEUE_SIZE
+#define NVMET_MAX_CMD(ctrl)	(NVME_CAP_MQES(ctrl->cap) + 1)
 
 /*
  * Nice round number that makes a list of nsids fit into a page.
diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index f2d963e1fe94..bb4a69d538fd 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -132,7 +132,7 @@ static u16 nvmet_passthru_override_id_ctrl(struct nvmet_req *req)
 
 	id->sqes = min_t(__u8, ((0x6 << 4) | 0x6), id->sqes);
 	id->cqes = min_t(__u8, ((0x4 << 4) | 0x4), id->cqes);
-	id->maxcmd = cpu_to_le16(NVMET_MAX_CMD);
+	id->maxcmd = cpu_to_le16(NVMET_MAX_CMD(ctrl));
 
 	/* don't support fuse commands */
 	id->fuses = 0;
-- 
2.18.1



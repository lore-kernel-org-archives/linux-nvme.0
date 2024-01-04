Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B941C47077
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Jan 2024 09:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UESTRngpUpMtWoEkco7Jvpd3gYWxjXdPn6POwndBngE=; b=Dg5OavvsBRHTPccdF1K5RfZy86
	c6PzP9idsgGpNd3g3tY1EcBVG+OoMDG7cwjwZArKFPoLZ2bX5B2yi2k8iZ6ohxESvNaSD8XLnPRSs
	1hPZ2df2WdoKhtnwb54EUSkIdV5bThbMKo7SUVGJ4sjM+H7Hcvfm1FikSK2UbSKjGQZnMECvfQ7Kf
	/QTjB2tCjoD+3basj5ZIuLkMeriE+Am+XlbAfRsxBLJHkIbsWuRysX1fH1ZKkFDofZGYjZ4r94dMh
	KlDclxXeHkKOShtXQjREX8cogZRJghRoIp0Ujw/urh4Jjkdd5cNxMZ17ma3Z6FZBN1B8gAUOF42S8
	36Ssadug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rLJza-00DMNs-17;
	Thu, 04 Jan 2024 09:26:22 +0000
Received: from mail-dm3nam02on2062d.outbound.protection.outlook.com ([2a01:111:f400:7e83::62d] helo=NAM02-DM3-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rLJzX-00DMLt-1D
	for linux-nvme@lists.infradead.org;
	Thu, 04 Jan 2024 09:26:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H6vaHyZNP1rrGRVgmooqlzOlycvxFCkSqwIyL0Hd1AczxZBP4f9giXfZ/jcjxxki2yeUJrlmQrifTTKh2svxXf/t0SLyq3ZQOhplbx6v2yRYX53B2MjndblXkhixd++8/sYg1fGBG+eqF7ZC4IIXSFEQh9IdMqJ2qgh9QEVQxpT+/4KXdSOeYmLhbobIbz+4ffeJ8zUVXjIe1EysAb0hkg2bH0wwUFLCTgneppSsI9sLsE5zAnHYPyLR2RZR0RD+ahQzM2ghijKPwM2SxWYHB5p64J6cBExQKjBZuDl3IRjb4Is6ejSB93XRfLub61f5hH3nEKCPeYA4d6xOPcc1Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UESTRngpUpMtWoEkco7Jvpd3gYWxjXdPn6POwndBngE=;
 b=HwxqBmlYKG2tHEUyD5eqATT1tBH5edwjMvgoaMNk/ACOLEsIeK6JgYz+/q+nODbI+kzeOYWHwhu0pfoUvWzay54e3MJ8A2XaBi224ZfsaB618AeIgOQXHPQsvF4SeeQukQLTkgVJPGHVcUT79PytFv5dN3Gc8wqXK1q7/B3dSZjOrQa7ctxkK3KM3x5P4ln+mbti4eckHtrx5IktzFUcDNJj4JkzhL6yl2UgrSPB0yXNZxZqIuix+qvvBSG6WmjvtMpdRqvYyq+XX6zNgzh/dOTwSWgbYsHfm3FMwAAA6trKAtc9g2Ix4lH4iklpchNNIOyZnVqwjZonyy6hs/VWKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UESTRngpUpMtWoEkco7Jvpd3gYWxjXdPn6POwndBngE=;
 b=n0QRsrJGkm4/txY7bnjYvYI3v0WmOI2hsGbaAbLffk6g0eXwqMwYIUCfA/FLp0M0ovaQy50+tqlwzCD7nY17Y1rGM4ISPDxRheQDvM4kmufirs1roHBCjs2bWv0ofl5A8Z7lJekk/AZKNtWzgMLFXf097TJV1KLWg+wPpStAHos1Wrifc7KSdvgG0EL3tjh8N5Xskw9EdA7JUCvg/exGoUX23K26oVQ8eDA+umvtAV7p7bvppj5RgvoERtYe9VtWHXaH2tslB3EZlcZfCtlxF6zsq5VnpAkQoyvQyRz8JEMu/3B8JH5pH9ZD9RXnSDIrPTkhqEpcQcqKwSWmZuc2vA==
Received: from MN2PR05CA0031.namprd05.prod.outlook.com (2603:10b6:208:c0::44)
 by PH0PR12MB8008.namprd12.prod.outlook.com (2603:10b6:510:26f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Thu, 4 Jan
 2024 09:26:12 +0000
Received: from BL6PEPF0001AB53.namprd02.prod.outlook.com
 (2603:10b6:208:c0:cafe::d6) by MN2PR05CA0031.outlook.office365.com
 (2603:10b6:208:c0::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.10 via Frontend
 Transport; Thu, 4 Jan 2024 09:26:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL6PEPF0001AB53.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7159.9 via Frontend Transport; Thu, 4 Jan 2024 09:26:11 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 4 Jan 2024
 01:25:59 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Thu, 4 Jan 2024 01:25:59 -0800
Received: from r-arch-stor03.mtr.labs.mlnx (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Thu, 4 Jan 2024 01:25:57 -0800
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>,
	<linux-nvme@lists.infradead.org>
CC: <israelr@nvidia.com>, <kch@nvidia.com>, <oren@nvidia.com>, Max Gurtovoy
	<mgurtovoy@nvidia.com>
Subject: [PATCH 3/8] nvmet: set maxcmd to be per controller
Date: Thu, 4 Jan 2024 11:25:44 +0200
Message-ID: <20240104092549.25721-4-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20240104092549.25721-1-mgurtovoy@nvidia.com>
References: <20240104092549.25721-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB53:EE_|PH0PR12MB8008:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f7fc248-59d1-45f0-8784-08dc0d0730f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8FLYY+XKZicwuajVmJjOvQFPxEnu5rHeWUSz/O7lLJGNDvx9F1YXaJg4rBAnSF9TiELUgTIjkUqhm6+jaZfyrqQXUDzTiACbCuhEUtu2cKHP9Nv5dD4BmJtTrdheLRB13DWEx7bcHEoTAegbdk3pNIlaci4vIVjCMPhv/9V7m9vr2rzhBn2k6pHTDR2BcgN18FUuUq9pnfDVxn7GcY8dC+z9voJeomsBNp0qTDqBf8WnIz4OZt0JFnyZog0UZekhUAZkfnBjSVm1fYBr1folSlgIo1LcUAG3S7AUnvq0vahre1eiJlh4YXUBrtqvK3JwbbO+RoDLTc7K+mlAS/G0ObhPkp4kr05os6h8WmMHBjeeU63tMg+zEyO1tpdDeTXwmH5p0faWAdPYqlvI4TDWzJgCWIGfzIVdrKFVuhlCXDE6nucyaiav3OgtOkbi6Xl1ofZCv2i/UbP4CrE8kUdSiTvwuHQ+g/4RNuhTNZeOorb7qXhGWnZ4YQvyw6G0BgxjUeOmE5OSkaoJWJTlcot79Qul9taXPaVvvEy4ZG9zqkn3K6XJDcFeIXSFKIkIaG/ywv4+39BI88/JtLLWirKcZR6j7+xjBivvyCIDg10K0E/gVUJ/8XdycpJyfu3oB46rNGrmZetigOteYb/LfOuBn8bdjfjOIryxtuWcdoSP3uVaOnXI0TvRBdB7zhDyUjNWrWfd1lPLMRpDOclHtK7ePklJ2UvhDaPepacqF6qyzN3i7wH07XEWtwvI53aacVXH
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(346002)(136003)(39860400002)(230922051799003)(1800799012)(186009)(82310400011)(64100799003)(451199024)(36840700001)(46966006)(40470700004)(40480700001)(40460700003)(36756003)(478600001)(86362001)(70586007)(70206006)(426003)(107886003)(2616005)(7636003)(83380400001)(356005)(1076003)(26005)(336012)(47076005)(2906002)(6666004)(4326008)(41300700001)(8676002)(54906003)(82740400003)(36860700001)(5660300002)(110136005)(8936002)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 09:26:11.5050
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f7fc248-59d1-45f0-8784-08dc0d0730f0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB53.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8008
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240104_012619_419880_8CA2FF43 
X-CRM114-Status: GOOD (  13.00  )
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



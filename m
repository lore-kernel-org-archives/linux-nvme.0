Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EEB2CAC5A7
	for <linux-nvme@archiver.kernel.org>; Sat, 20 Sep 2025 23:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+lzcEVYxJs+FcG4uPnmcEstmC76QkU6AN5Ybki1cWyA=; b=aoPvV/GhgOO/yDfQy5G5Xmdd5h
	04n4vF8iNSyBJTE2EvfARIzMRLknZ00dnGnn06ulHIzIJ4Su+tJAAQwK4pwcwclhvN2r1bRriw2xg
	PnD5PrGS5vgzpAo6s618nLkJpLFwz9iW1CKfjUveV5zN8A+XQaO75craPkjojhvTdN4emKNHVbSO6
	ufvgfGr4xXiBxkVeMfTFihgNyO1Vfoemxg/8Tk15WulgdrCuKyAl/nE1KVYF87rUQdi6XWc6k6byx
	uxEv/UQEHsZfSKG+2VQgcbMW5p8P/ozJ6EDik8hz6DNxrQ2jhwPnq8nS9kPunqUgmXkgVu1GbxaKK
	RoU/J2xQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v07L8-000000065VI-31gV;
	Sat, 20 Sep 2025 23:50:02 +0000
Received: from mail-westus2azlp170100005.outbound.protection.outlook.com ([2a01:111:f403:c005::5] helo=CO1PR03CU002.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v07L6-000000065UV-0Uj2
	for linux-nvme@lists.infradead.org;
	Sat, 20 Sep 2025 23:50:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ez3LpqReG6eY69i2MYyFtLUgxwo5hY7y/ycK5QOr8P0ThGQWYqlxabCT48nB2wH56lNQ/yA0adg5YYTlS2IfizTUMr48aKAItLl18g3FyRiO97ga2RgajVKQHIQ913ZppP0L5ydP9EhpcxGyznpKgIlr1v9lMI1W+N5SR51pQgtFqiz5UbQfTFJdhIoKPiG1Ipp1LdkkiHg8JSaEbnpPcWl+DJt1YurVWTs++L6R1s0d0v5Itza8KdJVZqqHCK7pEdGb9NX+i42jtHt4R8fV1Iex+hSZx0v+lvzdJ2e8iBJWDUKQBCBTvyXRxOwPpJHw9+bk1Pbqbv1t9ajyqQm/cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+lzcEVYxJs+FcG4uPnmcEstmC76QkU6AN5Ybki1cWyA=;
 b=ktD4Kq0il7cFER92Tb4AB1ElZcAK0yo/18UaacxP7VMCY+S7tFtfvXywS6s2cL6cg+/EDleHany5BQByOq1h3WAZ/T5QM4R9BuIfiW/BjKDicmoPqPWQQQEtAwzGZPcRXlmzBwo6FYN8bY7eVZzDoZD95gPby3EPWS4lRGru4J1xTquNk7ZtK9S7+1sMo5zQ2AZlX3OTw/N5KpZ+8gI2DqVcaM77RgGdBilEYRRXgNpmrhVzFOL6NsIP88XMNyV/sXOTR1sk3scsoJw/o8ECF6JGs6RGsPjG6MQQBiZPlp5Wl2OUFfN4PDqxkzlyGDSllKyumhnvOXHGe+TayqucyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=lst.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+lzcEVYxJs+FcG4uPnmcEstmC76QkU6AN5Ybki1cWyA=;
 b=SmTJZjWUJ4Cz+itzvZ5Y+XPKZXLYGKy8tPm9RkjI7nMl2maydPZMXWVnnSUEfn0HrnXmp8S6qBAzfDY3s6O8dtdnecLKBFl6vm1K7I9RFnDpevJ3EwMqXdN7jVetMJvmYHfaEEw4YLZ/2kn3wlEU2WcQPHduXj3aIw7pSBNVba3Eo79Y+Iz/54K6Sd/L8fjw5EL4ToKK96M85MaRQAe3x6tBulJrMGZgtTxMDsMeSgn3owzWBMV0ySqKzI2PAmgEaMiX5LmG0mZabZNx+hqGl5CFdd29u3t5fo1v3978xvyjxG92/9xE6h3JG676UdyoUNvKQitUCqdk21di1o715w==
Received: from BN9PR03CA0492.namprd03.prod.outlook.com (2603:10b6:408:130::17)
 by CH3PR12MB8852.namprd12.prod.outlook.com (2603:10b6:610:17d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Sat, 20 Sep
 2025 23:49:53 +0000
Received: from BN3PEPF0000B06A.namprd21.prod.outlook.com
 (2603:10b6:408:130:cafe::63) by BN9PR03CA0492.outlook.office365.com
 (2603:10b6:408:130::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.16 via Frontend Transport; Sat,
 20 Sep 2025 23:49:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN3PEPF0000B06A.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.0 via Frontend Transport; Sat, 20 Sep 2025 23:49:52 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sat, 20 Sep
 2025 16:49:49 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sat, 20 Sep 2025 16:49:49 -0700
Received: from r-arch-stor03.mtr.labs.mlnx (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sat, 20 Sep 2025 16:49:47 -0700
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <hch@lst.de>, <linux-nvme@lists.infradead.org>, <kbusch@kernel.org>,
	<sagi@grimberg.me>, <kch@nvidia.com>
CC: <israelr@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH 2/3] nvmet: use port's tr_ops in nvmet_disable_port
Date: Sun, 21 Sep 2025 02:49:42 +0300
Message-ID: <20250920234943.4959-2-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20250920234943.4959-1-mgurtovoy@nvidia.com>
References: <20250920234943.4959-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06A:EE_|CH3PR12MB8852:EE_
X-MS-Office365-Filtering-Correlation-Id: b78ee019-ce20-4681-7af2-08ddf8a064fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fQNUlbV363zzeCq60U4plRBmrMKq8lqFIoicgzHHyAkcwit8O8IxVqaXGXGV?=
 =?us-ascii?Q?JOM/NSE5+g7B6ddf6U3ad0PEQ1gn+SfQYYJoCNwhfHxRF3D+OyMhylBVs9vb?=
 =?us-ascii?Q?CWFKulSy/oThXzsOuWvvJteqmfNRo4UJpKNk9Q0WmCvygNb7276/Gh/2ufkw?=
 =?us-ascii?Q?RfX8VYa9P4DPNq3pwXFzNHyUzkfklZtOUgLTYygKY9s2vC8GenQ4z3zwqwlS?=
 =?us-ascii?Q?ifDZcggfdOGp5k/A+7CKU5DQ98brqkDhS2++l7TtEZN1/JUTmQurD1dIIJ/x?=
 =?us-ascii?Q?vLqUR1iEUrXBHkJyrjQTR5VqPFTxtpRKAtVg513Q1nzU8FhZZB9xtJN6f7vk?=
 =?us-ascii?Q?EEAYTp+UBxz31UaQ17W/iAQWBfZHiBcSTWrtuWjO24M83CY37nr/fvG2Bxa6?=
 =?us-ascii?Q?CLHsYUYJx/10sweSYvqxgTUVfnOYnPVbo+te8JuPNhQtZUPs9L3kxEFNPv/Q?=
 =?us-ascii?Q?9HnyiPW5Us/BrE/ziVZV1LYtw9o2Z9PvSlxpN2jIRsXYzs52bz7KImZV/2KI?=
 =?us-ascii?Q?a4yfnTu5jw2kSxjKhCKIs9G1Xq+KT0PO1qxk6vid5drb/oBJXXUfiCBhZXv0?=
 =?us-ascii?Q?7T+0WvotVHLS9GfX74QagP+7iwFpFZd+9A4aadh1aaTBBivdLM75VwM16kPl?=
 =?us-ascii?Q?vDFbpWlfrjlT+VIX4geX6Td1fa1I2NWi3fylZNPuCUaT9dyEKZOX1BR34igJ?=
 =?us-ascii?Q?4q+bH7tfkOjZjowuOIxOVR29nZl363W3Pn1ia/qYSqLu44xk3L8ohX2+z0mV?=
 =?us-ascii?Q?RXdTkPAO5pnqxXDtaig4yHKDo1ZHqupMUxf6pbyLOpVv/e9+8ZBN7twf5+Zg?=
 =?us-ascii?Q?mSvI+CJlPScZ93Oa2qiETEYQ/P6Y54ubNkKSqWKfQNeOQZBVedOly4RgX90q?=
 =?us-ascii?Q?Sm044DJNjrIQJolYilLdOyYnT8i+eRYSbwtRY7EB5UepV51aYGZdBp9ynJ4R?=
 =?us-ascii?Q?6G4zMB0pThKl7cwyLvWJtc68bDbmOWden2p2KSMK4XwyqVzwCOUcDColVXbW?=
 =?us-ascii?Q?U6xl1R0+cU759NdjPbsQK0JtUTptW3pc04mA3GkjKKCO3Zi3taCf7tf2vtyt?=
 =?us-ascii?Q?Al6ki2jFY65p6jLv8Q8M+VUib4H4fAQUBqcXUn8n5pq+ljSgmuZQua1DtVjg?=
 =?us-ascii?Q?Vu/BCI3xgLDolPZCE5tJHxYkPeMJJMzjcy2tvXENPUCPzhuvvRcRNGq4nYCN?=
 =?us-ascii?Q?/fCXwhN/VQa9u/9VZ3i2S7cvTNVeHa56eJ3eteIAd5EBE6UKebfg+7JW9PxJ?=
 =?us-ascii?Q?mFYG5KK5gMVGpf3yozJhBIVvR0DnyzD/Sy2i19waKicdRgTzX17yfwKhIfa6?=
 =?us-ascii?Q?hGSaWuJ2erhLJ+N7RJr+pCiK5SjHcEkVQiHl/GPx5VQf2FgSpstOPZofkNXb?=
 =?us-ascii?Q?jM0MkYle6rY3z6NpNIkrb/T4g7Az0evGkjd4bDsLgeOvi2iMTG5ntx1Bn7Ut?=
 =?us-ascii?Q?QmnSIR28XDssc4lCOS8KJS5M9mCs6H4iJK6I2UsQF6a2mkcO4doLSL055Bak?=
 =?us-ascii?Q?4qsN976K6dG3KXA=3D?=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2025 23:49:52.7286
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b78ee019-ce20-4681-7af2-08ddf8a064fc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06A.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8852
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250920_165000_155999_56AB9220 
X-CRM114-Status: UNSURE (   9.19  )
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

Use the port's tr_ops pointer when disabling a port, instead of looking
up the ops by the transport type. An enabled port is guaranteed to have
a valid reference to its fabrics ops.

Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/nvme/target/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 9f5159f04bbd..f31c7fa70740 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -388,10 +388,11 @@ void nvmet_disable_port(struct nvmet_port *port)
 	if (!port->enabled)
 		return;
 
+	ops = port->tr_ops;
+
 	port->enabled = false;
 	port->tr_ops = NULL;
 
-	ops = nvmet_transports[port->disc_addr.trtype];
 	ops->remove_port(port);
 	module_put(ops->owner);
 }
-- 
2.18.1



Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D048CFD31C
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Nov 2025 06:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=WM8JocUGSERnD277DM0ARLw0y2B86ts/uM/Vpio7mwE=; b=kqnbkcqMdgBNBW5BRsDNLBZAMs
	Ws9EMdV7+FyxKjJaCFC3QttHyLQTa3UfzjVaXvk5ei1Aiw0lh5rFK3d5ws5r4Xfz2bS28/Ks8k86J
	Lau0kdybTSi8/k3loPowVjSPlmzwfXdao8Nz5gJvVKEZvAUQVT4iqILZjo8DEuP3dUevwDeJbwuqQ
	kVxjqVrnmyKYjuBRE1rpo/17UWMPSOMyGWJEmOmgNiR1sZcWCrUxys8bE23TZUqrEs8DOarQ4NCYk
	eCBH3vDHXs6SY12zPcnq4uYp8z3VbNYMs67zvu83y9+riBHoRhzcUFu9pL0QS0FJ1LDieUK1ykiV+
	UzcUeC9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNQON-0000000BBYn-2lDJ;
	Mon, 24 Nov 2025 06:49:43 +0000
Received: from mail-southcentralusazlp170130001.outbound.protection.outlook.com ([2a01:111:f403:c10c::1] helo=SA9PR02CU001.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNQOL-0000000BBYB-0Nfi
	for linux-nvme@lists.infradead.org;
	Mon, 24 Nov 2025 06:49:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XI7GE6/PhRr7zJ54jOUI09hNT4VM7C/k6UzyYwYEnieuut4ZSvsYCefr+di/Wmb+euFhZmEIsP5uFbvzeHZ6GsdDVNFOd+Fd3CluNlPoCT/OQcopLJavauYdtmxOE5HzExWs2j02Rq+x/7CBdE09hA7kErzbs5k0k4h1E8h/fpcKhfhJNnp58Ocg0CCWLVdTaVSm6dQKC6OqJkpeXWgI0FTkvLWLGH2sb8BnTPSU/RCEiPpcWMSBCH72cHKkAHat/EZL7KD9UsqqGJTs8/OaxPKVvMVud+Hafs1PHGhcu9zYYyclAkY7QyKmKZGZUn6joOm46aubqSlhCI8WFLSvSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WM8JocUGSERnD277DM0ARLw0y2B86ts/uM/Vpio7mwE=;
 b=ep5gAE8Qa4ioh6FjWB7OM9cY1Igh1nhgrcAxeq5A/0UvkcWmEVrL2zkh1l77oRm8FoDD1MREvBhuZMOV2eR8nb7Y7jt64Ou+Xc3vj+jd5gvkCJYSDSjB9EUYew9bfDZQZkjxka2TOZP5XuQ/Fn95MmJn80wEwJM68+Ywtu15WwchcwEkdonkG7uEQsnZzdt/GRAWtytE126I6NKVg0qQUhHcS+wP5UNrmG9nGM9HWB08ESEeRE9jO/H/N/FwkGCyIsjr32OjPRobnI9o83mZl5zu5fQ2Bu+ZCcha2euMym3D+F063meIdr4sVkVqp3BQ2qmdCfXaYEOWbbY4GRK4UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WM8JocUGSERnD277DM0ARLw0y2B86ts/uM/Vpio7mwE=;
 b=ME+CfwNAL5B3dmxOq/tRHNW9OmGX4zYUGWqP4d8Kxjq/suTq9WlxRqyJHTRtyOjH4FsQNTwcGdkBN9AiQEiDlCarKDJ7LtqVtWtU4fwHo++9PAMIs60r/2kJyjD1MrDvvCeEe6vNfpgf6IsNYd8m6xvNIF1uypZ/UnJ+L70vcKLeeYZN9Jvpk4/MP4x2A0E97OInD0/x5TiWEx7ZQSmWaD5BMUedrqOaj+avd+qmc++AZNr0utlL79CKk7y8EzriveMDjNJg/ltM/xV3f5H3a71vRbTDrrNyMOT0yFGWNQrPJq6foFuoYkzq/mxcmSF5WS0e7U4anrAKqwyyRCU8zg==
Received: from SJ0PR03CA0179.namprd03.prod.outlook.com (2603:10b6:a03:338::34)
 by DS7PR12MB6006.namprd12.prod.outlook.com (2603:10b6:8:7d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Mon, 24 Nov
 2025 06:49:34 +0000
Received: from SJ5PEPF000001D7.namprd05.prod.outlook.com
 (2603:10b6:a03:338:cafe::46) by SJ0PR03CA0179.outlook.office365.com
 (2603:10b6:a03:338::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.17 via Frontend Transport; Mon,
 24 Nov 2025 06:49:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ5PEPF000001D7.mail.protection.outlook.com (10.167.242.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Mon, 24 Nov 2025 06:49:33 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 23 Nov
 2025 22:49:26 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 23 Nov 2025 22:49:26 -0800
Received: from rsws46.mtr.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sun, 23 Nov 2025 22:49:24 -0800
From: Israel Rukshin <israelr@nvidia.com>
To: Linux-nvme <linux-nvme@lists.infradead.org>, Sagi Grimberg
	<sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>, Keith Busch
	<kbusch@kernel.org>, Jens Axboe <axboe@fb.com>
CC: Israel Rukshin <israelr@nvidia.com>, Nitzan Carmi <nitzanc@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH 1/2] nvmet-rdma: Use kvcalloc for commands and responses arrays
Date: Mon, 24 Nov 2025 08:49:20 +0200
Message-ID: <1763966961-32140-1-git-send-email-israelr@nvidia.com>
X-Mailer: git-send-email 1.8.4.3
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D7:EE_|DS7PR12MB6006:EE_
X-MS-Office365-Filtering-Correlation-Id: 8156dc03-6fdd-40ac-ac00-08de2b25a05e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?J3sjyZxETQYHoj2cCETpEytmtMvWOHwxoqm/W9ovzjx50amA82lwklg57rXd?=
 =?us-ascii?Q?4VnkNE3gRWRc6u7itVakUs5h+ZSZGDFGoA9ywMYpARkMl/XxuhWvX4XBLkA3?=
 =?us-ascii?Q?bLzmJsiIBuFSKfihIPpgaZ96mqyOwLabw2n1es/rKSCKebr9McypHK8CxuWo?=
 =?us-ascii?Q?mGPBGeJARvh680ir4PFFjV5VQ52Rsbko0f7MIWJp8Df0djtq8UFlkNg5TPai?=
 =?us-ascii?Q?3cIVaE4/UN8QikQiW8Kdj+vaMqVr4M3CgrP1qU4lNqu46j4sUHoHsLJnL+Ih?=
 =?us-ascii?Q?RNtfsbeAE0I8tTmnMP276FB3dNBK+c/QORX0xvEU10930nQ5YblNiGr2EgAn?=
 =?us-ascii?Q?D0D8bB9DJJ+XI/x9NT3IDTbzWp9k7Xf2sOEegyLOPWs4epO9bTjQI1woqLPP?=
 =?us-ascii?Q?vUNZQ5+cdOK5UmU0aeNYk51gpOdNpsOc2x9YCYuC18hWABBb775uvtK0n4v9?=
 =?us-ascii?Q?XsaQXAg4rMWIN9B/e4CT+beJYlSvDu01ofV+KYUS0N6JsNSpHqkbyYsbYzFS?=
 =?us-ascii?Q?zasXmdMvyINCNpJqDiLlPcqYaaHvOxs+rRhzRcUwvoqfjcs5GoGSc9A57aqx?=
 =?us-ascii?Q?ya2fAeWkmL8uEhfDkxove6liQ6BPp8wqTncCQStoJnLPJEOmHGUl0rWS2/Y0?=
 =?us-ascii?Q?ZpCdk6jPzmHkoYeZODmHldSPq3MHE854FLY4WxpfgOK+mPjdlWYcp04YTad6?=
 =?us-ascii?Q?LiKZ9QEA8RIuMB0/LW0FsXyq1xZcgZj2GUjSVpBq2XVLj0mDEIZxch+11ZEH?=
 =?us-ascii?Q?L9rfQpFMyK5ZnKi5ueN2Op9+tpw+Htz6gglD7zsl+79xo0Jnc36uOr0Z75l3?=
 =?us-ascii?Q?7yzrxZBfwqapPu6iTd3VVAtmz9CBLlh4Ng7ZqiWLuhB6WmXWXao/NQ5iAUu7?=
 =?us-ascii?Q?Kz9AJDb9mOB9LLWC1Tz59ibBwrjWwGp/5vloHkasDvB8umEhrhfXMtBB7l0v?=
 =?us-ascii?Q?ucopIzoey86tGFlkaZpdsFRHWfchSXD/rqPlNE9qFTHe4AUjat5KRVSmga60?=
 =?us-ascii?Q?h33ZYQehosQjKH8oZTZ1/QK8yyV7IQ7j2MxvJmhDQ86L/tJTUuNKwhgrZNj8?=
 =?us-ascii?Q?VArQ1U6OdPUD1bwXfhFpvHXHvDP2Pi7pa2O/XtfB6FFMrPGzbxJbIY2JQCoz?=
 =?us-ascii?Q?VCHzmSotlr/ZOX5z8MkcHDMFSDaPmQ5APMENN+egSNoHGJ+AmxWPEp2hsnmv?=
 =?us-ascii?Q?e25Rg8pC4smoFBILzMHOaXXINBQVbh4aMi4rftIHpSoLTgFEOKTC9CZuK2X5?=
 =?us-ascii?Q?IYOmwmdvgmS1dy3AWT0FA8ZldYUyR45i8UeRCgx9N1Gm5gHhzN/Mliz6m3eq?=
 =?us-ascii?Q?8aO9jjt97XbdEWZNOn6jWSlRv0AY5NtSVwMTKTflj14YK11jqSVSF8mCOdsx?=
 =?us-ascii?Q?+gnpbsgiZVQRTZWXUg+15nsVD3FhStjXM17ivLIjkA/X4sybL3xyQtHozLGr?=
 =?us-ascii?Q?tvF0VNhqiDgBbOWI6MpyACeouY3hq50fOQF767ZU67O6sFHvSOpXTm4FQ861?=
 =?us-ascii?Q?jghdgAj/W/ys7BU7b5MbC7gXYoOvNIJuSUxXJ8Ci611Cs5V2/TUNX1ABIHbK?=
 =?us-ascii?Q?E1dBblO+IW+MQzK6mMg=3D?=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 06:49:33.7338
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8156dc03-6fdd-40ac-ac00-08de2b25a05e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6006
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251123_224941_149505_10DD5306 
X-CRM114-Status: GOOD (  11.44  )
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

Replace kcalloc with kvcalloc for allocation of the commands and
responses arrays. Each command structure is 272 bytes and each
response structure is 672 bytes. These arrays typically exceed a
single page, and grow much larger with high queue depths
(e.g., commands >2MB, responses >170KB)

kvcalloc automatically falls back to vmalloc for large or fragmented
allocations, improving reliability. In our case, this memory is not
aimed for DMA operations and could be safely allocated by kvcalloc.
Using virtually contiguous memory helps to avoid allocation failures
and out-of-memory conditions common with kcalloc on large pools.

Signed-off-by: Israel Rukshin <israelr@nvidia.com>
Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/nvme/target/rdma.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 0485e25ab797..9c12b2361a6d 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -367,7 +367,7 @@ nvmet_rdma_alloc_cmds(struct nvmet_rdma_device *ndev,
 	struct nvmet_rdma_cmd *cmds;
 	int ret = -EINVAL, i;
 
-	cmds = kcalloc(nr_cmds, sizeof(struct nvmet_rdma_cmd), GFP_KERNEL);
+	cmds = kvcalloc(nr_cmds, sizeof(struct nvmet_rdma_cmd), GFP_KERNEL);
 	if (!cmds)
 		goto out;
 
@@ -382,7 +382,7 @@ nvmet_rdma_alloc_cmds(struct nvmet_rdma_device *ndev,
 out_free:
 	while (--i >= 0)
 		nvmet_rdma_free_cmd(ndev, cmds + i, admin);
-	kfree(cmds);
+	kvfree(cmds);
 out:
 	return ERR_PTR(ret);
 }
@@ -394,7 +394,7 @@ static void nvmet_rdma_free_cmds(struct nvmet_rdma_device *ndev,
 
 	for (i = 0; i < nr_cmds; i++)
 		nvmet_rdma_free_cmd(ndev, cmds + i, admin);
-	kfree(cmds);
+	kvfree(cmds);
 }
 
 static int nvmet_rdma_alloc_rsp(struct nvmet_rdma_device *ndev,
@@ -455,7 +455,7 @@ nvmet_rdma_alloc_rsps(struct nvmet_rdma_queue *queue)
 			NUMA_NO_NODE, false, true))
 		goto out;
 
-	queue->rsps = kcalloc(nr_rsps, sizeof(struct nvmet_rdma_rsp),
+	queue->rsps = kvcalloc(nr_rsps, sizeof(struct nvmet_rdma_rsp),
 			GFP_KERNEL);
 	if (!queue->rsps)
 		goto out_free_sbitmap;
@@ -473,7 +473,7 @@ nvmet_rdma_alloc_rsps(struct nvmet_rdma_queue *queue)
 out_free:
 	while (--i >= 0)
 		nvmet_rdma_free_rsp(ndev, &queue->rsps[i]);
-	kfree(queue->rsps);
+	kvfree(queue->rsps);
 out_free_sbitmap:
 	sbitmap_free(&queue->rsp_tags);
 out:
@@ -487,7 +487,7 @@ static void nvmet_rdma_free_rsps(struct nvmet_rdma_queue *queue)
 
 	for (i = 0; i < nr_rsps; i++)
 		nvmet_rdma_free_rsp(ndev, &queue->rsps[i]);
-	kfree(queue->rsps);
+	kvfree(queue->rsps);
 	sbitmap_free(&queue->rsp_tags);
 }
 
-- 
2.34.1



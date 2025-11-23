Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D6BDCFA46B
	for <linux-nvme@archiver.kernel.org>; Sun, 23 Nov 2025 14:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Rw4C6ZmRID5roZr6cyo8AiByz6pgvQm4dkpBWA98uVo=; b=hj5PZJjHMRxoqDOGbn7dPjtyh1
	W/qYGKj0oDGpMBjnpuPJNO4+glJT7EzJoa9frTGX1Zu+ArKqaqeFebcUrGDbp9FWAeTIQgOXxs5Kh
	ksi1KDFwThGq53vIFwJwgHcY82lJd4jHMtOohrv1KFa3No2gLG4UY5LZ0bDWXNHfMY3Oc8vYAcT7Z
	TTdjZKvjDvJSgpHpcuJUEbjb89Kujp12rABoNedwfpSiiF0r8TVxogxzijAmmHRyyja5PJIa4VkZz
	NkPHguP98WmrLcs6hGPBlMBUA79D4InE3GB8ttKr29fnpBkuSiKe17EylSps7qmGOaV+VddMXa+35
	7oCMyYHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNBNL-0000000AUbr-3Kfs;
	Sun, 23 Nov 2025 14:47:39 +0000
Received: from mail-westusazon11012064.outbound.protection.outlook.com ([52.101.43.64] helo=SJ2PR03CU001.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNBNI-0000000AUbN-3M6z
	for linux-nvme@lists.infradead.org;
	Sun, 23 Nov 2025 14:47:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tb7+MqiOxX1L0V8UEmFKoO5ea9G8a3ouqnLu30fUQWi3nDu9z8rZIXRc0K1grUcnH89dlat7ekim6HEdg0cahlH7vr/3+6VB3t42oqUMMl1p4qcGbc6h/7k3PxyA1t1PFw1CaV2fExNG0kqDf9/yVIGEC9VZyuH1CVpXsMYjRXr2tkxIDxCCblFbXnLuR7ApMpCm8V4PDdYwgIJfVAPvoPHAbQaURAp7XgMVVJF7daIrqcTZSqaT/J1ebAbiY+DOKEA42xZGUPGJW9WRx3sXY1koPPKRFH+uHFl27NlZ0ramcVMPG4rgCiLeC1iaECgaKm9HcobljDkGiwE5zZZygA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rw4C6ZmRID5roZr6cyo8AiByz6pgvQm4dkpBWA98uVo=;
 b=VF7Wp2bWdUztFBdYFYhOsZnzO0nsk/nDeCTVRMDLwgNfQorODGcxRaiLEflTxpm9VmNJzpBRNPded3i/JN+9xA7+SyBf3OIAd9opFjoMVboP9vva88F4VeyeVJQsjteM8rgnHuwCco7e3eTn1HVr2Bk99iOD2bWNzYEdAFvSpF6J5cqq7oOl8oY4lrfJL0banjaYH7vI0KjCvj254+Jq6EKOn+G70UCWbGIbHHMDvDBtxOrLiUtAp87WSHeCHHzzognq0b2la+qwSYayAQLQjpgcS53AZUw6DMSalk11kMqo8Pg007U0OeyDEHEGaZsw9Mh1QD7WRBYkFmsi+E+xZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rw4C6ZmRID5roZr6cyo8AiByz6pgvQm4dkpBWA98uVo=;
 b=rgyn44TNgL0FdQw3fetAE/+RhH7kxrqQkA4QlOJnQT0IJt8HrVKOVSM+MHeNz1Ar5WZclG7w6YyFxVeMrAolhzmTrK0+JR3E6HJWL1hEAel2unOB8ZYDTvnvgGJXgl5d1hlT3WjjQ3nnZf9fks3NRU2nzzGUojqyU9wHq02lHKhpH66k+m2nElRcxWXJvy99m5ot8Q8I3N++3vWiCuWBI7p9XfVneeupOiwwEPdFE2A2VSgLr0RuRg5Uzzlm9uo8iNf18dqh57c6ZEOALrbvZoXwvmzdEoZBo23qjlQU+kiZzTRNxX2Mk7HzgFXQudy4yJZ3G7gEeian9uxYk4ybLg==
Received: from CY5PR19CA0120.namprd19.prod.outlook.com (2603:10b6:930:64::10)
 by DS0PR12MB8071.namprd12.prod.outlook.com (2603:10b6:8:df::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.16; Sun, 23 Nov 2025 14:47:31 +0000
Received: from CY4PEPF0000EE31.namprd05.prod.outlook.com
 (2603:10b6:930:64:cafe::83) by CY5PR19CA0120.outlook.office365.com
 (2603:10b6:930:64::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.17 via Frontend Transport; Sun,
 23 Nov 2025 14:47:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE31.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Sun, 23 Nov 2025 14:47:30 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 23 Nov
 2025 06:47:23 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 23 Nov
 2025 06:47:22 -0800
Received: from rsws46.mtr.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sun, 23 Nov 2025 06:47:20 -0800
From: Israel Rukshin <israelr@nvidia.com>
To: Linux-nvme <linux-nvme@lists.infradead.org>, Sagi Grimberg
	<sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>, Keith Busch
	<kbusch@kernel.org>, Jens Axboe <axboe@fb.com>
CC: Israel Rukshin <israelr@nvidia.com>, Nitzan Carmi <nitzanc@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH] nvme-auth: Use kvfree() for memory allocated with kvcalloc()
Date: Sun, 23 Nov 2025 16:46:48 +0200
Message-ID: <1763909208-11611-1-git-send-email-israelr@nvidia.com>
X-Mailer: git-send-email 1.8.4.3
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE31:EE_|DS0PR12MB8071:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e0779c7-71c1-4597-42b0-08de2a9f3ae4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xp6IQgHnDic7tzX7MSbP3H2RtDT4J0xhrPdJBebNPAAVsqGe5Li37A4DTgeL?=
 =?us-ascii?Q?hC/esc3KEO5A04Mtnl9X9XBxLQbgW280c1zwXqkBzmOT1OD/FhxP/uutvbUY?=
 =?us-ascii?Q?ub/D6Mi4PKppq/hOSzva9uOkq/LFdG9zpCsWNmVci4Bw76d3Eekm9jCSDK0D?=
 =?us-ascii?Q?5OAAiyg/QGPBKasDv8uSgVUOhMxa9U+WAz8nnMPtdleaUKZCSRJ7dTjqZiCR?=
 =?us-ascii?Q?16YR3RN7EmXUK8SCJlxhCah5WG/MseoKT1XFZX51brt/kSxIWjSbQcsxM19H?=
 =?us-ascii?Q?QFpGRIDIf9q+2jBQOBxfB2D8qj7c74JV7O4q/haUa7Zv9jO9OcH0yZY3+Gc6?=
 =?us-ascii?Q?vyIVFLz7oEtqiAKND4dDeSDy9CnhrqE9ibFwXcRhUFb0yb0j8xoP7UR08lL1?=
 =?us-ascii?Q?3CHb/+aJOH7oZUleJSi43hmFc79/CUJQeV9Xao3W64fByC3ttH3h2/g/8H+m?=
 =?us-ascii?Q?ytYa99Ce0HZ6IzUFPu3Dz1Z6RacDSGboTSUmoXSeedVqYhmpsw0pHqgQXkWR?=
 =?us-ascii?Q?6pAN+7iOv5ov8hroa7TbzZTrSjj67XPmBhgiHORiJFhPrqADPTKXvEKT4DOW?=
 =?us-ascii?Q?RIlWbc7ZxtcnZz+cMQ66HS9Xk1Hlj0QPpd/ts6CYKLd029OPvVUDUTNP3wbC?=
 =?us-ascii?Q?BU7oELRgpOcnY3NYZyJNO6yOSpotERmrYrdCuLPpDpOzqQXN+Z0YpM0vYa/U?=
 =?us-ascii?Q?EAlJ88vi9bMYI9jUs2ZxlNyhAUqgvIrk1z/n7prf24IiC2GJrAPVafndftLC?=
 =?us-ascii?Q?4QWNXYX4B6kuXG31bDxepKiMBRVDgqfboguPiZlAFTSk7+AYgRBtyol/eOeU?=
 =?us-ascii?Q?jv0i+o9YjYti1p1hCcrhjxPyKvy12dtYeRCx9AUBmvGDMYe4aaDoROiX1tqD?=
 =?us-ascii?Q?QV10xKCQi6HPCeIITOna7FUBzVWAviR/XCCRuWHK0FBVj5r3gj6CuZ/qYjq2?=
 =?us-ascii?Q?UdxMjARytaDvCx/VJJMOLWEdwSg+vGInxXzBkkPjeHx/wXg58EWpqUcMFOGa?=
 =?us-ascii?Q?fzR+r7FyBiu1VJkelFYBI8uojYDmw2twEVLEw3YRokcp1RHvQ/83CF83Qgvy?=
 =?us-ascii?Q?7QUnXUG8X8zY1Pz69EqXrVp0KPnzxwKN1Ih3OCJhlEw1WEO6nWFlhfG/lGFl?=
 =?us-ascii?Q?pn0vMU0dPl7Qicv2Rct+1zjLqwks+nLtseIyxs75N7RDJbDndHCalpO/U88U?=
 =?us-ascii?Q?ZIyZpFv99y/dW5eK1MCxpd7/n1WruReWNW6bYGz1nwIMyvoNW3F5DfSE8XsJ?=
 =?us-ascii?Q?GSCFVflOLD90OLAeFXomy4b+O+DSYJT+ohLXTdfsKxGQ+PuvXu+CjHnQMDM2?=
 =?us-ascii?Q?L9+eof0CvfwmhZCEZ5AUYmHgWAxjrQVexW8K60QvEOow6ZDdiSViB3TtOxgh?=
 =?us-ascii?Q?4qE3qp3DjiV7LblpWOObj5A0+7mmxDwu88wo9+AE027fTSiu7AntfGrR6cfm?=
 =?us-ascii?Q?g96OmxkNrnTmYLSg/p0U+3qFjlz2cqmkBUbktKDNlaoM1ZT6aPcXdz55+l0F?=
 =?us-ascii?Q?ltzzGzm2PraVlbCQApMlYuN2JxFfSvsC9QL+tLXDpIwMLC9Hu4MbZxVLNBAx?=
 =?us-ascii?Q?EU2BFoPcUd43kcHgUi8=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2025 14:47:30.8334
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e0779c7-71c1-4597-42b0-08de2a9f3ae4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE31.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8071
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251123_064736_874753_6568CB94 
X-CRM114-Status: GOOD (  10.77  )
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

Memory allocated by kvcalloc() may come from vmalloc or kmalloc,
so use kvfree() instead of kfree() for proper deallocation.

Fixes: aa36d711e945 ("nvme-auth: convert dhchap_auth_list to an array")
Signed-off-by: Israel Rukshin <israelr@nvidia.com>
Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/nvme/host/auth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index a01178caf15b..8f3ccb317e4d 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -1122,7 +1122,7 @@ void nvme_auth_free(struct nvme_ctrl *ctrl)
 	if (ctrl->dhchap_ctxs) {
 		for (i = 0; i < ctrl_max_dhchaps(ctrl); i++)
 			nvme_auth_free_dhchap(&ctrl->dhchap_ctxs[i]);
-		kfree(ctrl->dhchap_ctxs);
+		kvfree(ctrl->dhchap_ctxs);
 	}
 	if (ctrl->host_key) {
 		nvme_auth_free_key(ctrl->host_key);
-- 
2.34.1



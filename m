Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2961C02188
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Jan 2025 20:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=UWcaUtuO90zmn8faUf05SzR2dGWVW4kI1CTYtfGsZ2o=; b=KBcL+3bk0NvTv+HG/9QK8cBaAd
	hQVJw5PitI9sL1m9X/kYGfQyKLjObdkRmFKqS/wZpWRyAWqLZj8udTy5knuCJoNiGr6PmkuVp9cxb
	gkNCdOwyYzeTQW60mu5ySmS0KM4z+gySna+nrR4HKwKwo/8kMM/nwEjUvrTBMuag+WK4PUfd3Xtko
	nN8YXeJP0Z9vIEwM6GUeurrWhraSabXJSaCExgGtTSrPMioMhblEfOWMUapQY2RBQYdXLrynupXWi
	7aKRv2644vJspVRUXnirqdB0xYEedlyxceaePLxBti2rmS5HPAEovxX7dmwEXOLlKg7Uq15ENzzUJ
	F88OG/Mw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tYWKT-0000000FzT2-0Ny8;
	Thu, 16 Jan 2025 20:19:01 +0000
Received: from mail-mw2nam12on20624.outbound.protection.outlook.com ([2a01:111:f403:200a::624] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tYWIs-0000000FzDi-2Dx2
	for linux-nvme@lists.infradead.org;
	Thu, 16 Jan 2025 20:17:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UuKzLsiOevuiWVQ+mm5G0XPZzHaO1hPgW5cFL1rDjaHaLWrhH9veXds7fr93ojeCwaI1vjGEGAxlOR6rk7ttRKHFUMsnG4WsOhu0UXlgA9O9XSaJd5XXXnzzIoNtmizJuKsfoLkbhPTBd3KAerJlS4SGSREwu8nZxVsLZq4zPMQqwSKXCBmkH1k0u1zglDjskJElxfKz448EbwgrWb/PcU6K7uDK/YBFLcBZ8LYCKHeLD5GvMzuxH0v1CEzAufSwpkL0Gw0i7nxJCmzM+3sTOhRUNkMSzzpUSrHGsMPQnRKRGbiSfuaTWDYT3JmIYt5G3s3CxKlb2CVZF444ZIZMcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UWcaUtuO90zmn8faUf05SzR2dGWVW4kI1CTYtfGsZ2o=;
 b=ZnUFpXJ+HveaOtK3NtSXKOGOfGXh6enHF4K+RZok2o420O7wHREMCgyWXR7CMmmM1XAgoktAR0huKVJGYXr1TOTx/IGWuApDcQxfUm59yEB16jEyF9sj4ZmQq0s5rWsTOBZIaXSht4+v5kENf4Bh3YAqsqjjNYO4hMydQeogOnW1CeCWk6ZDG8i/cpTQ4MkYKdwQ1TZGMhu6fDcBAlAJrtVn48vbRBRW2XjTYBA/Ym/LTIv/C/Hm7Y4E8a6l30g5Evz7w5Ic6ezw4HlpbxrvqBYTw54quVjvb9AxCeuxItRGWQIBCveFQkZcZaTzWMIeNMqj3zwvnf7pr4mpqU3P2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UWcaUtuO90zmn8faUf05SzR2dGWVW4kI1CTYtfGsZ2o=;
 b=O/23ktz6oFz0nC7LF6o7wgUikM0I8iiJUVkZArhUNRevrrqRUQ2kYXY8KwxICe5IpStWQ8L91amsCY4fP6H+Eb4LI1pvht8syE1nNDaNHBCEXUiTfqhUrSTjA33aAKXTqpuxgFe/jhD2ynqNG4ACDFKtL6IPY8iSM6sMQNJxlVZ90hExCa2/JuTz3SDwrOJ0ZbufW5kdMawC6NCCV3vNVsULVCQOnCXLy43zlNFhwuE4dgLzYRgQCns4ZPW0cxojyQxwMOTqu8DfP/2GcjBt+CDdAgZPMjPBBivywtjQkLqC7TtGweMlKYOGPkjut2r426sgy4iyDGTnp6+58JxWfg==
Received: from BN9PR03CA0759.namprd03.prod.outlook.com (2603:10b6:408:13a::14)
 by IA1PR12MB8359.namprd12.prod.outlook.com (2603:10b6:208:3fc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.14; Thu, 16 Jan
 2025 20:17:18 +0000
Received: from BN2PEPF000055DE.namprd21.prod.outlook.com
 (2603:10b6:408:13a:cafe::a5) by BN9PR03CA0759.outlook.office365.com
 (2603:10b6:408:13a::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.14 via Frontend Transport; Thu,
 16 Jan 2025 20:17:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000055DE.mail.protection.outlook.com (10.167.245.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8377.0 via Frontend Transport; Thu, 16 Jan 2025 20:17:17 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 16 Jan
 2025 12:17:01 -0800
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 16 Jan
 2025 12:17:01 -0800
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>, Chaitanya Kulkarni
	<kch@nvidia.com>
Subject: [PATCH] nvme-core: decode the error on add disk()
Date: Thu, 16 Jan 2025 12:15:27 -0800
Message-ID: <20250116201527.9252-1-kch@nvidia.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DE:EE_|IA1PR12MB8359:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d74c5df-66cd-4223-9a02-08dd366ac654
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+D6KdkEWugblq7QJhUZwHepgTWXLX9dJanZt+0MvtzZlOXsp4du5bW+0ZBAK?=
 =?us-ascii?Q?INtkhCMeHR6fXRDkkxLrzXHAlsHWMZoj4jdJwTytpBeuzxFFk6pDUxuz0SsT?=
 =?us-ascii?Q?cvCog0D9NX1AKpel1DIIiizegIBsw0ABgfURlbclFcWtZOx+1Uab7yVRzJPl?=
 =?us-ascii?Q?k4zAVtgMGcS0+Mlg3+lp6xX2wXvdupvAGoDPsJe661hrzAwx0yHfBDx1d4K5?=
 =?us-ascii?Q?MIqwZEle4YfevwpgNaZHLIUXzzWvCiNttyDdtS0hJVyWxRmM8+GcuHmMvuOf?=
 =?us-ascii?Q?AYMF/ai48avgdBuTICsO8I0R5BS7YgWi3SmjWWBMV0WW3uXPHGwUvBd1qP7a?=
 =?us-ascii?Q?Tqjy6uQPiTtQ84PJTVIimD8j5YXi9X7cdEM4VNG67Ts2YWz4HTEd/c1QLpOe?=
 =?us-ascii?Q?9RcjPaExEY3DvIWZa1d4P4fEDEqDnHqIQqC91O6WSkZboa+48VpXKTXVYqtM?=
 =?us-ascii?Q?YakoUGDqhxXyGPbrmLwXnwqrAeraj4aHQh095MtZz/Z2sRHHRzLSI0e50Tq+?=
 =?us-ascii?Q?Z2h96O44Zh5FbK1+Qu0zZB5aI6THcPacQfWF63YpkT9u7V/oqzcTh7lFSQsO?=
 =?us-ascii?Q?1N+3NiHcWw+31ZsrqrYNFU6xeKCK4n8fNCHNkSWZpwVN5daN0bRONAe46rr1?=
 =?us-ascii?Q?q8FEP0JfH976AcJ3HWqO8cMiAAyFSqHAoToHubLY9AL8XeL/h+5+e6QZevmU?=
 =?us-ascii?Q?r8Wf1FBXmS0UfeUQa/bp3RtbklelaMhFGkU5DKcNthXw+xQBjA6sgxe5Sb3h?=
 =?us-ascii?Q?W2zKe+7tnMu0C5DL0BkYdCa2MDXlOGVNlREvwbDBz6f3lzVOBJYss4iurTnI?=
 =?us-ascii?Q?JfmGJyXb1TQXCpy+OBOHoa8p+WceXeWbsHwAMslI+fehWUkcT8M/ow84RXz4?=
 =?us-ascii?Q?0OAcKhfhHTV024z2NnEic2shnbLOHkdLQR0Vkji4OFT6+acbld4yQ0ohf9/E?=
 =?us-ascii?Q?JUBTj0XByfwDJTSibgaQ4JCRUdVHrrO25W16b8wrR8+WCpV5ugfvG+9Y9kFX?=
 =?us-ascii?Q?WMess4I6obrSJUw5MqacHfTcJIoMdYZAAclydxUF61aYCOiOk36amrfvVgFR?=
 =?us-ascii?Q?PzlxLqWdw+r4VeFkFYAuqVMCPrtppx6fqQiHeqIlp9mRAWjYhNecpLjk04Tv?=
 =?us-ascii?Q?g0V/ErpWNGmeCUPHy0p9CV31FZNyoTeF47dg9/ZEQNEF6Z/BLL7darEtKKSi?=
 =?us-ascii?Q?y/nP1djtilo7GpSbOt7o0HmZwIsZK02DxwmHC4OareXU4/EfHw44rtzkCnUI?=
 =?us-ascii?Q?4C5N03mK1pPXwPsn0RaQVreOhRZbkBccdGsTKi3XgWgVBqEM+qN8H68iS5Gp?=
 =?us-ascii?Q?RG/4UnF0uNobdUpXzGbdu4hmKntnlxkqPUYeYUSUZDmUJchIHzz7J7pe3EYK?=
 =?us-ascii?Q?BfUcvXA0eDbuzhbsb2nvB8nD8Iqf0YyJG6D8ASNCV/oiD8Ru0tmDHAXDIpRV?=
 =?us-ascii?Q?b47yp3/EXEXoA2ndhbc6mVdn7vyIZ8mxV19BBRtrvlj70XCf1D+CS0fUlrr1?=
 =?us-ascii?Q?RgNPxkSDdmJ7UGM=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 20:17:17.6469
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d74c5df-66cd-4223-9a02-08dd366ac654
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DE.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8359
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250116_121722_596415_5206222A 
X-CRM114-Status: GOOD (  11.15  )
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

While debugging the problem, it is important to know that what exact
error returned by device_add_disk() along side the disk name. Print
the error along with disk name when device_add_disk() fails when
allocating the namespace.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/host/core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 2a0555856795..0be42f9b86b5 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3868,6 +3868,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
 	struct nvme_ns *ns;
 	struct gendisk *disk;
 	int node = ctrl->numa_node;
+	int rc;
 
 	ns = kzalloc_node(sizeof(*ns), GFP_KERNEL, node);
 	if (!ns)
@@ -3933,8 +3934,12 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
 	synchronize_srcu(&ctrl->srcu);
 	nvme_get_ctrl(ctrl);
 
-	if (device_add_disk(ctrl->device, ns->disk, nvme_ns_attr_groups))
+	rc = device_add_disk(ctrl->device, ns->disk, nvme_ns_attr_groups);
+	if (rc) {
+		dev_err(ctrl->device, "%s:failed to add disk %d:%s\n",
+			__func__, rc, disk->disk_name);
 		goto out_cleanup_ns_from_list;
+	}
 
 	if (!nvme_ns_head_multipath(ns->head))
 		nvme_add_ns_cdev(ns);
-- 
2.40.0



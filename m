Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB189CAC5A5
	for <linux-nvme@archiver.kernel.org>; Sun, 21 Sep 2025 00:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=D1YAcnhz2DFEcvZypuVt9N6USJ2IjKWYcTDjV1qBMZc=; b=YIJDwn0gH+vfCFKhB/GLMq8OHN
	xTtrCpHoTcFMVV1iM0rBn6BsUZxkwG0fNVXODyNQdRUBD7rIrlcNWFTw6w15K4GVfkuuCaNqpoy9C
	WFMjN5Ldk7NJ+DMQUtIbRRdvUSqxGoHaVXdsJcNzETWiLSKQ1iiL1yBx3YEJ6B0RJ24HvuysCCKhQ
	IiN0NvoWoc3xn/r7CoeDjrEhBLE0iTCXJL6gpovscQY+JATQQyC0G1O9rkTHMKLOZRWG4Hnn16889
	S9vB7srf3pM1gQ6Ij9tBLfZWcsRD1lfYbVzXXm67BYRcyPHu6IJuuIUHu/uejn6vE5YWl1HoiwfBM
	ipDYocgw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v07dm-000000066ua-1mmR;
	Sun, 21 Sep 2025 00:09:18 +0000
Received: from mail-northcentralusazlp170130007.outbound.protection.outlook.com ([2a01:111:f403:c105::7] helo=CH4PR04CU002.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v07dj-000000066uF-3mR3
	for linux-nvme@lists.infradead.org;
	Sun, 21 Sep 2025 00:09:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e0ZSQeGz1/lppYWdpE+V9Ws3lY671Ev5Lj2RNn/UWE36jJrhilwdSJXHstdB9aCX3UouMo8V7lkdybNimIa82VVAux08ZVdVXr7w7wwMxC4qTCsDLHzD3gebO+Ew6WP3z6dRhiNpbgOrfwgZE2f5+oBBWF0llFhIl/Oj+wFhLmT2N/8gTEO9efiUW9aiRXDq+KrhHNYi7E85mDhynKP9y62neC0NE5Ck9CBXrUTCLkTifjWbfBFae2NQ41xW4vrmBZz9mhNdBDq4YDpuS7X7gcgI8zdhcvoMKEX9C0I3WBF+ybdKAo4WM613OWr9oi4yUgJrn0QZQ5PxBM9ARjqO+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D1YAcnhz2DFEcvZypuVt9N6USJ2IjKWYcTDjV1qBMZc=;
 b=Aoz0GBNrbqLmgpzivkJh0SoPE9nuIH4RwJGTo9H6KemIchP6En4fdQNWHlsILdvsgDE7I9Cw47HFEXtwqzeyabbND8WmwlKM+p28J46te7j0qlxLNtYPwqomyzPpOLGKxRdeiFVX3YnD6exbql9VMgaOLsVfsqeyfF+AUj1q4EChHyC2jFLMb43TZhY+eZ+KgvIYMWbKRctkD0IeZAK/4YX+d4gy8uAe78Pp6yEAerAkWJZkZrnsneh9YvftgUd9ZZsMyXt6esC9c86VHuI7yMdM8clYzi9ZQZe0+GdNun71CWpjizrtMBTw4izLNa3mgZ+MqoMqsu/E5grww9cZHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lst.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D1YAcnhz2DFEcvZypuVt9N6USJ2IjKWYcTDjV1qBMZc=;
 b=hKMTPqIgLpCCnSPs5oxAJzpoDkf0/hGPowHD8fBAG2VVmlXFdVyrm2be0sK0ajbiagCqCfwTF6y4XnouAmgXtrTOXiqleBOfSrjpnfZTABfngwHbxEK+OmrWA+LwcDCBVNXtRT71X2PE6nxg3yCpftgHJOvhQLWeM92oh/k+Owjne1lnD0LV1e3HuZj/x1ivO2U6iSXu+sA13qd4vUgl9WTYi9z1V+Wifz4VO7fwnfxrhLM5VkPNu+KQUiqHTlfeWCaYTsW7nD/5Ja505MszRpB54EjTIOM9zDIdDR+XMEC11LXe/0V7nydHEN6lJdwTVL+TNBlWmpdPgfI+ThZ7Tg==
Received: from BN0PR04CA0025.namprd04.prod.outlook.com (2603:10b6:408:ee::30)
 by SA1PR12MB6947.namprd12.prod.outlook.com (2603:10b6:806:24e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.16; Sun, 21 Sep
 2025 00:09:07 +0000
Received: from BN2PEPF000044AA.namprd04.prod.outlook.com
 (2603:10b6:408:ee:cafe::c4) by BN0PR04CA0025.outlook.office365.com
 (2603:10b6:408:ee::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.19 via Frontend Transport; Sun,
 21 Sep 2025 00:09:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000044AA.mail.protection.outlook.com (10.167.243.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Sun, 21 Sep 2025 00:09:06 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Sat, 20 Sep
 2025 17:08:56 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Sat, 20 Sep
 2025 17:08:55 -0700
Received: from r-arch-stor03.mtr.labs.mlnx (10.127.8.14) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sat, 20 Sep 2025 17:08:52 -0700
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <hch@lst.de>, <linux-nvme@lists.infradead.org>, <kbusch@kernel.org>,
	<sagi@grimberg.me>, <kch@nvidia.com>
CC: <israelr@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH 1/1] nvmet: add safety check for subsys lock during nvmet_p2pmem_ns_add_p2p
Date: Sun, 21 Sep 2025 03:08:51 +0300
Message-ID: <20250921000851.13975-1-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AA:EE_|SA1PR12MB6947:EE_
X-MS-Office365-Filtering-Correlation-Id: 8afdfff9-8daa-42b1-b131-08ddf8a314c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?y+T9W0xTFioCT12HUYbEoaOH7Iu16kYQ32BeY1YqrsDeK/ZEHyWRULW2iT2/?=
 =?us-ascii?Q?ha9FOuXP0CHYSznZsvBA7oTzz7WU8x8lSZmyzPpdBUoDaz0oN77Nzw8C3M8u?=
 =?us-ascii?Q?eIuRMpu2ZWALl32GxZTKLvCP6kAdmH+0pVyOO/S/uRZjykkWjoeo35jfyS2f?=
 =?us-ascii?Q?5xB9aCR0gaDm9HZ46Xk0pahvEfpBqCIisaFCaNLuzJ88T8yHwQ2bq3c8l0gf?=
 =?us-ascii?Q?zz/KbuFcqPIoohys4+DakdonKAG/LIU6FjKa0b2F0CfYKkP7c374qSnZ6bhT?=
 =?us-ascii?Q?2UywyqZi3sLfA7wakI+IN9Yjk9rUd3djW2M6/UPjMW/4SMnjtrnUBtWWkOCc?=
 =?us-ascii?Q?vZw/HDQidY3Ys0CvtlaT+ZuXIcL3sWXHNsUa/HFdI3G+EFfSPHBBpF0C3ULE?=
 =?us-ascii?Q?Mlru1/+vzaZtmo/Qq80xnaaOyxV+1K+5yHNVVYrA8YU0EMNqs1lvkQFHRY3b?=
 =?us-ascii?Q?V3BytsoS4E9b09N3jECA7b8HfVczK/yqQ+HRJD0JbM5gYF0hxO+tcM9kS63m?=
 =?us-ascii?Q?BuMcGksvpE3i5OkwopEDL+AMeNaAS0y5SbVmg/0ausvK6fQ4l44eFV9ULrHx?=
 =?us-ascii?Q?z+yBMgupRMrnchiy7FWIAP7l9jLiFiqwURVGqN2gBX1ghwiMti11E1EZE6qt?=
 =?us-ascii?Q?jSNoim6cq4BtgLlermA1hkLa0YdXZbzzUJLts+zX5JNYXND+zLSTLoLICzFU?=
 =?us-ascii?Q?2HFH4YKMbjPuzspkqcbv3tDL3nU6rsV4nDSFn+qQSZCL1gM8G8i0BlxbdXTJ?=
 =?us-ascii?Q?GNVGell50qmcfTJ7sqqzL/q7F0U0wro6opYOI/07DYpByCyKS5hUd5PPtZNj?=
 =?us-ascii?Q?sQUEXyImDcV1NYmCfm6mY4u1Fg7nTM4TVVZfdCAT/AK5dCVgr1jeCjz+NiKD?=
 =?us-ascii?Q?uHCZsAxys5AIhDs9cCvmPTCZl7Q3lFeavjpARbABNChhhbFKb9ZbiIA0eOk2?=
 =?us-ascii?Q?waImPjf4ancSApfLdCTauorE8KDE5JBHvK0KE9pl6lyZUlDHkeq0WPfC57Yt?=
 =?us-ascii?Q?v7QkqOqmcMQk7/NF9fTx26TCtLtMtMY52e5vXT9uPsBEikCod5lAuYWmNjjv?=
 =?us-ascii?Q?gE6u7gV3bZaqsRCJtA39GBnh95Qa7drs7fkVRm0WqSPwHMY0EuV63oCi8xq8?=
 =?us-ascii?Q?LS5pbVDUoU66z3PXHzTJvnxQhcOIqRL5XQYNjUSqD/tnuxMCDSsmceMKNKb0?=
 =?us-ascii?Q?IcdAuxWQ7yzbK5puBqTB86+eEZGtrK+XpzgT1XCkMnycWhnv5sWnuA9yDAiB?=
 =?us-ascii?Q?7jl2GhKSzRYcgGt2pSaViTEuPOkHOsvzVG/5ebDCw6lM6zmuo49eJQ71sy6q?=
 =?us-ascii?Q?bTVObtdcuaEa6QM9FHM3nWyjEwNQIDGLeTT5ne16NoFOojnu+05QfFqs7jsg?=
 =?us-ascii?Q?DXa3pd4aW3TF0fuj70UKhVdRJ5FQVjar/EwKx2llC30PwuVEsElBXxKtuhSZ?=
 =?us-ascii?Q?e9DPUQdUYCxNH0+MLfh4Mgcjoq/4vCwTmDid80IZoKxoGv5wxEowACrHoNeU?=
 =?us-ascii?Q?MderD+LLosuiNSF0a1QDePX2mLY8fANGPVla?=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2025 00:09:06.6602
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8afdfff9-8daa-42b1-b131-08ddf8a314c6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6947
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250920_170915_946191_0F0BC6DC 
X-CRM114-Status: GOOD (  10.23  )
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

Replace comment about required lock with a lockdep_assert_held()
check in nvmet_p2pmem_ns_add_p2p(). This ensures the subsystem
lock is held at runtime.

Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/nvme/target/core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 7ee12819e2b5..79104f5ce40a 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -541,9 +541,6 @@ static int nvmet_p2pmem_ns_enable(struct nvmet_ns *ns)
 	return 0;
 }
 
-/*
- * Note: ctrl->subsys->lock should be held when calling this function
- */
 static void nvmet_p2pmem_ns_add_p2p(struct nvmet_ctrl *ctrl,
 				    struct nvmet_ns *ns)
 {
@@ -551,6 +548,8 @@ static void nvmet_p2pmem_ns_add_p2p(struct nvmet_ctrl *ctrl,
 	struct pci_dev *p2p_dev;
 	int ret;
 
+	lockdep_assert_held(&ctrl->subsys->lock);
+
 	if (!ctrl->p2p_client || !ns->use_p2pmem)
 		return;
 
-- 
2.18.1



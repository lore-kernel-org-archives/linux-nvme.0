Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DFF9CAC5B5
	for <linux-nvme@archiver.kernel.org>; Sun, 28 Sep 2025 11:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OIw9a4hC5dMKGV3eMkOQXqYUAGeHb/beB+O126QLNpQ=; b=Fc2IydJsndakNNIFutTmmUd4At
	oJN6AvxBPREOcQ37Jss27NgyU7oFIDMXy89fOrn7T4MxxtbkFlSdwe2oyy4Wkf/kL3POmLzoKbMWT
	j81iBX270hAUAHxE/KOlXkfihf2O/HxPyd3SeycWiYs7gItfVOxIfu9Yrje/euIxeMKQdJS0qWQLH
	HmG1oOd2/RKI58Z6ZAkRY4D7w9VRUqJ1/AIRmZmkH3D0LjdW7J8S8jyD+x8AEFqDZtbQZwTWtbYkJ
	2kgMjIm+GWhMxuQsI5rzEUfvfzFCVHD3ZH4W5xkR4UfmpJ465LFIcRJX19LDJIQqxpWgl6904OXJf
	MQ85DX5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v2pwS-0000000FJrI-24Er;
	Sun, 28 Sep 2025 11:51:48 +0000
Received: from mail-eastus2azlp170100001.outbound.protection.outlook.com ([2a01:111:f403:c110::1] helo=BN1PR04CU002.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v2pwQ-0000000FJp4-2Lij
	for linux-nvme@lists.infradead.org;
	Sun, 28 Sep 2025 11:51:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AQn4sAliMo2/epz7dszuZx9bQsxZ/ukOSPg+HXW6WIZHym/1h56Y0JvaDusiQ6Q42l+WaPVODD78yvJaEypmQf2xsnpWqTz0tAbzJ4li5rRZVIHbvMd+7HvxFm9v1Eh2mWdZaCVnP2BO3WtTNlRw8n/2Rt4100MTmlecIN2RXj0ygF06bSY7y1J33HcncxEJlkgBkFE7muJECT6hj0WxQk9pM4065LA3yskmX1hNgxOi9y0bBgwQu2eoaOjmNngmlEIize9p0hpCfLlCmSc8uI0HIDM/+Ll4ocpegLIcLtGlnTH1Yd0QOtYrT2JvkkqD6r5uvtUMMAFE8eo1uF4dyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OIw9a4hC5dMKGV3eMkOQXqYUAGeHb/beB+O126QLNpQ=;
 b=dC1KcifPBmLHQgUhaqCBOCJG6LEnr9bVxRfHNFMUHbeBzYZMOaMfam52rEYYkae41UWwna75wkJXY5v0gsY/kqEpebJo0T95SgLB3d85iH9AE83eFIiM6D+Y5VDMCTtxvXMdm7p8tkcFOeUfHcYugL+oOgU4h7GIQVv/LMyQDYrUweiG7S1oC20dIKJVWZMCTGL3Mv81DMNvdflIwYVTLHAlS/N0XxhulvU+8fj48ao+2YqkaaVSPjI2GE7A/H43ymCYpeRd3e/dxZin/1YBBhDYkklXLI2nCLhrp1CH9Y7szOf/ml2qi2JIAVd502Q0aD++0V76mwLlB3PlG84wtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=suse.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OIw9a4hC5dMKGV3eMkOQXqYUAGeHb/beB+O126QLNpQ=;
 b=mw90LM5NNZh72mVcuAnk0f8+qnqoFgxR5m9nahNvrqvjdXy96dv4E9Hvyn5cNkmd6+7feA/8Ft35UAGnncLwI1J6Plco8TBEpovRm3dO8QnpS4PnQo+u2tMxUaihoN2pH2MJslxwcPBIJn5i9S9TWAenwaGQwxmiVmMUbl1KcQNAMmUlp/0fP/IytA+N7ozyNfgy8yIIXlv3BSkuBS9KJ2ozZAddIEVetwx4VEB0o7/a8h8o7eXioYnCfO9oEAW/LrUwX1oyfb/vkpcE47b4K/XAfZqUGF7gBUIEX3aoTIz27BAedc3ubGaewjwNXV7FT7Q7PxhdFKozZ6upM6kHWg==
Received: from SJ0P220CA0025.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::16)
 by SJ2PR12MB9241.namprd12.prod.outlook.com (2603:10b6:a03:57b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Sun, 28 Sep
 2025 11:51:36 +0000
Received: from SJ1PEPF000026C3.namprd04.prod.outlook.com
 (2603:10b6:a03:41b:cafe::46) by SJ0P220CA0025.outlook.office365.com
 (2603:10b6:a03:41b::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.15 via Frontend Transport; Sun,
 28 Sep 2025 11:51:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF000026C3.mail.protection.outlook.com (10.167.244.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Sun, 28 Sep 2025 11:51:36 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 28 Sep
 2025 04:51:35 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 28 Sep 2025 04:51:34 -0700
Received: from r-arch-stor03.mtr.labs.mlnx (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sun, 28 Sep 2025 04:51:32 -0700
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <dwagner@suse.de>, <johannes.thumshirn@wdc.com>, <kch@nvidia.com>,
	<linux-nvme@lists.infradead.org>
CC: <israelr@nvidia.com>, <shinichiro.kawasaki@wdc.com>, <hch@lst.de>,
	<kbusch@kernel.org>, <sagi@grimberg.me>, Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH 2/4] nvme: add support for mlx5 RDMA devices
Date: Sun, 28 Sep 2025 14:51:23 +0300
Message-ID: <20250928115125.38383-3-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20250928115125.38383-1-mgurtovoy@nvidia.com>
References: <20250928115125.38383-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C3:EE_|SJ2PR12MB9241:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a8010e5-1a17-4077-37ce-08ddfe8560f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5IJl4uL6aSRk/I/dfGzLrs2nq3KMkPE7cb6GXVhr6WLRTllJhfsaT26r8TZb?=
 =?us-ascii?Q?Ql2PAUHlxAcBj8ikzizscDZZaAvpYnqpUSWsTk0hN4MJhY+FSIst9Gntw6yz?=
 =?us-ascii?Q?1It/Q3J0zPToW3FTKII7dCEXX75l/AsW3eiCcwgf8kvs+NwPGZA8GFzQ6Kky?=
 =?us-ascii?Q?tQK9gpZsJfyq7J9bjS02es0rwiEFqQDicwswJDldmhFAyelblKh+NpXMeOA5?=
 =?us-ascii?Q?y90mYH0Vb27/OHXtOS+nKq0VWAeCfyINn4QUZ7xhChaHDkeu999VIFWdtYiz?=
 =?us-ascii?Q?9lEdClMeSPqDkkXWeahPYLAavhcdp5QpGY6MMnBF2s8HN7PAD+osfyejkWcM?=
 =?us-ascii?Q?1I98XhcUXSUj9LsP0YnkeVaGO1XYJ+uyHXukQFif4qrH4k5fVhNLEjf4VNuJ?=
 =?us-ascii?Q?P834PrlV5sV6gM16Agqn9DhlTc+s8V8tiVLKU/vsr0u5QEBdKFjLxjdcmz3m?=
 =?us-ascii?Q?azocYKbymJiauAy+fLbd0kSkw7fL6VZacRdF2BYq6mDAxvvw6OehuE7ymbGj?=
 =?us-ascii?Q?B145d3+tU+mT3AJzFo+sKxyP6u8x5rKWC2Gr3AGuqYgpsMedVI7Rq4FqMLjp?=
 =?us-ascii?Q?F8TpNo/fPv70c97pibvVbFeeVfu+drw7JEcPSYdAAscskmbbvdyM7GcWqRb+?=
 =?us-ascii?Q?wU0r+WEbhKgzGuWYnmHKUUF2OVxkEx4YmIFLCBt54UrSslIbUQ4PYlSSOJKL?=
 =?us-ascii?Q?2EDAc+jG6Y4JhjBqKj4jvWdBaPp7Lu0AyZ3K3gJ5h8Qc6HmFyQjxoLoLUsNt?=
 =?us-ascii?Q?aLdvBFRim7qxotYVbn8qEzu20eD4uH5Hf4XF0sHxLl9SIfIV0akynDY5vhXU?=
 =?us-ascii?Q?z3ECeVwqYs6z7TPSxOSehFyclp8A7Jk9ycZZZnQ8FGZjYXpz/9Pl6DqnV+ZH?=
 =?us-ascii?Q?lp+C1SOD1LhCwoycd5qTY1nTx6JmLtPzMJGwFFPU5l38aj6JiN3kBa1h+G7w?=
 =?us-ascii?Q?crXYLgUdW1R6chgskPY6eqqBAKWV246txcYLfm+X489mOcFQRDSdaGfVnOWz?=
 =?us-ascii?Q?nU9Mud+D6g5mJ6Ztfv5YkEimmoaJm+ynEDsXYI/y/1OrQ8irdR/4K6lPtEl7?=
 =?us-ascii?Q?EHKQxQs2fON2qjS2hOTUfNrTACrMDyfxQqXlDJXlbu0OAJO0ZGegKhxiAdAr?=
 =?us-ascii?Q?ZQwrhr3+dK3bykT73JS5c/RYLwoSfVwEPNB/6kE3azufwOuFU2vjjUzvpzRg?=
 =?us-ascii?Q?8h5/EmEyzd+8fo2sk0tiZfG+pDFn0s3pPc+/VSczMNIJYbzfQ5ku5d7oKlRt?=
 =?us-ascii?Q?in5xjC+p2iJGm5PLzjb135bQzm3xKJP4JrWM9NJnJNgQK1yiijTychVAUGyZ?=
 =?us-ascii?Q?b8q3p+/g8tJAxEVAu7vUYiDn2tcIIsCt/eoqjMZBy9RJ62PfFU14BXZKV32Z?=
 =?us-ascii?Q?AWMCOng3fUr/JovpTtHww/pihsTHmtA9meupJxmB28e0fyY+t10yomdO5syV?=
 =?us-ascii?Q?Q3S6SFZBr0KA1B4cyOEZjI0m6SkDhY1jWbfmuKaseG4BQJ3cgiGEZL9RKVkg?=
 =?us-ascii?Q?fD5H6PuhizFYshC0Q0DiXNNw82zA6F6ejaZ4XRFQ2Cj3VaQdF3jz/oB4iocb?=
 =?us-ascii?Q?R1mGFmwrNOVD090Ksc0=3D?=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2025 11:51:36.7223
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a8010e5-1a17-4077-37ce-08ddfe8560f9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9241
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250928_045146_605089_DBCFB11E 
X-CRM114-Status: GOOD (  11.94  )
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

Until now, the tests for RDMA transport were only supported on top of
software RDMA devices (rxe/siw). This commit adds support for running
tests on top of mlx5 hardware RDMA devices, allowing for more
comprehensive testing of NVMe-oF RDMA functionality.

Prerequisites:
- RDMA network interfaces must be configured prior to running tests
- User should set USE_MLX5=1 environment variable to use mlx5 devices

Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 common/multipath-over-rdma |  7 +++++++
 common/nvme                | 16 +++++++++++++---
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/common/multipath-over-rdma b/common/multipath-over-rdma
index e157e0a..9367662 100644
--- a/common/multipath-over-rdma
+++ b/common/multipath-over-rdma
@@ -98,6 +98,13 @@ rdma_network_interfaces() {
 		sort -u
 }
 
+# Lists RDMA capable network interface names associated with mlx5 devices, e.g. ib0 ib1.
+rdma_mlx5_network_interfaces() {
+	rdma link show | grep mlx5 |
+		sed -n 's/^.*[[:blank:]]netdev[[:blank:]]\+\([^[:blank:]]*\)[[:blank:]]*/\1/p' |
+		sort -u
+}
+
 # Check whether any stacked block device holds block device $1. If so, echo
 # the name of the holder.
 held_by() {
diff --git a/common/nvme b/common/nvme
index 3d43790..01d054d 100644
--- a/common/nvme
+++ b/common/nvme
@@ -218,7 +218,9 @@ _cleanup_nvmet() {
 	fi
 	modprobe -rq nvmet 2>/dev/null
 	if [[ "${nvme_trtype}" == "rdma" ]]; then
-		stop_soft_rdma
+		if [ -z "$USE_MLX5" ]; then
+			stop_soft_rdma
+		fi
 	fi
 
 	_cleanup_blkdev
@@ -243,8 +245,14 @@ _setup_nvmet() {
 	fi
 	modprobe -q nvme-"${nvme_trtype}"
 	if [[ "${nvme_trtype}" == "rdma" ]]; then
-		start_soft_rdma
-		for i in $(rdma_network_interfaces)
+		local interfaces
+		if [ -z "$USE_MLX5" ]; then
+			start_soft_rdma
+			interfaces="$(rdma_network_interfaces)"
+		else
+			interfaces="$(rdma_mlx5_network_interfaces)"
+		fi
+		for i in $interfaces
 		do
 			if [[ "${nvme_adrfam}" == "ipv6" ]]; then
 				ipv6_addr=$(get_ipv6_ll_addr "$i")
@@ -1180,6 +1188,8 @@ _nvme_requires() {
 		_have_program rdma
 		if [ -n "$USE_RXE" ]; then
 			_have_driver rdma_rxe
+		elif [ -n "$USE_MLX5" ]; then
+			_have_driver mlx5_ib
 		else
 			_have_driver siw
 		fi
-- 
2.18.1



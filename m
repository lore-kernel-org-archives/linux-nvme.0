Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FC2ACAC5BB
	for <linux-nvme@archiver.kernel.org>; Sun, 28 Sep 2025 11:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Wg1HWS2oETt2xtZGwMXugdEWXEPcYBsySMkH4UtltAo=; b=yHFT7zPpJ07QL1UcHzjcQwBJC2
	Jvssk7QPdoJizMlSDqsXT5GRGjlf1sNUcT3HHsox5Yl1SZ3/HgyiYLl99g1wjH5dKWM11i51BIB/B
	p8LAhqWggsbStZqDLjfSAVP4PXiMD67M0O0NksqznShpi+fAkfRGM3apXJjwxD3AcJTYlpzowOvkf
	O/S+pTa7s9fakkyh60Lf66N5JTBBsLnJgFqFaM1ycrrwsjmhDtI/o1tBrqPRkegzh6e3uyez1h2Qo
	YYsWKJHG9MmlnaZo7ydJV2j2V5AYNws6nJ/W7+2AOzBvXyvRNM3+e/tKw8cGnVlvo0bOD0X8b7I1a
	oSon+sCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v2pwN-0000000FJnk-2uyK;
	Sun, 28 Sep 2025 11:51:43 +0000
Received: from mail-southcentralusazlp170130001.outbound.protection.outlook.com ([2a01:111:f403:c10c::1] helo=SA9PR02CU001.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v2pwL-0000000FJlj-0Roh
	for linux-nvme@lists.infradead.org;
	Sun, 28 Sep 2025 11:51:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oub6U0pssfFmhCnHXa6TlG8avjSOuu8ggJNkuSyt8LfFE3gd+COURN7TTERAhMQvYK0zBISC5CpRLTnE8NiIBwkMhszjzD3nklS/tsvlpKIjBEqfV3+7j+/6uY4llEmeu/dqSBA9hL4IXMR/X+XCCHLWAZUt1oezw412FjbVaKDsRtK+i+0KBg+QIzJEzdZUWMB0UmfzR7AvA1jbVc8C3+9JhRwT/Bp70QxEzc+vB9jkCPBvx68n+2eanHPtwabWNyVZu/rJxIpR6isZFwi/ODDJ2Ruk31P3i55nzSstdSgPrEz+DRBezA164gek0VH11fFbA/HEIiEhEoSKAz39DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wg1HWS2oETt2xtZGwMXugdEWXEPcYBsySMkH4UtltAo=;
 b=quRgCwlmoiPjFvLbYkpljREZC8tAQmR/zfq8eA3lWVkzuXPObyuCkAMwNZm9aS4aj0P2FwepO3TYWohwoMq2qXZx03rSk8knOKJZlOX8R4maQDps25IGbysgeAM1XNTDIRanU/MTGCdBDOhmSEv8L9fh84XFPOwAxeQ6YIIwxf35KChR7GfLmn9JEmVN6E9OVxUeZOnUJgZeAH37OoSi91NdDK1GEwHv9wmSuEmkaibAXDWZdyDlrddqXVmDah8lXnFJBEfLaCE/X7moqP2CcDiuqpG5noTqqbEmMV3yF+7PgPg4MQBqVQ+h1enVXqfXxrzTPSbTqyCxn3LIog4UcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=suse.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wg1HWS2oETt2xtZGwMXugdEWXEPcYBsySMkH4UtltAo=;
 b=S4+xvxGTdhkK74YOFC2GHkP73hWWbYXGJujToSaTodi7xdGKtv3vEO6Khd0pwlVd9GYCyGhXxQY1+614SWSBoO4knwIF6RehbOqlTv7GRgD70dZc865NXKg7bSIYiUuI56lBnCJfnedpTYEtugWlsmNXoIK2mpu7M+Fu+4dz8R8yUepIRU9gReuqA/HZfvVf9EfI82bc2JY3Z4V3xpv9Xsie9TKqw/9iw5l2gCCuNOZdRNBmUr8ImVwd9kmPvMFFRb2zseM9xZjR2bxJHtnoJ1g2eMW4Hnlz8O9qS5q1mGCe4YO0p49WrRUJGuLobBPTGC90zEYP3cPB4qPma3z6Cg==
Received: from BYAPR06CA0052.namprd06.prod.outlook.com (2603:10b6:a03:14b::29)
 by IA1PR12MB9498.namprd12.prod.outlook.com (2603:10b6:208:594::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.15; Sun, 28 Sep
 2025 11:51:29 +0000
Received: from SJ1PEPF000026CA.namprd04.prod.outlook.com
 (2603:10b6:a03:14b:cafe::b2) by BYAPR06CA0052.outlook.office365.com
 (2603:10b6:a03:14b::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.15 via Frontend Transport; Sun,
 28 Sep 2025 11:51:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF000026CA.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Sun, 28 Sep 2025 11:51:29 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 28 Sep
 2025 04:51:29 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 28 Sep 2025 04:51:28 -0700
Received: from r-arch-stor03.mtr.labs.mlnx (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sun, 28 Sep 2025 04:51:26 -0700
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <dwagner@suse.de>, <johannes.thumshirn@wdc.com>, <kch@nvidia.com>,
	<linux-nvme@lists.infradead.org>
CC: <israelr@nvidia.com>, <shinichiro.kawasaki@wdc.com>, <hch@lst.de>,
	<kbusch@kernel.org>, <sagi@grimberg.me>, Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH 0/4] NVMe: add support for mlx5 RDMA HW and test enhancements
Date: Sun, 28 Sep 2025 14:51:21 +0300
Message-ID: <20250928115125.38383-1-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026CA:EE_|IA1PR12MB9498:EE_
X-MS-Office365-Filtering-Correlation-Id: b3ddab27-c949-4952-a2ab-08ddfe855c81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8ShTKc5gQjiW2bxATxiMENH5mQmx30EDIy0f8wJm/ZvxYFo0C4LKuV3DDXBC?=
 =?us-ascii?Q?Len7vVmaRR0TS4VeRwj3Uf2Ypb79TOEMNcJunVh+nfNHuKty8UnP02as4e7E?=
 =?us-ascii?Q?64YzsBIcpSvMvwtAiIYz2A9DH5OJwc6dROt+YbymMcQoLS9zff3LQP2wmWJq?=
 =?us-ascii?Q?drOjAYpPDePsyiEof7gvsiKrbxllhUuQ+nFuz3JQOfCFCK80VtESTGVppJZl?=
 =?us-ascii?Q?PEjmSu32G4zGVX3RA6o4Chw/MK5UN0cb2Aex0o9MbcCZoQGa54TUaMjAzmk4?=
 =?us-ascii?Q?wK48tM/2n1fhQM6PZfeKv3IoVRRLi+U/C/CTZ0Tf3/iOZ5SBDM33/fGFo4MY?=
 =?us-ascii?Q?1lGOyFB5YE/X1jzAmSoEa+Qsi/y3I0/0CbQ2ZtBhN6DZjhiVA8xFFOJ3uaX7?=
 =?us-ascii?Q?Z0YsPAfOrA8wVzXjrC9tqWHVWFlBNbIWfA9cD4/PEaeZKXq+YvkNGkVOna/W?=
 =?us-ascii?Q?QFCfB7Ww7NbyKR+HT0kIwBHVpulMcWEmSzuCwUE3nLkUdgvx1uXcd6wV2wN0?=
 =?us-ascii?Q?p0KKdLdMBZRR9EI3rFYxV6yJ4DvjEaqzjRgrE/bWhZcee9AHGZbgBvEMWLIJ?=
 =?us-ascii?Q?oOus0JqN7S+iBTeHzzzAmux1xD/k6IeEew+fdbiK2cSRKWAkhFmkSALP3fJl?=
 =?us-ascii?Q?BqHSqtE2a9McbnR8zZOYgUoywu1qEcQEfTsnOyDBp5dipwX+uH65oEACP8/R?=
 =?us-ascii?Q?0Byfd+nQ/YWHi0v8KQbK7DpFgedYazO4BK6N1EVI3ZW35wdrv6MedXCWVBZi?=
 =?us-ascii?Q?P/fWaoG8UQ8RT27O+ydzXALz7veMkySiUlGooAF501d0YAfw+ijGyZzl8eSZ?=
 =?us-ascii?Q?JUpSXUEFoYIFXBlP4X25VhJCL1YQicv3GSQJRQt5K398FpCFMHfRpUr/Syba?=
 =?us-ascii?Q?AdZd9NIUGAX15fgpWgp0706gFGQNFat63n1Tk7euiDPTi7EOERth09MbhywD?=
 =?us-ascii?Q?dxu25H4Ev+NOCBip1+V2WnRr3ZagAWmhgui16msuXds2Cm+TBFIRKHV0IeXB?=
 =?us-ascii?Q?3TiTQfO0kvI0+rGPr2g/WWd50KM+/ZiI7basVJlg5DJnRhT5i6KanRbNSz0Z?=
 =?us-ascii?Q?uQB2xmPFNJrLndlXeAesgGLRS/YUVz5r0oNYGZeigvH9J41FpU08eLo7nOsV?=
 =?us-ascii?Q?5rmTpt9wDKzDcgRHyoJ7vGCUSciq+EQ8imxIhK75ixTPq84P7GQvfkF+CCV5?=
 =?us-ascii?Q?ewfJ64O4Okq2TxvNfPMO2fKM/0qjEafCgGFewKnb9uHKfiRACPXr0NMTPb7B?=
 =?us-ascii?Q?c45y8zC9N6+6N9F10cm501+bXfX1lbiAEfw0MtWvGRekjEC6wExZmw+OKF5E?=
 =?us-ascii?Q?a4YJ4/6f2mve0XmDB3GDPJC6V6PFrG2zV0mi2zXAjDk2vexvZdpM1n5BF3jr?=
 =?us-ascii?Q?8WY1ketg/+cBAkp/fBTXvCkRMeIHe0WZAqAosJC6XI6uUPgIFR67P84LTx3x?=
 =?us-ascii?Q?BPDB/BBJ7Go/2JiH1kGW9kB+JMAOknBULWjSpySXrVcO5z9nZRh1irVrD4/g?=
 =?us-ascii?Q?qkifGMF4uxDeBjy9ALkHhE1gdxA/2p94gms8/Wg6ZtIM676T5FCYpmbO8vv1?=
 =?us-ascii?Q?zUt28UhjnA2oGcZn1i0=3D?=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2025 11:51:29.2395
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3ddab27-c949-4952-a2ab-08ddfe855c81
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026CA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9498
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250928_045141_146320_0742402F 
X-CRM114-Status: UNSURE (   8.85  )
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

Hi,

This patch series introduces several improvements to NVMe-oF support and
testing in blktests, with a focus on adding mlx5 hardware support for NVMe/RDMA
testing.

In addition, update nvme/061 test to support the new restriction added
to NVMe target driver that doesn't allow modifying the qid_max attribute
for discovered subsystems.

Max Gurtovoy (4):
  nvme/061: increase nvmf state wait timeout to 10s
  nvme: add support for mlx5 RDMA devices
  nvme/002: extend test to support TCP and RDMA transports
  nvmet: add --qid-max support for subsystem creation and setup

 common/multipath-over-rdma |  7 +++++++
 common/nvme                | 34 +++++++++++++++++++++++++++++++---
 tests/nvme/002             |  2 +-
 tests/nvme/048             |  7 ++++---
 tests/nvme/061             |  4 ++--
 5 files changed, 45 insertions(+), 9 deletions(-)

-- 
2.18.1



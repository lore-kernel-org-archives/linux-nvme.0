Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1DB6C369D9
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Apr 2025 08:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EbFu0dlFHD4ue6c1H0T2HHV4LvGUohbMvaX4FM2L4mE=; b=WJ+lQa1uUtSOCdgLWYOpcG4/C0
	60NF9kWmJnlaZeGNFMijX5iGTXUcP/evVGslRbiHfDAJ/i8W1djZnV9RPcNkRUR8HueY3V1aNTZVK
	7GgIxEO4vWxnLgawnBWsi09trOwH89RpjYQ28gNUGCtivkvPqDXMyuPIH0Q8rhA+cQMUkySprtTKk
	+tgeoKyrkzZSF6kE4rxG+yy9ZI3tHQI7YITHlNpI8YDA2as343UaYiQTtZoNofPE9Ba/1IxFqQce2
	obZCMd97AQWWmYamwiV8HSVwXFn1Me3bRPyo5g+/ZAGEKNvE80kRijzKksXN5upzZHf2GqCl80/Sm
	uOeoN1YQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uA3Ha-0000000CFUN-0uoq;
	Wed, 30 Apr 2025 08:59:10 +0000
Received: from mail-mw2nam12on20600.outbound.protection.outlook.com ([2a01:111:f403:200a::600] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uA3HW-0000000CFIW-10E7
	for linux-nvme@lists.infradead.org;
	Wed, 30 Apr 2025 08:59:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jo2QIQWarp1NVhJtH/blVaLKqO3CSgJDV3Q/wlpwdyqO+5zlanwDMMHdaha7H5/xvKl8GsN3EObQSAe1NFQ7lvPy67nH+SD7x1QGsHhXadi2cd1sZI8rpC0CETjLH5xw4RGYmIuBIOwmuLw9qxly5YOUQyxTN58/TS5p4chez7ySJ6FjZ2eYKG5oSezwwVRxtip4afyVG5szcAdR1dQRyvOkghiG27ZyxY9P7UKJx7asyCzqCb5pevGXUGM2C3U+/nH0IBKC8B/p99K+a0O9le5F6aSZhmxjNJmDokDuD0mkRdo7uSDR3JjgP5nQ0zNqN/6T7vrG/quMh284v2YuUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EbFu0dlFHD4ue6c1H0T2HHV4LvGUohbMvaX4FM2L4mE=;
 b=Z+B5/iRpyvdTDby1F6ESJbGRObmdK87GlYBC204x29wUIkz52Q/p1DCrTlCjp/ETjytQNvZ4BDv+mFETf3dvqy4gmCYo/ICnjfL8tgwz3nAC/GXEl3i8pW5lH+ORfYUnDEEiqR/lG/Bo5PzZnJEoLTjZp91FAOmD1d+AowhtqAmGdNoWEotdQ1ePSQma3Nk9jAWkCDkP7pj6GVBTomzqLiJ0tztuR3YgQJKQpXfMyBQy/gaUvzMDidKDje2JHeaLdZmpKgCWZMB1kdot/Tf9+rYmeAxTPnNlSUN0sj6io/54V3j/9HsV+hlNCMJ+kW6EE/7ye+AXJjZEn0VRjjO2oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EbFu0dlFHD4ue6c1H0T2HHV4LvGUohbMvaX4FM2L4mE=;
 b=T2LhAPhTcOS/Y9vuof5ughjnofMZOfOL7agv6By3r4nkO82o7urWpHgNYCK/iKHkzYkJjWF39K+pc8vJ2EUoc5QOYvaUufXHATm9Ksm3B1JDHzqhc4kHbl6gG2tujAnqj5I3TZrWAdrPkh4sh+AcAXl6qbo2ae2VfAZLMFLJcb7yItnUYy4IJIZKI/1B0i3dijS2cftmY5shrwbKNUv3w26uxgIiA5Hm6PDTWwPOJrOzCch0BRTNQk9hU8mEQWvMQocAo071meU4Yr8Y76nwKjosuervcVaZ3HgmTu44c/IKxtY65KI1oSHf8LFxDwU0hg5jLf2BVHaMKXvUue1X9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
 by SA1PR12MB7319.namprd12.prod.outlook.com (2603:10b6:806:2b5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Wed, 30 Apr
 2025 08:59:00 +0000
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc]) by SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc%5]) with mapi id 15.20.8699.012; Wed, 30 Apr 2025
 08:59:00 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: linux-nvme@lists.infradead.org,
	netdev@vger.kernel.org,
	sagi@grimberg.me,
	hch@lst.de,
	kbusch@kernel.org,
	axboe@fb.com,
	chaitanyak@nvidia.com,
	davem@davemloft.net,
	kuba@kernel.org
Cc: Boris Pismenny <borisp@nvidia.com>,
	aaptel@nvidia.com,
	aurelien.aptel@gmail.com,
	smalin@nvidia.com,
	malin1024@gmail.com,
	ogerlitz@nvidia.com,
	yorayz@nvidia.com,
	galshalom@nvidia.com,
	mgurtovoy@nvidia.com,
	tariqt@nvidia.com,
	gus@collabora.com
Subject: [PATCH v28 14/20] net/mlx5e: TCP flow steering for nvme-tcp acceleration
Date: Wed, 30 Apr 2025 08:57:35 +0000
Message-Id: <20250430085741.5108-15-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250430085741.5108-1-aaptel@nvidia.com>
References: <20250430085741.5108-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL2P290CA0001.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::19) To SJ2PR12MB8943.namprd12.prod.outlook.com
 (2603:10b6:a03:547::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8943:EE_|SA1PR12MB7319:EE_
X-MS-Office365-Filtering-Correlation-Id: d1dc5be3-1d15-487f-b6e1-08dd87c53f92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yKY0WuzQX6wEXg0c/C8cmJa42SDhLFiG9z/zDvX+ozkKHWv1JTe9DY7a/MsI?=
 =?us-ascii?Q?VkB496f+Tps7CXU1tXKGoYs5NkwGGt56uCU5gAtwx7hXyI+8eegwDWwfLMs2?=
 =?us-ascii?Q?7dmoCtYiwlspWY2lUHbJXLjuXXKXJ4xFfe1DG6EWvtTi29z8ncgWclbX43A+?=
 =?us-ascii?Q?QcuBEGtgDZo4WvsNwxbGnHXQwVVG/Zt2SxOMYYoRp05SIH5cq7VXQddnB2DK?=
 =?us-ascii?Q?igKEEmv5tp75bIlxTz7Cb8W4A/QJ7KbjeO5co+0SQaWLMvtFteUhyBd9ZI5x?=
 =?us-ascii?Q?CS2a8iJxQ4I9R3/97aHtwWgfC4GBeTnGiTxKiswa2OnXMLOLHc0X+DwN6dl+?=
 =?us-ascii?Q?oRZbBflewJRF3hYKaXP5TfMUHHlkd1kkJ0PjMSgtC4ahvcN4IDrNmvvTaePW?=
 =?us-ascii?Q?gRz31+0NCO7WbMKEuSkdfOFGwwr1lgi63USogsMCKLj1OVSsnL3IEjj4BKeo?=
 =?us-ascii?Q?1fTd0tN3AjulKe4knBMLSPB/F4G89ZR+alugfG8pxUFD891DH3DK+hkp1vRm?=
 =?us-ascii?Q?WiaLRNBi93xIlAOarTexLNqOOxhPX7ug80FW6HpwtG5PEZzt98SgS8jhzAz9?=
 =?us-ascii?Q?vo5enIOTu6NXFtm9wOxq9a2DcK1Ko3iJXRpEgH9mRogBy8FrjhYBtuAVKidv?=
 =?us-ascii?Q?gcrWzldU4IQmMtzJYRdG6VLTh9+qF3oqU0C/Y+j0Zvt2vr8fcPSXgEEInGzz?=
 =?us-ascii?Q?GldD653ZSOaF3M9/gtj9aD0BlF99Yk3R+3GC6uYX6WA6ZQfaAkBo8PL+RNtm?=
 =?us-ascii?Q?ivOOcOf0jx1vdf9HyqMUeRpENwOH1OvRCcUd/7aiwUqBXJxLzNGpupIB0dH8?=
 =?us-ascii?Q?cpa9WqgLVsBSq1/PSaPRlJWZ78aNutiGiSRIDpHoUL4g6BUkT+Hgh7X65dmO?=
 =?us-ascii?Q?m17i6LubtHZcnOSieUwI/8ozft7oywx9c6r0Taa3tGoKAYj/9xqwv8Buz4oc?=
 =?us-ascii?Q?QXiMiPmzaSgPLAHii1EXiokIMEpiiXE05O7yYRif65NKsRA6sjaCgTJzW422?=
 =?us-ascii?Q?py6ha8vuLIADFO6diDPCBQkH7jExopflGLslyFAq4VDzkkcg1sXog5gIgCB+?=
 =?us-ascii?Q?fvPhHoC6Oa2GooMuEEY7mfod7YFiqXdDWuUfsoMmt2G22DoR67ysOnN4KVpC?=
 =?us-ascii?Q?+WXlr3zyZt6j5PgSZTHFgRNazhNhGuH7mwtGo4dCkiBxYzmOCE7wJwNHSk//?=
 =?us-ascii?Q?xBXCpVDfh42+ObuONKmOALcKlki6j0Y3ruG4LoEJHZqMvZ8ILBBNrX8oflZg?=
 =?us-ascii?Q?6IEwfFNOF97v8EDlaWlfP6n41ZDY7Wdve4hGTBRnCVceKhDJwpSffkuPzIny?=
 =?us-ascii?Q?rexHkBGyzodonhrwombcQzV9wPvHpIUDhfHIC0kNM1SMepyOL8oDWytZoBGw?=
 =?us-ascii?Q?BneiWnmTPIQQxVDo7s3kaJJJLFSUezeG0qBtA67u+TAH9BJjxIks2lYnPCPx?=
 =?us-ascii?Q?iz5pvwjybFw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8943.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8NBAEodYkDp+lbg57i85FtsyzwXwSTdpHdGtVRJBpW6ZErybvk/fXZDu2fJN?=
 =?us-ascii?Q?u4uF/5pwoF+2uU/uPBfk2GPIG4hK1TH/38bKzLu30p0Q2rG+f3WgowplEed7?=
 =?us-ascii?Q?/eUsWNw2ilaIlBn9YsRvYvWFVzE2y+mNp38yaDiE906yoql8NVM8RQaiQheV?=
 =?us-ascii?Q?5VYhBtxORUJxHqgR0pnIhrFd4URckK65KCPZNvVUJPj0wE6KfjIUZDhjF9vV?=
 =?us-ascii?Q?RHdBbjqNWJzaMFaZVc6h8vfTGIyEnKGkMvR9lUHNqsaL6/g4/QMxbT2r2i96?=
 =?us-ascii?Q?MLShuixs/IAc1DJslmHH4MDI8DZ8Tn7hw8wo9EsIVYza0TsBIquYFLGFVteB?=
 =?us-ascii?Q?UCloBUKJ0Ado+Ym47Vw17NmhQ+trgpsIJn1IBF3+KbW45cYxqdzVuJ3kbo1k?=
 =?us-ascii?Q?87eX52R5jhHyVB2SvZs8LiboA/pXdnvLw9howyt9DKmtkYFcZsenElmJIc93?=
 =?us-ascii?Q?qBP7nNFCuAVxZZp3zSRofYeZEcKdXNYCSpA81M5c3JswhHPmBvMEVHc1vXFj?=
 =?us-ascii?Q?mkd7XSve8vT4arvGnBx1xZUFrNJwmRSp63BGkStVn51Gb0akCmtnYnpzKyF+?=
 =?us-ascii?Q?1ZKiLcnpp+f2dbhl3mpfplL2kYpvvBDXoTSIEQbIiPGERQRFvwqo09Nm5Imu?=
 =?us-ascii?Q?Uoh4HnlC1AcBgut1A4Weqpqp0ViLQnUY5aajA7uBJhDcp6+AJmVHFnBJibsv?=
 =?us-ascii?Q?/QgrIKqxCwB+gjeEgxq42ClBX6F2PzqgeP6M5xJB5l8AoM1F2ZG6UmrGDTSc?=
 =?us-ascii?Q?jrjxcCsB76lEzd1t9UuHreEiUfB53jj7EACeIcc2tPnmCPNWiHx+7fYiuBt1?=
 =?us-ascii?Q?sFW8fO62zgFiyG+m6d/4fB9R7Dns78MiNeWW+sOvnMv2/M47n2BnKWr3lXhV?=
 =?us-ascii?Q?ZBya/p1dVR5NnLoDEgCnPxoYJ2jy7U0C3dLYZEEANdzOSGWV1FBYf6NOLf7/?=
 =?us-ascii?Q?AnfIAWwVgVQNC4KMYPQYzWRnyoAl0nQEVg8/ZdunIxP3WmviEfx7NANE1VHw?=
 =?us-ascii?Q?dsNohF32ZRdjxIktJGrWui/RjG9zRpMKJ48Nd21QhVnYSjuVFkiMCJD3I3VS?=
 =?us-ascii?Q?qDeNSnYioBNpgRR5JTtKu79+mhBvDKo6wxfFk9/ol4cUZNJGrWEXDwiYLoI4?=
 =?us-ascii?Q?3N4mmLL+LT8bzGG0pOX7+8d5ub7AHQfuRO+jqL4DdqCjEW0JXowkfRUQVULS?=
 =?us-ascii?Q?sLMQWiSFLQVi6jPr/PAQAecBQ3mY+YznaeneQKU4i3DQ+FRK1bXkjFlkQCZd?=
 =?us-ascii?Q?gMCih/q3aGO2wvy9nihHabR8jBF3+onPrjJ9AugEgl3HHGYhhvTY9WIW8I4q?=
 =?us-ascii?Q?dVkZuCviFUJqAglNs7w+gbdZSil3qtzAYVCUc2y4U7jc88RGClunjKxauERS?=
 =?us-ascii?Q?gb5IHEBW0905qYIsmUiqF5LAM4J+lHZMxJmc6wqCGRhEnedskfJ/wVawfKg8?=
 =?us-ascii?Q?jkmAf0UPlMOp9dQevJ/UONt3NrnPnRpq80JT9bsa3LUurP6i4Sk1InZxEwdF?=
 =?us-ascii?Q?wWi4MPPSQGSEVuPVlSIR/1rEgGNWHxGwpvhO/SgVbnzPhKOpoIsU/UwCzEgp?=
 =?us-ascii?Q?DIMnZ2p0b7wR4O1BiJenlYxrC8sKmetx58mf+lyh?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1dc5be3-1d15-487f-b6e1-08dd87c53f92
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8943.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 08:59:00.2423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mHwCE+1kfWoUBg7S2DM8F9ZJxN/UBeAWM6M3GFp6IbZqQf1mSCYIrvITzOpCZYgKFN8qTaqojfWe2Om3aEEu6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7319
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250430_015906_307722_631187B5 
X-CRM114-Status: GOOD (  12.84  )
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

From: Boris Pismenny <borisp@nvidia.com>

Both nvme-tcp and tls acceleration require tcp flow steering.
Add reference counter to share TCP flow steering structure.

Signed-off-by: Boris Pismenny <borisp@nvidia.com>
Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
Signed-off-by: Yoray Zack <yorayz@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/en_accel/fs_tcp.c    | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/fs_tcp.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/fs_tcp.c
index 4f83e3172767..f5c67f9cb2f9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/fs_tcp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/fs_tcp.c
@@ -14,6 +14,7 @@ enum accel_fs_tcp_type {
 struct mlx5e_accel_fs_tcp {
 	struct mlx5e_flow_table tables[ACCEL_FS_TCP_NUM_TYPES];
 	struct mlx5_flow_handle *default_rules[ACCEL_FS_TCP_NUM_TYPES];
+	refcount_t user_count;
 };
 
 static enum mlx5_traffic_types fs_accel2tt(enum accel_fs_tcp_type i)
@@ -361,6 +362,9 @@ void mlx5e_accel_fs_tcp_destroy(struct mlx5e_flow_steering *fs)
 	if (!accel_tcp)
 		return;
 
+	if (!refcount_dec_and_test(&accel_tcp->user_count))
+		return;
+
 	accel_fs_tcp_disable(fs);
 
 	for (i = 0; i < ACCEL_FS_TCP_NUM_TYPES; i++)
@@ -372,12 +376,17 @@ void mlx5e_accel_fs_tcp_destroy(struct mlx5e_flow_steering *fs)
 
 int mlx5e_accel_fs_tcp_create(struct mlx5e_flow_steering *fs)
 {
-	struct mlx5e_accel_fs_tcp *accel_tcp;
+	struct mlx5e_accel_fs_tcp *accel_tcp = mlx5e_fs_get_accel_tcp(fs);
 	int i, err;
 
 	if (!MLX5_CAP_FLOWTABLE_NIC_RX(mlx5e_fs_get_mdev(fs), ft_field_support.outer_ip_version))
 		return -EOPNOTSUPP;
 
+	if (accel_tcp) {
+		refcount_inc(&accel_tcp->user_count);
+		return 0;
+	}
+
 	accel_tcp = kzalloc(sizeof(*accel_tcp), GFP_KERNEL);
 	if (!accel_tcp)
 		return -ENOMEM;
@@ -393,6 +402,7 @@ int mlx5e_accel_fs_tcp_create(struct mlx5e_flow_steering *fs)
 	if (err)
 		goto err_destroy_tables;
 
+	refcount_set(&accel_tcp->user_count, 1);
 	return 0;
 
 err_destroy_tables:
-- 
2.34.1



Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7826BC021B5
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Feb 2025 10:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EbFu0dlFHD4ue6c1H0T2HHV4LvGUohbMvaX4FM2L4mE=; b=Wtr0RGwJNN+h6M3PBvEVbrObGJ
	/+OKclBsoPiXy8inhNUY6bIVsWH9EmTErLYUvOrkqi4VQnu5YVUrpnBn5hFqRTbrx8bOVEn0g2YE1
	AoqYEkGJPX8gQu1dTyNZg16ED/UlTsjziybrjhkvpR+He4M47vnu1RHr9OSYvc5tXfNDGA2wD5AGJ
	RmgV/oDj7CYbupuGiNlUSFY0N680d/z2q5Dj3TBCXIOKsMIm7FnsvEVzjNftrCyM322RBM3f69b/U
	u36WhYDzbB4lcjMEUzjQmTXbbuCGxWd+D6on+dublUHfzC+a4XxWHRnnNPNnSEIrpno5JcjQTY8eM
	JHM40yKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tlPww-0000000555O-2OSK;
	Fri, 21 Feb 2025 10:08:02 +0000
Received: from mail-bn8nam11on20620.outbound.protection.outlook.com ([2a01:111:f403:2414::620] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tlPjK-000000051uh-079X
	for linux-nvme@lists.infradead.org;
	Fri, 21 Feb 2025 09:53:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SHr0WRPYP/FbluH8R9m3s9wM3xJ5GY5bPOmm01c2ZjG/IYYeVjui4h7BMU251NfW9kHqotLIgwhIWuSR4KqRzHSGm0hsJSS+hK+rcFD7p+kqAk66PD6H2nantnXOH5QA67IPGMhbRFZBNfZVri/Wt8VfDjEjjOLRUqBiQHC+H1F6s+jY6W/9SWKcJ2UEflyHeiNXLsbB1knrpI3+6Li2q20ZNrpbQbA62DDBSjLsUdQTgYRh9k9gcYXc0MmijnJc6BFVQDu9tUOm9HQNtKCx0QQs4jDOAKHZs7tVnfGUj4VphBqs3AzB/RlMzwJ25kIE+itR+MXbhaqVSRzmXsafjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EbFu0dlFHD4ue6c1H0T2HHV4LvGUohbMvaX4FM2L4mE=;
 b=GEpgwmsR6/y2mUaRmury4rV0aYBhgbYddC/QIG0lGOnMI1FIRj7z2AyBwIAjqtqiVgTwg+BfFwQgIgWo789cXyXaVMAIFbFCU0aWTRPDGnC8rrYE7z8HFwHTDZpnWmo5iIkoR2xqIYnbAhr+oC9eh0AFutcYU7bhH+U4gVXvQnST2xADt0TvX6i7b/a4al+dQ0dJT3+yDthIWKkiWzs1Rg3jGpal+OO+31nXmJD3R1Y5pT/vpXUlaUH8z5gdnAMm4tJp8ZqPNtzWquJYJwEt3o1KPlSBjJ+YAILmcdgxZUmBletqOV7ytYZdNWFGgCLjZizw+nUoepBd7oCwxLnN8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EbFu0dlFHD4ue6c1H0T2HHV4LvGUohbMvaX4FM2L4mE=;
 b=OZd38rW7JB9Ubd21IGqWvcNk3PO8OCPS/AIBykGkzT6XSTzRaoxIg/X89W7GKBzF7bAbjr/EtVQ6C3RPUmHRXaj5/7dWXCDkVYpvFpYfwb3+bgFjs6G2gAuT3tkUegWvKcqKWnpWbzn8dkEKJ8XOah0SNSoiqZ9dzsQzu43QselNNZBZhaQKaNWmPvl2+95BaZAb8J6MAZTwDplbh6ERy21ijHOoYn82zJzDUxXwU96hEdM3C7Hv+/cR3sIUh2rryoInngcUt+Ea/M7nx1SzeVI9mwINh1Ux77fZCYncrIyQ5y2XIK7hGw0Jz+u7pwMRH9LzVx8TgFMctyPli2T+ow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
 by PH7PR12MB9127.namprd12.prod.outlook.com (2603:10b6:510:2f6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Fri, 21 Feb
 2025 09:53:55 +0000
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc]) by SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc%5]) with mapi id 15.20.8466.016; Fri, 21 Feb 2025
 09:53:55 +0000
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
	mgurtovoy@nvidia.com
Subject: [PATCH v26 14/20] net/mlx5e: TCP flow steering for nvme-tcp acceleration
Date: Fri, 21 Feb 2025 09:52:19 +0000
Message-Id: <20250221095225.2159-15-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250221095225.2159-1-aaptel@nvidia.com>
References: <20250221095225.2159-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0282.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37a::14) To SJ2PR12MB8943.namprd12.prod.outlook.com
 (2603:10b6:a03:547::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8943:EE_|PH7PR12MB9127:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bf7c398-d2dd-43e5-9cdd-08dd525da7aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CYkGrIj2YCwZ22eA4yokJLszKAbJb0n9sct5kiiJLOIkhLc8BgIAhuDbzdSr?=
 =?us-ascii?Q?xSNJD0o+uTdfe6SpPsAjb/FnvvQEvhhAgX6Ssnn+hCKoHbygKQJT/L/xnmoE?=
 =?us-ascii?Q?o7aqtB/MtYq+e8inWSAEyVws0lV3ujNv0KPK4f7JrRgFD47PSOd51Rmv2P+p?=
 =?us-ascii?Q?HmffU3Xx0ZzD0vCEOJSL2ObcQ4F5EU/7sUyGUPw99nr7X8ZQntPS9L0Tlgg2?=
 =?us-ascii?Q?h2CpnCjvwPHSCDkuhi0+H10sMBCwMXrpkj3vgqSrkwPI1BpYCWic3io6yxqS?=
 =?us-ascii?Q?ACTof5aVqBSBFIqEZUOhkaM2rYJk7xGg5zlo9heGdmpNmb4pFuRaZBQ7kDb+?=
 =?us-ascii?Q?0+3oVE3ameNd1EVuLMIiigoAFQfsjlfSks7f4aD+75p8yK7jYvo3YZ28ktHD?=
 =?us-ascii?Q?bKt7pmeCbrI6T2awU1c039l39A3z1Md4bgghxUgO/ekhJvDn0V2r7TCNEMhb?=
 =?us-ascii?Q?MlRCL+k3UhhMH1Me2TF8iSlJlIWbwzY1OiusdGyEQFXgQgKR6GFggd12Jjw/?=
 =?us-ascii?Q?OpkA03Vv859wVGIYwr7/Gh33zJNffGIzmt8SNBXWxEulpKoj6TYt2Oii+tOq?=
 =?us-ascii?Q?bj4pye91W6b1yqZjyGYX2V/98LM3MygnVFwHWewALeSD7iaBF46xW+g0XAOo?=
 =?us-ascii?Q?xfPvNW1TJcQGwpuU3ny2GL0VM5z3JJJ39Fe3MXKuxrK2s8w63qrduwITI5EG?=
 =?us-ascii?Q?DJBvJ1Z1cDzOor3KkvfCfqCye10kAGH9B4GpIsVEOaON4zy33kh0QlMpVLLJ?=
 =?us-ascii?Q?nd2/xRAkdo14bwacwkT2S8eQgb5um7IVLLb0E248y3S0CZTNJrdw1KlxEL6g?=
 =?us-ascii?Q?VCF4mDBqYYskY4LKIG4Qi2GZPsQF8eGU7vTfTPL7T2C3To9aI2Z7yLeT2r4l?=
 =?us-ascii?Q?hXvrHLNV29v4X0dRY/aD+SNZyDDtA/IrryzBcgeu+BfMmq4/myy2g8/dMj49?=
 =?us-ascii?Q?o2Z9ZgehGbgHdcT6+/T0NUa1BAh/fgVoxZQV0tSZ64H6Fkv27xXsEdBZYPTr?=
 =?us-ascii?Q?TCA2SmXY/3ivkS/iZx7xvWaY0nS9EtQg06FMSLmwCpQz3A3quWUJ4azZiK3u?=
 =?us-ascii?Q?gbSBlMSzMznK4YmOwyNDmR4sbipbY+1npvpjKoGPuM02IFOCVZ3h494a7m/e?=
 =?us-ascii?Q?ZtmIO232gVpVLuGYPadWMDeVaAqVjbYfdxYpbkwsAxpT4NoJrhWo5Q4EuUCo?=
 =?us-ascii?Q?Q/3CG53PrYKDsS4/en+EjCw0oNLbdOfVX7qp7SJTL3P5Q1w9BEtTYl+Ulrya?=
 =?us-ascii?Q?oBPA0FIL2Fhp5huHUkRiM2g5aqgXDp/BIMoMsDFKvETVGLtgaHiVv9jCO38J?=
 =?us-ascii?Q?kcWMPQhzkc0EZIsbKnqBN5ChOOPXGhuzTInqOQ9uTMsY29L2QK7D+luQU6oG?=
 =?us-ascii?Q?hCwI6Noz7PWdfYlF6SC258d5PJpn?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8943.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lyxWmGkCZ1j5wgZ2PY8VZlGeHyNQ2G6H9sW6icr5wS8A4Bgq7E+fllFsrhk7?=
 =?us-ascii?Q?R+Qd6JTGFS562peO2M0k03IfV8NG6E64N1gM2U/cRY63+BjXv8TaUSaasPm+?=
 =?us-ascii?Q?oTxxw4mCNHbUqTwbsrWkoliGZ+RYdGUuCLbSxZ/5Oxvw9RYSDVD+QPeBVxtQ?=
 =?us-ascii?Q?HtA/5E65D83p8bWz7GIFmb6NjkQVBXEtyq1LamiZcGDp762dUv5jinz8/Zsr?=
 =?us-ascii?Q?tpGREoQozsN0ZoIJ5yeq46arDacCyfgmhQfXHwGQ9jpNu4BxR4DlB/B+IzHb?=
 =?us-ascii?Q?MMm6HfvqSFYeJkKu5r1g+5rJ8PySvB6ZriCoAHpeedp7aLlrgRPtg2ZNZU5V?=
 =?us-ascii?Q?AjbQyHFj11A3KD06SK5n6Of1nzkv/oimYWF5p4sxiCgctD+vRLD8xBM21Ej0?=
 =?us-ascii?Q?Cqw8mc24S7tbIcmdY8X3fPwX0KHcttOI5B46AvwgkurIkuZwCEYcF47tu13y?=
 =?us-ascii?Q?ZoJ1vTJnHJoJQb6X86EiQIQkPMPxSAN9YL1rbSPiQW0waG63KWQRpFbQrtrf?=
 =?us-ascii?Q?cUg5QrKAtgba7xsy5nk17Q3ruV6LXLU2wvce8f8KZWnj2QZSsxa5jFRjMNOF?=
 =?us-ascii?Q?DIIovgjo7HJrsM/mK/WxzYmdL10Nsy6rlxR3dQdeUt1JkLdZDDTpa4w0Euqa?=
 =?us-ascii?Q?G2+mTyuZaZhmGj1sXeV2aWjBwW1iDKnW4jEyXcXC1D0Gn19b/EvqmlNiLQuC?=
 =?us-ascii?Q?CXfH/30vbtMytfS3XoZ74aXLJt9RoZuBJM7nxlRiktHtymGKF6V9L3L/HJz7?=
 =?us-ascii?Q?lNQ04KkDmBJzFohwxsP7XmQtoITZoAOJi2VNXVpcvlJ8TwaXb9Khz1+Pmk1a?=
 =?us-ascii?Q?2iAKz9vycj0HnNru2KAzkuByXkXN2n0T2aF86RYCD9zwiMCPPf84lteJQ5rh?=
 =?us-ascii?Q?nE8QKk7Kg09ly2jDIemM8UdKmL5Haig0t2oNhcTIsKhRUcgcfMirULY7HakF?=
 =?us-ascii?Q?1wK/DP00PntJfi2XRIA/I9dYBI5eeyKXMgfTHCliMG659QIWTZ4Bm45ABWio?=
 =?us-ascii?Q?/cnZadV50iJPM3AC1EsI1Ju8cykNLHsjHFGBNxpy2opDGgGc44h8E2CAI4OU?=
 =?us-ascii?Q?xFrXSSodIdMHtwFk0UkL0Ij1f0HypS9pBFEe7VDb80sb5GWuGDob48gjGtyL?=
 =?us-ascii?Q?9deQpeSJFsrdE5cEFG5kY3n/P9+Orz8YbHHxZBISw7dqEGjIvD+cFwRrUoNh?=
 =?us-ascii?Q?U7Syye6oB38TlivJOk5Y8HoMK7taVWTRXTNNJGIz7BAZVSct5xg49z8zizUC?=
 =?us-ascii?Q?fOW5q8HZ8MjHYX1z9K9LJ5jt5cVHY2Ve1b8k2wLs3uDJ/fVAfVI0+qc7tI0u?=
 =?us-ascii?Q?K8B08XJg/Lks8ALL//fvemPN1IlaIeVDKwnz50kWHz6kFqPHtucmj1ig8QWh?=
 =?us-ascii?Q?yvhdHbq/wJckEw3tX4UXpJWFbRbBmXKR74wPVl20znQT9706ugXbk/nRoEdz?=
 =?us-ascii?Q?DJcZlcvzijYK7/YaE6CWUf86ADZPGoSdAwtoPVH1JSB97jT9TiYfGWPNQbpR?=
 =?us-ascii?Q?qeRqYUfZ5pykewx+Jxb2brrks1s2SbZuyDiRkpGLtQow/UKRf6h++5JRX4dY?=
 =?us-ascii?Q?cY8wGe0Ye9/bVG2lqzO39szlOsdTg9Ym+yWW0GEE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bf7c398-d2dd-43e5-9cdd-08dd525da7aa
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8943.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 09:53:55.7274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IQQERJleh2jHir1Zr4gfsXn8E0WXGyv+BAslZWkOyt/F5LqpvhTFhRfkWOrHljTdkoY0THRu2c1iQtGDRJSwAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9127
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250221_015358_071696_A770B080 
X-CRM114-Status: GOOD (  12.41  )
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



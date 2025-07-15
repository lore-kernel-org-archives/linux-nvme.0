Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2573AC83F36
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Jul 2025 15:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EbFu0dlFHD4ue6c1H0T2HHV4LvGUohbMvaX4FM2L4mE=; b=cBW/xu89Ws2Lb5T9aJyjf+pKdr
	ulpjYujSqcA4mjP9z0tP+Iut2GwEEOlav7xtrF79KdEWlthv5AA4d+cWyaKKQBdYogGrfC/rNmQKh
	gGGJ0vjOnmCpUwwh+beUY21tmSQWBl4rIs7g3gGcSLXiHtL2lGJHc3h1XmqDh8T1+x5ClTUGnrux7
	7hwS+AL6/98BDxmPgwv8Hss2xgbMPKh1+EbwZ0slSOrgx58+Yt19DngrY+XAaRAX9nb63r4lhBswP
	rrsIK/Bb3tu2ttehCYcPVKf6AmrkCwQ/uhSvN73VD/ZfEyjxHbJmy8Gjscc2XRQk1Xbdam7c2sI0n
	tL3RpI9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubhAP-00000005VRD-1znu;
	Tue, 15 Jul 2025 15:02:01 +0000
Received: from mail-mw2nam10on20630.outbound.protection.outlook.com ([2a01:111:f403:2412::630] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubfif-00000005DDa-0pbJ
	for linux-nvme@lists.infradead.org;
	Tue, 15 Jul 2025 13:29:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LXbuicFgIVWUx0FpaUmZTWzoSn2PuGcWRIu3TSjB7gRNMnSf0HLoBUGBm2M41iD6QBvlZHD6GbYdByctPnqtKRT+5DDhES1JwbrEHj7eZU+r/SbQG1bVCN1LA2+esITas9tHYpTaCk7JRn1kFm2lBuwDChhLh4wihck8MJ5NUiQgel3cbEsysBVwRos5jZvSUB5Ty10nj1I+Qb+N4UeK0czejmU8fAz6anVe0ZQ/lU6cyk14Pv8+7cG4a59kzzjZHqVP+teSlhDSmqFwMrcf5/Bk3dewcq5RarTU4axjWAKnVSw5HRcMxz8tcWdrCMt0a8Lpmt71ilga7MBAElRAFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EbFu0dlFHD4ue6c1H0T2HHV4LvGUohbMvaX4FM2L4mE=;
 b=LHHdcFuZqsENMNyggAJVFNx9yXgeMtAzrV8Y0HDjb2nuOUhWo8USP+Y/Nqch1+AnVB0s66ASGXbul/XQUWth4xaNywcoWGztpyj3eFeEwQqOC6o0fWZ90UvQBvRLzlf5doAgD9RkYhVr5IzIeBGmFEacjW0bxBR9UpuFKF3lPDTaVRU/Z09Nxyva+lXLnfiHYFPdKdWjudRNBEm2Ssbt9Du8O96ZCartxAngk5gzQiGuLiNrP7sXeCDC1F+pxUBc94d9q9u18tb2l+8GrOSm9WT4oh+m9MOtIIqt07Zbc1icDAkTvjJIK54qOW7N+qkkD7JDD/WuLS6FJ2sWIltsXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EbFu0dlFHD4ue6c1H0T2HHV4LvGUohbMvaX4FM2L4mE=;
 b=VDiGJWf4HfUqkVOtMvPVP0kTHVJ7GDLnd55ld8mXi3SMZlZ50jLcTZ8o4/nJK6V43AYACKXGNhHwynGLuPfbu5bHrsWupyvARUIyEcLT/t74HGGBXj3sfiIFiJ2mjar0JOTrsd4nnTHpPbiYZ1qjCDUGs+d6XsVGQARvI5K3jfQakerODbO2UeSpDdQwebMqZGCilWRjVnywrIWMaLdaUh2XVjg3gXbkmCJ+4CD+t6Va/qOuXih2mu/gTXqZkqw2UQHeRwdUYi3wN7fn+6zQVGrnqAwNdT/IuLc3OdG7yJWK6Dh1wk8fJDhw/Nc4eYzcSN8HP/4QlN+7Q0tFpk8vbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
 by PH7PR12MB8153.namprd12.prod.outlook.com (2603:10b6:510:2b0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Tue, 15 Jul
 2025 13:29:14 +0000
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc]) by SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc%4]) with mapi id 15.20.8901.023; Tue, 15 Jul 2025
 13:29:14 +0000
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
Subject: [PATCH v30 14/20] net/mlx5e: TCP flow steering for nvme-tcp acceleration
Date: Tue, 15 Jul 2025 13:27:43 +0000
Message-Id: <20250715132750.9619-15-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250715132750.9619-1-aaptel@nvidia.com>
References: <20250715132750.9619-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL2P290CA0022.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:3::6)
 To SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8943:EE_|PH7PR12MB8153:EE_
X-MS-Office365-Filtering-Correlation-Id: 079e2329-cfd2-44f4-79f8-08ddc3a39742
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6UGDJ0SBf/7OcnZ6fM/GqZhOFyckhOWBn8ealDxQeBrSlZgo4/qXS6a3v07G?=
 =?us-ascii?Q?ZSL2/XQt4keW4I/hzo993YiDuZ9x2PMWXRyKPipqOBRA4KqoLGz75ruXVriQ?=
 =?us-ascii?Q?HJSUZB5kr1Vpkph6Mjeyf2UNO9EOvkhvcPSiRNvfdMjuzbsVcUotq7sjtKRk?=
 =?us-ascii?Q?2fulYqKtkXwBSG7SyZwq/OKlHWy0KbIu+mKmH9VvZE38V+BJZStJ5/UatT6/?=
 =?us-ascii?Q?H+8q2giVzGt9CVy8dv3LYIqL1Fc5/zrOwNMHGHwRN0yvhaz1TKRbVpDOqfNr?=
 =?us-ascii?Q?FwTmx9imL0bI0iET8vnMkbOJbUHlhwmnXiNVoQFn3/aBZymstZ0I7zN/CXmA?=
 =?us-ascii?Q?RJLBR+m9W4DEviDwkwquF28B4qHUaLIzBQ5ITyt69Y189Vb+TMGnfvFrhbJX?=
 =?us-ascii?Q?JnpJRYn7x2ZErI5fuqbyc6wl03oKp9pw/d4wem4ye+Tr0PWTMFmwofz98+YE?=
 =?us-ascii?Q?lRqqsZYNMJP+PQjESbr4GSQeAVV6zVKGvjeODZoqwvrN/USBVtbIgh0Tjs8c?=
 =?us-ascii?Q?Sskh/LS6MrYunmytTvgOGQvdD3nkuCmYIE3ri6i+Xh+zLoc1duDyifEJqAdR?=
 =?us-ascii?Q?1luDiO+OCDa4vE5gMqBW5V247Yf9CQgCNrCGD4OTfH95va51nWdkEnFSbvKc?=
 =?us-ascii?Q?7N/WTnRqNtUQuF/MmQunFK8JFOn11ffmxn4RmVte8jETUDSBgqKE36h4MWeo?=
 =?us-ascii?Q?nCU9OLEmyuGVV1bO8CP4bl0wB4TOC4LGzoQzXwWPwppCZuYJVu4wK6QIUL/H?=
 =?us-ascii?Q?RhqsKh1ghBTHqBdxQ7ri0TANY+XzQ4dRaaohqePl7gRCPiN/VqvN3XUbFwyl?=
 =?us-ascii?Q?UfnlvfszKFghS+oRdJFzKGmr7poMnjc0iYxWP/c8nbPWUID4a6ZGAqLvODhG?=
 =?us-ascii?Q?KTeFhnZXnlbzgsX9GuU8/n7Npi60MoZqMFa7MQYYNGtEH8+7w4kmsOokZrVR?=
 =?us-ascii?Q?xXGmEJ7wJIxXTjsa+YNhNrGSZNbrLiyldWOgNkJ4t9rRHDhVoFs6frlmATxZ?=
 =?us-ascii?Q?zV7e8xlYflkowLrLWFmW4TFIzJVhS+ydylRyi02xbtpr4Cd9myx2AllHVI6K?=
 =?us-ascii?Q?NqQi+4ZEj6K4GHIrq7DPs3ZgU4XBTQgFiOM6n3u0tk7WyC72uWoeunpOU1np?=
 =?us-ascii?Q?ekIHJt78JkhcZn6QcdxL9a1Yd/yH0KVs7nkjS/YJh3HypelC/CtVQ8ClIAD/?=
 =?us-ascii?Q?rMz+VcoaZW5yz3OYIoW7gDr2tG5a75zOha+pTtGLAZ2E24K2mU1jAXxvSuzT?=
 =?us-ascii?Q?DhA2iafKC5Wfi7DpNpKTBFnWTqjIarcB8Zw40AKbvncpixTfmuGFHvb5x2Ae?=
 =?us-ascii?Q?l7M011ezo+Sz3c1Iv0pngDAsSbJtw3uvONmj4dnRGbp++qcKk8evxAMHVSpv?=
 =?us-ascii?Q?nBrjrIfghdPFsGxDXxDCfI7+VloA0pwK0aC0H5sr/9qxxIb7GWCobXmg/huZ?=
 =?us-ascii?Q?7Jf6pKjFPMU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8943.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kb8eLz1wqxBODeqmtNdaC2TVRoI1GnQDH+EvVepa+0dOeGPjFvSVr3541juC?=
 =?us-ascii?Q?Q0WsuykF0AUAbPHpWc4pf10VyqBsMnSw9EC3sRjMOdNrGiB0md1Yyj0kSq0O?=
 =?us-ascii?Q?bffTH/CICv8u3r2TRkOoI5hTre53r8Y5VpLWW3O6PwcvRQKrfKQ17VAn/ZgF?=
 =?us-ascii?Q?UJILlnCC+c8pdNERAiV2M0cEkKEV77lqYT7DnXJnfSbnKoWSFSMw8b6iReLy?=
 =?us-ascii?Q?U+JeNNH/D8A6FfEFNAnoLFUDiG+vz28MjYDRDypr+KOBT53XJMyFruWrE8mv?=
 =?us-ascii?Q?fmbi2A6eglr82kNX87zcDzGDwcVquyoVKRXTKHOLc7xY4ITgZRAOIG3i5/Ge?=
 =?us-ascii?Q?MTy4IzoTA+zEmLwgIXDpRNp3cxvFTR7z5VQKq0ft6Sgp0XxG8LctRcBM4oXy?=
 =?us-ascii?Q?w151ftf47+MmI+Ldjm08girSmEXn7p0G40yOrKXJ1xQSWBs9bTifbcPtSY8p?=
 =?us-ascii?Q?XYpIKEV50C7QXPzGXrqu9za31rE3hGl5IA1ABXWlawWt7NpIWbjekCH4QfLl?=
 =?us-ascii?Q?bPrcA23M8IYlNdXeBfB5ZR2uPHbW4U+gu88/hZknL9Ii01GNG8yHtA78WH3m?=
 =?us-ascii?Q?GHHeh0vLICyf81mhi+cWxpuVcfrX9k53odR3aeePHztcFiEJhqRMS8hNqmtW?=
 =?us-ascii?Q?eubC1JZEbyBCe+tn8NDbA2KmUMxzpdWLluqo3ewJmgdetSuDDEH7Ky8cJT48?=
 =?us-ascii?Q?R3zYSo+29m27jqzuxNMZMPn8AdTZ0Nd6MLbM6yBeXlDaGaXBlYWPIpVJD14M?=
 =?us-ascii?Q?QIlwqY9t1uM0XOndrwolnF9CNw4paVt0qfJDZIe7NdoUIbD0MHmnuNMVCAfX?=
 =?us-ascii?Q?bb7cN5R9wN3fJrmtVKpi9Nw3Acn0SG0wAXUmfbfu1pTOMRzkFvmyo7Sqf/go?=
 =?us-ascii?Q?84pYgJw7/PzDxrj7p4Hn71di18mWnRAnjM5fZ6lObmDuVzVO8QxALgzGSioI?=
 =?us-ascii?Q?ZpdtS+xWjbjbYCbx7r6GL7qeBGNVzVC8e3yXH+H8uT5YXR27CH/BnxWMhT+v?=
 =?us-ascii?Q?mEeiJewKBgSwhI8CGBIzo0T7pH13pS6SVqyvx2+x3XzvvfXig6XuRZWlTBfH?=
 =?us-ascii?Q?xBmkkU80SQmWTIjDMKq0r4tXIVnz7MbItJLnFpyPkOmhj/ABuEGZWP41O0UU?=
 =?us-ascii?Q?2IFCZ4rrqWFXkhvrE7XEtp4bSAavg9FU0bHUOggta/936TD3asSNcMct5CZT?=
 =?us-ascii?Q?zsM9hpfDudTFxPaqpZ0vLLTSDSUP8p7xszSHNjQqHzGSGlZ8TndvMo1tbU8v?=
 =?us-ascii?Q?M5k8dyYt1CJvLwtNBguf3jeAzJ13ixowaD1ewrokiV/jpSHuCALG1AFeHNxa?=
 =?us-ascii?Q?ybVoV1ILVdn6ZUktWXF8RFrChNPkoJhJB9XuBUeTa6hp7927UwT4M5mgWvHY?=
 =?us-ascii?Q?8V6WiBdB3CreY9O0nxYR2p2pqEJLSYuiWUUYn01opIdKTMm6/H7KHd4SFgp5?=
 =?us-ascii?Q?cDhYFCnRJn7m4pr1ahFzSLPKqXGAkP017HxO4zMI/lCCWLvI/DN4q/inO3us?=
 =?us-ascii?Q?55NS36bpJj3aPmqm6En63vt1BG58bmeVz1vnb+usTyChYQoUfeSyprFUMGVF?=
 =?us-ascii?Q?mxy6OMl5dNKH2S7zqToRpZp2MrjTIMmjWJdTf3FY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 079e2329-cfd2-44f4-79f8-08ddc3a39742
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8943.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 13:29:14.4527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RYXCMO1egNq7bhavMokOE+yRBolEd27k5URmuQaTcnpxyuUiZFHiAlwO7OvVy02TxN4cTm1EkX7gRGV9tGFh+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8153
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250715_062917_239840_7C26ABDC 
X-CRM114-Status: GOOD (  12.55  )
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



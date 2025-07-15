Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBBE1C83F2D
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Jul 2025 15:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FhMctWATS9+pv1R6IH+zD6h5loD3q4/JyouU8yyBq48=; b=OqxmCl+7QGe4H2cKe2/LJJH6jE
	eQF6ES40oFI4XeMS482/5SuBMQz1comM4gmHYc4OQoSVWWd0rGLCN6B6I84A6LBFOYvrrugPS7Rf+
	ksSQi2BYYyC4m27Gf5iLhJoNer42CaZGxdOOnQXenK4wRLvGaHi26iRtlCpVNhYdzaZt6FhDrl8vr
	JKkvyQ3c7D24/SwXXjm0lFAYi9fTFnMDLva2JH5uyNMmXkRRuydPn0FpmB7C06f0HbwSPny4IwxnW
	sF1O6KTFHqPmDr2+ERI8uasLz6y4M8Q5w41S6IIzBv8oF+PpZVd6OIsM8OOptgMFDRpp15LiBkfKe
	GcF0YV4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubhAM-00000005VOZ-4Br2;
	Tue, 15 Jul 2025 15:01:59 +0000
Received: from mail-mw2nam10on20630.outbound.protection.outlook.com ([2a01:111:f403:2412::630] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubfiS-00000005DAl-0GQS
	for linux-nvme@lists.infradead.org;
	Tue, 15 Jul 2025 13:29:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=czzmsYXR0ILi2E5lWuySlLIKkD08SHsFTxO6pj0xRGkizywM0m8HwntPOFOI9FGp/1yVdHffAMmi5HSc2KiwnONOxic9KLOFNofNm/+8fcOTRN/3S/bu1aFyefz/Kn3RaWiuhvCU0Jr31/R7r+lKlsRMEwME4YWWLNTwlqAP+hbpVHTKziRas2ZI4KNEQZ6RniZSE10oORlguR0ZXB0eJAwY+3LbP04qNGoS1Abg8VjpLs8hQ00SWZN4PbdKDSMjUxUsNfVtqyShSq6nn0C6LBofdhRqTEXPkHAWbEhgz4lBaD80MaRP54mdXVniRqBK8rwI4iRf8AituVl1Zf5peA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FhMctWATS9+pv1R6IH+zD6h5loD3q4/JyouU8yyBq48=;
 b=oU8ktrxcSC9eCKPbzy4kzGLVEfDlTFkwfXyEQetRCIKGiJEraSr85Pj7wLgdWVNjb+0TTQsbb41hRhw5CJdTbNdgOzW0H79DCcfj6Qu6fCpjQ+JMgNUbNScmwJSB3VS2L0svtDMi3dW4vUH/gAk0o2I4H7XBhfR4+b16QOCl9fbQnw4XbBMNLNPCKwxlGOfJ7CULuPHwomCJgaWMzGhv2eFqtf2LDflm8Km1+lzBJVmlIqWeXVdqEDyoRNntJgNXWVBidOFJSTeLV+0+aLwyYgSEL5i4c5ckaKwVtKalAwGNPs/7iEPSGOHOl5pnV0Mao4w1Td5lhEE+xaB1T333mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FhMctWATS9+pv1R6IH+zD6h5loD3q4/JyouU8yyBq48=;
 b=e7RSW0LmVJ/uxhk8TLl/TK1XKG7Mm59zbGsT8pEz/49mOqf2NyV9+bINq+anCbkanOPhUk2mYQoYshD5ROnUqe0Pwo8yUNyFgilqj8xKJGAUi/jmEngQv/lrgnjbhKQZKEow3DnxkwXIKmHeN9OcmcaFm+a9ICRBkKSxZgUogiUtQUMlEnm8DupXlw+dkZnUbnbbD8SuFaYs7or7sWRqrcND8RSSmEXByygUYzKnlXnkAFKAZfUWJpveiCDE+3IAHJofqzEK67bys2LlzmmercMNoLs6X1Od4B+HdXXsnru6bB1cyEqSkFhqOJyObXiWrgk8rPTJA7zZ9tmfT5rtJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
 by PH7PR12MB8153.namprd12.prod.outlook.com (2603:10b6:510:2b0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Tue, 15 Jul
 2025 13:28:59 +0000
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc]) by SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc%4]) with mapi id 15.20.8901.023; Tue, 15 Jul 2025
 13:28:59 +0000
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
Cc: Or Gerlitz <ogerlitz@nvidia.com>,
	aaptel@nvidia.com,
	aurelien.aptel@gmail.com,
	smalin@nvidia.com,
	malin1024@gmail.com,
	yorayz@nvidia.com,
	borisp@nvidia.com,
	galshalom@nvidia.com,
	mgurtovoy@nvidia.com,
	tariqt@nvidia.com,
	gus@collabora.com
Subject: [PATCH v30 11/20] net/mlx5e: Refactor ico sq polling to get budget
Date: Tue, 15 Jul 2025 13:27:40 +0000
Message-Id: <20250715132750.9619-12-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250715132750.9619-1-aaptel@nvidia.com>
References: <20250715132750.9619-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TLZP290CA0015.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::11) To SJ2PR12MB8943.namprd12.prod.outlook.com
 (2603:10b6:a03:547::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8943:EE_|PH7PR12MB8153:EE_
X-MS-Office365-Filtering-Correlation-Id: d783c85b-a6f7-4ee0-f8c1-08ddc3a38e89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vDXwJ1iXQ5tyc5LwHZ/6tReq20dweEphWOCJ3KjKT5uOosOvFkovZUrRExX/?=
 =?us-ascii?Q?+8BBlBpygvviVVwjdZsHWC8TxLNtQJ95bdLhJUCfKAJVbzoFsFQ1XoMVESfm?=
 =?us-ascii?Q?vPwSTRuih+qMRVSkx5D36LVfx0sJVNU80X6H/zfFVeijggdhujCddRj60IBl?=
 =?us-ascii?Q?eZFl9viiuUFuOrcWegy0Mkbc1gQKiQANHkH5t2a9MGbHXuYpF141PUsGTnU+?=
 =?us-ascii?Q?EeNco1mJU0GFTQATi8NLdIVx2TK2JOZmYvWdUSxrOF7qaQc6ROV+WPGmUVEC?=
 =?us-ascii?Q?agbG+bKP4MI1RVQNW7aPcoHWTIQZrstqnK1rECMM77FbNzH7VDIrfPhE7VHJ?=
 =?us-ascii?Q?XipVStza/gb4ViooOEKJjrLm69zCpBL7P8BD3KU0HotFOPTWxs/tJpA4FolL?=
 =?us-ascii?Q?OIQOlg8CueasXviZvYGGsjTFKUuQ233TtgPwCFAJ+JhirHxJ7b/7q4F77G9Y?=
 =?us-ascii?Q?S89dbGLUv5hmErqoCJgcYXBeAi22qB6OPjATkzRn5lgNqYW/A/3JRoaLJ+z1?=
 =?us-ascii?Q?+cJYVaklDzwuwzOiSf2H1c7umD8k5b8XZeR2f20zfjjHZ0BVdz7voDcb1Ks5?=
 =?us-ascii?Q?CxQZIqlM6hiQSpsx+LoL7mfUsaYNiFDHceUeMz8QbJeWX4RACzwgtNuA/GFP?=
 =?us-ascii?Q?6M7mDZ9Qspl72s/uPnHv2+SeRE/nsLVDBqCLJJ1I77siZrNlbEJfydD33RV6?=
 =?us-ascii?Q?A9jJlqagADcNvsUspcgXoawPYhHZ2Zrxi9QOWHpH/fT3N3NYfdq+IUryOinJ?=
 =?us-ascii?Q?BFF80YuSs8DnrOJKMvGCUV43I49XSsL0MrZ/fCdwgol4eQCHUc9K3DKk0FZf?=
 =?us-ascii?Q?Sam+f/4YFwmDkUo4xtFt56ZcQnYY8zYcqDeq1oMfptVZVxiAgh4PmNodYF75?=
 =?us-ascii?Q?TaLEXoj1ppOAYhEtetPCG5nZdB6icKBJJyd3pItNWyo08UEaKFtMUawAPPGW?=
 =?us-ascii?Q?aloQSmZ/V/ehp3QtYVAHaHD0f0oK5fLnb/rAjK8i0Kjd/20y56R9Dq2NRA6V?=
 =?us-ascii?Q?SIC5SUgqfFYiSpJRGyq4eOq9lLEM4aAmIVLCJ4NTP1HctL7Qhnf+l6DCaHpU?=
 =?us-ascii?Q?irqby0+8Xc10eHDd08KkBZE+LqJ3visa7JdqqJPGGhjvNWbNHECos+SRyqU5?=
 =?us-ascii?Q?gaCDD5Gp/UJ8oSlZ8SCoR5xymXIm8srVuvVYrKqzQSZyq2OLqMIUC9onCmH0?=
 =?us-ascii?Q?GsTgr2pA2/4Kd91iT4xaH7SzOliFnOCbO05vpd+pNPdRpcCfjWVUg7UTzg8s?=
 =?us-ascii?Q?IWQJ2cSSNGENcOJabsBwWVDI+IIvlHSoRVMjpWONiGRGGXoj5DdTsQsJGlH6?=
 =?us-ascii?Q?Y6Hz8fiPmBNmRYju2lBUfsz7z62PSHF26ZPzkC67ugb488DyhHyASjX2w77B?=
 =?us-ascii?Q?1OwLPSgr46wC0pRjRylJQvz5FJiEa4DfzSdFQvYV2nF13uz0kUNY5MMYFGZZ?=
 =?us-ascii?Q?uFXVPOjE+mY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8943.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3ItqmW7cgJuwLVyuXGUTQatBQZtG0oHjPEg7llBx+QeuQC5WFCCct0W73lzO?=
 =?us-ascii?Q?ldeKjKArVUDN7y8yXkQGtgi/Lgu0awnQzl1GesI6uR0RcA+qAcPfPumj36h0?=
 =?us-ascii?Q?1iz9W5zdDCzhhVB+O+a4r0F3GeJNVNvNJhmCs9lUEPLOoPaluHB1jkcMfpVB?=
 =?us-ascii?Q?m1yC0Nv7r8dzDfvKScrclMUHKXgZumT7+jRcQPBpRRYCTMYMPf6AT2c9w9GL?=
 =?us-ascii?Q?XF79R+xza9Dxev11QhT3Fhi6Ie1Z82qDYyo9vXLOTZVHILEi/H2+NIhbeupy?=
 =?us-ascii?Q?bD43vdDZcxRCRBlKTnhqmcCboBWJG5owBldOEjEqLuBwkyMKYBIBEU4GpcpW?=
 =?us-ascii?Q?B3DntH2fbIMj96T3Yn95FTVZyJ3+QNuwt4Y/LcTMFxIg9N33zyQSeKj9UVih?=
 =?us-ascii?Q?3EQ4wIe0fMcuDOajPD8Ac07pNsd88l6Px3UWXYS4QNF1YnZDR0fjTdHSmewj?=
 =?us-ascii?Q?1ja9HYgTYNJptKSN+YAc7odmxCNPQ9VtUY8EukrE7ed1aE7503yODBEb0yhe?=
 =?us-ascii?Q?WLj9gNi6eVbs0eKR89HQPGOGKWcZSk7cP3RDcqPz57MDEkZ8Tx6+OfNXzy7s?=
 =?us-ascii?Q?90AhOIJYLiBwq1RNOzRJFwEJrVkVb+QuYVPeQj1a1coFfDxexNZfnr51wNfw?=
 =?us-ascii?Q?Pk6jZmR5BaG1WzMIM89/KcuvAIrHz4T3zAC16wAen0yw3c17ThBqbh3Yce7x?=
 =?us-ascii?Q?jk1y1xvhZfANQgEHZWyZeyGtFF0JbSh8uiUip8dVDIXANYmYU9Tcl4VKBhPO?=
 =?us-ascii?Q?49avJObpRPgkTUV9qXwLnhuECqs9TyV1z5F5jCF2m4q4+meFfeccjLJM67r9?=
 =?us-ascii?Q?DOVXpUQq3vq7RW6zB9F7EfdEKPOBsPWMqGjSfRBoHEoo2nAab9GGN0CZ2xsJ?=
 =?us-ascii?Q?cNTcroc4ZbyqKyshY1J0G8SkCeaNV3nKE5lVvhfi7s/jIrTBRTz4/hcloAVX?=
 =?us-ascii?Q?yhnnIf+YyRRlYDnE7bYZNJLFFB6tUSNP3a953X+POFeL+GwRnl6fGChagvEq?=
 =?us-ascii?Q?GJ2xqFRxBdHLa54F8u535DvliR7JQXKznBEAmBJ5MSQeQNNHTuHXAGnaV6P9?=
 =?us-ascii?Q?WCAh/942ZeYgc6MEY+2Re/vvF3l07jIzuflQZoSe1mvvJLkKPkCv5oz2mbax?=
 =?us-ascii?Q?TvybbksIBBb0nY3NkJKv0SmSMCfLPuvjhexHvbwGfYLNLGntU9og4k8o8A6S?=
 =?us-ascii?Q?3mTmLhBS9uOIKJZgBIrJRq7uZRMXQ5+gzaWdrFEB8uAbFdrYCPr7DTbOa+jM?=
 =?us-ascii?Q?GHMCo8/1OLjS9txP3kKX0BR+xByvw9rtgB80+ih3K1LxylxR/wV+dP2ZiUA4?=
 =?us-ascii?Q?eevsDx9vTi9/IGKzGhMaL9P/TAohp7jzn153YbC71s9+zI16WoeyVoxWc7vP?=
 =?us-ascii?Q?VK61X8uTf5DIt6BYShmeGhULk2bLCrBZOVBghQlL+yziGe1UXmtn16V9flvu?=
 =?us-ascii?Q?c9YJ9J11pK4tCZaq27lv/6sxuBlhHeD6HNvs2knKy7q1Et8eDY1GQP9UFQQt?=
 =?us-ascii?Q?FOdwm7DioC1rP0Duwu19QK+tRfRWU5a+wL4EIJTGACWoHxbcCEDMjmXD4tp2?=
 =?us-ascii?Q?EZFIBouHNznauoZNHzxdzlPfq7lQ3/s4vRDh6jrq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d783c85b-a6f7-4ee0-f8c1-08ddc3a38e89
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8943.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 13:28:59.6392
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ifwavZYARtpLSBApoWqhWI3pvLZ3zmjKRB/5158W+aEFGFLbqrGQXv6/BcOxVPqHeGblR6g2a5cs3jz2yPBSYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8153
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250715_062904_107106_35323FC2 
X-CRM114-Status: GOOD (  15.83  )
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

From: Or Gerlitz <ogerlitz@nvidia.com>

The mlx5e driver uses ICO SQs for internal control operations which
are not visible to the network stack, such as UMR mapping for striding
RQ (MPWQ) and etc more cases.

The upcoming nvmeotcp offload uses ico sq for umr mapping as part of the
offload. As a pre-step for nvmeotcp ico sqs which have their own napi and
need to comply with budget, add the budget as parameter to the polling of
cqs related to ico sqs.

The polling already stops after a limit is reached, so just have the
caller to provide this limit as the budget.

Additionally, we move the mdev pointer directly on the icosq structure.
This provides better separation between channels to ICO SQs for use-cases
where they are not tightly coupled (such as the upcoming nvmeotcp code).

No functional change here.

Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h             | 1 +
 drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c | 4 ++--
 drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h        | 2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c        | 5 ++---
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c          | 4 ++--
 drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c        | 4 ++--
 6 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index 64e69e616b1f..3c291f7d5c39 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -547,6 +547,7 @@ struct mlx5e_icosq {
 	/* control path */
 	struct mlx5_wq_ctrl        wq_ctrl;
 	struct mlx5e_channel      *channel;
+	struct mlx5_core_dev      *mdev;
 
 	struct work_struct         recover_work;
 } ____cacheline_aligned_in_smp;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c
index e75759533ae0..89807aaa870d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c
@@ -46,7 +46,7 @@ static int mlx5e_query_rq_state(struct mlx5_core_dev *dev, u32 rqn, u8 *state)
 
 static int mlx5e_wait_for_icosq_flush(struct mlx5e_icosq *icosq)
 {
-	struct mlx5_core_dev *dev = icosq->channel->mdev;
+	struct mlx5_core_dev *dev = icosq->mdev;
 	unsigned long exp_time;
 
 	exp_time = jiffies + msecs_to_jiffies(mlx5_tout_ms(dev, FLUSH_ON_ERROR));
@@ -91,7 +91,7 @@ static int mlx5e_rx_reporter_err_icosq_cqe_recover(void *ctx)
 	rq = &icosq->channel->rq;
 	if (test_bit(MLX5E_RQ_STATE_ENABLED, &icosq->channel->xskrq.state))
 		xskrq = &icosq->channel->xskrq;
-	mdev = icosq->channel->mdev;
+	mdev = icosq->mdev;
 	dev = icosq->channel->netdev;
 	err = mlx5_core_query_sq_state(mdev, icosq->sqn, &state);
 	if (err) {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
index 6501252359b0..5aa5b5833c56 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
@@ -83,7 +83,7 @@ void mlx5e_trigger_irq(struct mlx5e_icosq *sq);
 void mlx5e_completion_event(struct mlx5_core_cq *mcq, struct mlx5_eqe *eqe);
 void mlx5e_cq_error_event(struct mlx5_core_cq *mcq, enum mlx5_event event);
 int mlx5e_napi_poll(struct napi_struct *napi, int budget);
-int mlx5e_poll_ico_cq(struct mlx5e_cq *cq);
+int mlx5e_poll_ico_cq(struct mlx5e_cq *cq, int budget);
 
 /* RX */
 INDIRECT_CALLABLE_DECLARE(bool mlx5e_post_rx_wqes(struct mlx5e_rq *rq));
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index fee323ade522..ba3b5c9266a0 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -1587,6 +1587,7 @@ static int mlx5e_alloc_icosq(struct mlx5e_channel *c,
 	int err;
 
 	sq->channel   = c;
+	sq->mdev      = mdev;
 	sq->uar_map   = mdev->mlx5e_res.hw_objs.bfreg.map;
 	sq->reserved_room = param->stop_room;
 
@@ -2056,11 +2057,9 @@ void mlx5e_deactivate_icosq(struct mlx5e_icosq *icosq)
 
 static void mlx5e_close_icosq(struct mlx5e_icosq *sq)
 {
-	struct mlx5e_channel *c = sq->channel;
-
 	if (sq->ktls_resync)
 		mlx5e_ktls_rx_resync_destroy_resp_list(sq->ktls_resync);
-	mlx5e_destroy_sq(c->mdev, sq->sqn);
+	mlx5e_destroy_sq(sq->mdev, sq->sqn);
 	mlx5e_free_icosq_descs(sq);
 	mlx5e_free_icosq(sq);
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index 2bb32082bfcc..f4c8c3f3c0d7 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -993,7 +993,7 @@ static void mlx5e_handle_shampo_hd_umr(struct mlx5e_shampo_umr umr,
 	mlx5e_shampo_fill_umr(rq, umr.len);
 }
 
-int mlx5e_poll_ico_cq(struct mlx5e_cq *cq)
+int mlx5e_poll_ico_cq(struct mlx5e_cq *cq, int budget)
 {
 	struct mlx5e_icosq *sq = container_of(cq, struct mlx5e_icosq, cq);
 	struct mlx5_cqe64 *cqe;
@@ -1068,7 +1068,7 @@ int mlx5e_poll_ico_cq(struct mlx5e_cq *cq)
 						 wi->wqe_type);
 			}
 		} while (!last_wqe);
-	} while ((++i < MLX5E_TX_CQ_POLL_BUDGET) && (cqe = mlx5_cqwq_get_cqe(&cq->wq)));
+	} while ((++i < budget) && (cqe = mlx5_cqwq_get_cqe(&cq->wq)));
 
 	sq->cc = sqcc;
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
index 76108299ea57..af0ae65cb87c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
@@ -179,8 +179,8 @@ int mlx5e_napi_poll(struct napi_struct *napi, int budget)
 
 	busy |= work_done == budget;
 
-	mlx5e_poll_ico_cq(&c->icosq.cq);
-	if (mlx5e_poll_ico_cq(&c->async_icosq.cq))
+	mlx5e_poll_ico_cq(&c->icosq.cq, MLX5E_TX_CQ_POLL_BUDGET);
+	if (mlx5e_poll_ico_cq(&c->async_icosq.cq, MLX5E_TX_CQ_POLL_BUDGET))
 		/* Don't clear the flag if nothing was polled to prevent
 		 * queueing more WQEs and overflowing the async ICOSQ.
 		 */
-- 
2.34.1



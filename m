Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00552C05027
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Jan 2023 16:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wSxMHa7YzER6/WmeunCHCpF7RS7He1WuqZJEis+t3Yo=; b=JNTCxyAGU3IOJzxkF0FaUA9WZQ
	KdrRWgV/HJG2YTADCt4F7L5UIlwhGuWJq/GCN9Yw2LVucjZof6Z8FRA/YppLKIHFffg6WN0+p6O19
	ciX/kgq3xEG5djZD/nxNMCRTz45sYKCevJ2xptVIbbGoa6h64wBSWQPkXzzeolXQPrgOqktGHMHGu
	TDi7+SrHWjL1p+Q6/xLS9H39VJAn059OZBWqiK5JcNuKHQoIr00n/veFSzDkj9lN4MuiJNSj+fmHj
	qi6mvfEJ1nH51lm9/B+0yBRm6PnmOEsrEFP5Ccku2TkuKNrvh67sx9RIgVpYpLIWY9NiXdfDzUyeG
	HpaLUF4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pL56S-00Blb0-NU; Thu, 26 Jan 2023 16:27:56 +0000
Received: from mail-mw2nam12on2087.outbound.protection.outlook.com ([40.107.244.87] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pL51y-00Bjon-39
	for linux-nvme@lists.infradead.org; Thu, 26 Jan 2023 16:23:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tof/WJNZr+p8tqnDtUgkUnrITPsKMLs9j0ydaOtFT8Z8I0V4/uTqkc/Hr5uzAJoCLm1hWynJtqP+ZEpsvcz6nJoLxxHIBUI7LgNOKse89sjM0JyktYEgsM4ZU52NqZMTduIgjnM4WOhECtDQFJiYZe9YGoBq5RGtsAjQpTSnu2Z6cBtr43w11T5irOaI+MtRqZ9id/SXkFPxWJs6X8htw7hP5ZZdwilo/7JMjfNPmtcozVJVDu4AwkKwy8mH0faZUxELG6E5Rn39DOAnW7OsW5OZurrmzJdxPSHExECjzO1UcAamzKhFhFUCt1ihxi7JAGbFdGQ3nsoh67e3F2TBIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wSxMHa7YzER6/WmeunCHCpF7RS7He1WuqZJEis+t3Yo=;
 b=J3XpoU1G57gWPkahWR7t0/+3dQevFeKNfsnt1BV5YlRe7y+3hql0DjUkC9IB75oo+tT2aaGxlj/UyApSIWHdxvV/pFsN6QjnKoSsSTVsxPl3fTKNE8xyn4T0kUW4TvwgoiNeiBAtInzi4enge/VDR4Dvoa+zrzh/bwnf2ugm3xOGgYnroQYK0MvQkT5QAET3P+fInFPfZa4ij8tyRTpWcL1R60xhtAdIo2ME/HKoudN1yi9HDw/h6r9MXFfcXeU6+600RLfrCi69PAdeAiC+OvFhv5Tmtaqtt8Ar07GRU+jWxqN8YkxAQY4LP3R/RpDTmS7LI0jW7Lwv0OHeltorDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wSxMHa7YzER6/WmeunCHCpF7RS7He1WuqZJEis+t3Yo=;
 b=Q6htxWKU9e4ul50kHmuq7XXWt5UmAyI4Maut/86Z+k82+XxD2ohYL+T6eoa58EveG966e/EY9rD8rqAapEf7Q3YwAt+v6QPZGuER2b7DDVQ9Y3jDrrkGPuKYUasH8NExGzs4DzjX6onXfjXq0q+R4F2snZoqkOiYf4GtF+FBorevrV4GI7m4AldJ+H+7KbbazFzaAZK7YcSv8O3SDYTKn6O7mI7KUnxm9wUbHDwFxftINj4JDCv0vKSPUdFkCVB5POzCtWEFF8LjkGmyqBehp3B0Iuy8wuivMFPhbO1OZcli7IWvGszExfTtVPoZX/fJNRj1rhgsf9F2qd5RP6EfmQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by CY5PR12MB6180.namprd12.prod.outlook.com (2603:10b6:930:23::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.22; Thu, 26 Jan
 2023 16:23:15 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::9fd9:dadc:4d8a:2d84]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::9fd9:dadc:4d8a:2d84%6]) with mapi id 15.20.6043.022; Thu, 26 Jan 2023
 16:23:15 +0000
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
Cc: Aurelien Aptel <aaptel@nvidia.com>,
	aurelien.aptel@gmail.com,
	smalin@nvidia.com,
	malin1024@gmail.com,
	ogerlitz@nvidia.com,
	yorayz@nvidia.com,
	borisp@nvidia.com
Subject: [PATCH v10 14/25] net/mlx5e: Refactor ico sq polling to get budget
Date: Thu, 26 Jan 2023 18:21:25 +0200
Message-Id: <20230126162136.13003-15-aaptel@nvidia.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230126162136.13003-1-aaptel@nvidia.com>
References: <20230126162136.13003-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0054.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::18) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|CY5PR12MB6180:EE_
X-MS-Office365-Filtering-Correlation-Id: 416704bc-a68d-43cb-bc76-08daffb9a049
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	iFU5ncHUtXwfpawc6keJ0Ujt23+htR5SuRWrbdbd6va5slx8XJQjLStQN1SCDhQRDXKE/eOUnO9bXYew/+tZJ5b542D7aJjsG4m14twIharIN9FL8yqEPxHQoLwUfMzfOpIFQqSxwwwgyyFjJXczT0aMMxFXAnr5Bz+CvobZkBHvRoYN6x7dMFVR0ws7RQQFHRMNs8SDWv9F7GSG3yubQXf2Ry1Pf4izqx7deKf/uqUuor8TqgsAtooDTFspd+yaRzZCyve2GNI4nJmK5xtUcocHx5XNC2vT49YccHb1nA3sLfh+C/W9wJBnR7nXn6ixs4ytXVZaGK7CW96YeUalU7OR0Ne6aZnc0CtqDy+HtM5ad9ZzCQTYVooSYyvjqrX6fowZSNMUAfvDIRb4qMhkeHlcPlgbrpSqUnmMFW2R3ULeyOIpJjTh18lhjXRmvQEyYWF7wo3/JQmTvOa2JoPpXiIj7yrxoA37qBVNANh/bc+TFLYCzGM8P+iHr6Syqav1vn/DaSVfekfYPiElIskAlU5+xS7arrh/XmIjAEseYRMGwm+CuOeDSWb4K/ayYKc5XMb9JsbOT/Jlq+N/5GphwbQudLV6mUTH6/8SActwVFIVedP+I4ttARhNP9HzaFnbxy6aLfoK1g68Rf7bM8QKtQ==
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(136003)(346002)(366004)(376002)(451199018)(36756003)(8676002)(316002)(478600001)(6666004)(107886003)(1076003)(6506007)(6486002)(5660300002)(7416002)(66946007)(2906002)(4326008)(66556008)(66476007)(8936002)(41300700001)(38100700002)(6512007)(26005)(2616005)(83380400001)(86362001)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?us-ascii?Q?N8dkcuJI45aQG34xumFAG4hmwC99xchTWdBluiarlGoAe8iHvfA09Kt2OnjR?=
 =?us-ascii?Q?48Nq/PNoo8Mbt/kUJG3qELNj3Vo8skMsH/x2xYPqi5lL0tVFSeZ4slsF4SxO?=
 =?us-ascii?Q?ZpDZDB4OLS4Lc5K6nsXj/icF8xvIZu8bgVuunk8IPHfy4A6XI8z5nPlYkWJU?=
 =?us-ascii?Q?sseq9fPEqAwvVSEe0PwURAws4OH33N6NhFv7lVW48K7pCeRCSrHkmwCrsIZ1?=
 =?us-ascii?Q?3tWIYEJtdMxxKjfdbw+IVYfcCV3mPneIxLakH+KnkfG5QrajZRIZ8f2P//SP?=
 =?us-ascii?Q?mQfEOjC7L8N/O1VdYua6txTA0kO9rP+E3qeqlH1uDOEtZGA7MuZ9bOmcCUSZ?=
 =?us-ascii?Q?YTdPhyYMYVuS8NYAfR0V/YuMESHRaDnPPnCyy+q++witTDzOAb73V9tO6zbD?=
 =?us-ascii?Q?VbV7msT+GV10d93CzIQg9KIMbluuzrPVdQu8kTIo1vxnaCtvm62b0Qw73yRC?=
 =?us-ascii?Q?s30+DxZk1uXNr4mn7aa3yGp/+HpWqoWLTRHU4pgMl/aUZkvanrjEimjxq5XU?=
 =?us-ascii?Q?JezA1nHFxRbhR3qiXkmHicpEcpmkQ4ZHLevlE8/ppJQkcvsGqMXlr9VSoGWN?=
 =?us-ascii?Q?InlOXG9Is80RIJuOLtPgQcLiggm9B5FgcftEk+ru0ZPSukQxyFtBXrymaIX4?=
 =?us-ascii?Q?7E4baeFBxsscDMHUlSILEXArGLRv5xC3L/45Fl+z9gb76N2RRArkVwzOZzPz?=
 =?us-ascii?Q?7kpIsS34Goo/FXJ2JJcF0e0ZHmFIYTFnvexaeMIAccg60MtHsrTZA4NWzy0Z?=
 =?us-ascii?Q?AvLA15fz9EVlCDPHqG4AX4XShuaVBcBCi6KDWpDYscF7xZHzVVKW7xBHKA5r?=
 =?us-ascii?Q?XNFO8w4/6+ap0y6Y7kKGJjapjYmnzpAW1u2Put9EkY0qsFDjg0krmntKHo6s?=
 =?us-ascii?Q?H80PIhiSGiQIcU2cuZU8q+dKi1vqBRR6XNa7kZON9yXTt7vUnFhBG7vpMPnW?=
 =?us-ascii?Q?4aqb3b3ABGpttAie0D+m78Oq9tQWbI5sQgdcXn4XVzSYTfuFfhQlL39Df6j/?=
 =?us-ascii?Q?WHyOULCJvdyPe6PpaZdH4OYu8Plb2oMCAHu0XL52dW5EJEowko/JW9Oqw8hs?=
 =?us-ascii?Q?jj6XpIMhQ/BmPSjbcMLIs+cXLzHuQwtofDurtBRoZLLddWqB9yGqaTZ1IjzZ?=
 =?us-ascii?Q?apZGGunUKHlK9/GBoD8PRW17YA46ggFY3NIXnoMC3ltjE1qheLDUGfGih69M?=
 =?us-ascii?Q?hKLaRr/pGvVAA/NZTIeUOdM9qyhug6My0Vf15YpzhROFUaexd+EIJsdNA5Ci?=
 =?us-ascii?Q?k0i3MDDjObsZZDZQycWTva3/6eHOeIepdrxmXriCOKOJq7/3S7Li6g/c/U2B?=
 =?us-ascii?Q?kqEnW15EpliYwOYC8B1BErRqdeCkOX87uRgKNT7Nd5sVBtvPCVspI8tzzoZt?=
 =?us-ascii?Q?5ZyBXa67OGXWod1FEIUZeLomrg+P2q5GbjgOw3kTiJ4/9RQKLkfZJdD9kici?=
 =?us-ascii?Q?zZumGqu+1+v+T+HJMT/q4Y4/qalcEmsnBtmxtEoCCecrVZvW33EbpcafABH0?=
 =?us-ascii?Q?lH/m0CTjZwRMh3BNnmj62wDMrwAkcHvEbVgnL1Vn5pAXlRY6FHk3qPKJqsaQ?=
 =?us-ascii?Q?95bw2/3WC/QQ3pALxOwZNVpbNyL7uMsQxyoJhOfC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 416704bc-a68d-43cb-bc76-08daffb9a049
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2023 16:23:15.1127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hds9azqyldTOn5uyzJES6ncdvQPUqqTt/GpoLZrfoeTsfNtpDXNWKYFa9VsLc4iT3EcvkX2zglIeVtLzvPIwlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230126_082318_192707_77CADF8F 
X-CRM114-Status: GOOD (  13.88  )
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

No functional change here.

Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h | 2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c   | 4 ++--
 drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
index 5578f92f7e0f..1d66b858db00 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
@@ -62,7 +62,7 @@ void mlx5e_trigger_irq(struct mlx5e_icosq *sq);
 void mlx5e_completion_event(struct mlx5_core_cq *mcq, struct mlx5_eqe *eqe);
 void mlx5e_cq_error_event(struct mlx5_core_cq *mcq, enum mlx5_event event);
 int mlx5e_napi_poll(struct napi_struct *napi, int budget);
-int mlx5e_poll_ico_cq(struct mlx5e_cq *cq);
+int mlx5e_poll_ico_cq(struct mlx5e_cq *cq, int budget);
 
 /* RX */
 void mlx5e_page_dma_unmap(struct mlx5e_rq *rq, struct page *page);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index 3df455f6b168..51167f000383 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -916,7 +916,7 @@ static void mlx5e_handle_shampo_hd_umr(struct mlx5e_shampo_umr umr,
 	shampo->ci = (shampo->ci + umr.len) & (shampo->hd_per_wq - 1);
 }
 
-int mlx5e_poll_ico_cq(struct mlx5e_cq *cq)
+int mlx5e_poll_ico_cq(struct mlx5e_cq *cq, int budget)
 {
 	struct mlx5e_icosq *sq = container_of(cq, struct mlx5e_icosq, cq);
 	struct mlx5_cqe64 *cqe;
@@ -991,7 +991,7 @@ int mlx5e_poll_ico_cq(struct mlx5e_cq *cq)
 						 wi->wqe_type);
 			}
 		} while (!last_wqe);
-	} while ((++i < MLX5E_TX_CQ_POLL_BUDGET) && (cqe = mlx5_cqwq_get_cqe(&cq->wq)));
+	} while ((++i < budget) && (cqe = mlx5_cqwq_get_cqe(&cq->wq)));
 
 	sq->cc = sqcc;
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
index 9a458a5d9853..9ddacb5e1bf4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
@@ -176,8 +176,8 @@ int mlx5e_napi_poll(struct napi_struct *napi, int budget)
 		busy |= work_done == budget;
 	}
 
-	mlx5e_poll_ico_cq(&c->icosq.cq);
-	if (mlx5e_poll_ico_cq(&c->async_icosq.cq))
+	mlx5e_poll_ico_cq(&c->icosq.cq, MLX5E_TX_CQ_POLL_BUDGET);
+	if (mlx5e_poll_ico_cq(&c->async_icosq.cq, MLX5E_TX_CQ_POLL_BUDGET))
 		/* Don't clear the flag if nothing was polled to prevent
 		 * queueing more WQEs and overflowing the async ICOSQ.
 		 */
-- 
2.31.1



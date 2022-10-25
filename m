Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E33EC04A95
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Oct 2022 14:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Uzi5joSDMAOMVKgUjEhcUpTyHX6iFpGB6ntvygeSvCY=; b=kXy8R20KSNntkJtGtx4jbTBATI
	KvQYPfpiv+uEqVpcgGXXLn7wG5NrwfDbztd//UnI78AQPafQbA2afg5h5C1sJQOvSbtZbOveeRr98
	qqONKsfGRrVWxYTDdVHw0TyfvxYCfbr2Y1CND68M0lAGBdkGNAd5biFA9BG06GQYY05JNuyexBNmn
	H8zlw+5CA2s4aG6XL9piBVp27qRcxVMic7faQX5lAQyHUBVB4vlObR/h82t4h3dzM4cQ0gA6RIeuQ
	6OvikH0t51WHZo27G/TrgydNeBJA49fClaFCph01tztsJHNBtUAcnP48206qm3QP5d/tWG7K2lKrZ
	sX3DfGaA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onKWP-005fMg-1d; Tue, 25 Oct 2022 14:03:13 +0000
Received: from mail-dm6nam11on2048.outbound.protection.outlook.com ([40.107.223.48] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onKUY-005ebM-72
	for linux-nvme@lists.infradead.org; Tue, 25 Oct 2022 14:01:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RseIdkZDweVGzORM/zl0SVnXj1VXx47n/xIQ732ZpqD3GJ/3asmaWChYWCSrzrF7eIZDC6LOABaRaSq59uzjavOkn+FmS0QUObtVSjDKkQ/KAGUI0X8G0YNio3DuuOulY8o1JVawDw41iSzqxUdwjwqKMvYw9rqRb4xWbdnIHs48VJeBHn4OTLS2IRBtmFWxzWOGuWc2xhJ/aERvmaSK9bLGs/jMKgLx+jSb93ss7c6wpP/1LseQhYYOMtLKwi5DKGPmycNw/D9o9pPcOh/XBY8pE0JVnllBBBi+VXh2CPoL9Y21OEZzdBePvobp+By2lXmY/xmXgfW5rhKQD7ceMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uzi5joSDMAOMVKgUjEhcUpTyHX6iFpGB6ntvygeSvCY=;
 b=Cf4418VNoFmtZH5IQe44zzZNEBOwkERIeSLFmVLJ5abp0A8oStXbhbha1+uzn8PBPQhA+iSVSTdZYOcTV60bcsyp4Lgc5DVb9nAJ4QHnoj3Xa1D8H4CwBcDfXrdBFI094/2pz59H3KpeZPfZihE4RJev/r+VXyjjjrkKOqu7mDGufv4nZIuRgMzG8965mg+B8ZwHq/1dNO3kqy2/M5OyuvLGObLgj9oGsVcL5u/T3zwUevxmVfVSLdTqZAH3d3EyJTpkEEvD8jKuam74oCVzhvpYoSyqZxRD2y5OtsDe+4dYM5EvB7m1U3izhE2WMjvS/aAAsV1QPYi+n6FyFi5vNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uzi5joSDMAOMVKgUjEhcUpTyHX6iFpGB6ntvygeSvCY=;
 b=QJoVhEZ6gaAzieKCANxnu5qT6oI1XwM2bddgP9z9+VYiQwEFen2lIMsP6wGXGXZTdKDIPrUCVLvamFE0o8z1xlCKhb6QEhObVzMBbf3E/9B8vtFfoPlPEHNEjIz5IG70pvkOqOL9ujDFN7GKxGrLJYmaxS/4DJROhApnSKbfujZlwJkeRO3LydMEQ/KsG2312jGHocUxZoxFKAzx2NUobC7L3KOlKdbpIvZlCUdL/8faVrRQVOINfZ0c2bRfqWMndHNwGhgDy34ncFsE6Zz9TTRsKSQqOM+GA0SHxwkKIbUGKHT12tafdWRwBC1hHgaV9lbx7jUlDoo1yknXmIwMYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by DM4PR12MB5279.namprd12.prod.outlook.com (2603:10b6:5:39f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Tue, 25 Oct
 2022 14:01:17 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::6713:a338:b6aa:871]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::6713:a338:b6aa:871%3]) with mapi id 15.20.5746.028; Tue, 25 Oct 2022
 14:01:17 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: netdev@vger.kernel.org,
	davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	leon@kernel.org,
	linux-nvme@lists.infradead.org,
	sagi@grimberg.me,
	hch@lst.de,
	kbusch@kernel.org,
	axboe@fb.com,
	chaitanyak@nvidia.com
Cc: smalin@nvidia.com,
	aaptel@nvidia.com,
	ogerlitz@nvidia.com,
	yorayz@nvidia.com,
	borisp@nvidia.com,
	aurelien.aptel@gmail.com,
	malin1024@gmail.com
Subject: [PATCH v7 12/23] net/mlx5e: Refactor ico sq polling to get budget
Date: Tue, 25 Oct 2022 16:59:47 +0300
Message-Id: <20221025135958.6242-13-aaptel@nvidia.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221025135958.6242-1-aaptel@nvidia.com>
References: <20221025135958.6242-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0127.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::13) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|DM4PR12MB5279:EE_
X-MS-Office365-Filtering-Correlation-Id: fa7b0d85-cea9-48b6-f399-08dab69162ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	056JDJLpeTzl5fuAke5MSLNPV2vW+2tLuckKnMclSqd9hnJgbcrxc3rGsOYZL80qEO0PZpmfDJ4QraRhg/oC/nrMZcP7WBAKzTukqzcTWRhkpa/BNsBY5XQtYHyPVrrKktVjbWVv8zgjr++nJy5VOeu+TN2bufyeUQ53zMnVIRyKOYDYG/Rki/tRpHt0xnXC7fhzmtuUyjxUClk8sqZ8PS+2r2dqm0B+yz49OWJrfBLs3hjFHJlClD8SleVwl+Ptk8QPqZ60YiUSAv9t+rvVpHT8yXdq3OE0x5Pzm11SE+EG1XUVxcOKeQmp7v0KZyA+3drJI3TcxdA0wdp2O9ScZnCC8k62rWBSfN1F4YVw5mkX9WRF4BO0nBUCPrX9Vg5oZzcjsK6ND6llgAACgWfgVBKf/tdbp+leYapxe+wBvxvK5qk+JV5+KcJXvOajblli77ip72T//C+5q3Ra+XEFxO6YfEw/MbZyD0I+dqINF1Jkk2j1KJPe3/YQF2F8rigMmV2u4JrkwJpbYiDx/8h1XhV8l8QcR19fgbmANe33K4JolzORZymBrvYl3VJN9ZY6qMOZuo5XS5OMhbt/Bv0Jdnv6Wl4vy4po6Q00yK/jZx+krP2f3d+HvM2zdR8aubYMcgT+ECriGj7dPli65bQfLMv/dmBmlj3SoCELauDbXACUhIKlKY3+SDPCnM0nhS/tWFrOEza/kwvTtPMrZsHqKuW2UwjayCaXfnt2E+vCYXGy8Bn1IuVphzjL9bBKbDj4
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(376002)(136003)(39860400002)(346002)(451199015)(478600001)(6636002)(921005)(6666004)(316002)(6486002)(6506007)(2906002)(36756003)(66556008)(4326008)(8676002)(66946007)(66476007)(6512007)(186003)(41300700001)(86362001)(26005)(38100700002)(1076003)(2616005)(83380400001)(8936002)(7416002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?us-ascii?Q?1PhAnNoL3hF2aCf4gbKakhAU/oX28fGaXQ50WjMR1wacsAWWGTOBfHGVAStM?=
 =?us-ascii?Q?wrvkqxzGHuL0ODwzjKJtU/PjO6kU7+wxyNYWQeVSzZC1yeE/9dLknKM8fKTH?=
 =?us-ascii?Q?TPkNXQBK5WE8CJrkSFlu0qrUK2s/qVkK8v7rfw3ksbbZe52wiLDCjQgmBGL5?=
 =?us-ascii?Q?BHw2rK10fhKYIU5zD2+9tw9lJ4jsYjnrMpPJsUKf/8lFW6glk48WTToQ3Flt?=
 =?us-ascii?Q?G42KdwDtn9tcPNmv0yvRQwLGRKck0aX5kLF0sLZD7tPb7kbJPN/Qc4wqJUDO?=
 =?us-ascii?Q?y+MjWBI2V5jh0xp/KQ0b6laDgDAPgNvrUqgpNrBonOO5+LZhewaf1+6xS9TR?=
 =?us-ascii?Q?Ru+2dbXwwKKrVNDjdJFiyso18CG1WwOfNgPRl0UpKdEWvop0idK9CKPmvdts?=
 =?us-ascii?Q?4z6tu5rUMlv2M1ocuxhWTxqcxuZT7APgq4UcCYi8Gbc/DdjCDvHL3h1ddt7L?=
 =?us-ascii?Q?jWT9Xk1XbMF3MO179WBBnQIZEGS8oSaqfzZRAiNX4puPquH+tKvuGHVhW9Yu?=
 =?us-ascii?Q?UYhIDUxWfrE5vsAYzMQa41BaUB8K0+bJBAQLQGThsmYlD3hhi2zgPaZluuXt?=
 =?us-ascii?Q?7IFW25YR9SUIpsfalp71mZE893v++VVCioQ4P9HZuRYr4afGTbdIMXPP9GXU?=
 =?us-ascii?Q?buZlBMzAl7qpkdNnqJkMm1Eh79Pq5/FX3Ug3kaLZHjMuywuSQiiFes3A0cA+?=
 =?us-ascii?Q?/fdaBIorJ+HcXPUqeI0PKeJPO95rS0BwZNzP8vx66RX6pav8mGn5HmmKGbZY?=
 =?us-ascii?Q?NyZcibfR2l9WSYECS7bo3xKjMgVqAbtpLWh7q0PqC0UfY3CvZNwHDLVrBtOp?=
 =?us-ascii?Q?O2ot80IXKnMROCdzQOHHinOTP8sLBfAJK1J6TRrafdGTCNBW94fjyqZJtjks?=
 =?us-ascii?Q?OIqrPSSFZzw1r7gdHHPAHYC3ArM+Gk7zeBSQICvEZ1p1xGkmGgNneeTPkH2b?=
 =?us-ascii?Q?xrpOX3njL76DZywDTViQp258JZaPIhW+IyGd4qqlabh7prElEWw5aQ3UrGTr?=
 =?us-ascii?Q?ONA6JTvqfBZq28QeA1q16u5s9HX0G8jLjSue0VglJu5YfRbR2rN/9NzaOSYY?=
 =?us-ascii?Q?a2oYKezE7rayyJ7y6gFw0WAocOy6HgdYIHELrjFnQsu6cLiarMUiiHSFpvco?=
 =?us-ascii?Q?P/MJdv4bJXXNtMCcWHY9pmquhFStAdBXwZjRkJp4xrfxI6/tR5CvVBbvWgMY?=
 =?us-ascii?Q?0tqgxIbAN0l7isEvypXrJJCy8fpXxZ2RTzn3Ak72x6eEKr0HNTorz4rbDve4?=
 =?us-ascii?Q?IYr/Xz1C5PBtZoTHqjQDWE6AF/CbmpomtEgz7nVcxcL+t72SSn6HFPLRXdZw?=
 =?us-ascii?Q?dcvYD2JOgNaK/BojHm9tcTqZVTrNLXYHAefgQp/bFFHNwuBlafLDgyCAz0LQ?=
 =?us-ascii?Q?CmSPEvv66bvLmTyM5OYve0xVxQMjhZiG+z4j5gb7QmPWsgO9/zcasry8+bCd?=
 =?us-ascii?Q?YmtT0QYYoDptTJz7U1IZcWK5DyvV2E6ZMgHTF/VoQAUDclPyE0xtRvL9Jfo2?=
 =?us-ascii?Q?K33wgnOyfFQqHqp/GmfhJl2TJtPpy14D6wcSqy7yFB59zk2mijFb+MaVU59k?=
 =?us-ascii?Q?uQFcarXi1yDJdVybcQOEyf4GMwML4yFN5OrlbeV3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa7b0d85-cea9-48b6-f399-08dab69162ac
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 14:01:16.9923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kSEdXGhkRBEBBV8V7bHYXXM59R6+jWZ506n33jj6nL5Sgwu7/eZ1/dNZym5iYYHF57ORDRiiHLPFzcouihBhNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5279
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221025_070118_312553_651A6D7F 
X-CRM114-Status: GOOD (  13.27  )
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
index 4456ad5cedf1..30c456bfc1c8 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
@@ -41,7 +41,7 @@ void mlx5e_trigger_irq(struct mlx5e_icosq *sq);
 void mlx5e_completion_event(struct mlx5_core_cq *mcq, struct mlx5_eqe *eqe);
 void mlx5e_cq_error_event(struct mlx5_core_cq *mcq, enum mlx5_event event);
 int mlx5e_napi_poll(struct napi_struct *napi, int budget);
-int mlx5e_poll_ico_cq(struct mlx5e_cq *cq);
+int mlx5e_poll_ico_cq(struct mlx5e_cq *cq, int budget);
 
 /* RX */
 void mlx5e_page_dma_unmap(struct mlx5e_rq *rq, struct page *page);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index 58084650151f..261802579791 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -853,7 +853,7 @@ static void mlx5e_handle_shampo_hd_umr(struct mlx5e_shampo_umr umr,
 	shampo->ci = (shampo->ci + umr.len) & (shampo->hd_per_wq - 1);
 }
 
-int mlx5e_poll_ico_cq(struct mlx5e_cq *cq)
+int mlx5e_poll_ico_cq(struct mlx5e_cq *cq, int budget)
 {
 	struct mlx5e_icosq *sq = container_of(cq, struct mlx5e_icosq, cq);
 	struct mlx5_cqe64 *cqe;
@@ -928,7 +928,7 @@ int mlx5e_poll_ico_cq(struct mlx5e_cq *cq)
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



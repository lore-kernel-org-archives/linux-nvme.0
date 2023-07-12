Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76019C001DC
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Jul 2023 16:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=t++xcxITLqomb2NzSnxHeZc+d6nhsFHoBzrebzkcKu0=; b=K2fDFB1ELUP6HIQqTXgEhPAc1k
	Yx+Xp4ouT6g6yG5O6/rfFLjCSZP9CTdCj01IZi0okGi5Arxu/AWxgefQvrhduvTzSzDXz3h3Kvy3l
	MQ3jVVwC9ea4KdwNHbzSujKP73vzbFOv4CJD22udefbPzYAjxrn4yNEPLpz98LGIUoXlNalHEq79p
	OdZP2m1JutOTmUVIPdwowfXrE6LRw6PkBbeIQn4RPP/GzQkURIeBaUtm9mKJsJ9cv2lk+wIqWnkly
	At7u7l0AJP3ammDAzZWAfilOXDfbyiCGQElGoi4rhn7NhBR5AI6Xkp2JZjk/L7r9A2cUqvV98mMij
	MYh5XtuA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qJcY8-000X3x-0T;
	Wed, 12 Jul 2023 16:18:44 +0000
Received: from mail-dm6nam11on20600.outbound.protection.outlook.com ([2a01:111:f400:7eaa::600] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qJcXq-000WIx-0S
	for linux-nvme@lists.infradead.org;
	Wed, 12 Jul 2023 16:18:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LdmTeAHYABycbVMU0dyUKYWoAiw+SLfThTiKq6MTs8YJBt0+eP0JP/0orupW2E4RWqmm0/sBu3sfZS65IHtW6wN+aSHrs0lCd1ilCl549JgsHzoSezAaQNP/kR0sFHCcqnjR3K0PWJ4vf3UFlxVWQbhkUQZLo8xtoELAhMsQXmWRmY77S8wAPcu+y1UTVp4+8pmlLSu0hDvIbI3UY+HrUUNwMhhDSsxyUVWMouX2FByxSRoSxR9Wx65ySH3PRjSaZljR+DKfgIh864DB0uXZM4MWcyunGQsuAQcfCc/kRMzAdg5r8xXfpZZQ3AuBdw5rjwcPy5Zz81c/Rcm/jn7DkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t++xcxITLqomb2NzSnxHeZc+d6nhsFHoBzrebzkcKu0=;
 b=G9nhBucC46TlS7xseXa1yMgFvMtrosZcOrJeL+f5+iPm3UkyvmsSmXfyyc+j0tYAZnoKxfZQoEQuYGUlGU8fYyhm6PGy31G2n3xFNVtPx+cDEoNW3vCZZTGzw961FqddVQTnby2/chnejuYeoSpomr6WyuRuLhKKiH62vrNVE4qRq6OTuuZmv8WPTrAC9rJOKDR2/bFKslOqbUuP5McM5HhoK7rmQDLZf8nrIaEwJbtvPhTYgQrfhajoWodKDOv8KzSHzL+wJsu90QY7gBtTay2gyC/ggJ4zh28JfLUxL/xGR4kzcC/DCiBt6ILetUvLUIYg6tEiWDCg6H9xT7nc+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t++xcxITLqomb2NzSnxHeZc+d6nhsFHoBzrebzkcKu0=;
 b=qSdHLGWo2ruHP8l90eroGpP9XzzBlBqwN4xLCLWY8ZG8gq6lVr7ktaGOlja1c1XqxpSKRTKfh55oUIbfDW1/8xmLwFx6F+Wl5nwc5AAyV/un0UXFPj9rcgYiiUZImdNbCYfQ/mCuf7V965d5BlC03LsDfIYJJCaahCSrxWCQKldv4R1ilkVZ4zVHyRq36eXjDFhoK+m1dkstDQRokULv27MaApfbqGP7nbLpMgNuETxFkx/PKAOzwGg2CGhqC1YMV+2pzq6fjw79f7AqwekdWx1wlwaYJNDulOfYzcz4EH7Col8IZQU3mj+wT7ZpgDGGwNKCAPtBWLhSzTicDNEr7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by DM4PR12MB6640.namprd12.prod.outlook.com (2603:10b6:8:8f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22; Wed, 12 Jul
 2023 16:17:53 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::3f6a:7977:dcd4:9ad1]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::3f6a:7977:dcd4:9ad1%4]) with mapi id 15.20.6588.017; Wed, 12 Jul 2023
 16:17:53 +0000
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
	mgurtovoy@nvidia.com
Subject: [PATCH v12 15/26] net/mlx5e: Refactor ico sq polling to get budget
Date: Wed, 12 Jul 2023 16:15:02 +0000
Message-Id: <20230712161513.134860-16-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230712161513.134860-1-aaptel@nvidia.com>
References: <20230712161513.134860-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0162.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::12) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|DM4PR12MB6640:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bc416db-be81-46c1-e349-08db82f38b92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SfjhU+pX+goKGdFa8a77NCFwFp54vnXF8xUcuvQcZ7BJUYVMC2tCIQJQ50CTswNocKWolTNc+bnDOX1f3qJzf/hkcuChtvpx3EQ2IR58sAIvGCR1CUICXVk7N6L/1CrcwS9EesZX5RnDiI0P2TKPMBC3gwbfsyLBHsa+A8kBol19tPfnbyJ9Z84oy0cOodLA3dUGRYL+y/SwLb3fAChpz2XKbL5rHJbyfA/GvDMMu5SSwiX2osqHUUSifjiD3VzeeDvDIau1WKQv+T15TB2mAgQDH3ahfsHvUCLPNbGnjo8aBvnErsUhaH+THLHPWk/rCIQQb+T8qr6vlzZASCiEO7R1RknjTUIbCUwdT9qJa+cZ/b/b9PfUmMXXuFy966aWtQ3dGf3gcjCC9RpNKetvs0Czzb/oLqI+FNm5EGSS8t9ssFpehrT9z999Zr/+tt1l+U/rGHLixd/nwzWB+6wxL5KTqqxHuR6j+rae8Gti4MTcNIEyRvrbZa8HrOP5B9YFDnlPBSYGnDMrA1s3KB3QLC1SIoKILHKZ5baJznAXaIs2IgCwAe5bDPDN4VTMwHLK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(366004)(396003)(346002)(376002)(451199021)(4326008)(66556008)(66946007)(66476007)(6512007)(38100700002)(107886003)(86362001)(186003)(26005)(6506007)(1076003)(2616005)(83380400001)(36756003)(478600001)(6486002)(6666004)(41300700001)(5660300002)(8676002)(8936002)(316002)(2906002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ea2dxNU5Dh80to3IuK/1oZpiw/MQkDhrmri6SOlKkYHqag+11WmMk+F5PEnk?=
 =?us-ascii?Q?/9c3gJxiApYqPq4ywSjmzOxm91pyP6pnL4uOdVKTWqsNyA00HE4AfVloTV1k?=
 =?us-ascii?Q?4p+zUthKq5UpWacz3AwqFzsZF8XqXj/hpxKhE64C6/cdP6uzQmox7Wzq79Hf?=
 =?us-ascii?Q?TRjQ7CMgRytuOOcMm43spa0QeHhW6vGmmBYjVvsBq3B0T1y8DKjNJjJ1Mm+W?=
 =?us-ascii?Q?dstiLpOd68BFR6Oq3fJQJEriV6M+bOc8TkiafkYjmmq11tNH3IPUviKlvBG2?=
 =?us-ascii?Q?1klRK961xtbk6lEqaeNzZ74sFztfLjSYU1ou8UnA6dLLrcJwVx73x/TaHw2g?=
 =?us-ascii?Q?HhasKyuTsSQNrzhd/+N/Q2o9K/9FWAINbw5Ba8AclZNe/djvJs/lQedQuJm4?=
 =?us-ascii?Q?S3dF2noke+vM+L6C655Jo6FryEva9v17bJsK8qsegogRxVo4yL4/hJhxvrVi?=
 =?us-ascii?Q?s52bL1fe0LSc7LyTpqclsLMIJfmzSUyGyOdkC6VD5o8ZpOu6BYWWneV66xAi?=
 =?us-ascii?Q?q97pO8to1pehonPwH5DkosHf+kPiS8O0SISSB/PZnhQPUuVHgMI0Nbj4Jg27?=
 =?us-ascii?Q?AWjENFL3i1Csk1VtgsrB4Yy6PKGyEVHZKCUZXqai61U1wl9EjVHhOgKgkPvl?=
 =?us-ascii?Q?QXVjKkXrFO4rqrfAts0c3QaVOES3vYoxzFvjr2yxHZBUyUl5FfhA5HrB3DHl?=
 =?us-ascii?Q?UD7F6NiFnNhtFrhFtD64YLCBoDYvjZ4j4KUkJryodnuQhaKrRwdtqbUk+E2d?=
 =?us-ascii?Q?EOfMkpy/rcdlMowRdp/GZTzsBios8o8EFffpBAdJ2V/vevYIHryCQM0h9KUP?=
 =?us-ascii?Q?Rpo0AMxAbt5t8sL5EmoOrkDrkD/Y08plCzHoew6XTrKuljNi3GoGfuRLr+kq?=
 =?us-ascii?Q?aM8M+uD9HKva4iYh9x8FStDcwgPfDGd4Utt6uGM+3UC2uU1WN1k7FpLI0Ul5?=
 =?us-ascii?Q?S/RUaPKo/V4EMLAqIn4T17s7GGlPRmqexMXO1VRuH9ePTsjXy5Zp4H1hfXuX?=
 =?us-ascii?Q?9Rp4URGU7Ktj48A2Oo2rGsL6LG9p360eQpsKTQpag4n0bMnHNf/+Y/S19zlo?=
 =?us-ascii?Q?ynXS4oorxgS4oZdspBf76MqwuuN6UyvkssWvBxHdrb6XWxFCDIFxjcmlBv55?=
 =?us-ascii?Q?PMKfdwLDHZ7DPdpbp2LtGlQBmAJleovm6Xk/xQ4U4CwMoFUqDo9qAUNpq2nM?=
 =?us-ascii?Q?IRkqcIm+4Hek+Pqg1NPdVo4eCxVmOKL4MiZAtYci/hB4xLhD7lMSgQUamGp8?=
 =?us-ascii?Q?WVc/bW5areRSnIsyAe2retUUDpfvK7AR1u6eZc/biKXCya1TRC9GS/hZmfo4?=
 =?us-ascii?Q?Kev+yPMRXNErp3oC2Ih3g0BH02gdQWrD2jBKOb3cEk50P83atdGaKj8qqxEK?=
 =?us-ascii?Q?q5sl6thlLxc14mLo2SoZ1Zydmnv5ROcJ9RbSTLWr2lGhzvMAdPZGaWSBrlZ/?=
 =?us-ascii?Q?kkVDKnMPKzpbwe3hTMeiUXW7+LKi3gIiUmxhaeaJ9FCrIjllhGup5VZg7Oid?=
 =?us-ascii?Q?E+iVWTVXEqOPfjFZC9VIqfLUz39vgwHn9Qd6d6TaSxR2fiQ44UbIUa8na5mF?=
 =?us-ascii?Q?J2iMclkd4gBHfUSemCxkLQSpXo5FDDnWlFRkTaGX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bc416db-be81-46c1-e349-08db82f38b92
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 16:17:53.5661
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fb5L2wSWNwwA0Gz2yGXiOKTiPm3/SN/K6NitZCT7YAjdQHsDBNKLJqJtRAJA0p4oizhs6iGNw9nTK94MkvFblw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6640
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230712_091826_203178_FCEDEAD7 
X-CRM114-Status: GOOD (  13.36  )
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
index 879d698b6119..cdd7fbf218ae 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
@@ -62,7 +62,7 @@ void mlx5e_trigger_irq(struct mlx5e_icosq *sq);
 void mlx5e_completion_event(struct mlx5_core_cq *mcq, struct mlx5_eqe *eqe);
 void mlx5e_cq_error_event(struct mlx5_core_cq *mcq, enum mlx5_event event);
 int mlx5e_napi_poll(struct napi_struct *napi, int budget);
-int mlx5e_poll_ico_cq(struct mlx5e_cq *cq);
+int mlx5e_poll_ico_cq(struct mlx5e_cq *cq, int budget);
 
 /* RX */
 INDIRECT_CALLABLE_DECLARE(bool mlx5e_post_rx_wqes(struct mlx5e_rq *rq));
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index 704b022cd1f0..84ea8594e1b6 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -968,7 +968,7 @@ static void mlx5e_handle_shampo_hd_umr(struct mlx5e_shampo_umr umr,
 	shampo->ci = (shampo->ci + umr.len) & (shampo->hd_per_wq - 1);
 }
 
-int mlx5e_poll_ico_cq(struct mlx5e_cq *cq)
+int mlx5e_poll_ico_cq(struct mlx5e_cq *cq, int budget)
 {
 	struct mlx5e_icosq *sq = container_of(cq, struct mlx5e_icosq, cq);
 	struct mlx5_cqe64 *cqe;
@@ -1043,7 +1043,7 @@ int mlx5e_poll_ico_cq(struct mlx5e_cq *cq)
 						 wi->wqe_type);
 			}
 		} while (!last_wqe);
-	} while ((++i < MLX5E_TX_CQ_POLL_BUDGET) && (cqe = mlx5_cqwq_get_cqe(&cq->wq)));
+	} while ((++i < budget) && (cqe = mlx5_cqwq_get_cqe(&cq->wq)));
 
 	sq->cc = sqcc;
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
index a7d9b7cb4297..fd52311aada9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
@@ -178,8 +178,8 @@ int mlx5e_napi_poll(struct napi_struct *napi, int budget)
 
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



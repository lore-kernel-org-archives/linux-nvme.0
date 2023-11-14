Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B7C7C4332F
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Nov 2023 12:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MCdphhMWRzXAc2Xb3Okzoxim4lrrgGLa6OvPNt/QM2k=; b=R/7bu1gnnL8RkBFnKia1gM5yjS
	Zwyxcx3cuQIsOudovlzaRjmJkWYhMX9Hvc7LvgGJqyroIBPWn4sOz/DKnF3I09X91eRjQ33fOBANK
	F/nHb6BhwIqMF7TaDxthCM1tjYJPocZhwyF3PzyTGjbC6MQdeiRU4Q60kZKfTTtzyMqNQWQZENwav
	9NuLCpGCNdIABCoPjx7MKL3/9kKJqLxMZoE6MuB6p8k2c6QF/2/1Fs31NU8onzxNTaqs+SEwnWe4b
	/cujMrxMvWOACABMv6QwYYeD+Rv2+CNcE7/1sHDT+7fnQGumLMR9HJOAjp6ShXWAAKi8AfuFPrGxQ
	YdnQ8i3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r2sm2-00FvSJ-2l;
	Tue, 14 Nov 2023 12:44:10 +0000
Received: from mail-mw2nam12on20627.outbound.protection.outlook.com ([2a01:111:f400:fe5a::627] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r2slz-00FvND-2i
	for linux-nvme@lists.infradead.org;
	Tue, 14 Nov 2023 12:44:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RkwsUG4H+O3ki+Hph62d+Ux4w+PDmaXjdqFIUyP/uxE3DdMonKd/8oMCMD/1FNzweGEBJUkR4sPqT8DsFNFOObczZK6xneuQ15jN5CLyRPWLFMWWW8wT9YmIAqRc3P8fFsIVYw4bJLcm9hxeOd5HoNLdAUzkAxAY6IWszd1trQO7cYL9sFHKxu83TrfkjBEdybZEqdf6LhqAd7Opl2gHDbl2ncxhJ8ptnvz17BF3gq2SeRg4CpKN1vP4M47+av836+VcwVyuJ4hhl2ZMmsZcodlTjmPAIWpqlCnPYwlpj720M0vF8hJtoNWT1t+x2wWTMiek02wyMgZEhUjVB/1d3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MCdphhMWRzXAc2Xb3Okzoxim4lrrgGLa6OvPNt/QM2k=;
 b=LOe8G65PVavguYlHJQD2kHGEZsUi0XvR251ucxeBRl2LWKbs5821S3lujz3IA52vcRH8+VvCLAmIiov6O3YzG8rDQh9TtKD02I3COa3Giq1FxtnQCLmrx3yNTu5NfpXHqvqz+IxHZY4t8/iPihKl20Yqrhe9vKvVgeOEuOjdigkCQK1so8cqjnY6SwTr9Z3rJnYjdox0PtuLp51SHxTN5KnhLGzk2XoXG4zzNNJL145QrHfJq+33i6aBA99CJaTa2TfJtAb4ScnMkdebyxhA0YHcp3zxJSToA4V1W9g3RiS/S9wKqs2DuZslgzC8rQ7YxGrMsryBrUTx4t5DRQ4k1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MCdphhMWRzXAc2Xb3Okzoxim4lrrgGLa6OvPNt/QM2k=;
 b=J9gKh77qSiqDgfB9AYmbJ69/m2W/MD8tZZQdZFoJOwRjwe0k+63z/zfcCxlBV8j2bRSlKw/kpbSE/1DgUXw0wc5vRu5lYXY0GyOH01Lv7Xzf/dtcM9ilI+nzcbSiVUNRkiSs8mp7lqD4ck4ilOfUd39N8S5CPidUSrowZZhUUd9Z7DT2mi9wfP96gHzCxq8bUUzPIBNRlyLx6d0vIIX44Qdhp7eXL39bj+/hTVy2pkC+BB1bVx3LVRW1Lwtfl5WrAVSD3oKO8kxlU0SuH/zTXfaVfKaoNq16VL1pa8nHubShcNA9TZzLyOUC4rUS4ljMMBtaReB1m5NpJeybe/pr2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by CH0PR12MB8463.namprd12.prod.outlook.com (2603:10b6:610:187::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Tue, 14 Nov
 2023 12:44:02 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::42b4:7f1:b049:39b2]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::42b4:7f1:b049:39b2%7]) with mapi id 15.20.6977.029; Tue, 14 Nov 2023
 12:44:02 +0000
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
Subject: [PATCH v19 11/20] net/mlx5e: Refactor ico sq polling to get budget
Date: Tue, 14 Nov 2023 12:42:45 +0000
Message-Id: <20231114124255.765473-12-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231114124255.765473-1-aaptel@nvidia.com>
References: <20231114124255.765473-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0090.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:190::23) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|CH0PR12MB8463:EE_
X-MS-Office365-Filtering-Correlation-Id: 835ce603-4f2d-4415-09de-08dbe50f6113
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CvqILB8l60D42wzzkisESEaDt6kEIYesOef2JF8rYwAlRrLDLfVzrYSrUX6l968fJyTEru0RgTwaPRXYHiVqM2Y90xRPbEQb8I4GNt4FZAadHxL6fCNWsIgpLNy1HXor+wFc/gLgAV3v7Dahf9gieA0nP4gFt7CmKlE6CDhnLkySbBlsUs/4/UFaG42KpmWPe70kqKwzWFZhOuVWFCzAb1LFCIEBO17hskBtW8NC7hfT1yyor45bvOT3FAI6VONc/CdlQB3/ksUpKkNWCu56gVKo3gU1SltWeNCKUtRb7YGQNnnnf4g9HA0QpomeK+ZT9tTKqMkr2BwwG45IM4AlsgfDZl9L0fKjgGG4RXPQeI1lTs6M15kHW91ZC5Qebnj6HY+SBukwkDo/r93Id5worvG3XcN9yByIpt3sUEY7RW9d1WQA2Ak+RTp1VZgH7EtuYjNiuxvfILPn9pvvF8SUzcTRi0W0mhYmXp3lnyonMQVrEnkFGw8cEA9zQQvkumU76/ahcbE0ZG5IRr0p9uKTA+lTVILt0jFpCZXPvxI1Y8P0f2D8h0qdGEu38RZA8p1C
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(136003)(396003)(366004)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(26005)(1076003)(107886003)(6506007)(6666004)(2616005)(6512007)(83380400001)(8936002)(4326008)(5660300002)(7416002)(41300700001)(8676002)(2906002)(6486002)(478600001)(316002)(66556008)(66946007)(66476007)(86362001)(38100700002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ajZuc1sQIOjtNNlrilghodSEs7z2jEbXpUv8TxTe/qTkfCCo6z+0mhwQ6RsS?=
 =?us-ascii?Q?vutntqUW2E4kGysDvhh1SWeOAA/rFdhYV/O95NhmaNFgwAJMsT0XDGPo+VEn?=
 =?us-ascii?Q?ukGs94gHR787QlxBRvbpBJf0oC8XkaM9PRFo4cmoFjHc+YhtUTYj704KBMUD?=
 =?us-ascii?Q?M6DhMtQUGCkwCTCDeijLgcD2WfNn8+ctcqhoYt4qv02QPUcJeCIHYlEsqNy/?=
 =?us-ascii?Q?AiTButSgSgPNbiIC0O/lgs35NT8et06yjAPVdnhVEG1TsQ0oybBxM/Pz6/yM?=
 =?us-ascii?Q?ViUYN2XU9/UzAxZqskNE6oBC+W0CUnhUl2qSqUkLvqfBIryQQjK3wyCp5Lrm?=
 =?us-ascii?Q?zN3ZpCHEWOnIk67sk03YV/zX8SEwIdX9dMF2yCuMj3RIWCnERmKUpqydEHlQ?=
 =?us-ascii?Q?Ut4LHk4b/MFIyPOKnEOqRtxWHyHSs8X6+OGEb57W+NoexApBDFiPvTZCXO7g?=
 =?us-ascii?Q?OR4/AVMXpPelA39cGPkw4z74ReBf996iZOlhRJ12wGnRQJMjngTWgGA0S/oQ?=
 =?us-ascii?Q?6HeA+IehFhClF+ZAJECqxpRpYXzUtnbUyYOvhpZrFwxJO6kf2ygNhkHA8fny?=
 =?us-ascii?Q?bAFyhlaxxAI8ZHa700EYC+tLNeHtjrXAkdyjoT6C12umvDbwc8rjU6BkhP/a?=
 =?us-ascii?Q?RCGZyzzgSDIN/yz9QvE/VNO6kD/CGLFDlNJVBbq19K6Ow5kO6HIQgMiWk1Gi?=
 =?us-ascii?Q?ced3WkrMT68NrJSr7KS1XyXsP1+f7nGDPAh2As6UVej3EVuRBGusU1lyn7CS?=
 =?us-ascii?Q?OrGh2ByTpo689l15Y0ALs14q01BucZytoQKmvsBtBZyEm6BTAvwsyP5gv/kP?=
 =?us-ascii?Q?Wui00xsg4GELRE6Q0mLGhm0I1JbaCMI2Kc5d9moKJxqZu3ufyGUr7/g88IQe?=
 =?us-ascii?Q?cW+uWkqsHh7Y67bZIMb3QY9n4hOdaRQMF0ho6+pIJJmFyZD7XIZtRQTJyLHh?=
 =?us-ascii?Q?FjaXNhe3fjzhayxgtHPxarhp+dB/GtzhshqkCDWB1jGZE5Vz36UlqBc2cEb6?=
 =?us-ascii?Q?Jos6ByVZiuaTwMr4J4KUpFObf/ntgCttlpJ1BPxP0bq6sBmdaba+k3KMFjN9?=
 =?us-ascii?Q?bMfCPNfo65BjjyFCdelbfaQEy3fmJmCUYiijwGlHr0sq4IR+Pvow/k354prp?=
 =?us-ascii?Q?Okf/ku1Gw6MclCkgz7BQTstMu7iJQC2a0zvWpkF973pT/CwjqxUfOJaxHB/q?=
 =?us-ascii?Q?sdjIrBUR0bW2puwet+O/MsSxvR3XzRCfBA+imC+egABNfDXorf2glv2+5cV5?=
 =?us-ascii?Q?HZOwTbhnbq3JAvWUXuhwt5rSicxnS4mM3H5poI2CcM/PrhzYGKpguUXzSva9?=
 =?us-ascii?Q?WbnEkpyGEYi0CTx8zqbmdwtkIEAFEXMsKKuNQ1uAR922d26JL5MWUIaNLSGt?=
 =?us-ascii?Q?+eJ8jVNklJKvzq+krNGrZLJ5ELNdpfkW08RrCYGW5U4zqQDo6Q/aO1BQ9uCV?=
 =?us-ascii?Q?Ucerp66W5P/Y8qBBXoXOqEa7IxVLc9/3CdTdZItw96fwmlFCzfvt526eFEKX?=
 =?us-ascii?Q?15SaowhY1jxt1bFc2Ghfsmo6X0oxASojd4GboHv/LiPj3m114jj8b5+/f4v4?=
 =?us-ascii?Q?RVbI5qP7oqqrNNxge7Ml78i5t9kHpUUIUx8GB8uP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 835ce603-4f2d-4415-09de-08dbe50f6113
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 12:44:02.0345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oVz/izczlTXW28GJKs+isskCYFORSsHsPz+xVOjTUImmU8ZpyXbx+nUGPkr3MSxNy+qPGf/3/+oL3BYMNlxXPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8463
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231114_044407_938438_84A397D6 
X-CRM114-Status: GOOD (  16.99  )
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

Additionnaly, we move the mdev pointer directly on the icosq structure.
This provides better separation between channels to ICO SQs for use-cases
where they are not tightly coupled (such as the upcoming nvmeotcp code).

No functional change here.

Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h               | 1 +
 drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c   | 4 ++--
 drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h          | 2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c | 2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c          | 5 ++---
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c            | 4 ++--
 drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c          | 4 ++--
 7 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index b2a5da9739d2..1e1d8f3d2b24 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -555,6 +555,7 @@ struct mlx5e_icosq {
 	/* control path */
 	struct mlx5_wq_ctrl        wq_ctrl;
 	struct mlx5e_channel      *channel;
+	struct mlx5_core_dev      *mdev;
 
 	struct work_struct         recover_work;
 } ____cacheline_aligned_in_smp;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c
index fea8c0a5fe89..793927b557e5 100644
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
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c
index 20994773056c..3c6c5a4692a3 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c
@@ -267,7 +267,7 @@ resync_post_get_progress_params(struct mlx5e_icosq *sq,
 		goto err_out;
 	}
 
-	pdev = mlx5_core_dma_dev(sq->channel->priv->mdev);
+	pdev = mlx5_core_dma_dev(sq->mdev);
 	buf->dma_addr = dma_map_single(pdev, &buf->progress,
 				       PROGRESS_PARAMS_PADDED_SIZE, DMA_FROM_DEVICE);
 	if (unlikely(dma_mapping_error(pdev, buf->dma_addr))) {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index ea58c6917433..9ae4c4213db7 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -1500,6 +1500,7 @@ static int mlx5e_alloc_icosq(struct mlx5e_channel *c,
 	int err;
 
 	sq->channel   = c;
+	sq->mdev      = mdev;
 	sq->uar_map   = mdev->mlx5e_res.hw_objs.bfreg.map;
 	sq->reserved_room = param->stop_room;
 
@@ -1898,11 +1899,9 @@ void mlx5e_deactivate_icosq(struct mlx5e_icosq *icosq)
 
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
index 8d9743a5e42c..addf8905fc35 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -993,7 +993,7 @@ static void mlx5e_handle_shampo_hd_umr(struct mlx5e_shampo_umr umr,
 	shampo->ci = (shampo->ci + umr.len) & (shampo->hd_per_wq - 1);
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



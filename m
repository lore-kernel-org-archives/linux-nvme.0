Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EEB9E732E7
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Sep 2023 16:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=smKil+QXC/4BIgbF9/VFLOo8KkrTKoyfafMBSFa8F6M=; b=CD8cM09dedM78V2hI2dB0Rf8/C
	Z2xqOvoN+iB0TEJzXnth5SxQvdXDfST59UDL99d7k2QfZPKwsxpxVnTv3de3vvXklRkUjqsITMZ/U
	jld346n+mlsy76+280xWdFZ6MN+85hH9SAngOTgEWUKRGUAMUp1MldOc/6Zl4hasslqOWm5mKV3G3
	1B+61eGVG9DfhjwI9ihafu3dEoUMBkPH4GMael8KZSaz9W4O74u3EKBmiUzAx+lLyg2mzWzeRgFev
	qFliNpJykohAEdjRSFpS/SqT6eNaGzZVdF5X221lAbTQPaysGHaIsIZTB3Px8FiWzQgue9S+CZWq0
	x8gcLsNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qltgK-005sfL-2P;
	Thu, 28 Sep 2023 16:16:04 +0000
Received: from mail-dm6nam10on2052.outbound.protection.outlook.com ([40.107.93.52] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qlsgV-005H1r-1Z
	for linux-nvme@lists.infradead.org;
	Thu, 28 Sep 2023 15:12:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HisLvv2UgrcS5B9vVdFTOiM6d4UlfOco2a+7NnPNLoGbzsjnTLmkR0wwI5BsctLp5zQwsdvWs+LUzOa5go42Q2pO52mqY1hWYYDU8/k0oQkpHovBFkjgrCekU3Ht2kGn2MDzEL7U37zNKwPkoEHglKF4MWhzkj31/LoXR3JRIyZye2j7Yhact6Mr4vpXe0jCn4KZbD9ysqI6vtIa19pKuSV2bOj11TIDm6y2SEVKPheir54RstSAYjFez0aQbNAlbmLwUDjLCfjKnoekx6xQ8AG4x1zAEO6K4SmFz5dffDa+iUamYTxgqI5TceX+p4xi16kj4cSS3kyDbAJld8RgNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=smKil+QXC/4BIgbF9/VFLOo8KkrTKoyfafMBSFa8F6M=;
 b=CbszyEYV8AzGj6KQbO0hl8R3JgjEuCthZ1ggUrwvxrsPdcRGCgDy8ZYHlezHcdpthfZLpbH+3wcU6/8clqbOeLiS2t1/DjFXNmFy3awZeM+DeoZETawAa6Iw9VZveyZJrsIHNlI7cQN6hJKNnzSlmgy2zp1hjNusEgG5a99wVdY/z+FMDfL3csiR4iIbw8cpSfD+0yyoEBZb/M26aD8utkom8/cwRlfbNbVaS8Q5/m2xqw7g8DyfkDyrFl5YhNdueo5klWOZDIy5AhmdnRhLB+8GgxmeSAM1qbLYihgUi4vrpimk2LOTzsGR9dvQFI0FVjhMeH5P+Y3w+ruD5Ow9NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=smKil+QXC/4BIgbF9/VFLOo8KkrTKoyfafMBSFa8F6M=;
 b=neJhtjaRahoe7MtYLBUvjukCJvY4Hbt+ugHL4LARxZNxsXmi6+2HroBTRgoJk6nsVpxJX+CU4IYBwfUDHdqcNVaebIDGpAmp8ZPFALyfXYYVMYsxiKtDAltwIrQ2by3EFM+yyG0JrPa1Qv9fSZbDuxTacztpbFYfxzNvI6Y3yr2glGPQd3U/5dBYP6mESFV1xbTX4InMrmmrDWxa6T2NZ/gnxXPigweqaxEC8YV3hYyY2HaWptiGulCLfmmHIa01buOsIt/hqvHmZb5+q+iaiahu8hWmt4QFbVLtwyez0iRedXWf73XT/5qvY7MYFEHqV2VT56+onwHdETTQZmjfog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by PH0PR12MB7095.namprd12.prod.outlook.com (2603:10b6:510:21d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.25; Thu, 28 Sep
 2023 15:11:17 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::54a7:525f:1e2a:85b1]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::54a7:525f:1e2a:85b1%4]) with mapi id 15.20.6838.016; Thu, 28 Sep 2023
 15:11:17 +0000
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
Subject: [PATCH v16 11/20] net/mlx5e: Refactor ico sq polling to get budget
Date: Thu, 28 Sep 2023 15:09:45 +0000
Message-Id: <20230928150954.1684-12-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230928150954.1684-1-aaptel@nvidia.com>
References: <20230928150954.1684-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0109.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::9) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|PH0PR12MB7095:EE_
X-MS-Office365-Filtering-Correlation-Id: 11c8f25b-89aa-4320-ccef-08dbc03529cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1kkVuwjUQj+/UY8CqudTGzERrWW2cKvcDg5mYppJp46zYZcGxYnBQ9HRpuftkrrss0dPhbyrGEhM6b5/OEuOHYSvl52R5rzEGW2iu/le1XO1bqs7IhVjZJmdY91y1nl1ADh3TnbBEZ4aOhmSpIVexO5yJ+zIi+mzAXbCqfamxX3nUhP14tgRjcAXyU+GYgi+WRmyeOMZO9fDXaD8ITEPWDsmfRkRYTCj16ZHILA8Vkub8Sv0Gh4h+h/zbd4RFqSfqrxKVYfxbk0A0SQKzdgWQpjYHdN+59s+s+d8UqiyvHEaZSxQT2SWsvTCbYVIizxBSjwqSU24/GTIiUZaXGIc47K9UWOASSXIyeGPN9AZDgXJ1J/SJ3Yj4BqBLhqJoJp1q7SxcFCAiJp1iHYIvAdtAcXmyD9ZbKXZZOQknRUy/orf2/4mJSXynjMVnU+Fea91rafvwE+0Q+p0PNi7AuDnQt61Bxlo7Nhkp9qzPO56Ghq3EdsDwH0FBHdkzQ1h0clB2pLinNkGsErnWN3qjjwvGBSRi3SL5GeeyQ1GcSlGppTzMPKloP6YSqLynO8V9T2r
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(39860400002)(396003)(346002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(2906002)(6512007)(6666004)(6506007)(1076003)(38100700002)(107886003)(2616005)(66556008)(66476007)(66946007)(86362001)(478600001)(6486002)(83380400001)(26005)(36756003)(5660300002)(7416002)(316002)(41300700001)(4326008)(8676002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/x8mT2h+mMSX+a3+KMIMRCTaLxh0oVokp0GhqCgoudqtCLsRym3y9yS8ZfRn?=
 =?us-ascii?Q?95reEcVwKvjJgBTrNR25jj2ERGCjJYXYbImEnVTzH5JQKagXmWEe+fp/B3kZ?=
 =?us-ascii?Q?Oj0o2yahuF3knt0lRFvx9w2aJSwFOQaRFTHzVpI/skuzyYdN3iDWSl40Vt8B?=
 =?us-ascii?Q?BL+DH3El5kv4vsNXdUx7BSsOBpSBOlrdZe8yzzd6cSRBiyAnOfPpzoe7K881?=
 =?us-ascii?Q?gBvH8KbsZO9Uu+3kFp3T8O6h5dJSmjXw1wl4aH80W3LogiqkUijF5C1ivcIr?=
 =?us-ascii?Q?H714IMkQZqqIppFVtzoRocwzxziQZLSGPyb0DwqM4I2k3EAlbNhCpyrTTd5/?=
 =?us-ascii?Q?6QX3pbJjncPgvzBAAUWCqF+JEVoD1KqGKA1WiH2WrfHmeZYn43BwjREAdjEq?=
 =?us-ascii?Q?0y41sRqmBT2Iy2U+DSYt/PMtcVA6HJkM/Wy5a57bY6cF5YAWo+ewkU9gyMJU?=
 =?us-ascii?Q?VyiCGNxfJBno5Piyx9N3nEJpmTkKKk6lDQuONEkTepMDpHZcYLhj0FW4+sMi?=
 =?us-ascii?Q?oavLmhyBNJ/dkZsZU6Jgeb1NoN2qTwuzqaS+Eq75r+FON70HlgJ+0jX3xJSM?=
 =?us-ascii?Q?Kz59UJGRlV3jB1RfpXW5J7wxFw5uk9DYV9AfAfklVC5FuAx54V5KqK+2zZqo?=
 =?us-ascii?Q?p7XV/YXd/+MlHSQe37J6Us+3K2FLRy8kCjXJKq4uyqjaZv+oW7iKaVoVEj8M?=
 =?us-ascii?Q?ug+MY8lzCz01HPd5JSpkTS1r5YeBjxZB/1Ry34w2n8rYETA6yndcqsBNaHbD?=
 =?us-ascii?Q?kddvken2a+C/sSGEbKijEb+7MFNHsvFm9CYhZ4nwg47a4gGsc8g7nVNcYKAW?=
 =?us-ascii?Q?a/0OI8TL9pI5fnRIp7G05oKa7jsH5ylxXEJ5VymIn4lfpwOZMkfCNCNLSqLf?=
 =?us-ascii?Q?R9aKFHjGDp+trdfX97+NQe0IBKMzsHzR9JB+XTxLpsH+yg1IobiFtdkKyHxk?=
 =?us-ascii?Q?B2r1JvurRyLt32yr8TeNmG/Zj0UpZ0wKg8L9aHIO3stOwoySElUiX/QMuBbn?=
 =?us-ascii?Q?hRdR/wjxtFJwh3ZbSGJ4e8HmulGx7U9wj2pr/p/zM0ZJJpevByMjiC6S5RNB?=
 =?us-ascii?Q?SXpl8XMxgNo6D4DeHxQwd1cu+X8FllNpCoXhqzkJT/pljm9eolp3S6GkLjto?=
 =?us-ascii?Q?4i75eTiAi4ehBO7SDgYjqr2qMfOSPGLs+kGUj7S2LfkwnEzEKPCtL3EssDKI?=
 =?us-ascii?Q?+BT13jul7aN3MRScbZmNJ4XtWqpQ69X00Ac/NHLTUcp4HwjB3kac848p97eV?=
 =?us-ascii?Q?p8w3QByyVewAnzUXsfWeWcuz0EAbFrVFgq6lF6TCfY/f+5OPrI5MM4WYBlRw?=
 =?us-ascii?Q?SR7hxOqDGk7vcM8CQbhMKaLz+S47gQlVq/zsBw4jLmUtXw2sc87xsdlnkCjo?=
 =?us-ascii?Q?tIBJT3rAzsNRK/PVa1ErJV2oJOqyOlnvTDdbutihydSQRG7/jTq5bOcUy1YE?=
 =?us-ascii?Q?d6yrE7kkNkk5byvmaBHqMsTI3bffTWWe8D8L/RaxCnXwYyyYg5HotDoP5PkU?=
 =?us-ascii?Q?WsMWghHmP4ZUCMC/wccjQcMW7D9JQAP+SjRxbJunCIUhI14c0P8rkZBWYzAT?=
 =?us-ascii?Q?93J3w+BGkNQGmt+FSvICVYUA9qZcaAljQSj8I6yI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11c8f25b-89aa-4320-ccef-08dbc03529cd
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 15:11:17.1741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yeqqy/dOt4QHU7Ji8PB27yPa/W4BzsdDcjwXjJgQoO3XK5DUd0TAe52X1C6u5o1qzVIqCPxLGmvBjBdHGzjb5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7095
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230928_081211_553699_7DA83266 
X-CRM114-Status: GOOD (  17.27  )
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
index 86f2690c5e01..d3982baefab6 100644
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
index e8eea9ffd5eb..1da90bda9eb0 100644
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
index a2ae791538ed..40277594c93a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -1437,6 +1437,7 @@ static int mlx5e_alloc_icosq(struct mlx5e_channel *c,
 	int err;
 
 	sq->channel   = c;
+	sq->mdev      = mdev;
 	sq->uar_map   = mdev->mlx5e_res.hw_objs.bfreg.map;
 	sq->reserved_room = param->stop_room;
 
@@ -1835,11 +1836,9 @@ void mlx5e_deactivate_icosq(struct mlx5e_icosq *icosq)
 
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
index 3fd11b0761e0..387eab498b8f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -976,7 +976,7 @@ static void mlx5e_handle_shampo_hd_umr(struct mlx5e_shampo_umr umr,
 	shampo->ci = (shampo->ci + umr.len) & (shampo->hd_per_wq - 1);
 }
 
-int mlx5e_poll_ico_cq(struct mlx5e_cq *cq)
+int mlx5e_poll_ico_cq(struct mlx5e_cq *cq, int budget)
 {
 	struct mlx5e_icosq *sq = container_of(cq, struct mlx5e_icosq, cq);
 	struct mlx5_cqe64 *cqe;
@@ -1051,7 +1051,7 @@ int mlx5e_poll_ico_cq(struct mlx5e_cq *cq)
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



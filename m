Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C73E5C00A8F
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Oct 2023 14:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yrfBrm71oCXSvhCL0E4JO2MlegGvxnrMPPGQly7sBdM=; b=B/i8gVpD246Z5dXcTNZvq5qcXK
	LUuj8OaXFUr6DODX5mqETbDJ6TktZomUTj/xWsEnckcJoOJAts5GwviQ9TUftccW18BVZ3G45Ef7q
	zUwB6RASrwp3pzQLg2y8EG+8OKZkmLls9XIZQP2Em3OPGOVW8aH1M0qswRepB/SipkL33RnD4xCrV
	DmwaiYAzkVY5u2orf0grfI8G1nlTdKcj3VHFz9Q12fxXMP+TGY9rhSzi4A23dZkBlqSTMqC/ggUTr
	InFHCkHPwqafvtjd0RvPgB9HZCenyuAn7vJNszj/kd2Ovxq+kdRBulS/j/k1u/nUMjFBodHH5eeBb
	tVpA6KeQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qvHxI-00A3zM-36;
	Tue, 24 Oct 2023 14:00:24 +0000
Received: from mail-dm6nam10on20619.outbound.protection.outlook.com ([2a01:111:f400:7e88::619] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qvGx1-009oIn-0q
	for linux-nvme@lists.infradead.org;
	Tue, 24 Oct 2023 12:56:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NiouoqcsVyJQLFccnkYc6Ezjavtd1mW/DBRn77YbMptooq2tTdMqF8+uunXCb+0dPrvF5WYJG0b77L4oxwXKAimq1fmOHCQS+mUl0E6r5AbKorN586k2zs5OCvM4wsrsKxk17GEPRDgsbHT9YkWstigHy399Cyt+hhrrcupJPc4Av9vVmfenMHZmLlBx+4gNqpz06TeTIGyHBMFBjExY4vARxbm7Ptsfzvx+rrM341TucaILFKCFee3bo5vM1KBDnrBaw0VcadJf+hxeSMpUiiEhGD520G3XtOD5M8aoB2zEoQ9doK8EYKpf84XhPegHVWRYwaZ2xYW99cZk8rDDzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yrfBrm71oCXSvhCL0E4JO2MlegGvxnrMPPGQly7sBdM=;
 b=gDfyb06WLEd8sVVE/TxaAhI76abVgFJnUwIKKBHr7hd4MCiPnELftx1yzMvQh88mqBcu1syTjduN/Psu2zlEkOTbg2F56D7507uFJKCs5m/T+jeUXynbSsmXo0R1V4wVYSGxK/m0FVK0QeU9yXyORPvGrStQCEEA2/1XJVG9DOJqpGsXD+kJKFDmhWTCH/jrLSvFevDu8K7Jig7W9FzV9YXS18U1hSPFAxC5FLaClIba8d65O49EKZnfhTyXljcE8DDkOV6NbjEr7axqG/xK2RYNDXIt563FNLFFhZWZ7jhWSJ5DlpKkeg9LJXxJPqiNXFYyERcFE8ysgUBg7PjmRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yrfBrm71oCXSvhCL0E4JO2MlegGvxnrMPPGQly7sBdM=;
 b=ee352qqpKNOdCYHqIP1u+CfqB0/iqy5nymgvowaKR9dRd+o+T6wXMDFp/Won4/UCGJLpuFKPsPZEoZVYiHY+5Nxm1uMlgVs+ZBPOqCYkLl/CpDH7byk/ewEFvrB1llQE9wofDOFXPpWr3LUj+6rrvvN0yGGHvQYdrcgwmP3JtaioD6iZkH3RomPSqc2BEYjVQbZIu83yK/JlIojpIoHENipAQYWop9v5mXTSsr22JLXD57LdpRGGEBApasaldZmSaN5A5vBnwDK8+YQUmxcGVbxZwj1vNL4RAZYqTVARorXAYe7SpzPOMdFedQT9dYKiSEy6XZt5lSGoLLDLmJSkiw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by PH8PR12MB7256.namprd12.prod.outlook.com (2603:10b6:510:223::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Tue, 24 Oct
 2023 12:55:55 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::42b4:7f1:b049:39b2]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::42b4:7f1:b049:39b2%6]) with mapi id 15.20.6907.030; Tue, 24 Oct 2023
 12:55:55 +0000
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
Subject: [PATCH v17 11/20] net/mlx5e: Refactor ico sq polling to get budget
Date: Tue, 24 Oct 2023 12:54:36 +0000
Message-Id: <20231024125445.2632-12-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231024125445.2632-1-aaptel@nvidia.com>
References: <20231024125445.2632-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P302CA0001.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c2::6) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|PH8PR12MB7256:EE_
X-MS-Office365-Filtering-Correlation-Id: 155cad02-e378-4d9a-452b-08dbd4908f85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 47ZhoP3in4ebo1fauGO44xvaHWGqxBGem7vcAlosT1yv8WnkFsfwE0rhU3bZYyOyCz8Lf8pLawAFhPQt25NKN6MwVmeuwEhj/1L4pDEh2Bw3t182g89tGQdR5r8gPngAYV9NInO7qP6U07dri07fRp0/U53IzAEoF6F9T1RFhC+j8tNuzQg98XcVx5S7EJVApmu7tRE1OtKaNAY4tI4WI2zYbPBJ2Afseoo4Ih+q9jFZnbbf/J16d4pnIaX1RCmvmfn7ZxlXS2EBuDsAQgPvVd+3wPIwXxtkxQV4+43mUwTX7LHl+a+WzgqNVyJNVMcgK9e/y5m5HXnCCUu7wnyDkX5MI48y2fonwe5zUimska3fFa+Tx+hq2/YR6BjfYgzguc6dll++uOnB743+n7qakz7UWxfOCyq4fHVf0NxPnydVCjdxCqZkpdbH8eyR12+EXt268kbQTVngWnbY1S8G/frnVOPEs0NueUp3fNlcH4GHC+El0/MNrJq1YnSfzQpGs54MzqNrGzTVz9puWmnTRlNLJRnwNOWPp4nkybCIcKKI8kF3muWGJHsGTbeXDZMa
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(346002)(366004)(39860400002)(136003)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(26005)(36756003)(66946007)(316002)(66556008)(66476007)(86362001)(38100700002)(83380400001)(1076003)(6506007)(107886003)(2616005)(6512007)(6666004)(8936002)(2906002)(478600001)(6486002)(8676002)(41300700001)(7416002)(5660300002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?99TYPJyplKEpwPHhVbUWsPQe0J/+Pk7EcrFkXlN/nESK9hKO+NHU9+8ilefP?=
 =?us-ascii?Q?pZeJvsqaBXgCPJyRH6UY6ki3V+3+PlvzcC0pMmuuHXh6eyDxP/A2kpawHhmc?=
 =?us-ascii?Q?2lSWvHQIMkWT7ts4A3GaecLVQBorIsmbqjjJ9YZb5DLV7gw2ae13rgeGKnvx?=
 =?us-ascii?Q?xl5N7911VO4X9oEXaMUTeVGk3+QcfvCUQ6BxeSF/OeM/r6IpbEDz3BC7e8Ko?=
 =?us-ascii?Q?fP+On4Z+fPNyRsDucCgb7dNqL4G7lkxIc+h3HtyDhg4BBEx3q/fsR1Q9ALbX?=
 =?us-ascii?Q?FNqa8ZLwysMGTeLjwJQSd7MwF8COhRalgZPi4TG2iFqcgxA7BR2oGFy+4JT4?=
 =?us-ascii?Q?Y2DlfxvsihHgJpXmzsRcZBHQ6ozLC3w1cMkQDQQ8+m7OC5x9BrEUgWrgHNTa?=
 =?us-ascii?Q?5+9w7OcG1aCcGkGGe8/UhLZoCfEFIffyz6+ksCfJt5D939I53b+9W9BlhKaL?=
 =?us-ascii?Q?TKJp5hloeWO/IgHVoNqR3fHNszKtMETm7oftiIGG9Ul0KrAHDv2YVUHi+aXL?=
 =?us-ascii?Q?Y3eielpYaBZmjadan+u1kmmJXogq6F7yLNdxBia++E8hcb3EiUUmb6W49rUO?=
 =?us-ascii?Q?VwXKVRVJETCk+xsSOnTye3wBbJ2f6HyZK8q65SK/E/s1hfVfpMZ+hBoL1maj?=
 =?us-ascii?Q?GtrN4d2iuVADarADPK1eFwXn3zEV3lN0X3ZC2dNaOHQ2ABa1RVfjZIeapEyx?=
 =?us-ascii?Q?2iukbp5fb5bcFgMqfu5lYqmZvXpiAXu0Rs/oTuO+LjnGW7l1yP3D1DckyRYL?=
 =?us-ascii?Q?bmYiAg7LrRM0weRtj+i2eYTmDN+CFqUlizmxlTShORPCR3mJA4Lr0H/mvzJg?=
 =?us-ascii?Q?g6Je54OqCAsODCVVFiL8W1z8MzbS5dwRrNrNo2upFebhmaTfZACkH9nMuHrM?=
 =?us-ascii?Q?KfOrbiD8uZ4yClUWJ8tC3Tp2DB+1fLij7XM/Z8G83/NEBkLLD8DvVBVg5qVT?=
 =?us-ascii?Q?3Ycvj7tRl/kFl6pjKFe0Cub0wV5RhlJXGHsfD5kChp2hdchzu5A+O0iiGx4h?=
 =?us-ascii?Q?C0G758SdtRVuRnODEG298ctbJZ1EfkWhWmOJ+iGigBkK3xd0EKBf1XNKowJa?=
 =?us-ascii?Q?wSUVOUGMeDCkQBPyZuei1KGvKXtX3QEOaSLAwORYp6uTwWaPbOHIdnwzkNU6?=
 =?us-ascii?Q?lvNwLqrpvExfpJ1QcwO1sexWLfiT9toC039/xjW0GwwitqVy5Lg+fevD+GCP?=
 =?us-ascii?Q?iwqOR2+nA/xZSgOwubs7YH9ajFJWqC+C9AtapUowJMUUoxfXY146r7ejtmh3?=
 =?us-ascii?Q?UsF68mLDWzf98uhp/5prnrahknrX2usj1wOntnX4vnbb9pruXvTXaGOEA9xf?=
 =?us-ascii?Q?/ACi2jEYZTXkmOlEmbb4JqOoo8gffZ4qy9DTUguTpiCVZ+aJPN0Q1qBHbznd?=
 =?us-ascii?Q?M8FejDKsFvQZTtwbdQLnN+Lwac/i7ioxXbx5VlQUAM7bELKJq5skb8R2uoun?=
 =?us-ascii?Q?Ti/UZHZIgSqx4Q4RK6LjJq3DvH22NRRkhILTn0Cag1He9Drl71zlLnFOu5nQ?=
 =?us-ascii?Q?EXEsOIoGv1xgk6PSIWg/Py7ez1klnwjpnZXvqBmjE4m9mwBcXzxcOa0cOYyl?=
 =?us-ascii?Q?UtqQms9w0Y0q8xR2S+Gl+lfHBkMga9+5Y2a0DoNJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 155cad02-e378-4d9a-452b-08dbd4908f85
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 12:55:55.2644
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ifpBrDjUNn13gHAXGhFzYR8HdFp/KNc0KIp6baiLHKNVu6OcHNu9hRMDnWFcBM7uDkDIpNYu2ppT+i0QH/3HoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7256
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231024_055603_339233_A84E1DCF 
X-CRM114-Status: GOOD (  17.06  )
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
index fc5a9fdd06db..9ab0b036ce92 100644
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



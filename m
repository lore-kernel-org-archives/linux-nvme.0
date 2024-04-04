Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A98F5CD1292
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Apr 2024 12:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=t2e7JpZa3tOKJTlJqb7+Hu+C07gfMG4HZFDfPv/DO0o=; b=sBWy3bAzaS4ob8UM7h5pTUDKiU
	n30JkauD9Je7MYHjrYzAzwo4NtkfxT2TUd+FvpeQOOKnxYj2sSquQoTgf8ZcV9P4vNI1Xdq+tj19w
	AS09+aEDC+/0L7XrWdJWKNIjkIOKPF4KkJEU9hZriGVt0DE1xZGJwXr9QveSv1HxLxvHwiFe2EpsA
	q6aK8KaYB+4XQfKVBZtAcfMybDctCdBcBJKPBXOM1gWiR3CHL1noDe4dWNfLHykeucLphY+KtIycF
	k3xqdID01UXNJEjxQB9dHrZp8k5X2HLOv0JkzjIIN6NJPjGpQsqLF7nxecqj3fU9PIPOt5YcuyH89
	nSN67ZkA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsMMo-00000002f4h-2LuN;
	Thu, 04 Apr 2024 12:38:54 +0000
Received: from mail-dm6nam10on2071b.outbound.protection.outlook.com ([2a01:111:f400:7e88::71b] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsMMi-00000002end-1UWq
	for linux-nvme@lists.infradead.org;
	Thu, 04 Apr 2024 12:38:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iuh0XOAOwb/nfXo5xFIqBtbKIH43XmKMqdcxBNNk4j1joROLUJHf396Z/3GBSsSpLDjA4j7JLSByhP+9tDWRYmHt+YlxTUf1aYORK3dUJa/dJZLgvwSbOqKARP06MHu+NCwnpAYBDxrAEIhxdpTwMmKA9BajY6px3dJNWa146Mh1DHiM4epMQ+FcA8EaeKyGDnoVQLuPnGYf7jzIoQxsfvfJNF69vb6fA/jl9bffZ0AD8yP+F0uOaNreCLhpTaoqX0qpmn51fkDi/GgaNiG+DAC3yq83ofoTCwnWhCunEsaB8I8VgOQ7V49Tg86GV/GVZDwBKOeVW/p+6a6kjxH7Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t2e7JpZa3tOKJTlJqb7+Hu+C07gfMG4HZFDfPv/DO0o=;
 b=UwcErFF34JcMhRf/1ciIKkhNvBmLcjGpfIog/Ayr32nM9GEXr2qQo7VMwnDoivEfJFn1VcT7vVfP9yhZOmmXdxYQwgJT5LIpYxxBrrN7En6D2/qBeZxs/xYzMBXqDBqJ5ZjMqTGx8LP+eNopUD0rFGhRCsUCvA29pMe2GIsAEn/6ctZz61maBYAiIgqvkDw/MDI8QoDXCd5DZgON0CeuueIfdUm3jAMe9MM2oHYMUI121WhanBQLG2gCypMnGdVSu+NEIQP1RzwmuSSM2CerXlYmISCHR9BKfKk9m/bCumHvZykK35GllapYUOqdBDWYXj4NBbNG24mVmo+1Iww6Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t2e7JpZa3tOKJTlJqb7+Hu+C07gfMG4HZFDfPv/DO0o=;
 b=ib3PHebXTQ+zZwvJN97cv/1wSdgNYjxs+cYDd5FCnS3PArEaqyq55KlVdmd+pl6mc3Li/LV/yxkhlcVxZdb1sME+/qScQV3vAikWX/5qRYaC79TuE3XTKfFSEooPQoeanGZnCfCVOAm1dRtqp0TqJUfryyCrkomm23132yK60VonrwirWj2KMOT32rffdUGH1nrbuBl/dtsk/ELa58pc3RuNtQbqL8z5aHTgU6pbIOLC15ocExHsdoD4YvoVZiRDaAfe/gdTMaFFFRgZoK72KLfwSCPHvGd5xQfVGwkEXo5SHZkOTHkP5kBu6Qey0/1mYyssua5QIrO7n9WCMKTcoQ==
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by SA1PR12MB7104.namprd12.prod.outlook.com (2603:10b6:806:29e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 4 Apr
 2024 12:38:26 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::aa05:b8a0:7d5:b463]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::aa05:b8a0:7d5:b463%3]) with mapi id 15.20.7409.042; Thu, 4 Apr 2024
 12:38:26 +0000
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
Subject: [PATCH v24 11/20] net/mlx5e: Refactor ico sq polling to get budget
Date: Thu,  4 Apr 2024 12:37:08 +0000
Message-Id: <20240404123717.11857-12-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240404123717.11857-1-aaptel@nvidia.com>
References: <20240404123717.11857-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0128.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::10) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|SA1PR12MB7104:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k8WuNmRhiRKlXGEXU47EJEN7gjW8l4nNihx9TXM4CHlj7yQZWVGxrLKl8gEoC80dwrUM8dkIgSWe5S/u7VoMNut0WRJbJACCUjIWxeYVlLcDgDCJXRc33kiCHtBS7d3q3UtGWnD2y+rdmVSyiQP2VDRCTaMFXCGQmRelyefwjS6AL33z2i9BshCFVLPwEl6aItjMdh4SLKeQQKFP5zl6GdkPsEMExz7COQK3HNZMkdWMSfxGj0ZbeksEnsRksTsJUO1DsfYp47tr6W17TGznWrAWKSwa517VTdOsKaa36vBj/JQZ+/Llwz1J8cm5KzwTAUbLwe9vhJ7jdYLb2AXGKaHs0CtDYnBb+prgupOt5bOBoDb2QWjO1Wz3fFm6bSpzGGeYzGMf4TzJLRP8CHpZ3p39ajsz96rFIrZ2hUPJl51M2lqeEW75u58dgvGRPZyCrA7WDnSo4I5w6DsrB/kefSv4V26K2xuVyDHrGqpjbOESMf0meayK6Z/8Lmd20b86Xmtn6yzzr4lYxbBy1stw1D7CiBWJOm6YbrDG6erKavDQOkh5jqd5+SV//MzdGz2+B27bIzLWpq5ggwqTTfptkbSxWd+nMAwO/0pjounziPiGfCSpgmVZpWmsdaCSMZYog/zdz4M29/vPIzHpoUzvE0vadGsK3qIUvxv99BhlSP0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VVgtVbdfDD2II+35shvCGwNm3CCfqp+xxhHUjzkoxSihrakiJDZyPz03RSw+?=
 =?us-ascii?Q?AxPTfWU4kEofXtvLl4v8zulZWLE2DaWRwa1Z6rKu5hi0Q+glSsCeDxbSuDHk?=
 =?us-ascii?Q?YywsK5mT5n4ZafqWX70MMDqmW6gIugE8S0XN5ELi5SGoJh/S+lDA43ertexe?=
 =?us-ascii?Q?G4pDY6BScjzuhyiWkWbh5rBBjDnfggA25qsmZCRG3lUAlwD02zKfGFMcu5EZ?=
 =?us-ascii?Q?YhXdRJw5D0G7rw2zeq7jgbseuo4+83QapRRBW2kCFPw/TUjyxmtXQs4kdcRo?=
 =?us-ascii?Q?33/5wlnckAb22KSmKDpQqUpGAI5EpJF85WykIhOxHHkjJnnQLQtu5m+BfcPT?=
 =?us-ascii?Q?8l+DrHf1H2FZMutL10P/VgoqJ11my6hiIGCJFSzB6v3hBNWMS9B94d8Z0BHy?=
 =?us-ascii?Q?ILMZ2MGn2yQslI5P+UsYrR47csM8tuWaoEYi3KNT9GknXgmsHhIABktBLugX?=
 =?us-ascii?Q?hjodLBXN9CbICBolpmTsd53d5u+IlIYPwanVv3rtR/wYOnH5OsZHJPV5mad6?=
 =?us-ascii?Q?9hDV+KU2PB6hn09BVsjcnJ8N+axKl1ym3j8tyyGW0nNVNlV5HNUn2VfVrZo/?=
 =?us-ascii?Q?YUKzdSzg9E53he34BySQzL6A764eSgMpPVkkxy8ZvGyWAMsTvrAWSA0F9i5O?=
 =?us-ascii?Q?n07BoxqLfxK/VI85NUvukzS/jJgigzHUuA26fclRK70qicF4HYcAgmqVGcpY?=
 =?us-ascii?Q?+0kXnr/gB95XsEBOF1mRemxf73ZHqV91i7SnjKwX3HTuYTKXPZINc9EEuocr?=
 =?us-ascii?Q?EyAfdMDz27XFBUnlcpaSDtqY5DTTnPsQ9TvB03BYAcwBjcV69Ef8RuUUUFat?=
 =?us-ascii?Q?V0FylWrAUocb7phnAEROMiWJSAywks2hj+M3y6cPlcFkeMpghyVnR8nCcR2s?=
 =?us-ascii?Q?hL6M29P9O3mZTmLFU3TXDJR7O9LKQSZJiDdjiHlUQ5AMfhh4UhAWTbcFgVtj?=
 =?us-ascii?Q?cJUyM7RUJ9NAasaM1lPq/Ml1hLLJ65mbycDktRo7BCZv/x7io0c6Mj+jJmdw?=
 =?us-ascii?Q?C+UIrCEygwf8S03qYGlB657vuyjosCd+CL4s66lzTbN6aOjVc4lcIdFH6xZv?=
 =?us-ascii?Q?ieCtdd5Y/y1VBN2aenMYtNK7nZo0I8v/XfUWrpsEhUbh2EdnkZCiVeeQTb9r?=
 =?us-ascii?Q?N3yioi3tHA/bT1geSBt7o5sPd0rvSBJYC4ord02XKJvMVNv4Tu1dWZDfH5Ir?=
 =?us-ascii?Q?fs5JgaO39/vpIbAFG7fdUF4X6wEZ4Y/f9Xg2qW/TCN/f7oXdOe9R8HmIxMA0?=
 =?us-ascii?Q?T4EcCqHTlU+l9XINKRw5S/ikJhgHjzLD5OLNb5F7UMoozJUsMAL2wKNqtL0U?=
 =?us-ascii?Q?n3CoARB4MPiiQjLji0prE5HPnf5OXLMyWXA4U2TNPoFSQV09Xq4r3hMI5uYL?=
 =?us-ascii?Q?uU/budsOPxvNP2bmi/7LJcwU3+Xp4PQ1cUBxdcNIdNdbaC753DsUkpqCTxzw?=
 =?us-ascii?Q?Bj6g45gFMR6QeJv2NooLM87KyBFm/zQcHcupDCOIS/l7GojMubIpvNWWWF++?=
 =?us-ascii?Q?z5TdhAxEErktr309YLgRZXrPrvnm202x4sVKEnRwZNiT9b9FQZgy4QfNrEB5?=
 =?us-ascii?Q?vtNJuS7kAGREfj2b04yoljjaJHbwjrNnn2hN8TVm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 404bc7d3-74f5-469f-decc-08dc54a41f8b
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2024 12:38:26.2380
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GGUWcn3W21KHRww8QKss3PYAv1ihpHWXMj1dNidgffKD+xymg3ntkNAL6N+WoZzOsp2RfGUOnkYKEh1mjIACTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7104
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240404_053848_719665_9E9EA9C4 
X-CRM114-Status: GOOD (  15.74  )
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
 drivers/net/ethernet/mellanox/mlx5/core/en.h             | 1 +
 drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c | 4 ++--
 drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h        | 2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c        | 5 ++---
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c          | 4 ++--
 drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c        | 4 ++--
 6 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index 84db05fb9389..e3471c442c8b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -557,6 +557,7 @@ struct mlx5e_icosq {
 	/* control path */
 	struct mlx5_wq_ctrl        wq_ctrl;
 	struct mlx5e_channel      *channel;
+	struct mlx5_core_dev      *mdev;
 
 	struct work_struct         recover_work;
 } ____cacheline_aligned_in_smp;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c
index 25d751eba99b..b45497e6ab1a 100644
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
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 81e1c1e401f9..a467a011c599 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -1514,6 +1514,7 @@ static int mlx5e_alloc_icosq(struct mlx5e_channel *c,
 	int err;
 
 	sq->channel   = c;
+	sq->mdev      = mdev;
 	sq->uar_map   = mdev->mlx5e_res.hw_objs.bfreg.map;
 	sq->reserved_room = param->stop_room;
 
@@ -1914,11 +1915,9 @@ void mlx5e_deactivate_icosq(struct mlx5e_icosq *icosq)
 
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
index d601b5faaed5..780902f63823 100644
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



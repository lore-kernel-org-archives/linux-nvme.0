Return-Path: <SRS0=qdm1=MO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ABBEC63793
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Jul 2021 12:24:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E84696135A
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Jul 2021 12:24:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E84696135A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YH7bcpxmu8nAKr/UdUZuD8Qm2QgPhQQras/Iaf/5dQg=; b=hrfyWXu/sgTowW
	JtNihxxz96AvPox4UdyODghBNkiJ1U8/8A2FscjAQN6DrOEqiY3L+I9MNnCsP1NrEsAjLuO2QPHLH
	WV6nKiMEA0+rgytv7YVdmoPrw8lrZOM8hnt/WUHPYCUXplcGMQpxQQhL5Rte/+czMcPbg+XmI82pK
	3sLINeoWkmrnki+80LhoT7SkuHT3Ih+wkZyPQfFfGLlNDHeo9pTn43ihEUB1omcKO3l2x+EvWW9FN
	kfM3CiP6HbjGkks3RTrxBiZHJc0MZK4fMRPU1Ax4F38a651mQ7Mk2JzipS3M7Q2pP01pxIz5jRpDS
	j95hK/jnoOO+ujVFAVMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m6Xk1-001TsD-9H; Thu, 22 Jul 2021 12:23:53 +0000
Received: from mail-bn7nam10on2063.outbound.protection.outlook.com
 ([40.107.92.63] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m6WY2-001J9H-8q
 for linux-nvme@lists.infradead.org; Thu, 22 Jul 2021 11:07:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A0CUYgT7Hpc6Max/+lpTDwJKAcqPHEI7Ff7XkyoB4wOivUHpFA5CKvdCx6SJUK1rhHad5vKgLUHptpCcjhOqC03xqwBqzYpKwGjxBBQaxIDAW3leNTQnpI3XNyq8PjE4gVvEINN5nQPHH1XVMiKrK2BUkYzx1O1o8JWocUI92QAkjCBVT1g8OAeP1muX9aQUmG1OBb0A1amLWWGV6mywlHULie4UJ548Km+rrnA2dc6NtJ/guHex3Ks+ksa0qyobzv9s6N53iSvft1aUSxQ4kM5LCTV0odlC7TRX40ZOIX6vGo9NJ1/FxfjL/sWtNbqX7B2Tmg9yTFpWn62W0Q28vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fmrIrnJiJ9al4+ThgYzDCiTuGDU5hVklX5lHdBbm4hU=;
 b=D8p69yeoVZYvd8deJYEQhvkTtpNbbH4Kkes8QQR62X2ZTczl2g2UnMYaBZ/0wqZ6VCtOtUO27YKVojbIBfKWgS9KifJJvIR47ZYgsTan+77wnqMqrCmHNpWhaKwCOfYy7qq5JnGy0US1H+soEIKs+t/lRV0I/LBCxL2/pmHtI2LoJkoNLC/CjI8Us48i220JBRGJNHDK2zhB5WdcGufswSYsPWXEFBB4/M4x4z02uHxejaEhpAIDiS0wf4kjB7JLPCm11Xj62WlJm3na48wRX5WdM6DJ68u6qVGrsKJp+uv85Gdy+XvNHPb9hIptuRmzR4hjwze3RT6yGGPfPHzueQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.32) smtp.rcpttodomain=marvell.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com; 
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fmrIrnJiJ9al4+ThgYzDCiTuGDU5hVklX5lHdBbm4hU=;
 b=b8bXfZdaL6QFMCRW2YYmtK1U0b7qC/ISsIYH5eNPqfwHzAxGsyzfaP/CxG0KauTwJ8D/4XP6C1JzLydjy7ZpDIGL82tX8IhPe0OZvJxVu5hTA3VIeFCdw2oFg2dsWikLqJcai9Ij0cjnxvBHVyw4UraTG4pR4hf7FHhGxsSHfICEQ6RAXFExDMSUObPFwEEFZAAOtxzT7+3spAgKvSjOWHCasXiClc5BKq+7Qzzo3zC4JcWWQrxUZPz0o2PIB1Dys1qrAHSoEI4hE77udciEUgxbptUtf5WlRb/SLntXfQPnAgcCsQU9a8vDFR5d9tOSy11NUI1uKCrfClieJGO3ig==
Received: from DM6PR02CA0075.namprd02.prod.outlook.com (2603:10b6:5:1f4::16)
 by BN9PR12MB5163.namprd12.prod.outlook.com (2603:10b6:408:11c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.26; Thu, 22 Jul
 2021 11:07:24 +0000
Received: from DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1f4:cafe::3e) by DM6PR02CA0075.outlook.office365.com
 (2603:10b6:5:1f4::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.25 via Frontend
 Transport; Thu, 22 Jul 2021 11:07:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.32)
 smtp.mailfrom=nvidia.com; marvell.com; dkim=none (message not signed)
 header.d=none;marvell.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.32 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.32; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.32) by
 DM6NAM11FT022.mail.protection.outlook.com (10.13.172.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4352.24 via Frontend Transport; Thu, 22 Jul 2021 11:07:23 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 22 Jul
 2021 04:07:22 -0700
Received: from vdi.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 22 Jul 2021 11:07:15 +0000
From: Boris Pismenny <borisp@nvidia.com>
To: <dsahern@gmail.com>, <kuba@kernel.org>, <davem@davemloft.net>,
 <saeedm@nvidia.com>, <hch@lst.de>, <sagi@grimberg.me>, <axboe@fb.com>,
 <kbusch@kernel.org>, <viro@zeniv.linux.org.uk>, <edumazet@google.com>,
 <smalin@marvell.com>
CC: <boris.pismenny@gmail.com>, <linux-nvme@lists.infradead.org>,
 <netdev@vger.kernel.org>, <benishay@nvidia.com>, <ogerlitz@nvidia.com>,
 <yorayz@nvidia.com>
Subject: [PATCH v5 net-next 36/36] net/mlx5e: NVMEoTCP DDGST TX statistics
Date: Thu, 22 Jul 2021 14:03:25 +0300
Message-ID: <20210722110325.371-37-borisp@nvidia.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20210722110325.371-1-borisp@nvidia.com>
References: <20210722110325.371-1-borisp@nvidia.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 582051a0-d58a-412b-5d31-08d94d00e20f
X-MS-TrafficTypeDiagnostic: BN9PR12MB5163:
X-Microsoft-Antispam-PRVS: <BN9PR12MB51638E9BFE40C7F64E81409BBDE49@BN9PR12MB5163.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:390;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fNZ/hH39b2ZNDuxq01a4fB7g64ju9ssYzLimfx7NFDpK3hIq7R0flgWB1DLcHvkAwok6z+WY+D0x+STXg9pRc6VQdpRTpArsNRmAxJqLrHN29GIsp/OZNqWTy65936wzJijX2HR9Dh7HJy5uaULlckrDIufJhD+wxFTNxKd725ydgNy4P2Zs8ne2QCFs3CkDKLSxX2J2KNqfbrM99ELBVYzx6DzSTsgfm6vQdjWnJTET94Hb4ZRM3SPWGZpF4eNZkbKRT+R1k7MrkOyoO6soPC8fCvHaV2HwbMMQZeeTwaZvgNnZpE2WHGrFyR3XQi06Dub12OiP8LOFGsVpMmK1SvX9aJ6CYxvMz1lgFmK54n62g9PrRpBIeV2k6L+hsmVK4hhNzu8BBnnZNNdtVjGro5H5HEbm1//ykSZ6kFzj9Wle75okPbHS6Maz+3tUBjDKRJZwC0Hu3cKJ48u3SXDWXtzJ5roAPrel61oNfte5segMqS1DJoC6AmwrYtWZcg7bmE6PoAPh+kWt6SjX8RbzBl+voP8IH0diz61Y9vRaJbVoUX/PlqQKVEPwO4Z63HdbInm2UDUUY8NCpWBtMbTvOKoc27Lk4f8gIwp5y20ylPPx31mi7f71icLAUPKiRBbAlpLRacA19rfyPI+A2mj/S3KK4+LvJvocG22Nn766783w74C+GcLrTTH1xmz/jtwakIBM2W37Sk5OK0eoFH58ED1ZCx7P1y9vPJ0tstuSOxY=
X-Forefront-Antispam-Report: CIP:216.228.112.32; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid01.nvidia.com; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(356005)(6666004)(47076005)(83380400001)(110136005)(336012)(36860700001)(186003)(7636003)(26005)(82310400003)(54906003)(86362001)(921005)(7696005)(2906002)(7416002)(8676002)(1076003)(4326008)(8936002)(5660300002)(426003)(2616005)(316002)(508600001)(70586007)(70206006)(107886003)(36756003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2021 11:07:23.6123 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 582051a0-d58a-412b-5d31-08d94d00e20f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.32];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5163
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210722_040726_475341_E2C683A4 
X-CRM114-Status: GOOD (  14.71  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Yoray Zack <yorayz@nvidia.com>

    NVMEoTCP Tx offload statistics includes both control and data path
    statistic: counters for contex, offloaded packets/bytes,
    out-of-order packets resync operation (success/fail),
    and DUMP packets/bytes.

Signed-off-by: Yoray Zack <yorayz@nvidia.com>
---
 .../mellanox/mlx5/core/en_accel/ktls_tx.c     |  4 ++
 .../mellanox/mlx5/core/en_accel/nvmeotcp.c    | 22 ++++++++++-
 .../ethernet/mellanox/mlx5/core/en_stats.c    | 37 +++++++++++++++++++
 .../ethernet/mellanox/mlx5/core/en_stats.h    | 23 ++++++++++++
 4 files changed, 84 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_tx.c
index 64780d0143ec..4b0d4bd88b9c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_tx.c
@@ -366,6 +366,10 @@ void mlx5e_ktls_tx_handle_resync_dump_comp(struct mlx5e_txqsq *sq,
 		stats->tls_dump_bytes += wi->num_bytes;
 		break;
 	case MLX5E_DUMP_WQE_NVMEOTCP:
+#ifdef CONFIG_ULP_DDP
+		stats->nvmeotcp_dump_packets++;
+		stats->nvmeotcp_dump_bytes += wi->num_bytes;
+#endif
 		break;
 	}
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
index f3ef92167e25..34676c81d889 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
@@ -1388,8 +1388,10 @@ bool mlx5e_nvmeotcp_resync_cap(struct mlx5e_nvmeotcp_queue *queue,
 	if (unlikely(ret))
 		goto err_out;
 out:
+	sq->stats->nvmeotcp_resync++;
 	return true;
 err_out:
+	sq->stats->nvmeotcp_resync_fail++;
 	return false;
 }
 
@@ -1413,21 +1415,29 @@ mlx5e_nvmeotcp_handle_ooo_skb(struct mlx5e_nvmeotcp_queue *queue,
 			      u32  seq, int datalen)
 {
 	struct ulp_ddp_pdu_info *pdu_info = NULL;
+	struct mlx5e_sq_stats *stats = sq->stats;
 
+	stats->nvmeotcp_ooo++;
 	if (mlx5e_nvmeotcp_check_if_need_offload(queue, seq + datalen, seq)) {
+		stats->nvmeotcp_no_need_offload++;
 		return MLX5E_NVMEOTCP_RESYNC_SKIP;
+	}
 
 	/* ask for pdu_info that includes the tcp_seq */
 	pdu_info = ulp_ddp_get_pdu_info(skb->sk, seq);
 
-	if (!pdu_info)
+	if (!pdu_info) {
+		stats->nvmeotcp_no_pdu_info++;
 		return MLX5E_NVMEOTCP_RESYNC_SKIP;
+	}
 
 	queue->end_seq_hint = pdu_info->end_seq - 4;
 	queue->start_pdu_hint = pdu_info->start_seq;
 	/* check if this packet contain crc - if so offload else no */
 	if (mlx5e_nvmeotcp_check_if_need_offload(queue, seq + datalen, seq)) {
+		stats->nvmeotcp_no_need_offload++;
 		return MLX5E_NVMEOTCP_RESYNC_SKIP;
+	}
 
 	/*update NIC about resync - he will rebuild parse machine
 	 *send psv with small fence
@@ -1464,6 +1474,7 @@ bool mlx5e_nvmeotcp_handle_tx_skb(struct net_device *netdev,
 				  struct sk_buff *skb, int *nvmeotcp_tisn)
 {
 	struct mlx5e_nvmeotcp_queue *ctx;
+	struct mlx5e_sq_stats *stats = sq->stats;
 	int datalen;
 	u32 seq;
 
@@ -1484,8 +1495,10 @@ bool mlx5e_nvmeotcp_handle_tx_skb(struct net_device *netdev,
 	if (WARN_ON_ONCE(ctx->ulp_ddp_ctx.netdev != netdev))
 		goto err_out;
 
-	if (unlikely(mlx5e_nvmeotcp_test_and_clear_pending(ctx)))
+	if (unlikely(mlx5e_nvmeotcp_test_and_clear_pending(ctx))) {
 		mlx5e_nvmeotcp_tx_post_param_wqes(sq, skb->sk, ctx);
+		stats->nvmeotcp_ctx++;
+	}
 
 	seq = ntohl(tcp_hdr(skb)->seq);
 	if (unlikely(ctx->ulp_ddp_ctx.expected_seq != seq)) {
@@ -1504,6 +1517,11 @@ bool mlx5e_nvmeotcp_handle_tx_skb(struct net_device *netdev,
 
 	*nvmeotcp_tisn = ctx->tisn;
 	ctx->ulp_ddp_ctx.expected_seq = seq + datalen;
+	stats->nvmeotcp_offload_packets += skb_is_gso(skb) ?
+		skb_shinfo(skb)->gso_segs : 1;
+
+	stats->nvmeotcp_offload_bytes   += datalen;
+
 	goto good_out;
 out:
 	*nvmeotcp_tisn = 0;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
index 3d95e46422e5..c51d1a76b22f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
@@ -125,6 +125,18 @@ static const struct counter_desc sw_stats_desc[] = {
 	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, tx_tls_drop_no_sync_data) },
 	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, tx_tls_drop_bypass_req) },
 #endif
+#ifdef CONFIG_MLX5_EN_NVMEOTCP
+	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, tx_nvmeotcp_offload_packets) },
+	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, tx_nvmeotcp_offload_bytes) },
+	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, tx_nvmeotcp_ooo) },
+	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, tx_nvmeotcp_dump_packets) },
+	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, tx_nvmeotcp_dump_bytes) },
+	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, tx_nvmeotcp_resync) },
+	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, tx_nvmeotcp_ctx) },
+	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, tx_nvmeotcp_resync_fail) },
+	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, tx_nvmeotcp_no_need_offload) },
+	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, tx_nvmeotcp_no_pdu_info) },
+#endif
 
 	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_lro_packets) },
 	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_lro_bytes) },
@@ -420,6 +432,19 @@ static void mlx5e_stats_grp_sw_update_stats_sq(struct mlx5e_sw_stats *s,
 	s->tx_tls_drop_no_sync_data += sq_stats->tls_drop_no_sync_data;
 	s->tx_tls_drop_bypass_req   += sq_stats->tls_drop_bypass_req;
 #endif
+#ifdef CONFIG_MLX5_EN_NVMEOTCP
+	s->tx_nvmeotcp_offload_packets += sq_stats->nvmeotcp_offload_packets;
+	s->tx_nvmeotcp_offload_bytes   += sq_stats->nvmeotcp_offload_bytes;
+	s->tx_nvmeotcp_ooo             += sq_stats->nvmeotcp_ooo;
+	s->tx_nvmeotcp_dump_bytes      += sq_stats->nvmeotcp_dump_bytes;
+	s->tx_nvmeotcp_dump_packets    += sq_stats->nvmeotcp_dump_packets;
+	s->tx_nvmeotcp_resync	       += sq_stats->nvmeotcp_resync;
+	s->tx_nvmeotcp_ctx             += sq_stats->nvmeotcp_ctx;
+	s->tx_nvmeotcp_resync_fail     += sq_stats->nvmeotcp_resync_fail;
+	s->tx_nvmeotcp_no_need_offload += sq_stats->nvmeotcp_no_need_offload;
+	s->tx_nvmeotcp_no_pdu_info     += sq_stats->nvmeotcp_no_pdu_info;
+#endif
+
 	s->tx_cqes                  += sq_stats->cqes;
 }
 
@@ -1850,6 +1875,18 @@ static const struct counter_desc sq_stats_desc[] = {
 	{ MLX5E_DECLARE_TX_STAT(struct mlx5e_sq_stats, tls_skip_no_sync_data) },
 	{ MLX5E_DECLARE_TX_STAT(struct mlx5e_sq_stats, tls_drop_no_sync_data) },
 	{ MLX5E_DECLARE_TX_STAT(struct mlx5e_sq_stats, tls_drop_bypass_req) },
+#endif
+#ifdef CONFIG_MLX5_EN_NVMEOTCP
+	{ MLX5E_DECLARE_TX_STAT(struct mlx5e_sq_stats, nvmeotcp_offload_packets) },
+	{ MLX5E_DECLARE_TX_STAT(struct mlx5e_sq_stats, nvmeotcp_offload_bytes) },
+	{ MLX5E_DECLARE_TX_STAT(struct mlx5e_sq_stats, nvmeotcp_ooo) },
+	{ MLX5E_DECLARE_TX_STAT(struct mlx5e_sq_stats, nvmeotcp_dump_packets) },
+	{ MLX5E_DECLARE_TX_STAT(struct mlx5e_sq_stats, nvmeotcp_dump_bytes) },
+	{ MLX5E_DECLARE_TX_STAT(struct mlx5e_sq_stats, nvmeotcp_resync) },
+	{ MLX5E_DECLARE_TX_STAT(struct mlx5e_sq_stats, nvmeotcp_ctx) },
+	{ MLX5E_DECLARE_TX_STAT(struct mlx5e_sq_stats, nvmeotcp_no_need_offload) },
+	{ MLX5E_DECLARE_TX_STAT(struct mlx5e_sq_stats, nvmeotcp_no_pdu_info) },
+	{ MLX5E_DECLARE_TX_STAT(struct mlx5e_sq_stats, nvmeotcp_resync_fail) },
 #endif
 	{ MLX5E_DECLARE_TX_STAT(struct mlx5e_sq_stats, csum_none) },
 	{ MLX5E_DECLARE_TX_STAT(struct mlx5e_sq_stats, stopped) },
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
index e645ee83de97..3ca48d69a2d6 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
@@ -205,6 +205,17 @@ struct mlx5e_sw_stats {
 	u64 rx_nvmeotcp_resync;
 	u64 rx_nvmeotcp_offload_packets;
 	u64 rx_nvmeotcp_offload_bytes;
+
+	u64 tx_nvmeotcp_offload_packets;
+	u64 tx_nvmeotcp_offload_bytes;
+	u64 tx_nvmeotcp_ooo;
+	u64 tx_nvmeotcp_resync;
+	u64 tx_nvmeotcp_dump_packets;
+	u64 tx_nvmeotcp_dump_bytes;
+	u64 tx_nvmeotcp_ctx;
+	u64 tx_nvmeotcp_no_need_offload;
+	u64 tx_nvmeotcp_no_pdu_info;
+	u64 tx_nvmeotcp_resync_fail;
 #endif
 	u64 ch_events;
 	u64 ch_poll;
@@ -405,6 +416,18 @@ struct mlx5e_sq_stats {
 	u64 tls_skip_no_sync_data;
 	u64 tls_drop_no_sync_data;
 	u64 tls_drop_bypass_req;
+#endif
+#ifdef CONFIG_MLX5_EN_NVMEOTCP
+	u64 nvmeotcp_offload_packets;
+	u64 nvmeotcp_offload_bytes;
+	u64 nvmeotcp_ooo;
+	u64 nvmeotcp_resync;
+	u64 nvmeotcp_dump_packets;
+	u64 nvmeotcp_dump_bytes;
+	u64 nvmeotcp_ctx;
+	u64 nvmeotcp_resync_fail;
+	u64 nvmeotcp_no_need_offload;
+	u64 nvmeotcp_no_pdu_info;
 #endif
 	/* less likely accessed in data path */
 	u64 csum_none;
-- 
2.24.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

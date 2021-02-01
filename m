Return-Path: <SRS0=DeHG=HD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19C3CC433E0
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Feb 2021 10:31:19 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5C8B64DDD
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Feb 2021 10:31:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5C8B64DDD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=0tBZJo4RpSdrots2iReGj7+XRLJtkrpK+c1adYQPHKw=; b=En4aSvljZVxA4juxLl63ocGqD
	F3JehpG3eiqM1Z16I2L44lp/UVWz2aqIQkSxT0FJLuFcR7LUQK9mR+8yu1XcjVKWBvMnW8izenGRe
	4CHyK86f9094F4W2AN5JCEq9juOwNJHSFdr2KylsVqbPyPkwCrjvroohGx5ovWe25EcL60a9GZTtT
	zr+2pUewRlfVXmCTp1fxiVMOUJb3MSdf0OUCgLS5WoU3bU7eNC++BHFctVlq+QBG85anC6hQpUQ86
	TRFEBMq83/J+XzJmh/U0Z8/0AFmYeYLdJAbU8j6rgmgrHwTsA8AO4jLegZhXmtybgeQu3WenlDPA3
	JVtJkMcFg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l6WUB-00005f-3G; Mon, 01 Feb 2021 10:31:11 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l6WQo-0006OK-06
 for linux-nvme@merlin.infradead.org; Mon, 01 Feb 2021 10:27:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=0ov4c4Wa0aN/ygmvyq/RH0Y5zBGo2jyN+YTiFpiEhuY=; b=hZactRdrEiV/SgNCJmutU0hrH4
 DeGZTd8KW/GYH2NhPblesaPRH8sdPAMsWOzpnJTte1m6/yTOb4l0ZIB7vNBCqTBYNuPpM46UL3QRY
 jy1InYmDM88ScTHmcbEIS9k/2Zd/E7E7bORVBL+DNgDuBqWXgukeQljaGXC47VMuYy3qOvc5tZcL5
 NL+/d+E/p5smeTZM1pMnq/3fxE7EYSHitk3G/IXP+MZF90wTaH7GLg8fX5fxfPb36IMG56BgQi6Or
 /S95JCpg2HvbjmOaebxNYc2+cIUUzR/8vsQ0dsQ2PMrEc5OEDZ59EPHqK//OjSo7N2UDLyp/MgPh+
 2RdzQY4g==;
Received: from mail-il-dmz.mellanox.com ([193.47.165.129] helo=mellanox.co.il)
 by casper.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
 id 1l6W5C-00DcmE-KR
 for linux-nvme@lists.infradead.org; Mon, 01 Feb 2021 10:05:23 +0000
Received: from Internal Mail-Server by MTLPINE1 (envelope-from
 borisp@mellanox.com) with SMTP; 1 Feb 2021 12:05:14 +0200
Received: from gen-l-vrt-133.mtl.labs.mlnx. (gen-l-vrt-133.mtl.labs.mlnx
 [10.237.11.160])
 by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 111A5C0B029353;
 Mon, 1 Feb 2021 12:05:14 +0200
From: Boris Pismenny <borisp@mellanox.com>
To: dsahern@gmail.com, kuba@kernel.org, davem@davemloft.net, saeedm@nvidia.com,
 hch@lst.de, sagi@grimberg.me, axboe@fb.com, kbusch@kernel.org,
 viro@zeniv.linux.org.uk, edumazet@google.com, smalin@marvell.com
Subject: [PATCH v3 net-next  18/21] net/mlx5e: NVMEoTCP ddp setup and resync
Date: Mon,  1 Feb 2021 12:05:06 +0200
Message-Id: <20210201100509.27351-19-borisp@mellanox.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20210201100509.27351-1-borisp@mellanox.com>
References: <20210201100509.27351-1-borisp@mellanox.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210201_100523_331452_E1600D46 
X-CRM114-Status: GOOD (  12.10  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Yoray Zack <yorayz@mellanox.com>, yorayz@nvidia.com,
 boris.pismenny@gmail.com, benishay@nvidia.com, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, Or Gerlitz <ogerlitz@mellanox.com>,
 ogerlitz@nvidia.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Ben Ben-Ishay <benishay@nvidia.com>

NVMEoTCP offload uses buffer registration for every NVME request to
perform direct data placement, The registration is done via KLM UMR
WQE's.  The driver resync handler advertise the software resync response
via static params WQE.

Signed-off-by: Boris Pismenny <borisp@mellanox.com>
Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
Signed-off-by: Or Gerlitz <ogerlitz@mellanox.com>
Signed-off-by: Yoray Zack <yorayz@mellanox.com>
---
 .../mellanox/mlx5/core/en_accel/nvmeotcp.c    | 33 +++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
index f30bfcb43701..4cbd86b9ed42 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
@@ -754,6 +754,30 @@ mlx5e_nvmeotcp_ddp_setup(struct net_device *netdev,
 			 struct sock *sk,
 			 struct tcp_ddp_io *ddp)
 {
+	struct mlx5e_priv *priv = netdev_priv(netdev);
+	struct scatterlist *sg = ddp->sg_table.sgl;
+	struct mlx5e_nvmeotcp_queue *queue;
+	struct mlx5_core_dev *mdev;
+	int i, size = 0, count = 0;
+
+	queue = container_of(tcp_ddp_get_ctx(sk), struct mlx5e_nvmeotcp_queue, tcp_ddp_ctx);
+
+	mdev = queue->priv->mdev;
+	count = dma_map_sg(mdev->device, ddp->sg_table.sgl, ddp->nents,
+			   DMA_FROM_DEVICE);
+
+	if (WARN_ON(count > mlx5e_get_max_sgl(mdev)))
+		return -ENOSPC;
+
+	for (i = 0; i < count; i++)
+		size += sg[i].length;
+
+	queue->ccid_table[ddp->command_id].size = size;
+	queue->ccid_table[ddp->command_id].ddp = ddp;
+	queue->ccid_table[ddp->command_id].sgl = sg;
+	queue->ccid_table[ddp->command_id].ccid_gen++;
+	queue->ccid_table[ddp->command_id].sgl_length = count;
+
 	return 0;
 }
 
@@ -791,11 +815,11 @@ mlx5e_nvmeotcp_ddp_teardown(struct net_device *netdev,
 			    struct tcp_ddp_io *ddp,
 			    void *ddp_ctx)
 {
-	struct mlx5e_nvmeotcp_queue *queue =
-		(struct mlx5e_nvmeotcp_queue *)tcp_ddp_get_ctx(sk);
+	struct mlx5e_nvmeotcp_queue *queue;
 	struct mlx5e_priv *priv = netdev_priv(netdev);
 	struct nvmeotcp_queue_entry *q_entry;
 
+	queue = container_of(tcp_ddp_get_ctx(sk), struct mlx5e_nvmeotcp_queue, tcp_ddp_ctx);
 	q_entry  = &queue->ccid_table[ddp->command_id];
 	WARN_ON(q_entry->sgl_length == 0);
 
@@ -811,6 +835,11 @@ static void
 mlx5e_nvmeotcp_dev_resync(struct net_device *netdev,
 			  struct sock *sk, u32 seq)
 {
+	struct mlx5e_nvmeotcp_queue *queue =
+		container_of(tcp_ddp_get_ctx(sk), struct mlx5e_nvmeotcp_queue, tcp_ddp_ctx);
+
+	queue->after_resync_cqe = 1;
+	mlx5e_nvmeotcp_rx_post_static_params_wqe(queue, seq);
 }
 
 static const struct tcp_ddp_dev_ops mlx5e_nvmeotcp_ops = {
-- 
2.24.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

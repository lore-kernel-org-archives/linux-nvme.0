Return-Path: <SRS0=0To6=77=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D0CAC433DF
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Jun 2020 21:16:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 557B5206B7
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Jun 2020 21:16:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Qk5rwod9";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="UCkLZZdc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 557B5206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Hj7MGCoM2dRg4xCk0YLOLlYkdVF/tSDJlPZ4io2VsNo=; b=Qk5rwod93ItT72
	pK5RDxZpAMflfLgX8/aMwIjKEXwf508UfdDDlN7JKcLkjjSiq2aGWgJvlKnwtVbwXbhIApoAZGZOa
	ROhEyQgi3C9YcyCsxhv9ioMMiaszomGlybvK0pDsL6G9aLqjuBOujKQ+Pbq66OLFl3D79C4emgx6Y
	7yp65Q1IrulnmbGvQoI84JcLCdqOSdr7RQI/p5zEVMN/ucL7Ku/UpDcLDLegLpO8rs7aHHyD6Ktcr
	wVjcbLwOWnUpo5pYcKTH+bXfZoH3Ung/9kD1bzdR7n7uUk7cVsdEwwC/dwh2QiVyIK42ojvdgu31W
	kaiHunL31nr199YDlEfg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jm1tF-0007hy-6v; Thu, 18 Jun 2020 21:16:05 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jm0kI-0001i3-83
 for linux-nvme@lists.infradead.org; Thu, 18 Jun 2020 20:02:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1592510567; x=1624046567;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=gJuYaqcKR+OMZ7sPr5EK6CTqXx7WnxJVT3V/UoaoUYA=;
 b=UCkLZZdcDTo5oXLXKzeJk1GOYlrTgqkchBcrKP2JClc9xOKkMO2iNMf8
 Bb83lyoW5P6uu62ozDd1lkyjymmCtJ+jpYXAfjGgEqIVfooEZA2ZYSC3m
 ciSJEejkjxeBCOHbj9AcgCiZH0mWPVpy+3DCuRDiRy2xRkHdAlMiAcGTO
 OQiOaLHaexSB5+viK3fLsFtfD39Bre0Wjb5+vk/ccSXAOOPksvRL2pIVP
 +N0ACGQiUfSAOtzx8mcXeJM4vGYfLCzmerj4cfSyJS9kR9TiUZc8/akYq
 lPRlDYU+Rk1Qu1gYR7KZM9/Wj5jpp+FF6qMZ4qPE22rci27fs/Vuiq5+K g==;
IronPort-SDR: lEwgQH3dLC7jkqo7/FK0ZPBFEgQLx3lIazQSjfRhKmWdUbFkdUjOvTBT8sS4mexjXpUGBGPCHd
 w+vLg81lglGtzHcMDeZz1N3Qg5o855WEcILl6PMYacYmfkMNp2fKdupBdGLnPfoRQeA+ehZnk4
 JO7rKcP/WiPmZiiJXS0wlinFhsETzrYBH9GuUXp5QS5gdjmkelSdNzZI4IKqLzBZr4dLAjy5q2
 OilWREEBpj6w847UPDBC1C1fcGjGlkh+Axn0VmFWYmu5qqwdVAe6y25e0uywyoXUbfnyPD/aRE
 3As=
X-IronPort-AV: E=Sophos;i="5.75,252,1589212800"; d="scan'208";a="144673250"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 19 Jun 2020 04:02:47 +0800
IronPort-SDR: U4msZcAiqoBdv712b/EyZGMOz4/DE6Fpw70xaErhTHFukkpmzTa+sc84OS6JE9L9VbGJ6nvuDk
 g4umL7y1tLhrwW/NNpY7flDxeFglhydrc=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jun 2020 12:51:58 -0700
IronPort-SDR: 4x42ejM9hx1A2RKaVuLbvcjCLRTdokmVOWyuf781LTlTNCDoj7DmNk3s2yEx6lMKSh8/mr630K
 RoEuSZq6Pohw==
WDCIronportException: Internal
Received: from usa001298.ad.shared (HELO localhost.hgst.com) ([10.86.58.149])
 by uls-op-cesaip02.wdc.com with ESMTP; 18 Jun 2020 13:02:44 -0700
From: Niklas Cassel <niklas.cassel@wdc.com>
To: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH v2 2/2] nvmet: remove workarounds for gcc bug wrt unnamed
 fields in initializers
Date: Thu, 18 Jun 2020 22:02:34 +0200
Message-Id: <20200618200235.1104587-3-niklas.cassel@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200618200235.1104587-1-niklas.cassel@wdc.com>
References: <20200618200235.1104587-1-niklas.cassel@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200618_130246_302832_AA526C24 
X-CRM114-Status: GOOD (  12.92  )
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
Cc: Niklas Cassel <niklas.cassel@wdc.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Workarounds for gcc issues with initializers and anon unions was first
introduced in commit e44ac588cd61 ("drivers/block/nvme-core.c: fix build
with gcc-4.4.4").

The gcc bug in question has been fixed since gcc 4.6.0:
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=10676

The minimum gcc version for building the kernel has been 4.6.0 since
commit cafa0010cd51 ("Raise the minimum required gcc version to 4.6"),
and has since been updated to gcc 4.8.0 in
commit 5429ef62bcf3 ("compiler/gcc: Raise minimum GCC version for
kernel builds to 4.8").

For that reason, it should now be safe to remove these workarounds
and make the code look like it did before
commit e44ac588cd61 ("drivers/block/nvme-core.c: fix build with gcc-4.4.4")
was introduced.

Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
---
 drivers/nvme/target/rdma.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 6731e0349480..238bc55de561 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -1535,19 +1535,20 @@ static int nvmet_rdma_cm_accept(struct rdma_cm_id *cm_id,
 		struct nvmet_rdma_queue *queue,
 		struct rdma_conn_param *p)
 {
-	struct rdma_conn_param  param = { };
-	struct nvme_rdma_cm_rep priv = { };
+	struct nvme_rdma_cm_rep priv = {
+		.recfmt = cpu_to_le16(NVME_RDMA_CM_FMT_1_0),
+		.crqsize = cpu_to_le16(queue->recv_queue_size),
+	};
+	struct rdma_conn_param  param = {
+		.rnr_retry_count = 7,
+		.flow_control = 1,
+		.initiator_depth = min_t(u8, p->initiator_depth,
+			queue->dev->device->attrs.max_qp_init_rd_atom),
+		.private_data = &priv,
+		.private_data_len = sizeof(priv),
+	};
 	int ret = -ENOMEM;
 
-	param.rnr_retry_count = 7;
-	param.flow_control = 1;
-	param.initiator_depth = min_t(u8, p->initiator_depth,
-		queue->dev->device->attrs.max_qp_init_rd_atom);
-	param.private_data = &priv;
-	param.private_data_len = sizeof(priv);
-	priv.recfmt = cpu_to_le16(NVME_RDMA_CM_FMT_1_0);
-	priv.crqsize = cpu_to_le16(queue->recv_queue_size);
-
 	ret = rdma_accept(cm_id, &param);
 	if (ret)
 		pr_err("rdma_accept failed (error code = %d)\n", ret);
-- 
2.26.2


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

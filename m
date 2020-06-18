Return-Path: <SRS0=0To6=77=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F95C433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Jun 2020 14:33:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B490A207E8
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Jun 2020 14:33:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ubCdjoY8";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="kPF+CSFd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B490A207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0Q6y+kwBuPBGCgCgR8+OHa8MTfBUAv35qf/INnbZlEA=; b=ubCdjoY88/q1ES
	cDbolnyJlgC+np1EzNoRxvyoFMrU5vx1hn/NbcGIMCRGMbXhyX2XD/iZ5JFkDZVRtRac8K8NKcz1x
	iLBy9yLya/iGCeMsp/8gOT+sWR+SRA2etYpAYWSdzRdZ8zQdHw/gdx9c5tuppRjsOmw6GeaQoa84H
	LjFNSH5nRtHv9wH1TOLTVEAnZ8F7NqPPOg/CohwZVXIovW6Z4AnX6/ahqx6o35FgNtL5XJccnR3L+
	y0f5dDCsjT9vRTQf+3vI/xWlMTAMaCh/JAagapF4nEtJBzmjeztZ8+xH15d+8Mmjc3dPXRvLWvSRp
	bYW65qMudLrnuWTEkrQg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jlvbB-0004bW-Uc; Thu, 18 Jun 2020 14:33:01 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jlvb0-0004Rq-LK
 for linux-nvme@lists.infradead.org; Thu, 18 Jun 2020 14:32:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1592490781; x=1624026781;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=e6ntQ+VP9KSu9eLc9ytqyhX70E87lTK30bl1wZkiMCM=;
 b=kPF+CSFdXkKc2jpgVaqX+cLNPZpxI7Po9fLhf1si5raIRflFvWNN/c4t
 Cg7jTW5SO/nLwhauPBQox143UKJsku8+dD3kNBvr6YFycMHRrc2wbaEzK
 Hr/48vucbe4MMxfIdjM9Ts0v2Q8YjHTpk6t4MuR5ARrUpfGLFFqfvUaWG
 vJxS8zrcElbFvK0ZYb9fLXSB09EgliSxEMhvIfl1uvILbaKClFXQfro/3
 UYcVBdriBgLYC0GWzJ8SEObNWlPz8xidiP+MRe2g2yQX36fREvoXYwVhV
 F4BEuqs6w+8zKnNcjCP03P3bvptSZ01oUgf1LFT4C6JEBZMcZ6SPTlohl w==;
IronPort-SDR: Yj/ODm4K3wHO8aFjjPa/wjyBLi11fIVg2ce2o+TYXTVqdlZmDqCmgNL8OLpwKfq7bm8BkyjFD7
 J02ZT8JjfALB7ubC+3LttWr3UW9Q8ZRznOZoOJbU+f4MJHKeJ7NQEmbZxpV6oNRQJucSIaYePW
 7A6rOE177oquE8tSZhuBvriy048o9F9Y+qmHJWRqdY7u4jnuvTFuRLnvsuJOW1kZuE0JiJQrZ1
 cvdxNwp+8bwE7JoTFBt/+HsnQmsk+kGK+oLetVYDRQ3vbMoeKzfsnR8/jQIAzH/De/9X9iMT03
 qTg=
X-IronPort-AV: E=Sophos;i="5.73,526,1583164800"; d="scan'208";a="243285416"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 18 Jun 2020 22:33:01 +0800
IronPort-SDR: lnKwiMfxRuTcNYt1KkFe83k4pFXCcUIkcIwmgCglJHiaBoWBfSiMtrWVqD8Dgyy5AN6jgvUmAQ
 CuDxii2s0LNlCvrUaBavy95rdPgOLus0E=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jun 2020 07:22:02 -0700
IronPort-SDR: TSnT4PLHaTYn/RtOitRfQahJ7TE0OkO8lFGG/Zw/4A7GDquWTbqMuvnBrZKTkEuqyWVffTpGxx
 bI1oxQ6h0uuQ==
WDCIronportException: Internal
Received: from cnf006060.ad.shared (HELO localhost.hgst.com) ([10.86.58.135])
 by uls-op-cesaip02.wdc.com with ESMTP; 18 Jun 2020 07:32:48 -0700
From: Niklas Cassel <niklas.cassel@wdc.com>
To: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 2/2] nvmet: remove workarounds for gcc bug wrt unnamed fields
 in initializers
Date: Thu, 18 Jun 2020 16:32:41 +0200
Message-Id: <20200618143241.1056800-2-niklas.cassel@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200618143241.1056800-1-niklas.cassel@wdc.com>
References: <20200618143241.1056800-1-niklas.cassel@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200618_073250_761101_817A5D04 
X-CRM114-Status: GOOD (  14.18  )
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
If, for some reason, we want to allow builds with gcc < 4.6.0
even though the minimum gcc version is now 4.8.0,
there is another less intrusive workaround where you add an extra pair of
curly braces, see e.g. commit 6cc65be4f6f2 ("locking/qspinlock: Fix build
for anonymous union in older GCC compilers").

 drivers/nvme/target/rdma.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 6731e0349480..85c6ff0b0e44 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -1535,19 +1535,20 @@ static int nvmet_rdma_cm_accept(struct rdma_cm_id *cm_id,
 		struct nvmet_rdma_queue *queue,
 		struct rdma_conn_param *p)
 {
-	struct rdma_conn_param  param = { };
-	struct nvme_rdma_cm_rep priv = { };
+	struct rdma_conn_param  param = {
+		.rnr_retry_count = 7,
+		.flow_control = 1,
+		.initiator_depth = min_t(u8, p->initiator_depth,
+			queue->dev->device->attrs.max_qp_init_rd_atom),
+		.private_data = &priv,
+		.private_data_len = sizeof(priv),
+	};
+	struct nvme_rdma_cm_rep priv = {
+		.recfmt = cpu_to_le16(NVME_RDMA_CM_FMT_1_0),
+		.crqsize = cpu_to_le16(queue->recv_queue_size),
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

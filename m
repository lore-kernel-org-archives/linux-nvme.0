Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AD51C35FF8
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Mar 2025 10:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VVmZSI8gR2KB1NJDc5Aw8G2u07MMxx9eGUDLquoUPZ4=; b=J3pdN0k7yD3oAHTFV9OaBu7E+I
	1U90NVUc1IElQM+R0dh5XZfH15yOklpc0IKf9SkMEsZF/BKrnZ1C+L/oVNOlF/uYzLLAMq3NBW9oB
	uJn7xBMsfyxIRZ5Ds08HE+auY5nbtRH2jWdmMfRxt9FVFhTJPk+m0N1KsuuKU84iHdaU74BBN91T7
	TNn17IcEMWuZE4geZf16/+GAZi73XDNKQiCg0DVRKPqeAlI3mKtupQ7S+1jrhoJ80k4TuHdmV8e2V
	82zYUTpeOaqXZJbFr/uUQW7+HtSbFJ4Q80l6ztd04w1+V+ox1y90Y/wAZ2hk7PXMJYIcEJmTIQWc5
	7NdAOfGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tuUNO-00000005YYa-1HvC;
	Tue, 18 Mar 2025 10:40:50 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tuUNJ-00000005YR5-43GT
	for linux-nvme@lists.infradead.org;
	Tue, 18 Mar 2025 10:40:47 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 7016F5C5895;
	Tue, 18 Mar 2025 10:38:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B16C6C4CEDD;
	Tue, 18 Mar 2025 10:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742294445;
	bh=xhWX+5IOa0crE05apLEVrNBm4agJvraayK65++Qyx48=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=O4xeDqZZUSZGXxLJZa4WtR1HktQKziBrn+md4R62yJDqqFxcCzmUcafpI2spW60tK
	 lEYNm+Bd+Oi20KA4FHnbZ2aDyP5jW5j8qL99IqECooG0q/sBJPsMzog/DOTj7A1uA7
	 xW2/ece/dVgY8F4eLaqiphdAie1H9nPBs71fqa6yMMxTylVgGl4wRnH/TvD0RpBrdc
	 cqjGQACLxK+wXI624tnT+rSXp1LBz0b1HN53L4T0cylGPnxf81l3cq7mKVg5oXVHeg
	 Dg5VAQHkPqeFzCr7N9skzvgfPHIrAWFvvLDDNLHPNw2QYkGiWee9wRPEJ4zumSTGjE
	 J1rL2VNJgdD0A==
From: Daniel Wagner <wagi@kernel.org>
Date: Tue, 18 Mar 2025 11:40:11 +0100
Subject: [PATCH v3 17/18] nvmet-fc: put ref when assoc->del_work is already
 scheduled
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-nvmet-fcloop-v3-17-05fec0fc02f6@kernel.org>
References: <20250318-nvmet-fcloop-v3-0-05fec0fc02f6@kernel.org>
In-Reply-To: <20250318-nvmet-fcloop-v3-0-05fec0fc02f6@kernel.org>
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250318_034046_078634_6A76DC79 
X-CRM114-Status: GOOD (  10.85  )
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

Do not leak the tgtport reference when the work is already scheduled.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/target/fc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 649afce908bbade0a843efc4b8b76105c164b035..e027986e35098acbe5f97dcbcc845b9d46b88923 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1087,7 +1087,8 @@ static void
 nvmet_fc_schedule_delete_assoc(struct nvmet_fc_tgt_assoc *assoc)
 {
 	nvmet_fc_tgtport_get(assoc->tgtport);
-	queue_work(nvmet_wq, &assoc->del_work);
+	if (!queue_work(nvmet_wq, &assoc->del_work))
+		nvmet_fc_tgtport_put(assoc->tgtport);
 }
 
 static bool

-- 
2.48.1



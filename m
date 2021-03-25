Return-Path: <SRS0=zNYX=IX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 358E4C433ED
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Mar 2021 11:27:09 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C163261A6D
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Mar 2021 11:27:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C163261A6D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=81fImn1rW6uQyuMaQp5itGyxbi+QyZlb+8ek6VcHHgQ=; b=hY91+BiuLq1dF6Z5oe1DgeF/D
	QpoYAvFGqNgxVWVfd47E10GU0muoS3Dgay7KL3G4o5zbFgoRPZFyy7mr1om6Ho6nLI9KpciqcddOJ
	yvajTi4eNXvGruLS3fFrSUWARxdW5XLzeA/f0dSRA03e86IJrvp51wRdvoPqlMwvkjCxrBG77WlBD
	KWrJLaLO1IMg9MIG7zVKv3DBtDFIBFGN5nMjBpWpvhCvGptAWSWBRUPdhCoHGhMn+a4MjLx4JwZcW
	GaURa4TsQFRs+wa66wo3UEL4ZeTQwyDX4GfS6CZGAD4OcmU08myJdm32keQa6xVeYET9EDBH4e0jb
	INqAvbXZQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lPO8a-001ImU-6X; Thu, 25 Mar 2021 11:26:52 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lPO8S-001Il4-1U
 for linux-nvme@lists.infradead.org; Thu, 25 Mar 2021 11:26:48 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id CBC6D61A33;
 Thu, 25 Mar 2021 11:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1616671602;
 bh=/9ujew30/khoYdl8uTOuMTpa+/+vYu2kig65Xjphl34=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=n3wzwtS4Nx4w5zUzbA29o51FjfKVu2GDZY6mPoJe3BqLQ4jKaXCy30uU5vgKxEAWB
 /Z6AhbuHhEMGT4ZHmBkvsd4Ql1y+/cp0iLccb7bK0fYxk+5zwFBDS4+etY8DF3G7tb
 caHrACJJXyI8YKS2A5z8/yoH+thIsULwxzsHiksewXci81X/UrD+y2wXdEIucnMyTZ
 4jm2wn5fkfP7C2pcKjZO5u+XXXL8U3qYIYYhSHqctVpvJayS6W8k18RLSEYyV9kyGE
 M2jIOAqIl6+URm5tlTEmZ3BtSiiO0nCwm+Tuo8Vto26hpFvULk7/jPwctAcf9PQKwQ
 +qDB3wEHoNQlw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Elad Grupi <elad.grupi@dell.com>, Sagi Grimberg <sagi@grimberg.me>,
 Christoph Hellwig <hch@lst.de>, Sasha Levin <sashal@kernel.org>,
 linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.10 33/39] nvmet-tcp: fix kmap leak when data digest
 in use
Date: Thu, 25 Mar 2021 07:25:52 -0400
Message-Id: <20210325112558.1927423-33-sashal@kernel.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210325112558.1927423-1-sashal@kernel.org>
References: <20210325112558.1927423-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210325_112645_230679_B2D291D7 
X-CRM114-Status: GOOD (  11.91  )
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

From: Elad Grupi <elad.grupi@dell.com>

[ Upstream commit bac04454ef9fada009f0572576837548b190bf94 ]

When data digest is enabled we should unmap pdu iovec before handling
the data digest pdu.

Signed-off-by: Elad Grupi <elad.grupi@dell.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/tcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 8b0485ada315..d658c6e8263a 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1098,11 +1098,11 @@ static int nvmet_tcp_try_recv_data(struct nvmet_tcp_queue *queue)
 		cmd->rbytes_done += ret;
 	}
 
+	nvmet_tcp_unmap_pdu_iovec(cmd);
 	if (queue->data_digest) {
 		nvmet_tcp_prep_recv_ddgst(cmd);
 		return 0;
 	}
-	nvmet_tcp_unmap_pdu_iovec(cmd);
 
 	if (!(cmd->flags & NVMET_TCP_F_INIT_FAILED) &&
 	    cmd->rbytes_done == cmd->req.transfer_len) {
-- 
2.30.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C88A9C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Nov 2021 14:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0kQKOE3A6om3j/fAXurxkFIcIEh120mLScao4tVXWVo=; b=eMbfj6wTJlsa3Q4Yo+DXr+EryZ
	/299APg9SsEzdpJ81NAWvXLUS+XkBEEoLV/IRzk0Y0JyJFEQgM/WitYt0BTbV2VPfKN2Uemx8LUyp
	q362Frx3ol79PNap46ZAaFjJToYVSwfvCJ3muPMC/N0W3MUDHtNNVIqXgQABQySfNViuRiksNZVu2
	rIkiT9rIx4JIFpaH0xa5iCVJtS4JCX/iSs/MPHl0D1cIQpG1XpswFR2ThSeyu6Oyrydj5Raunm+Et
	JnWiJpqp35MDfwogBQLJyBZCL+BXC/DEP3tZZmT+yZ5ex54d/GgZVTL7wC+xU5GhWrepUPgTTcR2x
	xVI5UL5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ms4RM-005gFB-HI; Tue, 30 Nov 2021 14:49:04 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ms4RF-005gAs-Gn
 for linux-nvme@lists.infradead.org; Tue, 30 Nov 2021 14:49:00 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id B8E2BCE1A3B;
 Tue, 30 Nov 2021 14:48:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 029A5C53FD3;
 Tue, 30 Nov 2021 14:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1638283733;
 bh=A+dUwODXJX9yZUhCZEJM+KQsIhUhtwPPnqKJN2KlFCE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=jHCf40IR8a101NCN/c4Z2yh/mqSxEqj2uaJHKhybqe9QBd/E7JcDtQxvnf+u7w/ZZ
 y6HD6gAWB5hd8EK2/5eOeONKBbN9yfhdHqBGCqhSjtL+MnC55IXQu5JfowvQPHTqvu
 O+T/ocQatvP2IfmPS4cuLF1wkz81sTgbzuZZ2oi3ipU2S1Ott1zXNCW/yVENY2PjQc
 i6EWy6aV7/3ZQI2VAbWX/o+qkah/igVQXKOlxCqDy7XJaGYE6wvWsmBll8HhLpCfxo
 rwbk8rT67rJIoBVq64FoExOf4gmGQbho/DVaOJXBKvpPDunGfCdtGqeIrJyW0v72Tx
 BbgNqiAHvKLhw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Maurizio Lombardi <mlombard@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, John Meneghini <jmeneghi@redhat.com>,
 Christoph Hellwig <hch@lst.de>, Sasha Levin <sashal@kernel.org>,
 kch@nvidia.com, linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.15 40/68] nvmet-tcp: fix a race condition between
 release_queue and io_work
Date: Tue, 30 Nov 2021 09:46:36 -0500
Message-Id: <20211130144707.944580-40-sashal@kernel.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211130144707.944580-1-sashal@kernel.org>
References: <20211130144707.944580-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211130_064857_796199_C3E74DF4 
X-CRM114-Status: GOOD (  13.94  )
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

From: Maurizio Lombardi <mlombard@redhat.com>

[ Upstream commit a208fc56721775987c1b86e20d86d7e0d017c0b2 ]

If the initiator executes a reset controller operation while
performing I/O, the target kernel will crash because of a race condition
between release_queue and io_work;
nvmet_tcp_uninit_data_in_cmds() may be executed while io_work
is running, calling flush_work() was not sufficient to
prevent this because io_work could requeue itself.

Fix this bug by using cancel_work_sync() to prevent io_work
from requeuing itself and set rcv_state to NVMET_TCP_RECV_ERR to
make sure we don't receive any more data from the socket.

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: John Meneghini <jmeneghi@redhat.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/tcp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 84c387e4bf431..18f36256095f6 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1437,7 +1437,9 @@ static void nvmet_tcp_release_queue_work(struct work_struct *w)
 	mutex_unlock(&nvmet_tcp_queue_mutex);
 
 	nvmet_tcp_restore_socket_callbacks(queue);
-	flush_work(&queue->io_work);
+	cancel_work_sync(&queue->io_work);
+	/* stop accepting incoming data */
+	queue->rcv_state = NVMET_TCP_RECV_ERR;
 
 	nvmet_tcp_uninit_data_in_cmds(queue);
 	nvmet_sq_destroy(&queue->nvme_sq);
-- 
2.33.0



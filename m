Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ACB9C4167D
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Nov 2023 14:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gV9ixTOjc/m0f+kFAdbDj6CUZ8HwrAQGFzmc6CaAGoE=; b=JycbGlkkJXNViegDQim5NbHfiH
	dG3MlCxuhh4kugCrud4xvbrfqRgqEHcM/SN7gzJzvZwKxTgIWApaNIdrMPo4ktpFF1cVjH2e/iRUb
	CL6O1caci4QVqlWtKo+Vcwdyd2/Zo1bIbHZsbKGcgQgd0DvIqAewcQ9wMgajdf9Mlo6uML2bmBs2u
	PBasdPxlj8qdTnkAcyZFuJMU5oCnHCukfhrouljfQJ6zUf36du9XVyKp4ITxJTbWzi41TA6EoGM3v
	yRvudy1mk+tYyOMk2/MD2tVlUw5Ofi0DxD2sDK26/39JOizeYyTvCsAoJ17DSULyVtSSAl5qjZT2a
	3y2Q5Y1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qyYXa-009cpx-0W;
	Thu, 02 Nov 2023 14:19:22 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qyYXS-009cnw-0F
	for linux-nvme@lists.infradead.org;
	Thu, 02 Nov 2023 14:19:21 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id E73C31F8D4;
	Thu,  2 Nov 2023 14:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1698934746; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gV9ixTOjc/m0f+kFAdbDj6CUZ8HwrAQGFzmc6CaAGoE=;
	b=h64NpYa2B9sHKb2F+yXHYQs/KlMbw7EEi4h/R47urGWCkpp+dl9cWtzwXhHgESb9bwUHYk
	IB1IYs5fZ4pPHQ54YuqTh8KJG6UxVMzmP5dB3hwB2lbBWidOgiW5+WVRQ1aNzaifZSnpOn
	GjH2rNWQh1fjmjs8oLst0KZjiT99WLs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1698934746;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gV9ixTOjc/m0f+kFAdbDj6CUZ8HwrAQGFzmc6CaAGoE=;
	b=u9JFZ9K6Al9i9HRMLNOHO+Xe6XoDvNhm0JseqiGQ/ldM60ks2Gnsaet7sh2kxPEpbruc9X
	yXX08wXtSTI+mSCQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id 9FB332D4B4;
	Thu,  2 Nov 2023 14:19:06 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id D237951ECABF; Thu,  2 Nov 2023 15:19:06 +0100 (CET)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH 2/2] nvmet-tcp: avoid circular locking dependency on install_queue()
Date: Thu,  2 Nov 2023 15:19:03 +0100
Message-Id: <20231102141903.66515-3-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231102141903.66515-1-hare@suse.de>
References: <20231102141903.66515-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231102_071914_281371_698D1038 
X-CRM114-Status: GOOD (  13.08  )
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

nvmet_tcp_install_queue() is driven from the ->io_work workqueue
function, but will call flush_workqueue() which might trigger
->release_work() which in itself calls flush_work on ->io_work.

To avoid that check for pending queue in disconnecting status,
and return 'controller busy' until all disconnects are completed.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 drivers/nvme/target/tcp.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index b3c1cc6690f6..850e40eb70a0 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -2121,8 +2121,17 @@ static u16 nvmet_tcp_install_queue(struct nvmet_sq *sq)
 		container_of(sq, struct nvmet_tcp_queue, nvme_sq);
 
 	if (sq->qid == 0) {
-		/* Let inflight controller teardown complete */
-		flush_workqueue(nvmet_wq);
+		struct nvmet_tcp_queue *q;
+
+		mutex_lock(&nvmet_tcp_queue_mutex);
+		list_for_each_entry(q, &nvmet_tcp_queue_list, queue_list) {
+			if (q->state == NVMET_TCP_Q_DISCONNECTING) {
+				/* Retry for pending controller teardown */
+				mutex_unlock(&nvmet_tcp_queue_mutex);
+				return NVME_SC_CONNECT_CTRL_BUSY;
+			}
+		}
+		mutex_unlock(&nvmet_tcp_queue_mutex);
 	}
 
 	queue->nr_cmds = sq->size * 2;
-- 
2.35.3



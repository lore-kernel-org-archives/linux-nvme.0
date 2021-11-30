Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4EFFC433FE
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Nov 2021 15:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bSVY/pP/mwFR89eZml6Je5pCduaKSlkRV4sNxPHa6JM=; b=fafUun6x5O4f5q9tLf3aJ5botB
	efmGvXYgPB0AfP6/eJ+BXJL7q2ypk3MF2h4Ygi9ayzDOqhvEhvn39COFVy8WddTfufLBfK7pSCgvG
	rROLHWppW3vnYPYOojo5/hOoPw2pONsYPnDS1rM6Vmev9+uz9v8iCivwkgY7kHAwdY2WzK9lAcCNZ
	Twe7evL8nE7kyp1hjjFj3zoqf2Q6hG8W2Rx5wFSoNVyZIy5bOUlSih2VQw29hWs8udyjvWdxpar4B
	hCsV7K+W11o/nmwqlGxG2bJo10bvXwI37gfzsJDUBiXUlaJ5ZMxQIT61EgBLuJKseJZ1BDbMsmJMa
	/qREmgQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ms4hs-005myI-8A; Tue, 30 Nov 2021 15:06:08 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ms4Tm-005hXM-5e
 for linux-nvme@lists.infradead.org; Tue, 30 Nov 2021 14:51:36 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id AE3DFB81A53;
 Tue, 30 Nov 2021 14:51:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BE81C58327;
 Tue, 30 Nov 2021 14:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1638283890;
 bh=pYSqKmHSJFO+ETC9QgsF3/poW7ilfYOo08geY76RAG4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=j0Ubi9Zd0nfB3xitNa/+zs9IvLMDxzfheW6U/MYCy66tjKTqOhGBidip7rlIvjwzZ
 /hMog1iBYYfDP4GwXZo4oxWet2uwkW1+Z1hvUCxMjPl0LrtSe8DkHz/fHC2JUtXLrg
 USCu5Io/WsjC8HBy/CUXE1lFqE6eAJx/Mbc9csNS4qh/QxkEq4bI+8JwzR9ZlCspnU
 kLKt432mYqKpnLQxtrccR73ZDd6R9htWUIkwlUiDEL4bva6SxbO4Q8DTQfGvogF8jx
 3dA1ftB5jXK46LD7wzu+w5g2A0wD9nrdgeK0x4invhCyLn6L5eJfnfwW8M9O/O0ScQ
 AsXB1ZjP9bzmg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Maurizio Lombardi <mlombard@redhat.com>, Sagi Grimberg <sagi@grimberg.me>,
 John Meneghini <jmeneghi@redhat.com>, Christoph Hellwig <hch@lst.de>,
 Sasha Levin <sashal@kernel.org>, kbusch@kernel.org, axboe@fb.com,
 linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.10 31/43] nvme-tcp: fix memory leak when freeing a
 queue
Date: Tue, 30 Nov 2021 09:50:08 -0500
Message-Id: <20211130145022.945517-31-sashal@kernel.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211130145022.945517-1-sashal@kernel.org>
References: <20211130145022.945517-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211130_065134_405401_695DBBB4 
X-CRM114-Status: GOOD (  12.89  )
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

[ Upstream commit a5053c92b3db71c3f7f9f13934ca620632828d06 ]

Release the page frag cache when tearing down the io queues

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: John Meneghini <jmeneghi@redhat.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/tcp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index c8efa98192a4f..aaad985175d60 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1212,6 +1212,7 @@ static int nvme_tcp_alloc_async_req(struct nvme_tcp_ctrl *ctrl)
 
 static void nvme_tcp_free_queue(struct nvme_ctrl *nctrl, int qid)
 {
+	struct page *page;
 	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
 	struct nvme_tcp_queue *queue = &ctrl->queues[qid];
 
@@ -1221,6 +1222,11 @@ static void nvme_tcp_free_queue(struct nvme_ctrl *nctrl, int qid)
 	if (queue->hdr_digest || queue->data_digest)
 		nvme_tcp_free_crypto(queue);
 
+	if (queue->pf_cache.va) {
+		page = virt_to_head_page(queue->pf_cache.va);
+		__page_frag_cache_drain(page, queue->pf_cache.pagecnt_bias);
+		queue->pf_cache.va = NULL;
+	}
 	sock_release(queue->sock);
 	kfree(queue->pdu);
 	mutex_destroy(&queue->queue_lock);
-- 
2.33.0



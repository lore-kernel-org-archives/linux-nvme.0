Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D83CEC433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Nov 2021 14:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wjfE3q1Qwx+bzktKBrVrmDKb4VXgoctwF7RxwRYqkeY=; b=JYYgzibXny6NGL7lmRecQeG6iq
	Ng1/N16H8OQv1s8DmS85adgYbOSD/VcL31JhSMaH6CnAz0TzMX2CvSePWweCh38zT21sarTcNEdWH
	W9hDxRjE+TQTmvilFOtDluTcCU4GiwIhemLXaUT/TlvCuqvmbbummYp4KxaZtQf02RU1Fc0lneTWa
	hh5d17IOo0maj2sCxHcwSN0zfcIhtLIUcuPKG5Vh2u5GknRUoi+6LNEgpcNDXCJVhGHUyw8n1OLvx
	8ZMLp2gsSKMcpQhopqDvgRnsN1b+TGrc1ZqC9LF6K3FcNMo0dMJzNYR1Ldq6kAWi3prXVsHn6SKMY
	jmrtbk0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ms4Tw-005hbg-Gk; Tue, 30 Nov 2021 14:51:44 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ms4RK-005gE3-CU
 for linux-nvme@lists.infradead.org; Tue, 30 Nov 2021 14:49:05 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 17C87B81A1A;
 Tue, 30 Nov 2021 14:49:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE51BC53FD0;
 Tue, 30 Nov 2021 14:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1638283739;
 bh=OzFtNvqM7ulxBRhMNN5S2bm1o0/gjzkmnQfVJZNx4Fg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=uev7Bx9GdVa1m0NhONp/6DMH21oS5ws1JTo5a79LlF0ZtFJ2ezK/pI54xKIm3wW/P
 SDvAzNF3mmuKm8q4y7aozNiFzxKtDhfZUn58lsjfs+cEwEYTN3PqS9fFvDfOLXl0KK
 3oaKLbEDc0OS/uR3WpKvWBnrb/oMfye+fbPcHH9UIK56AwfJiG+hWybuT92waVusMU
 aM9tedKRCDfzAlyFWtedloQo6PkHRwIVHR+YPG6iodtLcz/7ePgM40vrh0HB6bZRFf
 YrkRgZEX1i6cIyFAM+JN1lnGwNovR2Rx0iVQzggitZi6v0BcY8RFOuzTbtTO9uFrPY
 0CmkHFCBuvxIA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Maurizio Lombardi <mlombard@redhat.com>, Sagi Grimberg <sagi@grimberg.me>,
 John Meneghini <jmeneghi@redhat.com>, Christoph Hellwig <hch@lst.de>,
 Sasha Levin <sashal@kernel.org>, kbusch@kernel.org, axboe@fb.com,
 linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.15 44/68] nvme-tcp: fix memory leak when freeing a
 queue
Date: Tue, 30 Nov 2021 09:46:40 -0500
Message-Id: <20211130144707.944580-44-sashal@kernel.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211130144707.944580-1-sashal@kernel.org>
References: <20211130144707.944580-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211130_064902_625145_9EA6086C 
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
index da733749192c6..f7fdf78ec34db 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1225,6 +1225,7 @@ static int nvme_tcp_alloc_async_req(struct nvme_tcp_ctrl *ctrl)
 
 static void nvme_tcp_free_queue(struct nvme_ctrl *nctrl, int qid)
 {
+	struct page *page;
 	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
 	struct nvme_tcp_queue *queue = &ctrl->queues[qid];
 
@@ -1234,6 +1235,11 @@ static void nvme_tcp_free_queue(struct nvme_ctrl *nctrl, int qid)
 	if (queue->hdr_digest || queue->data_digest)
 		nvme_tcp_free_crypto(queue);
 
+	if (queue->pf_cache.va) {
+		page = virt_to_head_page(queue->pf_cache.va);
+		__page_frag_cache_drain(page, queue->pf_cache.pagecnt_bias);
+		queue->pf_cache.va = NULL;
+	}
 	sock_release(queue->sock);
 	kfree(queue->pdu);
 	mutex_destroy(&queue->send_mutex);
-- 
2.33.0



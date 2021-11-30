Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71A89C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Nov 2021 15:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8fJLa3vyGs9GZFQCyp5K9TXE4svZbw6QiX6ZOt+Yw8g=; b=CYD7tUVdUG3iNatZ01X5zs2oAo
	ZhVmnz1CT92v24zxwbXxdew4FWFCF5t1nMqo9lFTVDgqftHrEtkKxK490XLQHG0904WoJvWb5CqE1
	ujm9dBai0IfZrUnffDGsSwAtaFNh4UCvHLcarEG3LYF5IgdNQij3wY2FDoP4nO6wBOKTlV6Ocvfmc
	K3FA0UVL2Br1UnFDvdvoy1Vz2QGRHJ61rLyJEB+re1vCSCy3JQEsmYYNXau04PMxTAuuuq9W8WRXw
	tE4UpZNmgokLhwgtTcOtI9yzsxe72NHnhyVhJ0/7cxEEmTcF6wtFO8bJxo4YZFO4Sl4qtV3mCmeBa
	sEJzgC+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ms4sS-005q8X-Qb; Tue, 30 Nov 2021 15:17:04 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ms4Ul-005hwt-3k
 for linux-nvme@lists.infradead.org; Tue, 30 Nov 2021 14:52:36 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id C5C3EB81A56;
 Tue, 30 Nov 2021 14:52:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92348C8D181;
 Tue, 30 Nov 2021 14:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1638283952;
 bh=VmyoxZVaXTv/mGJlJoRgaI+O62uylQFHQ0dFjn0JQEM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=aPExj2YOt0BooAQBhOOR737xox8oGRVAUon/UGmjp7J/3gmtqwnHrAOqFB8wvJYZx
 YloR5Leid3mk7GPprLgQhEQzRGUsh4Fh7OtGIrGM9PG6b3018AwV+tCKRDelsVC3/N
 gKGYSSHW+AAxw3DWR5V4QLo721X7rAb5aXzRQxtT7ohb3VRWVHgWGsm+2SPzkc94wJ
 f0wT6FuBq7/ioL8a19a29k8pdqpCEA5fuH1eB8jq8ealhvwYkiqGLgHX8YsRr7MJ3m
 gdDbPJfKCp8ONQ2esnHJx49I02oEPUoyiOxccuilHPdnwU8pG8VcQeMcnb/SBH31q7
 H49AUCuOSePlg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Maurizio Lombardi <mlombard@redhat.com>, Sagi Grimberg <sagi@grimberg.me>,
 John Meneghini <jmeneghi@redhat.com>, Christoph Hellwig <hch@lst.de>,
 Sasha Levin <sashal@kernel.org>, kbusch@kernel.org, axboe@fb.com,
 linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.4 19/25] nvme-tcp: fix memory leak when freeing a
 queue
Date: Tue, 30 Nov 2021 09:51:49 -0500
Message-Id: <20211130145156.946083-19-sashal@kernel.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211130145156.946083-1-sashal@kernel.org>
References: <20211130145156.946083-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211130_065235_336800_3B834B16 
X-CRM114-Status: GOOD (  13.05  )
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
index ff0d06e8ebb53..a1c870e686549 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1134,6 +1134,7 @@ static int nvme_tcp_alloc_async_req(struct nvme_tcp_ctrl *ctrl)
 
 static void nvme_tcp_free_queue(struct nvme_ctrl *nctrl, int qid)
 {
+	struct page *page;
 	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
 	struct nvme_tcp_queue *queue = &ctrl->queues[qid];
 
@@ -1143,6 +1144,11 @@ static void nvme_tcp_free_queue(struct nvme_ctrl *nctrl, int qid)
 	if (queue->hdr_digest || queue->data_digest)
 		nvme_tcp_free_crypto(queue);
 
+	if (queue->pf_cache.va) {
+		page = virt_to_head_page(queue->pf_cache.va);
+		__page_frag_cache_drain(page, queue->pf_cache.pagecnt_bias);
+		queue->pf_cache.va = NULL;
+	}
 	sock_release(queue->sock);
 	kfree(queue->pdu);
 }
-- 
2.33.0



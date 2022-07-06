Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28A72C433EF
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Jul 2022 15:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=o37AfHDZ1bHxrNAbQ4Gz6hRQAsNfn5S+Kzyvo3JmOLE=; b=V9GY/SAEVii4wqAxTKY1Se/5+y
	sqTE0f7qo8OsC+vxZkVid4kOzwBwVamt5Cz8fq9G8xBA5JaOkrBiIk9UkTXVy52R9lxcU2HzrlUNk
	uwixszeR6aDGVNW9mpgShARauMG+p0dPIfC1kdCunTY00H69p261tiJ6nPDMYQuM0KtZRHdX4zbd0
	IOZ9QwatYCDp1jfOeOK0eKgh+aGQJTLblOw4jpJmBPQLAvJzr+Vh5elmCceIODQQJOPmMOwk2JCht
	3h/IKAxoXjfuJRKJXJDg5JQeWWZ49n5NTny6MBq4z4jzn+b1Oqdm7NNrHow0SenhluSrKjCa0e8bf
	gClVV2cg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o970M-00B2TO-1A; Wed, 06 Jul 2022 15:31:54 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o970J-00B2RK-Bv
	for linux-nvme@lists.infradead.org; Wed, 06 Jul 2022 15:31:52 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id B8B7B61FEA;
	Wed,  6 Jul 2022 15:31:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7CFBC341CA;
	Wed,  6 Jul 2022 15:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1657121508;
	bh=0tB/LX5tbGmxD7/pJ3RV12uRuMbISjx0rX5KmfklPqQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nTFCFTf25/OMZscd5W9ynSTPlL/TfGlMOuJWxaWzCwXPsbGMDGr+M5oHvgOz2lkfh
	 pNcNCygx5f3cAwzaY1Aj178W05v5IuuUpQHkOBCUOmaCpwS6Taq6rKET+szaoz/dke
	 mI6hlT13fZAuK333wAXQccxYT/U7APhS3ZQIspi/rT/8FFLGicX7pLc/c59HQig5mF
	 hhrbgV19nF8MVhxcRjzSJUlKC+H8G9r+KJlycZN7B6ZmcAAJxjvC74V3xPcTfeC/n2
	 GxQYEU77iBnLlGx33ebt5ZPYihK3aZjS/3ek1oiFpYPSF2q0qmAXy+YEAozWi9iO6W
	 ybAzmV9wHKQRg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Daniel Wagner <dwagner@suse.de>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	kbusch@kernel.org,
	axboe@fb.com,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.18 20/22] nvme-tcp: always fail a request when sending it failed
Date: Wed,  6 Jul 2022 11:30:38 -0400
Message-Id: <20220706153041.1597639-20-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220706153041.1597639-1-sashal@kernel.org>
References: <20220706153041.1597639-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220706_083151_503372_16C6DB0F 
X-CRM114-Status: GOOD (  14.71  )
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

From: Sagi Grimberg <sagi@grimberg.me>

[ Upstream commit 41d07df7de841bfbc32725ce21d933ad358f2844 ]

queue stoppage and inflight requests cancellation is fully fenced from
io_work and thus failing a request from this context. Hence we don't
need to try to guess from the socket retcode if this failure is because
the queue is about to be torn down or not.

We are perfectly safe to just fail it, the request will not be cancelled
later on.

This solves possible very long shutdown delays when the users issues a
'nvme disconnect-all'

Reported-by: Daniel Wagner <dwagner@suse.de>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/tcp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index ad3a2bf2f1e9..e44d0570e694 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1180,8 +1180,7 @@ static int nvme_tcp_try_send(struct nvme_tcp_queue *queue)
 	} else if (ret < 0) {
 		dev_err(queue->ctrl->ctrl.device,
 			"failed to send request %d\n", ret);
-		if (ret != -EPIPE && ret != -ECONNRESET)
-			nvme_tcp_fail_request(queue->request);
+		nvme_tcp_fail_request(queue->request);
 		nvme_tcp_done_send_req(queue);
 	}
 	return ret;
-- 
2.35.1



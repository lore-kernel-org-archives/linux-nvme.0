Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4F8AC43334
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Jul 2022 15:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zULpeLcZVEVHtvMRS/tYoJZoA+hYBbQd6MFCuNBcCtg=; b=2NBl8glt3yDmZ7CuKpQCoN5daB
	OHjtDJic8+9g1BJ4TtbM6f283OjUOIOL4brnwUxKwevO151bvHzjTjl5omrwKvA5SVzBfTDrG+FWD
	4cK87Sj7UGOMalBufl2QX3dBNmkJ2IMFVTcCxITOhCy7q2Z8J2SKEt77d3/uznxUsgy52PbaXBzTm
	XPljAoYWTOV7csCc1t5Ofq8A2oq/Ee1y7Emv92751450C3harE/CvRmTnS5DUYrz6pBEm/hZYJVD3
	psIwb7O5z6xTtetkHNWE5AA8uXqZd29cWr+5DFiEgXSjmA1nQzsdw271sgmKZ95EMLccPiIucbNNg
	esZCW13Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o971N-00B2wH-42; Wed, 06 Jul 2022 15:32:57 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o971K-00B2uE-5Q
	for linux-nvme@lists.infradead.org; Wed, 06 Jul 2022 15:32:55 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 83F1861FF2;
	Wed,  6 Jul 2022 15:32:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1092DC3411C;
	Wed,  6 Jul 2022 15:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1657121572;
	bh=J/EuGZdmSepc7xcdlMXsN1KoG6+RToJa/DgYPisABGo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RjQLyyVG8l0m+lyrIEfTJQypKiE2LIPINtENd8KoU4EIsG/l7TNMGF1sujFaBUnj5
	 uwQl7zjzs1WH+GcFKWE57hYZEYsjy/xdcJjaM0ROQr87A3mJiQpX0VKtY3F8umIDjz
	 7UE4rZTueXDHmXqAY+q7NjWQjz/txtcBEhkiV5W516m/p/ATgaofgRa/K/44IOX/5r
	 v7EPBeQvkOelU6JPNQHugGIfaYP5XTb+iOgWkUtqmP8WZhB8FdZJVWRTTpXBFfPhzq
	 V6SQrthLWsmrv24ats4sI/nyBCBQh3WbWb0byKj4/Gz00DO7H0GXE75T3g/UyZZxwy
	 w6IMdBpv9FsKg==
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
Subject: [PATCH AUTOSEL 5.15 16/18] nvme-tcp: always fail a request when sending it failed
Date: Wed,  6 Jul 2022 11:31:51 -0400
Message-Id: <20220706153153.1598076-16-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220706153153.1598076-1-sashal@kernel.org>
References: <20220706153153.1598076-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220706_083254_292537_DEC4D433 
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
index 10882d3d554c..1821d38e620e 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1162,8 +1162,7 @@ static int nvme_tcp_try_send(struct nvme_tcp_queue *queue)
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



Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 369D3C0218A
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jan 2025 16:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HRvg+WTQhS2yW6hwuENk6TL2WX75aibuJMNU+ixC8/Y=; b=3u65kyhKSpEldXEJC4N8YYTjnV
	rQtHvDdVdpk14p26KaHIyq3DvOBtjmqCrx+1IIgwwj3aDp527G4pAarVzVdvUWsSwSO2GAm0BMuxF
	V8t6iItmpi05egHBcXNzgFpROriEr/5D5QLRI3I3G+mfBTun0O7Wvd7z4jHRvmOP+TsKTZl9NDGl0
	/Rit2Gd4Uwro4urmXlzP0R4xnejRfJmgVgtaO4zKwobbLDmEQAUDuHiRjMioaKic2vEc5XSNxf2AT
	EpER5NDBpIeLRSFVjE1J3IZYcz3XiCFzHNXKplWdEZGvS47McayDfwgMk6/56xTVMU0pKO9Sg4290
	dZIS3k9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tcofA-00000005MMR-0ioG;
	Tue, 28 Jan 2025 16:42:08 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tcoYQ-00000005LPn-1coD
	for linux-nvme@lists.infradead.org;
	Tue, 28 Jan 2025 16:35:11 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id C56605C60CB;
	Tue, 28 Jan 2025 16:34:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61B3AC4CEE2;
	Tue, 28 Jan 2025 16:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738082109;
	bh=EqUhYMGg7r3msMj02LTUSBZGnT7L9xWRdBClYC5kDdc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tChAcbq78A2IK8uEqwPSxE4qq5nLYDCicUs6lftYelHuJSJttZ3QmaOkxr4c0boem
	 a7G053D88tS6k46gqEaXmZzIH+mIn1Epwlo2KG5TClGaNnh+RVnwR6uEJxcZifIkSr
	 XgQAisD/9UMsTi674UP671qj/uwYiMEe/a4WY0RAqy9cMNZ1wIDAiZ7i4LaTzgGueX
	 0tTpSK2RS+IRaVAp3Eo5/No/D9H0Ndho2KVF1yDYFNIE59J5jjJ4m3kZwZHnAq7hy3
	 1ZptCHkBqdXQ4nsQSjwaCLGZXFZbldjFXDx6pAlK8fxoAFJIdqsT9MSNOCaB5lGd2X
	 dLxQlxdKaL8Wg==
From: Daniel Wagner <wagi@kernel.org>
Date: Tue, 28 Jan 2025 17:34:46 +0100
Subject: [PATCH 1/3] nvme-tcp: rate limit error message in send path
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250128-nvme-misc-fixes-v1-1-40c586581171@kernel.org>
References: <20250128-nvme-misc-fixes-v1-0-40c586581171@kernel.org>
In-Reply-To: <20250128-nvme-misc-fixes-v1-0-40c586581171@kernel.org>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Ming Lei <ming.lei@redhat.com>
Cc: James Smart <james.smart@broadcom.com>, Hannes Reinecke <hare@suse.de>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-block@vger.kernel.org, Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250128_083510_472336_C1FB9E9F 
X-CRM114-Status: GOOD (  13.52  )
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

If a lot of request are in the queue, this message is spamming the logs,
thus rate limit it.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/host/tcp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index dc5bbca58c6dcbce40cfa3de893592d768ebc939..1ed0bc10b2dffe534536b1073abc0302056aa51e 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1257,8 +1257,8 @@ static int nvme_tcp_try_send(struct nvme_tcp_queue *queue)
 	if (ret == -EAGAIN) {
 		ret = 0;
 	} else if (ret < 0) {
-		dev_err(queue->ctrl->ctrl.device,
-			"failed to send request %d\n", ret);
+		dev_err_ratelimited(queue->ctrl->ctrl.device,
+				    "failed to send request %d\n", ret);
 		nvme_tcp_fail_request(queue->request);
 		nvme_tcp_done_send_req(queue);
 	}

-- 
2.48.1



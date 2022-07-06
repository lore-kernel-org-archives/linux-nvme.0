Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7FDBC43334
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Jul 2022 15:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=n6DW6kHcTot1J9H5lgaIcnAT0qRccPRnojSCbYRSWtk=; b=26aZliE0edW6+CItoHoXim2THd
	smnViDaJgBQ9vEk1WYPwn6D+TUZ2VXPRntiqw4rie/UdM19a0MTIPmIgnt96lmMDh62ECWyz1QDD8
	PHdCEA0ASKBb+SbgVzTnZviJMkJFdS8trWaKCUjW+I0QqjJ3fZurrM0R6DHM1vztszYfvd7/bFOAH
	ovghqB1SxHTg5JBsYH39UqkEO0OnA2OmOFGaSxW0Otc1U8u/TF0khhgFkPB3w2K/oYEJDruE2Uuw0
	1pziCFeiWKgSTth3qwRqYw7k9Co7v8qw7rOJynF5xz1kFSdPyN9iuy3g5O1Q2yrpgv++azOGaSi5D
	9LFBHlwQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o971i-00B38X-79; Wed, 06 Jul 2022 15:33:18 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o971e-00B35l-S3
	for linux-nvme@lists.infradead.org; Wed, 06 Jul 2022 15:33:16 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 71CE7B81ADA;
	Wed,  6 Jul 2022 15:33:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 604F1C385A2;
	Wed,  6 Jul 2022 15:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1657121592;
	bh=/PBo5aChT/HITL0n8XQjCAQovVMDJHQ5AmS2ELAt8oo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U/nmFYmn/KTwgG+VLroPzHYn5HYrFKTZoR/qj/CaZoWXqDwYRwnDlEUodUsKPcijE
	 XtL/64AMa2vAxdL+wMrsVoAE2KwvNnp0Z4g0mWnvp/5D3SFok9PWJ9E9nG+Mf5CqDH
	 jDhYCAqrwYGfTLEn475mOhpqA6bkWRL0JfkhtR4lK0oXru1qmyFQEw6JcJctG/dcf1
	 hzRxNZ5xwR8ThcKVLqJ/ZeHqPb+Fo0XEf0tXcMlIHEQXMgV7BAr+XMy850M/LL2nfH
	 /ZaInOrukde1IAnn91r+YWQ9FhTKdjB6gq3kndHUdg1IVl5R0d6BGTbz1FDIv8utjn
	 qy3YBKjQ7iNOA==
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
Subject: [PATCH AUTOSEL 5.10 09/11] nvme-tcp: always fail a request when sending it failed
Date: Wed,  6 Jul 2022 11:32:54 -0400
Message-Id: <20220706153256.1598411-9-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220706153256.1598411-1-sashal@kernel.org>
References: <20220706153256.1598411-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220706_083315_101311_DB634F7F 
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
index 7e3932033707..d5e162f2c23a 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1149,8 +1149,7 @@ static int nvme_tcp_try_send(struct nvme_tcp_queue *queue)
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



Return-Path: <SRS0=yMBa=LB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E90BC4743F
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Jun 2021 16:14:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F184761420
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Jun 2021 16:14:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F184761420
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ARoJc/kDwOzz4mOZPLwsivv9YW4nbKLWUebY4lOu8kw=; b=lDKa71I0862Xgo
	gZLkbTl8ey/7LEd5WhIyq/AgHAwKkHjeYknjeaHmnf6HEyNXBUz2TBiixV0VkvDbw4yd5GVFXSKkj
	8UmaQuh/s20mTeSRLKLYHr8T69fiXVfSiJtZzaPN3QEB5KQymPHS5cmxbLBq1AMNnvCws/AImm2QZ
	mTUmzlz6J7H9u15iB97VTAB/Vzgl/o7ihczhNq2VhLhVaG2qtXoeXr0y0fZyksCyoWL304QuCpyVP
	x/ekunlWHU/9WqGVFOx5L0XmbiVoy3fIVOwciRsoEYtfHf2OHOGkdwLj8ssrvvVeK5qjC+EP7Q3zR
	fZrjLMsaB+/a0M48bZCQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lqHt7-004PAz-CZ; Mon, 07 Jun 2021 16:14:05 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lqHs4-004OHE-No
 for linux-nvme@lists.infradead.org; Mon, 07 Jun 2021 16:13:07 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id BB5BB613DB;
 Mon,  7 Jun 2021 16:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1623082380;
 bh=45JLVJqfviyJdxA8LcjD9n3/BRyIxOebcdNmA3Perj0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=XjUxzmN7NRUKuJ9OyghhIdOzKN1rlq5RBLqlSkqeqcS0AFfOPnv9soWduU6lKniqu
 B2fmU9q3xFTnZURuAZ1QdaMM605joFDsSwdRZPT22NcgdqEYmoJny9HbjNKxKBf3QH
 porDuwd4LOsuTO0tVNEGrp1Og4IYB3vLX66b+A67qM2Bod44ue7nu4A6Z8l4q/Unjg
 2PM3zuIsdksK9j/c9ddEV6dytYQn4reDliIptdDCdlPg3sgl6+TQnoaRP9F/L6FNQk
 ja5lIqwKqp1bqlirk/cj5DOvvn9PNQ7byMWCcUbse8X/YG0ge/7aXgiAsxR/sPgEig
 oLCHplNhuQWXw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hannes Reinecke <hare@suse.de>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 Christoph Hellwig <hch@lst.de>, Sasha Levin <sashal@kernel.org>,
 linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.12 36/49] nvme-loop: reset queue count to 1 in
 nvme_loop_destroy_io_queues()
Date: Mon,  7 Jun 2021 12:12:02 -0400
Message-Id: <20210607161215.3583176-36-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210607161215.3583176-1-sashal@kernel.org>
References: <20210607161215.3583176-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210607_091300_817608_0F723A44 
X-CRM114-Status: GOOD (  10.11  )
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

From: Hannes Reinecke <hare@suse.de>

[ Upstream commit a6c144f3d2e230f2b3ac5ed8c51e0f0391556197 ]

The queue count is increased in nvme_loop_init_io_queues(), so we
need to reset it to 1 at the end of nvme_loop_destroy_io_queues().
Otherwise the function is not re-entrant safe, and crash will happen
during concurrent reset and remove calls.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/loop.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index 14913a4588ec..4b2a6330feb5 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -297,6 +297,7 @@ static void nvme_loop_destroy_io_queues(struct nvme_loop_ctrl *ctrl)
 		clear_bit(NVME_LOOP_Q_LIVE, &ctrl->queues[i].flags);
 		nvmet_sq_destroy(&ctrl->queues[i].nvme_sq);
 	}
+	ctrl->ctrl.queue_count = 1;
 }
 
 static int nvme_loop_init_io_queues(struct nvme_loop_ctrl *ctrl)
-- 
2.30.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

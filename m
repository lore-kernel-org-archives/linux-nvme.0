Return-Path: <SRS0=yMBa=LB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E15DBC47082
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Jun 2021 16:21:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4DB860FE5
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Jun 2021 16:21:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4DB860FE5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mCDjlUNXNVaKWD2pRUlxtRgNn5kRZWvtpMBBLj++x38=; b=Js5JCrDQaOMQAF
	rK5RdsubCUQ3g+RZcvqkeVu2erohpwjQ7Ii1qgHPWOeB499n01AQlyUjrpqfecWLCmNrYSvVi/vZa
	K/QRvzGemwPGfdxbUa4PR/A8KzxF1NhUXZcmIa3Oto8Qj6AzdPPMqr9UH5Ve79aTJ4dAAXPX1FMMa
	J9wOfECJPHBoRs5V/BG2p4BdeUIgSLw1/NwAx1YMXgpDxWrTdgQaDZxL3lukGD+oodLAnab0bQd1b
	zYvO5AfzaHogq48xyzTeUU5LZduyiOcwu0u79boLKj1Zd9PVF8H0JMn2hWk1vZbzmg0vm6eGERD5S
	RGHx8L5UbYAV7NqfkJwA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lqI0R-004T6N-PW; Mon, 07 Jun 2021 16:21:39 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lqHtd-004PXE-KH
 for linux-nvme@lists.infradead.org; Mon, 07 Jun 2021 16:14:38 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7CC606162A;
 Mon,  7 Jun 2021 16:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1623082477;
 bh=ypz9PQ9qe0SVB/8adFFM25pP4e02WlCyeIliOP7utIo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ehDiBAsT6M7dx6e6QRxHvfWj3I6xsBWv3XeR4B0CazgulY5iwhhwAgDgqpLNE6KT6
 G63WYkpNEG5+hSFFoyUod/m+fzkgLfzClUd/CunyJczm7InvMAJt/4RqRg7sIrKLye
 usaDQwO1T5rY63Tr6UfGuwqe8mI8udsj85rsznbI4eO7/DlN6TZQbGO4l0vc4Ad4Gd
 ZxHN6nsEJA8geHGf7F2DxxPys+h0dX7L3LOumYjdSX9TUPpmoG5I5j4thMrmUS3Cuk
 LAr/wRCCt15H0PE2klo+Jm1/loWbz0OKP+tz2s19HV3VTzfqSQgiSOqq6nBzYugIGP
 HAx6Ru3Gs1nLQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hannes Reinecke <hare@suse.de>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 Christoph Hellwig <hch@lst.de>, Sasha Levin <sashal@kernel.org>,
 linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.4 21/29] nvme-loop: clear NVME_LOOP_Q_LIVE when
 nvme_loop_configure_admin_queue() fails
Date: Mon,  7 Jun 2021 12:14:02 -0400
Message-Id: <20210607161410.3584036-21-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210607161410.3584036-1-sashal@kernel.org>
References: <20210607161410.3584036-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210607_091437_720349_3B6E2E70 
X-CRM114-Status: UNSURE (   8.66  )
X-CRM114-Notice: Please train this message.
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

[ Upstream commit 1c5f8e882a05de5c011e8c3fbeceb0d1c590eb53 ]

When the call to nvme_enable_ctrl() in nvme_loop_configure_admin_queue()
fails the NVME_LOOP_Q_LIVE flag is not cleared.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/loop.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index b4f5503ae570..f752e9432676 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -395,6 +395,7 @@ static int nvme_loop_configure_admin_queue(struct nvme_loop_ctrl *ctrl)
 	return 0;
 
 out_cleanup_queue:
+	clear_bit(NVME_LOOP_Q_LIVE, &ctrl->queues[0].flags);
 	blk_cleanup_queue(ctrl->ctrl.admin_q);
 out_cleanup_fabrics_q:
 	blk_cleanup_queue(ctrl->ctrl.fabrics_q);
-- 
2.30.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3BEAC7EE29
	for <linux-nvme@archiver.kernel.org>; Thu, 25 May 2023 18:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=P1B3vOA2fTm8rrLDq1PIXwlei+QcvSmZKZ29gxkWQy8=; b=W7yzih+cCzQ2UIbL9L6pR0GDof
	Us+1VBKwkN6nTejt8shUzJjiGFQFmqjc7ZoavjRsOm9UIhKTmlOf4wcoWaXZb1yxizgW7TeELfxIJ
	oV2mLCmfRHpvy7TS5QMAE5Rp9bgOt7snRulqxjDnqqaTG2xYV2+659bWk0DvYPwtmHJt2euTYao/O
	DIkbfm6rjOzi2cvhHeYdPy71LDF2hq1jqP2JVFIKxWVRcC2yCTRgQJ5N+pHzd2m5ZH0GJZbJ4Rkvf
	6Hh8c1/YCTJORKJZnebyOqfoesTrlfBGWz3RhJ4cXmGHsrWgYFb/iWho6smdzGZPmhQwU9vPfE0fS
	yP7WFCWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q2FoO-00HQGp-3B;
	Thu, 25 May 2023 18:35:45 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q2FoK-00HQDh-0v
	for linux-nvme@lists.infradead.org;
	Thu, 25 May 2023 18:35:41 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id DF129648EF;
	Thu, 25 May 2023 18:35:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D17BEC4331D;
	Thu, 25 May 2023 18:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1685039739;
	bh=hALR7glcJ178nXk9fUj64vfY42R+x5At/pAp7tcrEQw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jy6+3sLMQSzlWZL729+wAJ5O/A2qtuSJaeJa2VFwRm/JHafOUBJRvm80nOQ4Gkbub
	 SVTFWsas7bIgG8XRl1FnKMxP19Fz7E9fytQ7PPGVXjzzW36pbvp9OderfR6msxc3fQ
	 NGd1dyBNcYqLMO3kJoIYFItFebUANoVl/fBbfKQp1iDcWA/8p0NDUDmtYvRiMqL/Kn
	 z08QlBWa4w1CKb3q8ckbjDMKqaZ22umS5Z/CgbIudOzea4D8l3m+Lavsx0ByOOaQ4l
	 tyJ2j6bqvjQ5Og6Tb8j5ukfLy/yKOcTR4qgylUKaXBkFv+TQtWlRk49dHikFpN8oGe
	 eJ471DYOSZdpg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.3 57/67] nvme-multipath: don't call blk_mark_disk_dead in nvme_mpath_remove_disk
Date: Thu, 25 May 2023 14:31:34 -0400
Message-Id: <20230525183144.1717540-57-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230525183144.1717540-1-sashal@kernel.org>
References: <20230525183144.1717540-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230525_113540_362564_AE2A8F88 
X-CRM114-Status: GOOD (  12.15  )
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

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit 1743e5f6000901a11f4e1cd741bfa9136f3ec9b1 ]

nvme_mpath_remove_disk is called after del_gendisk, at which point a
blk_mark_disk_dead call doesn't make any sense.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/multipath.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 9171452e2f6d4..2bc159a318ff0 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -884,7 +884,6 @@ void nvme_mpath_remove_disk(struct nvme_ns_head *head)
 {
 	if (!head->disk)
 		return;
-	blk_mark_disk_dead(head->disk);
 	/* make sure all pending bios are cleaned up */
 	kblockd_schedule_work(&head->requeue_work);
 	flush_work(&head->requeue_work);
-- 
2.39.2



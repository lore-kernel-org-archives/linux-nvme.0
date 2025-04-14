Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 078C4C369B2
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Apr 2025 13:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=T3YfnX9ZglfQpUe0TP6pnBi52ZI7dRsf+S19M8yRul4=; b=MhKGLNNxAXGYZdKm314f4Jcvq5
	e6lE/Y1WyI02sjBiPUQK+f6VfpoTuJPOsCoZai9uK2LBCkjMWs7nZiniVLHK2PhhzJ4PEmjHG5MSZ
	ERkNgvRls9FanUL98db68xlvFFp8fKMLzjvWJJFl3vg/m/hyrTgokfkS258/0nLR7gfwmjdAIWKXP
	buns+nrupiTuNkk9Mz1B6XIb34913U86HcTRcGB8ae+Qiv99Eh9QwoFeoGsXHxA97Mi4dOP9rsJvR
	EOf12hSFl4zYUiRUfBJH8mMPn+7/pfH+/Rk5L8rMy+VIl1mRb0UnbrjjcseSJRapsn2ZID1zzL9rl
	L3gotj1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4Jqr-000000027yL-2TT2;
	Mon, 14 Apr 2025 13:27:53 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4Jqp-000000027xk-4C1H
	for linux-nvme@lists.infradead.org;
	Mon, 14 Apr 2025 13:27:52 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id CAD37614BF;
	Mon, 14 Apr 2025 13:27:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F31FBC4CEE9;
	Mon, 14 Apr 2025 13:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744637271;
	bh=5h2lMXQWMzNDy6atMz06+3FskdOTLm+ZoYi30GgjGDU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BntZI/6+Tw56TxUAstC8U+iB+8gN/ezfS5Iu0+qbVfI1xvEQU1VlbscjzJ2EQV6cH
	 ohEViIUIPjUCqs0BwWVztb7KTwY+GQO336zdIDzk7XybkVl7PBzmCHUE2m11/KuanQ
	 pDkhSQZ/zF31GNdhIGKQXkPCdwG2pQ564C/rbUEfr79XxLdiGlWPTbtY4HbJShh59q
	 2WU9KV/62GQQcH/HhhdiV8zQNG8x5/NCZsxxRj2moQuM24MYNwrFT1DL1PU+NTyV0x
	 p/b2+QQaXpQy65k/OkTxR2X7s2JPIjrWXEbWoRo2xZFv56RQIU66WLiZ46SrnXcZ+y
	 sLxwhYRZpIsQQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hannes Reinecke <hare@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.13 10/34] nvme: requeue namespace scan on missed AENs
Date: Mon, 14 Apr 2025 09:27:04 -0400
Message-Id: <20250414132729.679254-10-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250414132729.679254-1-sashal@kernel.org>
References: <20250414132729.679254-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.11
Content-Transfer-Encoding: 8bit
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

From: Hannes Reinecke <hare@kernel.org>

[ Upstream commit 9546ad1a9bda7362492114f5866b95b0ac4a100e ]

Scanning for namespaces can take some time, so if the target is
reconfigured while the scan is running we may miss a Attached Namespace
Attribute Changed AEN.

Check if the NVME_AER_NOTICE_NS_CHANGED bit is set once the scan has
finished, and requeue scanning to pick up any missed change.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index e4034cec59237..1b386889242c3 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4282,6 +4282,10 @@ static void nvme_scan_work(struct work_struct *work)
 			nvme_scan_ns_sequential(ctrl);
 	}
 	mutex_unlock(&ctrl->scan_lock);
+
+	/* Requeue if we have missed AENs */
+	if (test_bit(NVME_AER_NOTICE_NS_CHANGED, &ctrl->events))
+		nvme_queue_scan(ctrl);
 }
 
 /*
-- 
2.39.5



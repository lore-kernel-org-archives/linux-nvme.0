Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AD62C36012
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Mar 2025 15:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=k6rfX5xoz/Krm/0Qiz4MzvyqTrd1KUiBnPwf01qXJgA=; b=0v8RLJfz9N6dKMvhkl0tzH7/kL
	hkDmGEiFbycztFxRVc5Z3C4cZ943+r1JyAW7D/ffc8fNMTizudFXQ3uoFnb6sN67l7dM1f+/Qi8mO
	nLqUfAk9Rxt9lXh3J0s80JH67aBCswPZlS1++jLcl/7KPgEq2/IAewmmKR+KQNdpXW7LxO8ctJBAB
	zCDs6z+KqyPTuDS+3Wob3zxLHTUyLo+e6vRw3HwZmCI26ZJ4C7+/q6n9EK78gRWN7mTf3tdNOFLdi
	8SUAI4HxanmBHN0Rp0A+MV8IobehQ2oLoHanyWsMHvqXn1fzlrlQcNE6uRFLYCy4hixxqkX3ONdY/
	Ad0oqs3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1txpTs-0000000BPO2-3oeV;
	Thu, 27 Mar 2025 15:49:20 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1txpTp-0000000BPKs-3HRe
	for linux-nvme@lists.infradead.org;
	Thu, 27 Mar 2025 15:49:18 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 2C0FF5C3ECE;
	Thu, 27 Mar 2025 15:47:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B6DFC4CEDD;
	Thu, 27 Mar 2025 15:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743090556;
	bh=JY2hqLwKFAWaqgIGwVbQ63KHiFU602HpIvQkyIqYJ2Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bDCJEhXv03kZZplLo9Q1JVhMzIyP2gwVPBkqU3evTP3cu7qGsHyPYRJq/ZC1ktZ5B
	 W0vAWt6Ce08aAueGDh8Pg2psZbWG8iRC9ALpg7vb/S+oKKPhrezVVOQO3IGIAGof06
	 puKTL+1sA1Q4KmKMbpujfMvHB9YwG8FmAzCl4Eiq7hmIZerttjvqzSath/alYc6xUv
	 qpVKxIpII41+UQSzXKRCikfPs0ZyY8iSNtwUnyAfm2LOKlJZOs2LhdHXowArH7VQg9
	 tXwy2J6xGdLUksT7qid/kI++PCyH96dgrRlYoGnADdv87Pt/Hv54p66U895rd1ubEp
	 86ZfTKGRO6fhQ==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>,
	Chris Leech <cleech@redhat.com>
Subject: [PATCH 3/5] nvme-tcp: fix I/O stalls on congested sockets
Date: Thu, 27 Mar 2025 16:48:52 +0100
Message-Id: <20250327154854.85521-4-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250327154854.85521-1-hare@kernel.org>
References: <20250327154854.85521-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250327_084917_863411_DEE6DE39 
X-CRM114-Status: GOOD (  13.33  )
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

When the socket is busy processing nvme_tcp_try_recv() might
return -EAGAIN, but this doesn't automatically imply that
the sending side is blocked, too.
So check if there are pending requests once nvme_tcp_try_recv()
returns -EAGAIN and continue with the sending loop to avoid
I/O stalls.

Acked-by: Chris Leech <cleech@redhat.com>
Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/host/tcp.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 1a319cb86453..87f1d7a4ea06 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1389,9 +1389,12 @@ static void nvme_tcp_io_work(struct work_struct *w)
 		result = nvme_tcp_try_recv(queue);
 		if (result > 0)
 			pending = true;
-		else if (unlikely(result < 0))
+		else if (unlikely(result < 0) && result != -EAGAIN)
 			return;
 
+		if (nvme_tcp_queue_has_pending(queue))
+			pending = true;
+
 		if (!pending || !queue->rd_enabled)
 			return;
 
-- 
2.35.3



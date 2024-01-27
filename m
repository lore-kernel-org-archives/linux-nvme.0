Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86140C47DDB
	for <linux-nvme@archiver.kernel.org>; Sat, 27 Jan 2024 09:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fj/BNvc6uaAMN1fcfWWgStQyQU6ltxhN5JBVtHMv31o=; b=fuRuVkwuBAITj7MIkqHm0LJCp7
	1pq7p3emvGx1GzoqBLEzmjT4QNNhhz9GqAkKuwn6X+QWPxS4X+l9pCsQFYByYfB7vk5OM9gPM/PPA
	rDUBqnT3fKJVEHOsXH6PXvhHOg+z7YJPUCh0d5HN1e/+sUwAYHLUmGglBzZaafbg/Ol4pC6ueJ0Ht
	yjgS20Q5bwjt2NLTTbOqTkhTbgGRch0ePCgDynpHhL7x6nnLq89ihQ9gixdSyjn4p+dEDSiF8k5Zg
	H07VEil989Pj0etfyBPWsiLke+kugnGMD3jR5cLcA4ZZfhtzb6E3OpMdjVIJj8OkJzpHb88D+yFz4
	6/zzAbUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTf2O-00000007Fx1-35Bf;
	Sat, 27 Jan 2024 09:31:44 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTf22-00000007Fc6-2sNb
	for linux-nvme@lists.infradead.org;
	Sat, 27 Jan 2024 09:31:25 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 28A2560C0B;
	Sat, 27 Jan 2024 09:31:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91F18C43399;
	Sat, 27 Jan 2024 09:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706347881;
	bh=orfWKYeJVGJLVzcqeA3PEIBtAbJyMt6qAr9keAsVWbg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ctN8WgvrNZMtqtNEjqoszucvsmP2s8vt9s7I7AXz3GkLqJuu2dqHGu9x/f9M3YgBu
	 0TwZX0bARoT7cipOa1krZXo7MlWyLCfpPIBsxDhTyIXNFxIy/bryKzF5s5KCZrFzUb
	 SQ54KQ/teLvKqhX7rNc+C6ljYN+kU6i1UNSIP3QqmyKTWMgi5pvdP/dDSv2vpHhQJq
	 sJ7jtTG2/6IcBtIGk6WtYE+gOTK1RlyOUpp+V4skYAj5OXzfWJ4Hz2w258rue6Y8S2
	 bA4kwfrXCStrFUEBzRakLfqHg9PY3t596+Mc7zbElUQbSuguziCQiSopPVI4p+KhjD
	 WW+ioMyErXMTA==
From: hare@kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 11/13] nvme-tcp: combine reset and recovery
Date: Sat, 27 Jan 2024 10:30:56 +0100
Message-Id: <20240127093058.15699-12-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240127093058.15699-1-hare@kernel.org>
References: <20240127093058.15699-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240127_013122_924749_57EF15D5 
X-CRM114-Status: UNSURE (   9.00  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Hannes Reinecke <hare@suse.de>

Call 'connect_work' from reset to reduce duplicate code.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/tcp.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 6c8ca08f2972..a46ab8370007 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2329,14 +2329,7 @@ static void nvme_reset_ctrl_work(struct work_struct *work)
 		return;
 	}
 
-	if (nvme_tcp_setup_ctrl(ctrl, false))
-		goto out_fail;
-
-	return;
-
-out_fail:
-	++ctrl->nr_reconnects;
-	nvme_tcp_reconnect_or_remove(ctrl);
+	queue_delayed_work(nvme_wq, &to_tcp_ctrl(ctrl)->connect_work, 0);
 }
 
 static void nvme_tcp_stop_ctrl(struct nvme_ctrl *ctrl)
-- 
2.35.3



Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75722CD4F3C
	for <linux-nvme@archiver.kernel.org>; Tue, 19 May 2026 06:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ILKm15p5CTyr1Tu9vWBirCAIK+erVEmBmr7SAY7lvJ8=; b=xkg4vsg5nGdVpuCPyv+WnuXdCE
	wCN/VyjZDbHb0/X6928BXSWSHSeZAoyOTuifJzMGXX+FdCSVWnfo1uoX3enkMTKzARtxW5Ki6b1qn
	Li2eE2HTc7cY9A3rOidTHga+bYUJ37sdoWC9KU2paTanq/IuEkTCFr6HNTGFgpTwFJohnTPWQyVKo
	GXuvMnGEU6qhfy/ibB8YTWyrKsQpB0ZcqhXVL33gfvvyOkOpmJXVjJqBjV7zfWUPU+x2//6yDl30i
	90kFAgc70AsquzA1r/4bGUeuIwLUxk2i7ooOMz2r0wkfTOx/O+MWOzm7hs3bawOOfL8itG9BiHNeU
	RnL7jucg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPDff-00000000HfR-0Ina;
	Tue, 19 May 2026 06:11:15 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPDfd-00000000HeX-2nk3
	for linux-nvme@lists.infradead.org;
	Tue, 19 May 2026 06:11:13 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 2380860207;
	Tue, 19 May 2026 06:11:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CD20C2BCB3;
	Tue, 19 May 2026 06:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779171072;
	bh=5M/u3lC6xgzNmDc5Cdu/hGuWHEvFUBnF4R5HMnMNdTM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s/3SHKIm02V8GaTwKM30zTXXr0LQD3ty0dyTsHi7WH1kLi5cOkBLir/2eV9Twl9nI
	 Z0lFBJuqgmHI3SzggzpnLF7obCQYwJcNzKQLLGjSI6zvKyunCRRhFgLa9HqzJhqgjE
	 joVWsHhC4pq7xUOJz69IKnS8uFwlWxUalPvGTYlViHbYyEilB96OCANaWaVxiREJcF
	 0rWJIoEzSfpGGlCwFt6MS/4hxC0C2I09wwzEBQ7HFx7LMsB/hbmUEhSK9P2xOS2XaZ
	 /r5QYMwjZgW0eceK4kLgDZaqPe6MwT4mKV4q6cjULhoSVU+3JZVnHfNzlinsvFN77S
	 ZK6u8wrPPD+7Q==
From: Geliang Tang <geliang@kernel.org>
To: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Hannes Reinecke <hare@suse.de>,
	Keith Busch <kbusch@kernel.org>,
	Maurizio Lombardi <mlombard@redhat.com>,
	John Meneghini <jmeneghi@redhat.com>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	linux-nvme@lists.infradead.org
Subject: [PATCH 2/2] nvmet-tcp: remove duplicate cancel_work_sync in release_queue_work
Date: Tue, 19 May 2026 14:10:21 +0800
Message-ID: <246690f4c28333cc83f63081a36b85174465c9b7.1779170418.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1779170418.git.tanggeliang@kylinos.cn>
References: <cover.1779170418.git.tanggeliang@kylinos.cn>
MIME-Version: 1.0
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

From: Geliang Tang <tanggeliang@kylinos.cn>

The cancel_work_sync(&queue->io_work) is called twice in
nvmet_tcp_release_queue_work(). Remove the second one as it is redundant.

Fixes: a208fc5672177 ("nvmet-tcp: fix a race condition between release_queue and io_work")
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 drivers/nvme/target/tcp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 8a243d22a511..af7ce384b3cf 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1616,7 +1616,6 @@ static void nvmet_tcp_release_queue_work(struct work_struct *w)
 	nvmet_tcp_uninit_data_in_cmds(queue);
 	nvmet_sq_destroy(&queue->nvme_sq);
 	nvmet_cq_put(&queue->nvme_cq);
-	cancel_work_sync(&queue->io_work);
 	nvmet_tcp_free_cmd_data_in_buffers(queue);
 	/* ->sock will be released by fput() */
 	fput(queue->sock->file);
-- 
2.53.0



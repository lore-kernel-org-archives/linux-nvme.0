Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C808ACD13CF
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Sep 2024 13:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=jIqyDiN/5UEkfmn5zZTLyrr9mSWtdys64VffEmIMDW8=; b=dM4aJzXvGPjnLWLQcwWkkx3guj
	dbvTTuLObcpPKYcyUKadVUcIoYY7+aRNT8cPoP0rBatgD+0DYmB/A5LvjjU7149s9qclKPtx4q/WY
	fQWpHfur/kNo/XuGMHj1yqnKv/ymOWJW/OY2vn1xfZkDSQ9K9+9LdvZB9FRFtEF7V/whCPFt08B08
	U591gWpqPjClk9WYORzC/YtOqFSFgo7bnPbdg4VvF4OnVtzrIaAyeobU5mTG4f6hwsG3EukU1buv/
	lJXyKcvxLKu/kD/O5LCBRK5xKUZj3xl2ohCNkIVS43inLEdgkoCx7CYIdjaMMMGhY4wZ0zfrMFyjJ
	eCO4AFNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sl6mP-0000000ER70-34Tt;
	Mon, 02 Sep 2024 13:07:37 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sl6mL-0000000ER43-1mGX
	for linux-nvme@lists.infradead.org;
	Mon, 02 Sep 2024 13:07:36 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 4C72F5C5852;
	Mon,  2 Sep 2024 13:07:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2011C4CEC6;
	Mon,  2 Sep 2024 13:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725282452;
	bh=TTLZe+uGPKkdd7i7+GE3cw/Ud1n020Yb4BHFnJp6M74=;
	h=From:To:Cc:Subject:Date:From;
	b=qjWhBuzF3jv4o5mtAZ0oHeQwJ5YpHTk04Fu/157t/w3Wl5yG45TgGSBbJ7xOdef/i
	 etQ/V9IxzZcG7YFjmihc6rqWFsg7lCe6QwjBJ+Wmg19jsOAm33Z5E393JRpjgBCrcf
	 2ouse64ok4Pd3bsBPdabijaHRLR6+P8OWfAzwLoFYwexATznoLY5qeeoIYkGjz21t3
	 loLERaGN3ZfHE4E5KApoes7bdGJtFOjhazMgKKifVPUZRnJ+nWgIbs0qi9SqzkvsAV
	 5dz0K56TEZUGd8NgiS62CkMOVFVJ72JX36w01Jtr8+IwDJR38vRKN75GkZgiD61reW
	 yGxFWt3G7SD/w==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH] nvme-pci: check for valid request when polling for completions
Date: Mon,  2 Sep 2024 15:07:28 +0200
Message-Id: <20240902130728.1999-1-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240902_060733_721824_15A9B64C 
X-CRM114-Status: GOOD (  11.48  )
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

When polling for completions from the timeout handler we traverse
over _all_ cqes, and the fetching the request via blk_mq_tag_to_rq().
Unfortunately that function will always return a request, even if
that request is already completed.
So we need to check if the command is still in flight before
attempting to complete it.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/host/pci.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 6cd9395ba9ec..fc4c616516d6 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1037,6 +1037,13 @@ static inline void nvme_handle_cqe(struct nvme_queue *nvmeq,
 		return;
 	}
 
+	if (blk_mq_rq_state(req) != MQ_RQ_IN_FLIGHT) {
+		dev_warn(nvmeq->dev->ctrl.device,
+			 "stale completion id %d on queue %d\n",
+			 command_id, le16_to_cpu(cqe->sq_id));
+		return;
+	}
+
 	trace_nvme_sq(req, cqe->sq_head, nvmeq->sq_tail);
 	if (!nvme_try_complete_req(req, cqe->status, cqe->result) &&
 	    !blk_mq_add_to_batch(req, iob, nvme_req(req)->status,
-- 
2.35.3



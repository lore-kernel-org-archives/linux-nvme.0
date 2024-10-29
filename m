Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D3ECD3A67B
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Oct 2024 18:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WPznSjWJrOYs5EZhq/aklcV//pMCd90RcZ8YcLfYAow=; b=TaKEpOe74t9qv2PKP27kAe7HKg
	m/ItyMW1bSGkXzLiACLcvv5uODz+EEvOQVsQG5MYuFjCw1UkIxwApmXljqtd6TXxgLyv41Ih11lHQ
	loGX+FgiBGQI9/isDI7lM5UUhGabOMDhQvFVz0wxu0qVTFN0Yw+umfaq4VeJP1D/n0QsmssabfWJA
	phOMN+WvLhsEYS87gVmTdQwuniLmnoxGF/ITYvhVmTfbEFcIy1z0VM5IrfFXd0zLR/P8llw4K+dU0
	5QP0NzfDDaZ/J1dvOf6zwZIskMr82w0rO5oE+b3zfr3Fo7LY9KdSFU9Y9IE1bi6b2CfOzc9lFvGCW
	caIthILw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5r8i-0000000FVdc-43hs;
	Tue, 29 Oct 2024 18:40:24 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5r8f-0000000FVb7-0wEw
	for linux-nvme@lists.infradead.org;
	Tue, 29 Oct 2024 18:40:23 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 5F61BA431E6;
	Tue, 29 Oct 2024 18:38:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8715C4CEE4;
	Tue, 29 Oct 2024 18:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730227220;
	bh=YipPWOMTdVKjtMIdpDJ7zD4aTB5Vym5i0pgmtjyFGsE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=M+J1avRwzeSpv63jmRTtzo4bbGYbYTpfRQOQf15yuBhEnpYDLJ6pyzZRgsLh6gBNw
	 e8TXysIPRfcIMtX7U94mGHiVE0eRF7Jb/8TvkGp5KL6BICoGF/XTbKTcCFLrlnYqjb
	 XSusce0LRRSaJwoGdwscfD2P7z0jOsJiSiasRMlfczEuEQozc1UQL+7FRSGS4Pote8
	 1m8UYYCeS79l0jmUL3j0eVuuyfNN/TMnEN/gniMAxfpON9MOJj7+9SjqlBm9bh594c
	 afVfDqW9KIPT/0URXOnDxvukXhB8vat4Kt9919ERvLW45ezoO6/vY72TQ/btxk1mLo
	 wSJbppD4SG6hQ==
From: Daniel Wagner <wagi@kernel.org>
Date: Tue, 29 Oct 2024 19:40:12 +0100
Subject: [PATCH v2 2/2] nvme: handle connectivity loss in
 nvme_set_queue_count
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241029-nvme-fc-handle-com-lost-v2-2-5b0d137e2a0a@kernel.org>
References: <20241029-nvme-fc-handle-com-lost-v2-0-5b0d137e2a0a@kernel.org>
In-Reply-To: <20241029-nvme-fc-handle-com-lost-v2-0-5b0d137e2a0a@kernel.org>
To: James Smart <james.smart@broadcom.com>, Keith Busch <kbusch@kernel.org>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Hannes Reinecke <hare@suse.de>, Paul Ely <paul.ely@broadcom.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241029_114021_444952_6CD6A895 
X-CRM114-Status: GOOD (  18.37  )
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

nvme_set_queue_count is called when setting up the IO queues. When
updating of the queue number fails, the function will ignore all NVME
errors. The assumption is that the controller is in degraded state, the
admin queue is up and running but not the IO queues.

In this state it's still possible to issues admin commands to the
controller to mitigate the problem, that's whay the controller
is allowed to enter the LIVE state.

Though by filtering out all error, it filters out a connectivity loss
event for fabric controllers:

     1) nvme nvme10: NVME-FC{10}: create association : ...
     2) nvme nvme10: NVME-FC{10}: controller connectivity lost. Awaiting Reconnect
        nvme nvme10: queue_size 128 > ctrl maxcmd 32, reducing to maxcmd
     3) nvme nvme10: Could not set queue count (880)
        nvme nvme10: Failed to configure AEN (cfg 900)
     4) nvme nvme10: NVME-FC{10}: controller connect complete
     5) nvme nvme10: failed nvme_keep_alive_end_io error=4

A new connection attempt is started 1) and while connecting the host
receives a connectivity loss event 2). 3) is the point where the connect
code observes a problem but ignores it and enters LIVE state at 4). The
keep alive command eventually times out 5) but again, this type of error
is ignored.

Note the status in nvme_keep_alive_end_io is EINTR, the real reason got
lost at this point (connectivity loss).

Thus catch the error early where we still have the exact reason why the
nvme_set_features has failed and bail out from there.

Fixes: 9a0be7abb62f ("nvme: refactor set_queue_count")
Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/host/core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 84cb859a911d09dbe71b2f1ac473ae687c4dc687..cc5ed6daf61f6cbc6fdf7b48687e25225bfd9f17 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1664,7 +1664,12 @@ int nvme_set_queue_count(struct nvme_ctrl *ctrl, int *count)
 
 	status = nvme_set_features(ctrl, NVME_FEAT_NUM_QUEUES, q_count, NULL, 0,
 			&result);
-	if (status < 0)
+	/*
+	 * It's either a kernel error or the host observed a connection
+	 * lost. In either case it's not possible communicate with the
+	 * controller and thus enter the error code path.
+	 */
+	if (status < 0 || status == NVME_SC_HOST_PATH_ERROR)
 		return status;
 
 	/*

-- 
2.47.0



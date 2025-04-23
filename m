Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E63E2C369D7
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Apr 2025 13:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=L6mLGiZVRj/r2kEbAgsXZBAaxL59dgmF4U61U9Y6bTY=; b=noxvVS8WEXuCtaE8HXK8FS7vz3
	bMMRy8BZh7xJqO9NhfLIcJr9bme3d0oKTonMKGSqnTF/GciMThTgM986NYzvSpaGnPGzOOrCRQ68s
	N9wC3uuWVufZhxRvQr07zk6MTIyc3ymh9tuborQSw0t01c4agGlYL2/aIi0fu7vD/NRBCgiiAbUL8
	tqjnk+jCN/EAb0ntvWzqcb5tK6oHpzJhMW0UhqmRXmmShNfGkbsOdLQ30eF+XDdAiCwG5FoxWdKwl
	HQ44VDtR68pbv0VjKzOpPAQho3DEzQn0CrHwLLJUhYKncpnB/28gRmN/zyHHPGegjl5qN7zXzjPb+
	HLUYjZyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7aXT-0000000Ahtu-07Xb;
	Wed, 23 Apr 2025 13:53:23 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7a3T-0000000AaoJ-3urz
	for linux-nvme@lists.infradead.org;
	Wed, 23 Apr 2025 13:22:23 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 8368F614B5;
	Wed, 23 Apr 2025 13:22:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B100EC4CEE2;
	Wed, 23 Apr 2025 13:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745414543;
	bh=6MtNYpYf3+gfKph3AscTQcqFhTmhfVMJlOnasxAT7Vg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=uGzG7HQjaUOR35QHir31DR1z2HfBPedM5tEamXQzYkPoo9/XCIa30mQw1CH3QsLoA
	 GGxj8hSQTKO1gbJN4lKj6C7uIupIitm9kZo8+JXnIwwIgXLazQ0BlzgPC2NITECcYT
	 so4fBYHWVtKRqSsw3dybjbkXQzS9i8SFvcaGHKlflCHHi2tr9fNEFoBpHrwkqbmEBW
	 BPYLXUSLYQi8Y/ch4FWe1oTIjCu7SVnetaG1WHoI0MPo/0YJZppnjZe1PcUruRyWQO
	 yZ3gjWF3vpjbcKNhlgiwLXWlTXHo34kW9Oy710YjyMbJwMyAYRXuGxriUaQkldg/OS
	 BHpSAkDjYjT0g==
From: Daniel Wagner <wagi@kernel.org>
Date: Wed, 23 Apr 2025 15:21:54 +0200
Subject: [PATCH v5 11/14] nvmet-fcloop: drop response if targetport is gone
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250423-nvmet-fcloop-v5-11-3d7f968728a5@kernel.org>
References: <20250423-nvmet-fcloop-v5-0-3d7f968728a5@kernel.org>
In-Reply-To: <20250423-nvmet-fcloop-v5-0-3d7f968728a5@kernel.org>
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
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

When the target port is gone, the lsrsp pointer is invalid. Thus don't
call the done function anymore instead just drop the response.

This happens when the target sends a disconnect association. After this
the target starts tearing down all resources and doesn't expect any
response.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/target/fcloop.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index ca11230bffedb0f2313a99e24e54e892daf0d644..bb45721ec0f028399d810cbd7891bc6975801752 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -493,16 +493,25 @@ fcloop_t2h_xmt_ls_rsp(struct nvme_fc_local_port *localport,
 	struct nvmet_fc_target_port *targetport = rport->targetport;
 	struct fcloop_tport *tport;
 
-	memcpy(lsreq->rspaddr, lsrsp->rspbuf,
-		((lsreq->rsplen < lsrsp->rsplen) ?
-				lsreq->rsplen : lsrsp->rsplen));
-	lsrsp->done(lsrsp);
-
 	if (!targetport) {
+		/*
+		 * The target port is gone. The target doesn't expect any
+		 * response anymore and the ->done call is not valid
+		 * because the resources have been freed by
+		 * nvmet_fc_free_pending_reqs.
+		 *
+		 * We end up here from delete association exchange:
+		 * nvmet_fc_xmt_disconnect_assoc sends an async request.
+		 */
 		kmem_cache_free(lsreq_cache, tls_req);
 		return 0;
 	}
 
+	memcpy(lsreq->rspaddr, lsrsp->rspbuf,
+		((lsreq->rsplen < lsrsp->rsplen) ?
+				lsreq->rsplen : lsrsp->rsplen));
+	lsrsp->done(lsrsp);
+
 	tport = targetport->private;
 	spin_lock(&tport->lock);
 	list_add_tail(&tls_req->ls_list, &tport->ls_list);

-- 
2.49.0



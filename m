Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53F0FC3ABBF
	for <linux-nvme@archiver.kernel.org>; Wed,  7 May 2025 12:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=83ca3ndHT62scGwS6kVzP4aXholuzf+oR+i7b98P0zg=; b=ve62whLJF1ghx9MQO2V1ug+Tw+
	yWrL5or0pS5X2QjuPPcQbzxevCRML05iCTsNnqaQNxJZj2Ykxdsj2ssSikRS7DJSlllpeFYyNCqvu
	nJMcGWSMjS5JXNvAt7YMY8GTr0414CSqaq4wwJo4+UFnE/d2NUPC2IU9z+Aj4zq8nLh/y4pVY24XQ
	mS/54o3RXCjF4TYDHaYVRMxs8JAq/xzxzn50DFteOLBgQD2CdXMFkj1i/dO9t58Tq8FV7yfmUZx47
	KJ74zyfck5Ra1EXTYlcfJmRKS6jIGQsxrG5lIzvE5VT/M1y+H1/g5jiaSH+2b1Ga5frAga3IYFBAl
	1idIjtbw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCdoG-0000000FNCn-3Afv;
	Wed, 07 May 2025 12:23:36 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCdoF-0000000FNAj-00Gw
	for linux-nvme@lists.infradead.org;
	Wed, 07 May 2025 12:23:35 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 6C1C1629E5;
	Wed,  7 May 2025 12:23:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8583C4CEEE;
	Wed,  7 May 2025 12:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746620614;
	bh=Vgi/9IyqkECjCLy4OrYLOjteLpppbj1oxp8MVjo1eQs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Oh9dX8aAXSTWWt+hXSDRXwgZbV0Qdq/GSGS/kyLDRyZDLOovd6fVhq+XwJ9s1zoRC
	 OK4bKc1otjchyDHSszsnBQIkco8NM92Rk4/F6SHyCIJV5m6EdvUqfB7B6Nw0UiF3lH
	 Q8i6jtnRlAqzAligpQbmRtbuIAZFaDy7emUQGK1GQzJqK4EvQSf434MaruefAui2mw
	 TRsulgiNHKi6XdbH2/fdi1jmbUVEJnr8AD0y9Fh92GPyAfCL5Ey6+8jDI/oZSeIT65
	 da91gIW1XyL6JqqeDigUnMruJlJMkXwhw8JjVQUbZLiekajZW/+USsZdekqibn+ddT
	 W015GCXFUlKHw==
From: Daniel Wagner <wagi@kernel.org>
Date: Wed, 07 May 2025 14:23:07 +0200
Subject: [PATCH v6 11/14] nvmet-fcloop: drop response if targetport is gone
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250507-nvmet-fcloop-v6-11-ca02e16fb018@kernel.org>
References: <20250507-nvmet-fcloop-v6-0-ca02e16fb018@kernel.org>
In-Reply-To: <20250507-nvmet-fcloop-v6-0-ca02e16fb018@kernel.org>
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

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/target/fcloop.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index fc10d380c17e77ed35706ddd7690e6f6a8d268c6..83edfd48c30db36a755b9dc7af6605236dc67231 100644
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



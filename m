Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22F69CCF9F0
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Oct 2025 10:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vOF8rR5VMOhxteEbKlqUfy4+FfR+/qN09QIxxlXxObg=; b=JvbJfpaq6p59UFTLmIutLAS99C
	oupDCrIjPH5YQCNElrlzXNlGqvXOmmdET/L1tn0IKV3V3K43yovbwDMjaFOpinhebL7V+vMiTSSVd
	0dq8qGjaQKif1vbU8bI8Wx8BRUnda/e36PIqT6c1cOG7UKVQZssqp+Eia5oo4JvveGVBWeEeZHXqo
	qpMJMFPvlj1rukYFFbviHwdwyS7suxflrlbRZrkU8n9ey0LrUt7kEiXAsKSaIS0xyIHsWDWgfeGrV
	X8lgGCbRE9EQzlaugoPU18MzEuyB/i0K1i3g8wRG4aKvN3gBro4EY+K4Wy41VLsqoP+3MpEvIRGs0
	7uvTeZMw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEPXc-00000003wCF-2med;
	Thu, 30 Oct 2025 10:06:00 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEPXb-00000003wBh-1nZt
	for linux-nvme@lists.infradead.org;
	Thu, 30 Oct 2025 10:05:59 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id D6B2160B51;
	Thu, 30 Oct 2025 10:05:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F715C116B1;
	Thu, 30 Oct 2025 10:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761818758;
	bh=v/bwxwMrPgUrZzVMTssoD2ipJp8loXVDoDEfaEXxUas=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Vm1ZBE460FFKUGimLHP50dR5K9qwZcte7C31bHO6CkzQrGsy+co0uzHGhmohmHBDs
	 9/QJBBq/pimwj2Xu/VA65y6IvwIp7uGxfegWUddymSYGIwZEzLJY4tIXUOh6q8KepU
	 n5v1f3qaagsSm3hPoBXmpz1KL/p1Ae0ua6ki4zi52xSEZKu0M7QjLLtsZKT4+zWkGL
	 87a9Wd5p202LZF9OJGE37BmcWsvuq2ceSn9U1HZh0AOWUGVUxYKG2+bvdWkDGH4HaJ
	 jEYJuFgfIwDNyyS04FPxQcEdUuY0hUwNTCykYnjDoPyFhWMejeuBABODWqM8tAT9+q
	 DXYvupmk7R5aQ==
From: Daniel Wagner <wagi@kernel.org>
Date: Thu, 30 Oct 2025 11:05:47 +0100
Subject: [PATCH v2 3/5] nvmet-fcloop: check all request and response have
 been processed
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251030-nvmet-fcloop-fixes-v2-3-b8d66a322c51@kernel.org>
References: <20251030-nvmet-fcloop-fixes-v2-0-b8d66a322c51@kernel.org>
In-Reply-To: <20251030-nvmet-fcloop-fixes-v2-0-b8d66a322c51@kernel.org>
To: Justin Tee <justin.tee@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Keith Busch <kbusch@kernel.org>
Cc: James Smart <james.smart@broadcom.com>, Jens Axboe <axboe@kernel.dk>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.3
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

When the remoteport or the targetport are removed check that there are
no inflight requests or responses.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/target/fcloop.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index 5dffcc5becae..4e429a1ea2bd 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -1111,8 +1111,10 @@ fcloop_remoteport_delete(struct nvme_fc_remote_port *remoteport)
 	rport->nport->rport = NULL;
 	spin_unlock_irqrestore(&fcloop_lock, flags);
 
-	if (put_port)
+	if (put_port) {
+		WARN_ON(!list_empty(&rport->ls_list));
 		fcloop_nport_put(rport->nport);
+	}
 }
 
 static void
@@ -1130,8 +1132,10 @@ fcloop_targetport_delete(struct nvmet_fc_target_port *targetport)
 	tport->nport->tport = NULL;
 	spin_unlock_irqrestore(&fcloop_lock, flags);
 
-	if (put_port)
+	if (put_port) {
+		WARN_ON(!list_empty(&tport->ls_list));
 		fcloop_nport_put(tport->nport);
+	}
 }
 
 #define	FCLOOP_HW_QUEUES		4

-- 
2.51.1



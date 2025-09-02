Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 544ADCA1005
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Sep 2025 12:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WQfkRxZsBkw+b4gIendPXQd+jE3QB/KUKr6IQ0S/+78=; b=31vVOSeOUUt5GSYDLRTO6IE9g7
	sdH5/0rlgLXAC0vil0G9gxJE34M+5aNU7DKm+F+wLN6emKawFDd7m7wWKRXvVcR5GwQqlnQ5Byt5H
	zILS/dUANM4AyIDoOsR9dZjlC2tTEOzBqmaOLJe36aPumxIuBmZSHOTkgkW2ieiHTxPJZzmYTBr15
	U9FnNy+lkXU2bxUVgNYNIHKuyTIDfON+xwiveomNiy543PkscbktOHUlKVSyQFAAMIBHgOuotVNH7
	DPuE+g6txd02BvRueu7DGdSdYk6/3p3Fqc7FiNfAAjE1f+pJME/rFig65Ahsjrb41mwju+fD8Oz2Y
	e9A/Mz3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utQBJ-0000000HJdB-3Ia3;
	Tue, 02 Sep 2025 12:32:13 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utO9h-0000000GeCg-29jM
	for linux-nvme@lists.infradead.org;
	Tue, 02 Sep 2025 10:22:26 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 42B2344A32;
	Tue,  2 Sep 2025 10:22:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8697C4CEED;
	Tue,  2 Sep 2025 10:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756808545;
	bh=XdaLPKat6GDbBRPcO/Jf/i/b/c+Fok3IBE+4J5oQnYA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=d7BLtbSmF14hRfoeGMjdBAt9LFyXVNfLVyv0PN8J6acm1NrMFGjxJxyzZRVqfkPS4
	 TrCDmBDnfdJ5Ub2mcVKceJKFcivcKg2tyh2nMznlPN7VmJoXLSQ0cGtjQJhoqUCDle
	 YWqROghliDxD+WCwea1io6nTpy4iuXMo3RBLxBHv9j616/koUrvpIggV0WkFSG2Jvo
	 sc3XcnpX5TEjkjadv9FMNJre+0MBy6FOouiyrf4UMfd1eY05j/+XdjpvWvRVIGoTtC
	 MDiBbT2uCtg0dMRST/XoEy7Of/+KpnCZGIStKT/7cZVfLPExF/zV6qJpRgp5GFpdze
	 zDQNU80Ez9KiA==
From: Daniel Wagner <wagi@kernel.org>
Date: Tue, 02 Sep 2025 12:22:02 +0200
Subject: [PATCH v3 3/4] nvmet-fcloop: call done callback even when remote
 port is gone
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-fix-nvmet-fc-v3-3-1ae1ecb798d8@kernel.org>
References: <20250902-fix-nvmet-fc-v3-0-1ae1ecb798d8@kernel.org>
In-Reply-To: <20250902-fix-nvmet-fc-v3-0-1ae1ecb798d8@kernel.org>
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>
Cc: Yi Zhang <yi.zhang@redhat.com>, 
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
 Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250902_032225_576480_96F38D5B 
X-CRM114-Status: GOOD (  15.40  )
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

When the target port is gone, it's not possible to access any of the
request resources. The function should just silently drop the response.
The comment is misleading in this regard.

Though it's still necessary to call the driver via the ->done callback
so the driver is able to release all resources.

Reported-by: Yi Zhang <yi.zhang@redhat.com>
Closes: https://lore.kernel.org/all/CAHj4cs-OBA0WMt5f7R0dz+rR4HcEz19YLhnyGsj-MRV3jWDsPg@mail.gmail.com/
Fixes: 84eedced1c5b ("nvmet-fcloop: drop response if targetport is gone")
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/target/fcloop.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index 257b497d515a892a39da82d2f96b3fa3c6e10cdd..5dffcc5becae86c79ef75a123647566b2dfc21f6 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -496,13 +496,15 @@ fcloop_t2h_xmt_ls_rsp(struct nvme_fc_local_port *localport,
 	if (!targetport) {
 		/*
 		 * The target port is gone. The target doesn't expect any
-		 * response anymore and the ->done call is not valid
-		 * because the resources have been freed by
-		 * nvmet_fc_free_pending_reqs.
+		 * response anymore and thus lsreq can't be accessed anymore.
 		 *
 		 * We end up here from delete association exchange:
 		 * nvmet_fc_xmt_disconnect_assoc sends an async request.
+		 *
+		 * Return success because this is what LLDDs do; silently
+		 * drop the response.
 		 */
+		lsrsp->done(lsrsp);
 		kmem_cache_free(lsreq_cache, tls_req);
 		return 0;
 	}

-- 
2.51.0



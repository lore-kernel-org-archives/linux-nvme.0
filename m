Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCCAACD4851
	for <linux-nvme@archiver.kernel.org>; Thu, 14 May 2026 08:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fufir1DjEW4cYOI6Lc8NZmw8j0Eo+elwD4DGNbpPHLw=; b=1vBsO1EenXyviwYESfVhqNWLgh
	ExTtBiMsyt5hMdlrrFrXCPHC3chOUnTlUEXNUmKg534OxCDMdq3STPVsUlvdp8OrQAqRYLJ9Oajp7
	Fs04RSntxTQWw0nKEfAbxdNxx+IwiYeDZsqADflBfzXYH8g/OrG5fo754wEt8oTw0YTNrk80347CJ
	vchSjqbPaIf3dyAnVo0GyFhI60ZI7HiQvGgJSTQmYZoscOBOizzy5c640zXRAA64uWUHQReogw7EI
	lI9ghHHCDNUoB5bcQh0WcdGdZTPTRNU9eq7tqeLDpgeDdQGfV36R4vYKz51lDLjUsGAMFK8taAej0
	dJaTu3ug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNRVh-00000004xBF-0fFw;
	Thu, 14 May 2026 08:33:37 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNRVe-00000004x8w-3x2L
	for linux-nvme@lists.infradead.org;
	Thu, 14 May 2026 08:33:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778747614;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fufir1DjEW4cYOI6Lc8NZmw8j0Eo+elwD4DGNbpPHLw=;
	b=OsrVhRotXrPj1NWYy+CoKAnKFVop1zx7ZjIpyvefqA7KF2rs7qFbVkCuOCoKtgxgTNbY//
	7zUxtXBGQl6ye+Xh/IFymyxSit5PCCUlBcTfePTagX5/e4UT/xmZxlk2nUUAxLDhnBmfnQ
	bQSOZ6MQHb2YO4TM/ZOp8GbrTfTmKhw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-679-3EQlVfbuNTuOoaLttjWOaA-1; Thu,
 14 May 2026 04:33:30 -0400
X-MC-Unique: 3EQlVfbuNTuOoaLttjWOaA-1
X-Mimecast-MFC-AGG-ID: 3EQlVfbuNTuOoaLttjWOaA_1778747608
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 82FED1956094;
	Thu, 14 May 2026 08:33:28 +0000 (UTC)
Received: from mlombard-thinkpadt14gen4.rmtit.csb (unknown [10.44.48.89])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 465A81956053;
	Thu, 14 May 2026 08:33:25 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: kbusch@kernel.org
Cc: mheyne@amazon.de,
	emilne@redhat.com,
	jmeneghi@redhat.com,
	linux-nvme@lists.infradead.org,
	dwagner@suse.de,
	mlombard@arkamax.eu,
	mkhalfella@purestorage.com,
	chaitanyak@nvidia.com,
	hare@kernel.org,
	hch@lst.de
Subject: [PATCH V5 7/7] nvme-core: warn on allocating admin tag set with existing queue
Date: Thu, 14 May 2026 10:32:55 +0200
Message-ID: <20260514083255.41109-8-mlombard@redhat.com>
In-Reply-To: <20260514083255.41109-1-mlombard@redhat.com>
References: <20260514083255.41109-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: tZStRHFbhXk8TEIBtnm3IBChYcRyRbTEWK9GhkS34lg_1778747608
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260514_013335_055545_3F49D224 
X-CRM114-Status: GOOD (  13.62  )
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

Currently, nvme_alloc_admin_tag_set() silently drops and releases
the existing admin_q if it called on a controller that already
had one (e.g., during a controller reset).

However, transport drivers should not be reallocating the admin tag
set and queue during a reset. Dropping the old queue and allocating
a new one destroys user-configured timeouts and may race against
nvme_admin_timeout_store()

Since all transport drivers are now expected to preserve the admin queue
across resets, calling nvme_alloc_admin_tag_set() when ctrl->admin_q
is already populated is a bug.

Remove the silent cleanup and replace it with a WARN_ON_ONCE() to
explicitly catch any transport drivers that violate this lifecycle rule

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Daniel Wagner <dwagner@suse.de>
Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
---
 drivers/nvme/host/core.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index e6bb1f5e9657..f23a957c6e8f 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4893,12 +4893,7 @@ int nvme_alloc_admin_tag_set(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set,
 	if (ret)
 		return ret;
 
-	/*
-	 * If a previous admin queue exists (e.g., from before a reset),
-	 * put it now before allocating a new one to avoid orphaning it.
-	 */
-	if (ctrl->admin_q)
-		blk_put_queue(ctrl->admin_q);
+	WARN_ON_ONCE(ctrl->admin_q);
 
 	ctrl->admin_q = blk_mq_alloc_queue(set, NULL, NULL);
 	if (IS_ERR(ctrl->admin_q)) {
-- 
2.54.0



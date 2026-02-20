Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 438CFC54FD2
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Feb 2026 13:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=60SbIRislneZFct6I2kiisv8TuQ9oZeAymgZ5dRj6cQ=; b=1rTo52Tvhatl7T9GmNXvHDUHVQ
	VYDXK/N/1KHgUw+kRqjjBq9SsfWr2Pg3zELFZv1FVZCNB0K7hlUUclIwVZA+6+E2+GMFnND2m4Q5R
	11vkWnDOdN63AXB+G/zCFFzTpkamiGoGtOBU75coCzePzPjBB7orBhZovoD7ijB5/rr/TS7P71vG4
	aWHWkh8nJGgmSV3EEFVBUqciSvpIudMSJUhhxv0PgIYSScIBLVbQGPFs4Cicy8bMzZBC31rnEfRwn
	x7xBJAPs7C88kjKFa2SS7sPfwl5er6zg/G/8zrb6G9Ow3Dqw9mzunkHtmLdVW1Q9W4r0Tan74Do0+
	cMMsLffg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtQaU-0000000EXuS-2VIx;
	Fri, 20 Feb 2026 13:30:30 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtQaQ-0000000EXtf-1dB1
	for linux-nvme@lists.infradead.org;
	Fri, 20 Feb 2026 13:30:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771594225;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=60SbIRislneZFct6I2kiisv8TuQ9oZeAymgZ5dRj6cQ=;
	b=XEYFR0cdze+RY9d8aoPu6xrkpj3DWUxExz5cnIwOYinrgMwG5yPdH5VwJrnA7jP9cPpXEp
	XFz4TzElfmGUPsZR6k7wpWjg5Q173oyeHlCYQLXk9xYOY6h//cz3giNy2akvitzscSPZoy
	DPEOg0dy8WD4My4oHs5aJNJJ0VkwD9Q=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-646-Rc8foq1zP2mk8iz39a2RTg-1; Fri,
 20 Feb 2026 08:30:21 -0500
X-MC-Unique: Rc8foq1zP2mk8iz39a2RTg-1
X-Mimecast-MFC-AGG-ID: Rc8foq1zP2mk8iz39a2RTg_1771594220
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 262601800465;
	Fri, 20 Feb 2026 13:30:20 +0000 (UTC)
Received: from mlombard-thinkpadt14gen4.rmtit.csb (unknown [10.45.224.125])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 41291195419E;
	Fri, 20 Feb 2026 13:30:17 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: kbusch@kernel.org
Cc: linux-nvme@lists.infradead.org,
	dwagner@suse.de,
	mlombard@arkamax.eu
Subject: [PATCH] nvme-core: do not pass empty queue_limits to blk_mq_alloc_queue()
Date: Fri, 20 Feb 2026 14:30:16 +0100
Message-ID: <20260220133016.524192-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: hhQFTLHevl8adX7RgC8UwZzww5mGy4574udi0fVwlgM_1771594220
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260220_053026_499565_CEC39A00 
X-CRM114-Status: GOOD (  10.61  )
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

In nvme_alloc_admin_tag_set(), an empty queue_limits struct is
currently allocated on the stack and passed by reference to
blk_mq_alloc_queue().

This is redundant because blk_mq_alloc_queue() already handles
a NULL limits pointer by internally substituting it with a default
empty queue_limits struct.
Remove the unnecessary local variable and pass a NULL value.

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
---
 drivers/nvme/host/core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 19b67cf5d550..8798a51f735c 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4845,7 +4845,6 @@ EXPORT_SYMBOL_GPL(nvme_complete_async_event);
 int nvme_alloc_admin_tag_set(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set,
 		const struct blk_mq_ops *ops, unsigned int cmd_size)
 {
-	struct queue_limits lim = {};
 	int ret;
 
 	memset(set, 0, sizeof(*set));
@@ -4865,7 +4864,7 @@ int nvme_alloc_admin_tag_set(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set,
 	if (ret)
 		return ret;
 
-	ctrl->admin_q = blk_mq_alloc_queue(set, &lim, NULL);
+	ctrl->admin_q = blk_mq_alloc_queue(set, NULL, NULL);
 	if (IS_ERR(ctrl->admin_q)) {
 		ret = PTR_ERR(ctrl->admin_q);
 		goto out_free_tagset;
-- 
2.53.0



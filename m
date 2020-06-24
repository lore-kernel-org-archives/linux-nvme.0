Return-Path: <SRS0=WpAz=AF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42C4AC433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2020 19:27:25 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10B5820823
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2020 19:27:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="beyLLmQg";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="deTz69g3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10B5820823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=zstfKTXpndjA0k5cQc7qkNAidxEfpFnKOzfwoP8g7oU=; b=beyLLmQgn4a24CuaL87dyRtTFJ
	W8BCL6KVyGO6ZXPuS0Yf2OLlhI5R/jczJcPjFulejBM1jtmBYIGdgSP2sKlO0skPXal6diIBu8eG4
	VWbaV4tgDTyYvgAG5vfEaz3N4RmzhslqpFYxTKYHZbeJ/nFaBXxqV1ZbFV0IVRDBTguu+TezoyZbZ
	n0yP1Pu3jyUbGqUVsdNU6GzD+gGzs1GJOkhVlKFyPdhlyO1wsjNEERJfMm+xNBJeU5jTvwpU42f9u
	Ffi7u1pF0asByZ6um+t3PnwtydF0yxzeHCOq5P/wjPw7x+Hf80OZZR0+Piw/FiJtn9m29m5tHNy+u
	yZ+jtjGw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1joB3K-0001DD-Ft; Wed, 24 Jun 2020 19:27:22 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1joB3J-0001B7-8L
 for linux-nvme@merlin.infradead.org; Wed, 24 Jun 2020 19:27:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=7S2py2EPsvC5vemOc/aki/sUY3cfl+JInca9oR5KjQY=; b=deTz69g3ZCWqvbOtuu4A/fvPxg
 K9aUZ7jHgvS5N1g+TaTrdEfPQV0/as93c8OTVvKGgGxQUfQIxe2O5B1QPI0UqJUiWl4rE6GDDbLio
 e15GAvwZLiGYDIFoYZjEBnD8i6inZqRJiw3RcgJUmY2FLSVjcuW2abH3JD3D5//bREDGvUOwwidGz
 pxvmusqYgMwgtKTKHiqSpSnRU5ZKvLrRFMdZhs3JhDUrZ9lkW7/sevU8a6JNqsYB/BVbasl9lqz9p
 O+xXRKWJrvxSscAeNHemtLwWyGRssQcxd4S8pZxXWdtpB5y/0xa6JX1hGWQ0L8ngkzQ7a0YsLE9or
 k6/HR9/A==;
Received: from [2601:647:4802:9070:4c08:474f:e61d:6947]
 (helo=sagi-Latitude-7490.hsd1.ca.comcast.net)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1joB3H-0006o6-Gb; Wed, 24 Jun 2020 19:27:20 +0000
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH] nvmet-tcp: simplify nvmet_process_resp_list
Date: Wed, 24 Jun 2020 12:27:16 -0700
Message-Id: <20200624192716.14819-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

We can make it shorter and simpler without some
redundant checks.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
Christoph, your version looks so good that I want to
take it to the target code as well.

 drivers/nvme/target/tcp.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 38eb8797b3c0..dfcbc6522aba 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -463,17 +463,11 @@ static void nvmet_setup_response_pdu(struct nvmet_tcp_cmd *cmd)
 static void nvmet_tcp_process_resp_list(struct nvmet_tcp_queue *queue)
 {
 	struct llist_node *node;
+	struct nvmet_tcp_cmd *cmd;
 
-	node = llist_del_all(&queue->resp_list);
-	if (!node)
-		return;
-
-	while (node) {
-		struct nvmet_tcp_cmd *cmd = llist_entry(node,
-					struct nvmet_tcp_cmd, lentry);
-
+	for (node = llist_del_all(&queue->resp_list); node; node = node->next) {
+		cmd = llist_entry(node, struct nvmet_tcp_cmd, lentry);
 		list_add(&cmd->entry, &queue->resp_send_list);
-		node = node->next;
 		queue->send_list_len++;
 	}
 }
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

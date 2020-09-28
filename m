Return-Path: <SRS0=ZZT4=DF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8464C2D0A8
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Sep 2020 12:35:55 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 673B721531
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Sep 2020 12:35:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IVlOw3sP";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eM07fs9v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 673B721531
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=7xEW1vwH/03njMVbKG9MnlAqwN4aIvXx7ZIhg5ISJE4=; b=IVlOw3sP9xpOr7JCTkhnQ54n6
	xVHTFWDNQmG4y7EzfBT6zDihEBiz9WjzD9FPAyKB0HvUbhcd6yGl8BWxmEjzyYKs/dBMq6QVYyBvv
	5pqSyfXLCjAOCgxsusYwewf/BQJ4IxJr7mEVZ4OHq8GtbjKsw5we5jXlLQ/2FL6mcBucn0q22zua5
	cp4E/ZASdPBT51he+GzNufe8BbMkTSKMzYqz/69NDfD2YyyuwY0xZqQ2VCO3UlymiRyMKQWOzG8pz
	qFfejxE3jp0tKDOCKmyySl9w/650SQJv7A69Mmqk5HHmyzYMVlmsWYTIgZvW+FLS90M8j5/4+B7DS
	9uxHaHRZQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kMsNj-0002cq-Kl; Mon, 28 Sep 2020 12:35:51 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kMsNJ-0002QC-Rx
 for linux-nvme@merlin.infradead.org; Mon, 28 Sep 2020 12:35:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=I/YZBofZgTHKy1iGnSq+ACbIndyfqdcV9EHqRuwiSeE=; b=eM07fs9vzHJuinjfIw3EKKFuRd
 yxNSv/nABKfvX0wn6puWAXxZrRg9LQ7rtHj1zV4nYKDLqnb7c8DFLsjGePKoTFck967KrwaQ5inS9
 KPJnnP8T11sXe/UKKtTcZnBU5HBcGMEs/N8dN2F78synBfcfEq9rzMTwUNZAmmCvw/pynL9uMXoy8
 tCOTmM0NFnmd5nt53/HzRY5gLqtS+DMBHNHcL0dCWZd4aKvfrTK8MlXOVLIuVY+J8hsG5tABfMmhe
 91QKj23nd1YefJNdKDbAf/bgwf8UyBbTHYBztDa71hFQturjActkM6ItfQpBpNXSj56FZrW+IpIcc
 LInx1G9Q==;
Received: from [2001:4bb8:180:7b62:3a1d:d74e:d75b:5fe7] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kMsNI-0004lw-7A; Mon, 28 Sep 2020 12:35:24 +0000
From: Christoph Hellwig <hch@lst.de>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 14/20] nvme: update the known admin effects
Date: Mon, 28 Sep 2020 14:34:56 +0200
Message-Id: <20200928123502.435373-15-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200928123502.435373-1-hch@lst.de>
References: <20200928123502.435373-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Damien Le Moal <Damien.LeMoal@wdc.com>, Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

A Format NVM command can change the capabilities of namespaces, and
Sanity does change the Logical Block Content, and must be serialized.

Also remove CSUPP bit for Format - it is not a mandatory command,
and we don't check for the bit anyway.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index bb630d5fcb9647..4737591c1143ae 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -968,10 +968,10 @@ static u32 nvme_known_admin_effects(u8 opcode)
 {
 	switch (opcode) {
 	case nvme_admin_format_nvm:
-		return NVME_CMD_EFFECTS_CSUPP | NVME_CMD_EFFECTS_LBCC |
+		return NVME_CMD_EFFECTS_LBCC | NVME_CMD_EFFECTS_NCC |
 			NVME_CMD_EFFECTS_CSE_MASK;
 	case nvme_admin_sanitize_nvm:
-		return NVME_CMD_EFFECTS_CSE_MASK;
+		return NVME_CMD_EFFECTS_LBCC | NVME_CMD_EFFECTS_CSE_MASK;
 	default:
 		break;
 	}
-- 
2.28.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

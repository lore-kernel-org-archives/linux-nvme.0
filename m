Return-Path: <SRS0=v2se=PZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABA1AC433EF
	for <linux-nvme@archiver.kernel.org>; Sat,  6 Nov 2021 02:09:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F34361074
	for <linux-nvme@archiver.kernel.org>; Sat,  6 Nov 2021 02:09:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3F34361074
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=gI3pVf2yiR5r/UEtG9xEBfrAQBOq8foMeThoRbLJKbY=; b=Biu2lq+3GVdgroYX8IidMse1yw
	O1S/OzLoU+Ic9rYmDbYDVhhzaSh4h4fGYswXATldl91DmCUgbTrwA9epJzK7e0Mu85Z5IfVCPox4h
	fCaxnoTh5PVjEDG6Zn71YCwvZHyOozAkMw6EhDh3JVN3hFBcBCIq7E1J7b41Ku84xxlSt/zxTnePt
	pI1sXuikdgQu7xVwE7QQ9bvuqT8v9NVj3tNw8bz9J8ZpV3L8moLAq2qBNjApA4hnk7dPqVKvkTcJw
	PCH9VQ/XXnaITtDi23OHhijMEl+qD3suggmIJspdLnMAn2p5EvxekQVrU02JUPKGjeTwegYVNhZiS
	2sIYLpwg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mjB8r-00CZLd-Uk; Sat, 06 Nov 2021 02:09:13 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mjB8q-00CZKf-0s
 for linux-nvme@lists.infradead.org; Sat, 06 Nov 2021 02:09:13 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8A8A7218F8;
 Sat,  6 Nov 2021 02:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1636164545; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=gI3pVf2yiR5r/UEtG9xEBfrAQBOq8foMeThoRbLJKbY=;
 b=nPqUMv49auVsiO6ac9F9VZud6lAO8EnqnPYWyo/i1jKns3bUoKdJYLuITP/TiJwRrW8tVV
 GOVuFbkmAdN7X7M3AMMsX3s14ZVadLQcoemsITq9pNcQ28bhO83ylaRrmGqff28tFVvXCQ
 WNT2vIoVGOZRuZ0CKOHM7KmOq0VKJ9g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1636164545;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=gI3pVf2yiR5r/UEtG9xEBfrAQBOq8foMeThoRbLJKbY=;
 b=dHX4a5zhXH9QJztD0665QVeRyJ0VbXgp55EiQgGLLfE5Uj7P+cq9o/E1gVv2GpLGz1dJ/3
 wKJ4fAYWPWbhuOAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1140413DA1;
 Sat,  6 Nov 2021 02:09:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id r9kwMsDjhWH7FQAAMHmgww
 (envelope-from <ematsumiya@suse.de>); Sat, 06 Nov 2021 02:09:04 +0000
From: Enzo Matsumiya <ematsumiya@suse.de>
To: linux-nvme@lists.infradead.org
Cc: Enzo Matsumiya <ematsumiya@suse.de>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org
Subject: [RFC PATCH] nvme: add NO APST quirk for Kioxia device
Date: Fri,  5 Nov 2021 23:08:57 -0300
Message-Id: <20211106020858.18625-1-ematsumiya@suse.de>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211105_190912_251280_0B79CE1C 
X-CRM114-Status: GOOD (  14.63  )
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

This particular Kioxia device times out and aborts I/O during any load,
but it's more easily observable with discards (fstrim).

The device gets to a state that is also not possible to use "nvme set-feature"
to disable APST. Booting with nvme_core.default_ps_max_latency=0 solves the issue.

We had a dozen or so of these behaving this same way on customer
environment.

Signed-off-by: Enzo Matsumiya <ematsumiya@suse.de>
---
 drivers/nvme/host/core.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 838b5e2058be..a698c099164c 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2469,7 +2469,19 @@ static const struct nvme_core_quirk_entry core_quirks[] = {
 		.vid = 0x14a4,
 		.fr = "22301111",
 		.quirks = NVME_QUIRK_SIMPLE_SUSPEND,
-	}
+	},
+	{
+		/*
+		 * This Kioxia device times out and aborts I/O during any load,
+		 * but more easily reproducible with discards (fstrim).
+		 *
+		 * Device is left in a state that is also not possible to use "nvme set-feature"
+		 * to disable APST, but booting with nvme_core.default_ps_max_latency=0 works.
+		 */
+		.vid = 0x1e0f,
+		.mn = "KCD6XVUL6T40",
+		.quirks = NVME_QUIRK_NO_APST,
+ 	}
 };
 
 /* match is null-terminated but idstr is space-padded. */
-- 
2.33.0



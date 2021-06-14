Return-Path: <SRS0=JVDK=LI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67DF1C2B9F4
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Jun 2021 14:16:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F35961185
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Jun 2021 14:16:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F35961185
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=bxwcV1HAXQlPCFLFtEgNLVsPiEtUV6hWcM3wJCC9eds=; b=yeGAZk/qA5GRML
	xriOypHHwDCNfm14JIB1PVBgvP6hw3hUNJY2udiQ9ErjWGwicOGL9vBWFRuwIzh5Lll8u/4UGrX7e
	mL9L16dwtpsOVIQ2pAjFEUc1bDgvK7+YvufyrWNEvI90wEwBVhemtINqgfuFJx14ZfO3qHGVy2HxA
	T4rHpReUtYg6OJGsNzKwCCEFzuQktqhLzuf03rHSBLdi1e2+HZJ2g4hAqqyw1Tjuqoqm+2vb1Lyps
	L7UAFUHp/+McTXOxC4zwnrXNg5DTtuzc9sXa8+Hk07bP16sfdV42026qmgPHFSUBxWl0+SME1MIpV
	GO9GjZRwxL+hDO0rnGqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lsnO5-00ETug-1G; Mon, 14 Jun 2021 14:16:25 +0000
Received: from xavier.telenet-ops.be ([2a02:1800:120:4::f00:14])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lsnO1-00ETsz-T8
 for linux-nvme@lists.infradead.org; Mon, 14 Jun 2021 14:16:24 +0000
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:bda0:7de0:767e:26f9])
 by xavier.telenet-ops.be with bizsmtp
 id H2G92500N4N5gS3012G9j2; Mon, 14 Jun 2021 16:16:11 +0200
Received: from rox.of.borg ([192.168.97.57])
 by ramsan.of.borg with esmtps (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.93)
 (envelope-from <geert@linux-m68k.org>)
 id 1lsnNo-00H8uV-L6; Mon, 14 Jun 2021 16:16:08 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
 (envelope-from <geert@linux-m68k.org>)
 id 1lsnNn-004jiP-WF; Mon, 14 Jun 2021 16:16:08 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Jiri Kosina <trivial@kernel.org>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Hannes Reinecke <hare@suse.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH trivial] nvme: Grammar s/each namespaces/each namespace/
Date: Mon, 14 Jun 2021 16:16:07 +0200
Message-Id: <d195ebc405033c1de6ca01937a906afc97f285f7.1623680137.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210614_071622_097085_447624F3 
X-CRM114-Status: GOOD (  11.37  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Fix a singular/plural mismatch in the CONFIG_NVME_MULTIPATH help text.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/nvme/host/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
index f76cc4690bfc37bc..26ddd34ae45b76fc 100644
--- a/drivers/nvme/host/Kconfig
+++ b/drivers/nvme/host/Kconfig
@@ -21,7 +21,7 @@ config NVME_MULTIPATH
 	help
 	   This option enables support for multipath access to NVMe
 	   subsystems.  If this option is enabled only a single
-	   /dev/nvmeXnY device will show up for each NVMe namespaces,
+	   /dev/nvmeXnY device will show up for each NVMe namespace,
 	   even if it is accessible through multiple controllers.
 
 config NVME_HWMON
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

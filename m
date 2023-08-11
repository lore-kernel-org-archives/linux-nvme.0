Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8173CC04A94
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Aug 2023 12:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Va1veEwDpJUEh5ATScwAqKgDyPffWib9gL4y5XoXAQc=; b=FjRQFUbGkFu4WIuqYPcud18MPX
	LiZAeuCKmQ8g2N/iYbCjAAiAOm7tCLQYa2WtA9KrEypC60IUAo0MFZ0xZ7Vt1uliP4hwaG7mbvl9G
	seH4oz2TdIZoMHUrIs9uGhBklJxWaLnKJKcri0pCONOugu9fXes4vTZKR6T+jOlPBmqotd1Gm6CjV
	aRIeulIT+NK30GiR/3ws6wwkH0vUvEBxdpaGrTQanCV7Uf9QDySeNvNq3MjsA55clKUMkxb/0wNzI
	SpFYftTgMmrpVyfjx6AEIyZC+OQzEY7l/WzxtfJIgZUDzd7X2M/r0Zx/Z2km3iNWSUZdjIBA2Cmnl
	Tl5OihpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qUR5v-00AZAQ-33;
	Fri, 11 Aug 2023 12:18:19 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qUR5n-00AZ1O-2E
	for linux-nvme@lists.infradead.org;
	Fri, 11 Aug 2023 12:18:13 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out1.suse.de (Postfix) with ESMTP id 100A72187C;
	Fri, 11 Aug 2023 12:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1691756286; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Va1veEwDpJUEh5ATScwAqKgDyPffWib9gL4y5XoXAQc=;
	b=Vdx3afmwc9JnwfCA94KWzwxdIs5LUPcBlC3IX0nNJ6pWGYCSK3Hxl9njDfz0wRmciutv37
	5GB5ZJaa2Ya4K0y4P/IBWgK96PkSXBMjIOi1/+Y74R9hN9hCiYWF4yvv4Dv5Zbqsmf39Wr
	XQ6hPW9LP58y0BPTS9fkDUVgzfKw5fo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1691756286;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Va1veEwDpJUEh5ATScwAqKgDyPffWib9gL4y5XoXAQc=;
	b=KiuS7gOfxPu4H2jJdNybCVFEe/4YvRSK2GVEXyRbE7z90oB00cJ3cInE58UAwyOjk+TlQj
	nmhaXlQKi6/6UdDQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id EE4232C149;
	Fri, 11 Aug 2023 12:18:05 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id DF8EA51CAEEC; Fri, 11 Aug 2023 14:18:05 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 04/17] nvme-tcp: add definitions for TLS cipher suites
Date: Fri, 11 Aug 2023 14:17:42 +0200
Message-Id: <20230811121755.24715-5-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230811121755.24715-1-hare@suse.de>
References: <20230811121755.24715-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230811_051811_875338_4B2045C9 
X-CRM114-Status: UNSURE (   9.02  )
X-CRM114-Notice: Please train this message.
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

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 include/linux/nvme-tcp.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/nvme-tcp.h b/include/linux/nvme-tcp.h
index 57ebe1267f7f..e07e8978d691 100644
--- a/include/linux/nvme-tcp.h
+++ b/include/linux/nvme-tcp.h
@@ -18,6 +18,12 @@ enum nvme_tcp_pfv {
 	NVME_TCP_PFV_1_0 = 0x0,
 };
 
+enum nvme_tcp_tls_cipher {
+	NVME_TCP_TLS_CIPHER_INVALID     = 0,
+	NVME_TCP_TLS_CIPHER_SHA256      = 1,
+	NVME_TCP_TLS_CIPHER_SHA384      = 2,
+};
+
 enum nvme_tcp_fatal_error_status {
 	NVME_TCP_FES_INVALID_PDU_HDR		= 0x01,
 	NVME_TCP_FES_PDU_SEQ_ERR		= 0x02,
-- 
2.35.3



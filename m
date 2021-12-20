Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBCCAC433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Dec 2021 02:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=FnlNLGKGqbU/bbShEDZpfaUsZK3qKr3E3lCY3X0yMQA=; b=QshqGML8GVj6snsyAY1VIByue4
	ZatJAx08mpuPPLw5xdxmV5bVctq9oSRy6MsByoZMboyi+LsG++CRY5kwC1RYOGhES0VK4KbIzUSg1
	waXEn+6Pi39rkmpawZzAGodVvbdtFtiV1GKSzltIP0VWVwZSoccg6VslZXndMbEuS8UvKBSe9G8oO
	qFELKeqVHDvphvoZ4Rz5Lsh/48C7OngjdiSBV6XS8guM8kW86LKhgKU6LTub3jAx/qHUYGiIspdca
	lsXCcxEfN1vzM76vLpkNN/AGBS4fZBxo9sqB8y/kWvvSxJKd2GvLxkeisu/6BEARw1joUJFGFi/jL
	I4b/qQvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mz8pa-000Hw4-7M; Mon, 20 Dec 2021 02:55:18 +0000
Received: from out1.migadu.com ([2001:41d0:2:863f::])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mz8pW-000Htw-MD
 for linux-nvme@lists.infradead.org; Mon, 20 Dec 2021 02:55:16 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1639968904;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=FnlNLGKGqbU/bbShEDZpfaUsZK3qKr3E3lCY3X0yMQA=;
 b=FDl4BX++V3cOczNgLZZT3pWY19cFvYoxiOuEyP0h1lTQKxuTv79qS27KGEXPS74XZD6ws3
 fQGQNK+q4VLfDFPB8jtzkF8Up6LKFYKV8pEgMTlftoLy32dI6wcH9EWD1IBQn2fs9+hliz
 SM1zREPXpwysLtqkJDaVBtVw2CA2dOU=
From: Jackie Liu <liu.yun@linux.dev>
To: hch@lst.de
Cc: axboe@fb.com,
	linux-nvme@lists.infradead.org,
	liu.yun@linux.dev
Subject: [PATCH] nvme-tcp: memset scatterlist before sg_init_marker it
Date: Mon, 20 Dec 2021 10:54:39 +0800
Message-Id: <20211220025439.3995260-1-liu.yun@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211219_185514_927003_9A220B00 
X-CRM114-Status: UNSURE (   9.96  )
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

From: Jackie Liu <liuyun01@kylinos.cn>

sg_init_marker's sg need initialized, otherwise report:

[...]
In file included from ../include/linux/dma-mapping.h:10,
                 from ../include/linux/skbuff.h:31,
                 from ../include/net/net_namespace.h:39,
                 from ../include/linux/netdevice.h:37,
                 from ../include/net/sock.h:46,
                 from ../drivers/nvme/host/tcp.c:12:
../drivers/nvme/host/tcp.c: In function ‘nvme_tcp_ddgst_update’:
../include/linux/scatterlist.h:214:16: error: ‘sg.page_link’ is used uninitialized in this function [-Werror=uninitialized]
  214 |  sg->page_link |= SG_END;
      |                ^~
cc1: all warnings being treated as errors
make[4]: *** [../scripts/Makefile.build:287: drivers/nvme/host/tcp.o] Error 1
make[3]: *** [../scripts/Makefile.build:549: drivers/nvme/host] Error 2
make[2]: *** [../scripts/Makefile.build:549: drivers/nvme] Error 2
make[2]: *** Waiting for unfinished jobs....
[...]

Reported-by: k2ci <kernel-bot@kylinos.cn>
Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
---
 drivers/nvme/host/tcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 4ceb28675fdf..8fd8cbe23683 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -348,7 +348,7 @@ static inline void nvme_tcp_ddgst_update(struct ahash_request *hash,
 {
 	struct scatterlist sg;
 
-	sg_init_marker(&sg, 1);
+	sg_init_table(&sg, 1);
 	sg_set_page(&sg, page, len, off);
 	ahash_request_set_crypt(hash, &sg, NULL, len);
 	crypto_ahash_update(hash);
-- 
2.25.1



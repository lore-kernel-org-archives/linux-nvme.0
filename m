Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83E2CC001DE
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Jul 2023 09:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FeucCTWY3gG3V8pGdjIYSKIVeCJT+wXrFGXeSDUwHv4=; b=aBRpQ8whNd4oP/CjmJtZH3gFTP
	Ppy2nxcsF4nPNWwBbd5ptzaHvPrQxhj5TYGeIH3WilWr+IvCkn/UXX5M8unWNxFF4xehG2JkG54q3
	xWttPkK2Qwf6RcG9qwGXjjb3xqP+0TWg3bSdwIXBs2lbBcAPj95PjOIpqSN4sLckQGQ0vmgf/fa4K
	BqeLZk7uKJ6POR/iPl5dLRW1QvP1ylm9hzFB/9qUx0FZ5NVl2A5IjAVsTk528Z5TEnVL7+Ti+F3Un
	PVBqt3RYjM4bygG0Qrg0D/abNUVbMS5/LdRWrgiXCEyKQ2Igd2cjSojlRRWADlW/Kzh1M39Funnx5
	HyfNQH4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qNrkA-003Nt2-2x;
	Mon, 24 Jul 2023 09:20:42 +0000
Received: from mail-lj1-f176.google.com ([209.85.208.176])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qNrk6-003Nnd-1o
	for linux-nvme@lists.infradead.org;
	Mon, 24 Jul 2023 09:20:39 +0000
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2b982322609so6302911fa.0
        for <linux-nvme@lists.infradead.org>; Mon, 24 Jul 2023 02:20:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690190435; x=1690795235;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FeucCTWY3gG3V8pGdjIYSKIVeCJT+wXrFGXeSDUwHv4=;
        b=bO7IOwfx94g6mjKJKWiEmvPLxEFBa1n2cTgMFPav9mNKGWc1TRqyMWTZ+vzxsZFjG/
         rf6Rv1w/h/74JkQSrw03o3x+jQ6JqrXK3D8mog648S9Y0aho29gmAiOIGM3aE4o7ITYQ
         rD09Ya++PnprzmDO/0FyJYVjyO5dcfBwu7YrTazOgRCXjJp2CXdwgi+fK8+m5aIPFTY3
         YYIwBjXRcQOH/Ry9aqJ1vQtVrCJdBSC1xP8wZrpx607RmvL6XulYQ2Xylszhc6uWpgIQ
         sKIUlDesHJQ0AaUuHQKxT0gaJbqMcO55G/QAuFLrUIh5x+Rad+/e6m5PZ7cD58rzPZQ/
         63VA==
X-Gm-Message-State: ABy/qLbS6RIOIMp3w6jNi6CRR04YJ5TjAFtMRiIVCLFITjjKox0R6Bzf
	5FjH0zDds1IWWt1uSfv4B3IZH22fCdg=
X-Google-Smtp-Source: APBJJlF7/ErdOQnqoBLBkwBIYsLFnUY9qJl9RtgbbXB0pAf5WqUTdDzBjS5xFZAoHHls5d0v+x+uLw==
X-Received: by 2002:a05:651c:10a1:b0:2b7:3a7e:9e89 with SMTP id k1-20020a05651c10a100b002b73a7e9e89mr3452506ljn.2.1690190434925;
        Mon, 24 Jul 2023 02:20:34 -0700 (PDT)
Received: from localhost.localdomain (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id x21-20020a05600c21d500b003fb41491670sm12354052wmj.24.2023.07.24.02.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 02:20:34 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH rfc 6/6] nvme-fabrics: expose support for traddr as dns names to userspace
Date: Mon, 24 Jul 2023 12:20:22 +0300
Message-ID: <20230724092023.708335-7-sagi@grimberg.me>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230724092023.708335-1-sagi@grimberg.me>
References: <20230724092023.708335-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230724_022038_596305_690D3FC8 
X-CRM114-Status: GOOD (  11.21  )
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

userspace needs to know that the kernel is capable of doing a dns
query, so expose a custom opt called "dns_ip_traddr" which is not
an argument, but rather indication of support for dns names for
ip based traddr.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/fabrics.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index fadd25538d1b..6a7e8cbdaf69 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -1331,6 +1331,7 @@ static void __nvmf_concat_opt_tokens(struct seq_file *seq_file)
 		seq_puts(seq_file, ",");
 		seq_puts(seq_file, tok->pattern);
 	}
+	seq_puts(seq_file, ",dns_ip_traddr");
 	seq_puts(seq_file, "\n");
 }
 
-- 
2.41.0



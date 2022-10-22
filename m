Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3BCEC04A95
	for <linux-nvme@archiver.kernel.org>; Sat, 22 Oct 2022 17:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=kA1RUYYc/4X5sRFnjwWDavrb0+igVW51vZRNo+KLENo=; b=osmcXMQvVHu/Q27TjAcEtXZMDl
	ySiwpeiXamfgseg+ggT6CmzZQFCIv935mUsGO+ptBRepCXWXHOoaOWLTwLD00+YGGTIct4tRa3a0c
	MC2UmVIVjzY+dkgLVN+rLotpTOrAKB6pbhB35WRsKLlxtj7QyGEu0Dn9762oKWF6BxR1tta8FlG3I
	ozsukNcL2GahlM5lmjO7+yYwxkTQr8/ME4Dlvi6MKnwrHeGgjZPz2gdaMY1XH5O/98TqYdGEzTIQL
	p7iJLqd1Ed86fzkHiRBkTwBu/rlT6E6gQWRQMxkLyfuAGGvBBU2TxW2F7VhTF13SDh5w5fPDllDkj
	7q8qjx/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1omIbh-00DRJM-GD; Sat, 22 Oct 2022 17:48:25 +0000
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1omIba-00DRIb-IX
	for linux-nvme@lists.infradead.org; Sat, 22 Oct 2022 17:48:19 +0000
Received: by mail-ed1-x52d.google.com with SMTP id a13so17116748edj.0
        for <linux-nvme@lists.infradead.org>; Sat, 22 Oct 2022 10:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kA1RUYYc/4X5sRFnjwWDavrb0+igVW51vZRNo+KLENo=;
        b=pk1JPaO124kD9FUXsMNgIuLUnQeM7DtqHs1KwuFroXIGt6EGsnRBXLTXcE0liY6YNM
         QR9Z3txWC80+cz19T4MJOkXDvE2bf8gO4lrGGFyaq4hPGBH3/ZA4Hj6mNzhuvdnaEAea
         dtcwslJnx/X2Fl80CsqK1QTxyCuGNyA3KmtpcMeXJhpDADzfdLIj1scB6BS9ixy4uQKj
         jIQxALXTWuEBXMZloxPF861qOIXYfsdtiJbJF9ipavXB/43RBhmxXatbjtONQEXEgRgG
         W0Z6i7wt7n+9KtVHRCfuqUrjxY2+gxsWUWE5BgwueYwNvGUZEnGO05kr+8ao873HagD2
         8lPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kA1RUYYc/4X5sRFnjwWDavrb0+igVW51vZRNo+KLENo=;
        b=nBeEDfujTq3i0aqka/CFdI/RLilQhwSCTYnrn36lnT/M6Dvc+QiiWWI5IvnxsG167C
         lhZhaq3yX3IYopXgvq6G85dpUZyhuyWyQHamkZN0IUKTuIU6bEIH+X5OHzmOOQ1cuL6Q
         jb9fjnUwl0XKyj6wtpZ6E/dmoait+GlwAwLAAJTmWHy3FFJkzsu5iOXbJjKMikTVzymN
         9aYjnWoJ/Xo24TOdmsnoL32JKZdAS85jBA3dArC/rQM3sYW9YJw93eajD8F5iNYlLKiF
         rjAXSoxt+7Z2q0sJ/fR5Eh4QtsDNpoSUkOY1eBs04ooR8uDlPUp5h63dWijb0Q4zOTz5
         P4xg==
X-Gm-Message-State: ACrzQf3/rUCAIOCZX5TF93DkuBnRMmkbYgIxvsxXjullNvnwEkoYeDtS
	8RWEPo/Ka5WMn9uAf1HOD9E=
X-Google-Smtp-Source: AMsMyM4SZU4916e1mjGvrI/QPalwjrfgQvBYyCvFSL8mRnRuFa9koJtArq77o9k2/1EDQWi8zrqhdw==
X-Received: by 2002:a05:6402:520f:b0:45f:b7a0:a31 with SMTP id s15-20020a056402520f00b0045fb7a00a31mr15742960edd.379.1666460895540;
        Sat, 22 Oct 2022 10:48:15 -0700 (PDT)
Received: from localhost.localdomain (ip-217-105-46-178.ip.prioritytelecom.net. [217.105.46.178])
        by smtp.gmail.com with ESMTPSA id r17-20020a170906351100b0078d4962a46bsm13054235eja.190.2022.10.22.10.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Oct 2022 10:48:15 -0700 (PDT)
From: Nam Cao <namcaov@gmail.com>
To: kbusch@kernel.org,
	axboe@fb.com,
	hch@lst.de,
	sagi@grimberg.me
Cc: namcaov@gmail.com,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] nvme-tcp: replace sg_init_marker() with sg_init_table()
Date: Sat, 22 Oct 2022 19:46:36 +0200
Message-Id: <20221022174635.15643-1-namcaov@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221022_104818_649005_C1ADB89B 
X-CRM114-Status: GOOD (  12.67  )
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

In nvme_tcp_ddgst_update(), sg_init_marker() is called with an
uninitialized scatterlist. This is probably fine, but gcc complains:

  CC [M]  drivers/nvme/host/tcp.o
In file included from ./include/linux/dma-mapping.h:10,
                 from ./include/linux/skbuff.h:31,
                 from ./include/net/net_namespace.h:43,
                 from ./include/linux/netdevice.h:38,
                 from ./include/net/sock.h:46,
                 from drivers/nvme/host/tcp.c:12:
In function ‘sg_mark_end’,
    inlined from ‘sg_init_marker’ at ./include/linux/scatterlist.h:356:2,
    inlined from ‘nvme_tcp_ddgst_update’ at drivers/nvme/host/tcp.c:390:2:
./include/linux/scatterlist.h:234:11: error: ‘sg.page_link’ is used uninitialized [-Werror=uninitialized]
  234 |         sg->page_link |= SG_END;
      |         ~~^~~~~~~~~~~
drivers/nvme/host/tcp.c: In function ‘nvme_tcp_ddgst_update’:
drivers/nvme/host/tcp.c:388:28: note: ‘sg’ declared here
  388 |         struct scatterlist sg;
      |                            ^~
cc1: all warnings being treated as errors

Use sg_init_table() instead, which basically memset the scatterlist to
zero first before calling sg_init_marker().

Signed-off-by: Nam Cao <namcaov@gmail.com>
---
 drivers/nvme/host/tcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 1eed0fc26b3a..dc2def86076d 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -387,7 +387,7 @@ static inline void nvme_tcp_ddgst_update(struct ahash_request *hash,
 {
 	struct scatterlist sg;
 
-	sg_init_marker(&sg, 1);
+	sg_init_table(&sg, 1);
 	sg_set_page(&sg, page, len, off);
 	ahash_request_set_crypt(hash, &sg, NULL, len);
 	crypto_ahash_update(hash);
-- 
2.25.1



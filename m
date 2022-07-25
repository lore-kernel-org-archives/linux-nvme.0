Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEB80C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Jul 2022 19:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Nc5mbsO5EttJg9jLfbncA0LC8WA877dNDwcrS6YgrRk=; b=w7OKNEqEQizAzy/dlR5lk+ifQu
	+oi81IKxdfDeZyGDoahXN4ONkwKHovSfmNLIZrUL5c0YC2X1Kk/p+FFzME8O2cku5CzKi1nCwljeb
	TbGKlyKL5Glih8A6+aLbg/UZS1IlxdhVVDHxF+dk6Mcy3efdo4Rcjj1KGQl/FTMKgG62JWAk6rkAA
	TkGjMa/8qybZKyfyJSxmMfV/Tp4uJ+EhgNTFb7KJePsuOQkHpQsnNmWbgi0TZOLjcFTyQDKnzs5AI
	IZZfGhU64AnhR1/kL9Q5FFTtM9L6gsbZJWrmI/KxnHDuas3/yHJS5NEp0uZ2zeofvFtEMgHiBWugA
	yoCCRkIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oG3aa-000IGI-Pu; Mon, 25 Jul 2022 19:18:00 +0000
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oG3aX-000IFb-Mn
	for linux-nvme@lists.infradead.org; Mon, 25 Jul 2022 19:17:58 +0000
Received: by mail-pl1-x629.google.com with SMTP id w7so11267291ply.12
        for <linux-nvme@lists.infradead.org>; Mon, 25 Jul 2022 12:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Nc5mbsO5EttJg9jLfbncA0LC8WA877dNDwcrS6YgrRk=;
        b=YGNTSezmamE1TT1D0qah9lrebCAcP5hMFvzA1C51qcpj99nL5Dty7RDEpPoUuDlJCc
         ZS4Yh1J/3pdxcEITiF81+Qwk9HWEgF2NvKTNRQb8jCtGFSuv+j0UqReUu5F4xVzqgwXF
         WOnP/ikqDjbbBrwZuJrBaAG8U/iRU6DyYhRX8CCi3fmbFlkjFkboKCsmMIn3rW0FxMb6
         qWBA9kwVhdlzIAWRcQUTQbXRxmGLDCzhjGAMepi5fAsD6riRSMNupiIgQbtyMaR86IHE
         9ogteqHyRL9JD85ArX8hoa5poMe6PXVXbzBrUK7jhOmTF0aQCz6g/hdGuKUOMRWX/pos
         sj4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Nc5mbsO5EttJg9jLfbncA0LC8WA877dNDwcrS6YgrRk=;
        b=lI91iR3911fQSJ14b+Ho3bbmq69CbiSnRkTAT3ez/BAWS2BH/6/b+lHPVdtUAlCDOk
         AmnKJQFSR4VFW72wh2MJXL7/nao2pJOaHg7gF1b1QDFztbPFO7wSa4sOKzdcZCqLwx2L
         6BVDCLIFpsXNrEpeGQ8JYPR+d9o2BN4jsxdiV6ep2TwAUu1WXhmB0LJIFX77U6DQtHsg
         g6nJMTWwyPx0qqBjQOJ+FGN1CSJ6DS0pHz7PLJxs9mXEJe/zT90VzNoko1KQR8m9o06L
         5zmoaJLb3HwQPl6T7OORe4OjX4+QYk0A8bA96hYVnUYl9CCFECr+vg1DeuO+8UpwRrOb
         QIOw==
X-Gm-Message-State: AJIora/p5h3FLwsKAebo8sp+fE+2Cq8GyDowuyGaZs8C9PMpYk2AD6uh
	No59PtY9ISPreDUTZo/DBT0=
X-Google-Smtp-Source: AGRyM1tokQVnjdAkIgGb+KHxxfOdpkJirYK+Db287xsHtgvpecF+UVkPIkV897mcVVdjkpQbhEqOSg==
X-Received: by 2002:a17:902:8346:b0:16d:1fb6:3e9c with SMTP id z6-20020a170902834600b0016d1fb63e9cmr13031261pln.28.1658776676149;
        Mon, 25 Jul 2022 12:17:56 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:401:1d20:29f7:d008:e76a:7fb5])
        by smtp.gmail.com with ESMTPSA id y22-20020a170902b49600b0016c5306917fsm9608075plr.53.2022.07.25.12.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 12:17:55 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH] drivers/nvme: fix pr_warn format string
Date: Mon, 25 Jul 2022 12:17:51 -0700
Message-Id: <20220725191751.960838-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220725_121757_764862_B7328E46 
X-CRM114-Status: GOOD (  12.78  )
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

Use %zu format instead of %lu to print variable of size_t type.
This fixes the following gcc build error on 32-bit targets:

  error: format '%lu' expects argument of type 'long unsigned int',
  but argument 3 has type 'size_t' {aka 'unsigned int'}

Fixes: 71ebe3842ebe ("nvmet-auth: Diffie-Hellman key exchange support")
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 drivers/nvme/target/auth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
index bf92435c783c..716a10ca91d1 100644
--- a/drivers/nvme/target/auth.c
+++ b/drivers/nvme/target/auth.c
@@ -488,7 +488,7 @@ int nvmet_auth_ctrl_exponential(struct nvmet_req *req,
 		return -ENOKEY;
 	}
 	if (buf_size != ctrl->dh_keysize) {
-		pr_warn("ctrl %d DH public key size mismatch, need %lu is %d\n",
+		pr_warn("ctrl %d DH public key size mismatch, need %zu is %d\n",
 			ctrl->cntlid, ctrl->dh_keysize, buf_size);
 		ret = -EINVAL;
 	} else {
-- 
2.30.2



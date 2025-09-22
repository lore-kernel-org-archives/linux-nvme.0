Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 156E6CAC5A7
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Sep 2025 12:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=dVvWcx5WcGi28INSLgwKtPHgGGxPOXbbr75GLCOqJv0=; b=vHk/l3kj3pevCcLfd5NQ2WayAG
	qDw5AULE4Q69vdZRgnpZxGssE5We5d/3YD4JhO7p/lIBeMduGDQm/3tMgKNX2nca4zKUBC49Rbfd9
	0V0JHquMS+yMp2NVe96KM2AtUT/ZV4phHukQCbGMBI+BCD0Cfq5DQNdV5BFIVQYN/ZY7lUmOGEYEk
	fZsx0ZEriR2G56ZgIguxDbOv7jLjUovHBfMZY52jukfBNGmpb3h5z/+j1VrQBalEtBkeFcQIns92g
	I+X7HhfyOXMTkyFDtyvLa0yvQzfjvfotBcMv++rAfprbYWHo9iVjizgUJIxYBBhKQcK+WR412XSTe
	Sp4ynKRg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0fIt-0000000AHag-3Sjs;
	Mon, 22 Sep 2025 12:05:59 +0000
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0fIq-0000000AHZu-40L0
	for linux-nvme@lists.infradead.org;
	Mon, 22 Sep 2025 12:05:58 +0000
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-b55115148b4so2673981a12.3
        for <linux-nvme@lists.infradead.org>; Mon, 22 Sep 2025 05:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758542755; x=1759147555; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dVvWcx5WcGi28INSLgwKtPHgGGxPOXbbr75GLCOqJv0=;
        b=WtrwWBb3HgSaEoN0lng/QNH+/QcD7TjL8KML7hEUVbYi+dBu1QdbVo8s7Cqar1/y/T
         1WPHULv9td4lUbFfeAiEyXddPwtsuD9/yj7N+UQ3jdWh/uoYfsEbT/44e1unHZklzGW2
         ebj6q+T9a225gF6vG/Ubkom0YEG6rnc/aWEuU1LcrhpSgIaWNzkafhLYyTAn1j+V7yQk
         8Zc/X4m3KAoMr5INORCmXrbDjPHp1jJU/2o1iQ4iO+eZohPCvFlsvKEBMUVWZR2eQyuV
         h2LLjOMqYG4oF/D9SdA5m5nHcIwvBZ5LoQPUssejq8ErM4BiJsBbY/vNVYoluJXKf9/I
         0dTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758542755; x=1759147555;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dVvWcx5WcGi28INSLgwKtPHgGGxPOXbbr75GLCOqJv0=;
        b=aQhKLNLASVlndJjidlUjpSswB7Af37WpLUE9iPW5TxmWpJxxvpgHnrlYd56v2Fk/6q
         gH9YrdNtSnvCc3GJIkjQ5NtL6b7TEw7OUhNi+Bwi2BIsd8j5lAo8sDag8GIZ5uxwtwY0
         crALTQoOL0fF+bMq0ybYYFF+jQeptxc4rHr0pNknKYhodj1O9TVKd7Til9BwOuOagXPS
         I7PhOBwYb97htqrENBdcEm7n2HS0KIbd6YdiX9U/dp7CSaiI+sKWaERqC0XZwYA0VwKp
         +JLd0JIOct7S2PVGeUBRQNt/jzfGQ6Acy5WifficfHFX7JWFJ8QO9UJI/t7132UndYXb
         7Bpg==
X-Gm-Message-State: AOJu0YwSx9DhLBAL1mz3DGdT3jxS/NT22fGgtxEU5H3yukzclDC2dZpH
	hKAKQk3en7IYFZZxQloLBQXXqJELLL9KIXZ3JJQZUaWLB6WGJFrv4cDwpt4eYQ==
X-Gm-Gg: ASbGnctB+e+xhooDawOBDLPRHP52OLk9jsUiu2tFGCwbu0p3Raj7MpwPdBquDLaCm0I
	IY7A1FZre8vf4tydUOZ8yoPcFbf3nRHsC7dJYWYC7ExLXW2ASzyZPOF/6T4Rf+S2sR2zArWWVuj
	7n2YKP3Ogp0b+LnYCEWLF63Esq7YkQiTWQKdtV8XxKjtzO+ryW+pNxXSNryYOz9el7qMzJ0TcRf
	q8SmGdCnmxEq6UMjjJCl5/jjOyK5yf2tiOEWtDoVBz/T9tVOBjEJxRqhjVft3qamviWTWHNbPsM
	uU+2tKsswb9JrdMqngY/sCWeGFn1uGknGSBx2NbXtoGzYL5I8HVzqUCav2mkTS6vO8le9ZSas/V
	EWtcyMc4vlcK+w7Lq/riZwbHHwPTjrv4E9EtfDn/bJwQjfQ==
X-Google-Smtp-Source: AGHT+IFJl/C47UymbJKaGOTYeh89qHiRYx2W3BTMXfUCyvlvy37FY0mI5+FgJUW1YDVrN0j0w7DyTQ==
X-Received: by 2002:a17:902:ce12:b0:274:5030:2906 with SMTP id d9443c01a7336-27450302a03mr78393125ad.46.1758542755208;
        Mon, 22 Sep 2025 05:05:55 -0700 (PDT)
Received: from gooner.hq.netapp.com ([223.185.129.8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269802df76dsm127985345ad.74.2025.09.22.05.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 05:05:54 -0700 (PDT)
From: Martin George <martinus.gpy@gmail.com>
X-Google-Original-From: Martin George <marting@netapp.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de,
	kbusch@kernel.org,
	sagi@grimberg.me,
	Martin George <marting@netapp.com>
Subject: [PATCH] nvme-core: use nvme_is_io_ctrl() for I/O controller check
Date: Mon, 22 Sep 2025 17:35:32 +0530
Message-ID: <20250922120532.3754-1-marting@netapp.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250922_050556_991038_2F3FD26A 
X-CRM114-Status: GOOD (  12.58  )
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

Replace the current I/O controller check in
nvme_init_non_mdts_limits() with the helper nvme_is_io_ctrl()
function to maintain consistency with similar checks in other
parts of the code and improve code readability.

Signed-off-by: Martin George <marting@netapp.com>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index edfe7a267a4b..a46f0f2d1c37 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3370,7 +3370,7 @@ static int nvme_init_non_mdts_limits(struct nvme_ctrl *ctrl)
 	else
 		ctrl->max_zeroes_sectors = 0;
 
-	if (ctrl->subsys->subtype != NVME_NQN_NVME ||
+	if (!nvme_is_io_ctrl(ctrl) ||
 	    !nvme_id_cns_ok(ctrl, NVME_ID_CNS_CS_CTRL) ||
 	    test_bit(NVME_CTRL_SKIP_ID_CNS_CS, &ctrl->flags))
 		return 0;
-- 
2.43.0



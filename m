Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11491EB64D0
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Jun 2023 17:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=WN82Z//hA8DCGnigkJsaIDeW/GJCYIky/AxnHlgXepY=; b=MvYap19C5yqdE4fhqIXhyKe7Vl
	dGfAtrt2n4dALdRqaFaTmrJ+sz4kdLbdnk/sn0f/kHqeVoH6fcmwHosyjA/4XKxz1wI8533cgHPlT
	r+4xsmRV7RYGVHjHgymwyHK3fUUwsTmsQyXj5LPjy2aa4rIQLsf7L1KGymfGO0u4yMa50vpc+swLs
	wSYL8J+E2TDzQNu3heUUYJzrR92sUQKili5bgw/ds1FlNnC3bOozR0nhu6xxmHgrLGWgJ/ofORKyY
	Q1vmAtVvMdU8Q0mTCbPJIerhFPXAogdnUE3f12dyR7bVTD6VgaRj6Yfo2eXDoajs/OYwUk/Aa63Kn
	Jiow0opA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q98GY-008mWi-23;
	Tue, 13 Jun 2023 17:57:14 +0000
Received: from mail-wm1-f51.google.com ([209.85.128.51])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q98GT-008mW6-2r
	for linux-nvme@lists.infradead.org;
	Tue, 13 Jun 2023 17:57:12 +0000
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-3f81b449357so26226595e9.0
        for <linux-nvme@lists.infradead.org>; Tue, 13 Jun 2023 10:57:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686679026; x=1689271026;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WN82Z//hA8DCGnigkJsaIDeW/GJCYIky/AxnHlgXepY=;
        b=UD7NoiNEof24izmqJlnwyY2Wb20mub1+/PfWgQpSh96SkP89OoqH/epzpXGSCuGO32
         CB6DgJDUNgNpGMbS+SPdfZUZcwv9A1w9KadWkv9uBeHtSBf93+K00a6LNlBx4LVS7rHe
         GCHb7htrSaIzRfyASDNlzX5wgwjDUm3zFGDwv778x9sPN+Q/Vu7DbocwIVwGdP6r6Qms
         jfouhRfuB/UJZ/OxIFbcVqcKVvtJ37XBih+VTf+T9debmIY751WqKz2WrRsAgE45LodB
         77XMD8YJ79IMkWm18KJgNKnTYt5xPZWcTlfdho4zovuPXEaKqYyLfF8T124PvqZYIJV6
         0k9Q==
X-Gm-Message-State: AC+VfDymfi2+WsU4NSEbLnxZ6K7CjDsKTSwDBtPjrIwBZIJjHpJfH9fL
	DfXsoduuHAS9whLESPfOD8o=
X-Google-Smtp-Source: ACHHUZ4SvIkjRYigE3R7EfXa2NFlEKkpMNeBI7KHYvVwGTof6n1wmdR157IKfm7DOfWOMvfDXj+mQQ==
X-Received: by 2002:a7b:cc84:0:b0:3f6:476:915 with SMTP id p4-20020a7bcc84000000b003f604760915mr10289073wma.6.1686679026365;
        Tue, 13 Jun 2023 10:57:06 -0700 (PDT)
Received: from localhost (fwdproxy-cln-116.fbsv.net. [2a03:2880:31ff:74::face:b00c])
        by smtp.gmail.com with ESMTPSA id e8-20020adff348000000b00304adbeeabbsm16029549wrp.99.2023.06.13.10.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 10:57:05 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: leit@fb.com,
	linux-nvme@lists.infradead.org (open list:NVM EXPRESS DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] nvme: Print capabilities changes just once
Date: Tue, 13 Jun 2023 10:55:37 -0700
Message-Id: <20230613175538.331639-1-leitao@debian.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230613_105709_949135_02C895B8 
X-CRM114-Status: GOOD (  13.28  )
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

This current dev_info() could be very verbose and being printed very
frequently depending on some userspace application sending some specific
commands.

Let's turn it into a dev_info_once(), since it is not useful to know
about it all the time.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 3ec38e2b9173..459e5a84e596 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1134,7 +1134,7 @@ void nvme_passthru_end(struct nvme_ctrl *ctrl, struct nvme_ns *ns, u32 effects,
 		mutex_unlock(&ctrl->scan_lock);
 	}
 	if (effects & NVME_CMD_EFFECTS_CCC) {
-		dev_info(ctrl->device,
+		dev_info_once(ctrl->device,
 "controller capabilities changed, reset may be required to take effect.\n");
 	}
 	if (effects & (NVME_CMD_EFFECTS_NIC | NVME_CMD_EFFECTS_NCC)) {
-- 
2.34.1



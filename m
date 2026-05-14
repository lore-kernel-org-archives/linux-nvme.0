Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDAE8CD4F39
	for <linux-nvme@archiver.kernel.org>; Thu, 14 May 2026 12:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=1mOb+TPDTl0fQa5/hkU2v6gAp5LJjCUHg1aRjdDAAoU=; b=LVW0FHdqEurXrsVj23BXeV2brA
	8+drE2jNUZ+ZnPHAlr4VUIoiIIrjtZnmo8TyDE3tknH1G9ubZ86b4yH+WIk+XcsBPNraUoCfBgW4u
	1ZfPXr8QKMQhZXaisHde5O1FoOMFEH8WnrdiSBR6jadJL4YzmjbUAqA9TZwTl7iLB4Ny2KaXVHNvb
	MzOpSTYEYm09BHvqrxauMWDrQZ2WW9ntt6WNndKIl6a/XNd1ixkkQHQcWQyLsNy/x7703GhUTANpQ
	IbXFehPqTgqHzfQB4+R9ywLZT7hTE4HZ3xdCAXRahne6cbNxITG9KjZ8im/qHP0u54KHsEQKhdlmE
	St25q0Iw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNVaw-00000005Wf8-0V5M;
	Thu, 14 May 2026 12:55:18 +0000
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNVat-00000005Wct-3TXF
	for linux-nvme@lists.infradead.org;
	Thu, 14 May 2026 12:55:17 +0000
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-3665b67ed66so4200924a91.1
        for <linux-nvme@lists.infradead.org>; Thu, 14 May 2026 05:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778763314; x=1779368114; darn=lists.infradead.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1mOb+TPDTl0fQa5/hkU2v6gAp5LJjCUHg1aRjdDAAoU=;
        b=Y4JL8HcnwbqJG+f1qNDu1dQ8/Nf3wejedsE6FR+5/3nWEWdB68O7J1HPOSSAGn3Q0a
         7/apWV1L9CnpzuWfRZMTw8H6Z7K9A3JQeayRD+3TgxHFR5Fz3GlC3QdNJxGaYBQPIqX3
         ZpEthZIpXocyK+qRLXQiLv99aS8FBoaEwuppcFC9o/EkjoFO2QDSmtUCsNuUa5/u91uQ
         yD6gTDuqhbBJunUjJ+ukXTgYpZ2/E5lKSHm8x5lLYCKrzlafBu2LokvEYlP/vMAHaBFv
         2Ss+3hXq8iZC7bPRreE/NwV7KTYhFFVxP9pDrPFnFGqjdmXuSiVqrshZbL4rgiA/H9VX
         q4mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778763314; x=1779368114;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1mOb+TPDTl0fQa5/hkU2v6gAp5LJjCUHg1aRjdDAAoU=;
        b=mAVQCUavq7mXkQUWTVT0bd1xiR5igR8lxtB0lPUEWcAYUOXi9W9wLQOki0036PHW9b
         tu/IOXIxh61ipV/R0+o3Lo7o0usQFse9TZ+1LGkL3WuZVFPuNTn1PFh5ny87xNgKUXj/
         0FxEU+7Bn5QNkX3FmmwcIEhoFhPSY+ecfu5mxxiyLJSno0CBUNkNr4UP0kWYLzR4jz23
         9Ki51vT0j/KgKMPr5qdqn1H7tKyjOcRkUYAvH6nadRMlAdFMx+OUqMQtQB42m5fGiXU/
         BIBuEeZO6uIdPFfMhN7yd4XDNTYtcMgxwGgFuRgtyRbYJo5TVw3Evb4/dPxCphWhrxUr
         N3TA==
X-Forwarded-Encrypted: i=1; AFNElJ9BrxAlLMXZnbkDx0OhvnoUC1a3kimI3CEX/IonmEIzYld9bccjgVUmKGL0GvR2/hji/ZDjwK34ubIE@lists.infradead.org
X-Gm-Message-State: AOJu0YyIvYNS/Bdk4anbh0qXrkkIVtKGe2i376bKhTzgFhBqgWVtR20Z
	bJcNmu60MgP3XzWI3n02yl4pZYNSNt4oUio1h8ATsuygex2wd9ni94Oa
X-Gm-Gg: Acq92OHETZzJdflzfkaV8wF1bHQp0UdjZcO8sLc3Gag85p+oNfjzr+ZR8PYn3932Pr9
	cy7ojj83ibUDUILqhGp35sBvywUYjY2xLSN54Pry2JTXZr3Cz6QLCjYWrnkSbQdD7gCy3p4N53h
	WBMIB1GhONQ6/cP+SYoxY098Ox4a/sdW9C7E5mUKrQAEWD5KP1tpM44WnFWinGLPku1AxaaPuZ9
	TED7mENLoDmQM5a/6z3gO6I+KH9aLREnFp0vP31wMeWY9hN21asD3HOmUJh3AgujKrLarh7Cxmp
	TFeEJSxfstJR5tXU1GnvdKmbio2YiAAqVfn0ZPgKmW9U5AKJyMKrTDY3TVPq7psQ53zRiG5GXD6
	ztz3uWQQXSwOGNHE4DQ4ZoB7+ee0q85fT7aAo6r3U8jXaYBTVh5hi8FE8olIMTwaqszjwN1Bs0Q
	14BHsYG1fiTE/BnG7egLPQyRSRYa61xgMzLj8=
X-Received: by 2002:a17:90b:540b:b0:366:4a47:f267 with SMTP id 98e67ed59e1d1-368f3d25591mr8265697a91.16.1778763314268;
        Thu, 14 May 2026 05:55:14 -0700 (PDT)
Received: from [127.0.1.1] ([59.188.211.98])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-368ede204a4sm6464784a91.4.2026.05.14.05.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 05:55:13 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Thu, 14 May 2026 20:54:59 +0800
Subject: [PATCH] nvme-apple: Reset q->sq_tail during queue init
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260514-nvme-apple-sq-reset-v1-1-8931e455281e@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDU0MT3byy3FTdxIKCnFTd4kLdotTi1BJdU+NUI6NUC4tk8yQDJaDOgqL
 UtMwKsKnRsbW1ABy3rQtlAAAA
X-Change-ID: 20260514-nvme-apple-sq-reset-53e22e88c7b0
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Neal Gompa <neal@gompa.dev>, Keith Busch <kbusch@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Yuriy Havrylyuk <yhavry@gmail.com>, 
 Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=910; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=nn573OmNpZxrFI75wUW33iuDsPMZUxrP0CYhUYOBpec=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBqBcYnd58loG/sMZgnDZXeeue5linXTCbmSdFv7
 Usj8arhSQKJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCagXGJwAKCRABygi3psUI
 JE8sEACSOkv0EB3TanSxWricudH11RnYjW39i89ufhg2B/KmfgK6LwCcWQlCS88vsW2iMGH7C76
 jViheEwfPWQoZqBtU3rTlXpOVbxckR2wovC71lItN8M3LCZ8pbWlh4W7MH4bzV7L7cSxBzBxGfK
 vNRFhGCI5hRheRFMOcTNQ7wVUqQXMYfEoss6qaxUZJcUwtq4lA6zsVGov9uGyMhxACrDZn/OtkG
 p3E+Ew1PYIikq40kUgX/2D6+wlmv32nho4ZX/SchpQJOpesTa5IY3mfW998qY6TuW6lDfSFPvXG
 AGPnBsEh6EChTa7vlkwjRhOegY0rKM0WcVy3RUYd8nGoeyrD61W5GAjSH/iuNG3PUWIPOoZCZwS
 bnjMn4Z0N3ivYg9Ce87FNy2Huiq+13T7geSfxZhbRktPjsvNtku3X9H5w+l6Lr487cG7m8hVDN7
 ISYLTNhdKCWWrT11/J212YFd+F2902x1QhhSbZoGa75UACZ3iYtD6IHMIR9chRj/FFcKKkKAVwb
 vZVb1urcw94MuuJlZGZy/RE7CMpADRgx2zQU69YRcp/zPOufafs2ffge4zm98IEwClXrVwP8a0S
 Hb89KP//znnoY53t0c6L6RTTxOUrE9uNRkSy4EeVYr113m7OV/tqdC8zMlY+LMOnqnPbB2WMOPB
 KD7ZiDqGTRNh0BQ==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260514_055515_881399_586FA45C 
X-CRM114-Status: GOOD (  11.26  )
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

Fixes controller reset on Apple A11 / T8015.

Fixes: 04d8ecf37b5e ("nvme: apple: Add Apple A11 support")
Suggested-by: Yuriy Havrylyuk <yhavry@gmail.com>
Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 drivers/nvme/host/apple.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
index 423c9c628e7b..c692fc73babf 100644
--- a/drivers/nvme/host/apple.c
+++ b/drivers/nvme/host/apple.c
@@ -1009,6 +1009,7 @@ static void apple_nvme_init_queue(struct apple_nvme_queue *q)
 	unsigned int depth = apple_nvme_queue_depth(q);
 	struct apple_nvme *anv = queue_to_apple_nvme(q);
 
+	q->sq_tail = 0;
 	q->cq_head = 0;
 	q->cq_phase = 1;
 	if (anv->hw->has_lsq_nvmmu)

---
base-commit: 5d6919055dec134de3c40167a490f33c74c12581
change-id: 20260514-nvme-apple-sq-reset-53e22e88c7b0

Best regards,
-- 
Nick Chan <towinchenmi@gmail.com>



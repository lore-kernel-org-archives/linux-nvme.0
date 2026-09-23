Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B981C982EA
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Sep 2026 04:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=bXIaa9lwQNszVQiM2fHG7rFajy+6MFlPqqteMlpXrzc=; b=wGP66ZWoXP82Uec9hPnPkmgZL3
	wovaQfb01H81lcvS6nj0aecF6+Jw3OLGYHEOrcBnPytnnlQlCXWO+zjN3hmZdFsi/Cul156IveiSK
	ncoHafPKbF/OMadyas3C/NgCLLwU/oPVIwqqlm6YjrKH7resW4eF9++cvxXyhX9rplEgB0vKmby6C
	xp+5KsjZoSxd1+E2pqnFjZIeEMwjmTbD4ghZyotyTOLAd8CiV7yhDzF+72tSHAMYG+SnSCTZcOS6j
	MvcqGzRCd5UTGQfYt8nadLB8bHnXy0lYfRvqPYjJgAkdIkzJ6ZlP/0+Zhd/Aez5OCwvTPl/jukn/3
	Lyf84eBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9ESo-000000076W0-21Qs;
	Wed, 23 Sep 2026 04:20:10 +0000
Received: from mail-vk1-f179.google.com ([209.85.221.179])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9ESl-000000076Ul-0rTK
	for linux-nvme@lists.infradead.org;
	Wed, 23 Sep 2026 04:20:09 +0000
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-5c675e64ffcso1332003e0c.0
        for <linux-nvme@lists.infradead.org>; Tue, 22 Sep 2026 21:20:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790137205; x=1790742005;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bXIaa9lwQNszVQiM2fHG7rFajy+6MFlPqqteMlpXrzc=;
        b=y2UXebcPFkqnLgbQ1x4tixfwZZcivWGwOGJLgHI1+vz8PNNWM+cKkrasZBtuVXmSDw
         0SRvy1rFDjP23dqWrX7PN5H82XKW1+bqHdsXcandiPOVzA+hDEmSofdCAL9T8GWC23WO
         0xtJWvp43/FymDWI5URhdMnuQXRPI0pcFBmqfyq3nkmWmkVJLSBydOl7q0fnVavPtjad
         1osW2Oov6iHeZW7Q9LSY+nreXe5bdJdfb5FrubFdmASmFJ+iDbp+wri2DPQkOTHxKMML
         IIBWnztlUVnQb9s96Rv1v4d7SKqNJq+I+uYohOuFyMyydAzIbZbj2E4N4fyTmgYnSxlm
         RB+Q==
X-Gm-Message-State: AFuF++nx8uEbDidy3ZXF7y6zaZ23Y87xwT/7iGhjB2sG/OYjBER8cNX+
	Qsh0jhztQM81KZqWobnMn0PVjp+bo6ruAl6BRYTtoY4fL9aVx9KWxxg6/cCTpT7hB9Q=
X-Gm-Gg: AYBFou2tmR1RbCtG/fTS2Gc0kf4Orlpqmf+pUEIknvduDIwSHEGdvP0UIUsqVXKXNUw
	vHPOefu78jV67h9dWTSxNctHkmXXC7B5U0wMDv+s56x/hDiasrFdW9BPTBDd7ONjHX56EMFgbeL
	Y6shJBKfZGPxmBZlsugucRe6tG+cTUBY4T/andWEA5BqcbBa08+1tlRLK9jggr5TDsxtvHREiRQ
	nvOCJijIwHz/wbm/ERNPKO5X/PCgCQn7OBAR79zKpbNRlo8u029Zm2mnEnaVHsYuErE7g5YxXrK
	hykhufk7HolvKR+G+2iKabZxG1AOD/oONnUn314Wu2eAHiNXMpk8v5fQtvIHXF0i0yre1K1hjLJ
	PQPIV/0dv2GV0N/9s+NNo4TYSEEiVGhCNPhP35Er9GGqBRRtojlGyppqd8JBr/TmV3JxvRyVOpx
	B86FHF4ORvqxD/CsMqtRU6KWoDZ97RTTCOIS5dEBILYzpDjrDOe1firhxPifyi4TMQNR1CEKewn
	95JpuykCG5Sz0t/yoRB+t52b0CLAeKgpF5Oc/tHvL581pPdtJIUrFs=
X-Received: by 2002:a05:6102:6212:10b0:7aa:f842:e3fe with SMTP id ada2fe7eead31-7aaf842e599mr3275105137.21.1790137205381;
        Tue, 22 Sep 2026 21:20:05 -0700 (PDT)
Received: from [100.96.0.25] (corp-190-12-36-222.uio.puntonet.ec. [190.12.36.222])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c9f053a418sm1839977e0c.13.2026.09.22.21.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 21:20:04 -0700 (PDT)
From: Ing. Alfonso Kuen Arroyo <gerencia@idkmanager.com>
To: hch@lst.de, sagi@grimberg.me, kch@nvidia.com
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 mlombard@arkamax.eu
Subject: [PATCH v2] nvmet-tcp: fix stale comment on NVMET_TCP_MAXH2CDATA
Date: Tue, 22 Sep 2026 23:20:03 -0500
Message-ID: <179013720383.9364.11263428288753603011@idkmanager.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260922_212007_254263_8CF9C5E4 
X-CRM114-Status: GOOD (  11.99  )
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

The constant is 0x400000, 4 MiB, but the comment next to it said 16M.
Use SZ_4M instead of a value and a comment that can drift out of sync
with each other, as suggested by Christoph Hellwig.

Noticed by Maurizio Lombardi while reviewing "nvmet-tcp: report a
bounded MDTS instead of "no limit"".

v2: use SZ_4M instead of the raw hex value + comment (Christoph
    Hellwig). The file did not pull in linux/sizes.h yet and had no
    other SZ_ user, so the include is added.

Signed-off-by: Alfonso Kuen
---
 drivers/nvme/target/tcp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index e598101..000000 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -18,12 +18,13 @@
 #include <net/handshake.h>
 #include <linux/inet.h>
 #include <linux/llist.h>
+#include <linux/sizes.h>
 #include <trace/events/sock.h>

 #include "nvmet.h"

 #define NVMET_TCP_DEF_INLINE_DATA_SIZE	(4 * PAGE_SIZE)
-#define NVMET_TCP_MAXH2CDATA		0x400000 /* 16M arbitrary limit */
+#define NVMET_TCP_MAXH2CDATA		SZ_4M
 #define NVMET_TCP_BACKLOG 128

 static int param_store_val(const char *str, int *val, int min, int max)
--
2.53.0


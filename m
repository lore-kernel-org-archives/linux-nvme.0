Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62D7FC982EE
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Sep 2026 13:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=igw8US+UUaQ7xFHWjPtidfissy+IxS4zwRUNv5NU2iI=; b=DqOS2Rg7tHt+xUnVwfLUN9W4MA
	Pf3zYJQmS73T64YaakJomOmqDwAXeAMQEIeJaegehaTNl2K+Qpu0cPIyHF2lu0ks37+MmEOvoh/Ry
	j38IhOdzy/wi7g/Tyc7OJIVcZGH6KaiGxb+uQbws1Tuffd/ead31O7RwxHMkj0z6e9mCNvr1BYmIQ
	EFUqegsoM2OvaWBdZe5lBUVJJ1z0Xr6iE1AkQLNrjsJDKnjsZ4o+JR/REJMZZK1dFEApO2doMXIzK
	D6VT+PexvLpxzA6ZjGgGDW5enLQZPO+2v0GVfxy3zEtLTbWi1CN2GE/DlfoGuwf+aAvpjrsA6zbr3
	CxwmbaNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8eI9-00000002GtW-0Qel;
	Mon, 21 Sep 2026 13:42:45 +0000
Received: from mail-ua2-f12.google.com ([74.125.226.204])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8eI5-00000002Gsn-0nNL
	for linux-nvme@lists.infradead.org;
	Mon, 21 Sep 2026 13:42:42 +0000
Received: by mail-ua2-f12.google.com with SMTP id a1e0cc1a2514c-97e7c8d040aso1529745241.2
        for <linux-nvme@lists.infradead.org>; Mon, 21 Sep 2026 06:42:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789998159; x=1790602959;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=igw8US+UUaQ7xFHWjPtidfissy+IxS4zwRUNv5NU2iI=;
        b=bgRvPi4/cuZ0RwVYzNtR02PXEyDz9bkfHBtt3QpZZZ6vwSnPxr9GxsbtslJiK1dGmH
         KgpBuOwoc34geqt+9VdsZ3VenVMHhrpAtupu/s8y8ywosmb7/btKfvAyNbODq9DAL3cc
         IjnGezdqrESDh5WwX0gp+1Dv7v72fceZqU4YCiwntE+Pwv4AP9zEbI5Om0KaCfr0RhWX
         INoNSdimk3ymZjFbpBuBoMImMBFHLXx1EYp7C66LwgJPjotfbjr+CaagRjoiKT4yzPDr
         jlyC1it5YzChovOyp1T341iYjiS2hpZ+xOC/xFhCj3w85wImb85w6guQ4FZc1yTm9G+Z
         r8vA==
X-Forwarded-Encrypted: i=1; AKwUvBzULhlDK7W2o0d/Z/QQkBCB4Bn1TSUdiwFOYQ/aixsvkew3BgKVqiKumf17S2zytsQtTdgM1eJ+gFuq@lists.infradead.org
X-Gm-Message-State: AFuF++n8XJHe5BtN4EsbMrxu3/foY6eS9pEI9FCN6LQg28X4kl2/r0jM
	YeXpeCN40I+lqJXrMZHtBdTWWXmdkdZZhF6hs6NZXxCexPjtatrNSStDu2fwqj9Q2Qk=
X-Gm-Gg: AYBFou3TcwSCImZFM1Dlgo0f+BtrYJ7Bcq/9lBytqlE/F6CF+U4NwJjtwVqDRdM59Vq
	ACVmJPvLm9p04cFIfTd7FL17yjVcPGIfdRL/NSbbH4gTx8AsBCZYrgh3Gv14IaWWAll+oB/G07h
	wv/e+pXYUo/TR1VgFNVx/+aEP0TBHvchUHCHTqoC/TXZ3Byj6l74FMqFpFIyjyTdbjMU/NEAIJS
	Sk9H5BojkSe5qqxK9IoenKwPrT+zwr9zvzeIJ1Q/lsSl34cY+hG7g6FwCsN2XTm2aFMRlg/hxpd
	DYTkC9LjrGyG5gShaEaRkXniBS7uwQT/GWkCZ/pXnw8FvtH4+vihUsZe/Hd/McHl3rXXtqFD81C
	9/nAWbn5QlpQiofx/uO+qAs80GIpsghuS5BBLTfNGkti11k74TFBObsfhdcrEsmSIFl0dX3ODUl
	n2nXK6g3pAheih6ANDoNfR1yI/fYjahYg5I6k1Twn1cidWCVjJkTZuEbsj0cvuJ1TfNe1jsanhL
	jGo4f65qnTPQhTw5EfPgkptxBJIr/tMLjMUQu8jUqFTKbRj6GTkq7srMEPqA/tsyw==
X-Received: by 2002:a05:6102:1629:b0:7a7:19aa:8a86 with SMTP id ada2fe7eead31-7a719aa9111mr2954454137.33.1789998159216;
        Mon, 21 Sep 2026 06:42:39 -0700 (PDT)
Received: from [100.96.0.25] (corp-190-12-36-222.uio.puntonet.ec. [190.12.36.222])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7a6ac5e08c7sm8343193137.8.2026.09.21.06.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 06:42:38 -0700 (PDT)
From: Ing. Alfonso Kuen Arroyo <gerencia@idkmanager.com>
To: Christoph Hellwig <hch@lst.de>
Cc: hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 mlombard@arkamax.eu
Subject: Re: [PATCH] nvmet-tcp: fix stale comment on NVMET_TCP_MAXH2CDATA
Date: Mon, 21 Sep 2026 08:42:39 -0500
Message-ID: <178999815960.27132.5021907314171265355@idkmanager.com>
In-Reply-To: <20260921065448.GA13764@lst.de>
References: 178978695312.43804.1554581215424967584@idkmanager.com
 <20260921065448.GA13764@lst.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260921_064241_239784_D00BC51B 
X-CRM114-Status: GOOD (  13.56  )
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

On Sun Sep 20, 2026, Christoph Hellwig wrote:
> Maybe use SZ_4M instead of having a value and a comment that can get
> out of sync?

Good call - that also gets rid of the case Maurizio flagged (a value and
a human-maintained comment that describe the same number and can drift
independently). v2 below; the file doesn't pull in linux/sizes.h yet
(checked, no other SZ_ user in it), so it needs the include.

Signed-off-by: Alfonso Kuen
---
 drivers/nvme/target/tcp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
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

Alfonso


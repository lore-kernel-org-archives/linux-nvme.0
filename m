Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71EE4CD6E44
	for <linux-nvme@archiver.kernel.org>; Thu, 28 May 2026 09:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XxB8couJfSeRJkgFA78R4nRWKjJBmx0PLO3J8/y/sqs=; b=PUfk45muwzqgGaDladxkHh6RVp
	dGw8/HPlM6vQhPWti6Gj/fQf/+ID0IYV3NvSZSqW+nF4ojiWPoEV0z5KlIlpHdscT9GyajAegGg8E
	fyjN/2lYmmnCoN1TuM8dQ9Q4NAfzRZg1x/d5mHH74HCb+qW13edTUUktFqWV5Y8rzzhYleR198GJw
	NRcgLMR3uLJpMFxagZmKNUJaRztNagvqKrUPHv5xTFkA4aMnSLOETEGPN2E1N3PZ6mawJ0YeGDFJS
	QjY09wgunpFSfWFvps47Jhkxt14I/wXAfrclRU+i3Upw8Q0WUZfOMtE9tVaCkQVtM5iA4aDyo0a10
	ufkUGUEg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSX5n-00000005VmO-3VZ9;
	Thu, 28 May 2026 09:31:55 +0000
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSX5l-00000005VkR-176H
	for linux-nvme@lists.infradead.org;
	Thu, 28 May 2026 09:31:54 +0000
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-2b4583f0a1aso92502865ad.3
        for <linux-nvme@lists.infradead.org>; Thu, 28 May 2026 02:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779960712; x=1780565512; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XxB8couJfSeRJkgFA78R4nRWKjJBmx0PLO3J8/y/sqs=;
        b=FEBsv9FpgFlS1B0PZ8z9qIR6D6qt0PUJ0CYBZ0TNTjcblnAatgmGn2Czr8POPErPYj
         m79q6t0r7epNdwTXhq+qy0CPApb/p4Tp0DEB6sa5J2VEehlZ/xASnFirE5aIG1eFCSHY
         Gr73WCcAWC3oQGkXXOiiRE8cPGx2zTC+8WvpPmyhBV7/lpq9oHCyYiYdSox4SGdnPNM8
         wCShfL+SiTtrFLgIRHIMfdIwqYzcP5qqoZ3spTJ5fo1mfRUYor0BbstmBKU5riilFkCJ
         lqWBrt61kPG3yF0p19YrborwTcc/8Nz5nYChxka45cyD0sY5om0+jZBZHlJTFxA0eV8i
         wj3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779960712; x=1780565512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XxB8couJfSeRJkgFA78R4nRWKjJBmx0PLO3J8/y/sqs=;
        b=aV/wOnPNXv2Ts8DkbH38BXayN89PKTynadmA/RSvR6WFzQgKICo/zF0prRYedRU4ws
         k85+b8qHOH5AWhgCez/Js+ZXTBgvVJRCtTWIE4Ek4pTGGjT+2i9Ql/+LpAMBob71HWWN
         VXQmlbH+hEKnwXtWWnMur5NKbdYDCuHpBNfZwuksnxBy8WNyREFI3Nw3ljrJY/J1NyYA
         v5FO0hVywAwTa7Krzb0ZefAs4E2UJtMIq3w600zfUWyOHj/gJu38ilWcaLq+V8jsG8Bu
         cQGIqZqfhuIq80IxxpeJFMXIjZJdZXTnx8DY5UJmceqNEL6tAQGyMrbCIAkOxOPsv36O
         KQ6Q==
X-Gm-Message-State: AOJu0YyJcAPPrn15RyBYo4I9GkVSj4CrzRxNgn+z8G8LWjkuBICStc9R
	quFhc3M0V4m01ZOHF+zHNDtsugsvRoLPrU6HV3r5JwEkkHcLpa6dBGxFK8F9/toDLVw=
X-Gm-Gg: Acq92OFAbj1F42oENti1PWQ/iP8Uh5CEnQypYIeJfWKtX6ElLiU3/Ok2D8wgI/oIrIB
	WONcmN15AJc0JtfP/s25+Zy5mh1igXuejiPKoCk4IG3y5Qf0ofxVIKyzS6rF2VDY/nzGgx8iYnn
	rv5VGMCAuO1Cwx1lYd6kDmroRXBVhU36co1mjwZJuOuWfY6ayeHJrcakQVSBNDQIJYIxb1TkJJO
	ZrDyrd6BSNM/yxTziePwLvweqoC6Riov3KXGhatCUjjE5WxCPx7j7aTTB7vKWcT0WZoAf6F/uYd
	Qq1ujesgG9ASjBECG0PTmCYX2u87EsHPeefpWfKaKaQOUF2GDbJHSo4edL9Z5wLz90T+bx9IsoK
	RYS7J6Syv8+xgpcRY9nM5hDUQ40uBqtzVf9wcqQ3/fM2mSee/55HZrqcNMeHOY4Ut8VufK7nhkF
	UazT/VdWv+SMvlTlMmDfwYkEMMaIOU
X-Received: by 2002:a17:902:da92:b0:2b2:5857:583e with SMTP id d9443c01a7336-2beb080a6dbmr287274375ad.31.1779960712334;
        Thu, 28 May 2026 02:31:52 -0700 (PDT)
Received: from [127.0.1.1] ([221.238.56.51])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb56ca7fcsm173561985ad.27.2026.05.28.02.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 02:31:52 -0700 (PDT)
From: liuxixin <gliuxen@gmail.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, linux-kernel@vger.kernel.org, gliuxen@gmail.com
Subject: [PATCH v4 2/2] nvme: validate FDP configuration descriptor sizes
Date: Thu, 28 May 2026 18:00:02 +0800
Message-ID: <b2f3e4d5c6b7a8901bcdef2345678901bcdef234.1748418000.git.gliuxen@gmail.com>
In-Reply-To: <cover.1748418000.git.gliuxen@gmail.com>
References: <20260527133205.GA12042@lst.de> <cover.1779930057.git.gliuxen@gmail.com> <20260528083016.GB7073@lst.de> <20260528083043.GC7073@lst.de> <cover.1748418000.git.gliuxen@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: send-local.py
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260528_023153_404900_F34426A9 
X-CRM114-Status: GOOD (  13.96  )
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

Validate descriptor sizes while walking the FDP configurations log so
dsze == 0 or a descriptor past the log end cannot cause unbounded
iteration or reads past the buffer.

Reviewed-by: Nitesh Shetty <nj.shetty@samsung.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: liuxixin <gliuxen@gmail.com>
---
 drivers/nvme/host/core.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 766157ba6..40e87b563 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2275,7 +2275,15 @@ static int nvme_query_fdp_granularity(struct nvme_ctrl *ctrl,
 	desc = log;
 	end = log + size - sizeof(*h);
 	for (i = 0; i < fdp_idx; i++) {
-		log += le16_to_cpu(desc->dsze);
+		u16 dsze = le16_to_cpu(desc->dsze);
+
+		if (!dsze || log + dsze > end) {
+			dev_warn(ctrl->device,
+				 "FDP invalid config descriptor at index %d\n", i);
+			ret = 0;
+			goto out;
+		}
+		log += dsze;
 		desc = log;
 		if (log >= end) {
 			dev_warn(ctrl->device,
-- 
2.43.0



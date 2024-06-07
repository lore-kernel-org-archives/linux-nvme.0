Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6681C27C53
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Jun 2024 13:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=pdBre1dGi2JyJKOSGF7gG4RE564btgGprcdJBommpHk=; b=BnN80iiiaNIUEpvHzIU0I+9D30
	ZfhbRveXISiSuxxuCxi8Wx27jBfRwvSM/07ZM3oG6Su62K17FyuZajuaKWiMkB1s3tgzfBKxi3CDR
	J0vBvFrLHy8gipwUBD6h28BiJQh4WJgzqPAl7bGZMbwabl6g/PyHvhbWH69RGQERUFjmHbDNKKv7D
	1AimfR3aFVmUvIq7mJ/IeqKqohF7sfPqsEZ3JZbN5SMK8FOJ+TVl4B8tpqpCsL6/o17yGDYew6Zw1
	G3x7iu/icXGkaZhELsF5ngVq9f2rZ9xupFdi5KlEZv75zrJgCOg46mkYzFMpWnucww3APRGjLLFEE
	Xxx/70tw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFZsr-0000000EEFc-2KVy;
	Fri, 07 Jun 2024 13:43:57 +0000
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFZsk-0000000EEDp-09M2
	for linux-nvme@lists.infradead.org;
	Fri, 07 Jun 2024 13:43:51 +0000
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-52bc121fb1eso563792e87.1
        for <linux-nvme@lists.infradead.org>; Fri, 07 Jun 2024 06:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717767826; x=1718372626; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pdBre1dGi2JyJKOSGF7gG4RE564btgGprcdJBommpHk=;
        b=LKyflFtCLsORzsqjJZMbE7NPUwiO9xvsu+M/tv4lofLnODB6Z0JlXY3sCOTr1GXD0g
         i1WrsqSy0wxpH0g3OKtrdgrzE5lF7Ms+OJljMHx8K7ZnrAjPpEHd6gQrBlQ4bVqdlp5C
         nDc4rwUIQ4OtHuWrbxah/baH897aDNer2YgNALvWd8Lr065OMpR9ZxdwKAl3XvV57zPf
         CNPNHXHL8w0hh2HvbMivjFQfBXfgcTpanSr2zsDInSLyBpq1J/Mbn38XRXT6OvWRLfo4
         3XKDt+eunhZQQdz2FKXW6UJkdkneJGUzuxcU59+5ezchQded7CkqeHbtQHOhOs4GFtKw
         3R9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717767826; x=1718372626;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pdBre1dGi2JyJKOSGF7gG4RE564btgGprcdJBommpHk=;
        b=JFV13nIkZyxHztiKN39gEcX0b7IvSoZg9DROzssq5u3sV0pRWvcEIVYfraqp6eTiVI
         1RdMZmtf1oNFsMZIk+xjcZqRNya7Z7mSF65RDixfpaqXiHBlLPRk3aONHiKdkEMfTvao
         a+othRSKqN5UMf2HHNLQWw7NhlX/3MYA71PDhaKCr7HerIsuDwwbZq5dKzG9I57n7agj
         CO32mw2Hvy1p/MoYiGBF+ElgMOfoZ1CMEsFj5CKIZvlk5jK1AN1SslNRinujJhseJ8eV
         jysfRm/xNOTqzpMDxqU7ilfYl93TOxajCGInlFO9T/3h82/NL4Dyyii/Mb9gS/HhulyF
         W2AQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXR+zSyFMEUSI+q7Oiwo6NPpIQZNdaaCjGwkeY0jysRbNPmVnG34E/B5Ev5mHFnNqs4kqQUNF6KSyDy+BvWZ69M2YDU4IJ7w/55FRkkm0=
X-Gm-Message-State: AOJu0Yy/G229luV5uSr0hPUKvW5vI4UmpxOxOQSBufLxUuS4memK3bYT
	vD6+ZvQNe66TDcrTlc/ZPeMrP2FK5gwFQ5kMniR2mAwJSAFbX05a
X-Google-Smtp-Source: AGHT+IGMxlg8urqbwAFOjNr5bTMp9W0RVY0EmvHh1p5VgXr3s6l4vrW2FFSH8rmVQ7/n9SDcAnbVoA==
X-Received: by 2002:ac2:5ec4:0:b0:51f:2908:df48 with SMTP id 2adb3069b0e04-52bb9f7a958mr1610734e87.18.1717767826019;
        Fri, 07 Jun 2024 06:43:46 -0700 (PDT)
Received: from alsp.netis.cc ([2a02:2168:8a08:3100:a1b3:3b31:44cc:f7ee])
        by smtp.googlemail.com with ESMTPSA id 2adb3069b0e04-52bb41ee46esm550070e87.72.2024.06.07.06.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 06:43:45 -0700 (PDT)
From: Alexander Sapozhnikov <alsp705@gmail.com>
To: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: Alexandr Sapozhnikov <alsp705@gmail.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH] drivers: nvme: target: core: deref after null
Date: Fri,  7 Jun 2024 16:43:39 +0300
Message-Id: <20240607134340.11-1-alsp705@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240607_064350_097542_8A7D2C08 
X-CRM114-Status: GOOD (  12.88  )
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

From: Alexandr Sapozhnikov <alsp705@gmail.com>

After having been compared to a NULL value at core.c:813, 
pointer '(**sq->ctrl).sqs' is dereferenced at core.c:838.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Alexandr Sapozhnikov <alsp705@gmail.com>
---
 drivers/nvme/target/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 06f0c587f343..5a67d2bc0c55 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -827,7 +827,7 @@ void nvmet_sq_destroy(struct nvmet_sq *sq)
 	 */
 	ctrl = sq->ctrl;
 
-	if (ctrl) {
+	if (ctrl && ctrl->sqs) {
 		/*
 		 * The teardown flow may take some time, and the host may not
 		 * send us keep-alive during this period, hence reset the
-- 
2.39.2



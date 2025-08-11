Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FF11C87FDB
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Aug 2025 14:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8BEwZHZ+L3ilTH9rJUZDkczC6u83Mtp4BtglFfrqDMI=; b=NA5BhgGOpRSb2RUz2oVT239SrY
	/8jQVvhap1//9x2ItjvjRDkFJKkNNVMyjGRaYzDGNGJj+UGw1qrNaJvlp5Ct3PE70yKL8Qrx/G2Zg
	fPAST+rcUzY4dlrpm6ciXxGS6QRFc4udiwwE0pqlBPw+QHSh7axGyNeJjFbPhG1Spt1/Yv2clTRme
	47+pdmymUQqU4gOq0H3Ulj4nqifnfoOol/NGMNO+ijY4MKOezP1PrtIxqUsY1ibuOhZ4W31ehU/6r
	1itvDJlvgxTSArTmZAtcYjvPYLsZo6wuPADapjEEbS3bQefOv3Lhk5aRmHP1UgActP9f6Xp17yfNy
	EZO4zNxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulTFa-00000007yHd-3Lg4;
	Mon, 11 Aug 2025 14:11:46 +0000
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulSwN-00000007t48-1SW0;
	Mon, 11 Aug 2025 13:51:56 +0000
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-76bc55f6612so3900294b3a.0;
        Mon, 11 Aug 2025 06:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754920314; x=1755525114; darn=lists.infradead.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8BEwZHZ+L3ilTH9rJUZDkczC6u83Mtp4BtglFfrqDMI=;
        b=mXFLamQjv+lN6hmfeiNPZ3NVT72rFqG/m/7FUqNkVMaWrmyZvndbqUKQuA57PbYTiR
         C3qs1HCPyoGb1pkTvpHXdi5+1SONQ91kDg2jxq5tA8BV3KnY7ZzfXz03ivdeTLuhwyfO
         DaL3DK6Wh6YwX9X43MxXk8fAIjXqWHFQ9gt1CZVcTuAamH/vf/FJLwVt6XDH6d/lJQmE
         Vu8wMbYiH7HSdgmf6V6lVHIatY7Kvr2tnaZRZ0goAZj3a6tZXdumf95oIbjhMxK6VQHR
         AsUKiz49QE0msO/BVo50v9AGjJ2AAH0zV19TPlWIqFX2DdtByUgF7ylwEbx5I3q/PMin
         jeDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754920314; x=1755525114;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8BEwZHZ+L3ilTH9rJUZDkczC6u83Mtp4BtglFfrqDMI=;
        b=Ou0svp4AudP0Uobo32PwBHV3jtN4IqBH6pSvJbxfnKBq8f2oe2x/lDy+11TX1X6Fgh
         JlFMlhZsjGaMmTymNF7v1KI800b4FPvGgdfZN8xVAXiBoWi4evFtay6F6NDaPMzJPI65
         3GwjEW34T1HiCWQ2rzx69y2d9T//CaTULyJCZJPP0ytwxACv3d0AtgiQSCwBPzUuCIC0
         gpMsV3pGDAjoGndvrmWCKy1Zw5giiVlLaOc2tFOvWkw0Xm13LoeWNb9Azyx51SBWowxE
         d4JdgnI/L45PkmqA8c9I/yBlaRz/SrYoibmxE8+dfsFqdPUqU/wy+zGKUVQnPVqeogKy
         2jGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhHoEm81hKnKUgYdlm2FKy8IKj3229I1tyJE2Gf/bJje3kq/Fmz8+v8ra06z6qKh/DMw3U7KzudKPNdxfKnhEk@lists.infradead.org, AJvYcCWCHe02YW9TjM2gCzmOpFxFAnFRln6mlm3mrHomf3XdFkGuT28zNM4rSb4HOi1rFVSjjLIOQsYAEi/NLg==@lists.infradead.org
X-Gm-Message-State: AOJu0Yz9l5VgWKWG0htGj/CMyCVlqnCO201W2PczL1HKQkNvwvM/9+iJ
	ryA41cEG6wnXYzlQZUx4GH4jhxY3DRAga0nborGBPkRrvH1BtcPyybdp
X-Gm-Gg: ASbGncv/AjwU1bLz7D/nk0Aj02LVA8wSb3f3sac02OAWsGqxKnLFASjBznsuznIxXQ2
	IerdJvablrj/cq/P+0JTsFHizpFM7bsIBsMtsgnZfCUsSyet0Svhd7/p2ggqu6kMO4OYHLDKN1a
	SB74BiL1hUNM9HsRZJVocjdTwgm0R9JUqrhfc+QIboKfXO0OjDI1vOAm79vF9Ftq3ex8O1GPE61
	1qrmL0kW17jUYsip1aLdDTWHJa5I5iBpdmhpRB/VcasdtyheOcFWpNy5hBrK3CLM0WV5JSB96kT
	ENsECE72HJmFAERQ8UYOehKE7kvqmE3r2L4seCxwR0kcOWMIlfoiSF3EYtOv7MczWBEdbQLJ4VP
	LNsQvZDi/2JTj6MMEvsvJc9giQMNcMlsVcJn5OPBWQqdizHI=
X-Google-Smtp-Source: AGHT+IGhE+hSwc9ysPvVz7jbqtKJ2dKarkpmwubjOr30BSYSqZyhNCYRQjTx26kCmxQPcCpm1AuJ8A==
X-Received: by 2002:a05:6a20:12c9:b0:238:abe:6363 with SMTP id adf61e73a8af0-240412d3d1bmr30536141637.14.1754920314461;
        Mon, 11 Aug 2025 06:51:54 -0700 (PDT)
Received: from [127.0.1.1] (061092221177.ctinets.com. [61.92.221.177])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b422b7b2700sm23504993a12.15.2025.08.11.06.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 06:51:54 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Mon, 11 Aug 2025 21:50:58 +0800
Subject: [PATCH 6/9] dt-bindings: nvme: apple,nvme-ans: Add Apple A11
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250811-t8015-nvme-v1-6-ef9c200e74a7@gmail.com>
References: <20250811-t8015-nvme-v1-0-ef9c200e74a7@gmail.com>
In-Reply-To: <20250811-t8015-nvme-v1-0-ef9c200e74a7@gmail.com>
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>, 
 Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Hector Martin <marcan@marcan.st>, 
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Keith Busch <kbusch@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 iommu@lists.linux.dev, linux-nvme@lists.infradead.org, 
 Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1310; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=UCisHMuxtAwW4uphlmL614TcUp9WjlCZlTIn0NRlWVg=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBomfVR4bxz+MuUXxpiFshyYD6ViYMujQXc2DuHt
 +wsEwye3/iJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaJn1UQAKCRABygi3psUI
 JKqTEAC33mI1jzeS8VVyGFEq/BiQe/bhvXliEN4SdCe2Tf6qLrBRqeMCfat6HbLoCja4CbUVsSe
 Wemni/JKDF4aHY6dMInba1FQ5MCA8wxD3RTKkJEhbX9XWcY2DGJPEW+lBuwfq5IdtpdbGPpDpwj
 zkAFEHlpl8MUaWTG7GSm1OY0HqYFLEEuAIbYr6uEeKrBhI96Iwb0sg0WXb783y9dQ3ry3uE2UT+
 OMuetIm7TibCt2bAlSkvgDYC72Rdt/curbxJ5Mdd9fRVB8aICuA0yKN0tan1nViX97O4TqKukNM
 oVh2gJgU1zt4axuYbPHfR+d1Mj5l+C2FYEP+rm1sP+0yG2HgGerJek2XpOjzLKissSw852P4/Vf
 imtGgV1Mud0iXKrxkEGPdyFX9+xWpSuN46Cld2ktxXGZuXmWOf56m00c3X++7B2KXGpITfnMwlH
 OmMc7flr9uQ7l/f17nBHDf8n5nEee9ymqZVYaHPqLPv0B1jRy1D/ZM8rCursoteS3Ll0lE5U0nl
 cJP6/uXAnYMBiRnM31x7J8vJErU1S39eSCcNR6Oitlpa35p+W6q6VQjcqTXtKks/fWGUrQk1u6H
 COIuCWyD+4hp5tNOO9FRIZRJTLU9mDzqtvNvjp8QZt6nU8K+yYRcd5SI3f/opD8MH7GOhyJoNjU
 cXMFsGdgsiST1Qw==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250811_065155_396921_E8117EC8 
X-CRM114-Status: GOOD (  11.06  )
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

Add ANS2 NVMe bindings for Apple A11 SoC.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 .../devicetree/bindings/nvme/apple,nvme-ans.yaml          | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml b/Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml
index fc6555724e1858e8a16f6750302ff0ad9c4e5b88..4127d7b0a0f066fd0e144b32d1b676e3406b9d5a 100644
--- a/Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml
+++ b/Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml
@@ -11,12 +11,14 @@ maintainers:
 
 properties:
   compatible:
-    items:
-      - enum:
-          - apple,t8103-nvme-ans2
-          - apple,t8112-nvme-ans2
-          - apple,t6000-nvme-ans2
-      - const: apple,nvme-ans2
+    oneOf:
+      - const: apple,t8015-nvme-ans2
+      - items:
+          - enum:
+              - apple,t8103-nvme-ans2
+              - apple,t8112-nvme-ans2
+              - apple,t6000-nvme-ans2
+          - const: apple,nvme-ans2
 
   reg:
     items:
@@ -67,6 +69,7 @@ if:
     compatible:
       contains:
         enum:
+          - apple,t8015-nvme-ans2
           - apple,t8103-nvme-ans2
           - apple,t8112-nvme-ans2
 then:

-- 
2.50.1



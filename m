Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DF58CA0EF1
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Aug 2025 13:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ab/nfPMw843eKZIzh1MEFIjYGxeCe4JAvrb6z0G3ci8=; b=xk355WMfTtifF8pA3DcwLSvlht
	eDTg5hvPNcs0vzm16we/i7BSIBAOmoknl/Q3nTbuLbA1NW8BKExoet8ngA+CnHPmzsb//Qs/tcXc1
	XiM0UCNRxDh1dG2FW7FbAhjmZC1hXBaFIiMmcOg/6GAhxzss5u5x2H4vG+QKP+SskQ9z23pTxif/j
	Hg3yzgNg9Z6y72SPz7KeSa3Vjp05NV/A23RIlq6PcMY6eyEegHqQHGVg7FfjXuvJhgSiPfcw3dQeb
	suiIOWgo2Ve8dRm9PKe6odh0jTXoYNxe+qHOZ6+HndvEF+KjBHoQCzG/1gmsUz82HD7X+tEJ7QcgW
	LW2nb31g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uo03h-00000007Usc-1C8Q;
	Mon, 18 Aug 2025 13:37:57 +0000
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1unvSl-00000006xjB-1yJe;
	Mon, 18 Aug 2025 08:43:32 +0000
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-24458242b33so34915505ad.3;
        Mon, 18 Aug 2025 01:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755506610; x=1756111410; darn=lists.infradead.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ab/nfPMw843eKZIzh1MEFIjYGxeCe4JAvrb6z0G3ci8=;
        b=gutBJTymz99pZDIKlRGa8+LlJ1NkMcHbMpeIGNk/nHAJ0xk0a5f7eU0LEegXDfKTtA
         2tLEz1tyKjI5KGZm5aTK0nqD5iDyk0N+FQF7YadpXsvL1WdeMM7QaQA+h5UMZDgUQF7B
         59tJIIr8iFOrqPnaT4NG2HDvXs2Hd6xy71AxUzwloPxfXBv+Gdu7F65k66PpqPqhwOgm
         jk1uBW1yIn/PMhq9f+TYjE4Rf3/3zYBHmFG4EvRjMlabqMLgijJcDhIJoniwuemtcs6T
         sPVz8lbdH/XPeaJc9pg0KG/zd9qV0FBNcPPzVUC6hb/BWYK8osAHQshL0GGGzu0sff8L
         g6xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755506610; x=1756111410;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ab/nfPMw843eKZIzh1MEFIjYGxeCe4JAvrb6z0G3ci8=;
        b=SPLyqefsZs/g0XWBjbEHyKpZF6q5Y2J9bLoyk8PSHjtb38h1XYCxJUyprgqfn26JcV
         CysU1ad4CEfYmC3GzFdnIPgqByCO+/HEeR0P84yokHtMlAKWXr47V4u5ipmkLczdoAqR
         ThOF3KalTdGKclRWxL1n/ATKhT8A/8LVR00mvqoeHfVw1YECeLZudHP17eUSAM69Diez
         NYNzwaX+pjwFEQWa3KhcVJvE4KKypeb+DtRauKXDQu4aCvHC6/Sd4h02awW6tkooAyE6
         /P4QWzuyQ7gwepYdTzXDGii3vMEHFPzqNBxrZgugm6Qd7IByW4p4JPzLCuxmm8vw6An9
         Ffjw==
X-Forwarded-Encrypted: i=1; AJvYcCVSRq6B2mOmxMx0XL4CQdyy99sCYlnWeM1b0tqI2sSMAsmtuJe4P4cmOnmeXOGhAFgyCdU4ajA7grNFZg==@lists.infradead.org, AJvYcCWM3+xmiE7hS8uw9Ft3utT9xIZZsvBJLUo20zRi03bYyJb65pUDMP83aX1P3FafXGNgWGv0+XSIRhMEqW9mFgWp@lists.infradead.org
X-Gm-Message-State: AOJu0YxtDDrfdIeHpyKZDRfD7fFxYmAm+bf8AUzx49QpmuTlv+aRpAO3
	VY0iF73I/ubp+UF1keehLuYmRcJzLgK7XrtRK7KEE9FLKgQD1Cac/hnfzvK73Q==
X-Gm-Gg: ASbGnctPBY148vr67hOaXFUYkh0oohSxY8pmjwU1Op6Pdcq4T+s3QOhpTTuv/xm6iUz
	/QzWm+gGvYS+Pwi49hjBSwdqeMrP+ntpUIEljb7lw5muqjGaQ7uMbFGwiJp91h3cesClPRqiGOz
	VfsBepLXtYMdPRGeDKA4/PsFF6QHDoS5iARVYGRGnXlc9c1Jw/810wc+XSR/+kwbWPmrw7/b/31
	OjuuuuZeFYKRZ0yu6BID5yIcnM911x+m1gez4wboIok5RCBI1u21ezXehkSBmCU+y2uwGAO8K/u
	tiktPKdF28ZjXGu8NAUSFD6bcf16TBTRIuNZKTwvNCWMRcCZNhGOd5E/wkV4uGnmRBW0N5mqbQh
	CRaYTkkBxipBhcoPivp76XaQFOohxCvBKAkPLU/q1ijzGL00=
X-Google-Smtp-Source: AGHT+IH3faNDzylzD0VDv8Y+qqSpzsBrx/M1k4bGkBOGU1VP2ePH7Sqk6RK7FHzo52EeYG4HYqUC7g==
X-Received: by 2002:a17:902:ec8d:b0:242:1ce4:e4f9 with SMTP id d9443c01a7336-2446d9c64admr141732475ad.53.1755506610186;
        Mon, 18 Aug 2025 01:43:30 -0700 (PDT)
Received: from [127.0.1.1] (061092221177.ctinets.com. [61.92.221.177])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2446d538f75sm74090925ad.108.2025.08.18.01.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 01:43:29 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Mon, 18 Aug 2025 16:42:54 +0800
Subject: [PATCH v2 1/9] dt-bindings: mailbox: apple,mailbox: Add ASC
 mailboxes on Apple A11 and T2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250818-t8015-nvme-v2-1-65648cd189e0@gmail.com>
References: <20250818-t8015-nvme-v2-0-65648cd189e0@gmail.com>
In-Reply-To: <20250818-t8015-nvme-v2-0-65648cd189e0@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1317; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=vsY2LxZcawhqMw/s5IJH3Qa/QDQv7w3VsaD857GZcqg=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBoouekHBA3JNgEkbcxb1qrPDbRHzmVLLnTVmcky
 5RaLd4oGx+JAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaKLnpAAKCRABygi3psUI
 JGAUEACHsbI+FHcbJBapYoOszX5QQh6fS6dV6ukZSZpH5IJsuhx+4NIp7tg2wqpS7YRCuEjRQOX
 YJJx16lKWjQwFpzsR2omcDJfxqXcUA+Tm809iYgdkDNPSeScAGBi35AtLvk8KNbiFfzSiJqsHaR
 PJDnR7MVMOb5BK5nZdhPLXySqzEiZkvUxb0WPJDXZOJ9ErQygRKAkUPLqvBMb1MrGT78MhbwBi8
 Giwd6FiFoUWf/FrtIzXWZcEvuwIX29x3z6yqZAbG3eiPV3waEr/Y51xMPzw1zGVJQruMb6WYBq2
 tlZwPAv1Moo8n/KqnzswCvikGRj8mc8oGLkRjPUz9QW4pu0l9qbJ5yc/DsR4YRNeTUpPqCmNE9d
 P/YmSyW1dIjehZHUL/XjGW3LCG3zekN15tXLXATKCG5m0E01P7t32G4v0S3ngjLsLRM5jXUATSn
 jT1oKiGokPTrlyOCZummYN8+6YdVnJJnZezLFkRmKD0GICTrZCWyBF/fqxMHTKOXY8nEZUEy+3m
 j7Sl6vgoelGCbSa2ENOE6qoIDvMZAgWMsH6fafFmgmJNaytYz5WpwQzRMjrPqpfIJ/fXnQQ7laR
 l2K+A63zdf0GLp67J5koiVNxxGmAoaCwdtMQyyA+dGfWKAN40Je5L+N+PP0t9HyMSKaNPa33Lly
 XO53R8O4FyKKNUw==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250818_014331_516367_C28543C3 
X-CRM114-Status: GOOD (  12.63  )
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

Add bindings for ASC mailboxes as found on Apple A11 and T2 SoCs. These
mailboxes are used for coprocessors including Secure Enclave Processor
(SEP), the NVMe coprocessor and the system management controller.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml b/Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml
index 474c1a0f99f34777e1bed7fc0a34f89320a93b7c..bdf58f03b84833ecd93a34b91f6262d1706a002d 100644
--- a/Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml
+++ b/Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml
@@ -33,6 +33,13 @@ properties:
               - apple,t6000-asc-mailbox
           - const: apple,asc-mailbox-v4
 
+      - description:
+          An older ASC mailbox interface found on T2 and A11 that is also
+          used for the NVMe coprocessor and the system management
+          controller.
+        items:
+          - const: apple,t8015-asc-mailbox
+
       - description:
           M3 mailboxes are an older variant with a slightly different MMIO
           interface still found on the M1. It is used for the Thunderbolt

-- 
2.50.1



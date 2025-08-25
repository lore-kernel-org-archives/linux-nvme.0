Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26016CA0FE1
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Aug 2025 11:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KtjFp+37deP+qcyMingdWbOCwQKbGl67hntF9ZyCbl8=; b=XROqsQnFfh7fto9h0RwJcs+FoE
	g3cPrdXn4dcMWxG9AJPWJRyxQxNRwC4zqq40y/kWKh6RPb9ZkldE7XGNx5Oi3urYmr5x+ipR9hTdj
	Iv1jwKAWL5ifjeynkj6H6jRZ54O34F4+oK0rGxU1B4158elGxU5L9jL0oHnLgmO1hFmMPhtwuP3A8
	2fcE7NzCGh2wiyvJ6sdIXXRvCSpWK6tF42r/cmHlzblhHXdvWQZ2vPJC8ewl2RQqtFFamZNk5BgcZ
	dnBd/pv7y6wTUxySq6By4PyLEvY7xYIt51Aeb/RQd3M3MKrmAAHaxNvASxuqHiTXGqkgnu2uTmTVK
	av+6HA2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqVNL-00000007kAx-1m77;
	Mon, 25 Aug 2025 11:28:35 +0000
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqTJE-00000007Spo-1hbr;
	Mon, 25 Aug 2025 09:16:13 +0000
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-b49d98691faso771370a12.1;
        Mon, 25 Aug 2025 02:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756113372; x=1756718172; darn=lists.infradead.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KtjFp+37deP+qcyMingdWbOCwQKbGl67hntF9ZyCbl8=;
        b=grlGsc6/R+EU8TEr1j9MSimw2ZbhI1bOQbTJtb3XzQVk5Gk2KWyeoA4aQy1tlqerAa
         hwYMeBtuBg89abJmG7SLuggxQGxI03wSQPyfZzudsoyUjDipeayXBRo/5rEcng0Afaix
         UFT+tOimtezmMZNcCLk4kXeOBpENMKhuwwFcIh14CkneRC0THQLyxotKPA2lNlstDGhA
         5GOh8PjZ4Elnclkq9ffJBExF5sobWNlImv6SXkAzkzphq7/U00/UMeC1TbPsQXZorxFR
         gw3PdYWspUD73KO3ZsU4eaD7UidTtE0GiJXwbuReODjyIKM01Hw2rOLWBy3vORzYToo3
         GQUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756113372; x=1756718172;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KtjFp+37deP+qcyMingdWbOCwQKbGl67hntF9ZyCbl8=;
        b=bJ+INng11re5ABrknj7a0MfBndO8jGeo93cAJY0F4qGbArhDG7n3DejAqqGxuPwKYZ
         P6kwdJoE6eGS77gK5xxRYWqDtYYcCak+x0IYthD+BSZLHlRJ8mCZaEp3buRs4g4RE1j4
         bPSlm/6ZYLvkR0wAo9R98RG+c8B+UPKstIwnljikeTexGEK6W5dFwF1BmnZGcpLHNS09
         LqXaVLBDIQLHsm1Tl3yz8uFYymXuUt8DzR/Iukr3szK8s2EULkq+IsqnZ6Jo1hIGsRyK
         vVb8o+L5pVsYXje22eEp7TOhy3OFrmZ5on7PrGqhJDUd5yK7WSfC9sf73jq+q4f+vDuf
         +0xQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3AWOOPI+e3Sdz2DD2cIFssroCmbv4RnRRtG8P67uuJwX9LADwTLYSp57be7vPc0R6T2sVA2hSuCbH+V8q5H3d@lists.infradead.org, AJvYcCXHN8q9b/Ey3ZWIkk3cIYkPeBYRAP498Hobu/SPCJJZTRSZOAuU8LDEWNcblf6ezgnGFS/d8O8z2K1Hhw==@lists.infradead.org
X-Gm-Message-State: AOJu0YzlrgDTbs9a9fDQiqTVv2qbXLQVnGUSxNesf2+SRySCurRN/thB
	lMljWzNpwU7DeXwHj5dCwQOXjB+QmxJzG2nmSZmT5aU+dTB74Zeghxzr
X-Gm-Gg: ASbGncvJKGITC6Nsx7fQm06zrV/+15qGaOgeCYLQjQFsPizpG969Thm2UKn4oeGg5qJ
	L2DELYhOZXu14aeKjsGENHJKpqg+SQOgS3LttbY2lbaSsMO5uy1rlnvqng+cUzI6p4fWcog4mvU
	eAAk25xhuEJryArwN3UEEm7hyff5yxPK/esnCjUcejqx8kx69I9KUCFEffkKkjt69e1vKSAm6My
	NuYDoVY+KKUN8HhwXIxw1A4FvuXTHmFv/Ls7rdKUpvIV4jYCFpwOfN3VIHK0KTvYE+f4NHu0khA
	y2pw0r1Y7aj9YV8zL5fV6uiZaGdKs8Hm6FtrJ0Q8TaG2a7BbT0ZqZpPwuBj5YYHKC75JB5BM5WR
	YcaIZCzQdqyuSWbJ6G/q9cuIXPcgMuYQhZk8TOw==
X-Google-Smtp-Source: AGHT+IF4/e+c9KPSdTDMcNdsLzyEg0pIQO80fJt35j/c/EQiaTLu5Fs4DEVRakhW7pq5lO2LcmBS0A==
X-Received: by 2002:a17:903:40d1:b0:246:d00b:4ae3 with SMTP id d9443c01a7336-246d00b549dmr33462425ad.61.1756113371622;
        Mon, 25 Aug 2025 02:16:11 -0700 (PDT)
Received: from [127.0.1.1] ([59.188.211.98])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2466887fc8dsm62873875ad.122.2025.08.25.02.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 02:16:11 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Mon, 25 Aug 2025 17:15:04 +0800
Subject: [PATCH v4 1/4] dt-bindings: nvme: apple,nvme-ans: Add Apple A11
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250825-t8015-nvme-v4-1-6ffc8f891b6e@gmail.com>
References: <20250825-t8015-nvme-v4-0-6ffc8f891b6e@gmail.com>
In-Reply-To: <20250825-t8015-nvme-v4-0-6ffc8f891b6e@gmail.com>
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Keith Busch <kbusch@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-nvme@lists.infradead.org, Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1310; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=bGe3lHrFEExwJaoIxfgSlWjKRZ1MiKpscWSHgaSU79Y=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBorCnRRlvaE1w45hp8w+1EdsAIb8vul/MWpn6CY
 /kNXwesAeKJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaKwp0QAKCRABygi3psUI
 JEzuEAC2TMVz3DGV6ukw1ucnN5hJu5mTHBu4Ncp+n7bj2ByuWZ6dFArojJXcFBs60ihtFtLLbG6
 800iDleo3mVFngAS4fGuPMBfjKZdMAZE67+ErnTamwUipTCW7igb8A9yuPQeFFjJDE8fUd7SA/1
 Jc0/yiyLm4MNnUPuXuHyvnOTbRWZMuableg/SlSbqYZnaWwPyQAI/v9k9M1LC68wp6Pz0nJ7lag
 9JkM4gbvt0Nc//Rov2phSzZnYUE9BLaaogCo7m1QEtLlf8TISP35plxevBeK/Zlowc4p/AdLWAq
 qadzU4c5PYHedjIfIbuk3SvazoC9nJK3ZOGBvRBD7k6kENFnqRGwDpjRFQu5Az3RzL6qq0svpKg
 F89UjE4RdSndyy0itOO3pI9oKyOEWI3LdK9l9fSDT6VeEuDM76DLcuTMdFqfYTXikM9py5/v20Y
 OXY301j4fuCN3PEaAVV25pIHHSqG8z3532ce5Ijmi72J5V75d1tUBXGCS3cql4vf5IjGhmNx7Fm
 Kk0UKy2GhWLbgJ8mt92b/giaq/kxeI/c7OQLJNizjXDqedaaWV+pbkbsaj6HxYc0V7m7+mLl/dG
 LYqg0ANnheFUTn+ML/uVpcebFDszlNtMUP1YotMT94RkGsOhwQulR/T9u4isP3rydo6yBH7hPTD
 SniWNkdxz8exiAg==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250825_021612_448313_088A8F69 
X-CRM114-Status: GOOD (  10.50  )
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
2.51.0



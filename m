Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51863CA0FE9
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Aug 2025 12:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=myWZ5KKugg0r3Iz22gx0u77eYst6AR+R8GzbR5T+YNo=; b=WNOtvPeDWDPSLgXT4k96TYvi8U
	w0kftjrc9cZ+GGJXY72dVi3lkjCYTDIO17X2ff1qBj+RCSvVbalnp3+kQ2GKJN4oKTwZ/U8Kk5NuW
	XyIVJ5LIq0gw5vtq1VF8Q7aKqgSHnqbrb0ysNVoZUQs8ScwPF136RquCshP+TCvoWRkzyyg2ObPw0
	wPQ2ZpJad2jsN/+95s7thjx1fKHG4WhZ5ui2VpJMtrrniaWqTFD29uGhPQz9h+olLf3w21tXdsjkr
	14WN925QduwnjwlcTpUKWbi7U9x62xys1UtTjVPiAGlxpgYEJxISqb7PHp0abHG7diZ+HWSzYw8Tv
	bVYu88UA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqshU-0000000BvoJ-33Or;
	Tue, 26 Aug 2025 12:22:56 +0000
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqsUo-0000000Bu4N-2E3t;
	Tue, 26 Aug 2025 12:09:51 +0000
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-2449978aceaso39531595ad.2;
        Tue, 26 Aug 2025 05:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756210190; x=1756814990; darn=lists.infradead.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=myWZ5KKugg0r3Iz22gx0u77eYst6AR+R8GzbR5T+YNo=;
        b=RAMe2xOSrCxh+A2teqLrjcPcpdDUBLoW0uHZQ7fkhBCufAXMHpwWF7/VhXhKy/5Jge
         5FM8s1jGSAf8sEzclFStepY+JctohWvOh3s91naemWO4DbZ4HF+NJ3LG5zDQm+QxhtMs
         5duppCnGUSgqMvZh4I4l25wiyFs9vBrx1ZzbS401OtZykneaO1LYSk5k6QCvNDoxBXk/
         BmbF9pRpwrOrfviTiUmPaj9wmA9FlRSFPBG6tzTO34302osIFJ+KHY8kWGDZ/sytRi0X
         9vJS4qs4rDvczRHLDolJ4shd5XxQsuG+hc1y+UtjzBGntcW2bOIHps2JrrZtMqx+CsAu
         Pl4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756210190; x=1756814990;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=myWZ5KKugg0r3Iz22gx0u77eYst6AR+R8GzbR5T+YNo=;
        b=ADvpvfLCpQ5SQ989i1J7Q+fa/gBppuVMtR8wRkcd6a1FIKouD9oS4zC01syoZb8hoz
         wuw/Te6vEpAniTlVvz4JjiiyI+aJz08qRCTdGaFVFEdmsETp364PsdrPTUutmTPqhPTL
         cU7qXpAdW58qlK5g5CQBETCmbtQcpK2NFsNndewVxFOQjdiffiTS8K5jB+v70PjAj5ND
         v3lMevaWJIuPsQG4HxxGMqeKhD83Sk5+bhjf35ld8y771FMPTQ6PVFao1QAAwquuTBIf
         3qSB3T8xfdhpjJYUg0f7coFYdbcTAzk2GDcqaFvCn3FjI/nvhpKr+n9ETjgNjj4s6+LZ
         8oVw==
X-Forwarded-Encrypted: i=1; AJvYcCURoTKO1DT9tLo7+7RI851z5YpDEa8q262yXimQW1ucRxqHLkK0oF2KnNREdP/Meubk9Sr+VZB4aw1po6M1DPz/@lists.infradead.org, AJvYcCWlJr7lXoW+mHBjLkBZS+kMUxqlcKdxtGvVLjDRSSgYA0Cm9wBhnKEc5R3cGdRxi2dDP7jHBXKWaeybfA==@lists.infradead.org
X-Gm-Message-State: AOJu0YyPY8azJwXank9p1EXe8WCjWbPFufcqHfRJP1jCrxap90AG2LlP
	0RBtRIDzGdIY1AIuCNJOieNgGIub9boM1dnGlmXdFBS8E7uVQwbxCoTp
X-Gm-Gg: ASbGncvFNMEwN8JXyj2IMO4aWFXUtHmw3RbGZpv42EqoSP6VkO5PZHdiVb2e4AXIaLf
	NyMJNz8H/kSwXC57a7q+ESkITuV4Jmo9gOQKCwt2DV/iB37uE2IottNorNeHE1aJ+nsxNyPvOvh
	t80dd699bWSup2wsuJX7ljtlTV5NTgLmo7S/1M7pI/Kt5yVosVkKrw82UdRvoobxvnLQdSqhkB4
	A2vPZ+YTKmq3oahz/HoLL5XcCqxoHFmvb2RV0L3QWEabGNyM84JQunvlh7ylBEJZ8m8nkcWBRUc
	THAjlnG9j3JqWwoQcHZn7MSDs81bkMbc7X7j8VhUi22aYq/tjHuL2A9X4rYiKS6Dmxl5IqT52Mv
	zZvxNaX4Biy2gwSypQi3vekRxWwM=
X-Google-Smtp-Source: AGHT+IFCs+0+QPpGE5rod3ewcQ6LEfg1s385+SmIISqW/6UyVrO7Bz46rSAw1PuBDWqjvwCmypo/2A==
X-Received: by 2002:a17:902:d4c6:b0:246:eaec:2994 with SMTP id d9443c01a7336-246eaec2c7bmr90916255ad.49.1756210189659;
        Tue, 26 Aug 2025 05:09:49 -0700 (PDT)
Received: from [127.0.1.1] ([59.188.211.98])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-327565d3924sm619966a91.13.2025.08.26.05.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 05:09:49 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Tue, 26 Aug 2025 20:09:12 +0800
Subject: [PATCH v5 1/4] dt-bindings: nvme: apple,nvme-ans: Add Apple A11
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250826-t8015-nvme-v5-1-caee6ab00144@gmail.com>
References: <20250826-t8015-nvme-v5-0-caee6ab00144@gmail.com>
In-Reply-To: <20250826-t8015-nvme-v5-0-caee6ab00144@gmail.com>
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Keith Busch <kbusch@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-nvme@lists.infradead.org, Nick Chan <towinchenmi@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1377; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=QAiPwZypg/VMlrPIBhr0fWYCSyBf5BBQP9eNNCiNfG4=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBoraQDfcGlhRdbNX8kCRUtLsCfOQJIqHlyC4YjU
 BwPiF6XsVuJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaK2kAwAKCRABygi3psUI
 JGGFD/94mzTsBZpIQi24EhnHzwccGc0LDw8hGHIljz4WJYYwVsLfVquxUWdYAB08y6fm2eTVo0T
 MNh3t5Gt4Lh3wL2DcI3SFCG/3IVipT+XGVbX/r0RpHiDos8ZCg0QVtF1/on4amZn3T7qwmGqdSF
 +ySBYE7E4a0CpSNlC6GGgPOfGwrMeUVshCdM2liaghAVcPF69QMylAeYPUIc2eDlBbRZT0l/A5J
 vERkbULAJPwxT3bW0dV3fnqj0X00lXQdSiL7sxiZwb01qxR1zX+XGjyGfP2nm31y7vJNTt3Pb1g
 yyZVEoS2SE9lU44S1PBS1NZyMbrWu8KHWJ3NtkDJve5EQBcqJe4kJCvqWEuBZudmGTaPnbYx+bv
 se1nOzWouaav74L8nOGYFxS+CPCAxCzaZ1BcUYEdZ9DQ3EAMXaC61OOkWbPZQ+ZPFZydGk1kQ/o
 VOBAQTqno65pINclM5H73eZNQIy3rWDQF476WxLpc6hGY5fY2s5OYcFgBw9lFfXUzHYB5WeoXct
 h9Tv0rP6qPkmlAqsa7tDZGnLAilKIN5d9kHLtdB04LSzG0vSTzfFnzTdsLrIaQ39oKlEV7YkQRP
 vGpOy8z2Jdc97Qrtgt3Ue+iVUHC83WYvyGsh/r1HGcMkOBqEBADXHbNEPJvu1Aa3YSRgvJaqy+E
 OLsg8E+SBMa0Ktw==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250826_050950_572869_30D8B89E 
X-CRM114-Status: GOOD (  10.47  )
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

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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



Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 649D0CA0EE4
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Aug 2025 13:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8BEwZHZ+L3ilTH9rJUZDkczC6u83Mtp4BtglFfrqDMI=; b=Lu9nV6ZTghGREp4j0+OhqNrXMJ
	vG2FyBDfRkG+Lf+SS0f1peT94lNFZqyGOEQFQPHOK8Rakw2OXNLVyDWZvLuJ4cXjgRB/H3Yk672hW
	K5K2bi1D8fBGkQ/4Z5A294zwu+pRywTDEJ8pJakWOqug5GiQlNFMEuoeDpyoYt1IE14oSipONHta7
	gvLu8X++EM1yfJ443ebowK44JyfcISv5Vew4DujcsbIwjc//WECkh95lPXS58FpU8PLLZbyRKjx/J
	WnVJmLpQlcDp81IteT8gX0h6Zi9f0o/rPUhxNmg4m4zv0A5M7k7yn9+jrD5oJ8Qjw+u4O9W3OrZzQ
	XAJwjQsw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uo04A-00000007VjA-3uvv;
	Mon, 18 Aug 2025 13:38:26 +0000
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1unvTF-00000006xqY-0mVS;
	Mon, 18 Aug 2025 08:44:02 +0000
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-2445811e19dso29384425ad.1;
        Mon, 18 Aug 2025 01:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755506640; x=1756111440; darn=lists.infradead.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8BEwZHZ+L3ilTH9rJUZDkczC6u83Mtp4BtglFfrqDMI=;
        b=ivmw0tFsP4+wJ7obFuA458tPJdXfmfXIWEwsITfTSp7b7p0hs3IYHUub2GDzXs0KXB
         0SdLmj+1/fY7cm9nds9a6bEZIEO5XI73sCpQkFhl57C7hnmhQHg6GACRKpu6xiLG/mHv
         5wLAbUtSJKDtkmajkWLXHwLuoWJyjR3k9J76iUMUM2grn6vKJu792L3a6OUXGj62mC1R
         fFknC0CNdRGP7k1zSuV7VcXLhv3NUL/XizEA3kpyUrKxqTzrZOTmcEVDgNB0PCchcJUz
         YcXiQapg6lvBvtIS6pHD8qs0YuL237rhhvrgYQsOPo18ELJBfjCrZEYixWIRF/uu6oSu
         b8+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755506640; x=1756111440;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8BEwZHZ+L3ilTH9rJUZDkczC6u83Mtp4BtglFfrqDMI=;
        b=gKFT9JzokzTjaSXO5pLo8Q8hknVyYhjjKbFm6wpUcroFjL+/5Pc+hwdZdeFJsWFNyo
         fWHWP711iAlv96WFco9CBY3zwsdTCd0u+FzzKCz1FLqbezsJi6RIKrgf23tOxFG0Nh4P
         wPOMMxqBiD2nYIotw/GWZMb4ElWNoQVkgY2PjizOzHAKFxFgTQUuOCV+Wff+zleJ80Cn
         OgAsPTRurt+3BlmiVRNr38WbIpA3UImT6fy38hadVymQqhCpIs7ZdQDkeqMAKFpOqSaR
         oBtFTJ4i6pBLoBmIMrfVmiAy+EZtUscJdVjFZDalbnzgIPv5WvQh3EN3AgfU3fmWkF4P
         DiKA==
X-Forwarded-Encrypted: i=1; AJvYcCW5WfP/bDQwUOHJgxMAWgQe1YqbQVEZzMjRX3eNyF3ReVmZhb8EnRJyk1Z2R1TFdNpQjvQnQiJNXhXUJQ==@lists.infradead.org, AJvYcCX7zLqTtQxQMZzXPig/VP/E/LbQTSt/VLSRFJGbRvIHmHKiGcyIOgdQJ4AP8S8ejIh3USNTQuRwGvEKTxabbpjS@lists.infradead.org
X-Gm-Message-State: AOJu0Yzq23vC8OhEaQQ9/t6/HLVz/2rOxSaMP+wLgwFdlRiXHIQo7/k2
	XuthhihfTWba0MNkKRcuPZe1KamqW/KwINb4FgtYufhaT75T8QCFp4am6UBBQA==
X-Gm-Gg: ASbGnctnDdTw5T9CfdCf8qkFhi2Ubt1/vWyEMBYZCuNWTKA2edeaDU5mOoYlCG2jqyF
	3V0ueOjds3z/fiqOSrRFzpWuuL0ieKSK2lEhI4L5uWR9vRG/xGkFUMxYmPcXTc7ejsXsYlPFa0F
	dwXbHo6KCvo77oPYr39YNsinFLDk6sNdQQTiB0KVeEQdjK0Hd19fbHCtgbvxF0S4F/u+JFkLmof
	vzxnH5/JLogr/2C2/hu7H6H33IYfygS88+WPTrXi5271ZwD/KWxwM0MYeOuzKu5Z5dnnTXHTaT8
	X4hxJhbSTsoqXLzkUAjAz0Rz+HfXcO4Pzi3cMbFxVCo69EV5VKFWyXn09qLee/2sNLk8zBhv0dx
	2fOTCTp9hyy5cbnyrl20kKeFrsgtCt8EGfoScR/ubEg/BuEo=
X-Google-Smtp-Source: AGHT+IE41TgaDK6U7fh0y68RK4M9hHY2iTY9/syz4IuIq1e5ai42XH7ZdeIfRSVEhQVGfnthb5LW2w==
X-Received: by 2002:a17:903:2304:b0:242:b14b:15ab with SMTP id d9443c01a7336-2446d8db8fbmr133100255ad.42.1755506639947;
        Mon, 18 Aug 2025 01:43:59 -0700 (PDT)
Received: from [127.0.1.1] (061092221177.ctinets.com. [61.92.221.177])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2446d538f75sm74090925ad.108.2025.08.18.01.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 01:43:59 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Mon, 18 Aug 2025 16:42:59 +0800
Subject: [PATCH v2 6/9] dt-bindings: nvme: apple,nvme-ans: Add Apple A11
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250818-t8015-nvme-v2-6-65648cd189e0@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1310; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=UCisHMuxtAwW4uphlmL614TcUp9WjlCZlTIn0NRlWVg=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBoouel76WKJHT6a2iEtG2nIQSl6p8GRmIT4TNIr
 Xm/tahu1kuJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaKLnpQAKCRABygi3psUI
 JH+QD/4iOQllLnnWwQJNPY5oL2ee4utIpCyxF094977VkZE8cu11GVaSzIu+vwks3UlOctE1/vh
 3M5vIVvKzCAQdKgP/hteJAXI4ORPUYXNdTy0OGn0Fj0uB/xNFWrkC9sMhtE9lnNb0GBc+lL5PzX
 RGnyCP5QXVmM23oBXVe1OaGgjfnOtpIbNAv06wWJv/Bl4qucj7bb2LyFmK8cXM1IEcT6agBzpv7
 b3foA51U1DraEa+d9Jq5zfc7R8mc12vXcAhEpS5o2iTxChjW7Tb7L+sKi27pyQaOzUJE6UjNRqR
 9gzojiBQzVjS+o2+JfTYJc51+fpoY1nNpg+nzXM8Vm5Ab21EQQqPAPdfEPWFcyGN+suIvZzPjVq
 0yN1QONYRLODY4YCVDVoM3inRzp6FzDavxwbyWiAhvX7vjEK9iIRXsLK5rDDAJC3HshOp9sKivR
 RLSUkoEnaJXWpCp5ImXwpGlIH+10suCQBDMDaumHOdCRrVXFOeKa8dl+cIYlw0zCoYk7aocXFtM
 grLxE9ZmZj0ZN3tyetAIMhWlwioazCLlA1Qnf9BSbpYmaZWjWfK6hrPH9WQ5SZ0zlL6cIlOdf8Y
 NVJIkscN9u+moAMEN118ut8e2Id1o37RLIs4oxboX6NH+MJLeeNQkCp3eHUzWET5DP8N28r+TIY
 vfsSluB8+N4II0Q==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250818_014401_228579_12F2E766 
X-CRM114-Status: GOOD (  11.16  )
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



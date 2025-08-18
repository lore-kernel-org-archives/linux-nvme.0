Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00E48CA0EEB
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Aug 2025 13:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FSMLqQCi3JFRl+5II1bxu9Sm2VnKzJTs6Ar/7xglwSU=; b=pWsMp1DFIy4ds/tH3UBxRFNVIE
	M4LPFURnWkuohRFY0V18b/0+0O9nKuM4I3l564kheJJXtTim3fJkJc3tLCDg7mXIfCKk62NZ58HGU
	UPxpRSCfty1vOZ+45mgygZ5nbU3t0y5RZGdQTTHQvCSVkvkI+R1zpzUKPGeXrdxumFhRaTRMeE6DD
	Tg4HD2sWbmtFqZoRoEXJvqdqkwNUfMkdyAjXe4dNmCCRZp5YHyh9GTyajU4x6A4/gMOP6U2OgELVM
	DHzRJvCx2/TikqUoFEnCswwcUP0EmnIknhNgCc8wPcah90DJH8PVqrjP38olK2JnsD7fMmcfKV+OL
	aUQtuOFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uo03p-00000007VCe-3C4W;
	Mon, 18 Aug 2025 13:38:05 +0000
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1unvSx-00000006xmM-2104;
	Mon, 18 Aug 2025 08:43:44 +0000
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-b4746fd4793so583778a12.1;
        Mon, 18 Aug 2025 01:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755506622; x=1756111422; darn=lists.infradead.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FSMLqQCi3JFRl+5II1bxu9Sm2VnKzJTs6Ar/7xglwSU=;
        b=k5limToMfHZG4payS6DOfAec3w9rfMkJXveisHrO4KKOEIKLu1NKKNohmZNjNnFS8T
         sD9NbCXcPKs/MIDLFoPB9ES9rAbLcE9tcVXamzgvgkjA2up58a9C1erKLzkAy2AaCOWc
         6X6kT7Tg/Szk65b7u+Oi9Ahg/X6iXfDGmhEKKtJeRQezfTxXCmZI9/15L0bNh1deRTYx
         5aqNSqwufZa04ZWagPqT+5YcAG5wUZoJOHX7HMTi+0iNnhd9+tI0MSY72nINBr5gYyk1
         dQoHE6YYQbUhsJ7vDIyvz6HdPYNXUMtSxSDRqV2Pu4quP+saDC9uITvnC8nkINqJP8LN
         2/UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755506622; x=1756111422;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FSMLqQCi3JFRl+5II1bxu9Sm2VnKzJTs6Ar/7xglwSU=;
        b=Lp0NAuqIpp+xBZee8vqud0SMZnwZ1Rsp1xv4dQw7B2XbFLKUTx+wolJI/66ucHLxFb
         8JPeb1SiW2NBKl1Hq2rroaQj5F4vMpvXUtz89WoEbedphAaWnPunC+VV3/Jcx6AG+KH7
         6nW8SyUJca7Y5oPdS7RnAWY3e+i4vgRD3Zecv0G9qzMOe6RvYZyYwNyDwtZmijgvV8Jd
         ydIBlOOFl3b5zcWEn0hR85phyhc6Hds0rqy4E5sSahuw5BJguveNasfC6E17kPO0Xnzb
         ytpB1+om0oeCf8iCxE/bIpXiPQhslunclTYmdbAzPxgdWVMlxHFQpZxW+oWSizzWkEd3
         haZg==
X-Forwarded-Encrypted: i=1; AJvYcCUwIgb+bSibjvxquTmsLiZUryFoZcfcRnX0HhWx0Mr259t9DiN+L3Mi9m0kfSWPIqeKIhBUyUdGpGacP/b07Zky@lists.infradead.org, AJvYcCXrznH2ME0DnPkwMO4cCPLjFiHtB5i+R7R7lvanmAzIJTuCUs1DahlbAekl97bURkHjgDhZO7S4BU2n0g==@lists.infradead.org
X-Gm-Message-State: AOJu0Yzc/qWSMWcmiy2iwrhwauB+E2Jl4XSvWDOaVrV8exNIFSVfvAVi
	dCJNVneLAMk1x2cPf3WdCWemSQ+LEo6M/iPUAW7gJDGtuXXAg+qmGlY4cePKUQ==
X-Gm-Gg: ASbGncu+hNfIXHSvMspTTgwG4umqBS380qdN/8PR0/uGWWo2mrF/v1CNkyD4dRhNAHP
	cje1Ve8D/clyvl+MFkurg5r0+pHSwfMD9VHYdAjSlSSnUKXeU9tsKD4pr4KGAOS9T6E4WDVrzR8
	fuZgYB+tM+HsxNQsgyq8eCYV87pbNaBWsGStAvwZgSTQ6RTaM1JvihBqAjuECYtv7fnHikO7nil
	foQNm0jRKhIT78EEvoKJ+Fm4kdDUUTu4XyHgSGFhaQEQsi/7vLGcM/ULo6eoKxnyqpjmO99sYbv
	zJ51dFJar+hSLNCRHIlUFz/X3OOfeqVwvOot5/pjD+7u1Q6V/m1GG/f4Z+XrAW6XSIv+Uh7+aGk
	K1zUHHW4IOrNjPJq84MXc2LhBOT+RYv8YW8EMy8LXgdgH1K0=
X-Google-Smtp-Source: AGHT+IF/h6xzRZDylkBa1DogMzbFZ9ZNolM7ThCwkCRwLY7MWhdX0t6RGaQFVvUpBph9fcpGuIpgGg==
X-Received: by 2002:a17:902:e549:b0:234:d679:72e9 with SMTP id d9443c01a7336-2446d5b8566mr181472805ad.12.1755506622219;
        Mon, 18 Aug 2025 01:43:42 -0700 (PDT)
Received: from [127.0.1.1] (061092221177.ctinets.com. [61.92.221.177])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2446d538f75sm74090925ad.108.2025.08.18.01.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 01:43:41 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Mon, 18 Aug 2025 16:42:56 +0800
Subject: [PATCH v2 3/9] dt-bindings: iommu: apple,sart: Add Apple A11
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250818-t8015-nvme-v2-3-65648cd189e0@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=819; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=wfeQYcQCRdUqIZWllk2wZ5t9grHRAxtFZe3NBrLJiwM=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBoouelpFr7oTbmVaqjHTmHzVQtKtTAyaoCZyIV0
 OEs8q6LnoSJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaKLnpQAKCRABygi3psUI
 JN/tD/9YeZd1u82jIKk1o5aqzHcZaPiNzKg+Z8D6TaUSqhBLL7SGu2a838sevRrqwkrDU7zLaoI
 NCBVXOvZdrQiGZppjOMBYORwUy/a7Uh6KguUxykovjG8WacAQ3YOG5WMI4YLNp25E/F4iZKqG4g
 bXdczMVA9rQnNTvzXJNknC/PAfCBHOHA3ltaNyToYPHcgtp33lVD7ob8TFb2ZUNfSsOiQ7b5tB9
 wgPDPrjV7noCvwZBkJXl4GGLAyWrZN4jY7GPjEBXK8555ARCvnxLVIDfDgBRFSRChBA+rrfDoTY
 OQ78//CizYG0morb5ebeb/yaHmFqPSV1vUgfJIH5rkJ3IkmgmxT9ayoRkHROpAGEYTo/4Mw7yq4
 PBJHTKDLLR2vrZ8ss+K5j2GhiPyuU+/bEUaLxaL+lTKVM+z7jgJh4MeWefGyDiJA2KlLrF0vNne
 e9mFmfbexhzoU0orpmmRyJgqoU8FFa1acrsQxjqFhrSMyAuHe9bnlfVB7aOWEy+NFqUQkKdtXu3
 M6jjXwXonWLea08JMf5edO5CQ43opJy/eEHPLzZiVBUCCFBXRDVhf0zmriUvLaQA6uTpu0GinBQ
 DOGBa5ptbDfr2BsNhfKWIX3adcZ+ApxFpbR4arO3tIaAaZsAX/7ibE/eQ5p8p+qrVPRnb6XPRxu
 jAf1llI0PaMFEyA==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250818_014343_526325_54A998DA 
X-CRM114-Status: GOOD (  10.05  )
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

Add bindings for SARTv0 as found on Apple A11 SoC.

Reviewed-by: Sven Peter <sven@kernel.org>
Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 Documentation/devicetree/bindings/iommu/apple,sart.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iommu/apple,sart.yaml b/Documentation/devicetree/bindings/iommu/apple,sart.yaml
index e87c1520fea60a2de549aa8a469fcded52e3b6e3..95d55ec688779bd52b8aef316a4c1ba7b7449574 100644
--- a/Documentation/devicetree/bindings/iommu/apple,sart.yaml
+++ b/Documentation/devicetree/bindings/iommu/apple,sart.yaml
@@ -29,6 +29,7 @@ description:
 properties:
   compatible:
     oneOf:
+      - const: apple,t8015-sart
       - items:
           - const: apple,t8112-sart
           - const: apple,t6000-sart

-- 
2.50.1



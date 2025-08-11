Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDA42C87FDB
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Aug 2025 14:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lD/WrxSX1/EFla87ahcJA+QqQVIM1RkgY0PCe9xlzK0=; b=2+pPAc+tWpFSxF3ZlzluWilc4G
	I7cCpRatdUe80xEdrg2jjPDNUG4GB/EtvldncFzBAsxaX6mbjA9OXfUrjLbdDoyPV0Nd7TNGLJfKg
	at/G5tBBwqZacmNPT9fq7mXx164XBhpvKNUHFzBplZT7X+xHU4Rx5dwGNpjNZPmGtsCPVxOPz9X4T
	w5aDbfN1EhLclYeLt8T20/EQMml+EtXNo3edKSdpX1G7Drd1RlOKweqybTKoK1o5E/L10wCoUMI6x
	kBpjAmdCVr2UBraOaO1pCUEzHCy7Y7po+S7e8Vin73ScnucY7WCJRuEsV2mzoGBlxRWjGRsnVZfZt
	hTXLI4Yw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulT7k-00000007wAZ-1j0A;
	Mon, 11 Aug 2025 14:03:40 +0000
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulSw6-00000007sym-0C34;
	Mon, 11 Aug 2025 13:51:39 +0000
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-313bb9b2f5bso4803139a91.3;
        Mon, 11 Aug 2025 06:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754920297; x=1755525097; darn=lists.infradead.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lD/WrxSX1/EFla87ahcJA+QqQVIM1RkgY0PCe9xlzK0=;
        b=F8v1CnkW8cyjClmrPXfgE5XRN/YRq6fExnh5/QATTOXkyVMFBgkpfB139iK5ObPkTD
         EN3GHux+pt8okvijcg+pCdbZd7q6f94sNySkAwYjX2cXVCzXpHtitHP/8hH7NxJo6Z5V
         zy9z5dlQb6DwbM5Cb71W943Rma5EH3ZgfBD7GM/tMaQDjQMnxLH6JsR8y0BnWxHe55xM
         5dTqqO2rXqagrQzOrAl3W5hXWQpwOd8PMU/0qjxQvtdEyR9oENQMCBDOEXenJRnxUQG+
         m5AafPIxAA3RWt0ELPSj7q0bZttUbc27f1Pu3Av7kFkE0+gvZJHpmBfUwoBNhJ58u3Kr
         ePRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754920297; x=1755525097;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lD/WrxSX1/EFla87ahcJA+QqQVIM1RkgY0PCe9xlzK0=;
        b=boHgjkXl3JrLIcMAnFEAnUXd9rgLj/CkSGH+e53eIFjBBpj2+i2wYEA2lHJiAegFdh
         dVLqbrow/7JlhzLOi507XhSe6uVbajMKT7jpYkz+O5d7o4fWhmoSTUKB7T3ejJvZFEzd
         FosrlgVIlmJcBCn1WCEZ5yHxfXnd34VQY6/dAphg2dkFRWSQ2Zly7ovYu8fL6QGfqrHm
         k7GfMBV2t5WK8kbWlepzydGp47ivy3VNoHImn+r0doqquHYxiHjQan6LRjU3hpQRn3BF
         dlocg0iPQnjnamTkU1RNZ32uglUvE3Ydmc7ouZH6KXp3vBBnHcxl5xYiJyzqOvkJi2Jz
         TFEg==
X-Forwarded-Encrypted: i=1; AJvYcCW5Oa+eZrHC0iTtRG0PTvhQFfN2sFiRlU2l+GQYQodm2aUBIOGVSYMr9WA8QBgjCUxLNTNvRJqpexJkpA==@lists.infradead.org, AJvYcCWo+2a1nnItqvdNiR/ewLe9a89a8vR+lretS/CGxjwAY9z9i9GehwyjfNsG0ZcQoChE9bKmUpT+z7eQr9pdBJ3O@lists.infradead.org
X-Gm-Message-State: AOJu0YwJ8KSHSncxck6Q0IlG+klwSC03m5D7eCRIyzX+X4jDWv/5l9er
	xwFzrSA9A173YUiOFb1lF+yz8UBwF0Wh1986NF4S8jyFXzzOwtpROp7S
X-Gm-Gg: ASbGncspPj3Wuyn9I64g7DtsrL5mk7L8EaAv3zhta58trsE86AKyfbqKnBnbffBKHa3
	QVzUcPRhM0feyqjZdxlWF+0WU5QVRxWRgFKeQWgp5mWnwMuBWy81zjRCBsz0j75Zxd7SK2gEdmx
	PmAqeI4P0yFPQBONfzDoYno6udX5A2mwQLPGkAVS59vmNYwh2dMVz5sof3TjI9hVtV20yLMgS+P
	yDaLA7jwO5lh1C4JzAx34ZfcdhAHmnZB1NXRrIvhIeMEB5UEGZY8Qye5lTsN1d3TNVCWeOICoPC
	IqzcLQpkKnxzAXp50d45Ur21oM0ka7mMqij1mhCvPKsxDztGDV5n4lUnWF22dZxfriJ2Y4l5TEk
	W523euvdMEKylYavYvwzo0rYzWqD7Ih9bDsuNU365HzFHmn8=
X-Google-Smtp-Source: AGHT+IH9KDpx03ywNJvdLzBAfBlJLI4oeKmVAO5UR+drZaqVUoplxQq1MfoVtn8zvLDNwTwHUy4OvQ==
X-Received: by 2002:a17:90b:3c49:b0:321:75c1:65b2 with SMTP id 98e67ed59e1d1-32183b45760mr23917637a91.18.1754920297041;
        Mon, 11 Aug 2025 06:51:37 -0700 (PDT)
Received: from [127.0.1.1] (061092221177.ctinets.com. [61.92.221.177])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b422b7b2700sm23504993a12.15.2025.08.11.06.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 06:51:36 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Mon, 11 Aug 2025 21:50:55 +0800
Subject: [PATCH 3/9] dt-bindings: iommu: apple,sart: Add Apple A11
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250811-t8015-nvme-v1-3-ef9c200e74a7@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=776; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=WsW9yxxkWE67nB6JIFQv5v8viYACQD+qfWrPx8gpdkA=;
 b=kA0DAAoBAcoIt6bFCCQByyZiAGiZ9VCgpq+sLCPb6h7skrPDQfu6PKhvLP5vmejwncunolc9M
 IkCMwQAAQoAHRYhBEtSeHhcl6z3nDxogwHKCLemxQgkBQJomfVQAAoJEAHKCLemxQgkx/AQAJyL
 UoiKJly1Puh26oQIp/eE1rItZVtYiLLcwoNLwy26TFIVgQpbz6CwutVT7YMNMFjKRGST/KXTVUG
 nNOAq9f+JPjb0vKn35FO3X2RTUudGt5tBsN7gP1WAuHwL50pVLUpwlr5mOmUEnPoxECo3su4Gpl
 u6D2Q+RHjZKv4m8wH223Xlww9RFi7gOYF1LDYJg0Ijn2n6NsoFB8NnSGyN4R3exhrXw3s5ByJBt
 MPiEHWglVMs29eju0clMKjW9fk8/3C/7UP+rJ00B0z7tbymKxWlf7joJREw8NY9k8DMow8DkL6e
 VXRkVr7XloyJiCxp7K3knbiafjV305yNWNHCFKyBPdySFHfSdGdac2y30TXDK2t02z0vQyE3ily
 7jGglW73k7b+fiU7tn89oiTUbdh9u4JbjrXLYuLejcmBZRpUyY4D4K+HX0mDeGy1NxIMG19xZRn
 7g8sNiuG4nsROjMUz4hvB6p8FxHhHtT9AFVtEwYn1sbtvrZSiLTKKt4PrVyP4C3OWUlkOFwFAoR
 RhLj/kT8mq0Knaubp168KQbr7/vRLh2CvOu5/HVVjNsR9hRT4u3udves1TxU/nW8kKzsc/YFt0p
 TTYNHDSVKn/R+NaPaAVYFQqZOwMjKMB9LHIgLvQsqLD9rgK8AaxdU7MR0iKg7wjOvLYTGfAXd3H
 cYc+Y
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250811_065138_089340_CF1AF080 
X-CRM114-Status: GOOD (  10.27  )
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



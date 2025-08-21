Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 077C8CA0EFA
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Aug 2025 22:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8BEwZHZ+L3ilTH9rJUZDkczC6u83Mtp4BtglFfrqDMI=; b=rXtKGHsp9pBWvBKRaa80gDu64J
	7d9oMLA7XfazBaautv4/rgqGd7GwfVAmzB7yEFuRBLzwqNaisxCwOKQ3aFVNe2OlyAxgMuubWlYK0
	10PTbEwWRMMKVs9X7UaHpzMofdhQOAWNXBYta+i49KXDboYxfGl9dH/fELZnnLRgB/wg1LFiUGPCx
	81jvHF+9rVECopS5bHqtwB8QBm0jS4DP94OnImyr70bVm+PuXekorRGCxLWshPOaVdz6OwBVu9Dvj
	hKksHUigao1MilH5CZ5DA/LKtXVk0EJK24M32TW+IqG0Wy/LvR+Yh9k9gMoxnYX7MNN8X6tg2eIHy
	rrj0T/7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1upDvv-00000000o6v-2S7W;
	Thu, 21 Aug 2025 22:38:59 +0000
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1up7fm-0000000HU3I-1Nr4;
	Thu, 21 Aug 2025 15:57:55 +0000
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-76e2e88c6a6so1122775b3a.1;
        Thu, 21 Aug 2025 08:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755791873; x=1756396673; darn=lists.infradead.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8BEwZHZ+L3ilTH9rJUZDkczC6u83Mtp4BtglFfrqDMI=;
        b=T4CZmpmppnnOq/U3hTn4CBpGHOqtuHbCrmiQFDwc7NN6pu/kuzMETrniCp5xZ9xeAx
         sQTEz+P+kjkgawGWeaJ3kkhDiaQYpo2cX3nDD6RteDm5eeEQZhiWx+R1uJZQdsDhulQo
         KYqZe80sA64ql9Z9ekZePHskqce9K+UOK+oK1+rvqYLuX5ltDEPOn2hVZX+qrBdlcNmG
         Ug5YVGTsyzm3FJLRcMW+mkIsc3idloOXqHSrlLmGK/nidinUIP1X1zN5ByYqXcCAYZ3t
         5V5eb8JvyKjc6+OGCDTbsSfB2dpJMZJWgXxWXdz4vRggs5d+qC6mOEHtSM7vlB7pK7tT
         Uryw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755791873; x=1756396673;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8BEwZHZ+L3ilTH9rJUZDkczC6u83Mtp4BtglFfrqDMI=;
        b=b6MbCrYi1oVVPJt+I/IUxDR9adgb+TPCg6NO2yANf16gFnqBWwEWjxmh+etd3Tx5Po
         tXEUrE82Aggje11wes+rXKtO05ffXPt2FkzDA72eti8D3wurvI/5Ei8G/i9z++6U7/b1
         VI2kTFSXrHNCjX113zgVG3MnvlJuaw1pAvXXsurYaiL7Kkcc8/V2eUWqIMyt7U5hY23v
         hBSWplCN1HKbjmHJ+XjOYAqf2hOhRIF4hL5OEoSorOJUUOJ3+ujvXEdAnhibC7TrRCA6
         Te1ByL17CwU/ZDSPge3GJoOI2OnWmAznJQXIO+89RUAjT9zFBB9fI303OFXGhuO7hwjp
         GehQ==
X-Forwarded-Encrypted: i=1; AJvYcCVR9/oCp/MNmWugnepbo01p7dNR84TMcABtsMnDllOpqHB13/BCK0laF+QDXcnWeLuPnOQOUQ2qt8twUA==@lists.infradead.org, AJvYcCWYV7gIfXtUBmmQjTUSxGmwyAh4RmjClF2HM94VuO94JXUnLRtEn2ERHWTlVAKZybE9AXUvzxlF/EsSpkaLCIiy@lists.infradead.org
X-Gm-Message-State: AOJu0Yy5XDsGDOujhMRYU01K9YJMizaKUgHlFNf9a2jgihOBXd4kRaQ2
	G//lbrMOdvbi9rH8zTJeVof3JPdALeVMUiR7hNkNeOwY8stfcpsiLx0d
X-Gm-Gg: ASbGncsYRnKFC06mZE1vryoY1YeQQ6aTL+pkKLu4WNoxKOKlcGweYtQMCdCeRJDLq91
	AgtnAjUr+9EjlBQRbuF3GFck99wgyo6n2jPcevdFq4u10XZjkbViHibVNa+FWSTKdnVAfMIlVNg
	olnOneu0V08T712yBOudvWCYn4B3yKhDKoyt7mpro0Q5wJ1RvNlwz8DU4VZnAwyCdFMQQxDi8yU
	epbmUy0/d/Sbm9tZzzqFKd8AA9+NHTQC5LbYBMXg4y0nVOZDa+lQ3wGmfcSAX3mFS/VyOiNW9l4
	JItW8Zl2joQN8tYS+YhZBFKjygf20lsuypUkV65d0djMASRVgtrVARWgBtaOUF6m+c22eV0RX+M
	sZnFYd7Tl1IGalDNVp/4QW1x0nTdQuRTx0FtahmronSGboDs=
X-Google-Smtp-Source: AGHT+IGl8DhfBnfyyRb/1wuIt4ZnuuK5v/ajSI18QqjSW5uA5+dCScmkCcOWU0FTW5Qiao6GY4NPmg==
X-Received: by 2002:a05:6a21:999e:b0:243:78a:828a with SMTP id adf61e73a8af0-24330aaa986mr4832755637.49.1755791873031;
        Thu, 21 Aug 2025 08:57:53 -0700 (PDT)
Received: from [127.0.1.1] (061092221177.ctinets.com. [61.92.221.177])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b47640afb33sm5094320a12.38.2025.08.21.08.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 08:57:52 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Thu, 21 Aug 2025 23:56:43 +0800
Subject: [PATCH v3 6/9] dt-bindings: nvme: apple,nvme-ans: Add Apple A11
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-t8015-nvme-v3-6-14a4178adf68@gmail.com>
References: <20250821-t8015-nvme-v3-0-14a4178adf68@gmail.com>
In-Reply-To: <20250821-t8015-nvme-v3-0-14a4178adf68@gmail.com>
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
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBop0HVe+SYcZ4v31RCzG+zBlarAEg9e5w9fD6uT
 6uHdqv3tdGJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaKdB1QAKCRABygi3psUI
 JKl0D/9L0mE7dXU2s95VtJEOhw9hiZJoAf0kmkheBDiq2ex+CgUM9689RXA8Q5UIFgqG3HwcT1u
 qdSi9MwNSV+DmDZa0NteXj/QA3FPkz2wu1qFqwGiTDMOt+V/nB0yK29xB6a8mkzdQU9BI5GvCtj
 8iupQqETr3cuFkQ/wUH4OfFwgxxN2TBlOLUPedcog2Esg1Gdl/oS4VKymOgOMEZTJkWWGzUCvH1
 Tb7gEOdgDmdt86gzbH4R8hC/a5NPIdw//ESycyj+0mAOn/CRpGSz1ql9cTzfrAEG5XjqAd76dar
 xyFOG28eH754ZioFrxEA4nbNtZkptM2JQUyxJrnafS7BkydNBN4ihW6ZXT6FgB59AVUT8CCKUo7
 IOKblLdv3m104dkriKSm5IN8RO8GI23IFnvmRkn7NB93PeEp8nc+F+SpZep9I+aODBxxnavPfBB
 LW3TVrL0QsMpDU3YzP9g4SEqFSswAzJDLKv/JR21yoFbYH5yZmaxtlcqk58X+apLffev2Rt12EJ
 tnQQKquhH/Awk+CFvyVMSo4sswgvsdXpdpjP5wLqW/iXt10Hfn5VTnpkFAoRD47IuJxfVdlR7A1
 B7W234hW/PkZgtLyYnAkThuEdXQHpKthI3H5Ht49QcHOXhTJHAWD0CDaO2ACod2v/gRFQ5+TL16
 Wmv/t0XQ1D945YA==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250821_085754_371212_48E8F46B 
X-CRM114-Status: GOOD (  11.10  )
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



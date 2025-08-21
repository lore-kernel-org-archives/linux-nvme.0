Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0E2DCA0EFA
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Aug 2025 22:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=l+TLtxQE62J5KV0O9wYqUJlCIzAdogQJTkJBjLbCxYg=; b=11Ofu8kIuWWsYR9RqTZud1pFZE
	ExCknEfI43WmJOp6DsKeQX5Q21JdBrCFXGMtc+8sQljjqMUJlrA2GEG8N/jRa4hzFLNzu93P+iIm+
	FZmyw7udAl9G5nCD+4k0jiqHxOAa4NHhTpRKifonqgjeWXwqH8UGVmHW+HHz/heo/HC89Z3gXhRjG
	m0ykfvheeiUVmXRNuddo4dLhckKQwZo5Qr+MLDU5NLVrOODbqpKftj9LczV88hGrs7nfubCJIjZho
	r3MNUVnlCobF5TKJe1D3xmUfVY4fYC9sPRvWxUzpBIhMoGZfjf2RHLTGp9991a065pUVRX5Wj5Scd
	wnxL/1Kw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1upDvW-00000000ngn-1yW4;
	Thu, 21 Aug 2025 22:38:34 +0000
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1up7fT-0000000HTyO-3UVh;
	Thu, 21 Aug 2025 15:57:36 +0000
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-76e43ee62b8so867593b3a.2;
        Thu, 21 Aug 2025 08:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755791855; x=1756396655; darn=lists.infradead.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l+TLtxQE62J5KV0O9wYqUJlCIzAdogQJTkJBjLbCxYg=;
        b=gYLEY3Mkd84TMcvCyYwjoCfuNpTy8sp2XR1w27bBFoC/B5X1rvFDAQnvc1S3gYWOte
         hscB9VLCURBvLDjyBaGd7wjySSW8XVBwUAhIvbcDW0u09Y8SwkL8nE005PNPSijrdUAJ
         TtOhXnAurcPWVIh0BOfxrMjOsBA6lvc/IDROtnry3WVU8CgF6gQi5Wza6UCVBSDFnSC2
         EROg6VNL1mj0mslNKwZWkiIkOQ7Nl5ovV9rvyhdMoA/awCqxatLkaXiBiNLWyyKjwSxB
         sbhp9JKYi28Zu4l6q6XyMrtvl/UWeV5wNrpZHVmqVUztRf0uQWtCzg3Trq7Qqb7rmF/f
         XbsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755791855; x=1756396655;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l+TLtxQE62J5KV0O9wYqUJlCIzAdogQJTkJBjLbCxYg=;
        b=o5GTBf7fFm0MhFQHcMhxBzOYaZgmfhgaPzqzS0Ah3BlbFYZzqSjcUG4RljOjPg2RRM
         oo0sbxr9aKGjXNpNXhZkKlndNzZUOH3cZ9y92o7n3nisFTYZBcIbTJLRsT55LAPPfgW6
         yuZnRjnTk874YPoyICzkX8uDH0VYGWIWHtSGJ1psz4N0/f00EYEJHwpeK166WDfHUQN2
         +O4iCF5ePIqLNUuXKFiDQwm/8/gTezHGWefSlHmMWob8CvXOKrG+51sY383ALIXGhgrf
         cIqEp3aPhFTgGNM9FYoXwgKF2LMa9MJPT+ra26p02j+IwHtSz/Ox1MUYzEXK7HDPyZlV
         IzGg==
X-Forwarded-Encrypted: i=1; AJvYcCUsLQov3NaNumGUDGzajaafC0F1J1++6h4F7veqCv5hZDFtpWYRU1OSSsH909PpNyGXq75tpaI/HZf/Oan3DBTk@lists.infradead.org, AJvYcCUwZ1wG2FoKGIX6IJhSovFXmqd+eZ3aIAtBxThZGpgAQ8L6GQqhEqpMO9cTDkoWoUAI8ucyVwFHgM+EHQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YwVMiTfAY4uwhNjFdW30J9xH4dUF2v77PqclMnMorvDzAE/1MVS
	EChxXyDmNh+P4W590WaIvdh245m3Um7m+NVvPLpe6aScNvYrD2k29qzCrywZqzFT
X-Gm-Gg: ASbGncvmM48qc1qlN97LC0x5oC8ZIJtmV4DCh90M2ALJ+D/hujwyxyf7dZ7oLc5Utha
	9fSGkIrX3ipwMFXNyCkhjXBxN2uRqdfX2zeb/KCNftu60mCHOACY8CYWX9r/ICTvrUsdcWPXF/R
	0eSP0Z7kWLQ9+fS/i2zStrh/LFNmOwb7yaQLFHl12fbya6OpLRdxHJSeJ454K7w7QBxG1xd7DOL
	Q4kwXXcBLXrLz2FYhlaIA2Np/P9uTGwZbNleZuO1VsFPqWM30LmtbEiPmMFvAZY1cBrj93NzBh+
	u8W3i3GzLW55svTqBPEIIKxsvFGgMpMWGOjEaOdA7MyKKFEjc+YCMpejIxf/qbqaW+u4qKRZUsA
	J3zdT2cvuseaL2gQx5xUCucohqWCNI/VzGaQsfxco+kae1lw=
X-Google-Smtp-Source: AGHT+IE0wcnJHKLEW1RO99lnzrgpQRtwp6zZL3gPMRllIkPxphhvBCZH1jAgYyHmbKF4OaX4kboVfA==
X-Received: by 2002:a05:6a20:3d1c:b0:240:1d13:ccc1 with SMTP id adf61e73a8af0-243307985dfmr3463057637.11.1755791854959;
        Thu, 21 Aug 2025 08:57:34 -0700 (PDT)
Received: from [127.0.1.1] (061092221177.ctinets.com. [61.92.221.177])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b47640afb33sm5094320a12.38.2025.08.21.08.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 08:57:34 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Thu, 21 Aug 2025 23:56:40 +0800
Subject: [PATCH v3 3/9] dt-bindings: iommu: apple,sart: Add Apple A11
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-t8015-nvme-v3-3-14a4178adf68@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=854; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=v4OiVJFsSwjODAdi15xQbBcLXhKlJm7rChMF33HLKjg=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBop0HUF7nwsx/EDWK2zDtfXq72ykV0AI3cjgEEV
 9AO6pJUDl2JAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaKdB1AAKCRABygi3psUI
 JPjzD/9ULBgNc5mV2zbwjOSGof+wpPmRDRKVbasRayoFp2Fx2wctI/7F7cyPCE9Vb3aimuNSW0U
 pm77OfK34fZPTWk1BYskORnZHyFhJ2xQROrBFLne7E6gwWbuMLUpjPKZmfWoAWE8lIRwLVTyLku
 hENiMjSDmjT7t0M35bgMOWz40E5Dq6i+tRtnIXcvjOzQJJDG9Ir+ZrIeTAd4vEbv0WPmctsct/V
 RsIJ/+zK3gDLE69ojf6Xe0HbaxNvpG9sHtNWnOQF95PZlahElyHS/2LPkPkGkcOpDInKxIjrY30
 UjZ5Mqwh4TTQW3MZLEC5kMcTxtLUDCVE0UJF/duROcUkeNU3yBuBnq0yrHGctbrNIouX0F3zp6p
 86G/vg3AXEg+UfoOz20jaB8X7S2FWgMdgS1EL7pL4zs+QtFMUOn1Ow18Pb+0R5iOD2AWMxNcqB5
 znSdFSuFwV649uwTBtLSrsBksi3V/C6HVYCr8jM5/MXKoReGZqVv6P8CQL9LDGmm7kdWcyDu744
 VDoxJK9wDnDuMojz046T1LbYdMfyGOkrBWJTKl0FLP3wM8BRu5GhXZi+2/7a5Vl6lWzi1fTg/+a
 TN2vlU5yiz07qwLCsV+1lB2m36dMV+/4uX1V5KpG2WklJxNn+fcBEXJ9ZWezH4wtk1Uw8QCIzrk
 dG8n95wcQFyR2bQ==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250821_085735_874187_355DA2EC 
X-CRM114-Status: GOOD (  10.55  )
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
Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 Documentation/devicetree/bindings/iommu/apple,sart.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iommu/apple,sart.yaml b/Documentation/devicetree/bindings/iommu/apple,sart.yaml
index e87c1520fea60a2de549aa8a469fcded52e3b6e3..c8c62f32988238c5dab93bdb04cafcc41129b423 100644
--- a/Documentation/devicetree/bindings/iommu/apple,sart.yaml
+++ b/Documentation/devicetree/bindings/iommu/apple,sart.yaml
@@ -34,6 +34,7 @@ properties:
           - const: apple,t6000-sart
       - enum:
           - apple,t6000-sart
+          - apple,t8015-sart
           - apple,t8103-sart
 
   reg:

-- 
2.50.1



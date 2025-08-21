Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD709CA0EFA
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Aug 2025 22:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4j3UGmCjPkpS1tmosPSouCHG7oP/SURnr100ibkxKMQ=; b=0n/8I+kFlaKfr9sokZd+7YHa5K
	O2lYATbedDhn8RjAU8tpts5OHMKmdbOEybFmhtICI0n4JDFELTDjWF4u5ClSXjOIwkyLpQ9JHridq
	zG3a9j7FYhlaQA8PyDMU5tlmb1Jc9hf32UQBHhQXBHKHoh7vNS8h5PholLvBkJd+M0SYKxDG1MCcU
	S7acjGHP+hSBAKThdLiqqfg+YvYKqPLFI6otqMNZUSqPPiBs1PfhAcsORUo93oKueWH8ajoT1wk2M
	wJXCnBYvB2X5svaQQvvC1pipLryezW61p49c8lJKUruJfdlwHQ+pPs4d6qnuQrfmLEb0fmv5qkqk4
	HQc9iPmg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1upDvF-00000000nMt-1Wr9;
	Thu, 21 Aug 2025 22:38:17 +0000
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1up7fH-0000000HTvq-1p9Z;
	Thu, 21 Aug 2025 15:57:24 +0000
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-323266b6ff5so894871a91.0;
        Thu, 21 Aug 2025 08:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755791843; x=1756396643; darn=lists.infradead.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4j3UGmCjPkpS1tmosPSouCHG7oP/SURnr100ibkxKMQ=;
        b=O7C0mDd60w1XX2rEarnM/36ZDZ5aMzTuldGSBWjIorbGZbkZwFeCKAX1yvsLWCZZvN
         obOrjJOGSKyrEUo1syYh9R3hvtbQMKJNuk7Inu+2JAJ4E4YyZuhBmpvi7XMOLaIfZadX
         z8Z/IggnIs3JlM7Q6tcJsHJOQCidpa1Xw+IV341daQN/Xq580h37/TImTB1gMSo7UBVS
         oYsAsgzauKXctkpvUhbLK2fsEaM9G/xUfJpsl8y8zq2mVHYZsOoqm/pkSvtDb3YHwKkX
         1UEOCnofOzC1nx4lbBHhqmoQzObqcQSqDVnoIwHZcGDyDQtALImt9AGAWxgRYJQodt3j
         KQGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755791843; x=1756396643;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4j3UGmCjPkpS1tmosPSouCHG7oP/SURnr100ibkxKMQ=;
        b=Tba358GqTwuBe6kkDDSSMekW4ly7BIE3GFoGzcHuT3mfm5+7J+GyT5Yf++PF6uaoQv
         K+gbWcm9fTu2vphNTEYyRath7zPsjUT9zC/OIUkF8FK6KmCObD8MGsvwtB5en0UFOIrR
         ZN/jqpIK58DrwYdCjMwOkneKi8kOMpz5838y371EUFBIR/ZWx0Ha0HHqWwKHQDcKyezI
         KZLDqHVECOmpUBVht4w59nm09eswhlBRTk4fc2x/nQz+GPMRpwUOJRjSTLc/a4i8IqwE
         RfuuhIpk6lhDXI+r0DywjzzlZIENlcIaQdpHqRqBnjUTqdIAHU3fBpJKYbsFucvAOmER
         1ACg==
X-Forwarded-Encrypted: i=1; AJvYcCU5z2/gKycnQZ7X8iNMsBfIeTKiF1LpaGkap5NCxLfExwoD450/RBLStyYHs2OpuXtHPSMgV38cseXdzQpdqGnt@lists.infradead.org, AJvYcCVdC00gibmQoI0RU3AlzwF4oYx+/VZ7mtKv4SAubhGyZOJV3lj7WhoFbPxJcPTVNHSZjqBP3+w0YmthAQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YzqJoShoLnqXIOnhLMiRvsKjuEOV2jezK2qVB6vIwgDO/NYdZ1/
	Ra46MUu77d1LV7R5gAvgX/mXwTe8morAJMFltCZf5JizR+YHpCqlFucO
X-Gm-Gg: ASbGncvEJ7FMSFjQtDqg9+hg1apNZ6jeZLUgfJKSHkhM6hBHLMbhT8BJTfYTBrRM7hs
	3GxvV4vXRWMUTxKHoPK/XnZr5tmDKxeWTghlUe/RnnQspHN3zfLVoV301bfWm/WI6H3/tdnzgT6
	xprRZsnZZWh08TvC3ldLCN0OJXX19zBH3FqZIz30DTz56H4kZYDhJ03i31a9b/eMrd8kEg4eFfD
	FIiq4gX1XFd2qE4NKJe+RkzWbOXwjvAMP+PyvF7N278d37a0wB0b9SUk/KS/BszlJuIcfoDdc9e
	E3T5vximejwIYSzjflyepLqkYkTy0+xP8+sUcVkV7C/1uzR7VyDxqpxwHY6qtEeL8aF+Obu9u0o
	r2FWYRX3vswf8DK3upJowS7JMya4LfdDw3ulxSAmv++PtxZU=
X-Google-Smtp-Source: AGHT+IF9e73V5L0GJ4m8c/wyYuFTuRvWMYZBEUvb8sVuZ4sk4ob+Qxwo84ji2NVWtD5/HFf92Hoh8Q==
X-Received: by 2002:a17:90b:3d09:b0:31e:f30f:6d3b with SMTP id 98e67ed59e1d1-324eecf9b08mr3700392a91.2.1755791842544;
        Thu, 21 Aug 2025 08:57:22 -0700 (PDT)
Received: from [127.0.1.1] (061092221177.ctinets.com. [61.92.221.177])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b47640afb33sm5094320a12.38.2025.08.21.08.57.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 08:57:21 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Thu, 21 Aug 2025 23:56:38 +0800
Subject: [PATCH v3 1/9] dt-bindings: mailbox: apple,mailbox: Add ASC
 mailboxes on Apple A11 and T2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-t8015-nvme-v3-1-14a4178adf68@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1364; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=aT4t5F2y67HWgbmENf4vzAFYl2ef4GaofSdzJe/3ZlA=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBop0HUUPbE15NZosT3IEFTJW+24ZWMhyU+JoV2Q
 WVUeBbwX+iJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaKdB1AAKCRABygi3psUI
 JGkXD/94d1kksoerwXSsMGQTysYOmWY5f/NO8PwqSESSbEBiHoUzVpro88j7yHlZRZPsLcHVgEJ
 fV3x+1Cx+oG8xSCvCMNjXkAog2MeESRudOKu1Ci2lJTAPOpqqDqwwXisGo4z8cyYqUcnrwBEItc
 UBgM+DbloO6ILChq0OLXgqRdrPKNBe79MljNt7/lDE5jOaNAv6O6gXwpisv2Hv1CrosG4DnzqdM
 ojiv21uaEkKAATAOBonffdQ8hCdiAUBNSOZ94s4vq0sewDAYLsNTJKbGvTerIXlZWHXv8wSP98o
 qXoCBS2HVRiUG3K0/oSJSTwGyCZKvQcAgDrmgVi+v6oUuX+7zmzU7CZziPDn6b54EQAR9SlDaCQ
 oZ9U8vQxAFyY6SH1j6siKQlLpONcSCCrwtaDZIS/KGGa1iWforS7wdL8SKUchqx0rN8fhI6xkFS
 2Ja6Z+0X/kwzFk1/1cUHj6hzczTN++6Bj03CUax0Zdu045eHn0o9F+ibkL2zVctLyUyqGYBuse4
 nRizdxC2T4CzG5yi7Pkix+hlXQaJF8qH8E8xcL5r1MLXI7IH0HYaCwrmOaRDmENWk3jNzZ1votX
 gJQT0L8qelm1fG43gboJ6BTIIW+wO0lpILMEWoshhZoeH8VCty0DQ5SJRKDaKUnVCJBZ5+s9E5L
 Twjq02ZQc7UuNog==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250821_085723_479196_329F7C90 
X-CRM114-Status: GOOD (  12.67  )
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

Acked-by: Rob Herring (Arm) <robh@kernel.org>
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



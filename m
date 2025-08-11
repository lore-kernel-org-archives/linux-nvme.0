Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B37CC87FD2
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Aug 2025 13:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ab/nfPMw843eKZIzh1MEFIjYGxeCe4JAvrb6z0G3ci8=; b=O0tlUEq8LbTmsYljd7JngyWd6Y
	hBpQxH6Z9Af5ipq9Ju3tGnu8qUWPGfwhojXrgPiJ2UWpolRNsbZcb73RL0UjEZUUgojBtChmCRdPv
	SscCw+upVJLlUHVURuWC6WdjJGaWhzO08kV7SNCFob0wYe4/DczUAN3tUefDKtWczIoMnDuXHulpD
	h3vsj+9jRGkuZT5bT7bdPNUyKxJjX1bycBeVMrSTZzTTOPIBoAKfHTfZezrHCBs5HsupQpNj3O3nY
	A3vc0Mh6jcAbqmbP9lTXlWBcWJYwi4kzHqBooX/fQ9HnZz7EBqd6Fqpaxc28byStrXfWsuvRzlri5
	erNpxKiw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulT2W-00000007uie-3Hj0;
	Mon, 11 Aug 2025 13:58:16 +0000
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulSvu-00000007svq-2OT8;
	Mon, 11 Aug 2025 13:51:27 +0000
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-76bde897110so3440931b3a.3;
        Mon, 11 Aug 2025 06:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754920286; x=1755525086; darn=lists.infradead.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ab/nfPMw843eKZIzh1MEFIjYGxeCe4JAvrb6z0G3ci8=;
        b=fCskhXGKvhWjgql4W51LX++Lcm7DjPIuIInJRTYcUkZt0Bjemc5KBtIjQFX25lmU8N
         mTcnVo4+wzow1sX61Nda8VXs/n2XoJpjW/5C3UTUJ5m+djpIxTtFnAYbbaVRmc0xL133
         Ebs6/XM4M7EUPWDjYZkw48Jf7O6n6wD53N/bt8X6cpJFUDeNHy5RBBGVm1CDpm4VcSy/
         9NTnMCzAXHfZz4CRbqf6SqaCSseDIY9WUIzg9T4ezWInjiLIwzHRqhqqBuZvoTiAAA52
         Vt9KiydILYTIIink5ywkiR+An06vyQytYjTJYjiOyIw22i9zaV3KSIyR8+I1Iu0YG13e
         zO/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754920286; x=1755525086;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ab/nfPMw843eKZIzh1MEFIjYGxeCe4JAvrb6z0G3ci8=;
        b=Z1Mmv92KPS21ohvS+P0iGqtY7+bIqF/3HHc5pP+S/VOBdVs5vvCjHFigaPat1mD6LK
         bw/Ndgx+I9a1Oq2boq8tfdOMZdeemJf5CVUx5fW7RErm6XMNWDnD7ly5AskRq0vJqiak
         50vS3Fk+OeMXJ9D1vO2xvjtvvX2/C0vcsfymiEh/Ai0PpE95Bc+Yow+qEE1Mutypbqr/
         amuuek97kXBA8ULedRh+AEB9Sie6rli/Uipir/nE4lzLFB/kGEt6yK5iSS9oqD75eZ0b
         /XB5i28gFZZdhMHVsS3itMWS8i7T25dkM9YO+gAX97jtdxe5JJX5IipSDzRMZ/jsfZu6
         Qdgg==
X-Forwarded-Encrypted: i=1; AJvYcCXOhAh0zeEeyW2CM+DvrxouT07PJEX3uocUiRhl0lmnqbXLVhffthtISwxHL2w0tG1OUe8ESh00Gg93Pg==@lists.infradead.org, AJvYcCXlXvLD69qqmr3oq4D4om9Fvw2EwsnUyu07l4KkEb0NrevWokJwpfGfqBu3FmJauMmR61jD1CoiyDGFlAzPRr1Z@lists.infradead.org
X-Gm-Message-State: AOJu0YwHPpn3VXe3g7XHdCLiVr9UP15Xa8lAF/kpvyi5v9pu9p+iBOTo
	cChITIPqmWWStJHwHF4baLieG6ioU/DI+bJzPcmTFHv4kmR6rvC9FFr+
X-Gm-Gg: ASbGncuYoX/TJuCTogjiUj+Sjw8pKpSyh9vKRCDR6IW9QLgv1AevOLkPLh3LQIBVmzZ
	wXBALaOpUpmTBSeomVUXrf1NOW6Pfq9Ke4J4/HlL/ohqUWVwK32gGXwmPissPBUmnVvcMxGieFt
	Q2e6RCPLGrtAoHJWaziKTIvPu35G/r5OphxJULEJQZxXv9C9IsaShHObqaqVpbH2Ecb/aD0IEr0
	+9XxDwQjksLqmRFXtqthxZOZvb85R3bY3XFRNjoTZZzfWJe6PD7/8OY1S+03yi6Mx2QWsYtVKY7
	/mS7Of4yRwpMsGliEIUCUGrsCdlCJj5Ri/VpZ4ud2JaeBwRdVCF53iUScQY0DXryKPJjEVVlPvz
	2Mvd0IN7GxYJqwacld2CWpscCxDbj5BJQFIpB3PXftlT4MJM=
X-Google-Smtp-Source: AGHT+IFww40/ClkPYxA7P/SDXLTgj031HhNn9dtfaoB7f1h4Mue1IW6LCE6otocYEXgs/2Rx3IFTPA==
X-Received: by 2002:a05:6a20:939d:b0:240:2473:57c5 with SMTP id adf61e73a8af0-24055160423mr20825244637.26.1754920285410;
        Mon, 11 Aug 2025 06:51:25 -0700 (PDT)
Received: from [127.0.1.1] (061092221177.ctinets.com. [61.92.221.177])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b422b7b2700sm23504993a12.15.2025.08.11.06.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 06:51:24 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Mon, 11 Aug 2025 21:50:53 +0800
Subject: [PATCH 1/9] dt-bindings: mailbox: apple,mailbox: Add ASC mailboxes
 on Apple A11 and T2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250811-t8015-nvme-v1-1-ef9c200e74a7@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1317; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=vsY2LxZcawhqMw/s5IJH3Qa/QDQv7w3VsaD857GZcqg=;
 b=kA0DAAoBAcoIt6bFCCQByyZiAGiZ9VCg1SNuFuRtQYHU7Ko65u2SjlDXr67OxKAIlhnOA/x9P
 YkCMwQAAQoAHRYhBEtSeHhcl6z3nDxogwHKCLemxQgkBQJomfVQAAoJEAHKCLemxQgkVBMP/3AD
 XG5579GsnDv3PE0P38gtqmvfnHLEICpLLgy06SxvD9gt89Wf72i8W6pLjr2QrSMjg1oHxD0i8UR
 jjfw2UXKN/IgSe4jLH3loLBm1aLil8sAF7P30v6N7OEuleofgtcDs4sH+Xb1vTuKOVUllFKYXcF
 l+zW7wJYGcXoLu78dlryBBAx53zZ1IDjFh6UoExBhCN8Meikn85tIlyDM1XKYU2fu/AeUhCGBjw
 +iNQC7imeTw9GsWyQ8E5sftOFV9XkcDJnOA14AS3in7IJD8DxXCWDtXwPDwUXBVBGytTaEGece0
 Ogzhyp+d7EE+GEPBNGbuhr35SAozALWljqHhmf61mILsdozH2ANgks5tVF2aD1qEjGFtQFkjWry
 ZDWoAHASPCJ5T+sAV+jp56pR/1tOU/xnQpJ4+ELmnn8MMAxS5bDd7eKUMXkQHLze8tvnwFiF3vn
 XqQ/B+RaqT7KM/Lf2mGO5JanAykB50OuQX6ccnpeAv7VU15GHKbbAXXcssCnV8HQp43WwjDvkKu
 etjdjXDbL38FRe8qM8xYloXU14WYw0svs1nYorwUEssHYemtpIJ7eC1JxyrlXOeRWP1a2CPZBYc
 7/RUGQYSK9M01WXO1lr1Fbl15K3rfRH8FvCPdvTwknAJ+9N2YauKyzdeW6ASol54Dnb7R1zDkG/
 /DWz0
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250811_065126_614914_F702ECA0 
X-CRM114-Status: GOOD (  12.64  )
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



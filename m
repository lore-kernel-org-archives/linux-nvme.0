Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1231CA0EE4
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Aug 2025 13:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7jrUSLF8HrmgX2IqYpc6hu8jyDWmvx8chNYfkelzvuE=; b=4WRpJG+3wnqXa0CSibWEDIipF6
	vBHN8zId6v14k9p/NyVwBQlCjBzx8s0lMDaHbFsjT6vtrJiS9n5Xd39tGoEACVtXOgy7LAA8CMYMT
	sAktWWmPH2SvUyCQfnkEXyKN5cdoLLtM5RHYFqYgZeQjQGVSp80VJq3NbobiIfHcVHZhqlT+JRaF3
	QgW+AkibafcBN5aTKHMddzJ08enuzKZEMJ9N+MLsMxw6heBPVVEOFfTBDVkfER7ymdc4nml5bX6Y4
	5jMAl0yiYFHnkzIzs3ZRl3zuOJ3ToKscLIobBhUXC/aM7p6CMdgn/8ihRimzyU5U9PRS3LA/zSCcT
	+zWTyKkA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uo04N-00000007W2Q-0am7;
	Mon, 18 Aug 2025 13:38:39 +0000
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1unvTR-00000006xt2-0Lw5;
	Mon, 18 Aug 2025 08:44:14 +0000
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-b47174beccfso3314642a12.2;
        Mon, 18 Aug 2025 01:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755506652; x=1756111452; darn=lists.infradead.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7jrUSLF8HrmgX2IqYpc6hu8jyDWmvx8chNYfkelzvuE=;
        b=fXPHNhYeo3v4aZ5bWsmBynYBHgxA9OEaNBMk32BCimgCnJSpIV7vCYte2cI+IqreMu
         frGcd9lIK0fDE44FkBepL+R/+pHGWj8albdEk/jGB/IfYKfQ0/Ym96+26tEbju4p9IUn
         O/6+1r6EBYNXFueML0U03xm4zCpJEYpFHWY4G66MstGmXd7PxXL/KcwKWbvAr3aLYs47
         ajofb12VUcPeVuM9k5L3xntREkI9n62sGqTGby8+424twc6h/vrZOGcifxUlCpZ/6KzX
         Ax/xkv87suoRNhHBUPjy7wx++6TInc5e+vHOrZrasDp57vO47madaadvVX08nKDqLQOS
         i0rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755506652; x=1756111452;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7jrUSLF8HrmgX2IqYpc6hu8jyDWmvx8chNYfkelzvuE=;
        b=NMEq6jqceJWrqedWwklReVkVW1ylE+/FwaMq6eW40mH0Po8VWJ1+z6G0oB3khz1H8k
         Q4Wsr4Z/Hu1szHIGLfM0U0SY2yOfJC4NCXVqOTip/OO5OUKF9aLclwojnjYcmcrTjd0L
         mTjyGyTwZLriNZbc+9rewVWDjBMbQcdDG0tvGGXbV+MTuvadGnqn03qibXFMt3dff5f8
         fqdg4r8MMRZIVOguKV0b8ZN0P5WMi1hXC1a2356Pc5Un7yS6iQTQOrF/zeCV9nMC6GvL
         fVeVkZfDBK00sxXUog9bvq/+YcbU10jjEHj7sAWxnuxwYsaZwhaxUrH0Okl4loBV3W1X
         o+4w==
X-Forwarded-Encrypted: i=1; AJvYcCUYTPRyiFNQXONeW8Waqyw+wfeQWfXh1qgDU6ZQuuPefTAMDpULvAxsq5oUyVByGp8j9Dj3sqHPFr/JeyrdCRlO@lists.infradead.org, AJvYcCXKHKg3xQuNwQ/CdqsWAe6tz0VbhQyM0mFjuiQ0OGY+rjG8l/+7ZyqfuxQv3auSn+5EhbNyNo4TM1Auvg==@lists.infradead.org
X-Gm-Message-State: AOJu0YwcwhMuxHu4DSatRYF4ipNaf8YoJlbCFDU0OIPd3YOHBySH9OuB
	+knyWNTploqXoJOhSqY0SH/frCH3c4dJDsuXkqbEXs7+xrmDXiM85FPnJSfC0Q==
X-Gm-Gg: ASbGnctTWe3nA2gEBeIdlnUycxFaHnXWiedsXl9C1fTVySu677bPRPPNTdjFEHiy0TX
	OYdMLcSelZM/3bUZQwZzBV9oxz4vR0J0hS3KoITZ+AnUKcoSo8WsmsOv10cW+Y1GVKqErQpE1wJ
	KbuEiu03UmIzS4bmJzD2/7JoGBfivhsHHCPP6C7WuFlGSchAr0E3xZm4QVemVOtretOePNCzKQU
	wwnEHwAdGo+8og8Dsa74GTC1iDLTqMb9sRQnHA16/tD7DZZGNYBjohnqeWNWaSmXG8vD1XdekKw
	Gf80bumiv1N6SW9k/dS9zKBBwWE1yLSWZXgI3l5xRIi+AiArzykZxs5fYW9eZH77rVcPVU+whZ+
	QcieHRMTQ8D7cJ6lXxAu5b4ovna/tPo/2t3ZsO7v+rKFbyXhzQ/6uPOqAPg==
X-Google-Smtp-Source: AGHT+IG1afPtfSsM25RsLVziBfnzCxe+fm/mDBbqheQlT6OGm2ccgvPEYnJThK+OOSerwaXiksOffA==
X-Received: by 2002:a17:903:24e:b0:240:8704:fb9 with SMTP id d9443c01a7336-2446d948463mr151270825ad.53.1755506651863;
        Mon, 18 Aug 2025 01:44:11 -0700 (PDT)
Received: from [127.0.1.1] (061092221177.ctinets.com. [61.92.221.177])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2446d538f75sm74090925ad.108.2025.08.18.01.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 01:44:11 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Mon, 18 Aug 2025 16:43:01 +0800
Subject: [PATCH v2 8/9] arm64: dts: apple: t8015: Fix PCIE power domains
 dependencies
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250818-t8015-nvme-v2-8-65648cd189e0@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=798; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=pTUWkvNCIyhLcProl9XhpfAEq16p+fwv6rNm58M87Cc=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBoouelWWJ0YeXG6dIWCt0vJagWW33XZSkjmaJ2r
 35WAX3kwK6JAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaKLnpQAKCRABygi3psUI
 JDvPEACrtXL7Qr/DBRGiWukhhjd/4Z4w2dKfoWc6FF9aC19lals0kztGvk/RjEmsDol5RmPErQE
 MIEd5GstMiWFW32+K6f1VMh4YNf6wUn2kaz1gexAQdk0XAYgAsiKV3AUMPZrN37GpzqBoyCht0M
 kFxcpnvdq6CBkOsu8pgnCTRBe8PLDtGJPMcV33U5PlJXfpgJYRRRhaZKgBK6NebPt7m/09uodgd
 Oc5veSeMzd3QzmVqI5AkGn95VcnN0lWiA5srfxz6RhhoOk/ixgyTvg2IreLOKLzDMXlhzmA9Xpn
 mochAQmxFSZ3ZF0znN91qZH8HrC3zNSpEvDN9RQ8YnIaVg2n2plKKlIha5CRG4PNKfwzbJw3J6+
 3ClQcpUcYudBkeCcyPzqczIqMPpQ5tz6aL1MolfiiV2Yt2dRCIuVPvoEZbhNKDaYuDej1nGXJW7
 EygOsTIebFypwkjFkEDvwnjjbsnMRO/I67936jtrsqXndRUbb+srPh4kGIRsmP6QUP3F1zTnIgU
 nWY75uqHxdfv/jJ0deQ0nY+wLSX/iH0bW3ZHz50//N0JRxxBpkObWScmPh3d6+w306mkpnXriD1
 fzSAYuwHgXJI6yMrpyZVw2p2KBkOdbiUiNvJ/rMIBgEAKGDQUu3Ytqp9c9Xe2on8hUxHM96fmSF
 DaIl4kv/gDmUEOg==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250818_014413_120212_4931BAE4 
X-CRM114-Status: GOOD (  10.49  )
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

Fix the dependency topology of PCIE power domain nodes, as required by ANS2
NVME controller.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 arch/arm64/boot/dts/apple/t8015-pmgr.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/apple/t8015-pmgr.dtsi b/arch/arm64/boot/dts/apple/t8015-pmgr.dtsi
index e238c2d2732f7944dc1f984a4eb647ba212b9ea5..1d8da9c7863e5b7a732888342de9d481f309edd8 100644
--- a/arch/arm64/boot/dts/apple/t8015-pmgr.dtsi
+++ b/arch/arm64/boot/dts/apple/t8015-pmgr.dtsi
@@ -658,6 +658,7 @@ ps_pcie: power-controller@80318 {
 		#power-domain-cells = <0>;
 		#reset-cells = <0>;
 		label = "pcie";
+		power-domains = <&ps_pcie_aux>, <&ps_pcie_direct>, <&ps_pcie_ref>;
 	};
 
 	ps_pcie_aux: power-controller@80320 {

-- 
2.50.1



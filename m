Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C7BAC87FDB
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Aug 2025 14:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=F9SU02hcw6WNKVO382VnK0doOc9DExiucOzxMaULtIk=; b=DvlboXf5TOtWo+UVgJHx3Xxikt
	W/7pO/woA7nbHfv1W27+ZqrzMz1cVae4yS/3LWqUh8cRdfIpq4uG7jmv/HwR9addRg5qT8DdmBXDx
	1DwyaMnFlj8G72Go4kDaV1hHdAtQJ0aEk4wi0gDpTiDH2UzgiXfi1E4lgPT6ZBpmPNjINu2+RKobt
	OagXUj5cnS0ExIMOhl7yJ7COcU92Z1aKhS/FFLewhM9aN2PfNTPt8REKjDspH23ZPMVgv7pMPzdZT
	gqcyXnSyVvt+TBWF1MVWSctzkK+gtZal6S67H/xTLcl44rDG8Vzb+xOMXmjGH4oClyEWBzpXqthcu
	3XFZz8Gw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulTNP-000000080HT-2BEp;
	Mon, 11 Aug 2025 14:19:51 +0000
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulSwe-00000007t9h-2AJm;
	Mon, 11 Aug 2025 13:52:13 +0000
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-24099fade34so30699855ad.0;
        Mon, 11 Aug 2025 06:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754920332; x=1755525132; darn=lists.infradead.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F9SU02hcw6WNKVO382VnK0doOc9DExiucOzxMaULtIk=;
        b=CXdOZs6QgyeO4wTYHHRH1GE/e6I8UtrgW6ndbI5duVq3KOhv5YdTMLCAXGVBcsvLRV
         r5C3/QIqyBDiLvNWUmW0smZ3ZWCN2NI/ygrHcYN9/7xcgCuflzmcmqJlsVjI05ACtDGm
         Kq5T4KKkZ0cI5OuoT2156NDJR3oLj3ywSkJheRX65InsYaY40eFdd3xGE38i9fAnGMvE
         aO8PyDVEEqu1w+R7EtRiKC1jhT0oxSM5ywXBSu6e7Q47HN1dZqt80gUkhL0O0hm2+gQW
         O7mK/agsAeyxR91xjkzSgDxtjtiZy4MCS2cPvIcEIkUvbkZ023gLYrmPXA0fFxOTmMUe
         cPJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754920332; x=1755525132;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F9SU02hcw6WNKVO382VnK0doOc9DExiucOzxMaULtIk=;
        b=ICZWnUPAl7bWEWnE17j9939sQ7I7XMxLiKxGamVZISQv6pr2qfdPLT73aiqUVZA1zg
         wWDW8afbV2oc8LZRvqXToLMZ7Y9ETkOnMCxDdAaD+F0q83kW5Zv0MjPlqXAZJF6GyLiH
         M4d28LZsNH42jIh1YOk1zRp7H1CDnEyR7Hn9efg/qgpCnqkEOmd8MkD7cT/KrSadsRGw
         QOSP/yys7AWzRJX8Z4Qk3hZ8g9MkgABA8MN63Q3Z2l4j0hvwlY3jclwYbQbKEpg3Z9yA
         D4yLJWj4Kc8WQBHe5zy/D48pcZ3QeKhZrbOYFZxkK1pozflbF1YVqgHtY7zxChYKUygf
         u7Xw==
X-Forwarded-Encrypted: i=1; AJvYcCUc6bA6woabb8Uefwug1ZZ7hwye1htws4GHjZrgNO4zglmnyAGDQ+Gii9I+sQeX1BCKPbAz+ZwWkRDQTg==@lists.infradead.org, AJvYcCVpVYWks7mSwV59QEO9X9Xb2LJ6qnMFOZWqtxiWjop7JGrhS0D6plr2/mRrWUI+/1MpVRZnG8pvmiBW+jeGDQE/@lists.infradead.org
X-Gm-Message-State: AOJu0YwzZvI7PIlXD/gVt2JPsvH/8suwcj2ylUwwL/1mvnT9o+8RFn0b
	6FdpBAW7ywSX2qHthIapk0pTcB7cNiX6P2e7LxJiZ2vY1ryf+2ralbE9
X-Gm-Gg: ASbGncsc0khXYD+Y5bQDqxJmrq3EFdTYdVwcTCpCOUTe3jYiMmW3Sh1dsLw7zK5kqLO
	BE48VjXXyNbH9dke4CHmFs1yo8S9n9PKzGxL3eDV6NUDoOzAKW4Sh2nYTQAmwaF88tlaaVIS+4V
	jMyU3WJAfimUvzq+o56HSYX3Qvzlky1SUpfT16xepb/obioPFtRp963z8af4xId29FYW5TqI0HR
	nbHVOYKEnH9luywWEhI5cWJKs+q1VVVAoT9YOTZkeRZbpD07aA/aAprTfgNHvSfp1XgmMZ2pzn1
	sX7TfeVplYL5cAZu26R7zn1DtHmVky7e30TDL8IiJtDVeSdtfLlGZLWZsKWiiBqU/c43Zsju28R
	YDeCKmOzSfP7dwvZi37NYPaE+FuVHTS+C9qvSTKqMf/jqfjY=
X-Google-Smtp-Source: AGHT+IHsxIyDM9j4Z56s2PC1p2LLkjNdobtNOeiBJ+4IdAtlR71OsGV/hp5bGiCrntnf6+2PClAPZw==
X-Received: by 2002:a17:902:fc87:b0:23f:ade1:2227 with SMTP id d9443c01a7336-242c1fdb174mr191343675ad.12.1754920331944;
        Mon, 11 Aug 2025 06:52:11 -0700 (PDT)
Received: from [127.0.1.1] (061092221177.ctinets.com. [61.92.221.177])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b422b7b2700sm23504993a12.15.2025.08.11.06.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 06:52:11 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Mon, 11 Aug 2025 21:51:01 +0800
Subject: [PATCH 9/9] arm64: dts: apple: t8015: Add NVMe nodes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250811-t8015-nvme-v1-9-ef9c200e74a7@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1720; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=W450nZF9q8zgSwZAzN00gO+pHroqymkBwDRdi0GaMOE=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBomfVRGHgf36cod0yWTvzYD2KxQiswdaxCj9aUt
 tnU+n5OXvSJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaJn1UQAKCRABygi3psUI
 JMovEACF05H0isL+zJmzsPyQ+OL+CT/ADfwinwpz+nd6NB3OCFBCrxMDJrsuBwHrK+qRDxrFkJ1
 MgPJTnTKHdAwcncxg0XAvPwwjkOw1mGsAlhdkfH0DB0PR7RBHQOnwn30fn72ANfuvmv5mibqJGS
 Nn0swtMKc5++lCZGmJCvsEohtABmLqP6NBTDOlw3R9iqYFARLmIThIO+G891QQkvmKHU4aE6FvR
 2lcw7W0MEMVTDi9HPA0IVC8FWoYEsiMeGm3GtSW5ih+1K0EK9YzJQjecCS8xhxEzi2IEWmDaJpY
 jpcBaoqzgBKLXU7haCecTUccUhDZGnr36FwEUG6QRye6WUNi1WFmdHHZRlWb4mhG4wokiqD0vSh
 TuA5lKdme1ZatKrQO5t1+3CgbWQrq74KScqjwSBm/LxHRw7gv7JMo0Xbv+a73FZ825cTjkNBj0X
 4kf8iE2o6Py54WsrEW5MlcWm0fTEGiTjmbwtcx+9Z3/ESNqTJ9kX52B8hqbbcfryK4SnPGmpsDD
 W01JLE+28XAeqkgCAHACHicCRA817HiQxJxK311b67cN1H/ye1nrD6EyF7qunCM3N3PPE0d1C/o
 u7pD3rg+pwSBVuwnLaYv+d6Elz0RWwHCtox3IaIF8aI+kv6mKysVNpZqVdd+5lbXGtrNeyavCD8
 CPIZJYWQS4uWqtw==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250811_065212_562031_8C52A44F 
X-CRM114-Status: GOOD (  11.26  )
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

Add nodes for NVMe and associated mailbox and sart for Apple A11 SoC.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 arch/arm64/boot/dts/apple/t8015.dtsi | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/t8015.dtsi b/arch/arm64/boot/dts/apple/t8015.dtsi
index 12acf8fc8bc6bcde6b11773cadd97e9ee115f510..84acf2839fb6279dcc956e1f4cee1afa909d2f27 100644
--- a/arch/arm64/boot/dts/apple/t8015.dtsi
+++ b/arch/arm64/boot/dts/apple/t8015.dtsi
@@ -402,6 +402,40 @@ pinctrl_smc: pinctrl@236024000 {
 			 */
 			status = "disabled";
 		};
+
+		ans_mbox: mbox@257008000 {
+			compatible = "apple,t8015-asc-mailbox";
+			reg = <0x2 0x57008000 0x0 0x4000>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 265 IRQ_TYPE_LEVEL_HIGH>,
+				<AIC_IRQ 266 IRQ_TYPE_LEVEL_HIGH>,
+				<AIC_IRQ 267 IRQ_TYPE_LEVEL_HIGH>,
+				<AIC_IRQ 268 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "send-empty", "send-not-empty",
+				"recv-empty", "recv-not-empty";
+			#mbox-cells = <0>;
+			power-domains = <&ps_ans2>;
+		};
+
+		sart: iommu@259c50000 {
+			compatible = "apple,t8015-sart";
+			reg = <0x2 0x59c50000 0x0 0x10000>;
+			power-domains = <&ps_ans2>;
+		};
+
+		nvme@259cc0000 {
+			compatible = "apple,t8015-nvme-ans2";
+			reg = <0x2 0x59cc0000 0x0 0x40000>,
+				<0x2 0x59d20000 0x0 0x2000>;
+			reg-names = "nvme", "ans";
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 270 IRQ_TYPE_LEVEL_HIGH>;
+			mboxes = <&ans_mbox>;
+			apple,sart = <&sart>;
+			power-domains = <&ps_ans2>, <&ps_pcie>;
+			power-domain-names = "ans", "apcie0";
+			resets = <&ps_ans2>;
+		};
 	};
 
 	timer {

-- 
2.50.1



Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45E77CA0EFF
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Aug 2025 22:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=liRBVRNyAnOklnxAr3VQmJBjVpYUwLEwgd0SLy2njow=; b=pUdRVkVZgwnSaydiHOxploM4/m
	P3+k/DbKXP5ECtJDr627JuywAJpuw9ZrvKFpHRu2n4KEAw5Ldnr4eK+3EqUZR4EwV0pG3Y6JB5I07
	NvDRlpZHExUSAFERnM7ShwlBdz7LaEUsOgcyD+iSIlCv0vm2LvYnZNUf10tt3U3pqtNF+1t8Si3Px
	8hEMXQ5FQWGbcpxXb0eEoOhHcR1DRey0LpO9VzNeCgPg2oMKyNWj4wRkizGm/fp4gHhI1OCeVjt+B
	U5LUIKbWGMmq94AR8aY+t1/yjmyt/C97DwAsk7J+UKDxYQtya2U/Q7/k9Z2XRsVJf4cJjJDx3+MqA
	OgKbnvJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1upDvL-00000000nTX-2nEJ;
	Thu, 21 Aug 2025 22:38:23 +0000
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1up7fN-0000000HTx4-1RWU;
	Thu, 21 Aug 2025 15:57:30 +0000
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-76e2eb20a64so1388894b3a.3;
        Thu, 21 Aug 2025 08:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755791848; x=1756396648; darn=lists.infradead.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=liRBVRNyAnOklnxAr3VQmJBjVpYUwLEwgd0SLy2njow=;
        b=k8EpU6jUunAeuirZkE34DhmRqVj6Cw+UD92jLQ4bZTBbaLuW/lE2WN7EMiPTSKnPnB
         ACBmLuQxvYtVGLVpOakXRXDY56FU28LvkdSlYbs8/4y2iQPHvIajTz3ZWetogqTK4WnM
         QGUuPs0tYpGJMgxMxvoVHk21BSxHGgrgvnB5hwz3u60RAPXSQLfLxywm09SOcPB3JS+T
         8dTZaFjZ5HE0hOyD/0s/vXtZ3qMhlNdJJCWJnHooxeguCYgoo+mV7cCunusfqhE64r6Z
         1hojmizai+/0DgOhtgD45uI10g2+uJpV9e9vrgZdFyOn2eeAumL5/sma1w6VyFR1DllR
         3Ieg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755791848; x=1756396648;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=liRBVRNyAnOklnxAr3VQmJBjVpYUwLEwgd0SLy2njow=;
        b=RbL/XWVU0IHFOcRhJaxdaCg4puD+PkjlAmiVdT4QArgYhm1vpRM61hG0uFrSjd293G
         CQgSylJMC5nrsoOmVLxtndB7Cht1j1rQla13O8pSTkZAyCzJHCYDJfkTcjYt6AYrYT8z
         klwbYqs4LmpJbN0SqPhhb9w0z4QlbF+OAGCQYOgIVQ3FwNtQ+7bpzMNrXkoSHpm35OsD
         aC9c5xXUYIDxrBPCl7303gw2FJLUtYMNZacgOfoLQnev4eiCLRxP/SDrH8aBtgVh6w4F
         RtVJIPnEleSzoAibEkdqV6hL0a4eRIM3McAjcoSNZnTxQENyi7JlyycNeXQvoMaIDnLd
         F2lg==
X-Forwarded-Encrypted: i=1; AJvYcCUY2PgrcQl8R+v9BKmM9NkC4OnYGbdwS+bFzlmNwgqHjlF0HaOyrAUF9iIsGQd3w4EfQ+Rj5kcekxhWNw==@lists.infradead.org, AJvYcCWf7ldBG0lCGEfl6jwTEdE4yXPxZgA4iaLw6TlbjLYQimX0Z8xQrLr9zWqT2evOUhZQcli6K8FP42RN3tGDNSrp@lists.infradead.org
X-Gm-Message-State: AOJu0Yy2f7G6Q7uU1ZNEIwx1UAF0zdQtR5R+2F4Q8kziv0xUdbZxntUm
	fRRa5ZcI2cV0gkSbTXWme1BZrce1SGFyF5Dhh6xaoh9u4SasgDhtN8M8
X-Gm-Gg: ASbGnctz1oet4zM7y0d+hpikpsB40qsBqZLUWqooM+MuJPsfr3DhbQ3hkBV9Pb+5R7U
	R9uqe1RwZY/g+vH2VnJB/nirNMtq9upCKQBQFBtgH9b5tE0XDl1JoOPGQXAhn0xwIxmjtBuIDWb
	bdxHRDVhlJKLDs+pXUMEaJVacrnwRsISScfwrUPrq8M44qtie5Gb2B2e6KXY3QJ5KJOwDfF0Ojn
	K43rv9GQYEALl4pp8WS/tlokGxy36ehbLBn/adPrOOmFJPsvMqh8Pss20Zx1WnMMFniX4MOshPM
	g1+74Rb1SxuiNL2Mi1HHBhhmyIQMD21NmT1kXo1MouGBfYhiEgGGLWLTX9j5Y3uqojPAK0oMgnI
	2uZa1Fh2n2JKvuAQReYGZVIQENmpFarAG1SuZVPq3Ix2WB+A=
X-Google-Smtp-Source: AGHT+IFJECtN2JBxWTnx/B5whjt3GAKIljMS7Cdf8bpeBXhuCcAUtRueDJJA33kBEPKfW+AfsuryVA==
X-Received: by 2002:a05:6a20:7349:b0:23d:ac50:333e with SMTP id adf61e73a8af0-24330a6922bmr4449826637.43.1755791848470;
        Thu, 21 Aug 2025 08:57:28 -0700 (PDT)
Received: from [127.0.1.1] (061092221177.ctinets.com. [61.92.221.177])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b47640afb33sm5094320a12.38.2025.08.21.08.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 08:57:27 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Thu, 21 Aug 2025 23:56:39 +0800
Subject: [PATCH v3 2/9] soc: apple: mailbox: Add Apple A11 and T2 mailbox
 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-t8015-nvme-v3-2-14a4178adf68@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1934; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=svMsQbdVjQ089a4loHQsnYthHi7jkbh4sKxZEGMZ2G4=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBop0HUsDkeUyeY8L8Ri1VshHhDwApV456m3+yPI
 5Fi+gqjcEeJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaKdB1AAKCRABygi3psUI
 JPpqEACU9bzBFeE/CYD4VSK97ziuAegkJJYF/LPx5Ws6y6IIDDAhrhJKUyNxTI6OpltFHUqA0F/
 i4ANEHT/uMb2Y9iJr9Ydp6oP6s6bex2+Jr/xYe3OtGPO1cWitxqEhUORWZ4qViICtbJ6D/H6Cwz
 CZ2+GyBHtn6vggUsNFH0hJMJ2h32eRNBlP8i3MRI1k+RUasl5GQIQLwMRhlVuUJ/1mdkqzIqKEm
 0PiIXBv166RtN0aWa3cC/3Ck+vuK3Lc5pzpj1JLM6hyDTW0Xmhq7j3gR+f3GF+x2B2vQ+/tccQd
 Mn81SfmS7f37AcPsh1PfvmHs5xJjOl9T6ryDVFNIwxMwpPGf++ISMkgn0zvwj9x9jXfbhFhBiMn
 nCSOWlAI1/q+2hn1lbgtdVM0b4ZNWcoakAH9CVoOWOU47okzBVXfK9FKlCb86eYryM2KlvXfCez
 5utJZjQdIL47aXWOtrSh8U5avHWRj5Ondzi72vl01s3g9Kn4tYOzFh2g8mc90aOhgR0yUTYtycV
 bAn2p4vHQfOJZqLv6hXlzIyp5ROriNbr7tw0jaFRYtk+uVIvJr5/asLUQBAE2DX6J+XUWHr062o
 cUfoL0d1tyLIFPSuvZ6QstRD7eGGBfpd9g7IGp1eRPz5isuWprfzyC2alt+VrBhp7kmyErDogqW
 Ktfu26RYg2uDigA==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250821_085729_386834_A0E1452E 
X-CRM114-Status: GOOD (  14.14  )
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

Add ASC mailbox support for Apple A11 and T2 SoCs, which is used for
coprocessors in the system.

Reviewed-by: Sven Peter <sven@kernel.org>
Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 drivers/soc/apple/mailbox.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/soc/apple/mailbox.c b/drivers/soc/apple/mailbox.c
index 49a0955e82d6cf5eef83e5f63ba8d31194c65324..8f29108dc69ac964236121d439e86c923a441265 100644
--- a/drivers/soc/apple/mailbox.c
+++ b/drivers/soc/apple/mailbox.c
@@ -47,6 +47,9 @@
 #define APPLE_ASC_MBOX_I2A_RECV0 0x830
 #define APPLE_ASC_MBOX_I2A_RECV1 0x838
 
+#define APPLE_T8015_MBOX_A2I_CONTROL	0x108
+#define APPLE_T8015_MBOX_I2A_CONTROL	0x10c
+
 #define APPLE_M3_MBOX_CONTROL_FULL BIT(16)
 #define APPLE_M3_MBOX_CONTROL_EMPTY BIT(17)
 
@@ -382,6 +385,21 @@ static int apple_mbox_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct apple_mbox_hw apple_mbox_t8015_hw = {
+	.control_full = APPLE_ASC_MBOX_CONTROL_FULL,
+	.control_empty = APPLE_ASC_MBOX_CONTROL_EMPTY,
+
+	.a2i_control = APPLE_T8015_MBOX_A2I_CONTROL,
+	.a2i_send0 = APPLE_ASC_MBOX_A2I_SEND0,
+	.a2i_send1 = APPLE_ASC_MBOX_A2I_SEND1,
+
+	.i2a_control = APPLE_T8015_MBOX_I2A_CONTROL,
+	.i2a_recv0 = APPLE_ASC_MBOX_I2A_RECV0,
+	.i2a_recv1 = APPLE_ASC_MBOX_I2A_RECV1,
+
+	.has_irq_controls = false,
+};
+
 static const struct apple_mbox_hw apple_mbox_asc_hw = {
 	.control_full = APPLE_ASC_MBOX_CONTROL_FULL,
 	.control_empty = APPLE_ASC_MBOX_CONTROL_EMPTY,
@@ -418,6 +436,7 @@ static const struct apple_mbox_hw apple_mbox_m3_hw = {
 
 static const struct of_device_id apple_mbox_of_match[] = {
 	{ .compatible = "apple,asc-mailbox-v4", .data = &apple_mbox_asc_hw },
+	{ .compatible = "apple,t8015-asc-mailbox", .data = &apple_mbox_t8015_hw },
 	{ .compatible = "apple,m3-mailbox-v2", .data = &apple_mbox_m3_hw },
 	{}
 };

-- 
2.50.1



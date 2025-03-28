Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C59A2C3600B
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Mar 2025 01:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Date:Subject:Cc:To:From:Message-ID:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PjXUOGWXY+dEUkurv+VbTf8nEAUGXROEdkAf6TL7DIo=; b=B5wecpW+yt7BP9teB4XFZPzMBM
	XL8Wu4rfK4Gm3CpqHSJcHI0jy9+HpicWPBuG3zp6CSPQhvB7/IpPg0vin/pmqcXmoi0T/rDDkQ1jl
	mJ2+yCh9iaRhOoa0K5ipTK1hAmyYFFRn2KvsncOTXL2IQe8zrkksXF+NPgI2EUzPejKzmDlbbv8Po
	3F/AFWplcIKe9KZU/PtZawFwQgAooD/XfUS0oUUJ39ZHS3KJuSR5haIcXR9mYGgzpJdrFTwxtGYVZ
	oe32swsN7sJDckl1XGr2eJ2onRSqp5RdZWhT5MKXpwA5lNhljYrS5hpXCTytVcVZetn54NE38IH7c
	nvRNW5zg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1txyiA-0000000CMD2-0ngE;
	Fri, 28 Mar 2025 01:40:42 +0000
Received: from out203-205-221-173.mail.qq.com ([203.205.221.173])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1txyi7-0000000CMCJ-2avd
	for linux-nvme@lists.infradead.org;
	Fri, 28 Mar 2025 01:40:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1743126024; bh=PjXUOGWXY+dEUkurv+VbTf8nEAUGXROEdkAf6TL7DIo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=x2DtC1wSKqJJ5arVh2Jf85IA89FKK4FIVEU3twjIp+2OYxwB/dsFSoP3Qap9avMFg
	 olNM6lPbKjrxFULZ6FWWnrQu/+BySJKjp9JSM4UTc+ABQVLdNBVobWWux6GkcF4anX
	 5oPBwPjWtP9mfji9tIg2RUW62GIRWDhli97T2vEA=
Received: from localhost.localdomain ([116.128.244.169])
	by newxmesmtplogicsvrsza36-0.qq.com (NewEsmtp) with SMTP
	id A16BAECE; Fri, 28 Mar 2025 09:40:22 +0800
X-QQ-mid: xmsmtpt1743126022tnsyc6efw
Message-ID: <tencent_10073A637F934BE4C78884A0465872286C09@qq.com>
X-QQ-XMAILINFO: NkHKfw09D6j8I5pEsPCmWh/6BKZqiMrnvcCXG4fCP1/9IllAXb2wFCI+NKgdTe
	 Hi0yLm8wVOiu8gzYGvTKkcpuKUtFk1G3BtoZypnScNh4JxQuCECK64vFjDU1Z5HQP6QrRS9ZA1E+
	 Fkt34nHUlLdC3c8Y7QsKeMWbQltbwiyRLSfvTlPLoZHuk9Tpv82RW8kPjjrk5QO0cnnBJqnuFsNk
	 qba98qvUg8lv/LoqkAHQ37x6EBhgO2J+/UVZYDYwinCvQRw6PHQvlcglzr3WpmNepmdo0kkpUyAf
	 FEFoH32j1ZaYvAHbRE9QgzdBS5zlKgkuE1Az+3/jm3FDaL+R3jzmb6+eWDF8L5GEe/sLDF0qBCut
	 YjI7lGfA5btSV2QKV9hYaK8v1lTolRhbDKFMUfFfyihBsk1+kfdnPutluioh9lkcsktHKuPMJmXo
	 9wndBYSuyneSosS/wTapNel6fFZARYFPBRBVpElgwbbHIpXC0HY+wRlVbz8WtxO9aBrrVnDhfxa7
	 q7PHAwcxEkkYpeA0fKrLt3GhrDY29xmIIQyMsND2VZ9kapOvUwthmyMU1yfnthUTkSJCdfGZEIY5
	 xkSkTS5ai2BAx7TM4CA2xDkqFIEtxq6A4Iu3aDPW+5WzC2La6/zoeyEsAmztG2808+ienjqg08wV
	 D9aEQi0AxG8891e6Ih/QU5sLdTFWTXO0OFt/Ksm9nxEMucb1Ty7QqPFDXc3JToCsrScTogUFHrIe
	 oeB3akTgJFXu7JciocPKMgA+OOKuh+6ODdWKMDYh1/ksiRaE2Mg5IkYAmWm50S6dDda1a2PiP5fF
	 imKZlCvO2ZHyjnslAErSeSy82EartcnbEQ3k2WvlzzLOMQXL9L1/8xlfqHAZmxucnMxTvM4YZ2qm
	 raqRY+cA9u8e96L91cJGz+YjOC4CinmRG+rjPK9rVMKSWEWtne02CCZQV6ztuA5FiCh74loni7Af
	 odA2YfbiO9iJ8j72OqGuECzWpqCUeY
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: Yaxiong Tian <iambestgod@qq.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Yaxiong Tian <tianyaxiong@kylinos.cn>
Subject: [PATCH v2 1/3] nvme: Add warning for PST table memory allocation failure in nvme_configure_apst
Date: Fri, 28 Mar 2025 09:40:21 +0800
X-OQ-MSGID: <20250328014021.94451-1-iambestgod@qq.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <tencent_4A5421BA11BD9C5B5BF3CEA95FD212AB3107@qq.com>
References: <tencent_4A5421BA11BD9C5B5BF3CEA95FD212AB3107@qq.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250327_184039_956901_01917B58 
X-CRM114-Status: GOOD (  12.84  )
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

From: Yaxiong Tian <tianyaxiong@kylinos.cn>

Currently the function fails silently on PST table memory allocation failure.
Add warning messages to improve error visibility.

Signed-off-by: Yaxiong Tian <tianyaxiong@kylinos.cn>
---
 drivers/nvme/host/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c2d89fac86c5..fb0404fee551 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2678,8 +2678,10 @@ static int nvme_configure_apst(struct nvme_ctrl *ctrl)
 	}
 
 	table = kzalloc(sizeof(*table), GFP_KERNEL);
-	if (!table)
+	if (!table) {
+		dev_warn(ctrl->device, "Failed to allocate pst table; not using APST\n");
 		return 0;
+	}
 
 	if (!ctrl->apst_enabled || ctrl->ps_max_latency_us == 0) {
 		/* Turn off APST. */
-- 
2.25.1



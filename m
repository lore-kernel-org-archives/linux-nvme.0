Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0510EE49A4
	for <linux-nvme@archiver.kernel.org>; Sun, 20 Aug 2023 09:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=j9OULWVa+9T7e9o5P1jtC577YEjNpAm+SlBh32Oe6Yg=; b=1WKDx7CfGF0nvlTStpg9yUVTXB
	9CYaz0YsHn2GXcPTJjdr8Rvq9mcT6d69/J1SM+IO09k5avdBA1InD4Bg5uSgg/s72HVrfPdmkGa4w
	JyTm7yh5fbeV8jtZWs/oM2SzMB+9oU8EqUrkJEIqzyLG/kkYQ6MpyhQ5Q5DNah01KgjxBnr72eTyQ
	kYOiuFxRWqsftXrp5pRvtQvoJ2xizS2whXqR13JnmxnAdk2x9BRegVzRJxOa29YV3NJ6VaJVkMK96
	Y/l1MUgZK1rV8nKjVoveM8pUxd0KrCmVZZQtloPoKWEoqUrc6esUZdUu+aXhOpmQy+Qeh8e2JKOaN
	XeZvUB6Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qXed3-00BZwp-25;
	Sun, 20 Aug 2023 09:21:49 +0000
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qXecx-00BZwO-2Y
	for linux-nvme@lists.infradead.org;
	Sun, 20 Aug 2023 09:21:45 +0000
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-99df11828c6so718857866b.1
        for <linux-nvme@lists.infradead.org>; Sun, 20 Aug 2023 02:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692523302; x=1693128102;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j9OULWVa+9T7e9o5P1jtC577YEjNpAm+SlBh32Oe6Yg=;
        b=eDVqdKJpbJD7MuQny9+PhQ5TFBxVSIo3XbudQeaIjzBlui+3e/vbqjkeOpOrn0zhMH
         6T7c9bZzLd9TkiJN0kUB3yH0OwgAkPkfT66CuwyqMEOXu5s5ej7Onmmi7eSPmIOIljwf
         clo+s7h4M9mgy18apQBtXpEn34uDj9l8+h7YMwSU6OV0nhcHn+p904R10gWX2RBVEkV2
         uRk4yGtdwCY6frKfaPAep8zXa5w9BYDveiwec2tqchY3Uzr7C8zuSaYZBLl6C3e3jBMh
         SUK0Z0XOPhjqX/fmA2QTrlXGC6hqsYkFYod6mBqxsX60y9HWb0rJ9nsd4jjuIU3xraJo
         Uekg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692523302; x=1693128102;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j9OULWVa+9T7e9o5P1jtC577YEjNpAm+SlBh32Oe6Yg=;
        b=MG3d7Sk2G/fP/xlQxK/HnJfU1/lDgc/CpzRKJ3qaLE6JYIjIl69BHQpYpEm9iNJ89V
         MoXFaXq8ogrWpffSDPpGax55CMS2PNljAmc/wwNpqbksUn70A8sYT9QOrSj8HmRrfDdc
         A7pac5i9rVQAogXR4kCLhFFyIRytz0KeFUNXlIXijGrIwGEkU93fhdnoZNPIdgXV/lMO
         xP/MiQfi0JjauX0jD7NOBaSJGZynlAGZBifv3hNL7NM6JOZYW1+k1iPshgONFel1Iv9A
         dDLJ7buuMRutqFt+WemkvHzBYMdoXB4SXsf2RXs3/JbTiSM31dmb/gaFt0JPJGhNYG4E
         deOw==
X-Gm-Message-State: AOJu0Yw4Olr78yIEf3whuQNFJGhX3151c0InOetJNzxh2+DDxlyRU+c/
	6ZD+4wCFhoDKuwiImNAoKUc72g==
X-Google-Smtp-Source: AGHT+IHkeRUpC5ZDCIVCrdslgCCGuB/IQ0zwX54Vc5/y9+nsHHaU5zB3arEBOBCtnfhpKTUPxcz3Jg==
X-Received: by 2002:a17:907:6d09:b0:98d:ebb7:a8b0 with SMTP id sa9-20020a1709076d0900b0098debb7a8b0mr4282297ejc.14.1692523301871;
        Sun, 20 Aug 2023 02:21:41 -0700 (PDT)
Received: from krzk-bin.. ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id r16-20020a170906705000b0099bd6026f45sm4320132ejj.198.2023.08.20.02.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Aug 2023 02:21:41 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Guenter Roeck <linux@roeck-us.net>,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RESEND PATCH v2] nvme: host: hwmon: constify pointers to hwmon_channel_info
Date: Sun, 20 Aug 2023 11:21:39 +0200
Message-Id: <20230820092139.45029-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230820_022143_844259_EA9A5432 
X-CRM114-Status: GOOD (  12.45  )
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

Statically allocated array of pointed to hwmon_channel_info can be made
const for safety.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Christoph Hellwig <hch@lst.de>
Acked-by: Guenter Roeck <linux@roeck-us.net>

---

Changes since v1:
1. Correct whitespace (Christoph)
2. Add tags
---
 drivers/nvme/host/hwmon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/hwmon.c b/drivers/nvme/host/hwmon.c
index 316f3e4ca7cc..8df73a0b3980 100644
--- a/drivers/nvme/host/hwmon.c
+++ b/drivers/nvme/host/hwmon.c
@@ -187,7 +187,7 @@ static umode_t nvme_hwmon_is_visible(const void *_data,
 	return 0;
 }
 
-static const struct hwmon_channel_info *nvme_hwmon_info[] = {
+static const struct hwmon_channel_info *const nvme_hwmon_info[] = {
 	HWMON_CHANNEL_INFO(chip, HWMON_C_REGISTER_TZ),
 	HWMON_CHANNEL_INFO(temp,
 			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_MIN |
-- 
2.34.1



Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D093C77B7C
	for <linux-nvme@archiver.kernel.org>; Thu, 11 May 2023 17:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=w10pXzBXXA8TvY3Yamk/BTpqwZGim8+uZJGGktQkRcU=; b=hhBhel5EnqHNgrvjV609g/cm9w
	tE9MNyCQ8D5UEr8K4MIrbY9gVg0fRMOUfBL/freQ8jG/RWc8R9GmELKgzKSvXq13g4xWdhR+aHfpz
	3sEEwpX23MxGsMT0Z1i38BSd8whMiptA6Bas3IBp6AsF3z0jRe4vOsgTZcmMEc1JPDgVVRtjyghzD
	+p2EJwfX6z7aehyfyt55h9nb3ghqziU/WHF2ORGBHOQm0t0xwDneyaGJh2gqEec7lKoiu+28vqx5b
	DIqWfBeGoPoyXCoYlm1MJLCHid+EZGu0nGRwdn6JPfGP/DbF7OWTaofdaSKL6eM+UZqvdfhp5jedp
	s5G/GTCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pxANY-009bkS-2i;
	Thu, 11 May 2023 17:47:00 +0000
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pxANW-009bj4-13
	for linux-nvme@lists.infradead.org;
	Thu, 11 May 2023 17:46:59 +0000
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-50bc3088b7aso16825826a12.3
        for <linux-nvme@lists.infradead.org>; Thu, 11 May 2023 10:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683827214; x=1686419214;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w10pXzBXXA8TvY3Yamk/BTpqwZGim8+uZJGGktQkRcU=;
        b=M0II5MKSdmQmnrtsEzOojZkt5itSV6IRUkyFPhsF7OHlccuPFX5bqhcFqdCULySxAs
         Xl5IogWe7chmAQy132m3jdounJJrF7BhXBX/Mwk0Hjf40BU1/3wDGvrqU+OLWRzUIx8I
         4jF50D9NLQ82ir5XFkiYtSsSdGblENEDcIdMOSWoBUPq9vPM0yhT6Q/TObpnh8tmdPZP
         8qnz9AUqdVcXjy8o4O8j0V1x1Z7TboBzaI4GfW2DdMhK7Ke/wz+mmMcfO7fv4smydRtZ
         3cA+8j8uSTPK3OH0Fu868BDdlCZDZ4cvVM8LwCez7o2S6QN6X4w1yhVqca0G9tPAuAWI
         eaOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683827214; x=1686419214;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w10pXzBXXA8TvY3Yamk/BTpqwZGim8+uZJGGktQkRcU=;
        b=ZEk4BznhU9JKcSXNjyfc2j4E8KpcQ/uS+OBuQ1+ViZxIZUyWXzl4rEnff/Gi+mKO+n
         4qOgQ6ZzjevLJEc2aICwsGC2xJnI9y3TvepMJmLPLTGm7NE+itDV1zadlr1bjVHPLueh
         fxG7wSEqfF6IUqEmw2kGGJJG+KwvHrGW8dexaW6ruQz80AM73Q6YDiQadHGc+NkrU74h
         6n2LtNLMiM8dCMG+5/pUvMMiumta/pmOTtLpDm0FgxE4AIVtDsp+r7v/qL4Kk5IqY4Xi
         HTMfkxt3FXP0PzA3uDmkUqVMuxX+fOnXTuWur+eKXKnDGJNrYQe1yEpkTsHCS8cBZ3vT
         HW9w==
X-Gm-Message-State: AC+VfDxcaGVosVKlpRaGrrLEVv+uDbSQ84mddIIWOwngGksB+oh+UF6Q
	TlxD8tDnUJO6r+TTz4rXqkHGE0xgI22hc8LdPEiDfQ==
X-Google-Smtp-Source: ACHHUZ4UTTdqCPBb/fskbugWXNHeyHl/TFIRurwmR3RwkAjY3S0nJxhVXqSxWl9iAFLdKx21iF0E/g==
X-Received: by 2002:a17:907:97c9:b0:96a:1348:7a27 with SMTP id js9-20020a17090797c900b0096a13487a27mr8677329ejc.12.1683827214066;
        Thu, 11 May 2023 10:46:54 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:d7cd:1be6:f89d:7218])
        by smtp.gmail.com with ESMTPSA id x4-20020a1709060a4400b0095ed3befbedsm4291188ejf.54.2023.05.11.10.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 10:46:53 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Guenter Roeck <linux@roeck-us.net>,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2] nvme: host: hwmon: constify pointers to hwmon_channel_info
Date: Thu, 11 May 2023 19:46:50 +0200
Message-Id: <20230511174650.279452-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230511_104658_498830_F2204F84 
X-CRM114-Status: GOOD (  12.33  )
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

Acked-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes since v1:
1. Correct whitespace (Christoph)
2. Add tag
---
 drivers/nvme/host/hwmon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/hwmon.c b/drivers/nvme/host/hwmon.c
index 9e6e56c20ec9..6aa153f3178a 100644
--- a/drivers/nvme/host/hwmon.c
+++ b/drivers/nvme/host/hwmon.c
@@ -185,7 +185,7 @@ static umode_t nvme_hwmon_is_visible(const void *_data,
 	return 0;
 }
 
-static const struct hwmon_channel_info *nvme_hwmon_info[] = {
+static const struct hwmon_channel_info *const nvme_hwmon_info[] = {
 	HWMON_CHANNEL_INFO(chip, HWMON_C_REGISTER_TZ),
 	HWMON_CHANNEL_INFO(temp,
 			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_MIN |
-- 
2.34.1



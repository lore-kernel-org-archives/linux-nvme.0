Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AA3BC433EF
	for <linux-nvme@archiver.kernel.org>; Sat,  7 May 2022 06:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RRa4965RJ8y32BByKAGeELe6oxXld3+6IanDwJTYWnY=; b=lQi9bY5MeLi4emp8Fr4RFn29Ra
	3hxTSamBWwm1JybPo1WQdz/2xL0fkGQrkzBHhHEcTbzLt0KrchNLW1NrK5QHfkk9sAAekGwCwXmN6
	xbUv1+6cBbRwCUmxTRSHc2G6wWwJRQU4T3+H/ZG7+dY/77aV1TaA2G50Mlnx1Otl3NKQIZ5JoOe6k
	IAPKo56jur9R+vkqrEjWa7GhDafiZiks9qO8NFfgVcUS28u6a+eRE/KQlk82TZQsQhESwcDMA3qd2
	gvSgegJsNDU/qUjhnhtor74C+w3AUkiHUebFMq8NrJiceOtSDEsQa/3uW1/G2sQh/hwEsiB0v3oGo
	zxL0EpEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nnEL5-006IbD-Af; Sat, 07 May 2022 06:54:51 +0000
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nnEKk-006IPR-K6
 for linux-nvme@lists.infradead.org; Sat, 07 May 2022 06:54:32 +0000
Received: by mail-pj1-x1030.google.com with SMTP id
 a15-20020a17090ad80f00b001dc2e23ad84so12659535pjv.4
 for <linux-nvme@lists.infradead.org>; Fri, 06 May 2022 23:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=RRa4965RJ8y32BByKAGeELe6oxXld3+6IanDwJTYWnY=;
 b=xNQKDdJP4WbwJcuJABhBBVkZABgGtp/lIpUgcfm4U35ypS+0RPtYoa7EyuOaUS0e99
 5Q5J1qXVN8JrP3Xb1ZYvXZCKvfJiuFGO5eoZDsVx11rO2LvAEXtz9xt0qTLksGz/L4k4
 9eKTTxI2lJR+mi65seLq0E2Q9l5H+VhaXY8SkhgOPvxWWfe4BKYuQfJCieuJ1x0kuYjC
 jeIKxfLH8Fz8iZLmkAWbkbH9AG8zdYR2ESnXCSOHsnU+iCzCWj5Vi7r5jDXBpopFHyVj
 65QaL1taLk1grCv16rfwwrFqoakS5TagNUPQ7Gc22lvIGeuH7TNZK5bAQtQP8L58ebyv
 MLhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=RRa4965RJ8y32BByKAGeELe6oxXld3+6IanDwJTYWnY=;
 b=UFcf1OizYn2dzuOgX5NJATuy8w7e/4bLbrevkIwcut+A/+cJVBO3FlsDptyznCJa+f
 thKge6zWXIdCF1klij5yqo957JDz2X8E+Goy1+/99nIoWYBb9KnSzxe6yguJram54tOr
 ThFfHDk6XN1sppCyQr6pT77LaT4l9HoSstBHAo1vgy4PWIJiA17TFyi58dcr65XLIS+I
 xNttUQ4vf4pevFY+/23+CIBHYy3sfNEDphOk6YKW7eDmS828JdEXP/B2CGIcB3PyJcwy
 fhzWihAMCTP9f41obFRhNk7JcohMPLbe5d2LWKD0qg2ADui/5EzWxlU19pYWtucIy4/N
 Ct0A==
X-Gm-Message-State: AOAM530okbXtHZK8rV6kFWlWSbT6PjkPRpzgAmP0rJDwXBnnyXorroGT
 7JtzGiuX55dbcOkgsCOhvRhY5A==
X-Google-Smtp-Source: ABdhPJy+ytxstxUEpu8mNGXpx9L/zPq4dqAsHosZjVqYEE5lXWnzQpcO+5TlDLudLY7n4T8N+OY7KQ==
X-Received: by 2002:a17:90b:38cd:b0:1dc:1ebe:2c6c with SMTP id
 nn13-20020a17090b38cd00b001dc1ebe2c6cmr8313033pjb.149.1651906469423; 
 Fri, 06 May 2022 23:54:29 -0700 (PDT)
Received: from always-x1.www.tendawifi.com ([139.177.225.239])
 by smtp.gmail.com with ESMTPSA id
 y20-20020a1709027c9400b0015e8d4eb1ebsm2905162pll.53.2022.05.06.23.54.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 May 2022 23:54:28 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: kbusch@kernel.org,
	hch@lst.de
Cc: sagi@grimberg.me, axboe@fb.com, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH 2/3] nvme: introduce smart bits of aen cfg
Date: Sat,  7 May 2022 14:50:25 +0800
Message-Id: <20220507065026.260306-3-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220507065026.260306-1-pizhenwei@bytedance.com>
References: <20220507065026.260306-1-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220506_235430_729537_2AEDBAD7 
X-CRM114-Status: UNSURE (   8.12  )
X-CRM114-Notice: Please train this message.
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

According to NVM Express v1.4, Section 5.21.1.11 (Asynchronous Event
Configuration), introduce bit 0 ~ bit 5.

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 include/linux/nvme.h | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 882ad7523127..e9f1563ab878 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -688,10 +688,21 @@ enum {
 };
 
 enum {
-	NVME_AEN_CFG_NS_ATTR		= 1 << NVME_AEN_BIT_NS_ATTR,
-	NVME_AEN_CFG_FW_ACT		= 1 << NVME_AEN_BIT_FW_ACT,
-	NVME_AEN_CFG_ANA_CHANGE		= 1 << NVME_AEN_BIT_ANA_CHANGE,
-	NVME_AEN_CFG_DISC_CHANGE	= 1 << NVME_AEN_BIT_DISC_CHANGE,
+	/*
+	 * NVMe SPEC 1.4: 5.21.1.11 Asynchronous Event Configuration
+	 * bits 07:00: SMART / Health Critical Warnings
+	 */
+	NVME_AEN_CFG_SMART_CRIT_SPARE		= NVME_SMART_CRIT_SPARE,
+	NVME_AEN_CFG_SMART_CRIT_TEMPERATURE	= NVME_SMART_CRIT_TEMPERATURE,
+	NVME_AEN_CFG_SMART_CRIT_RELIABILITY	= NVME_SMART_CRIT_RELIABILITY,
+	NVME_AEN_CFG_SMART_CRIT_MEDIA		= NVME_SMART_CRIT_MEDIA,
+	NVME_AEN_CFG_SMART_CRIT_VOLATILE_MEMORY	= NVME_SMART_CRIT_VOLATILE_MEMORY,
+	NVME_AEN_CFG_SMART_CRIT_PMR_UNRELIABLE	= NVME_SMART_CRIT_PMR_UNRELIABLE,
+
+	NVME_AEN_CFG_NS_ATTR			= 1 << NVME_AEN_BIT_NS_ATTR,
+	NVME_AEN_CFG_FW_ACT			= 1 << NVME_AEN_BIT_FW_ACT,
+	NVME_AEN_CFG_ANA_CHANGE			= 1 << NVME_AEN_BIT_ANA_CHANGE,
+	NVME_AEN_CFG_DISC_CHANGE		= 1 << NVME_AEN_BIT_DISC_CHANGE,
 };
 
 struct nvme_lba_range_type {
-- 
2.20.1



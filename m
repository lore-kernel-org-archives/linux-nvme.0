Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E14FCFA747
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Nov 2025 08:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HsO4Hd5ROz+D0bqFKvcezOn2Jkcskeai3TxWpcHV0vk=; b=YAuikxKFRFCKkc0YkbFl2YSvAr
	+qtMwti+ZNVX52geWamddsrM3TM6M6uWeU3gqnGxgJPl9jm2X1LoUPNPXA1zH0kUmWQq6LxtB5MLo
	nFJgGO23hubQGqtPLlJiSwR78HrQF6CdKvQ7x14oaV/BcFQoa4IzNScEKOD9H2P5YIUQWDI4ytkOC
	5+kZGWpXBowjAqHtMiMQZaVGhVIXeiYLrGhwztfmGIHuIZYcCrfx6i7l2+fl/QLwiQwcPCnpwk4A+
	kOxtuLOkAbMmS4v8OHInnTma1FGuowSnWu48vM4QpxOBdlvRbm2Glr1XuBsbGKIp0TfWM7HfJEQ5H
	Qo/QMSDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vMMLL-00000008264-3y0T;
	Fri, 21 Nov 2025 08:18:11 +0000
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vMMLK-0000000825a-1uQi
	for linux-nvme@lists.infradead.org;
	Fri, 21 Nov 2025 08:18:11 +0000
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-7bb3092e4d7so1951094b3a.0
        for <linux-nvme@lists.infradead.org>; Fri, 21 Nov 2025 00:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763713089; x=1764317889; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HsO4Hd5ROz+D0bqFKvcezOn2Jkcskeai3TxWpcHV0vk=;
        b=jCV08QAnOjuA6nbgO2aNw4aRDUwEQqDYLAJA/xIxoDsEoeMHLrmsdx7eA+RyWjDvVj
         stjs5/6XU73dgiUIs0MBfU5pS83eK1dOZi1hwz0Pudo+giRZ4RnxlY174fl0qz2q/XgC
         mKRkEd3rllI1GA7f3vY7nFPIghenjvbxyjmWh78joopk2ReuIreMfg0SsIJelYotkF0y
         cTTjBMMx+8+y+5wQzEXd6DzWsFAMOysNsiWAgADdBWcXa/EzZRT7p0iIIIettmX7GkUM
         2IvIIxWgqaoCaAQnoxcLUIYR18oCYO67OIAW1QQuVxJwqZYFtUNeK0iZyN3WLoxg7PP/
         nJhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763713089; x=1764317889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HsO4Hd5ROz+D0bqFKvcezOn2Jkcskeai3TxWpcHV0vk=;
        b=n0Ptaonm0TFEkuNGq/iBJfw9f8y2vKxxkJ5lc+rGBvd+LNcs/KusUgjRMulRolBAR9
         O48W6DYBaXcsk3iVV0aiJqKuNR+MlwfXvpQXDekyJ2ouEID5N9nHRp4nmttqYNm6DFom
         0RmEmFPFVJ/bBjBpEH80qB++N3+JAB/jrQGAd7rUhYOYzgOEQ+Ojuz5VGRSQmb5QaKDG
         6Vi66hgz1dBimepuL+xK3KqPM+Uj7by475h9Ls3jHbVOvNI/FfozJmjcw8ZMOYLV3RQX
         i3diGm7C0vgoiS+2pnsZ9RJv0ZAzMlrDo8TL5CyMsIOfnTRa2R86ZRhqMAltPj5dgi+k
         T3CA==
X-Forwarded-Encrypted: i=1; AJvYcCWb/c1cn3iBrXwWp8eusfXIBmg+vTaTi93uFa1XsdawlanDM1IzrdDwg2Mp6bRa/0ddooz1h0LEz4OW@lists.infradead.org
X-Gm-Message-State: AOJu0YzB51PZMfgkYhLsV01PlMCqyMN+/sGBoWwLY2MCDd/4uBdE3FQy
	JBaEQH4ynKDpyCTvfM3wM5CrfAVH/DpNhY8hom6woKml3iP6Dd7jzjBy
X-Gm-Gg: ASbGncsGW8848URZ5E4VJPtzExr1+KzDaSqvLqehfrNNkp7aWTZBu0j+KD6a7KYAIhS
	8Se+2Xcj+kmMGVCKMx1H9Cn4PK/fOTLDPrHyj8i1NQIaGu1gX6hW6qgRENQYTkihmp03gw7xCCJ
	2nt3KyVtmJpcafw+x1oPTPQxMmp7oMvydClvg87P86S1DFj9+USseLCZmkeV71ON/7phd9Y/m7Z
	mIH7lXq19rwwmsM6T/cneFkuWm8TLMHwrdgRJNYXrekqwybRHVfeAetqwU5OD6ZPh5CzYeVA9Ag
	c9GhNKkSGQL9RFegIxuKk+Ryitf+c1kJNQdqAPVx4w5AocO60+icY7SEG2n/LFDPeRrNSyJqhGN
	DDYwZL31R261D5PlkcQ11y3/iivZX4rd6mOysHldbqCJ+n7aMsy5IYBk5EgYXTSMKlHjZmkeJjC
	aDEkvyDSj+cky/ICzM97oaLI0sXA==
X-Google-Smtp-Source: AGHT+IFqeRBYEjCaG+tIpPdWA+qVKSXVzOiqtjGknDBSdNDUFTnY7ogPNjlccPCj95LHEh6lRlusYg==
X-Received: by 2002:a05:7022:6b97:b0:119:e569:fb9b with SMTP id a92af1059eb24-11c9d708d34mr570234c88.10.1763713089300;
        Fri, 21 Nov 2025 00:18:09 -0800 (PST)
Received: from localhost.localdomain ([104.128.72.43])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11c93e55af3sm20997352c88.7.2025.11.21.00.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 00:18:09 -0800 (PST)
From: zhangshida <starzhangzsd@gmail.com>
X-Google-Original-From: zhangshida <zhangshida@kylinos.cn>
To: linux-kernel@vger.kernel.org
Cc: linux-block@vger.kernel.org,
	nvdimm@lists.linux.dev,
	virtualization@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	gfs2@lists.linux.dev,
	ntfs3@lists.linux.dev,
	linux-xfs@vger.kernel.org,
	zhangshida@kylinos.cn,
	starzhangzsd@gmail.com
Subject: [PATCH 1/9] block: fix data loss and stale date exposure problems during append write
Date: Fri, 21 Nov 2025 16:17:40 +0800
Message-Id: <20251121081748.1443507-2-zhangshida@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251121081748.1443507-1-zhangshida@kylinos.cn>
References: <20251121081748.1443507-1-zhangshida@kylinos.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251121_001810_496898_6810D91C 
X-CRM114-Status: GOOD (  10.83  )
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

From: Shida Zhang <zhangshida@kylinos.cn>

Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
---
 block/bio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/bio.c b/block/bio.c
index b3a79285c27..55c2c1a0020 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -322,7 +322,7 @@ static struct bio *__bio_chain_endio(struct bio *bio)
 
 static void bio_chain_endio(struct bio *bio)
 {
-	bio_endio(__bio_chain_endio(bio));
+	bio_endio(bio);
 }
 
 /**
-- 
2.34.1



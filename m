Return-Path: <SRS0=jeJI=MB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3672CC07E96
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Jul 2021 02:36:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F25026145E
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Jul 2021 02:36:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F25026145E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=s8PPnA+qczP9wFHSibvzuFWp4TeB23EsWj/kHg/R77M=; b=d0FZLXW4czWjMa
	1iAHFhIe50bWqps2yzI9cRkahcH+V4HUc9/MQqqNFN+AWV8FBawZZiOjABncnG8nMAe02UKeUKPro
	r4TtyAhOM5+kY7ixmrPsIsjyLULW14fBrDGgTUgLRP6Cs9B6VhTHNkgnEJ62kU5SqJdjF9CQCnvCy
	6P+ElfrpL8LCq/UVXVjGM9shzPyOaGZ3tRGMj6uykLcjKqnGtcybnnn7SKuB3Mq4DiADitV3rZMF4
	eyMgg+62ft8T6GmXmHc8JeLvuWTuJM8apcnIOwRrnPjQcnnOiSFo8y1y2hLtQ3J+pWPzbLOlpDqPk
	rdZWUokM+lM29FG0u5Qg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m1gMw-000dT7-PB; Fri, 09 Jul 2021 02:35:58 +0000
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m1gMs-000dRk-8V
 for linux-nvme@lists.infradead.org; Fri, 09 Jul 2021 02:35:56 +0000
Received: by mail-pg1-x535.google.com with SMTP id w15so8419652pgk.13
 for <linux-nvme@lists.infradead.org>; Thu, 08 Jul 2021 19:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=YdbDLS5SpAkMx8rszkRn6E12ynsuXJWoFBCuhtyJ2dM=;
 b=orHsO7hDJRrqy/Te/ID+VhDXQeJdf93yvR5QzW3Zn9Q8Qox6R+BtTcDfTQbklcuaJC
 L1FnJkoUr6dLMpMi1K/TahjKdKVI5v5mVTGqoFV1tzqWQQFUS6/65pGM9mAnNwqLniCA
 b61K8sep3eJKa1iSIhoY0rvVugakBpJL/9GfxU2a1nskDXEXQniLvHNktuFpoh0xBaiZ
 wA8h+cTF45/bfUNfxTizqYfHKZdSMUiVf5+mTm6Ma6x5KyTk7TW3UKx0IRXjf5GRiIBo
 /drmatyxR7Dma4z6O2xkMJ+ic7/Tx4XeIu2crEFa3XS6xStqD7cpZ5ULYS1Sj7h5iMtu
 q5oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=YdbDLS5SpAkMx8rszkRn6E12ynsuXJWoFBCuhtyJ2dM=;
 b=bkRuos8Zb/fGal8uTKDJpzZdA7sK62ot6woLoD5zKgjDuIP53EVbXyw1icKe7LufXY
 yds8krbE991rITNK5Dzy+dE8+T1aMKS+7MvurMQyKuijGvRmYyNXekfK3y3i4zpIySv1
 kMxaiGkTtpb1g9OBmv8aIRiqld4SG9Lg+/l3+Ej/bBqRS7FTU7jUuXZJCwVVzOqxeg64
 zF8guOFYzu41S2ZDoBgzw1OucTqXet1h+Lt3CHb8NAp1mq0/v9Mzp9Io3XYqkwig/fTV
 NYoi2ZSiwiah2WECq1pzaFIXltl0/Oj/Z76Sy62+maQy2Jfysg+/DhnDm1nB+x8gtDp9
 Sx9w==
X-Gm-Message-State: AOAM531vQ3SipU27HylLl7wuy1Yt6LgFSJtvByhgu+AE0AFjFZZiXvqJ
 gXpnTK2QGPEwXKYk8uwkiGM=
X-Google-Smtp-Source: ABdhPJz5m554dMdB2g1oqHnkP9Euo1+NZNTOB/yronotyqF894mNiCv7KOZvrJuSReO4fV3yOWsYXQ==
X-Received: by 2002:a62:5b04:0:b029:308:6fc4:da91 with SMTP id
 p4-20020a625b040000b02903086fc4da91mr34281076pfb.26.1625798152898; 
 Thu, 08 Jul 2021 19:35:52 -0700 (PDT)
Received: from houpudeMacBook-Pro.local.net ([61.120.150.70])
 by smtp.gmail.com with ESMTPSA id me4sm3780792pjb.4.2021.07.08.19.35.49
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 08 Jul 2021 19:35:52 -0700 (PDT)
From: Hou Pu <houpu.main@gmail.com>
To: sagi@grimberg.me,
	hch@lst.de,
	chaitanya.kulkarni@wdc.com
Cc: linux-nvme@lists.infradead.org,
	houpu.main@gmail.com
Subject: [PATCH] nvme-fabrics: remove superfluous nvmf_host_put in
 nvmf_parse_options
Date: Fri,  9 Jul 2021 10:32:47 +0800
Message-Id: <20210709023247.69287-1-houpu.main@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210708_193554_357189_87D4013A 
X-CRM114-Status: GOOD (  10.11  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Opts->host is NULL there. It is checked just before. So remove
nvmf_host_put. It is introduced by commit 59a2f3f00fd7 ("nvme: fix
potential memory leak in option parsing").

Signed-off-by: Hou Pu <houpu.main@gmail.com>
---
 drivers/nvme/host/fabrics.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index a5469fd9d4c3..668c6bb7a567 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -719,7 +719,6 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 				ret = -EINVAL;
 				goto out;
 			}
-			nvmf_host_put(opts->host);
 			opts->host = nvmf_host_add(p);
 			kfree(p);
 			if (!opts->host) {
-- 
2.28.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78ADEC48BF6
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Mar 2024 11:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=OVxCAgmtfzVnrg1x3qpcTUSpcMueI2D1M8zr46ervg8=; b=y/E023Eprt3eU3gQEHjAAPYr8I
	bGeqTwHuVpzwBMpYeCjT1eguZv/bh1fa0lTq+UD4q+2CJmCkH5XVJc1AJJhai8usQwMTdGM3zBXOI
	UVEQd0ttF2PeZFmvl0Alo9c4CrMZ1rd4nMkDI+rktT0wbzm2fpsF2hiTxjdJZOyQF1a1JIWoMk5Qr
	UCGLY+iAAr8GtAsrIEa/ofVKVfDhLbG5QnEqqoyHA2/Iir1yyHaW+fXAg4AKRdzaRhjac5+ktGBu9
	Cf0Ryfo0f7PvHjiiD/6cjbnDSRtKozfTntYVEnC42dCs8bvF5hjCfHRSQZofx8mlhSaq+aAUPyKQq
	NBCJdz4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riBVl-00000004C87-1mvg;
	Thu, 07 Mar 2024 11:02:05 +0000
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riBVh-00000004C72-2gT2
	for linux-nvme@lists.infradead.org;
	Thu, 07 Mar 2024 11:02:03 +0000
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-4131285a72cso2250325e9.2
        for <linux-nvme@lists.infradead.org>; Thu, 07 Mar 2024 03:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709809319; x=1710414119; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OVxCAgmtfzVnrg1x3qpcTUSpcMueI2D1M8zr46ervg8=;
        b=Oj/q1UHgYCuq6gzYqSEdXkfqbGe8kMWmUguq3wFpkHXcDfbJqF+nD/zKLpIUwo2c9D
         hLW+jdGTBZXFdQyY0P7TX2JRn3huGUBH8q1f1VfTOzKnnQB2dH3N0f+OdU9CFOWXY3YP
         +xhA/x6NL3nM5IY4ZVURWNiGJGpjII30BAZ1HBLIG36uJco0Ehca6ZUDhC45hRh+Hn5Y
         Yq6o7P+B7mmdU/afMTFdIiySfcBbSZ0iRQXl6hUc8i8P5isEdFWmLUp/T/ohaUJqvcNC
         GWS6vQHjcy1ZfoKfeEGeq8P0e6odqpiO1YNGHDcaMUHWMQTz1ZDw4eoj2GejSCtM+z0l
         Qttw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709809319; x=1710414119;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OVxCAgmtfzVnrg1x3qpcTUSpcMueI2D1M8zr46ervg8=;
        b=Ydn3BvMRJ4w59asVG3zCJCG3O5aRKiWNIkBM4PtwCd4tRRhBhSnlGshQKr/hhyqpd+
         oLm8fZF365Bz3+1bNbv+4sGmFhbszL7p4Rp5ledBvi+0SON5VP1LJJ3dbfWo9In4YsFs
         QhjoPQR3QzbXsP8JGzS5R6MbdYE1noJ3MgCgXJkNhAiK807LRlPTncVvywBwZnjf4DaF
         rJXSyUTUk/+tyDGBN9iT4d5/YPp0HYMGu2hHCUwQhrRYTee9Lw1D3yEzWY0knlTaV77O
         93KmPGcIGGfe1p+Bi3BXvN4zXnno1Kv7VT35koEYIGnjKvJRgyNes1zfyet8Fme7/69E
         gXBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwrh2Reixy3t5F0W5bUsuZdlokfYwj9/Ha4xVpuIlzdGk2ijSazhaLKe+c+hrtQO/YrK0FrZ9YpDNf9uqQszE+8a127dnQ4Ja/9UFJHbE=
X-Gm-Message-State: AOJu0YzOeklznEPGemzfN7d0jOea2sbEz3OqG42GVRbT8XDC07PaqvuI
	eUUkUYk69v9FFExVj4GoI0AVbLWPo1tHgNIGysNp4GsuY1H6qLP4
X-Google-Smtp-Source: AGHT+IFLyuScgDC5qSvBnfaovh6jHiE08ApmLOiTh8dr5gaSz2ndkCaFTchxRoN4I24dQevFNBNhRw==
X-Received: by 2002:a05:600c:548e:b0:412:e4f6:75ae with SMTP id iv14-20020a05600c548e00b00412e4f675aemr7518549wmb.32.1709809319108;
        Thu, 07 Mar 2024 03:01:59 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id fa18-20020a05600c519200b004130c1dc29csm2285249wmb.22.2024.03.07.03.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 03:01:58 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: James Smart <james.smart@broadcom.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	linux-nvme@lists.infradead.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] nvmet-fc: remove unused functions nvmet_fc_iodnum and nvmet_fc_fodnum
Date: Thu,  7 Mar 2024 11:01:58 +0000
Message-Id: <20240307110158.1981401-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240307_030201_703685_24571A27 
X-CRM114-Status: GOOD (  11.07  )
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

The inlined helper functions nvmet_fc_iodnum and nvmet_fc_fodnum are
not used and are redundant. They have been in the code since 2016 and
never been referenced. Remove them.

Cleans up clang scan warnings such as:
drivers/nvme/target/fc.c:177:1: warning: unused function
'nvmet_fc_iodnum' [-Wunused-function]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/nvme/target/fc.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index fd229f310c93..a19fa50c840b 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -172,20 +172,6 @@ struct nvmet_fc_tgt_assoc {
 	struct work_struct		del_work;
 };
 
-
-static inline int
-nvmet_fc_iodnum(struct nvmet_fc_ls_iod *iodptr)
-{
-	return (iodptr - iodptr->tgtport->iod);
-}
-
-static inline int
-nvmet_fc_fodnum(struct nvmet_fc_fcp_iod *fodptr)
-{
-	return (fodptr - fodptr->queue->fod);
-}
-
-
 /*
  * Association and Connection IDs:
  *
-- 
2.39.2



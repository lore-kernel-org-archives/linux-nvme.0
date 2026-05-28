Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A697CD5BD1
	for <linux-nvme@archiver.kernel.org>; Thu, 28 May 2026 09:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1BL71DOAkq0sLsiyukDrRcXJ19tZkTPOHhufsrp79qw=; b=jzvOh8yvoAhh8RQZhC3yinNtO/
	mydl3j1Uurw259UEi/yjbN6JC48WPWcAYWISW1UWPd9maLq4/C/dyjszc+6FifQGJwjR5F9/fkL2p
	qwO2cHi7vPwh0Q3ocB0l/951D++Hz8qaNGPmHUbCy+RkaiZ/8n3cT80MExt5g54WJgjzOCtmqAlYr
	lH2hTMsNTb20hRGX0vfSxuCY/nIgLu1kbpwSSFRaygsPhfUvwh27TdFbcDesr4wCV+qectBiKDa8y
	9BCrHBGXt89CSolGUUUFnQUV5mma6JVsJU9KBz2D55RmywQNxtsvTPnNkrqDNqJ4oMee+Y0h2tkjR
	gKwqNz9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSX5k-00000005VkM-31vZ;
	Thu, 28 May 2026 09:31:52 +0000
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSX5j-00000005Vjk-12gM
	for linux-nvme@lists.infradead.org;
	Thu, 28 May 2026 09:31:52 +0000
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-2bd2051167eso62500975ad.1
        for <linux-nvme@lists.infradead.org>; Thu, 28 May 2026 02:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779960710; x=1780565510; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1BL71DOAkq0sLsiyukDrRcXJ19tZkTPOHhufsrp79qw=;
        b=WgJL/IrHxa3bE6S9lg4YEztfykZggNtcrCZHr/907E0UtpVAp6DhI7Fofi8Bqw4d18
         lWVd/U1XlgwVYMg0XkYQZtfRNwbrmC9kQ5zX38QfCLwotX/2qgdrVLDzd+lGXDYulXjy
         8BJkHVEUyhWevBnWYz5o8YQIu2uGtmxjbvB5A7pkwyGstR6+v4+VeOx7n9BB6X0cMEGl
         oX57y2d3wIOjyRWG5iV6QndP2NssXw1eG++OWcD2duYh8I8adtL1GpF+sfm4coYZS02d
         bkMDK+0RwB40As1mRxa2vjV2v1BreBXkvApX4TjjvhhQa/h5aRVmP7d55Eo1iLZTpXC8
         I/gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779960710; x=1780565510;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1BL71DOAkq0sLsiyukDrRcXJ19tZkTPOHhufsrp79qw=;
        b=crYyw6Rs652JXr1NGh3yUNL+Lruc8EL3CMvxq+AGGYzlei4hNEXN3Oxnz/F+YNhxYN
         vylT23sbUHbgUvC0X5kxaoaZqtJuD7dBkE5qBaTkWynqvZ52jG8Vc3sAsmJ4p3HGf4bV
         lExC7SYikbT3BjWFomgx3+SNJN0uLlPQ/laQ2oeprOzRckOp+En3RToCN5iaaBfHa76H
         tmmgIJ5ONLciqh7TB42ZcoIo4lNnPGvnBSNqFjDIEYdSYpuGuC7sy9worcCxbh5dgple
         YmL9ez7ZkwMShOLbNh+UVfgPe1rTqG+WhLPCHDK/hRfX22IjuDrkQpmoAGBNO6d+kU0G
         /0/w==
X-Gm-Message-State: AOJu0YxUkLldgiplAn3A+WTbKHqpBU7TB8sZOVRL6RiEYFZ82m6bO1Z9
	u2Kb0tOXRKoXcSY0unBSygJDKIbuYK73Hl17pt7X+nefYejkJxfy7vr1mMDN9d7YpJw=
X-Gm-Gg: Acq92OEg620TN1+TjF4BKk922fUfR+g77io5TFYnsRGHCQYCz0iZ+KfgDTZh7ihECSv
	ZM6nokQwJU5agwOVzepu9m46TeYMVTPrLorQ53ptSPKH9fbn2brfjmUd5G2Dkcrf9+9yYVS2YxC
	RVfbr0ljoF7TJ+hxlpkK8+9+Jls8aa7PmxkSMpoMYCjv6U7xNpXjTOiUj5Lzi72NVpma5QQzffX
	afkpNlAR+5wHh9yu/nvxxRDA7l8oGbLu/Ppsl6ow3sdkFOs5+udjxwIiS8FxRGUL1US3Va6FRqz
	Wlreaiu8EtxscxIZ7PjkVRzXVOZBkBmsGfu0Pn8f9TzPC5KnL+oOKhxLyObAQtXDv3VzrilBPvb
	oD/kik8dPgoyU1cKJJCOsU45/kNIt+qr1hmQJWCsU9UWHjQFcSMq4M8Nd60qq8Gx+D9mdY530KF
	JnQZ9L/UQRV8fl1TWPun92uv0J0xmn8LG3H3wuDik=
X-Received: by 2002:a17:902:fc85:b0:2bc:e2ed:fd03 with SMTP id d9443c01a7336-2beb06a041emr293910615ad.39.1779960710128;
        Thu, 28 May 2026 02:31:50 -0700 (PDT)
Received: from [127.0.1.1] ([221.238.56.51])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb56ca7fcsm173561985ad.27.2026.05.28.02.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 02:31:49 -0700 (PDT)
From: liuxixin <gliuxen@gmail.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, linux-kernel@vger.kernel.org, gliuxen@gmail.com
Subject: [PATCH v4 1/2] nvme: fix FDP fdpcidx bounds check
Date: Thu, 28 May 2026 18:00:01 +0800
Message-ID: <a1e2f3c4d5b6a7890abcdef1234567890abcdef12.1748418000.git.gliuxen@gmail.com>
In-Reply-To: <cover.1748418000.git.gliuxen@gmail.com>
References: <20260527133205.GA12042@lst.de> <cover.1779930057.git.gliuxen@gmail.com> <20260528083016.GB7073@lst.de> <20260528083043.GC7073@lst.de> <cover.1748418000.git.gliuxen@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: send-local.py
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260528_023151_289600_EA7ADD55 
X-CRM114-Status: GOOD (  12.85  )
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

The fdpcidx bounds check sets n = NUMFDPC + 1 but used > instead of >=,
incorrectly accepting fdp_idx when it equals n (i.e. NUMFDPC + 1).

Fixes: 30b5f20bb2dd ("nvme: register fdp parameters with the block layer")
Reviewed-by: Nitesh Shetty <nj.shetty@samsung.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: liuxixin <gliuxen@gmail.com>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c3032d6ad..766157ba6 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2263,7 +2263,7 @@ static int nvme_query_fdp_granularity(struct nvme_ctrl *ctrl,
 	}
 
 	n = le16_to_cpu(h->numfdpc) + 1;
-	if (fdp_idx > n) {
+	if (fdp_idx >= n) {
 		dev_warn(ctrl->device, "FDP index:%d out of range:%d\n",
 			 fdp_idx, n);
 		/* Proceed without registering FDP streams */
-- 
2.43.0



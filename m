Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52AD0CFA747
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Nov 2025 08:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Yt1oIqGxOTrmRU0wY5Kf2stOafiOCOsnZEA0d2AzsC4=; b=fi+eRacs2VJYCf7WhGdBh3504f
	xUXbExdNd1/Xiejr8qcBl4tcwps9W0DBPWNBwrWbb8wT8DHsJsOqXduVIQ3Iwi4gwfiTaX0eIYwMt
	8BlhEqRTNy/za002DVAOmyguC+UngwFj1x1OEXG2kXoT4MqjLRWQPujUJ+N/5nJqOPsHS1xW9ssyh
	U37AtDZoITgZY+KG+RggKxrB5AHZCO2rdX7PxIAjy2FoauxVM4HddpziIX/Z/WclzrCUzmT+yr+QU
	4+d8Wsnw+sxRs/YYQifi3GIs76DJBGivvQ4kkD/yRYLrFse6frXNyXRdWpzYlt/YGq7KFf+9Qn1WY
	aJXHxgDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vMMLl-000000082QI-2lQL;
	Fri, 21 Nov 2025 08:18:37 +0000
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vMMLj-000000082Mz-074h
	for linux-nvme@lists.infradead.org;
	Fri, 21 Nov 2025 08:18:36 +0000
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-bc8ceb76c04so1175056a12.1
        for <linux-nvme@lists.infradead.org>; Fri, 21 Nov 2025 00:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763713114; x=1764317914; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yt1oIqGxOTrmRU0wY5Kf2stOafiOCOsnZEA0d2AzsC4=;
        b=Fd3tZr82MdUm3b3fl8P5EJo9uD1Myg8Kxa4bkRXjb8cwQEe33CTWPafJlfMFB7KLCk
         bDJPGKCbc+bh4wfE8no2VNjQBUbQF91SnGlh0sgzkUUmTvCZB9ynPMaYbcOsNJodzg2U
         VeVaqv3z16QByYe9qhEfNp6vjWP/RYJi5d+rZh96c2hPUVtHfnHoS/KYN1vaJ8JgFEej
         Udoo2DkJl2MBmhS4J6GXVETCXsUwvcT/gL1WTpJeamucDSc/RQAPP7v7KeYFtbjxOXOO
         ES8R/b5t9ZS4k/mxupIwLAtZxCyw1v3rNqoW8NXKZJUAxtg7UsBhtE54e8wlJmy4FIyD
         cKNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763713114; x=1764317914;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Yt1oIqGxOTrmRU0wY5Kf2stOafiOCOsnZEA0d2AzsC4=;
        b=w4v2oT44zgrQgsVPVDx8EJ4dR288GhNTwmlVt98rSmvG6zb96AA0vOE7v8NWZOO9ID
         k1zAFZPb7bC7eZ+MLvvPTjhw+a9vfQGLYq+DaHR0b5y7GG/8Oosc2WxGV5m4twICkB6b
         8SjBED3h7fEiK7tc/pwkxjvlJJ8+GRRGoXIAs/PDVl8PkvAdhaZjUXzuO8CmHgVWX3A+
         0I3jHNH9xjgkwuIp33wA8VnCdPGRqpwhmmj1fYlYMDGz4DS41fatWwSXef3+kOnq3e4b
         XmD9SAeYcu0YNs2ayhJdgnACK/lGSQfs4LerQt5SdpYfjcyClFDj12WRfUQuJSZCP0eD
         zfuA==
X-Forwarded-Encrypted: i=1; AJvYcCX1XRFJQyb2SepLBI7U/IaSe6TGf0pGHHa4YnpAf0suqi2ZpAKtXeQEQowx++ztuW1r2VX49sbfPxVk@lists.infradead.org
X-Gm-Message-State: AOJu0YyhJtDoQ1GXKEtXxcvV+IOJmru1WXFe5BGNuGSO9eMJCcZDH/oO
	GDGowOVt0UJDnoTNXBaRWquIxzQw98KdEOcN2ae/ovs3ZaNfpG7UWGwU
X-Gm-Gg: ASbGncvQ14j9gRV4qN7bYv5TBKel45b3gPAlnPOg7cGDnwYls+DjjWTrdzD7XJGe7we
	fyQUsvIrvdag1ZqA0YtJ7maIYf8MRSH3FhtJcLdQbNdAkWBgSrO8Aj1JBHlihvehFQxFE3CmOEN
	53SYqfG6Kv2tmSsgr38c2XVtmZy5DzssGJ2K7beD55WSA51C4Ci1LwdM0ScpBRmdqn5nBgStN+Q
	i2B72EbLtP+di/LJeIr2bL9QN7nFF/rs/dAWI2CqIjl3OBpyEIyTyOUN2dgEjpUug00kvzRe4ed
	Hm6wZXz5BWSBmAXZoSEj/49Y9OYxKUN6b/0qRYBDnF8EIwvehif2+C3dpuikrZOewCzJpM/6bxF
	vm+DPC9p3FEzSW9tDstcYRxUJ/4HuEZNOQ9/hE/zJ48kqyALVwipWD+9Bx3BQVOCqVVhfur+FFt
	Z0SXMXN8owJb+Pc38xH1zPk37oAOPvgORBfSPA
X-Google-Smtp-Source: AGHT+IGjQz6D1HhxF/O38ExwwmQdYex30Wle92q1+zy1HDlDdyzSrgD/kMDXWQtHpmE2DiVpd2L90Q==
X-Received: by 2002:a05:7300:238e:b0:2a4:3593:c7c9 with SMTP id 5a478bee46e88-2a7194d07b7mr663198eec.9.1763713114130;
        Fri, 21 Nov 2025 00:18:34 -0800 (PST)
Received: from localhost.localdomain ([104.128.72.43])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11c93e55af3sm20997352c88.7.2025.11.21.00.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 00:18:33 -0800 (PST)
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
Subject: [PATCH 9/9] nvdimm: use bio_chain_and_submit for simplification
Date: Fri, 21 Nov 2025 16:17:48 +0800
Message-Id: <20251121081748.1443507-10-zhangshida@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251121081748.1443507-1-zhangshida@kylinos.cn>
References: <20251121081748.1443507-1-zhangshida@kylinos.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251121_001835_089895_7B24269E 
X-CRM114-Status: UNSURE (   9.44  )
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

From: Shida Zhang <zhangshida@kylinos.cn>

Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
---
 drivers/nvdimm/nd_virtio.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvdimm/nd_virtio.c b/drivers/nvdimm/nd_virtio.c
index c3f07be4aa2..e6ec7ceee9b 100644
--- a/drivers/nvdimm/nd_virtio.c
+++ b/drivers/nvdimm/nd_virtio.c
@@ -122,8 +122,7 @@ int async_pmem_flush(struct nd_region *nd_region, struct bio *bio)
 			return -ENOMEM;
 		bio_clone_blkg_association(child, bio);
 		child->bi_iter.bi_sector = -1;
-		bio_chain(child, bio);
-		submit_bio(child);
+		bio_chain_and_submit(child, bio);
 		return 0;
 	}
 	if (virtio_pmem_flush(nd_region))
-- 
2.34.1



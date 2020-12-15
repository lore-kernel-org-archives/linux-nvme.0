Return-Path: <SRS0=/AMA=FT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05F79C4361B
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Dec 2020 06:04:19 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9A4320791
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Dec 2020 06:04:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9A4320791
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=utXUoKscth+OiFBi0SRPoBqHkJ9LiH27usrz6PiO5hc=; b=qx9Yd+vlah1ucN1smH75n19xh
	XHXcwPidG1xOBvrInltIP2S47iKzLPKXDspktMQB6lMMosp42UycrT0qgzHM9gM3ZPaDKCrXKRCeb
	irKb5V+1Ak3URHf1M3pPI/yGo10ZHgPB6O4KSRLf2BNJ9mlTNK1ciLs5J+VUv6wghoWKHQQpjLT7u
	3ufj+zzJG6yGwwehiQ4XrhtL3tkEjWRQwrB6DVgW/LpYcLSGx7iEXIQimq0KgfZoa6+vWN0Va1VwL
	T4UXjw7olFy+H6Wu9PWy1AAVgv9rE5WXIXqIMqyW2S3A2BMPiKA8xbpghNxE087RARhEudaLGUzAi
	fWEQ1hR8A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kp3RX-0007tq-Et; Tue, 15 Dec 2020 06:04:15 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kp3RU-0007sE-54
 for linux-nvme@lists.infradead.org; Tue, 15 Dec 2020 06:04:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1608012252; x=1639548252;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=2WRsibq+qDho+pjgl/Wk32oPiBilraCut4aAJwCYJ8M=;
 b=MwJXHF9w0v04guraFI/7eKo9E+D6b4wFqLlTbuKY8felFjP38mytXDyg
 iKUUV0NXJoaThxw0Xwtb3Dns8w8JWoAHN7uCpthumLQLK+ePHk9Reb5cb
 nQZd9d07ffdhjkaHuo3GoaCG/sSZ9srkAe7S3rLG85ggsJddge8K8S6oC
 hPe07TUf18NxbqmkbCROMx7YxMJ9wWVkCL65Hb1ExxiyTFOeU2GaSJAly
 UuBc2/gcD8t31O06nhIt7C6oISXNT/3s38YDFti/H19/pJlCmG9KQ73MO
 G+lPqLQ6y8jWxEw+2nYKWNtC94tmohvmz/GRhkxhbytvMW9Ec9ZQrUL/a g==;
IronPort-SDR: bcopDB98Wd/5BXHlsyA6I8BFWcf3e7hsZqJbn/OcPvWK8ovWs6YBgeu/D6k3eSRSKiEYkhOgrE
 zk04sJ/bBOroLFAVaRh8RFm2heIkhfZqTL+/cHFa2r9t0bfCsZ5l4UZMR32k+oQZA9xDSOz1Nc
 hISytONIMd0hV78+ONxmQa2s8Rrkn6KwiLRmfEyw+9UYN7QX5sC4wVTiQNFWIq/kTbP1yXBZal
 R5LtuKb4/B+LUGAxkb2X+3b5lyE9UsCHm4CXSO/7ZDJ20zSvpJq9o02jQJXRF1owmcIzA+5TIU
 Kgw=
X-IronPort-AV: E=Sophos;i="5.78,420,1599494400"; d="scan'208";a="155158428"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 15 Dec 2020 14:04:11 +0800
IronPort-SDR: tprLdkgRQ1GryKGeI5R0DMZBtiRvXnMHkFNu7FO8Zlc1nMXXbhBkMGra2Z+GLyYOQqYPBa6HyR
 3ONuuiHIdEw8WM7JgMQ865sVTqRunCaWpCDkLG34fj1ngMQlt9IUwUuFAXmYrBkd5SHnXRZF1d
 etoveUogGoh6bJe0zkfuujnisHv3wZe4OCMoeCM2ve/wjp32W/BO+Hp8ySrzRIwIX9+PeIpMFK
 FcTePBB35P2dW2OEpuj5Gz7hFetI87UgSHyKknCrwhiwBQVGgqOYkKet75eWMVSIXU+lGyq6wW
 hUkUNIhf47ivQZsu5u7FJWQK
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Dec 2020 21:47:54 -0800
IronPort-SDR: BmMmOzY6yL12xaJFftEGsBKcBk4EVNmQVzbyJSa/WgM6aQgDS0z+Iw+cakoRcTkhjwpU9+KZNo
 s9FFwWwtH6dXYa5Ll4QyvRdRNgdC4tGz6daHVEmfp1H2M7PTlUSJfiuRaaCYB4n4PhcUrBCyWS
 NCWSu4uXj3P5atQSlKS/bqKc2ZDw0de8zKi32uxl1h8eRmurwkhE3aaWydcNH7TMcS+pB9DUVL
 lmujSaEu8TedQ+Z1Rz+hWJewdC/feyQOb3rsbh3UQF5ARL6UBbOlvUaYdDV/+l2fPfsBiIqs2W
 Bak=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 14 Dec 2020 22:04:12 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH V7 6/6] nvmet: add bio put helper for different backends
Date: Mon, 14 Dec 2020 22:03:05 -0800
Message-Id: <20201215060305.28141-7-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201215060305.28141-1-chaitanya.kulkarni@wdc.com>
References: <20201215060305.28141-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201215_010412_393398_2334A91E 
X-CRM114-Status: GOOD (  14.56  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: damien.lemoal@wdc.com, sagi@grimberg.me,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

With the addition of zns backend now we have three different
backends with inline bio optimization. That leads to having duplicate
code in for freeing the bio in all three backends: generic bdev,
passsthru and generic zns.

Add a helper function to avoid the duplicate code and update the
respective backends.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/io-cmd-bdev.c | 3 +--
 drivers/nvme/target/nvmet.h       | 6 ++++++
 drivers/nvme/target/passthru.c    | 3 +--
 drivers/nvme/target/zns.c         | 3 +--
 4 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index 72746e29cb0d..6ffd84a620e7 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -172,8 +172,7 @@ static void nvmet_bio_done(struct bio *bio)
 	struct nvmet_req *req = bio->bi_private;
 
 	nvmet_req_complete(req, blk_to_nvme_status(req, bio->bi_status));
-	if (bio != &req->b.inline_bio)
-		bio_put(bio);
+	nvmet_req_bio_put(req, bio);
 }
 
 #ifdef CONFIG_BLK_DEV_INTEGRITY
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 3fc84f79cce1..e770086b5890 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -668,4 +668,10 @@ static inline struct bio *nvmet_req_bio_get(struct nvmet_req *req,
 	return bio;
 }
 
+static inline void nvmet_req_bio_put(struct nvmet_req *req, struct bio *bio)
+{
+	if (bio != &req->b.inline_bio)
+		bio_put(bio);
+}
+
 #endif /* _NVMET_H */
diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index 54f765b566ee..a4a73d64c603 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -200,8 +200,7 @@ static int nvmet_passthru_map_sg(struct nvmet_req *req, struct request *rq)
 	for_each_sg(req->sg, sg, req->sg_cnt, i) {
 		if (bio_add_pc_page(rq->q, bio, sg_page(sg), sg->length,
 				    sg->offset) < sg->length) {
-			if (bio != &req->p.inline_bio)
-				bio_put(bio);
+			nvmet_req_bio_put(req, bio);
 			return -EINVAL;
 		}
 	}
diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c
index 8bafab98d076..d6a8310cf672 100644
--- a/drivers/nvme/target/zns.c
+++ b/drivers/nvme/target/zns.c
@@ -330,7 +330,6 @@ void nvmet_bdev_execute_zone_append(struct nvmet_req *req)
 						 bio->bi_iter.bi_sector);
 
 out_bio_put:
-	if (bio != &req->b.inline_bio)
-		bio_put(bio);
+	nvmet_req_bio_put(req, bio);
 	nvmet_req_complete(req, ret < 0 ? NVME_SC_INTERNAL : status);
 }
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

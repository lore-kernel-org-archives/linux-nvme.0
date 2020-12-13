Return-Path: <SRS0=ZzGD=FR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C8AC433FE
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Dec 2020 05:51:44 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8BB122D71
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Dec 2020 05:51:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8BB122D71
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=OcgIDYl/b02/V9uUUf4APpKDRgUuxcE6SSqKXlQvwbA=; b=Qh1wsYVbcCrUxLVHhktPJHgBV
	0Wlv3bXtVkHnfWJF340LT2avKVN2Ktx26GuZpN6StfidfXI0hbbLesJWI8BK+GAtgWk01+R3eTBWU
	PN12VCSzGJ7WFLv6sqOnZAzTXNumoPeuLEVILt4SzCZKgJgDlMEtnrv191WUNvZbiJ3otLz5s7NIB
	QWIjOw++7+WO8zGflGQkXZd5g664+iNVF7JG6wmkSNm4HmUbku8CLBD5mpGg84hrXp7k/XxOWsDMd
	BPE+m7aANpgx7HBpBbXkaFLJo5mZlidFryHSBq8s2AO60uLNzFjMufPB1gJIjGT0+1ftQktxRfacc
	DbinZnZZQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1koKIG-0005tS-Ir; Sun, 13 Dec 2020 05:51:40 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1koKHv-0005nr-Gh
 for linux-nvme@lists.infradead.org; Sun, 13 Dec 2020 05:51:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1607838679; x=1639374679;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=6iQxxapLrqBA7SoY0rjMc7pwZ2Vn0eqmBYQq+bt9gtU=;
 b=h7c8XTQL9g20qp2mC8KKBU38VuW/tTQ6o68G8kN+JqXzBZMRDjfIjVSp
 DhHfVPH6KO+A/n+j1tV7IAWFJxcMjwdLd88M/aIOBGAamsQBHp5zGNqcf
 zxcwGAmNobGUvnIXspIC5gzR4KeRJe7e9LoOMRSbXtz1QTHu4zhuSBhz5
 sfTZ/MEm3HW/JMaikXVCgGDe9VznGo4o+wI5aOUR3AnOOFYNZaUsgZszk
 adjPnB7opdf5a6l7OVZh6DTMZR9tW4MEquUHitNbHE52aVhxOMGwG/26/
 QyxBM4MDx690m7pf4GPqGXSw+mYS3ovZS77k8PyC9u/i3XZOdZ+Pwbv3A g==;
IronPort-SDR: bgly4bJDSfoZUWwKtUqrXFC/jcl7Jh8M2XxJYRhuVYulQrrbewnDIdEKSuVmCfG25aodbbnsXq
 76oB5y1bbl6jae/Zh/3291LC90g933oATDedA8dO02sQG7cCXQv2X4MJv0WFR/qxOEKVHl3Omi
 Z45l1KnkXhLlMfU+aKZKh4pjPVEWiGRu+J+qkax1juI0JXlYuXibRul1FcQkNeYyHqQDqz+G4t
 G7KZiQ2dgNpuSue23I1eOxsjbpN4gpKxyTgvzo587sIXg7hPMz5tYJZ6DSLzjw1Ov8qGRO+c+p
 bxw=
X-IronPort-AV: E=Sophos;i="5.78,415,1599494400"; d="scan'208";a="159483874"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 13 Dec 2020 13:51:17 +0800
IronPort-SDR: 1ZZbVO65XtfGqefdQlZhPhpgXRvL1FwDmG6QIDvBiVbchZ8mZhMb9mdeflyiaDo1+nhfizN0O0
 QPvNkuHb3/SHHcpyWHyb4W/u3iuruyLzMaH95GJ5o7g/LWckFQji1httfnBgwPwEjwGZ2nu9Xp
 NXLwBvNA6ANMXzTOFt/2pKMJJnhEi2+oyXGSmzW09P1N0VDneKPgJY6gRhFavj1dh1ELlqI8nH
 SdZlMhHgtzI6j80pggnCuJNEcj58xs9z1HqsWJ+vNsCX9KmtzZTLS+Fj2J/V2pkjKAqHKxIKy5
 aSy12ebMlQt7FdZnRLQFcg+j
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Dec 2020 21:36:38 -0800
IronPort-SDR: blFYTv0Uo9gZGR0KtydYgcZBR6w+VIk2TS6ks+xbU0VwGquUjtHt6fIfuAXnIEwYueV91yJCEp
 IMnErq9Zoq0VypRFL87A/VvN0NH9DMJw80lrlPiLAPLOHh7O9mDPVIDqaSzqIOYofxW6VNawBF
 9hPqX3eDBSB/VPrNCwXpZLz8zg4OG+jFH/iskXV7O25gnzKKny6HcE4pFv0NJ+fWMuE2rBkIbZ
 wXqh9qQKd/p/sAlK0nzoqecSOVfh6wjnSEPcZXu4ikkpmo+hvEZo7eXMIYYlCL1Lw7gmivLZxY
 joo=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip01.wdc.com with ESMTP; 12 Dec 2020 21:51:17 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH V6 6/6] nvmet: add bio put helper for different backends
Date: Sat, 12 Dec 2020 21:50:17 -0800
Message-Id: <20201213055017.7141-7-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201213055017.7141-1-chaitanya.kulkarni@wdc.com>
References: <20201213055017.7141-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201213_005122_406671_A9093FCE 
X-CRM114-Status: GOOD (  14.36  )
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
index 058da4a2012b..2b5c04e56097 100644
--- a/drivers/nvme/target/zns.c
+++ b/drivers/nvme/target/zns.c
@@ -345,7 +345,6 @@ void nvmet_bdev_execute_zone_append(struct nvmet_req *req)
 						 bio->bi_iter.bi_sector);
 
 out_bio_put:
-	if (bio != &req->b.inline_bio)
-		bio_put(bio);
+	nvmet_req_bio_put(req, bio);
 	nvmet_req_complete(req, status);
 }
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

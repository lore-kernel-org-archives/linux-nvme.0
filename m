Return-Path: <SRS0=pxZf=IH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80DCDC433E0
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Mar 2021 04:59:52 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22A726529C
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Mar 2021 04:59:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22A726529C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=R10AvaM94MFSijB/v09GgfHie7BFIw85s5mJdwGei5M=; b=YS2OCn0DV9m6QtW9O3BuDb++1
	mHL7x6XXClbr9MRq57gTeuAxGFQg3KlODVyZ+26b92MxNBjPEEuOvehzF00aVc3fxT7O4N768cbAP
	Hhn1MTiK1cCN4qHTMMRjQvIhEnpo3hxQHAaDhyZQ3xVbNok9l3FBJdbQ+g2B6dCDDgRZCqe1Fgx+v
	+Xzsbt3xNajyR54LxSQ7GBm1TJwEHDeCoNN9Fg06ckGtU/j9JGOpjqYy1qpgMGl0KC2G+9QpEqCYe
	cw4G9cWkmfvZ4bI0OMlaHiFv8HSQHwahHS1ooWXhKJdCYycmvKtiXBttdVZdCkBjMvfirfl6bQlek
	ywu6H7zyA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lJUT0-003lJS-Hf; Tue, 09 Mar 2021 04:59:34 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lJUSf-003lFL-UJ
 for linux-nvme@lists.infradead.org; Tue, 09 Mar 2021 04:59:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1615265956; x=1646801956;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=v6NE0CwE9o0OgZTWVyiKpY7CuUKsyEXKz9gm6mhcXf4=;
 b=FeYu1FxJx75OMT1HJ3dKzmxb3YFI4IvsrU8X+2nokrS23AViWJIckeDs
 DoTWEwB4xApAOgC2l3id6chFPmcLlZD2419EWrbfMXAeQaT86EjNCyeXu
 lGvUNnPfcRzSZSzynMSAWnqqsqB8Q1zME+8IEHOXqvxarQA3HMnmVGjea
 jnrSQWNMTOhNutgUG1zghvvWaq6h71+Meu3C95fB3KQ6NSW0rX4IZJ5y1
 +Djd3Mez792kzX7JdJ0p6S3W9DAr42G/PuRFCI1n9J01bkQdaEkm0wqqH
 egWwPLjV3s8PiHgb5u7g2PtnaGH+s4/8JEW6+AQfHc2a5tiHlhFzQAhaS Q==;
IronPort-SDR: c+kZBwoLi63zkfWvtZjAAc7eosV/5BV2Ns2zgLsGa/WiwSr+NL9s/e1W0yvH9fcGJzkeTIl0jt
 iNJ2CLp2jpOoPFP++TcsOVR1J9+rleWAhow1FYlvzwVcCSARXoXuBfMyBsck0dIqKajYb6XlIn
 K7xKSf3dQrRWTiDHOuKz+xqTDCCEiJfHyVRKuilGymWPn28WVqpctHZtXABNr3ILBsmOWmfSFW
 BIb3LyTpy1UyrAFIVdIGAaHuWMhAKrCZGVBbS61EsJUOgHvqN7Qb/wvgUy8+D4OLB3MBmYRioI
 MAc=
X-IronPort-AV: E=Sophos;i="5.81,234,1610380800"; d="scan'208";a="266008594"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 09 Mar 2021 12:59:13 +0800
IronPort-SDR: wkvDVz2wr0j47uXDPWS4vzJJTXAKCq/mgkNyvtv9HtVMwwWdqrhuvPcg8wcJCTRah/fqKyEiAU
 I3HApyYU+9Z6pYONkIkuSSec1c/4PLue3qhq4H33n0u9Kqp93/sLgRL48/MQ//nUInn5N13/G6
 HIbRzD5DjbgxdsL+ebb1UgSeCZKv3F9hPlyOsOoHAYg2IV32UupTIazIml3qDjnGzRAPyEHWp4
 d1J+n1nPpB6iWGDptuojSNkvXLQeWgsSkO1EtE6cK6yjXaun7MQh/yzG5FLKXsdEykt+fQ0Xo6
 KnIzAb6jYcHa2cVja6cu02ue
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Mar 2021 20:41:55 -0800
IronPort-SDR: BMLKTO+7EWMjFyLzAVBB4SvatMYGzgbT/lYW8NHh/f1kw6qE6BbqzYGp5ce8yHqcJExlvw6gwL
 veUNwGi7Gz1rkXOaMMWb+DCnkVlTBHG2XF0LEho5ZZ/Bu1jhgj0zgvKjk5Om+7Vm3nm31+x7fT
 mPL3n3uxArvCKG+4vUJPLq3knDLh/lLmHBTOrp+H7GoBHbybGBG+svgkRBF9vImdsg/85zEJih
 7Js7lDyJp20f+3zO6ktAV6PWr27wnWETt24E7VZTB8pad/vzb+voZ416I0KTIoQ1S/yAN0Mai9
 dNs=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 08 Mar 2021 20:59:13 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, damien.lemoal@wdc.com,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V10 5/8] nvmet: add nvmet_req_bio put helper for backends
Date: Mon,  8 Mar 2021 20:58:20 -0800
Message-Id: <20210309045823.18545-6-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210309045823.18545-1-chaitanya.kulkarni@wdc.com>
References: <20210309045823.18545-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210309_045914_328467_90CBC7B1 
X-CRM114-Status: GOOD (  13.85  )
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

With the addition of zns backend now we have three different backends
with inline bio optimization. That leads to having duplicate code in
for freeing the bio in all three backends: generic bdev, passsthru and
generic zns.

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
index 394090bf75a6..9a98b18a50d8 100644
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
index cf592035e569..ba7c609b9427 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -653,4 +653,10 @@ static inline sector_t nvmet_lba_to_sect(struct nvmet_ns *ns, __le64 lba)
 	return le64_to_cpu(lba) << (ns->blksize_shift - SECTOR_SHIFT);
 }
 
+static inline void nvmet_req_bio_put(struct nvmet_req *req, struct bio *bio)
+{
+	if (bio != &req->b.inline_bio)
+		bio_put(bio);
+}
+
 #endif /* _NVMET_H */
diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index 26c587ccd152..011aeebace55 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -206,8 +206,7 @@ static int nvmet_passthru_map_sg(struct nvmet_req *req, struct request *rq)
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
index 96bb1b041105..cb480560ebb3 100644
--- a/drivers/nvme/target/zns.c
+++ b/drivers/nvme/target/zns.c
@@ -302,7 +302,6 @@ void nvmet_bdev_execute_zone_append(struct nvmet_req *req)
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

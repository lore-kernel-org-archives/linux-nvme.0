Return-Path: <SRS0=tknV=IJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E291C433DB
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Mar 2021 07:16:19 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C80A864E77
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Mar 2021 07:16:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C80A864E77
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=UY88X3vcACuqeytBjXBVbK8Okf/N98jnsHMiz3ZHAZs=; b=djq9BaQ1UH+7u2cCTRSv6NnNh
	BWdS4KwEImDzlxJ9Xdzr6CGkOPy9j8uVoa9lbiX6isUPidJpp4AJJhndLr5UKv/drnfhRVd2Fddzy
	TKTfkZuitOko4MAfPkwrdYn546EZMTOqMucHqRXc6YtEC1xGUGZT+e8eGUl4IcXGbZmDyYuvk4LU9
	UIP+vldb+yY9GPuf6aCskQKq4X0MkAqjP3R+hNCHXEEtJNpJTklyHECCXoN7IG5kbc7tt0N0JFvJ0
	7QtPDVRcriG5ptlWJWacjDrZHWjKzepiIARPDaoZmLoHCFxaG6jY7UNEqqohMJrBuTRjoWTAYvPX5
	lvpp3UQLg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lKFYK-008atn-2S; Thu, 11 Mar 2021 07:16:12 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lKFY8-008aqY-DY
 for linux-nvme@lists.infradead.org; Thu, 11 Mar 2021 07:16:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1615446961; x=1646982961;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=QGCm7z33Chb26s+Bsn9lwJNEMY+0Wx9VcGkbY2T2bIA=;
 b=K3hpTrjtyRg+rX6dornO4ZqbwlbPASDO0UunNmbR/QeD6h1sWh0ByM06
 DjyYeFd5Ph5YGTjsZxXkCLmWFUj2YOojTgo+tAb+yM/HVlk24TQMIExkw
 CGMugQh+xBp7SftlVHxT3WR0EhFHkbgJD0jn551NS55qalJQ5nXg3N5AM
 NBp+ta1ELc8Y2oDqCf1NwJ9nVEB+bg+wR/H3HqUJfrsOlRUpwqv4kVbRJ
 on03nRe8aVx3uxNVvluThQQOkznOivA3AZy8r7T8W+cvTy4ya5dXCGg3H
 ipBGAeFlgnhR1c55y717WgpKj7qvxlMIQ4Gs0qMw/6HFhmDGieYlzmfZU A==;
IronPort-SDR: sfgumXO0WzjHXf9VllL+vCdQ9o7nRGTNRjD/ZGbagwlLHCQeqor1N8syYvuN8WT0dUqJbij2NA
 3gMXTkEtfzjwV6tg38hk42CcmlgaG6uuWv/7FpThLRBhVsrH5ZiaEGEDZao2W5RV/XPcKIzcgP
 scQud/ZBT9NX8wJ8ZjlRCT1j2/v7qTkmESyNGBcFx8PsAUORPkIzU5ffyY+duet/Ew9ax1qPJ/
 zynVy7wvRSbh+zUuyh7WnIvPDzDwzhRXHRIeHrhN5bfYJHVvjAl0waJ6AAHqU+fp3kMPk9cUz7
 2dM=
X-IronPort-AV: E=Sophos;i="5.81,239,1610380800"; d="scan'208";a="163050705"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 11 Mar 2021 15:15:59 +0800
IronPort-SDR: UtuctYNymEB+gMT39YrWb5EBsasg45W/l4EeHa7WGiS1ugAOJkTtdr0N1mfBTJQFg9k9KM64oX
 Gj6FlHzH+jz/f7H33sEtGJWanjKH3nejiabOUMPNR8KkMmBeqKUvV55bv+S7QIOe0egBINmajj
 dM040RTd5Pf3vZ/If2cD55CKxeW9BEdL+l4vPcD8b8QvPCsAwPjJEJtv1mNv/eGr8k+m2TOkd+
 CjkYfYghVO3NrTGK1vIrQzfAKvijC8U2o+urO7daFzDdrSn8kRinvbuuBbLwenHq7kYqf836Lj
 6Y9cXLGLyZSUYMFQ2S40aN7T
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2021 22:56:53 -0800
IronPort-SDR: pqxsQWVDbzluSnIHuPfstI/04rFdKM5uC5i7Lkn1tH4/zUyswQSd/KSA3umTrMc5optZyKHgG2
 pQEZSudff0IZqeosBaBBIXt82kcyuHuthlI46l9kTTgfQOwx1tEDBxDepGKXzVQ3UWRRckkBZR
 9ooEbaPIn/sZMZ0eRzLUZQbjvVjKVIF90kziwUp5J/8eVaZmS302dH/Vzrns52DMw4QL8KyooB
 CgYA6xShORlnQwsrszWnGl95EOnIl8Tvx0hs5Gnnv419XdHPXm/ZBFbalt4yhezU1J+9JjsA48
 QcQ=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip01.wdc.com with ESMTP; 10 Mar 2021 23:15:58 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, damien.lemoal@wdc.com,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V12 3/3] nvmet: add nvmet_req_bio put helper for backends
Date: Wed, 10 Mar 2021 23:15:30 -0800
Message-Id: <20210311071530.18680-4-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210311071530.18680-1-chaitanya.kulkarni@wdc.com>
References: <20210311071530.18680-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210311_071600_830721_79D04DB1 
X-CRM114-Status: GOOD (  14.96  )
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

Add a helper function to avoid duplicate code and update the
respective backends.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/io-cmd-bdev.c | 3 +--
 drivers/nvme/target/nvmet.h       | 6 ++++++
 drivers/nvme/target/passthru.c    | 3 +--
 drivers/nvme/target/zns.c         | 3 +--
 4 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index ada0215f5e56..ca39d787d71f 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -173,8 +173,7 @@ static void nvmet_bio_done(struct bio *bio)
 	struct nvmet_req *req = bio->bi_private;
 
 	nvmet_req_complete(req, blk_to_nvme_status(req, bio->bi_status));
-	if (bio != &req->b.inline_bio)
-		bio_put(bio);
+	nvmet_req_bio_put(req, bio);
 }
 
 #ifdef CONFIG_BLK_DEV_INTEGRITY
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index f3fccc49de03..2f1bd3ac34a2 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -654,4 +654,10 @@ static inline sector_t nvmet_lba_to_sect(struct nvmet_ns *ns, __le64 lba)
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
index e12629b02320..112d213583ea 100644
--- a/drivers/nvme/target/zns.c
+++ b/drivers/nvme/target/zns.c
@@ -326,7 +326,6 @@ void nvmet_bdev_execute_zone_append(struct nvmet_req *req)
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

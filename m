Return-Path: <SRS0=ToWz=FO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03132C4361B
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Dec 2020 06:27:39 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B893823C43
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Dec 2020 06:27:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B893823C43
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=OOWaGp4UeSMXuDiCU9Lc+AcbaKVl6lmeBTpfOizmIVI=; b=2w71H/T6MhoSVbYTvukeDBYek
	o0sJOwd2KlHoR74kN5RnbuQf2F3+HaaAWnmvNGF6ZC5KNdZdGf8zXxZTSdfwVTCOuq7f0t2+eSbob
	6Hvwtx0gbJtkrhI9kQ1hYu/iQsfNBsMuPjDo0JkrfBHiiyIQ7SgWQ6Jt9zvWmKFP00Q2YeCSE9E+I
	2SCLCu8p5qe5+tPSFxkxhlNYkM68lQd5U//aAeEhSkzayVDn5ixtWIiIeAkzEcdfZ+NL+a43YlRFR
	YajcTYyE2wbRjenSwWM6tgYYYR1iDRWzeHMavyGmDt7Jj1Au0/HpcrZAdp26Y2tSZ469fFcjx7Qud
	YNBLYZvPg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1knFQO-0001C4-JN; Thu, 10 Dec 2020 06:27:36 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1knFQM-0001BL-6o
 for linux-nvme@lists.infradead.org; Thu, 10 Dec 2020 06:27:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1607581654; x=1639117654;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=lOMLIaJDmIDD0WogVMYt9X+5GYen2N6/lQaazz+2jhs=;
 b=jW/VFKeqTiCipQ2rVpOxtuX9Ioi2eWtsqR/2xJe9c/kSo6El39AGMYgz
 +bPnpYOO/9sZji6jV9Ji3PYS0W7ex+0lBves83zda0O0iss5cwqDp0kDS
 cbfltc5H9thmeCvWGYWKtzjEjSSSrg2R5OgzL62UgMHUTB/EUTLb8K4yH
 jsH8KpGmtTCi2u6bLcnf+Wbrfsn2rnZ267+jUwKUhFa9D/YB1ca4lmiS6
 vAORsr4kbVgOW3S4pJTXmNodn3IBtpoI60vWmJTu97eR1MSvGnAohek25
 +JGxHy/zbxL37KYjpX9smExqzG09K1+WExQj4DXtxMs2EMZtNr+We06S/ g==;
IronPort-SDR: ESVdop+Sy/5VHCZw2cCPotEwMnVmEknyy2aaGC58rYiDqOYIUo1s4LC/YrMD/jDJmQm2PZ1Wcd
 qL/aludRmuq7xLEA1Sue1oQ8VCD9kvsny7Wi0kcaV4i3z762wl1V8brLg4X/aDqCFLioDTjxPD
 wdfuLvdYjxoqBgQOWuM5EZ0haQ2ptQQFRnmKfHRlSjFfX4UiKBCwrMrGRFvGpQBUbVPq322MS4
 3AVrl667MYkr2mt94lx5zNY8Yeq61iwlgEgKqZwdBPD8Vz4txSId/wvNKlWktVEobuAqqZiC08
 gXI=
X-IronPort-AV: E=Sophos;i="5.78,407,1599494400"; d="scan'208";a="264993815"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 10 Dec 2020 14:27:33 +0800
IronPort-SDR: fST+hZNs6OhY46XfF6MkCXeog8qY2efYW/eMIT00hnNvt+W2wY/JdIAipXv9auNipxAG6ihT+V
 6qI22yAHIT3gdheK3Ho8IV+cv1R7r/0EM=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Dec 2020 22:11:28 -0800
IronPort-SDR: F+ipM1tH8HcRaAAnfS9DyeWqO5AivvL0vFXA1Z5Xmf5lv4aX8GCdQuvbZ0KyFi39TQHALUxuOp
 AYWJqkC46MJA==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip01.wdc.com with ESMTP; 09 Dec 2020 22:27:34 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH V5 5/6] nvmet: add bio put helper for different backends
Date: Wed,  9 Dec 2020 22:26:21 -0800
Message-Id: <20201210062622.62053-6-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201210062622.62053-1-chaitanya.kulkarni@wdc.com>
References: <20201210062622.62053-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201210_012734_413333_1BA46492 
X-CRM114-Status: GOOD (  13.61  )
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

With the addition of the zns backend now we have three different
backends with inline bio optimization. That leads to having duplicate
code in for freeing the bio in all three backends: generic bdev,
passsthru and generic zns.

Add a helper function for the duplicate code.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/io-cmd-bdev.c | 3 +--
 drivers/nvme/target/nvmet.h       | 6 ++++++
 drivers/nvme/target/passthru.c    | 3 +--
 drivers/nvme/target/zns.c         | 3 +--
 4 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index 6178ef643962..0ce6d165dc4f 100644
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
index dae6ecba6780..7ef416de4f6f 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -618,6 +618,12 @@ static inline sector_t nvmet_lba_to_sect(struct nvmet_ns *ns, __le64 lba)
 	return le64_to_cpu(lba) << (ns->blksize_shift - SECTOR_SHIFT);
 }
 
+static inline void nvmet_req_bio_put(struct nvmet_req *req, struct bio *bio)
+{
+	if (bio != &req->b.inline_bio)
+		bio_put(bio);
+}
+
 #ifdef CONFIG_BLK_DEV_ZONED
 bool nvmet_bdev_zns_enable(struct nvmet_ns *ns);
 void nvmet_execute_identify_cns_cs_ctrl(struct nvmet_req *req);
diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index b9776fc8f08f..c2858ea8cabc 100644
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
index ae51bae996f9..d2d1538f92d4 100644
--- a/drivers/nvme/target/zns.c
+++ b/drivers/nvme/target/zns.c
@@ -321,7 +321,6 @@ void nvmet_bdev_execute_zone_append(struct nvmet_req *req)
 	req->cqe->result.u64 = cpu_to_le64(nvmet_sect_to_lba(req->ns, sect));
 
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

Return-Path: <SRS0=WFi/=JF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABC52C43460
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Apr 2021 00:15:49 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55DAF61028
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Apr 2021 00:15:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55DAF61028
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=EXHxoWLB0Lp5v7xxH12pOwfcZ5ohBOiy/RMWYUSNn4I=; b=dQDHyxYmk21YucWFm/OPDpQH2
	ORUkW7r5EacXuqPH4Cgddp9wtpZG53OG1gRzSmpqA567ZcO/U05UR9VB6rRuh+cr1tv+DDEgQzfbf
	pKDf7WuH93USDq5zM2lLzlVHlx56fHQvM8noH2OEr+HrO8iQg+C/CPgckpQkami20rdpuW64LbptU
	k4shJ4IQnAyLJ3IE0gMsNwfEGu9Jy58Jo41jLNjnxqPb56otnRpKT2pm0jW3+Kv3TE0cqCUqCQxi4
	vSDC4QR21V99wszL3IH85ghoh9F/ZLBZ6qrjV/pLoTBFjeN+hPPsTX0658WDzqiJmL0BGUcrfbqUF
	KnG0VzsIA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lUIKV-006L3W-5g; Thu, 08 Apr 2021 00:15:27 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lUIK0-006Kyq-Cu
 for linux-nvme@lists.infradead.org; Thu, 08 Apr 2021 00:15:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1617840896; x=1649376896;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=x7uDFmmNLnrGw81NvkuIIb4xrK2bt9g3WEzy4UtDx4k=;
 b=pQt402KRpmIF4Au+uA0SUfCFFlc86I7UHVX3f1jTMiJc6DTg2B5nkl0U
 Ys3BcAD2zDJdXzgGwEYdExeVYfniyKH9PkfRjFAbNH5va2z/2herJ5KJV
 88Z2fLOi2efua9tN4a8QhYqAhyGDn6WcQX4L7aeNtqSHfduO6xbzygVKV
 M3pgMqguzqYDj7ThcZZdFFQf5vo8kpj3+lz3Zez9CoVe9b7qgB0UF8M4b
 Ue04hKEM04dpaX4mbURrjNxYvECj8qegUGCP3wGhc8fYwqQdAMhcD/IaU
 ns1OPH/7HhNZzhUEiM1kA69Dim3nUnWbMf3jtWqhxSEB6IdsyEUcbxTbP A==;
IronPort-SDR: Xv0GLuy6UKHGVSsJUt1WbMzfOgQz6sF4CVH3w1DMJipSNLHsuLbVm4V32RVmvKuv0htzGmpH6/
 UXwS18qXu+1Es+Yo1aWkzb2Jf9WtKObrVw42v7bXvyDpDLHYqfiVV34+CAAjqO8iwoWPP8y7Uw
 tFRRED/w0YRj6lx/C4HOqwldbx2DjNa2Yty7wMgkucpk7hT4gs2EpdfTQepnXZusV6IQ7hZaam
 1khDsrN318saN/NodhVvbulebkz0aYriOY4SyjozxyROPTYfWe5xrXLlegOi2lymdVYw18gLnN
 jIk=
X-IronPort-AV: E=Sophos;i="5.82,204,1613404800"; d="scan'208";a="164137392"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 08 Apr 2021 08:14:54 +0800
IronPort-SDR: FLlpAcoJ2Rn/DztOqgqnuD8kLKFFkQRPAtSJzX7kfcWI+qMDwwFKckxRJ3tyOSP7x0AQE7pfRV
 chevsdApsev2HqwWigtmwo6KXu4UIU/BNBAmPI8khNf/X6MXlx1CyDPXWH8xoy6OexB0aZ5YuD
 /OXtiL503mPsWJZ+R396P9SKcwxwGjm9T/cABqDfaz/2cQyVcP6YbLC/UQDxxYGL1F3OjnEFcZ
 jT9K+skYUaKiWocJr6Fxl3imwqtHz+xbe8H0y+WaECvbBJ3bifbUautlaZOEUNhjshEf1jRn6m
 T1JZ51kLy+Svsaw+3oF2iAow
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2021 16:54:38 -0700
IronPort-SDR: 34YRd8HjbZ2YQb3cwEdUgbCzWzjBhoLb+sD+Xo3BhISnxaLKafSC8BJ8fX6PjWv9fL5mURy5Rd
 8E00Lz4d5vrjpUi/Txk0nOlZTlg/M++Okef3k9z9BIp/pBAN5K6v6HfNFcjVSd7vcrH1BJwptu
 dQG7Q4sinya9eYz0yFgH7VrXvm3BetO2IY+kUrcX5zaBElSN9A3GPAirgnmxb1kV4sLJP2mrcf
 uJJaM3lOKClU2orFEGyIL0SgHaL2m9xc0Uo4sMeoVTVPNUJ75bkPpLy6xP5VQGHNlPzFcYfsQO
 664=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip01.wdc.com with ESMTP; 07 Apr 2021 17:14:54 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, damien.lemoal@wdc.com,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V13 3/4] nvmet: add nvmet_req_bio put helper for backends
Date: Wed,  7 Apr 2021 17:14:26 -0700
Message-Id: <20210408001427.20501-4-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210408001427.20501-1-chaitanya.kulkarni@wdc.com>
References: <20210408001427.20501-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210408_011456_807795_89C834CF 
X-CRM114-Status: GOOD (  13.39  )
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

With the addition of the ZBD backend now we have three different backends
with inline bio optimization. That leads to duplicate code for
freeing the bio in all three backends: generic bdev, passsthru, and
generic zns.

Add a helper function to avoid duplicate code and update the respective
backends.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 drivers/nvme/target/io-cmd-bdev.c | 3 +--
 drivers/nvme/target/nvmet.h       | 7 +++++++
 drivers/nvme/target/passthru.c    | 3 +--
 drivers/nvme/target/zns.c         | 6 ++----
 4 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index 1e54e7478735..509a053d1f40 100644
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
index 5e6514565f8c..cf542bf5df31 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -664,4 +664,11 @@ static inline sector_t nvmet_lba_to_sect(struct nvmet_ns *ns, __le64 lba)
 	return le64_to_cpu(lba) << (ns->blksize_shift - SECTOR_SHIFT);
 }
 
+static inline void nvmet_req_bio_put(struct nvmet_req *req, struct bio *bio)
+{
+	if (bio != &req->b.inline_bio)
+		bio_put(bio);
+}
+
+
 #endif /* _NVMET_H */
diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index 2798944899b7..e1487bb2240a 100644
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
index 308198dd580b..328ef95a5812 100644
--- a/drivers/nvme/target/zns.c
+++ b/drivers/nvme/target/zns.c
@@ -411,8 +411,7 @@ static void nvmet_bdev_zone_append_bio_done(struct bio *bio)
 	req->cqe->result.u64 = nvmet_sect_to_lba(req->ns,
 						 bio->bi_iter.bi_sector);
 	nvmet_req_complete(req, blk_to_nvme_status(req, bio->bi_status));
-	if (bio != &req->b.inline_bio)
-		bio_put(bio);
+	nvmet_req_bio_put(req, bio);
 }
 
 void nvmet_bdev_execute_zone_append(struct nvmet_req *req)
@@ -471,7 +470,6 @@ void nvmet_bdev_execute_zone_append(struct nvmet_req *req)
 	return;
 
 out_bio_put:
-	if (bio != &req->b.inline_bio)
-		bio_put(bio);
 	nvmet_req_complete(req, ret < 0 ? NVME_SC_INTERNAL : status);
+	nvmet_req_bio_put(req, bio);
 }
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

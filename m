Return-Path: <SRS0=3deH=D5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB6EDC55178
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Oct 2020 01:03:36 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42913223FB
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Oct 2020 01:03:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rcj+jWkC";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="KjDSVdvF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42913223FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=lT6PGsiqY6FQLjUFpVRN7xUuGezHf+ZwtfBFErpaB/g=; b=rcj+jWkCa1AFYE8fmbb9bdyWV
	KZrlXRHgSITcQi5MLfvAv/glkIeoU64+gbRvcUm8bYG/NJWY3aHZf3UHsgvJI+SPTNfJL2VeR49WQ
	5Baxc4jCcid//Vm8TG017tQv+OPVNZH7EYYLT/l92yt4ArpBLIrgM1Rn5X2Z92K/s4pp/RjZnobaL
	aOgQb0rkJFR1g6fbCeItgJbL4QTr2nUOVXERSypVJU0Nd3AuInh3fwbTpdx3iOlAYW9w1OJQZj6X0
	7jHOXEF/YilrdSQ5CiYYCKn8SxoRvzOrU/hXEj+ymfU35MCjTh0cEXD7gFOK6BXA6F0jv912lnbMw
	Uzf4NMCwQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kVP0t-0004EA-PW; Thu, 22 Oct 2020 01:03:31 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kVP0r-0004D2-0s
 for linux-nvme@lists.infradead.org; Thu, 22 Oct 2020 01:03:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1603328608; x=1634864608;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Y+hmrbRo5JQNhnhjQXfoPvp530DmB5g2Qp7dpvys4W0=;
 b=KjDSVdvFJu4ZV82yw/LPl9sWXjTISIbehxAGEZq1cmZ0jg657VfDOAHM
 x/uoXIx4TMesiJnmxyT8vdUkDrawhxIOGKHWQdo1kvkEKMmBEkO48g4GF
 ZD7bNvGKvvy0+YWlMqfrihb5VOi/Xg8WqfHa7itvg5o8/fuA10noPYFoL
 Bwnp5Kk6C0R8W0EvwIaruXNakbF4OJE4FVNtAsmACW8aP9iI9VAAYba/x
 r2fm3gpqPc1hDrdpk8hsRYGdAHqQM06Z5QvGR13kpws54Bq/dqSsPwnx9
 q7qmWXMIf2o6rZqxYXSp6RLynwt+xfHUVokcpJ31oqsoTxjqomZITrO1D w==;
IronPort-SDR: 7EfZyhrtomcHHnFa+FBUnhWMcSpHPf7+hK+qIk00BjDyZOGzhaamP4R5eGBBQxAW+J6W8VAAak
 8tss2KfDVrYxLVOXoAJXewsvOD2GJ9x0yoUwiSvTaTsG6s7wYqAG0LDbUz/bbSGt77cc3cXKXA
 eIsXgZMjonsuUUHt3NbE6DlGhCC5qaVB1yWb+LOHAJSJG7h80yi9hoIT4vNJkUAB/CFjuwWANB
 0fPp1FI2kBTTOafFWDGouP/rtrPmnn8j22Gdg3B1ckfOET67uDoB6sye+mIOXDExANyYFEMVvE
 15c=
X-IronPort-AV: E=Sophos;i="5.77,402,1596470400"; d="scan'208";a="150488813"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 22 Oct 2020 09:03:28 +0800
IronPort-SDR: FkRWWL47m8FgKTcur2NaWtR1YM/SPmvDuckRARt8ltnunQMMuW1F3OCb0csTXmsqsklUsHT+kl
 4r4grGKTGAvW5UnwSc670y8jaP/CuZKpWoF6iCVf1x5uJ6LnyaTlIRBB66t4Us5XRPXzFGKo+r
 d7LLoSWYd05JScc06rYfMurm+F3cxZhWpKsXPmuQrJFU7z73qz0Bvn91tY/2gN+I9nkkEzd1/M
 HUgPGrzLi9vjOmce0Dg+dgoyzLo7BnS8Nd7H2O23EkGeurGvef9WR8n7Iyll2pFGRGdiP0OZnd
 Lb4GIUEZi0jZxVaePDOZjyWC
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2020 17:49:00 -0700
IronPort-SDR: KJa3ahp/xsHYGqmeHzjSY7mOl6UdUWE+WcWU7cmfHYmIPtTOHbscpC9l9IZ4qummNULL3RURns
 1UFw8FwrrzZ2JzD2HXIR/yuyOzZLVruLJrzGDaF7temfUDF2o6A2t6guOW2Rtb/DYB8plpWRcX
 DCa8LGZJm+NGpPuB/x88DadWQmccBf/5ehus7oWEUxKRtNEeVz4pXKofc8WqmgTmEa1C2rg8Jd
 vApZvQwPe9oofya9sjmDMMsGqaE+UAf8m9s12X8qtr1kCbaWr8mcfiJQH9kGEFL72v4d2BYftJ
 MGs=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 21 Oct 2020 18:03:28 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH V3 6/6] nvmet: use inline bio for passthru fast path
Date: Wed, 21 Oct 2020 18:02:34 -0700
Message-Id: <20201022010234.8304-7-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201022010234.8304-1-chaitanya.kulkarni@wdc.com>
References: <20201022010234.8304-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201021_210329_465171_AA94AAB4 
X-CRM114-Status: GOOD (  18.04  )
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
Cc: kbusch@kernel.org, logang@deltatee.com, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

In nvmet_passthru_execute_cmd() which is a high frequency function
it uses bio_alloc() which leads to memory allocation from the fs pool
for each I/O.

For NVMeoF nvmet_req we already have inline_bvec allocated as a part of
request allocation that can be used with preallocated bio when we
already know the size of request before bio allocation with bio_alloc(),
which we already do.

Introduce a bio member for the nvmet_req passthru anon union. In the
fast path, check if we can get away with inline bvec and bio from
nvmet_req with bio_init() call before actually allocating from the
bio_alloc().

This will be useful to avoid any new memory allocation under high
memory pressure situation and get rid of any extra work of
allocation (bio_alloc()) vs initialization (bio_init()) when
transfer len is < NVMET_MAX_INLINE_DATA_LEN that user can configure at
compile time.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/nvmet.h    |  1 +
 drivers/nvme/target/passthru.c | 20 ++++++++++++++++++--
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 559a15ccc322..408a13084fb4 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -330,6 +330,7 @@ struct nvmet_req {
 			struct work_struct      work;
 		} f;
 		struct {
+			struct bio		inline_bio;
 			struct request		*rq;
 			struct work_struct      work;
 			bool			use_workqueue;
diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index 496ffedb77dc..32498b4302cc 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -178,6 +178,14 @@ static void nvmet_passthru_req_done(struct request *rq,
 	blk_mq_free_request(rq);
 }
 
+static void nvmet_passthru_bio_done(struct bio *bio)
+{
+	struct nvmet_req *req = bio->bi_private;
+
+	if (bio != &req->p.inline_bio)
+		bio_put(bio);
+}
+
 static int nvmet_passthru_map_sg(struct nvmet_req *req, struct request *rq)
 {
 	int sg_cnt = req->sg_cnt;
@@ -186,13 +194,21 @@ static int nvmet_passthru_map_sg(struct nvmet_req *req, struct request *rq)
 	int i;
 
 	bio = bio_alloc(GFP_KERNEL, min(sg_cnt, BIO_MAX_PAGES));
-	bio->bi_end_io = bio_put;
+	if (req->transfer_len <= NVMET_MAX_INLINE_DATA_LEN) {
+		bio = &req->p.inline_bio;
+		bio_init(bio, req->inline_bvec, ARRAY_SIZE(req->inline_bvec));
+	} else {
+		bio = bio_alloc(GFP_KERNEL, min(sg_cnt, BIO_MAX_PAGES));
+	}
+
+	bio->bi_end_io = nvmet_passthru_bio_done;
 	bio->bi_opf = req_op(rq);
+	bio->bi_private = req;
 
 	for_each_sg(req->sg, sg, req->sg_cnt, i) {
 		if (bio_add_pc_page(rq->q, bio, sg_page(sg), sg->length,
 				    sg->offset) < sg->length) {
-			bio_put(bio);
+			nvmet_passthru_bio_done(bio);
 			return -EINVAL;
 		}
 		sg_cnt--;
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

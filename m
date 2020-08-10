Return-Path: <SRS0=L2sc=BU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF2FBC433DF
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2020 18:57:07 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9683320774
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2020 18:57:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Cbf3UdCd";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="MIv6wwkC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9683320774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Hd72txvshMslRpWNw6VlO3XdAWQkXbgxoCSBrP2o7Ag=; b=Cbf3UdCd4RyrjPQvkV0of8wy9
	rqARP5ZcwkJWOdTy9W+a890sn6+MEIe2QkO8CQ8XIx2Dz+DiYHM3vNOF/14Vb5ftEDf7GhYL4HCEI
	RZy1mnJBB9NsDYmq8AwSrnjoKR/z9It3uBdcoJOb+Ba7x8K7iVeW1QmYrAA7912XnALm8xrMXiZ8k
	XiAEv/oIxNcxlwQjVqRpQZ2Mxb9+gKlvAN0xAYWpzEnZU6aV9H+Gk/9gKiaRwUop8i2dZJA813F4s
	C95TUU1oai8qnT2L9JDg1gXFxVDWMgpSi7kVZqPSHa7JZCiemKqC/5bpLC33vSY0FbCUu9p7b8V7z
	VBurukKGw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k5Cym-0007hQ-3W; Mon, 10 Aug 2020 18:57:04 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k5CyX-0007aB-Va
 for linux-nvme@lists.infradead.org; Mon, 10 Aug 2020 18:56:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1597085810; x=1628621810;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=A2Jmuzefg9VBRnlf0ViDLQL51oLcU6onfIrfhJYkWss=;
 b=MIv6wwkCiNxrtDlu5W7wk+X34dBiJYMxCqzNQc6EpIRYnAQUrFOH7fkX
 7mcqSlt/Og+csZ5Gd1ezuecKCEbiU4+f8/ggy8a6Mg0lMtn1b+9erGAEM
 0I1C63YScNmY7lY2C3wR0ZnKuvaXKl1p7fC1XwmsO0Cj6z8/XKrMpJr9b
 6M1JaBy0VZf1JRlFQ7BzTi6jqOsvuA/pIm+KmClG55NueOR1vkHBEthBc
 oZwudWB8DKZJm/rQgUJnGWuZIVHEO5rJCH/H5D4dbhyi375jnHZSsHpty
 VWhIQ/XXaxjeio+nE7GwmBXVciUk+8v7IFnDQagwJeUlCvaYS10plplDL w==;
IronPort-SDR: jGRCSufk32k1Gl6HBpAOTG/K32iXm6IdGvx3eqdjrvf0gpn8r5EZNprF4Sz/nXb530s5O1UB44
 1ysDroz8dn4b2Ua7D78U36bgiFSy4r5B6E+p+IsZPp3l6hMVw6U87Lxkf+4wZjndP+IvioxHMe
 dR64PtGtap02h4X18EEav5XIwKBjJ65HoylJmQMQcDheiJSnr+cVPeTPNQKfF0MZ0S0uLybxMP
 VnnOALcruA8gStYiXasOVOA0PtaC4uS08p9sEHek1Op7YMIaPEnc1lq3+Am6vVawex1xpIljix
 3Ks=
X-IronPort-AV: E=Sophos;i="5.75,458,1589212800"; d="scan'208";a="145829113"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 11 Aug 2020 02:56:49 +0800
IronPort-SDR: 9vITJOfjYK2Ae0btjQkwR+YUt8gHre2pwzohtJBDj5bPXhHyzXNBM/764i72cbx3SnTGq54RfK
 sDYlUHQo5Szg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Aug 2020 11:43:59 -0700
IronPort-SDR: nxJYD4wZP+015vuf+OvvjXRbz7X/DLrW4MblfZ7YG78JMYSbumOHiJBz4WN+ARni1ti352yQo2
 OtrMtQJcIPFQ==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 10 Aug 2020 11:56:49 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 14/14] nvmet: use inline bio for passthru fast path
Date: Mon, 10 Aug 2020 11:54:56 -0700
Message-Id: <20200810185456.7713-15-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20200810185456.7713-1-chaitanya.kulkarni@wdc.com>
References: <20200810185456.7713-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200810_145650_192582_3AB649FD 
X-CRM114-Status: GOOD (  18.46  )
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
Cc: hch@lst.de, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 sagi@grimberg.me
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
 drivers/nvme/target/passthru.c | 21 ++++++++++++++++++---
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 47ee3fb193bd..3dd18f593472 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -331,6 +331,7 @@ struct nvmet_req {
 		} f;
 		struct {
 			struct request		*rq;
+			struct bio		inline_bio;
 			struct work_struct      work;
 			bool			use_workqueue;
 		} p;
diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index a7ccc817ac2d..8b22a6c8f57c 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -200,6 +200,14 @@ static inline bool nvmet_write_cmd_group(__u8 opcode)
 	return ret;
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
 	unsigned int op_flags = 0;
@@ -219,14 +227,21 @@ static int nvmet_passthru_map_sg(struct nvmet_req *req, struct request *rq)
 	} else if (unlikely(req->cmd->common.opcode == nvme_cmd_flush))
 		op_flags = REQ_FUA;
 
-	bio = bio_alloc(GFP_KERNEL, min(sg_cnt, BIO_MAX_PAGES));
-	bio->bi_end_io = bio_put;
+	if (req->transfer_len <= NVMET_MAX_INLINE_DATA_LEN) {
+		bio = &req->p.inline_bio;
+		bio_init(bio, req->inline_bvec, ARRAY_SIZE(req->inline_bvec));
+	} else {
+		bio = bio_alloc(GFP_KERNEL, min(sg_cnt, BIO_MAX_PAGES));
+	}
+
+	bio->bi_end_io = nvmet_passthru_bio_done;
 	bio->bi_opf = req_op(rq) | op_flags;
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

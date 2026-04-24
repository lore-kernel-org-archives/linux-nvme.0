Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 749F9FF885C
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Apr 2026 22:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=E09dOn9ADG8OwTD8WVqq6oMOalW+1VMCECVk65HZSAg=; b=P2W+uVFdrYQ+DMwBJasEBPQ6io
	EJY1DDgRrQz1Mx/d6ZjD0Q/RyBd27UJo0kKVykAcOmI+JPvZGUBHrrGeU4Ocb3yALgYGUk5+xOxjY
	UrXt5AT+RGFgkMjXA3VlN/XQRHT+tgHZox6ZYekauUJLtb0x9cHm6JF0gVduvfWK6OCe0wqXB+ml3
	3DCxrrVieoYMO89Mdkt23cnlBrfgnioCPuXTzuBQkEWhRz6bKAvnfg6H94v+LoD9zFZDVr3jjyqoN
	wWqRsnj1wudsUUtimtT1OrboecGJw+eA8cbuMARfWFBFgp8VsItm0NCgoP+Dpr98EpsgXWhshJoIl
	TDJ8UtLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wGPEK-0000000Dpld-2ZTm;
	Fri, 24 Apr 2026 22:42:36 +0000
Received: from 011.lax.mailroute.net ([199.89.1.14])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wGPEI-0000000DpjR-0i5y
	for linux-nvme@lists.infradead.org;
	Fri, 24 Apr 2026 22:42:35 +0000
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4g2Sdj72WCz1XLHZ6;
	Fri, 24 Apr 2026 22:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1777070549; x=1779662550; bh=E09dO
	n9ADG8OwTD8WVqq6oMOalW+1VMCECVk65HZSAg=; b=TINU3I4H2sUD76hKNKY4E
	ecoby23j1sebYr9YdLWC84QOAwSnR532s/xlgMbuKsUERD68Wc/Yde3STcBuC2aM
	PE1dTANfXY87Pmyj/GfCobGbY5K0Ac1Y/fZlDe/Don3eNhficokWVCCKLTwd/aqU
	R7L728Af0KBajM4ZR0ih0HJgi0MYjuWHOUI8DpFHVAVSicyzWOCQAHvj4LolV6Ic
	90dTPIsToA33MKr8vV32lmnisq3iTweuaPBnkUYUITJrip5Ut4hUMGLJzn2kmdTx
	GcaiNw8/nFvuEeiH2IKQgoJvUiX9uUMwh3agAMryRbQqkUuqQlA1WT7ZuisJTlad
	A==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id BjifY1RZlGsy; Fri, 24 Apr 2026 22:42:29 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4g2SdV4kY2z1XLHYt;
	Fri, 24 Apr 2026 22:42:22 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 05/12] block: Introduce accessor functions for copy offload bios
Date: Fri, 24 Apr 2026 15:41:54 -0700
Message-ID: <20260424224201.1949243-6-bvanassche@acm.org>
X-Mailer: git-send-email 2.54.0.rc2.544.gc7ae2d5bb8-goog
In-Reply-To: <20260424224201.1949243-1-bvanassche@acm.org>
References: <20260424224201.1949243-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260424_154234_516544_A4AE3716 
X-CRM114-Status: GOOD (  12.88  )
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

Make it easy for block drivers to iterate over the copy offload bios by
providing accessor functions for the copy offloading bios.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-copy.c         | 47 ++++++++++++++++++++++++++++++++++++++++
 include/linux/blk-copy.h |  4 ++++
 2 files changed, 51 insertions(+)

diff --git a/block/blk-copy.c b/block/blk-copy.c
index 459ed8581efc..f49a5f835b4a 100644
--- a/block/blk-copy.c
+++ b/block/blk-copy.c
@@ -7,6 +7,53 @@
 #include <linux/blk-copy.h>
 #include <linux/blk-mq.h>
=20
+static struct bio *__blk_next_copy_bio(struct request *rq, struct bio *p=
rev_bio,
+				       enum req_op op)
+{
+	struct bio *bio;
+
+	if (prev_bio) {
+		bio =3D prev_bio->bi_next;
+	} else {
+		struct bio_copy_offload_ctx *copy_ctx =3D rq->bio->bi_copy_ctx;
+
+		bio =3D copy_ctx->bios;
+	}
+
+	for (; bio && bio_op(bio) !=3D op; bio =3D bio->bi_next)
+		;
+	return bio;
+}
+
+struct bio *blk_first_copy_bio(struct request *rq, enum req_op op)
+{
+	struct bio *bio =3D rq->bio;
+
+	if (bio_op(bio) =3D=3D op)
+		return bio;
+
+	return __blk_next_copy_bio(rq, NULL, op);
+}
+EXPORT_SYMBOL_GPL(blk_first_copy_bio);
+
+struct bio *blk_next_copy_bio(struct bio *bio)
+{
+	return __blk_next_copy_bio(NULL, bio, bio_op(bio));
+}
+EXPORT_SYMBOL_GPL(blk_next_copy_bio);
+
+unsigned int blk_copy_bio_count(struct request *rq, enum req_op op)
+{
+	unsigned int count =3D 0;
+
+	for (struct bio *bio =3D blk_first_copy_bio(rq, op); bio;
+	     bio =3D blk_next_copy_bio(bio))
+		count++;
+
+	return count;
+}
+EXPORT_SYMBOL_GPL(blk_copy_bio_count);
+
 /**
  * Tracks the state of a single onloaded copy operation.
  * @params: Data copy parameters.
diff --git a/include/linux/blk-copy.h b/include/linux/blk-copy.h
index 5e38cfc14a71..4c8435312752 100644
--- a/include/linux/blk-copy.h
+++ b/include/linux/blk-copy.h
@@ -43,4 +43,8 @@ struct bio_copy_offload_ctx {
 	void (*translation_complete)(struct bio_copy_offload_ctx *ctx);
 };
=20
+struct bio *blk_first_copy_bio(struct request *rq, enum req_op op);
+struct bio *blk_next_copy_bio(struct bio *bio);
+unsigned int blk_copy_bio_count(struct request *rq, enum req_op op);
+
 #endif /* __LINUX_BLK_COPY_H */


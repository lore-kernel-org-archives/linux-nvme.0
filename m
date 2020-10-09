Return-Path: <SRS0=D38N=DQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89322C433E7
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Oct 2020 23:18:39 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3F2E206B2
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Oct 2020 23:18:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="2xBU8i9+";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="kYJuDX3u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3F2E206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-Id:Date:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=YY1ifFdD+6GKUEdBfkSgl24VziTyTSJs7rTDdJZt+Uk=; b=2xBU8i9+jIdGgi74vhGUfzgT6B
	9/Pf9+wm8pqb+rPhPZhzSc2tDTfmXNFXnevx6sbB8JS4DW+FjJ0JL6FzLHAf+yAxIZKdHvfIjwL0I
	nH3q0u80wiWb9LJvJIyFfdUF+P5H0ycQPRoCx8L+12gcvFOVg+1u1FrHHDugNqE7LnHn/+mJKOzKF
	Rkz8b/5RycftdU4Va1cnmPYKqbxsndL8llqHU7FokaQeJ93nGwZG5G/bdO0/lVNch+zw0Pi/hIm5s
	46shbtIU5TZD6dQfFlgbOdOVPyjvp7M8VZamZqgBZ44uSnkAx50S3DNn3GFBr27tzDujYdUzasUc3
	oKovo/ag==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kR1ee-0003aO-KB; Fri, 09 Oct 2020 23:18:28 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kR1ec-0003a2-9G
 for linux-nvme@lists.infradead.org; Fri, 09 Oct 2020 23:18:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sxF6G2BPsT7JsBNWQ7HqKvwOgvgB4aUlksulBRLAiwM=; b=kYJuDX3u1GB7MzF876D9rWQHs7
 mLXzJ7XEvE56zZ5/Gu16OuO7RaIm6JwrFmIi7cILBkL4csWxlS7c5tr0kilkqpyRyJEcMFYWj3x6I
 KLocb+DgHGsqrSNr56MUvM/FCuEedkCL4k+1C4ypWDdrRbMff8WdbATSckpBfc5DCYC9xBh9wxCof
 FLNG5oHXD80Hm4lYEdV12H7CpQ5yLFaMfNZjhdOhYTc+a86y9Xjm9FCTkvSnfOC9GAHnPvrap/TPX
 1XnxVtJLVAzPBcUG6DY9LdYCm1bXtBCe4MO1XlUEq6w1TXV5lS31NPvIFenkiiV6dGRHTOXSMbLTo
 FoFjkSBw==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
 by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <gunthorp@deltatee.com>)
 id 1kR1eY-0005eY-7y; Fri, 09 Oct 2020 17:18:23 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
 (envelope-from <gunthorp@deltatee.com>)
 id 1kR1eU-0000Pm-VG; Fri, 09 Oct 2020 17:18:18 -0600
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-nvme@lists.infradead.org
Date: Fri,  9 Oct 2020 17:18:16 -0600
Message-Id: <20201009231816.1524-1-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, logang@deltatee.com,
 dgilbert@interlog.com, hch@lst.de, sagi@grimberg.me,
 chaitanya.kulkarni@wdc.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH] nvmet-passthru: Cleanup nvmet_passthru_map_sg()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201009_191826_378737_D68DB2DA 
X-CRM114-Status: GOOD (  15.05  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, Logan Gunthorpe <logang@deltatee.com>,
 Christoph Hellwig <hch@lst.de>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 Douglas Gilbert <dgilbert@interlog.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Clean up some confusing elements of nvmet_passthru_map_sg() by returning
early if the request is greater than the maximum bio size. This allows
us to drop the sg_cnt variable.

This should not result in any functional change but makes the code
clearer and more understandable. The original code allocated a truncated
bio then would return EINVAL when bio_add_pc_page() filled that bio. The
new code just returns EINVAL early if this would happen.

Fixes: c1fef73f793b ("nvmet: add passthru code to process commands")
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Suggested-by: Douglas Gilbert <dgilbert@interlog.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/passthru.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index dacfa7435d0b..076e829490a1 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -180,18 +180,20 @@ static void nvmet_passthru_req_done(struct request *rq,
 
 static int nvmet_passthru_map_sg(struct nvmet_req *req, struct request *rq)
 {
-	int sg_cnt = req->sg_cnt;
 	struct scatterlist *sg;
 	int op_flags = 0;
 	struct bio *bio;
 	int i, ret;
 
+	if (req->sg_cnt > BIO_MAX_PAGES)
+		return -EINVAL;
+
 	if (req->cmd->common.opcode == nvme_cmd_flush)
 		op_flags = REQ_FUA;
 	else if (nvme_is_write(req->cmd))
 		op_flags = REQ_SYNC | REQ_IDLE;
 
-	bio = bio_alloc(GFP_KERNEL, min(sg_cnt, BIO_MAX_PAGES));
+	bio = bio_alloc(GFP_KERNEL, req->sg_cnt);
 	bio->bi_end_io = bio_put;
 	bio->bi_opf = req_op(rq) | op_flags;
 
@@ -201,7 +203,6 @@ static int nvmet_passthru_map_sg(struct nvmet_req *req, struct request *rq)
 			bio_put(bio);
 			return -EINVAL;
 		}
-		sg_cnt--;
 	}
 
 	ret = blk_rq_append_bio(rq, &bio);

base-commit: 549738f15da0e5a00275977623be199fbbf7df50
-- 
2.20.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

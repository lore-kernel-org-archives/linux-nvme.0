Return-Path: <SRS0=oO1v=DX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C153AC433DF
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Oct 2020 22:19:18 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3E61221EB
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Oct 2020 22:19:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ky1UqQm3";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="lWp163eh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3E61221EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-Id:Date:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=BgeFA+t0pxRL6IhriMdWij3qQwvbPrMljBHJmef1sOo=; b=Ky1UqQm3TvhwbD1Lm7NHj/Voa
	wjgiQUVsyD3YbjU2BpVLSc4bCdKQIUtHUU7Pmb0b6+jre43RrIeffFBBWw8dZrz+Ulas/FSKQ3Jke
	wTpMDABOzc47p4IeDasycvMq3otjHTD9sXuqz7etcJDnfsVTHFTX+l1QXbp+FFNJ8JjvpihXkC7HR
	V+g/O7lIhakn1FDsXT31nEt0yp4bxPKkifUjEUq4pbezic6SkC10gUl8JK5avO6sDxvHTnsnM3C0l
	UjwEGZzh1K3z59a7+2cnKxIsEQc77aPNWBwh41zB1tzQJCL7RDqQv5LnfIodlVLXgHvH4m7eusdWf
	twEJSZXvg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kTY4A-0004FC-DZ; Fri, 16 Oct 2020 22:19:14 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kTY46-0004EI-D1
 for linux-nvme@lists.infradead.org; Fri, 16 Oct 2020 22:19:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=accAo7GRfc1As1/d931ZaiZGbVlq+zNfC2LuIiUeIhc=; b=lWp163ehnyZY1qv1gp2SqzgFI1
 VEYBRWuvF0vlwL0buf1HkghxmLtN3RCEvwdB47LbVbVQexX09q5/h9tIlxoL5/C1sr9y7139r3p3F
 BJ0HkGANvgrWvr9M5WGHzio8FfXcvs5Watx71xUkg9cVrrE/r2MRP7IjVRG5aAn1ahHEoHfdmfvrp
 +wJ+htvlQkTVhjpQcAwP9qbMJgIFo7geeJxJfIozUCuX+UbYnt8c36hPU+A+DfcurjfiLciuj2ZnQ
 Q/9b6P4tETpPwnwpMGGwgxyrwTHBmUB1d8VRPudS0RTTj5ri2QpGIk4xY2gxNMQH/2xfkAIXUpdFh
 zpIDa4yA==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
 by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <gunthorp@deltatee.com>)
 id 1kTY43-0005Ml-LT; Fri, 16 Oct 2020 16:19:09 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
 (envelope-from <gunthorp@deltatee.com>)
 id 1kTY42-0001EN-HC; Fri, 16 Oct 2020 16:19:06 -0600
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-nvme@lists.infradead.org
Date: Fri, 16 Oct 2020 16:19:05 -0600
Message-Id: <20201016221905.4686-2-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201016221905.4686-1-logang@deltatee.com>
References: <20201016221905.4686-1-logang@deltatee.com>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, logang@deltatee.com,
 dgilbert@interlog.com, sagi@grimberg.me, hch@lst.de,
 chaitanya.kulkarni@wdc.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v2 2/2] nvmet-passthru: Cleanup nvmet_passthru_map_sg()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201016_181910_458347_9398F70D 
X-CRM114-Status: GOOD (  15.63  )
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
Cc: Christoph Hellwig <hch@lst.de>, Logan Gunthorpe <logang@deltatee.com>,
 Sagi Grimberg <sagi@grimberg.me>,
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
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/passthru.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index 1ab88df3310f..8ea9b173f285 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -187,18 +187,20 @@ static void nvmet_passthru_req_done(struct request *rq,
 
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
 
@@ -208,7 +210,6 @@ static int nvmet_passthru_map_sg(struct nvmet_req *req, struct request *rq)
 			bio_put(bio);
 			return -EINVAL;
 		}
-		sg_cnt--;
 	}
 
 	ret = blk_rq_append_bio(rq, &bio);
-- 
2.20.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

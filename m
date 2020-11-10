Return-Path: <SRS0=JPfP=EQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AF9DC4741F
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Nov 2020 02:24:42 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9F6C206F1
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Nov 2020 02:24:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aWlRp+Da";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="p9aWxiP5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9F6C206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=4wpIiwEOtKxWjErNmmR3aFFYq0iO8mmH58J10kMvvIo=; b=aWlRp+Da+ekNLBsrfDw1C243d
	TX8lMWJmj83VI3ePSf7tUqvOMIPyXgrYTx+pwsBZQnejbjoMueanQzUmspT65pg/XsFcmUbNFZHic
	qcPmestqmxvcIsNaxAfN5whQekNVgrlTxn2i/5q9imiH44/x5gvBnTDEnTiv3aPZJcSLSgTMxjkiJ
	zQpJk43+zaSPqf1CNx39CDwt6UWqXIo9k4ifkucDz3lmbBMW8Ru5NOgOQrry/+jDfr41TyJaeCHLU
	Fdm6jlJ8yrnZtcZKBwWQmbX9ZFPeX9SF1zlgl5r21pPrxkKY/R7avcerltxvbw7cqns1RM8MmE5/E
	LYkv+p6EQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kcJKk-0006A0-Ko; Tue, 10 Nov 2020 02:24:34 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kcJKg-00066R-IJ
 for linux-nvme@lists.infradead.org; Tue, 10 Nov 2020 02:24:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1604975071; x=1636511071;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=XoQ22JwDeYI/Y/DWLZcgR5ylbUQpu3lntdI38exCX0U=;
 b=p9aWxiP5MJ8WCyvkpqGRFsIGD8zaBShanbXEM+hpWdXC3+WDLlBGnAho
 ZvnB0MMDYXWc0kW6CbKBCD+ZkylDOabMM9pOb9HFLlpbiWxDxp1KeGjUw
 TzSonrW4xE4m8M70UT+cUcV0R/sk+OxhOj0RQX3epyl71Qen9nvCHX30l
 fcy3HN4ymOdR4PUCOY2b/Ck3wj2G5RYDqrDwKZkQ8pOsaU78tZhZWUKTT
 l6pdrxMtInrDzjfbd7cW6RQEpe8/nj8pMkU7l94JaDKm/8hzqHbYc6ljk
 z/1Knp4klB35gjYIvt609oyyUoiTSU2Du6uePtLDKyIfnqeF31okLjOjw A==;
IronPort-SDR: MCR5ULft2kFxp5l6kFupm3s379eXYfbOfJS08FwKN5yHRNG/jsgIuqTxfOpAumrOeSLLuZJJfI
 sEXPD4zGl//lMj3bQtSOXbPbwbIXOWIFIQitk2LZvA9JCtuuFO/6fqOB/VCob9Ibf6TQyM3E5q
 ypcsC4pHOOFQZd/o1vOk37UjHbaq03V7XcUjeh/uVZHsYOyeO9J+EgG1bnVjeI2La9khl1rtzj
 tHquOPOqkh/QmPK9ZQJ7Y8PhydWWT3lHAs0zU33POj8qQQnaK2jqnGjgkVjUa6CoKvALps6Txt
 H48=
X-IronPort-AV: E=Sophos;i="5.77,465,1596470400"; d="scan'208";a="153438838"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 10 Nov 2020 10:24:29 +0800
IronPort-SDR: Y5xKbrcwUAwAwy5m/OO50GkKuhQj/agXEibr0qHOCOPG9Rl95SzffW7RXkYT8rNaFK6FJMdxt0
 /Ep0tV4mUNZZf8X14c+8ZoANFSYgNtEzm/flZvbkte2bXSQWFHTF7uc89MURi2ZSiljJuGlMEd
 2/861K5ZJgJ5RcEV9I9sOh2FoDBaECtlf2dy/QE2S/dj9kgkMRh3heUGYWqModVyjDMXxXMJzG
 VlfBbmWFTdw8xM4oARwrTtJwuVrtMgCO5AsbcK5PpBEmkfIWwyy+tiKivEv/d/tZfH6i8OGiHI
 xLKqSO+ASCxeE8N1KhflVXjA
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2020 18:09:17 -0800
IronPort-SDR: k/oTFRZ0M7LN/uh6B+sFf+F/T1+gy4L387SrYXmBm4vrxBZpsmbuOqaJ9OUzv/pUXW0lHaU4kR
 tABtCSeGGpcIFJ6qPqjA9azj5fbbvhDnaWJuvY5TZPbMfgCJq3o76qftchjAnZVqQG42K0se1R
 8eObAWZkcetWaWrLnrPgQOLx777z278+yJDFiRP+RabwQtHwODhp7Q/DDlHTeoh9tbMAkeiDoV
 K51A74o6H6ZRCzcFZZ2GS2n7gad1CUU0kWtmxZwkhITqXWKRQ/Ycn2eumRd9YcxFgcjtHrAyWD
 YQ0=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 09 Nov 2020 18:24:28 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: [PATCH V4 3/6] nvmet: remove op_flags for passthru commands
Date: Mon,  9 Nov 2020 18:24:02 -0800
Message-Id: <20201110022405.6707-4-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201110022405.6707-1-chaitanya.kulkarni@wdc.com>
References: <20201110022405.6707-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201109_212430_817894_BDDDEB53 
X-CRM114-Status: GOOD (  13.91  )
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
Cc: axboe@kernel.dk, sagi@grimberg.me,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, kbusch@kernel.org,
 Logan Gunthorpe <logang@deltatee.com>, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

For passthru commands setting op_flags has no meaning. Remove the code
that sets the op flags in nvmet_passthru_map_sg().

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/nvme/target/passthru.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index be8ae59dcb71..1c84dadfb38f 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -188,21 +188,15 @@ static void nvmet_passthru_req_done(struct request *rq,
 static int nvmet_passthru_map_sg(struct nvmet_req *req, struct request *rq)
 {
 	struct scatterlist *sg;
-	int op_flags = 0;
 	struct bio *bio;
 	int i, ret;
 
 	if (req->sg_cnt > BIO_MAX_PAGES)
 		return -EINVAL;
 
-	if (req->cmd->common.opcode == nvme_cmd_flush)
-		op_flags = REQ_FUA;
-	else if (nvme_is_write(req->cmd))
-		op_flags = REQ_SYNC | REQ_IDLE;
-
 	bio = bio_alloc(GFP_KERNEL, req->sg_cnt);
 	bio->bi_end_io = bio_put;
-	bio->bi_opf = req_op(rq) | op_flags;
+	bio->bi_opf = req_op(rq);
 
 	for_each_sg(req->sg, sg, req->sg_cnt, i) {
 		if (bio_add_pc_page(rq->q, bio, sg_page(sg), sg->length,
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

Return-Path: <SRS0=L2sc=BU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88218C433DF
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2020 18:02:53 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54D7D20791
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2020 18:02:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gw9kp7a0";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="On3PakV9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54D7D20791
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=zLT7FXeDB9ZUH7mB2nCqxkewCfq+etvz2ZdlNhggT7Y=; b=gw9kp7a0yHhOtakGQFcXj/cgI
	POzfNokpQc84np/b0J0Ac9LPWliY60d72a7tPB16UofI4y+G+gyBBTzbyQKeCMJ0fjDys0OofKVHe
	BdiXpQYrY1fZDIWMh3Le1w/8VjUnpgvV7v0VFkFr8czRc+/qSX6bLGCB6s5otkJdY+ffwuXdmv5TJ
	qqRJ2sfVcFLXJMGNSQSoz2a5+/Q/eZqcOCqsLPYX0af8IshWWfAvs0D0tZUnbwlAB7HkcQqbsUT7O
	np9fmZ/XPJM1bY7WuyRRmmJEJU7JCE92nLFJhumIje7kj+2FJ7rkktKEdaguz2rIteFw2q/uFdQfw
	a7bWvtkfw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k5C8J-00013u-Cs; Mon, 10 Aug 2020 18:02:51 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k5C8B-00010P-84
 for linux-nvme@lists.infradead.org; Mon, 10 Aug 2020 18:02:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1597082563; x=1628618563;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=zOuEJ5uPincOQRuSuNHHbTNIk1/T3pIhzFlgDoXQ4Xo=;
 b=On3PakV9y2bLvO8ltVZLnmNqDbdYlyoQHIbQAmJk2ANuKi0hee3Ev4wz
 WXo53Mjpfkf1Cku5BZBYvWzoagk/5/nAku1whq4DejXfV+ubLRTaaJDNm
 7gZvw2IpZ7PhqwbPc3EGt2pAC8hJwanCBp8UTSbx8+mGypAsukNtg0OE/
 xrLrONgQkQc2PfbU2cadDfH53bLWrvVuwmmq3b4bD+9Z3yt+JRuEpjg9h
 wy8aXe2wqa93IXPEFkNA19kH2tuC17lxIfHXPqFslsF+Qq3Yms82amT+5
 13rkfBUNU05GuT5a6OECvIAWfdWXTktMPNLiGcvghZLA5yPmgsMSz2NZZ A==;
IronPort-SDR: eXUjQEoIg0IHraNBRw+W1Q2Tg5Qv8Ns0IsKKaOGQDLPk3wxzGl8lLjE+RtOr44YQzwMCb01a5p
 Q7cnYfu4ljHRnAHAaojJWVYA/b6j9AeDPqxw2Gm/2rui34VFzuA21/xwispi923N08urQYq3iP
 VWGAoYpj2E8j+9FnrOSTGKCRPO+di4gdf36/K/QcDB2JL22lVy8RBiZj7o1ZdfeGxVLCnKrkIO
 VEShaGVr8DUT/BkYXjNre3L6/2JSGCozCSUpjC3bI1zOty3t4FO3Y/8ztNW+xHczxwhgXaYB4P
 9P0=
X-IronPort-AV: E=Sophos;i="5.75,458,1589212800"; d="scan'208";a="144647711"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 11 Aug 2020 02:02:27 +0800
IronPort-SDR: goJsOHgFKTkEaxRRsMaaQplBmURZjI08WZAJgW4aJtXQQwofK6/daAz/snlOntDNxip5tsK2Ic
 MdLk1et0s4lQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Aug 2020 10:50:20 -0700
IronPort-SDR: hhEWnDod923Eal1z+2r9ub9z99LgNyNLeaomvOAE5tpaanl5IG74YfGuiANR22GiIoBdwQ5d8O
 yvV/x4nYOPTg==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 10 Aug 2020 11:02:27 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [RESEND PATCH V2 3/3] nvmet: call blk_mq_free_request() directly
Date: Mon, 10 Aug 2020 11:02:18 -0700
Message-Id: <20200810180218.5857-4-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20200810180218.5857-1-chaitanya.kulkarni@wdc.com>
References: <20200810180218.5857-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200810_140243_522008_E1583BAD 
X-CRM114-Status: GOOD (  11.62  )
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
Cc: Keith Busch <kbusch@kernel.org>, Logan Gunthorpe <logang@deltatee.com>,
 hch@lst.de, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Instead of calling blk_put_request() which calls blk_mq_free_request(),
call blk_mq_free_request() directly for NVMeOF passthru. This is to
mainly avoid an extra function call in the completion path
nvmet_passthru_req_done().

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/nvme/target/passthru.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index aecabf423df2..68701754b036 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -165,7 +165,7 @@ static void nvmet_passthru_execute_cmd_work(struct work_struct *w)
 
 	req->cqe->result = nvme_req(rq)->result;
 	nvmet_req_complete(req, status);
-	blk_put_request(rq);
+	blk_mq_free_request(rq);
 }
 
 static void nvmet_passthru_req_done(struct request *rq,
@@ -175,7 +175,7 @@ static void nvmet_passthru_req_done(struct request *rq,
 
 	req->cqe->result = nvme_req(rq)->result;
 	nvmet_req_complete(req, nvme_req(rq)->status);
-	blk_put_request(rq);
+	blk_mq_free_request(rq);
 }
 
 static int nvmet_passthru_map_sg(struct nvmet_req *req, struct request *rq)
@@ -274,7 +274,7 @@ static void nvmet_passthru_execute_cmd(struct nvmet_req *req)
 	return;
 
 out_put_req:
-	blk_put_request(rq);
+	blk_mq_free_request(rq);
 out_put_ns:
 	if (ns)
 		nvme_put_ns(ns);
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

Return-Path: <SRS0=L2sc=BU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A427C433E0
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2020 18:55:40 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDAEF20774
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2020 18:55:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dJa1hQGy";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="FhsZUqKK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDAEF20774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=53fDnkrIxQNNvZHsgzOR4m3b2Oy7tudq9FCNx+2hh6g=; b=dJa1hQGy/6J+o6YwHaLCzzrPS
	0CNrdadCJi4PLo6FikSgXD7hew/UoufuRfd9dI6cWVX7JnIYXAMr7Z0nCpgVaQfaCJhR0j8eCAtF2
	3KSd4b+SaBGvwUOOIItN7llGoCLROvTTwyXdNOcwWPkfxCVJcOIGTFuPX11xNXNen1nc9lmPLsWhD
	c6c+1jfm7ABE7lyQUDeLQNHkWQF/L/pPEfXYrNOGZVT0ZVdIGIuajS0DAQ5NxoU7bdjMWtyxb+Y75
	bNo2TG7aNyR6W7A0tIJogZz7vjBzJWAsVgoeG7GblLbyDFjJ/MHwj5gqtsrh1gffw5OK4PAMs7CvM
	GgBpNDwCw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k5CxO-00072I-4N; Mon, 10 Aug 2020 18:55:38 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k5CxL-00071C-Rr
 for linux-nvme@lists.infradead.org; Mon, 10 Aug 2020 18:55:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1597085735; x=1628621735;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=pGBw4DdOG+acQghw3WuPZryyTqHOk/ngpvJ/F8i1uoc=;
 b=FhsZUqKKHgBrFaCp8EW8mgPyXrLau4jXyeYRrxvJV8MRqwus9q2+ynZK
 +RlFOecxmszJ90NtcCZvyEMwamSNVd8NX+IPeFdNPr3Ia/D0gGS48gGom
 Yd69lOIJ7BvkiZsrColHpx83WZrAx7uyNOj/lvoKsKojXa9r/bh9OjQq4
 GKGCfy66l+ycjQWo6EIXsLwf5EZt724gR3YyCiIemBhxR8bFQb1mvJ5mw
 l0Fs+KhKx7mksxdUO+6KSIFt5wLHPxNGc0e4pXeHDpnhzCCwl34tmoijR
 vAjB7ig0IuHDHqXYS8hcF+CwrgrT1X2WHVHy0cYstA6gVoVDcieNXdTbF Q==;
IronPort-SDR: OsDVULnRsoagyFF3VKHdQNKFUXqPcXLBmgTGcTbGyJM6EVkZDAcK5tdrSVGvq+0wY5/V4xNMW3
 Z2vZ5OJwLJP4tObOuF8SmZbMjkbBIr2zgQoCa0xctYR8z5qW7nEGCZWQLjHqvv9zOrDWJ5dmNn
 8zDxQb+bS6cnh1llAgBKH1rSZIroLv0i2LSnIqT8s47FOOBNnsgD6+1NFGcwGZToxBlx5ZPMr2
 gGskBYzZhZSBPXLwzL/6lmuyUQGvasSdnuWXyHiCpvGPL6fAqtwtIpGPEaUZlbh1o8UXxcZZeM
 1II=
X-IronPort-AV: E=Sophos;i="5.75,458,1589212800"; d="scan'208";a="253987863"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 11 Aug 2020 02:55:34 +0800
IronPort-SDR: GU4hjeCZkeNXF0IUQm0buQffT6woHx4GUCEYuKBr+mG+ijYF7zCYdRlkyVF9cAgBGLCxkaVm2w
 vRWDp3jctJiQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Aug 2020 11:42:45 -0700
IronPort-SDR: /okdsmV2crbwBkZd7gkGaW7j+q3olye8VTmQ+dpphoxfQN41bAPnjAvd1tpo8byQFSLqXmP3Xl
 0+K6KyN4XK5g==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 10 Aug 2020 11:55:35 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 04/14] nvmet: use consistent type for op_flag
Date: Mon, 10 Aug 2020 11:54:46 -0700
Message-Id: <20200810185456.7713-5-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20200810185456.7713-1-chaitanya.kulkarni@wdc.com>
References: <20200810185456.7713-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200810_145536_082468_0BF0B3D3 
X-CRM114-Status: GOOD (  14.21  )
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

In function nvmet_passthru_map_sg() we set the bio->bi_opf ored with
req_op and op_flags set based on the NVMe cmd. The variable bio->bi_opf
is declared as unsigned int use same type for op_flag.

Also, adjust the indentation according to new length.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/passthru.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index 13d73f36e927..58377420874f 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -180,9 +180,9 @@ static void nvmet_passthru_req_done(struct request *rq,
 
 static int nvmet_passthru_map_sg(struct nvmet_req *req, struct request *rq)
 {
+	unsigned int op_flags = 0;
 	int sg_cnt = req->sg_cnt;
 	struct scatterlist *sg;
-	int op_flags = 0;
 	struct bio *bio;
 	int i, ret;
 
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

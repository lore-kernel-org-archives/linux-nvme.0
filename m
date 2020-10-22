Return-Path: <SRS0=3deH=D5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82D5DC2D0A3
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Oct 2020 01:03:10 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE0BD223FB
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Oct 2020 01:03:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="yiz+PpR6";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="FOcXEKAi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE0BD223FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=vzYuIjfm4/JLdU6joQnYdreXUWMTcTq4EoqLCljhbeA=; b=yiz+PpR6RVL7gy67Q2WtJGbpN
	/BTT42P7BIOLMYUQ+rmQkV06FpeUdsjeL3tbEKiSdHO8BZaBOVpaHeb7PU/zptnGTTkU3fwinZgUk
	eG/vnDeJJMGrJUAd/bDUhskFgUXOxZuQx4q2U6du3kfut3izWw5qT/ta560wYVH8ZEEHc2adi8xGM
	eM562/ttz/Qqg+XI7RpGX6/idqa9kNLVS9nznLu/OmpsmkhTlcQ8tcg94c2Xt6GENCApDQTox3Kpi
	7EaRAjJIY0FgF4IsxTRzcbp9uVAogD5zi5ql8wH34+acplLVSjiJsLVPV+ExRzdqbMcBireG4zfno
	A4fc9wk1g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kVP0V-00047V-Dw; Thu, 22 Oct 2020 01:03:07 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kVP0S-00046m-Ls
 for linux-nvme@lists.infradead.org; Thu, 22 Oct 2020 01:03:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1603328584; x=1634864584;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=6NOKkrJ+dd5+a5TidOKmE++eASzCFtwy/mCMZlmbUoE=;
 b=FOcXEKAiY9v1S+da3S+HBcth2/D5IyrkyMJRy/OT4s/G7B81L7+GRlWF
 GT0SWDw6IvaYufW9mHnml1oM9c2y7XfCAk1/xFvDMy18NJ/7a+p1RGL5k
 uyA9tpWFa9JwUjprjAFZpEhMIb4Ruszi+bmYHYY/WBo/WmGevKrjAl1rl
 9KzxBVCC5LkozPpx3/Tz/gTA11FIXAH/NLqhReQmf5gcksjP3stf3774d
 ToykfnwyLfgk/+8YmBTLm9+VnlC5LKpCfTnWZIwHOyC98UBgUpp6JF6ag
 ghyWenc+sxDKQ+bIn1Gqxn7wBLvaVyinMPUrIuqbbA3AqMfGJ6ejBWHOH Q==;
IronPort-SDR: YU9X/DeBkMhQb5CZyVki5Snn3txgi6NajMdE83nlP0I9Afn7qC/+psYpWbDlWj8DZhBPrKy/6W
 X2knGhDu1Eq1Umw2kJNJEP/qf3WhE4RKoZs6hMSYHKcfh+sU0xzIowrOo2S0p+8cAEzaVL4l2L
 9Ji5b3jdgZhxGypqUDjtjiOC+Trs6kJnOYQNIy5cX8m40ldMp5AbySWtmwUcM58R7gyux9qE6k
 feq9zqOhFDxYDCchClK3wQzDSAwRr4yFbKPEh/6UcREfBv+HL3ytsLVO7xrXj632PrXoAwMpvH
 DUM=
X-IronPort-AV: E=Sophos;i="5.77,402,1596470400"; d="scan'208";a="150488765"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 22 Oct 2020 09:03:03 +0800
IronPort-SDR: DWwyS7cpOCW6v84J4YzN43G+DkytMRyuQnS2s1FJyd5ywMD3vDxHWneNa9s9tOXy4xSDNrGROj
 4s9yJEqoP2gmOcnc5NOmo/DMYjOH5lS7qVVz+37PumCAqmmxKZSXg5jHZ9aD25cb+aneU/yJE4
 KLrM0shqsq6pSszenvpTv/6k56LJJcUsWsuk/NIso+8L4kn+mOxT5iujcKda/0Gppr2Kg6mXER
 cN2xwB7dmmvGf+lA6AwXYeSdPLrlzkJlsBOGWMYkj3kJ/5xHD6TegxIpzZq0S2ab7xD2y0qvAE
 yzCBDlySBAh+lORZphqZR4Sa
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2020 17:49:27 -0700
IronPort-SDR: trAgIIh25ehnatCW/4qXNGzjgAUmq7TkPPX5YoqIxeABlzFSK8Lurn3uEl9xrpoWUeXJtzmRL6
 rkK2N9Nb4hr3tsmhLsLjLKqxlJ3houHQXF98mlFOffbun2PiB01b+jGIPKp+8sBlJvA/hGw7sE
 ppy28nYBsLIjIKDSMqC94PetTxQaroySA6TYun954j+dwZCnqJsdlHwxMW/oRCyWntAY6cmrKi
 7kmAh8KOe4u0CBO4DyDfSalCewJZ7WabArjn8PipsQaTD4C4yfjsknqH2iF7p+wKaILeabmXAj
 MZc=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 21 Oct 2020 18:03:03 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH V3 3/6] nvmet: remove op_flags for passthru commands
Date: Wed, 21 Oct 2020 18:02:31 -0700
Message-Id: <20201022010234.8304-4-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201022010234.8304-1-chaitanya.kulkarni@wdc.com>
References: <20201022010234.8304-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201021_210304_849949_AE6C18CA 
X-CRM114-Status: GOOD (  13.28  )
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

For passthru commands setting op_flags has no meaning. Remove the code
that sets the op flags in nvmet_passthru_map_sg().

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/passthru.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index 76affbc3bd9a..e5b5657bcce2 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -182,18 +182,12 @@ static int nvmet_passthru_map_sg(struct nvmet_req *req, struct request *rq)
 {
 	int sg_cnt = req->sg_cnt;
 	struct scatterlist *sg;
-	int op_flags = 0;
 	struct bio *bio;
 	int i, ret;
 
-	if (req->cmd->common.opcode == nvme_cmd_flush)
-		op_flags = REQ_FUA;
-	else if (nvme_is_write(req->cmd))
-		op_flags = REQ_SYNC | REQ_IDLE;
-
 	bio = bio_alloc(GFP_KERNEL, min(sg_cnt, BIO_MAX_PAGES));
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

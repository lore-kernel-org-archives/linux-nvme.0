Return-Path: <SRS0=15Zf=IO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BA95C433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Mar 2021 17:08:59 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 247866511E
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Mar 2021 17:08:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 247866511E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=bwPeUGbW4Y6d1eLwjpRbderoB5MCvW/NUNQK0gPM9n0=; b=kRVy17B5IwMUmoeK2F+mJwt0VV
	uD+qCGAWHDZULLmp7yXKgMe1K9HpQ84B1KnrBTFDQRDMchjgURzV20vt2mCPJX5XIh48iG/MeU7tK
	m0HojqAYKBWcYwp0aRpVtBva5C/W25E8IbwrJVqDb/8F5xENQcNN+HRjcR7UjPHG2ca6bfpRFIlc+
	++8WXuwaIxGh5TN1jFLcKBGIIbrrS4u1yGCxtm75ereMDk56W4/v1ZxYYP2IrZn5g9M7oId4rcHkU
	5T8GecZgLzhwtpSMhAlWIF0QZV5M67tUWPEJ1N4GlLE2gdQsXbzMJuBStMvB4z/KSwbfSjs+Hxhqe
	7HPo/uWg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lMDBV-001MEq-G7; Tue, 16 Mar 2021 17:08:45 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lMD9S-001LBx-Gv
 for linux-nvme@lists.infradead.org; Tue, 16 Mar 2021 17:06:45 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 555B96510F;
 Tue, 16 Mar 2021 17:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1615914394;
 bh=A+82x4kZC1deXVVj/Cs6+2RJ13fDjJ/DopvtUpyI2oM=;
 h=From:To:Cc:Subject:Date:From;
 b=sg2iRxUfXPs3XYILfi4T5H14pzfPOSBjvr17mC/+dma668Df6ICt96xvCkrRbeSlE
 9Zeo6mWZtrc8RV+H/r5W1zJaKe3KE/olNViSCrS2CCWhn0Xgc3PfQINmECNVJqvIfC
 t0zwf2DTkGXC4mQCs1xhATK9cLh49ZpCQRRzMLi117Xngt28rrOYHpskr/T5BCZ7WV
 CKhknzN6iYZgPEt6ApnqbdXM6FDFvNgLZ+z4l/02UFNfTRU6UQyyp2132I52/YuYAJ
 AVhGQYVUTshDTikPjdotxmleXOpM51d6uhZ0Ksr/T0D4xN8GZd3dBToGio+Xf00pZ+
 omEoiIidokB4w==
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
 Kanchan Joshi <joshi.k@samsung.com>
Cc: Keith Busch <kbusch@kernel.org>
Subject: [PATCH 1/2] nvme-pci: allocate nvme_command within driver pdu
Date: Tue, 16 Mar 2021 10:06:31 -0700
Message-Id: <20210316170632.4161183-1-kbusch@kernel.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210316_170638_838773_F063A261 
X-CRM114-Status: GOOD (  10.25  )
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

All the nvme transport drivers had allocated the nvme command within the
driver's pdu except for pci. Align pci with everyone else and replace
the stack variable with the pdu command.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/pci.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index ecd11b1febf8..1a0912146c74 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -224,6 +224,7 @@ struct nvme_queue {
  */
 struct nvme_iod {
 	struct nvme_request req;
+	struct nvme_command cmd;
 	struct nvme_queue *nvmeq;
 	bool use_sgl;
 	int aborted;
@@ -917,7 +918,7 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 	struct nvme_dev *dev = nvmeq->dev;
 	struct request *req = bd->rq;
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
-	struct nvme_command cmnd;
+	struct nvme_command *cmnd = &iod->cmd;
 	blk_status_t ret;
 
 	iod->aborted = 0;
@@ -931,24 +932,24 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 	if (unlikely(!test_bit(NVMEQ_ENABLED, &nvmeq->flags)))
 		return BLK_STS_IOERR;
 
-	ret = nvme_setup_cmd(ns, req, &cmnd);
+	ret = nvme_setup_cmd(ns, req, cmnd);
 	if (ret)
 		return ret;
 
 	if (blk_rq_nr_phys_segments(req)) {
-		ret = nvme_map_data(dev, req, &cmnd);
+		ret = nvme_map_data(dev, req, cmnd);
 		if (ret)
 			goto out_free_cmd;
 	}
 
 	if (blk_integrity_rq(req)) {
-		ret = nvme_map_metadata(dev, req, &cmnd);
+		ret = nvme_map_metadata(dev, req, cmnd);
 		if (ret)
 			goto out_unmap_data;
 	}
 
 	blk_mq_start_request(req);
-	nvme_submit_cmd(nvmeq, &cmnd, bd->last);
+	nvme_submit_cmd(nvmeq, cmnd, bd->last);
 	return BLK_STS_OK;
 out_unmap_data:
 	nvme_unmap_data(dev, req);
-- 
2.25.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

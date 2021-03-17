Return-Path: <SRS0=uaVC=IP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4959C433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Mar 2021 20:51:11 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4664A64E90
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Mar 2021 20:51:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4664A64E90
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=KrQnK0m3z3IhwtWjA5z2BdRprfQponC2uZacADJUS7I=; b=n4XdeUIwpbW1EOQ4RWHTjczfE
	047WVzuu5mOmbp70Ueugk1ywS/ePSa1Z2wd0Tli96up8qhILhV9lktG0JUIOmCGJkkvDHgW2FTR+h
	MIhvL1e17MLyVv0QGgY9ggDygBAe5utPgmK+uI52PZ32Km02E6cctf0jCCGUPfh8OIuInCRWcXA9z
	9DA7PaR+PT4t0aesvS8U8l6mOE2B5s2J78klTsxIDlHtXNYuCcK1HMac5ADp9HgAw6nwzy35eLrCm
	CWrfu3mogLMKZGJQyi24l7P9gTLYfAsH3lwAGDr8GQE+PLMJSO2nqrq9N60l+tlt7JY+/az6Ey+5y
	oJULJKsSQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lMd7R-003srJ-TG; Wed, 17 Mar 2021 20:50:20 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lMcui-003sFk-6y
 for linux-nvme@lists.infradead.org; Wed, 17 Mar 2021 20:37:22 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6F66F64F3B;
 Wed, 17 Mar 2021 20:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1616013426;
 bh=D0qdeBCigZMZQpHgwVM1WhVQtb1+NzJ4bnl4iyeFrS4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=GscJEEm2DCg4t5uJbOj7zvflXB4H4iEWPlaj0Tb+1GekoosWHEv6dWLKTVAZ7Q1hi
 BKdlfrw9q65WKeNelA31cIjsOKL7Luv4nxXhNP7C4YVPjPhLLOuDz+knuJHwQWSBFu
 l+T8XF7p7QeC6brLgsw6CeU0nVAaw9BRCHFcxmJ/qsopvYHu15CTvkeO6KMvhvm1if
 RQ/9cLy/vRefqY3xyMx+WHsd9c3LQnTOgV2B/bMZhXVQdMX9ICy1DhaOapJwUZI/Ri
 rj3c6Sr/QwdmWJeJve0w1Af3cWPOyIe0W6AC1dE6Am0+cOLPffeQIF7j/0Rk+8/SI3
 ev3fJoMuUudrQ==
From: Keith Busch <kbusch@kernel.org>
To: joshi.k@samsung.com, hch@lst.de, sagi@grimberg.me,
 linux-nvme@lists.infradead.org
Cc: Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2 1/2] nvme-pci: allocate nvme_command within driver pdu
Date: Wed, 17 Mar 2021 13:37:02 -0700
Message-Id: <20210317203703.17391-2-kbusch@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210317203703.17391-1-kbusch@kernel.org>
References: <20210317203703.17391-1-kbusch@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210317_203720_578968_D6EF980E 
X-CRM114-Status: GOOD (  11.88  )
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

Except for pci, all the nvme transport drivers allocate a command within
the driver's pdu. Align pci with everyone else by allocating the nvme
command within pci's pdu and replace the .queue_rq() stack variable with
this.

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Christoph Hellwig <hch@lst.de>
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

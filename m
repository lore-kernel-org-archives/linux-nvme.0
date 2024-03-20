Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 412EFC54E58
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Mar 2024 11:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=kME1Ajn+X78iUrEXOAZxLCnlJuObW4wno7FTTSviGrY=; b=mGqCpWDxz4laxUje4L427AtniJ
	O7ACMI0X1j78qC+AK7DvxR/k7o6G7Mg3unArpfShlxv3knV9yIq0oKKgn0mGnere1HNoLAgR8Wvh3
	ykQ8IlDsURRKsbZlBxBNiFjgVHAPb7royGRqBADvRKels15gFkhjOJVjQ5jmogkbFH/jP8NwJ3/yt
	fU5Oes2qEYIq8kbHjW+FFjgSc1BglR8kad+zX9qpKsOa/TvJb+34BiP8tzMVbTTGDJS97Qs+9zCvJ
	2d7fg+iOGluHiGGwzrXt1fNhDMWy4Lgfjiv1x++474OIOIqCNxUkHqiADIXZkGK8txWmmxbik2MkV
	aD3gApOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmtoB-0000000GtMN-3wzh;
	Wed, 20 Mar 2024 11:08:35 +0000
Received: from out30-100.freemail.mail.aliyun.com ([115.124.30.100])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmto7-0000000GtKd-3wb3
	for linux-nvme@lists.infradead.org;
	Wed, 20 Mar 2024 11:08:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1710932907; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=kME1Ajn+X78iUrEXOAZxLCnlJuObW4wno7FTTSviGrY=;
	b=SY+zVGt01ed040GyUOwHVpZve7TcVXo3IMIQHK0RRURAHntrYSvIqxCc6krSaQyp9+lAzUGCLNfsbfEAbzksS6r9azUQbgDvZpaqDLiiEcT9erQPVVfc/xKNxDHmbJMRh1mWK+AniF0i5PzsMw/QlW0eb8oz/ZFiOc0WySVJ+8w=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0W2xB0U3_1710932902;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0W2xB0U3_1710932902)
          by smtp.aliyun-inc.com;
          Wed, 20 Mar 2024 19:08:26 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH v2] nvmet-rdma: remove NVMET_RDMA_REQ_INVALIDATE_RKEY flag
Date: Wed, 20 Mar 2024 19:08:21 +0800
Message-ID: <20240320110821.60775-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240320_040832_482468_5C120331 
X-CRM114-Status: GOOD (  11.29  )
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

We can simply use invalidate_rkey to check instead of adding a flag.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
Changes from v1 to v2:
- Clear invalidate_rkey to 0 after nvmet_rdma_get_rsp().

 drivers/nvme/target/rdma.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index f2bb9d95ecf4..5b8c63e74639 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -53,7 +53,6 @@ struct nvmet_rdma_cmd {
 
 enum {
 	NVMET_RDMA_REQ_INLINE_DATA	= (1 << 0),
-	NVMET_RDMA_REQ_INVALIDATE_RKEY	= (1 << 1),
 };
 
 struct nvmet_rdma_rsp {
@@ -722,7 +721,7 @@ static void nvmet_rdma_queue_response(struct nvmet_req *req)
 	struct rdma_cm_id *cm_id = rsp->queue->cm_id;
 	struct ib_send_wr *first_wr;
 
-	if (rsp->flags & NVMET_RDMA_REQ_INVALIDATE_RKEY) {
+	if (rsp->invalidate_rkey) {
 		rsp->send_wr.opcode = IB_WR_SEND_WITH_INV;
 		rsp->send_wr.ex.invalidate_rkey = rsp->invalidate_rkey;
 	} else {
@@ -905,10 +904,8 @@ static u16 nvmet_rdma_map_sgl_keyed(struct nvmet_rdma_rsp *rsp,
 		goto error_out;
 	rsp->n_rdma += ret;
 
-	if (invalidate) {
+	if (invalidate)
 		rsp->invalidate_rkey = key;
-		rsp->flags |= NVMET_RDMA_REQ_INVALIDATE_RKEY;
-	}
 
 	return 0;
 
@@ -1047,6 +1044,7 @@ static void nvmet_rdma_recv_done(struct ib_cq *cq, struct ib_wc *wc)
 	rsp->req.cmd = cmd->nvme_cmd;
 	rsp->req.port = queue->port;
 	rsp->n_rdma = 0;
+	rsp->invalidate_rkey = 0;
 
 	if (unlikely(queue->state != NVMET_RDMA_Q_LIVE)) {
 		unsigned long flags;
-- 
2.43.0



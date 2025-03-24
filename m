Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EF78C36005
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Mar 2025 10:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oRBmhnvJkFCOgg0y4Pda0HTysswqTSBUiijflXLqIxo=; b=f6RUxVcK721cz6t23iqhnDiesu
	L+YV0vTpHBZKoDdulLc8i0GnlRTAgyuN0zcexSZRuuPsMLlO9jDod0MPyUY0BUnEJIN/k/nQVYUvI
	rfj05Fu/nxBxQwsZ1HD0YguzqwymVOiaDiIZzCaWXvl5WwffI1agJcXvIbWf83NHukEvPoPBYV0qs
	l8r8yPQ9IT49KVd/3bUAhj+cSqgsMzz2Lc8G5wT0kKraDv7H4fzfH60Lt0HWqe9ZCnQ3m1AWGOV/b
	Ob3YPrc5FzwN2iVkcmbWgk5TXB1pQDU/b4s5cghCaQhSRAti2zWEKhbzMXv1+lOc2FqYrIU+4Fvpv
	FUEI4Mvg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tweyx-00000002oQQ-2jOR;
	Mon, 24 Mar 2025 10:24:35 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tweyB-00000002oFJ-3BPH
	for linux-nvme@lists.infradead.org;
	Mon, 24 Mar 2025 10:23:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742811826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oRBmhnvJkFCOgg0y4Pda0HTysswqTSBUiijflXLqIxo=;
	b=EWnTMQkUnVi8OaVx0rVk/UZw1Wwy3RXvXHI1AAaxGaWI5NFlLkJRRqJTJp4TZ+++LRpeLK
	lod8CN/J+SZ5uLuOQJzzviP6VRcuxt4v/KJyI9FxKQhMLQICCIyQNIdEPcD9s5DkOGTmxQ
	kBDZjPdT8f1JilEB4rUKr5PDRsFhRlI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-619-dXoP8_XGNaK0qHyQ0xhgLA-1; Mon,
 24 Mar 2025 06:23:42 -0400
X-MC-Unique: dXoP8_XGNaK0qHyQ0xhgLA-1
X-Mimecast-MFC-AGG-ID: dXoP8_XGNaK0qHyQ0xhgLA_1742811821
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A1F8719560AA;
	Mon, 24 Mar 2025 10:23:41 +0000 (UTC)
Received: from rocky.redhat.com (unknown [10.47.238.77])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 062E0180A803;
	Mon, 24 Mar 2025 10:23:38 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: sagi@grimberg.me
Cc: kbusch@kernel.org,
	linux-nvme@lists.infradead.org,
	jmeneghi@redhat.com,
	hare@suse.de,
	cleech@redhat.com
Subject: [PATCH RFC v3 07/11] nvmet: put all nvmet_req.execute calls behind a function name
Date: Mon, 24 Mar 2025 11:23:06 +0100
Message-ID: <20250324102310.658007-8-mlombard@redhat.com>
In-Reply-To: <20250324102310.658007-1-mlombard@redhat.com>
References: <20250324102310.658007-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: I6lp9vNvVeH3xiKurERovCu0IhW1DyJl5Nyu1-rFuyU_1742811821
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250324_032347_871232_03ADFA2D 
X-CRM114-Status: GOOD (  14.31  )
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

From: Chris Leech <cleech@redhat.com>

This is setup for being able to manipluate the outstanding requests.

Signed-off-by: Chris Leech <cleech@redhat.com>
---
 drivers/nvme/target/fc.c    | 4 ++--
 drivers/nvme/target/loop.c  | 2 +-
 drivers/nvme/target/nvmet.h | 1 +
 drivers/nvme/target/rdma.c  | 4 ++--
 drivers/nvme/target/tcp.c   | 4 ++--
 5 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 7318b736d414..f86b628b1efe 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -2378,7 +2378,7 @@ nvmet_fc_fod_op_done(struct nvmet_fc_fcp_iod *fod)
 		}
 
 		/* data transfer complete, resume with nvmet layer */
-		fod->req.execute(&fod->req);
+		nvmet_execute_request(&fod->req);
 		break;
 
 	case NVMET_FCOP_READDATA:
@@ -2589,7 +2589,7 @@ nvmet_fc_handle_fcp_rqst(struct nvmet_fc_tgtport *tgtport,
 	 * can invoke the nvmet_layer now. If read data, cmd completion will
 	 * push the data
 	 */
-	fod->req.execute(&fod->req);
+	nvmet_execute_request(&fod->req);
 	return;
 
 transport_error:
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index a5c41144667c..11d5f6dd9ece 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -125,7 +125,7 @@ static void nvme_loop_execute_work(struct work_struct *work)
 	struct nvme_loop_iod *iod =
 		container_of(work, struct nvme_loop_iod, work);
 
-	iod->req.execute(&iod->req);
+	nvmet_execute_request(&iod->req);
 }
 
 static blk_status_t nvme_loop_queue_rq(struct blk_mq_hw_ctx *hctx,
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 8778fbe82e74..7599dbb4347c 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -967,4 +967,5 @@ struct nvmet_feat_arbitration {
 	u8		ab;
 };
 
+static inline void nvmet_execute_request(struct nvmet_req *req) { req->execute(req); }
 #endif /* _NVMET_H */
diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 1afd93026f9b..f9ffb5feedb5 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -773,7 +773,7 @@ static void nvmet_rdma_read_data_done(struct ib_cq *cq, struct ib_wc *wc)
 	if (unlikely(status))
 		nvmet_req_complete(&rsp->req, status);
 	else
-		rsp->req.execute(&rsp->req);
+		nvmet_execute_request(&rsp->req);
 }
 
 static void nvmet_rdma_write_data_done(struct ib_cq *cq, struct ib_wc *wc)
@@ -958,7 +958,7 @@ static bool nvmet_rdma_execute_command(struct nvmet_rdma_rsp *rsp)
 				queue->cm_id->port_num, &rsp->read_cqe, NULL))
 			nvmet_req_complete(&rsp->req, NVME_SC_DATA_XFER_ERROR);
 	} else {
-		rsp->req.execute(&rsp->req);
+		nvmet_execute_request(&rsp->req);
 	}
 
 	return true;
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 9cf97433b0b6..96851e226bc4 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -597,7 +597,7 @@ static void nvmet_tcp_execute_request(struct nvmet_tcp_cmd *cmd)
 	if (unlikely(cmd->flags & NVMET_TCP_F_INIT_FAILED))
 		nvmet_tcp_queue_response(&cmd->req);
 	else
-		cmd->req.execute(&cmd->req);
+		nvmet_execute_request(&cmd->req);
 }
 
 static int nvmet_try_send_data_pdu(struct nvmet_tcp_cmd *cmd)
@@ -1104,7 +1104,7 @@ static int nvmet_tcp_done_recv_pdu(struct nvmet_tcp_queue *queue)
 		goto out;
 	}
 
-	queue->cmd->req.execute(&queue->cmd->req);
+	nvmet_execute_request(&queue->cmd->req);
 out:
 	nvmet_prepare_receive_pdu(queue);
 	return ret;
-- 
2.43.5



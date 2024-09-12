Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FDA3EE6451
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Sep 2024 06:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Bl2ECNPivqIZXFNVoGPXs5+iUsEKP/AgHeY34R0SsZw=; b=SPwyMiw+apxjw+0pT4m/wdljIy
	YRcAe90lzm7A3OPyCzJGFlmDqD/VKlao0NDgG70d98lHyuXIj11mqvwhe3Qwy8j2l7dDEXTH+qU/A
	RtCs0Csqj7li9Lo+GsqOtzO5edOBEy0cfbDAAHU/FmbxL4Zc2z76NnWg3GI8DHSEx1K+Ce+fpMhrc
	gy8J5P5tXs2XnGY5SOnYZ7RCUHp5xqIYW5WUqJWTQ5ig4fLODXQ31UmVm9J0xuaFcZYut0QCqA3B2
	Asp0KPGHHNHwK9Z+zFiDiVUh8l3Ok66wyGOFkBNsfZ+lHehotCD1IfLT5ZIq9F6aNlR62JXe4DyYq
	aR5XzvNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sodYm-0000000C3TL-3fMF;
	Thu, 12 Sep 2024 06:44:09 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sodYg-0000000C3Nw-1GjS
	for linux-nvme@bombadil.infradead.org;
	Thu, 12 Sep 2024 06:44:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:Content-Transfer-Encoding
	:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=Bl2ECNPivqIZXFNVoGPXs5+iUsEKP/AgHeY34R0SsZw=; b=X1FZ6BhhvOZYKpVBRFryi+6oCl
	KEauKbzzhowgY52pEP7xw/BA7cepMPWroJRmHRxP1MlLVjgF06cT+p/qAVuYoq4FCz0M8Vz3hs479
	O3ROtK/FgK2GlwJgmhel0MH9+9lO/e5YuRbYMhE7rYgrfM26Wh2gp6ViDpwxpxhGb3hn7P7lxwHRx
	X7F1R0D5EDz/hSaHhqf2z+9sAr19Q+/4JRoxwlD/lhnU/XCHg1PNQCRteVx0gQMrM9T5x7Dace1xg
	OqdcpkXoLoTmBGMK7qmfvOO03ml3+T7bUk2ceKU3nboVpQe1EK9F8VXB6fZqQ55pi/1avvAUK1pMC
	ACCGRWlg==;
Received: from mta-04.yadro.com ([89.207.88.248])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sodYb-00000000Nek-3KUg
	for linux-nvme@lists.infradead.org;
	Thu, 12 Sep 2024 06:44:00 +0000
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com D6A83C0004
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-04;
	t=1726123432; bh=Bl2ECNPivqIZXFNVoGPXs5+iUsEKP/AgHeY34R0SsZw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=NYzERTPV1mu2m5/PKb2XXi2ClWpJHGr7U1YRphevoJYfOUR10W4M8Yvf3cTyQAEZH
	 qHG7DgUz7lxJ9chhEkrn2gR+VcW0t72yY4UScZ60Nk+eDiyOCwPALlZT8xs6CceLex
	 RjO/JkQQUDLhn7f79lnD5qAKIt+DIE4GWexfFRS8gcfrQfGwN8nwLzcQUtKQZPizQD
	 bR2LB1dWQvOhXefmJiQqLmtZ4bpO6A/GOH1G+enRGuUjgsRlBPEgFH0Y1ZHl6HGPFp
	 i2mBjIzH0dU4qH9lOGXT9R7ys0t2k7pC4s5GYuum54vNKsmga2aZaRBdjqmLa29FMV
	 DENZdkofG63rQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-03;
	t=1726123432; bh=Bl2ECNPivqIZXFNVoGPXs5+iUsEKP/AgHeY34R0SsZw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=huJEwRIeERl2vW1ONii8pXQhQl1VoyMicRTn1dMwrbkvolsF20vgYJXeDb35ImkjT
	 3HxsztQHJi/l4ngDNp8z7CdLErkgttTfn25TbcSL9OC4CflwcxXU08by/FwjBcn39f
	 irRwSAYvU6qYePA2agDawnHgjuxpd0FPVS2Zyw8B8P3NPcNycDAMf+4kQGSK1VQ6PQ
	 sksN5IhJi84s4dOh/gPUTNPF5KV7sB27C+6l1YZ7SrN80CSHlVv7TYY40H5Qk8XYRA
	 f37EcVd4UBSjDBqDoLlishpdS4TlM6dvyQ6ML25ckeFnNz+JGjOVhCX2GvMLflQvkf
	 JNHCzZAxNX5Qw==
From: Dmitry Bogdanov <d.bogdanov@yadro.com>
To: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, James Smart <james.smart@broadcom.com>
CC: <linux-nvme@lists.infradead.org>, <linux@yadro.com>, Dmitry Bogdanov
	<d.bogdanov@yadro.com>
Subject: [PATCH 4/7] Revert "nvmet: Open code nvmet_req_execute()"
Date: Thu, 12 Sep 2024 09:42:56 +0300
Message-ID: <20240912064259.5228-5-d.bogdanov@yadro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240912064259.5228-1-d.bogdanov@yadro.com>
References: <20240912064259.5228-1-d.bogdanov@yadro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: T-Exch-05.corp.yadro.com (172.17.10.109) To
 T-EXCH-09.corp.yadro.com (172.17.11.59)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240912_074358_473431_1B5E063B 
X-CRM114-Status: GOOD (  11.83  )
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

This reverts commit be3f3114ddd58d12f64b872247bb1bc46df56b36.

Common nvmet_req_execute() is needed for fused commands support.

Signed-off-by: Dmitry Bogdanov <d.bogdanov@yadro.com>
---
 drivers/nvme/target/core.c  | 6 ++++++
 drivers/nvme/target/fc.c    | 4 ++--
 drivers/nvme/target/loop.c  | 2 +-
 drivers/nvme/target/nvmet.h | 1 +
 drivers/nvme/target/rdma.c  | 4 ++--
 drivers/nvme/target/tcp.c   | 4 ++--
 6 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index b3194d66f7dc..b7b2bf7b460c 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1098,6 +1098,12 @@ bool nvmet_check_data_len_lte(struct nvmet_req *req, size_t data_len)
 	return true;
 }
 
+void nvmet_req_execute(struct nvmet_req *req)
+{
+	req->execute(req);
+}
+EXPORT_SYMBOL_GPL(nvmet_req_execute);
+
 static unsigned int nvmet_data_transfer_len(struct nvmet_req *req)
 {
 	return req->transfer_len - req->metadata_len;
diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 3ef4beacde32..a77f0e05c174 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -2392,7 +2392,7 @@ nvmet_fc_fod_op_done(struct nvmet_fc_fcp_iod *fod)
 		}
 
 		/* data transfer complete, resume with nvmet layer */
-		fod->req.execute(&fod->req);
+		nvmet_req_execute(&fod->req);
 		break;
 
 	case NVMET_FCOP_READDATA:
@@ -2603,7 +2603,7 @@ nvmet_fc_handle_fcp_rqst(struct nvmet_fc_tgtport *tgtport,
 	 * can invoke the nvmet_layer now. If read data, cmd completion will
 	 * push the data
 	 */
-	fod->req.execute(&fod->req);
+	nvmet_req_execute(&fod->req);
 	return;
 
 transport_error:
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index e32790d8fc26..18c80ff6d7b1 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -125,7 +125,7 @@ static void nvme_loop_execute_work(struct work_struct *work)
 	struct nvme_loop_iod *iod =
 		container_of(work, struct nvme_loop_iod, work);
 
-	iod->req.execute(&iod->req);
+	nvmet_req_execute(&iod->req);
 }
 
 static blk_status_t nvme_loop_queue_rq(struct blk_mq_hw_ctx *hctx,
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 8a26b8b4dc63..41e4eec9a251 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -480,6 +480,7 @@ bool nvmet_req_init(struct nvmet_req *req, struct nvmet_cq *cq,
 void nvmet_req_uninit(struct nvmet_req *req);
 bool nvmet_check_transfer_len(struct nvmet_req *req, size_t len);
 bool nvmet_check_data_len_lte(struct nvmet_req *req, size_t data_len);
+void nvmet_req_execute(struct nvmet_req *req);
 void nvmet_req_complete(struct nvmet_req *req, u16 status);
 int nvmet_req_alloc_sgls(struct nvmet_req *req);
 void nvmet_req_free_sgls(struct nvmet_req *req);
diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 1b6264fa5803..69fd6d7063da 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -773,7 +773,7 @@ static void nvmet_rdma_read_data_done(struct ib_cq *cq, struct ib_wc *wc)
 	if (unlikely(status))
 		nvmet_req_complete(&rsp->req, status);
 	else
-		rsp->req.execute(&rsp->req);
+		nvmet_req_execute(&rsp->req);
 }
 
 static void nvmet_rdma_write_data_done(struct ib_cq *cq, struct ib_wc *wc)
@@ -958,7 +958,7 @@ static bool nvmet_rdma_execute_command(struct nvmet_rdma_rsp *rsp)
 				queue->cm_id->port_num, &rsp->read_cqe, NULL))
 			nvmet_req_complete(&rsp->req, NVME_SC_DATA_XFER_ERROR);
 	} else {
-		rsp->req.execute(&rsp->req);
+		nvmet_req_execute(&rsp->req);
 	}
 
 	return true;
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 5bff0d5464d1..ac6cd73b6e91 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -598,7 +598,7 @@ static void nvmet_tcp_execute_request(struct nvmet_tcp_cmd *cmd)
 	if (unlikely(cmd->flags & NVMET_TCP_F_INIT_FAILED))
 		nvmet_tcp_queue_response(&cmd->req);
 	else
-		cmd->req.execute(&cmd->req);
+		nvmet_req_execute(&cmd->req);
 }
 
 static int nvmet_try_send_data_pdu(struct nvmet_tcp_cmd *cmd)
@@ -1104,7 +1104,7 @@ static int nvmet_tcp_done_recv_pdu(struct nvmet_tcp_queue *queue)
 		goto out;
 	}
 
-	queue->cmd->req.execute(&queue->cmd->req);
+	nvmet_req_execute(&queue->cmd->req);
 out:
 	nvmet_prepare_receive_pdu(queue);
 	return ret;
-- 
2.25.1



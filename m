Return-Path: <SRS0=wn7D=EC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE3AFC2D0A3
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Oct 2020 00:14:38 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D3F020754
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Oct 2020 00:14:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="2mu3Lbk9";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="LNZ57PDg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D3F020754
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=C8GFH8D3CxOpH3REFYfcipxCxylmM5Xe8HBp3W3XLEM=; b=2mu3Lbk9YOX0FKCS8mzIIyiHQ
	41vR7Py8grBE56UAt1AR7YjmYeek93/8XAiXHNv3y2qLxv/NN3Y/plYXbBTAtzmqOd9jxZz/2iixV
	cmrFGJW5ZUspIjzqVgBhN5ia4voApZvwvriLSRPlmI4pnhm74pLdPvqOM2tcjKfFfWOO5X3ycS7SF
	iPycEkGEG0Y5v5hhDTZ/DDySXym/jOAgN1VjGK1GQ7X2bkJszxGgx/VUYWU1/y9rlTm25cKVgbFD2
	JE79DQi8thVC1tfExrDvoMNMn0KIH4mLAqZInVg0Qu1+7+ZgHBLrFvBBca3TNRYMSrPd9FWIcN2B2
	h0a0hFFLA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kXCdA-0003wu-RK; Tue, 27 Oct 2020 00:14:28 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kXCMB-00047o-QL
 for linux-nvme@lists.infradead.org; Mon, 26 Oct 2020 23:56:58 +0000
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id BE21120770;
 Mon, 26 Oct 2020 23:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1603756613;
 bh=cCVgGMe5hoIQ+QFz+qgGojy6g3g+wPwt63Y5/vZUW0Q=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=LNZ57PDg6tQ8tF+AM7jHI41/PE8CfMhXrflkKYIrdMkTA4H6I6KZ/Q4xvAnjqwH1X
 dK6wX6pbK7Kdl0Rm1/XOowwiYj8vkeXwSBWOGZVGdwYtnDWTISD19d6RyAb9PFh6e9
 hUfp5yWmDdXACr0aVLg0A/ocdJOLrM7aIVaBn8Q8=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 80/80] nvme-rdma: fix crash when connect rejected
Date: Mon, 26 Oct 2020 19:55:16 -0400
Message-Id: <20201026235516.1025100-80-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201026235516.1025100-1-sashal@kernel.org>
References: <20201026235516.1025100-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201026_195656_200122_332352B6 
X-CRM114-Status: GOOD (  15.89  )
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
Cc: Sasha Levin <sashal@kernel.org>, linux-nvme@lists.infradead.org,
 Sagi Grimberg <sagi@grimberg.me>, Chao Leng <lengchao@huawei.com>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Chao Leng <lengchao@huawei.com>

[ Upstream commit 43efdb8e870ee0f58633fd579aa5b5185bf5d39e ]

A crash can happened when a connect is rejected.   The host establishes
the connection after received ConnectReply, and then continues to send
the fabrics Connect command.  If the controller does not receive the
ReadyToUse capsule, host may receive a ConnectReject reply.

Call nvme_rdma_destroy_queue_ib after the host received the
RDMA_CM_EVENT_REJECTED event.  Then when the fabrics Connect command
times out, nvme_rdma_timeout calls nvme_rdma_complete_rq to fail the
request.  A crash happenes due to use after free in
nvme_rdma_complete_rq.

nvme_rdma_destroy_queue_ib is redundant when handling the
RDMA_CM_EVENT_REJECTED event as nvme_rdma_destroy_queue_ib is already
called in connection failure handler.

Signed-off-by: Chao Leng <lengchao@huawei.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/rdma.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index abe4fe496d05c..a41ee9feab8e7 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1679,7 +1679,6 @@ static int nvme_rdma_cm_handler(struct rdma_cm_id *cm_id,
 		complete(&queue->cm_done);
 		return 0;
 	case RDMA_CM_EVENT_REJECTED:
-		nvme_rdma_destroy_queue_ib(queue);
 		cm_error = nvme_rdma_conn_rejected(queue, ev);
 		break;
 	case RDMA_CM_EVENT_ROUTE_ERROR:
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

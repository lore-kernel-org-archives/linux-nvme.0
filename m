Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CE7DC3ABB2
	for <linux-nvme@archiver.kernel.org>; Wed, 28 May 2025 06:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hU0uVWkpUtdLwnSAZer8OXMnG0Zm6qnxxlkI1tliRNU=; b=rIQ+BgbYJtgFtxAqIEx27U9dNA
	nFu+MXRcBP0WQ+KZYk63MvQ3GclzbYn/u4cV0gokteLeoQrLxDAmtIcpVxzYstoJkLe+MfyhAYtkJ
	ssHcu01Owtb2X9VHpDRunXOqPw3In1HrSLsw6bE9ASm7IunGd8BkGICyWcMg8SqHZOiHA2BHe4wWK
	YB8xVnc4BcI00q6uqF4SEhyixfLNZiSyrPdSZZKZzxlN3UFH79YH8/CIxLtDhkdRa9tGstWCqerE0
	AH05svu187MiX8Ba+Jv/psa6IXBOjbda0lwpayKEg84DPAjzXo0QxfiFVz3uM1wy1uCniHn3dJsAW
	cYOeoP0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKAg7-0000000CMB7-3e72;
	Wed, 28 May 2025 06:54:19 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKAXv-0000000CL1W-48Tg
	for linux-nvme@lists.infradead.org;
	Wed, 28 May 2025 06:45:53 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 4BB174AA80;
	Wed, 28 May 2025 06:45:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B15DBC4CEEF;
	Wed, 28 May 2025 06:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748414751;
	bh=6DXVk/La468zFHIbx4IE/sL3lLcU6DlqEVe9kVQYJm4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rA1Z2vTOhVDM29J32eNM/YBfBRZdBC2AWbNI28Qvz9PacmAZ00bFiGvRMsC/6Onlz
	 IP4W62PYXd5Uwgj2jhQR/OE/w0JLIlOPV2DrhmwrsVo0v4lyLfcMSqBHj65ZATs0Ac
	 Pad/vk4nws/8NIa3dDW6zhJZWibpp33KzsT7LLVvIvPzmP7NqlqRrkjwjQ7jVGKTAw
	 RziMaQjTT5bDtylqni/4tI/bTKjj4Aa49BOheGRuptkVqo/XuVE2+DAO50JFBgJQqy
	 +Cac5M4ug6OUwp32NjuP1I2qywnmLsyOVczjJYByv9PVZKnYwVPQDZZ5ueqzRmcdYQ
	 LGI0o+7Aj1Pcg==
From: Hannes Reinecke <hare@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Kamaljit Singh <kamaljit.singh1@wdc.com>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 1/3] nvme-tcp: sanitize request list handling
Date: Wed, 28 May 2025 08:45:33 +0200
Message-Id: <20250528064535.135653-2-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250528064535.135653-1-hare@kernel.org>
References: <20250528064535.135653-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250527_234552_053001_00BB7024 
X-CRM114-Status: GOOD (  12.38  )
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

Validate the request in nvme_tcp_handle_r2t() to ensure it's not
part of any list, otherwise a malicious R2T PDU might inject a
loop in request list processing.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/host/tcp.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 853bc67d045c..69b89a3c09a1 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -452,7 +452,8 @@ nvme_tcp_fetch_request(struct nvme_tcp_queue *queue)
 			return NULL;
 	}
 
-	list_del(&req->entry);
+	list_del_init(&req->entry);
+	init_llist_node(&req->lentry);
 	return req;
 }
 
@@ -560,6 +561,8 @@ static int nvme_tcp_init_request(struct blk_mq_tag_set *set,
 	req->queue = queue;
 	nvme_req(rq)->ctrl = &ctrl->ctrl;
 	nvme_req(rq)->cmd = &pdu->cmd;
+	init_llist_node(&req->lentry);
+	INIT_LIST_HEAD(&req->entry);
 
 	return 0;
 }
@@ -764,6 +767,14 @@ static int nvme_tcp_handle_r2t(struct nvme_tcp_queue *queue,
 		return -EPROTO;
 	}
 
+	if (llist_on_list(&req->lentry) ||
+	    !list_empty(&req->entry)) {
+		dev_err(queue->ctrl->ctrl.device,
+			"req %d unexpected r2t while processing request\n",
+			rq->tag);
+		return -EPROTO;
+	}
+
 	req->pdu_len = 0;
 	req->h2cdata_left = r2t_length;
 	req->h2cdata_offset = r2t_offset;
@@ -2638,6 +2649,8 @@ static void nvme_tcp_submit_async_event(struct nvme_ctrl *arg)
 	ctrl->async_req.offset = 0;
 	ctrl->async_req.curr_bio = NULL;
 	ctrl->async_req.data_len = 0;
+	init_llist_node(&ctrl->async_req.lentry);
+	INIT_LIST_HEAD(&ctrl->async_req.entry);
 
 	nvme_tcp_queue_request(&ctrl->async_req, true);
 }
-- 
2.35.3



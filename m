Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17B28C25B10
	for <linux-nvme@archiver.kernel.org>; Fri, 10 May 2024 16:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4M4k32h+Yu8xy73EvoEkgAHVR5/50jfl4f9whUpaT2s=; b=YlwEqE/aGdIApmEg3uM954hntW
	CxXxNAUpafcN6wn+w7f8565x2rf0nZj061ZEMq8AdFf+5RmAMJ1N7UTcWGDC+7mOvDb2TO5UZsOe2
	fW/0NvCKpDQxmn3Fd4Yo4JcDfsj5ikRZ1F20d4Wp7o481jnIOcvdTJMqUM7Nw0zAzh/UC5k03rSKN
	J6ffwR2ZMefPzZUaeSpkOP3u+lAUyU5qioUH2i/8hWIdWYje3xbE1FLTVZ8LwsQ1xtnDXH+HY8yKJ
	JGeoNi6Qc+YnFDTVueS6xA/+2vw43GxV2vIrRLBx1BxKcJ3mTFcl5sUKHsLqHCtNz3LvDQvzfJJkN
	xUkeL6vw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5T8t-00000005s3O-3xsI;
	Fri, 10 May 2024 16:30:43 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5T8p-00000005s0z-0Kxq
	for linux-nvme@lists.infradead.org;
	Fri, 10 May 2024 16:30:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715358637;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4M4k32h+Yu8xy73EvoEkgAHVR5/50jfl4f9whUpaT2s=;
	b=KngeQd3mbr3eEsXm0TFe/DX672BFhjfOwoYiJM9Ra9K9LTf0LQne/0tO3XACKK3vwzyAXJ
	kPVSu9RVA1aTR8/17qAekhWpmVD1Os4EdNQPZxUewXH1/kMLFMup1LKdefAzZzPDxY6DAv
	7wJbdrafnGLFHBu8Fzf5lBuoofDFcgs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-497-cwHEVoiDMb2OIfBuU8t3Hw-1; Fri, 10 May 2024 12:30:34 -0400
X-MC-Unique: cwHEVoiDMb2OIfBuU8t3Hw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 71C82101A557;
	Fri, 10 May 2024 16:30:34 +0000 (UTC)
Received: from kalibr.redhat.com (unknown [10.42.28.72])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 54EC8200A380;
	Fri, 10 May 2024 16:30:33 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: kbusch@meta.com
Cc: hare@kernel.org,
	sagi@grimberg.me,
	emilne@redhat.com,
	jmeneghi@redhat.com,
	linux-nvme@lists.infradead.org
Subject: [PATCH 3/5] nvme-tcp: use the cancel command to perform an abort if target supports it
Date: Fri, 10 May 2024 18:30:24 +0200
Message-Id: <20240510163026.786898-4-mlombard@redhat.com>
In-Reply-To: <20240510163026.786898-1-mlombard@redhat.com>
References: <20240510163026.786898-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240510_093039_214461_874C20EF 
X-CRM114-Status: GOOD (  12.82  )
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

If available, use Cancel command to abort the command that timed
out instead of resetting the controller.

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
---
 drivers/nvme/host/tcp.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 28bc2f373cfa..d7922fa9aabe 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -121,6 +121,7 @@ struct nvme_tcp_request {
 	size_t			offset;
 	size_t			data_sent;
 	enum nvme_tcp_send_state state;
+	bool			aborted;
 };
 
 enum nvme_tcp_queue_flags {
@@ -2442,6 +2443,8 @@ static enum blk_eh_timer_return nvme_tcp_timeout(struct request *rq)
 	struct nvme_tcp_cmd_pdu *pdu = nvme_tcp_req_cmd_pdu(req);
 	struct nvme_command *cmd = &pdu->cmd;
 	int qid = nvme_tcp_queue_id(req->queue);
+	int error;
+	u32 effects;
 
 	dev_warn(ctrl->device,
 		 "I/O tag %d (%04x) type %d opcode %#x (%s) QID %d timeout\n",
@@ -2466,10 +2469,25 @@ static enum blk_eh_timer_return nvme_tcp_timeout(struct request *rq)
 		return BLK_EH_DONE;
 	}
 
+	if (!req->aborted) {
+		effects = le32_to_cpu(ctrl->effects->iocs[nvme_cmd_cancel]);
+
+		if (!(effects & NVME_CMD_EFFECTS_CSUPP))
+			goto err_recovery;
+
+		error = nvme_submit_cancel_req(ctrl, rq, qid);
+		if (error)
+			goto err_recovery;
+
+		req->aborted = true;
+		return BLK_EH_RESET_TIMER;
+	}
+
 	/*
 	 * LIVE state should trigger the normal error recovery which will
 	 * handle completing this request.
 	 */
+err_recovery:
 	nvme_tcp_error_recovery(ctrl);
 	return BLK_EH_RESET_TIMER;
 }
@@ -2514,6 +2532,7 @@ static blk_status_t nvme_tcp_setup_cmd_pdu(struct nvme_ns *ns,
 	req->pdu_len = 0;
 	req->pdu_sent = 0;
 	req->h2cdata_left = 0;
+	req->aborted = false;
 	req->data_len = blk_rq_nr_phys_segments(rq) ?
 				blk_rq_payload_bytes(rq) : 0;
 	req->curr_bio = rq->bio;
-- 
2.39.3



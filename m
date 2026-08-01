Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F118C54FCD
	for <linux-nvme@archiver.kernel.org>; Sat,  1 Aug 2026 08:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=f1eprebx+Ei9fy9zASKq2n4ZSux+Wxq0L1cBEFaU7cY=; b=Yf+rhhPNfRl4esmATghA0bm4Y/
	U4+25i8xWp4O7A6k615gK2w+bgR/lC+21apMDrpRAFFdh1Foavr0HE0ONXxsGsHMYU6vH7KaYjBNc
	ESZkMKG6RKb5/68vOl3trI3SYjd5PBpoCyscwYV4wddECIdTDbbFVcDEeNvj7xiNUj1u/NfFZx4aV
	OylLvZ07UhKBsUWOfsHQ1Bk5jdhtnNPsvF1lqDmmtPMGJLLQ2m3oS2t8UcSkFVcg5G4i3L9vXqDXx
	Roy2+uRAzPnSGCwyq1cO1iFVtFeZKRyFYAHR7Tz9rRKs19MqLns1Yb3zHTf42/L6y8AUpbYacQ7t0
	rvcWnBNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wq4vb-0000000E2lz-0cZt;
	Sat, 01 Aug 2026 08:18:43 +0000
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wq4vY-0000000E2kv-1j7t
	for linux-nvme@lists.infradead.org;
	Sat, 01 Aug 2026 08:18:42 +0000
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-84862b0d5aeso2269091b3a.2
        for <linux-nvme@lists.infradead.org>; Sat, 01 Aug 2026 01:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1785572319; x=1786177119; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f1eprebx+Ei9fy9zASKq2n4ZSux+Wxq0L1cBEFaU7cY=;
        b=pPslRQNtXFK10nYCTr3MMumRj8YmSqIgawROIb+ckl7cY2YrsPbqhauDqBdP2s/vg0
         XvQyXnHhSimOZbQlLOYPoijhuH4XM+6XvhwSoG7JXiyZwBFodIAxwjLBrYBgboeUCcgR
         SQfDG+xW+pt2Zd+baf1ZfQpGVIa+ANx22GwXKFl1sj+dR2irUx8EfaOMc2/JVoeTXBgA
         3FDIWLPaw86d68DeNJcZNNTKoYcyOJ35FEhco69vcZQUMOOSSb+yLpUPiY7J5I9xnsMu
         1W8KPi4dexk4qQyI5gM7BUjuEmT5+DLfaCQW4IWQ4eHH5snko9A8FigSQ1nj02ESY6f9
         aKpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785572319; x=1786177119;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=f1eprebx+Ei9fy9zASKq2n4ZSux+Wxq0L1cBEFaU7cY=;
        b=tRA2YksY9titKjUDWWj58OsDavD1nIF94NaFVa7DPo6ofZyQXdRmCuBYZJxgRuGEL0
         NDbhW9jWeJX53Cio5TGDq7wNb4FlrEbB/W5CMkUIAHk2KiuV37Pae5INRnUt8ye9bn+l
         RLZCH6RxCUbTd8Jmm/4lNQoyqv4pa18bNZLvk9nFvwP6riVnzFiRfnIUpVJqG6br2M2V
         DRLsbk54q5PoUgHNSFvqqNsFS3bHFHt1g4lBybfH3nncbvyEqEHHMvP0cN+j/2kCj5wb
         vZPVvxOA8DqehxR+bDoWShWL2aoBX0EFISIHJfxgfu2TOQdoSap5a9BEZu8r6q4jalBf
         LeXw==
X-Gm-Message-State: AOJu0Yxmq7pVfMWGsRAP7tQBZbWY/d15hweJtfz+VuqFKBC8owcuBjmg
	MJahh9toXsY+KAwk4nlZZntXCo+YO1pgZCcfldbdWGZJ+42dmd6aSBo7+47YGMkBGfXgbXH0Sfv
	kWwe4
X-Gm-Gg: AR+sD12SIwIIwo/nVRlu9Bo21maTq3xEi4y1kaF9BOpzc6NiHzjD21NMnyvFeMAC1NA
	Y58NUOtb4W1aYn3b2vfWd1fJxI3HdOx1j65kCT/pNG4ZJgj3NzOoDj2a8hTORNA57lkio/NGFTo
	ocJ+joK2DYBm3YTvEmTo+YiGzy78ScMhRyFBmbPQz1pow74cr6APVVHbcqlHiK2lFtWlJz8xMGB
	FjHsHaygjMU0yDIKzJdw6kbFbO3/Ej+3wUpuKC3mAw84SebLbnfZeRr2px/q96JlnZOG1WlRzeo
	qbo7Vnh187wuxaPooxw68x/FX+YDlsUa/Mi5MIaENVuAGHPSZPgMwupkad+TPjD7vn92ipOgEte
	SUyXMJglXv6E30uc2KG/ta32JIBe1Z0azxmzczdX2JYl8sqhRM9VpED6qy0f3UT76ZGK00g6TOR
	WBmdvwcJd7vUHTTGLitaoJZ+qFAHZqOnE9P7Pz1g8bBFhLJWzlPcUOfiyX08SNJ3KlEm4XP8bXI
	10faEAQlZI=
X-Received: by 2002:a05:6a00:9296:b0:847:82dc:452d with SMTP id d2e1a72fcca58-84ee47d8cf6mr2245492b3a.29.1785572319549;
        Sat, 01 Aug 2026 01:18:39 -0700 (PDT)
Received: from localhost.localdomain ([2406:5900:1044:110c:c329:7b28:fe02:5dc8])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbe39ea9a40sm1433003a12.25.2026.08.01.01.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 01:18:39 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	linux-kernel@vger.kernel.org,
	Yehyeong Lee <yhlee@isslab.korea.ac.kr>,
	stable@vger.kernel.org
Subject: [PATCH v3 1/2] nvme-tcp: reject a read that transferred too few bytes
Date: Sat,  1 Aug 2026 17:18:17 +0900
Message-ID: <20260801081818.1884199-2-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260801081818.1884199-1-yhlee@isslab.korea.ac.kr>
References: <20260801081818.1884199-1-yhlee@isslab.korea.ac.kr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260801_011841_267252_03538AF3 
X-CRM114-Status: GOOD (  19.71  )
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

nvme_tcp_recv_data() completes a request once the current C2HData PDU
has been consumed. Nothing compares the total bytes received against
the length the command asked for: struct nvme_tcp_request has no
receive-side counter, queue->data_remaining is per queue, and
blk_mq_end_request() completes for blk_rq_bytes(rq) unconditionally
with no residual concept anywhere above.

A controller can therefore answer a 4096-byte read with 512 bytes and
have it reported as a complete read; user space then gets 4096 bytes of
which 3584 are whatever was already in the page. I reproduced that with
a test target.

Count the bytes received and refuse to complete a successful read whose
count does not match, at the two NVME_TCP_F_DATA_SUCCESS paths and in
nvme_tcp_process_nvme_cqe(). The success test shifts req->status right
by one, because the driver keeps the wire value there and shifts it on
completion, so the check must see what the completion path will see.
Only REQ_OP_READ is checked, because there the length comes from the
sectors the request covers; a passthrough command is built by its
submitter, which picks both command and buffer, so the kernel has
nothing to compare against.

Fixes: 3f2304f8c6d6 ("nvme-tcp: add NVMe over TCP host driver")
Cc: stable@vger.kernel.org
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
v2 -> v3: the success test now uses req->status >> 1, the same expression
nvme_try_complete_req() uses, so a CQE phase tag cannot evade it.

 drivers/nvme/host/tcp.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index ba5c7b3e2a7c..c4fe06d424d1 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -80,6 +80,7 @@ struct nvme_tcp_request {
 
 	struct bio		*curr_bio;
 	struct iov_iter		iter;
+	u32			data_recvd;
 
 	/* send state */
 	size_t			offset;
@@ -612,6 +613,29 @@ static void nvme_tcp_error_recovery(struct nvme_ctrl *ctrl)
 	queue_work(nvme_reset_wq, &to_tcp_ctrl(ctrl)->err_work);
 }
 
+/*
+ * NVMe has no short read: a read that completes successfully must
+ * have transferred everything it asked for.
+ */
+static bool nvme_tcp_data_in_short(struct nvme_tcp_queue *queue,
+				   struct request *rq)
+{
+	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
+
+	if (le16_to_cpu(req->status) >> 1)
+		return false;
+	if (req_op(rq) != REQ_OP_READ || !req->data_len)
+		return false;
+	if (likely(req->data_recvd == req->data_len))
+		return false;
+
+	dev_err(queue->ctrl->ctrl.device,
+		"queue %d tag %#x short data-in: got %u of %u\n",
+		nvme_tcp_queue_id(queue), rq->tag,
+		req->data_recvd, req->data_len);
+	return true;
+}
+
 static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
 		struct nvme_completion *cqe)
 {
@@ -631,6 +655,9 @@ static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
 	if (req->status == cpu_to_le16(NVME_SC_SUCCESS))
 		req->status = cqe->status;
 
+	if (unlikely(nvme_tcp_data_in_short(queue, rq)))
+		return -EPROTO;
+
 	if (!nvme_try_complete_req(rq, req->status, cqe->result))
 		nvme_complete_rq(rq);
 	queue->nr_cqe++;
@@ -953,6 +980,7 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 		*len -= recv_len;
 		*offset += recv_len;
 		queue->data_remaining -= recv_len;
+		req->data_recvd += recv_len;
 	}
 
 	if (!queue->data_remaining) {
@@ -961,6 +989,8 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 			queue->ddgst_remaining = NVME_TCP_DIGEST_LENGTH;
 		} else {
 			if (pdu->hdr.flags & NVME_TCP_F_DATA_SUCCESS) {
+				if (unlikely(nvme_tcp_data_in_short(queue, rq)))
+					return -EPROTO;
 				nvme_tcp_end_request(rq,
 						le16_to_cpu(req->status));
 				queue->nr_cqe++;
@@ -1009,6 +1039,9 @@ static int nvme_tcp_recv_ddgst(struct nvme_tcp_queue *queue,
 					pdu->command_id);
 		struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
 
+		if (unlikely(nvme_tcp_data_in_short(queue, rq)))
+			return -EPROTO;
+
 		nvme_tcp_end_request(rq, le16_to_cpu(req->status));
 		queue->nr_cqe++;
 	}
@@ -2736,6 +2769,7 @@ static blk_status_t nvme_tcp_setup_cmd_pdu(struct nvme_ns *ns,
 	req->status = cpu_to_le16(NVME_SC_SUCCESS);
 	req->offset = 0;
 	req->data_sent = 0;
+	req->data_recvd = 0;
 	req->pdu_len = 0;
 	req->pdu_sent = 0;
 	req->h2cdata_left = 0;
-- 
2.43.0



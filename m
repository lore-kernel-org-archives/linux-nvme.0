Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FB1FC54F54
	for <linux-nvme@archiver.kernel.org>; Fri, 31 Jul 2026 14:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Nqg0dSHeP45xd/EokPloz+X9pwqjo4SAbZQxj3uAduY=; b=ePIn2cURiciy5K9UGnEyqWtXPV
	XM4xIUmQ2XZIkuHy7GpLYYCeJc6Of/niIHaP/mMMwq5eeG6xKc9UFE3C926395OqnKK3zOO07RNga
	rGg1t5M54MVW8DdqsMWYJzYVOtYvTMWAijYVd7Z5XJLZkz+FrWg8rkqGyvQdl2e482TdN2hWsr9vo
	V2gbQnCMSqtJ0rkbUdSVEmeXSYuSdHOO9J1hCSiDcMJL0yegWTsg8fazRgm0oHT1z7mada+sutLSl
	4vCNKvwqCYVrv0JOV69wmn53tRolQLo8Bchvt4JX0h5GzzL6IUXnf8RMrS5+/Cfk/BmC07Uc9ep1B
	cve5YYKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpoH9-0000000CiVW-2dWY;
	Fri, 31 Jul 2026 14:31:51 +0000
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpoH7-0000000CiUK-0Tin
	for linux-nvme@lists.infradead.org;
	Fri, 31 Jul 2026 14:31:50 +0000
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-2d004f135b1so10588475ad.3
        for <linux-nvme@lists.infradead.org>; Fri, 31 Jul 2026 07:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1785508308; x=1786113108; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Nqg0dSHeP45xd/EokPloz+X9pwqjo4SAbZQxj3uAduY=;
        b=SzJqdP5qgFgofYhjKxipND9XzhO/yJKTU0cBSymuDIMY6jr7VXJMzlp9IdELqIkPOX
         +qnmxyntH7QGAIst5qt6oS5kjtyzx8+iIstWPXKqyZuILYAyy4Jfh1+9Mn6d9YN+w1Ct
         ACIc5qO7KJyoEs6HJK5sHkEESHiColMMGNc8dmBqMtXKM3SzO2GFPZfutfmTK37vRbRO
         CcSGeSuPt0xHVNPHnyoKA3ag9Foen/v8lrOVZRt/ybplKP6kCWCe2Ze+7g1rA4SUB7DG
         coXtzu/FzrM4oEZetaJEd8DI6h0D40WKHUc9M4CnvALzWYCyf9DusI6FrCto5sT5elR7
         YwYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785508308; x=1786113108;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Nqg0dSHeP45xd/EokPloz+X9pwqjo4SAbZQxj3uAduY=;
        b=a90bBawu9Zum1OQbyeYfDmimoDsKVHAG8+9iGmlxHJhHRRucDPveTJCnVncoQ4rWSq
         eXHZ1uUijALqNkXiaz+cBSs2q1OtU4Bpy+TOWDA8uq2f3BXIPngRZA4B5fx2G5KO9OhJ
         uPiupIEqx9PRRQRj16kI7RhWaqsN1cyn8H2WyRiDblhuZLBPH+OIirH4D10EuP60+b42
         P2vqRObKV+Tj3tL1f1JK2oYyoVvC7dgF1W9n0nJ1aE8C4sjZ4mXkAtXCk6y//5m4bc0k
         Rtat4muUP2o+/Hj7nXocSSxAeFhOv2UuuX92z6Vq6Nw8zXnbkS8awbEDu7ccDVUpgHsJ
         zgoA==
X-Gm-Message-State: AOJu0Yxx7zTtWwIfaKuDm7D29yIA2fhrfBXKUci1IhK/SOFB5qYUjSIt
	1HRHvPoZOra22QmBERsGTy3y3fEcal53RIbbX9Qn7wLt7UVxaUDsg0JyaEXKgMbXpgGG32/s6KS
	B/leiTBrCUQ==
X-Gm-Gg: AR+sD13+k1F0co2I5OLXcKQH9LHH38nUN25ERxzRlGTcWO9pTitJLiTnRWT0EsYq838
	i77XwYCMcCEvn5wXeQzopUp2MIrFcDQmjBnf9YoZsdcew8GejSDeHU5wNWQDXThSFXcmyf2qBxd
	LXrXimPtwASc80R/ZDpTvzrNZpyIPvxzZl0yzcvSaAoxZ/pIKHP+qu3pBZ2SBzk2sAWqlLogeDw
	+cgg+6dmH7SohHuOH82SSJ1CgkShwWPaEbju++GZkNEDtk09REdQE/XJZjlD+nGEHfyPZ7Rss2P
	43ait41qva5MwFT3mI5msrxsbgA9nfHC3qRDv6WsP7aDeizQiJM7WI+biQ7prcIc9BOR7RUr1Mh
	f839JvKKa141pDFoM6wgoergA3dRSGI8+TeXuvYRJXJIH1FrYlHsVipsKlVJNtLdD559rsG/Q27
	n4qiCGffTj6fSmRfLERYC0fic8uqsmIJiZl91vAX/QTNcVMJf58oLODd9Ug2lDIjevCZ8n
X-Received: by 2002:a17:903:2283:b0:2cf:dc6f:cc42 with SMTP id d9443c01a7336-2d0524b39a0mr1900965ad.46.1785508308110;
        Fri, 31 Jul 2026 07:31:48 -0700 (PDT)
Received: from yhlee-960QFG.. ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04ae19b82sm6203185ad.6.2026.07.31.07.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 07:31:47 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	linux-kernel@vger.kernel.org,
	Yehyeong Lee <yhlee@isslab.korea.ac.kr>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] nvme-tcp: reject a data-in command that transferred too few bytes
Date: Fri, 31 Jul 2026 23:31:15 +0900
Message-ID: <20260731143116.1870962-2-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260731143116.1870962-1-yhlee@isslab.korea.ac.kr>
References: <20260731143116.1870962-1-yhlee@isslab.korea.ac.kr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260731_073149_177671_129B3450 
X-CRM114-Status: GOOD (  19.27  )
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

nvme_tcp_recv_data() seeds queue->data_remaining from the declared
length of the C2HData PDU it is currently processing, and completes the
request once that one PDU has been consumed. Nothing compares the total
number of bytes actually received against the length the command asked
for: there is no receive-side counter in struct nvme_tcp_request, and
queue->data_remaining is a per-queue field, so it cannot accumulate per
command.

Nothing above nvme-tcp catches it either. blk_mq_end_request() completes
the request for blk_rq_bytes(rq) unconditionally, and neither struct
request nor the nvme host code has a residual concept.

A controller can therefore answer a 4096-byte read with a single
C2HData carrying 512 bytes. The host copies 512 bytes, completes the
request as fully successful, and the block layer reports a complete
read. In the buffered path user space subsequently reads 4096 bytes of
which 3584 were never written by that read and are whatever was already
in the page.

Observed against a test target that answers a 4096-byte read with one
512-byte C2HData: pread() returns 4096, and the trailing 3584 bytes are
content the read never wrote. With this patch the same target instead
produces "short data-in: got 512 of 4096" and the request is not
completed.

Count the bytes actually received and refuse to complete a successful
data-in command whose count does not match the requested length. The
check is applied at all three sites that can complete such a command:
the two NVME_TCP_F_DATA_SUCCESS paths in nvme_tcp_recv_data() and
nvme_tcp_recv_ddgst(), and nvme_tcp_process_nvme_cqe() for a command
completed by a separate response capsule.

Fixes: 3f2304f8c6d6 ("nvme-tcp: add NVMe over TCP host driver")
Cc: stable@vger.kernel.org
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
 drivers/nvme/host/tcp.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index ba5c7b3e2a7c..e93f015fa785 100644
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
+ * NVMe has no short read: a data-in command that completes
+ * successfully must have transferred everything it asked for.
+ */
+static bool nvme_tcp_data_in_short(struct nvme_tcp_queue *queue,
+				   struct request *rq)
+{
+	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
+
+	if (req->status != cpu_to_le16(NVME_SC_SUCCESS))
+		return false;
+	if (rq_data_dir(rq) != READ || !req->data_len)
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



Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EE1EC5516F
	for <linux-nvme@archiver.kernel.org>; Sat,  1 Aug 2026 06:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ar0TU0A76j4CC+o54wdVQpftKVR0bXPf2ahLSopc8SM=; b=tl+VGPsYB/76J2JKvFclDizrQ+
	n8LQOLRWIsTVLK+KKwxaM6rmcHuiHGbR1X11jEZWZP8bgit3qwWjp317NaByuAmIA287S6b4i2v7W
	UolW0nUEPVPXLNRD4ieilMhiMl489EGi8XULVXRyadgf+hBx/88mjjrxIAwgheE8cvAU84KZ6YMVU
	jnLc8jl4n35xzRVs/OsxawrT3IoPqPDwWAuwUpHfN4gfYjoTrAyBsketYz+UchioPS5dXzbmS4Puz
	E/De78XXOAu8efJygUc/I1b+W8Y/oO1cSt5+vPzjillTIfJfgCO0zzM7iieaD5c+z+8ueF4+6jBYh
	kqufd7Cw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wq2o5-0000000DvXb-2SoM;
	Sat, 01 Aug 2026 06:02:49 +0000
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wq2o1-0000000DvWh-3nqP
	for linux-nvme@lists.infradead.org;
	Sat, 01 Aug 2026 06:02:47 +0000
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-2ceab75934dso19441125ad.2
        for <linux-nvme@lists.infradead.org>; Fri, 31 Jul 2026 23:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1785564165; x=1786168965; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ar0TU0A76j4CC+o54wdVQpftKVR0bXPf2ahLSopc8SM=;
        b=QystAK7Wx9D2qRM9Yu2UnVmMsV/wthfQYmCAJ5WD3qRZ6MCcnvKdo3vsKG04H9DK7F
         ifU6HGKnPkcKpDLh6HvXyTVDnn0GGRZtE7PN0bu2OAnx/MeOPdXUOmZlxXEHyYz8VzoE
         qW02UbFCQlJPgjx4mmBWFc3878mYQQQXmNZBm/8RO3QQG7BYCze1HiXlejTITZvT2vOo
         l3OIrY2fn2sOFTb5dcTVzaiIIy13XTwkrudjQuTlg0iyBTDy8gEGxAO7qBeszye8Usec
         Vv2Z8uo+bdRE4kaj0V5Y4dLZxtYkFBMjqG+2GXaWpOAj4MaOoKZL9TU175pCCVhTCa1i
         937w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785564165; x=1786168965;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ar0TU0A76j4CC+o54wdVQpftKVR0bXPf2ahLSopc8SM=;
        b=WXVF09nNXNmBPb8K63hgin9VDRvkxESqar0UkpnWRh1U3MZJ1cSb0QPyK0ZkXieZA3
         rqTGD0QL8FNbUBM5hs9eQIaT8G5Ulx1RlUqspsUsVgvqh7vP1FaHR03+06Nzzd4M8h0T
         vinqay0sUW+pMb5H3/oCygM2fAERS8AykWCAVRp+34iPj2/sdIS0Ws/D/K0gXmaFQQb6
         xyEt8QGG28jUx5EMSgp6kRnAw17VnPP9DvjBx/mu1NPfKFN9qP3/y5UwTLmWU/PnqEHy
         fCvJBJ8ljrniI5jwNF03BJVyPPciFpTKtlrf+lloyQALVFjVWa7MZkc+pCLQEasf8ORJ
         sHJA==
X-Gm-Message-State: AOJu0YwgViufKCGAY8Ktl2bdzZrEvIJvMZlZ3dhPikWa7nfWugmdpYyv
	3j9IMdR95yEnWnQrDsn6OydBgpe7NtkG3yB9lGn1F7J0Wl7VS2VcD01gI66xCJzhG4zblSSV+GD
	DQcUM42g=
X-Gm-Gg: AR+sD13oIf1aJou0JPIO7i1xq3ZHF+XS99ZwkZSSHf/6OoA4yyqPTKbC0KY3epdtJri
	+WcHVrOB0LeKmgnC8CrqR09uopKw+sv20vH6stv3wHP9ldj3zFsNIA4MBlXZ+6N0yrqOuf4DogR
	AMNK3AdK1kOVlknHLEctSfx1CzoomOLRi+HE/BIvKLc9oHe3p0xLwd33eVTfSs3d0D9WyYn6itl
	rgIsXGlBvn/u7O7N1S4nGJQR0wvmii1/tsX1xQmh8+8ZH4vsp8hYwNYWPf8ndl4dfguY7MIgPES
	lZMBoaNLA2hntbqfElG6+MNnmKvyf3OFU7+1k/KjmCkEAjzjBvKIzvqVdY8nEN8JHc+7wfxmGYT
	vjKJu5NaP4skjk8KAwSX3nIWQPJTQLbpw1CFHraQwDet1LaGxzhz5BdV33IHE/n7ikuybYn47M6
	JuL34G1JM45Qm4X6IjQw0uYB0un0W+2PIGQtwYxaqF4z/3eeIwKpGYeci4SpDC1a/J0qRUihq61
	HNpZPujoiE=
X-Received: by 2002:a17:90b:1d52:b0:381:3b5d:30f4 with SMTP id 98e67ed59e1d1-38fbc40e3a0mr2124348a91.1.1785564164843;
        Fri, 31 Jul 2026 23:02:44 -0700 (PDT)
Received: from localhost.localdomain ([2406:5900:1044:110c:c329:7b28:fe02:5dc8])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38fb2bae2efsm1598856a91.11.2026.07.31.23.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 23:02:44 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	linux-kernel@vger.kernel.org,
	Yehyeong Lee <yhlee@isslab.korea.ac.kr>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] nvme-tcp: reject a read that transferred too few bytes
Date: Sat,  1 Aug 2026 15:02:00 +0900
Message-ID: <20260801060201.1879499-2-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260801060201.1879499-1-yhlee@isslab.korea.ac.kr>
References: <20260801060201.1879499-1-yhlee@isslab.korea.ac.kr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260731_230245_952121_4ADCCFFE 
X-CRM114-Status: GOOD (  19.90  )
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
the length the command asked for -- struct nvme_tcp_request has no
receive-side counter, and queue->data_remaining is per queue, not per
command. The layers above do not catch it either, since
blk_mq_end_request() completes for blk_rq_bytes(rq) unconditionally and
nothing here has a residual concept.

A controller can therefore answer a 4096-byte read with 512 bytes and
have it reported as a complete read; user space then gets 4096 bytes of
which 3584 are whatever was already in the page. I reproduced that with
a test target.

Count the bytes received and refuse to complete a successful read whose
count does not match, at the two NVME_TCP_F_DATA_SUCCESS paths and in
nvme_tcp_process_nvme_cqe(). Only REQ_OP_READ is checked, because there
the length comes from the sectors the request covers; a passthrough
command is built by its submitter, which picks both the command and the
buffer, so the kernel has nothing to compare against.

Fixes: 3f2304f8c6d6 ("nvme-tcp: add NVMe over TCP host driver")
Cc: stable@vger.kernel.org
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
v1 -> v2: an automated review pointed out that the check also applied to
passthrough commands, where the kernel does not know the command's real
transfer length; restricted to REQ_OP_READ.  Patch 2/2 is unchanged.

 drivers/nvme/host/tcp.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index ba5c7b3e2a7c..4b72f555495d 100644
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
+	if (req->status != cpu_to_le16(NVME_SC_SUCCESS))
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



Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2635D116F3
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Dec 2025 01:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=alrcnF8hffQyqVii+35fGG8FiEZV1WdxKAf95IBHMhY=; b=WsbN6NuxGcao+CDgTyj+2Q2/1E
	HJwIpRCM87p4LCzDwIgwVUEpw7CIfOwOA16rVns3jHtPlJ5KD/0diK0f5epT89V6tU5EKLIm6+8C3
	j7atMHXSm003mvdGr4ScndBzicr56VcNCFJF3+hCvgFe3shbsqAqEnfSecHTMuYzYXvDvhyy3+ZHI
	YUr3U10fibgdXcOnxFAWR75pHpAkfsHJqfUGfvLzhS2jYENFxbvd+MB+Kn9Ze+6CBpw+pPsHre4Ne
	sS1AW6V2LGr7MpPy4GhDVcSZpylHGgU/2SuVjBJQAvwvpTmViDIG1hqzCFfeaUi93jQl/A/3v2YeW
	4Bgr8IBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQFIj-00000004gNv-0qFj;
	Tue, 02 Dec 2025 01:35:33 +0000
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQFIg-00000004gLr-17Qd
	for linux-nvme@lists.infradead.org;
	Tue, 02 Dec 2025 01:35:31 +0000
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-297ec50477aso19915745ad.1
        for <linux-nvme@lists.infradead.org>; Mon, 01 Dec 2025 17:35:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764639329; x=1765244129; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=alrcnF8hffQyqVii+35fGG8FiEZV1WdxKAf95IBHMhY=;
        b=R2VVs4TBikXulRHG8CZCjAxN3RYHmqOgRU1ZoIreswBigzmEZATsx3ZvZ++s8zIuXL
         mdrV7uf6PRzMsrMeE83rWgPThymHQ5UOW5rZvYSNrnLHRVFxO4jO60bZEAL3xfyz5I4u
         K7GOk24vUZry/bUUAH4RnYjdwyLsxlgEjXxoBLAbG+CyRFY/Be8SlUtpJnSbGurvgBpD
         xyi84ngEtMN08y1VYHJNL/7NP1cj5BgDqjuOaU/a5I8debfacqKYRRVeR45sxf6VzRg/
         nSxwLc2wMQinFhFHpenYXcvYsf4QG7kmlo8xYz6EldNfEsIAcwxo3n3xDC/V33z22zfe
         VlPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764639329; x=1765244129;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=alrcnF8hffQyqVii+35fGG8FiEZV1WdxKAf95IBHMhY=;
        b=xG4Rp8N7sTxZ97rkdwh1KaOXBnFQR2UwCauSKyEK2aMdNsLWPuVUAuKHV3/2WolqjB
         BC3PUxE8tCDN1lsrfHDEyJ9RIdoCeITRgLff9ixsULK/03AxAFSUbIPC8/4nimjVGCkD
         7fojojCvLiUN1C6t55whAmCjymaTgRBaz5Snsfj1lMp6aOjHOb7KIGmvzyS9HZ1gRKor
         /bKahpQRUnoHV2IZC3wNkYREHKZYqweKieMdVAoyzAmfP3RX65+VWk9j0/Y0Ci9dWuNE
         A2POgUzPgxw1SIWVOQcBsFkHj5RC6S244g2RtdpWsmKiCa7gC6SaLt5fUs3GgO3u6sqh
         eciQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1PbHfDnWBzxKibbsSX4yEsB5zZUndUJcTti1ItpDgqTNVNCpV8QDeC39uk6oB1caoE9pGOOCp2DXg@lists.infradead.org
X-Gm-Message-State: AOJu0Yw2oV8lKnib3yQbVRzxMLOTUxMFDP5f62hEqfNi+T8/kyHgStZw
	s2hfwuupW5j2mdxnoj+41YMRp1wrbghEIyN5B/aSvkfCiEEFqgxtNmnV
X-Gm-Gg: ASbGncu/lvbNHa/Ly/G6Hk5uvUdD9P+P9eZUm+B47SS2T74ovmXzn4D1vdAblT5vqyg
	vh6C4RHbcqwMWGZdXA8unT6+PVYGey2lQ+sAFh7dmKtBw0ufoLhx/9FOouE63pkTn7YQaPUYXPc
	aU/kotIRyw/0gebm0EeK8tMAuU9aYuHAg3Tpr3lbTBYMIyF2ZKbUkHGHRoa7oSRC2lxrQAqNmNE
	hYoE8CCBPs21GJdFhXCHT6DVpGZt7px+5t8tqZnu5+7vCFHf6dQZwj4butrMM/SF8Ut0cwvtOXb
	QdiFCXno2XZ1dxZYUER5qNxcvS19ZifGghau5wN15/Z79WwmY3tAo+/xSp+V1QIm0PRmU7FVyQ7
	byqVlu7Yqj567UnjkAX5HKq9tzoSPFW1GbCtf5BKnL+JA0/UTJXnMc3y3ufjAJ1XWP9ecqK0+sw
	kCD312S01pUc2/IzjPLU4H8wRp46CVn0w4phomm28Ofj761tzb7t5ICETrcFJRijkezwETPAx8v
	1PwPdJqjdM09FjcHw8=
X-Google-Smtp-Source: AGHT+IHdYVOCmmOlbphB1W7UrAZ5O3XT23PE61UI8Mwhm5s9BH8EvESHLmAwNWu7QZRIDDb2agOulw==
X-Received: by 2002:a17:902:f786:b0:298:88:c006 with SMTP id d9443c01a7336-29d5a48b3afmr8809815ad.4.1764639329398;
        Mon, 01 Dec 2025 17:35:29 -0800 (PST)
Received: from toolbx.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29bceb54563sm132378575ad.89.2025.12.01.17.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 17:35:28 -0800 (PST)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: chuck.lever@oracle.com,
	hare@kernel.org,
	kernel-tls-handshake@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-nfs@vger.kernel.org
Cc: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	hare@suse.de,
	alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v6 4/5] nvme-tcp: Support KeyUpdate
Date: Tue,  2 Dec 2025 11:34:28 +1000
Message-ID: <20251202013429.1199659-5-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251202013429.1199659-1-alistair.francis@wdc.com>
References: <20251202013429.1199659-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251201_173530_656231_E25E395D 
X-CRM114-Status: GOOD (  26.20  )
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

From: Alistair Francis <alistair.francis@wdc.com>

If the nvme_tcp_try_send() or nvme_tcp_try_recv() functions return
EKEYEXPIRED then the underlying TLS keys need to be updated. This occurs
on an KeyUpdate event as described in RFC8446
https://datatracker.ietf.org/doc/html/rfc8446#section-4.6.3.

If the NVMe Target (TLS server) initiates a KeyUpdate this patch will
allow the NVMe layer to process the KeyUpdate request and forward the
request to userspace. Userspace must then update the key to keep the
connection alive.

This patch allows us to handle the NVMe target sending a KeyUpdate
request without aborting the connection. At this time we don't support
initiating a KeyUpdate.

Based-on: 2cbe1350-0bf5-4487-be33-1d317cb73acf@suse.de
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
v6:
 - Don't use `struct nvme_tcp_hdr` to determine TLS_HANDSHAKE_KEYUPDATE,
   instead look at the cmsg fields.
 - Don't flush async_event_work
v5:
 - Cleanup code flow
 - Check for MSG_CTRUNC in the msg_flags return from recvmsg
   and use that to determine if it's a control message
v4:
 - Remove all support for initiating KeyUpdate
 - Don't call cancel_work() when updating keys
v3:
 - Don't cancel existing handshake requests
v2:
 - Don't change the state
 - Use a helper function for KeyUpdates
 - Continue sending in nvme_tcp_send_all() after a KeyUpdate
 - Remove command message using recvmsg

 drivers/nvme/host/tcp.c | 93 +++++++++++++++++++++++++++++++++--------
 1 file changed, 75 insertions(+), 18 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 4797a4532b0d..c0966929f97b 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -172,6 +172,7 @@ struct nvme_tcp_queue {
 	bool			tls_enabled;
 	u32			rcv_crc;
 	u32			snd_crc;
+	key_serial_t		handshake_session_id;
 	__le32			exp_ddgst;
 	__le32			recv_ddgst;
 	struct completion       tls_complete;
@@ -858,7 +859,10 @@ static void nvme_tcp_handle_c2h_term(struct nvme_tcp_queue *queue,
 static int nvme_tcp_recvmsg_pdu(struct nvme_tcp_queue *queue)
 {
 	char *pdu = queue->pdu;
+	char cbuf[CMSG_LEN(sizeof(char))] = {};
 	struct msghdr msg = {
+		.msg_control = cbuf,
+		.msg_controllen = sizeof(cbuf),
 		.msg_flags = MSG_DONTWAIT,
 	};
 	struct kvec iov = {
@@ -873,6 +877,12 @@ static int nvme_tcp_recvmsg_pdu(struct nvme_tcp_queue *queue)
 	if (ret <= 0)
 		return ret;
 
+	if (cbuf[CMSG_LEN(sizeof(char)) - 1] == TLS_RECORD_TYPE_HANDSHAKE &&
+	    pdu[queue->pdu_offset] == TLS_HANDSHAKE_KEYUPDATE) {
+		dev_err(queue->ctrl->ctrl.device, "KeyUpdate message\n");
+		return 1;
+	}
+
 	queue->pdu_remaining -= ret;
 	queue->pdu_offset += ret;
 	if (queue->pdu_remaining)
@@ -944,14 +954,14 @@ static int nvme_tcp_recvmsg_data(struct nvme_tcp_queue *queue)
 	struct request *rq =
 		nvme_cid_to_rq(nvme_tcp_tagset(queue), pdu->command_id);
 	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
+	char cbuf[CMSG_LEN(sizeof(char))] = {};
+	struct msghdr msg;
+	int ret;
 
 	if (nvme_tcp_recv_state(queue) != NVME_TCP_RECV_DATA)
 		return 0;
 
 	while (queue->data_remaining) {
-		struct msghdr msg;
-		int ret;
-
 		if (!iov_iter_count(&req->iter)) {
 			req->curr_bio = req->curr_bio->bi_next;
 
@@ -975,11 +985,8 @@ static int nvme_tcp_recvmsg_data(struct nvme_tcp_queue *queue)
 		msg.msg_flags = MSG_DONTWAIT;
 
 		ret = sock_recvmsg(queue->sock, &msg, msg.msg_flags);
-		if (ret < 0) {
-			dev_err(queue->ctrl->ctrl.device,
-				"queue %d failed to receive request %#x data",
-				nvme_tcp_queue_id(queue), rq->tag);
-			return ret;
+		if (unlikely(ret < 0)) {
+			goto msg_control;
 		}
 		if (queue->data_digest)
 			nvme_tcp_ddgst_calc(req, &queue->rcv_crc, ret);
@@ -1002,6 +1009,29 @@ static int nvme_tcp_recvmsg_data(struct nvme_tcp_queue *queue)
 		}
 	}
 
+	return 0;
+
+msg_control:
+	/*
+	 * If MSG_CTRUNC is set, it's a control message,
+	 * so let's read the control message.
+	 */
+	if (msg.msg_flags & MSG_CTRUNC) {
+		memset(&msg, 0, sizeof(msg));
+		msg.msg_flags = MSG_DONTWAIT;
+		msg.msg_control = cbuf;
+		msg.msg_controllen = sizeof(cbuf);
+
+		ret = sock_recvmsg(queue->sock, &msg, msg.msg_flags);
+	}
+
+	if (ret < 0) {
+		dev_err(queue->ctrl->ctrl.device,
+			"queue %d failed to receive request %#x data, %d",
+			nvme_tcp_queue_id(queue), rq->tag, ret);
+		return ret;
+	}
+
 	return 0;
 }
 
@@ -1384,15 +1414,37 @@ static int nvme_tcp_try_recvmsg(struct nvme_tcp_queue *queue)
 		}
 	} while (result >= 0);
 
-	if (result < 0 && result != -EAGAIN) {
-		dev_err(queue->ctrl->ctrl.device,
-			"receive failed:  %d\n", result);
-		queue->rd_enabled = false;
-		nvme_tcp_error_recovery(&queue->ctrl->ctrl);
-	} else if (result == -EAGAIN)
-		result = 0;
+	if (result < 0) {
+		if (result != -EKEYEXPIRED && result != -EAGAIN) {
+			dev_err(queue->ctrl->ctrl.device,
+				"receive failed:  %d\n", result);
+			queue->rd_enabled = false;
+			nvme_tcp_error_recovery(&queue->ctrl->ctrl);
+		}
+		return result;
+	}
 
-	return result < 0 ? result : (queue->nr_cqe = nr_cqe);
+	queue->nr_cqe = nr_cqe;
+	return nr_cqe;
+}
+
+static void update_tls_keys(struct nvme_tcp_queue *queue)
+{
+	int qid = nvme_tcp_queue_id(queue);
+	int ret;
+
+	dev_dbg(queue->ctrl->ctrl.device,
+		"updating key for queue %d\n", qid);
+
+	ret = nvme_tcp_start_tls(&(queue->ctrl->ctrl),
+				 queue, queue->ctrl->ctrl.tls_pskid,
+				 HANDSHAKE_KEY_UPDATE_TYPE_RECEIVED);
+
+	if (ret < 0) {
+		dev_err(queue->ctrl->ctrl.device,
+			"failed to update the keys %d\n", ret);
+		nvme_tcp_fail_request(queue->request);
+	}
 }
 
 static void nvme_tcp_io_work(struct work_struct *w)
@@ -1417,8 +1469,11 @@ static void nvme_tcp_io_work(struct work_struct *w)
 		result = nvme_tcp_try_recvmsg(queue);
 		if (result > 0)
 			pending = true;
-		else if (unlikely(result < 0))
-			return;
+		else if (unlikely(result < 0)) {
+			if (result == -EKEYEXPIRED)
+				update_tls_keys(queue);
+			break;
+		}
 
 		/* did we get some space after spending time in recv? */
 		if (nvme_tcp_queue_has_pending(queue) &&
@@ -1726,6 +1781,7 @@ static void nvme_tcp_tls_done(void *data, int status, key_serial_t pskid,
 			ctrl->ctrl.tls_pskid = key_serial(tls_key);
 		key_put(tls_key);
 		queue->tls_err = 0;
+		queue->handshake_session_id = handshake_session_id;
 	}
 
 out_complete:
@@ -1755,6 +1811,7 @@ static int nvme_tcp_start_tls(struct nvme_ctrl *nctrl,
 		keyring = key_serial(nctrl->opts->keyring);
 	args.ta_keyring = keyring;
 	args.ta_timeout_ms = tls_handshake_timeout * 1000;
+	args.ta_handshake_session_id = queue->handshake_session_id;
 	queue->tls_err = -EOPNOTSUPP;
 	init_completion(&queue->tls_complete);
 	if (keyupdate == HANDSHAKE_KEY_UPDATE_TYPE_UNSPEC)
-- 
2.51.1



Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2591ECA1012
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Sep 2025 02:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M9e5+w0yseDVRKXyHQG0EMob0UgsivV46mk3lPkzuSY=; b=kMzspLt6EmT/JBUU7fisBxPc5h
	A84MA7pjWyHnSBclBt8E+PDhSq/i4R2nbEnj7nJSwgUhG8I7clMZ9K7Rm+pJfn0RVTa7VRIv/AFCK
	1F+G9CIT6sCVdQnv+m/T7+Z1yuOIqCPaNstA26lWKTlQ4sihuOluIzkO8KjI1zq9slIwYpr7O04wC
	bWomurBczor6e/FHiJZ8EHGIaqpPU6Qb3OM0I6Uvq8k02iSpHLN8oCYpOiLOwt0VHaLNPfiNs7qTY
	ImqFCDJ/1pPDvgzzBiMEk6FXw2FN/RrXC6qmC4yZ53XbSQf6HgJSNRYIeUer/Iy8WGk4hoGNVGDHT
	pu8CvnRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uuMUa-0000000GEyf-2LeI;
	Fri, 05 Sep 2025 02:48:00 +0000
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uuMUW-0000000GEsc-2Mc9
	for linux-nvme@lists.infradead.org;
	Fri, 05 Sep 2025 02:47:57 +0000
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-76e6cbb991aso1393448b3a.1
        for <linux-nvme@lists.infradead.org>; Thu, 04 Sep 2025 19:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757040476; x=1757645276; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M9e5+w0yseDVRKXyHQG0EMob0UgsivV46mk3lPkzuSY=;
        b=ktkqGYL2rRocxkVrBQ4JzQwIieXd4ocmeUKRiDr/RRRv6DOn87HaOg1iiakbiuNBP0
         VvDedyrzGcSR0ihi5mzqdmO9L1CR5I8suNJlKCu8C7LTiaxCZCgNQdecOP85wO6inNKX
         qGsmwGikeyRDIkD6A+7/TIBWBcFijZsC4l9AJMZPxrYkkgf5PpRTVwY7sqXZ2R5H/63Z
         HDbCoCfiajUTfJ89kqqgNKvyb4T9uvFOFZPeHOvuAdteo+lNIoae55p++ccLAI2rPAH8
         XMKEHFXXTg8z+3zYG/tFfxlGukgY6DtNRV0VG5Sx9Z9Lslki64c/SquPIMd706lNotJ4
         qvOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757040476; x=1757645276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M9e5+w0yseDVRKXyHQG0EMob0UgsivV46mk3lPkzuSY=;
        b=M4JnX2lODZ2YkG2pGE+brOsSdVxZNoDYxzz1Xl7IuYafos9LsMm7XWjMUiHcRghIl4
         JURA5DcipMacYKYt0GvJE4wYzPPALbo1An25nql0PNhVFYhUNXm16su/0ckloG/zw6ZZ
         q5C3eo0nWZ+f44//NnI9EXlBT+s+TPNH41lEVZG/+PNgwClfla3FMn1PNupMuygmf7+v
         IKP7MRM3DjDrDMcmj+RSbngwpecl95gnH6eApiVHKugQtgjxvRo1snu9DwGafJC5xxEl
         XqygXbPvrRh9xZ/8Lrs+7gU8W5gDJ8Kd8MY2goVKroK8i1WT0BXg1HDKY7JxZ9ixXw81
         vbEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbRDxgsEH9hYgQZ0a35wE1TaySlJIuk+YFU8ozxfaCiP8sbZaS6/iPGPPj7R74tF7oFSe09B5MZx0N@lists.infradead.org
X-Gm-Message-State: AOJu0YxvhlijXaLhbpUYQfI03aU6HqphANs2v/IS4KF/aS54USx4I+kn
	04LXDblldwy1UuziU9wN8CiT9A/N5FKrTeuMWcwTyiY8KXvXxKSzqSul
X-Gm-Gg: ASbGncvAWHAFr2EmNVc/5fOG6tL62BOqnH89WjxdgQwt+cavlhWdRYIRvfRJD25MdSL
	1xKF/2a//LPMbFF/aKbP4OlHiDLcQEveBhdVxwXm4klX7vVDx5TBuxzL+50EpagojkvkEH0ZZNF
	R01ZkTeKpKyIZGDoJgCkM+2hl3MaqtHWD4bbafcP0wdo87Z54gqEPDBwOdL4xSzxJboKKtqAcRa
	M2a3jFkiJQit0Rnb3vUIQ03W3nQkDpyQPBhcU4BQBeCAwn69puYowq3VeWN8csD7bIvOTN/fxw6
	jLnVwG2HYiT/7t5yuwQnZjKqk4bZqVj3xDZGURpXbdUhLojvBcBHVVrXArkeSzUj5bNR8+t3jpn
	OIPyx1DoIIijTWN1Jtj63s8x2vl8ojg8aXE/ZFb+b9QRubwUtq9OyvvlUCNGqDI0QnKy+setD6H
	N3/3Ju4syfvNOAug/lT0sPTpXrF6Y=
X-Google-Smtp-Source: AGHT+IE5rtWLMqPFBmeaxbv9KttLOM1H0Hi7npadmSAN8tmXCrE3ITkAgijdjWzjFV2lB+BE+swDmw==
X-Received: by 2002:a05:6a20:a11d:b0:245:ffe1:5615 with SMTP id adf61e73a8af0-245ffe186e2mr14759405637.38.1757040475632;
        Thu, 04 Sep 2025 19:47:55 -0700 (PDT)
Received: from toolbx.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-772590e0519sm12991858b3a.84.2025.09.04.19.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 19:47:55 -0700 (PDT)
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
	alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v2 6/7] nvme-tcp: Support KeyUpdate
Date: Fri,  5 Sep 2025 12:46:58 +1000
Message-ID: <20250905024659.811386-7-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250905024659.811386-1-alistair.francis@wdc.com>
References: <20250905024659.811386-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250904_194756_621647_5DE150BA 
X-CRM114-Status: GOOD (  23.35  )
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
on an KeyUpdate event.

If the NVMe Target (TLS server) initiates a KeyUpdate this patch will
allow the NVMe layer to process the KeyUpdate request and forward the
request to userspace. Userspace must then update the key to keep the
connection alive.

This patch allows us to handle the NVMe target sending a KeyUpdate
request without aborting the connection. At this time we don't support
initiating a KeyUpdate.

Link: https://datatracker.ietf.org/doc/html/rfc8446#section-4.6.3
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
v2:
 - Don't change the state
 - Use a helper function for KeyUpdates
 - Continue sending in nvme_tcp_send_all() after a KeyUpdate
 - Remove command message using recvmsg
 
 drivers/nvme/host/tcp.c | 73 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 70 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 776047a71436..b6449effc2ac 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -171,6 +171,7 @@ struct nvme_tcp_queue {
 	bool			tls_enabled;
 	u32			rcv_crc;
 	u32			snd_crc;
+	key_serial_t		user_session_id;
 	__le32			exp_ddgst;
 	__le32			recv_ddgst;
 	struct completion       tls_complete;
@@ -210,6 +211,7 @@ static int nvme_tcp_start_tls(struct nvme_ctrl *nctrl,
 			      struct nvme_tcp_queue *queue,
 			      key_serial_t pskid,
 			      handshake_key_update_type keyupdate);
+static void update_tls_keys(struct nvme_tcp_queue *queue);
 
 static inline struct nvme_tcp_ctrl *to_tcp_ctrl(struct nvme_ctrl *ctrl)
 {
@@ -393,6 +395,14 @@ static inline void nvme_tcp_send_all(struct nvme_tcp_queue *queue)
 	do {
 		ret = nvme_tcp_try_send(queue);
 	} while (ret > 0);
+
+	if (ret == -EKEYEXPIRED) {
+		update_tls_keys(queue);
+
+		do {
+			ret = nvme_tcp_try_send(queue);
+		} while (ret > 0);
+	}
 }
 
 static inline bool nvme_tcp_queue_has_pending(struct nvme_tcp_queue *queue)
@@ -1347,6 +1357,8 @@ static int nvme_tcp_try_send(struct nvme_tcp_queue *queue)
 done:
 	if (ret == -EAGAIN) {
 		ret = 0;
+	} else if (ret == -EKEYEXPIRED) {
+		goto out;
 	} else if (ret < 0) {
 		dev_err(queue->ctrl->ctrl.device,
 			"failed to send request %d\n", ret);
@@ -1371,9 +1383,56 @@ static int nvme_tcp_try_recv(struct nvme_tcp_queue *queue)
 	queue->nr_cqe = 0;
 	consumed = sock->ops->read_sock(sk, &rd_desc, nvme_tcp_recv_skb);
 	release_sock(sk);
+
+	/* If we received EINVAL from read_sock then it generally means the
+	 * other side sent a command message. So let's try to clear it from
+	 * our queue with a recvmsg, otherwise we get stuck in an infinite
+	 * loop.
+	 */
+	if (consumed == -EINVAL) {
+		char cbuf[CMSG_LEN(sizeof(char))] = {};
+		struct msghdr msg = { .msg_flags = MSG_DONTWAIT };
+		struct bio_vec bvec;
+
+		bvec_set_virt(&bvec, (void *)cbuf, sizeof(cbuf));
+		iov_iter_bvec(&msg.msg_iter, ITER_DEST, &bvec, 1, sizeof(cbuf));
+
+		msg.msg_control = cbuf;
+		msg.msg_controllen = sizeof(cbuf);
+
+		consumed = sock_recvmsg(sock, &msg, msg.msg_flags);
+	}
+
 	return consumed == -EAGAIN ? 0 : consumed;
 }
 
+static void update_tls_keys(struct nvme_tcp_queue *queue)
+{
+	int qid = nvme_tcp_queue_id(queue);
+	int ret;
+
+	dev_dbg(queue->ctrl->ctrl.device,
+		"updating key for queue %d\n", qid);
+
+	cancel_work(&queue->io_work);
+	handshake_req_cancel(queue->sock->sk);
+	handshake_sk_destruct_req(queue->sock->sk);
+
+	nvme_stop_keep_alive(&(queue->ctrl->ctrl));
+	flush_work(&(queue->ctrl->ctrl).async_event_work);
+
+	ret = nvme_tcp_start_tls(&(queue->ctrl->ctrl),
+				 queue, queue->ctrl->ctrl.tls_pskid,
+				 HANDSHAKE_KEY_UPDATE_TYPE_RECEIVED);
+
+	if (ret < 0) {
+		dev_err(queue->ctrl->ctrl.device,
+			"failed to update the keys %d\n", ret);
+		nvme_tcp_fail_request(queue->request);
+		nvme_tcp_done_send_req(queue);
+	}
+}
+
 static void nvme_tcp_io_work(struct work_struct *w)
 {
 	struct nvme_tcp_queue *queue =
@@ -1389,15 +1448,21 @@ static void nvme_tcp_io_work(struct work_struct *w)
 			mutex_unlock(&queue->send_mutex);
 			if (result > 0)
 				pending = true;
-			else if (unlikely(result < 0))
+			else if (unlikely(result < 0)) {
+				if (result == -EKEYEXPIRED)
+					update_tls_keys(queue);
 				break;
+			}
 		}
 
 		result = nvme_tcp_try_recv(queue);
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
@@ -1705,6 +1770,7 @@ static void nvme_tcp_tls_done(void *data, int status, key_serial_t pskid,
 			ctrl->ctrl.tls_pskid = key_serial(tls_key);
 		key_put(tls_key);
 		queue->tls_err = 0;
+		queue->user_session_id = user_session_id;
 	}
 
 out_complete:
@@ -1734,6 +1800,7 @@ static int nvme_tcp_start_tls(struct nvme_ctrl *nctrl,
 		keyring = key_serial(nctrl->opts->keyring);
 	args.ta_keyring = keyring;
 	args.ta_timeout_ms = tls_handshake_timeout * 1000;
+	args.user_session_id = queue->user_session_id;
 	queue->tls_err = -EOPNOTSUPP;
 	init_completion(&queue->tls_complete);
 	ret = tls_client_hello_psk(&args, GFP_KERNEL, keyupdate);
-- 
2.50.1



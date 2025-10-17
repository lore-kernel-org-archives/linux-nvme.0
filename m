Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8E04CCD184
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Oct 2025 04:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ynJnGU8No3Ej9J48gvJNh3pD5kzmZrz6FyAMKm2dKu0=; b=cGFKPU1kkNp4XnM5nQ95Xgc4+s
	WZ1/K+cP7JjrvCTMmT044/bpENEHJsrkMmObZuIN6ce2s8nEtSURSBr5yRJYVQELxGrnx8YL9a8IM
	wLs+XMCDzk0m0jQJc+4LpZbFz7XHTL/Gd+m1p8FjIonIlAlTi++h8jw44B6+BzM7NMOZmGwIcF4h/
	g+14RFcKEvAhudySv05dImqBTBgj0HekRirMzySgpx+PIl2aNit2kbtmc624VduJ/2Lk+Ih/xUT3p
	v1O/2VO9SbFVOqoCic3c2UPtN/agnWtLSO+ZG/HS5DgGroUjTIOIN69kjmwJnFIqctw8djo0vUVPj
	RvDQ7mkw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v9c1n-00000006WkE-3M5g;
	Fri, 17 Oct 2025 04:25:19 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v9c1m-00000006Wjc-3myi
	for linux-nvme@bombadil.infradead.org;
	Fri, 17 Oct 2025 04:25:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=ynJnGU8No3Ej9J48gvJNh3pD5kzmZrz6FyAMKm2dKu0=; b=SRWtR3Pq4CF+bIG6VsIPnbQfG0
	FwBuHmz/UAmVS8lrCtrWeNqwvsxLeYsNxUFeNYS0LNu2A2HZO+0Gey0PBHUpfHwkyjhdhTk5mW46x
	s7hKBppFzDde66newW2Dog4lKUnGOd1OFuTWeH1GghFPdwh+VdbdigCjBvB/GkN+gA9glI2kLS/A4
	Xr2dagldYqzathIrj1eLSGlB32Ni0SzwL9AIRLy23s8CSaOPm3/3OmxX3iVvpqm6CrW7pJoO/NDxb
	qbPSdl5J1Mmgas2cYUKMyopwgPWo8h+0YvPBuSyNxrWz9wpsaFKBkLpAEQPp99O1kBBAvo8sjug7F
	Lpv+6znw==;
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v9c0h-00000007Hc9-3ilK
	for linux-nvme@lists.infradead.org;
	Fri, 17 Oct 2025 04:24:52 +0000
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-290a3a4c7ecso15798335ad.0
        for <linux-nvme@lists.infradead.org>; Thu, 16 Oct 2025 21:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760675043; x=1761279843; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ynJnGU8No3Ej9J48gvJNh3pD5kzmZrz6FyAMKm2dKu0=;
        b=hl3n15euG3kY1+OmeksiyHivvqMyHwMlDMvCl6PyOv72K/I3piyBQu/ZYXpANNQJFx
         Cn+nI9oO2Jr7sNZLwSXBCFO3a3OINT2IYOYZYcNQ8ofoBrv6t31q1mOYjNCopcsfl7j1
         JycBicubb0cVa7Ghlm57munefRoyYTbbvu4heLtqi8/3lqTvAF1nwDQjMRC4hymWskoo
         H3JM0b8tl5alz7FvBsfm6B7mwcOYfqrL66JfpP51g3wji5ndWN2ajPjYTgVDl5FnT+N2
         8v6bw3hLMZ/4jyanVXVFIWIAiQGXCdZ5yuE5pQOh2hJnFEQ7CNH7ucCPuqJWg8P7TC5f
         uyxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760675043; x=1761279843;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ynJnGU8No3Ej9J48gvJNh3pD5kzmZrz6FyAMKm2dKu0=;
        b=Fab0e5YjiI2799IzsJUwh4mh/CeW15+kJJK3skvpI9+ddfZzmb6DbSFCeOIFSP4Wzx
         voQoPHqjz+eKIJyYY+8lm3Br4/mkipXVaWoIqNCKBDD9D1H4CjA4KeBXAKDFRanHcDy7
         Q33tnL5YwOiiFdwWcVAQ28xNklp87iFShG6lthKFCTaV/lD3Sj4LVpHV9PMrOnA1SW5l
         dawhoqY81ZPn0ydc6B49TGh4aIrY0ID21LtzQm9ZUi+LILtB7jRJZNPmh4u8zVfxQkjN
         clciByeSZDvQdHZI06A65eIold01mXtBt1Rdjt8Ib2EOQm6gxaos6GIvIRl1s1hNpr4K
         yRmw==
X-Forwarded-Encrypted: i=1; AJvYcCUOrywPq7JiogdO5I2KahbLWMbEqJrN8Nxeh3xcMHdhoY72VNfNR/ZOEe4im/gorhJI1VY3pxqI1O9M@lists.infradead.org
X-Gm-Message-State: AOJu0YxwF2vqgY8vKx8GXttKW7VDmwk27CYsG+0SfzuXKuABkTcmNIxo
	Pvvg8YdScBbm7WHwYFl/9aOUB1sva+g8YDp38kMGMaIf/Hh81otvfBhB
X-Gm-Gg: ASbGncsKzcXTV7jG76h5lK8KMCiq904GVE49n4dgyMwq6A5gzQTe0VCbXTsUn69NGsd
	gg5e6v8gL1QIaPXLx8M+Q0jvX5u5016BNfqfjZmz2yK9NwxxPFenSeNnCcLeyRPkn1gAu1l19Lz
	Xxm2ELNGODtXYw7oVUQA4Q6xYzdf2EBC9Fj5bv6UIjmPHiAyrKUy6hTwdJo0YxEVPhSa5i5T0y4
	xb9KPqY1VuzQGKCMiCDJ4ehD+hJjFb8Qzdp2PkbhQfZU+xntA84J/Ym1LLcIAdKSbtstPs5TKqP
	tgw5PEdkiecMIedOQatmQnYdJloA0WYo9DZ7x0XIq+DbzLGAs1RQKYRI7dXmpFXIE6Fdl8rxNQh
	Eic8pxbweu+cG/sttbn6HhYutqtsk+OqKa/xlytl2GiOyOWzkh3mZnjJDM2WL+R9kZy51xJAXJl
	l8/dj/rhcTwKFEdbOEwUP1Ffx5pAOEQHEzrXmSZZu1f+QgzvPjcDgfJyFZRFhEHYcn5rybD7B5p
	VbwmfVDJ1U5KhHkJRJVV8CIhpe7624=
X-Google-Smtp-Source: AGHT+IFcY3veIMHOTTRwopAq4s0Ev1n9UH4zUIWfhrPPA4Ws9V39ePWtGb2V3y+JvQ2CTsDbOiB+pg==
X-Received: by 2002:a17:902:e88e:b0:246:e1b6:f9b0 with SMTP id d9443c01a7336-290c9ca6712mr28314355ad.18.1760675042582;
        Thu, 16 Oct 2025 21:24:02 -0700 (PDT)
Received: from toolbx.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33be54cad3esm245557a91.12.2025.10.16.21.23.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 21:24:02 -0700 (PDT)
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
Subject: [PATCH v4 5/7] nvme-tcp: Support KeyUpdate
Date: Fri, 17 Oct 2025 14:23:10 +1000
Message-ID: <20251017042312.1271322-6-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017042312.1271322-1-alistair.francis@wdc.com>
References: <20251017042312.1271322-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251017_052449_045054_C4B8954C 
X-CRM114-Status: GOOD (  22.93  )
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

 drivers/nvme/host/tcp.c | 60 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 51 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 2696bf97dfac..791e0cc91ad8 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -172,6 +172,7 @@ struct nvme_tcp_queue {
 	bool			tls_enabled;
 	u32			rcv_crc;
 	u32			snd_crc;
+	key_serial_t		user_session_id;
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
@@ -873,12 +877,17 @@ static int nvme_tcp_recvmsg_pdu(struct nvme_tcp_queue *queue)
 	if (ret <= 0)
 		return ret;
 
+	hdr = queue->pdu;
+	if (hdr->type == TLS_HANDSHAKE_KEYUPDATE) {
+		dev_err(queue->ctrl->ctrl.device, "KeyUpdate message\n");
+		return 1;
+	}
+
 	queue->pdu_remaining -= ret;
 	queue->pdu_offset += ret;
 	if (queue->pdu_remaining)
 		return 0;
 
-	hdr = queue->pdu;
 	if (unlikely(hdr->hlen != sizeof(struct nvme_tcp_rsp_pdu))) {
 		if (!nvme_tcp_recv_pdu_supported(hdr->type))
 			goto unsupported_pdu;
@@ -944,6 +953,7 @@ static int nvme_tcp_recvmsg_data(struct nvme_tcp_queue *queue)
 	struct request *rq =
 		nvme_cid_to_rq(nvme_tcp_tagset(queue), pdu->command_id);
 	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
+	char cbuf[CMSG_LEN(sizeof(char))] = {};
 
 	if (nvme_tcp_recv_state(queue) != NVME_TCP_RECV_DATA)
 		return 0;
@@ -973,12 +983,14 @@ static int nvme_tcp_recvmsg_data(struct nvme_tcp_queue *queue)
 		memset(&msg, 0, sizeof(msg));
 		msg.msg_iter = req->iter;
 		msg.msg_flags = MSG_DONTWAIT;
+		msg.msg_control = cbuf,
+		msg.msg_controllen = sizeof(cbuf),
 
 		ret = sock_recvmsg(queue->sock, &msg, msg.msg_flags);
 		if (ret < 0) {
-			dev_err(queue->ctrl->ctrl.device,
-				"queue %d failed to receive request %#x data",
-				nvme_tcp_queue_id(queue), rq->tag);
+			dev_dbg(queue->ctrl->ctrl.device,
+				"queue %d failed to receive request %#x data, %d",
+				nvme_tcp_queue_id(queue), rq->tag, ret);
 			return ret;
 		}
 		if (queue->data_digest)
@@ -1381,17 +1393,42 @@ static int nvme_tcp_try_recvmsg(struct nvme_tcp_queue *queue)
 		}
 	} while (result >= 0);
 
-	if (result < 0 && result != -EAGAIN) {
+	if (result == -EKEYEXPIRED) {
+		return -EKEYEXPIRED;
+	} else if (result == -EAGAIN) {
+		return -EAGAIN;
+	} else if (result < 0) {
 		dev_err(queue->ctrl->ctrl.device,
 			"receive failed:  %d\n", result);
 		queue->rd_enabled = false;
 		nvme_tcp_error_recovery(&queue->ctrl->ctrl);
-	} else if (result == -EAGAIN)
-		result = 0;
+	}
 
 	return result < 0 ? result : (queue->nr_cqe = nr_cqe);
 }
 
+static void update_tls_keys(struct nvme_tcp_queue *queue)
+{
+	int qid = nvme_tcp_queue_id(queue);
+	int ret;
+
+	dev_dbg(queue->ctrl->ctrl.device,
+		"updating key for queue %d\n", qid);
+
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
@@ -1414,8 +1451,11 @@ static void nvme_tcp_io_work(struct work_struct *w)
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
@@ -1723,6 +1763,7 @@ static void nvme_tcp_tls_done(void *data, int status, key_serial_t pskid,
 			ctrl->ctrl.tls_pskid = key_serial(tls_key);
 		key_put(tls_key);
 		queue->tls_err = 0;
+		queue->user_session_id = user_session_id;
 	}
 
 out_complete:
@@ -1752,6 +1793,7 @@ static int nvme_tcp_start_tls(struct nvme_ctrl *nctrl,
 		keyring = key_serial(nctrl->opts->keyring);
 	args.ta_keyring = keyring;
 	args.ta_timeout_ms = tls_handshake_timeout * 1000;
+	args.user_session_id = queue->user_session_id;
 	queue->tls_err = -EOPNOTSUPP;
 	init_completion(&queue->tls_complete);
 	if (keyupdate == HANDSHAKE_KEY_UPDATE_TYPE_UNSPEC)
-- 
2.51.0



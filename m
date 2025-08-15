Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35857CA0ED1
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Aug 2025 05:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Gb3D+2Y2P+VKDJSul4hdca7kG6zpe2ME/ptwlX9aheU=; b=vHi9h6FgH/Qso1YGLOe72ZRc3a
	C7r0jFRzaTTgfeDM/DTJlCBdVBLNvAL8XbwSYP5HlVSL5lCHXBn1P3xevZj67ArEK/18TIMAGgZjH
	3V7j5alxcYUqw1OVEM1BqXqq1Nik4jtytfDViLmzNlx9JuOylDL7OZOKjj9LfkhMrfel960WNKAj4
	b7+imjfn2A2iCaipqFndweXXn4wZeloox1EAFqS989h/CrHG3UMAcyclLyTJ89erDg0u/qjWHebKZ
	bgRuovfZq5YHxDLVKwu2LpXixjtoXsscMLmrQkqxV/rG6p9H4V5XXQouuPDffqCAMfUYAoQb6I+nO
	jTpaRgaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ummar-00000001T3A-2Bao;
	Fri, 15 Aug 2025 05:03:09 +0000
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ummao-00000001T0f-2jeM
	for linux-nvme@lists.infradead.org;
	Fri, 15 Aug 2025 05:03:08 +0000
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-b47173a03ffso1009070a12.1
        for <linux-nvme@lists.infradead.org>; Thu, 14 Aug 2025 22:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755234186; x=1755838986; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gb3D+2Y2P+VKDJSul4hdca7kG6zpe2ME/ptwlX9aheU=;
        b=BiCDICABnCT15EmOWGjG1BdzQsBbSZ9iyJaeUiUi2pC4t/HJdgbCpXUcpiaQhs//B7
         i9Wz6wKmhexKaE9fcHCPkIYEF68VtZ65XkhVq4Zpq4CJSWO/DmbGJtfLaOcuM5IyWDn0
         1SdUN3lk5M44+J465kuoQkFITw7QTIgrXjD59GMK4rciaquoAhr8wEYVJYzX5V1GHi0V
         ruVlkP45V23U8uAM5gy9d6dHJDSwtxVz7tzjiCAUqP7SgbtjuM68dlQankKLpQXUyiy0
         nKZzfPI2HkVJ0SgjxuHV5TXvsUhhPGoc3Whgh73j3N3jfgfOhdPvgWhj7AQyt6L6aGEu
         J9Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755234186; x=1755838986;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gb3D+2Y2P+VKDJSul4hdca7kG6zpe2ME/ptwlX9aheU=;
        b=eH7m1xuIYSy5DC+Yid6TwlvAgLL5QGi+VRBs0PCPDVIv5p6GDWrkRgK9aE9pOBLY/2
         bCguOlOmI9UFX4iEvzoTTsrK7q+MRgpC3kaTFlbyyFmvUJF8XUCZGlH5YmOsPHjLAtzu
         7xygR+4SXlPvVwgROtuMvRRfQqdXHYarxAXQ+ns2eTMyOiDqBC0sw0GyDJ2KqcJVwjLx
         PMiigD5jtBvQIaYgvNO8CyhGenHrzQkifN14insCUcGTlb2nWkT+cD2YiNsAZYbY6VUI
         I5VR0MiqETg9ASxjyy/u6fbErLJHHlnUs9fHViDGXkkoWnJjYLDOuPzy3w4L2Ov0YMB7
         20rA==
X-Forwarded-Encrypted: i=1; AJvYcCUQk+8XVyFGR0aIaDt9cILnDM9Ox4v1gyvhhTTIQ0XcQsw/mWhWM1dFzo10OHKdmQYQDuNIIjv/8NoM@lists.infradead.org
X-Gm-Message-State: AOJu0YyosD4n1xXYD2uYgei/KlDwP5TiKY3BI7ZrX4fU8/VIi3/xMN8Q
	zAOY1bV5qawD433OJfdlwGBQAplPOUWFmmZi1a96GfbfbYbuqTxK4uTi
X-Gm-Gg: ASbGncsvazt/duB4y7cuGJ0oBBCa7moiqe0vVp70utLxRDS3BxH1GmZI13Xtv/peZzg
	b6tHhtI1Ee/e+PAnyInmvBmfP//6KR+hcX41zplbMyD8HUv5Wt8wO7ywpG5LW8v5JoGqzVlnhYO
	LCCtBRaCsR3O9Milk6gDM1suKH5KQNDRFxUs7iZpmI6l5eNpTe0ydLwCZVHgXpeW/VZdYOuKr2T
	0nxJmYytvlpssx6GajHUHl7vbHxtveQfrs22XUCK8yPyNHU723MiHIWxvgj72TaqXl6aiEM5Yyn
	AMlXY0MdMgEiVq0K64kP6jJqFUTx+jOERUwRAWnjS162Fnpox9P3iT+U5Gwm8LA9QwDQdvGlzqM
	9c++cT0cxmOvBvAFdtZPN5mVnXzItSbOjXhkjA3dprfDNcc3qLFF2KGdzal6an+YccCwTEtRvMK
	7bnmIqaF/Qe2FjagN82aBXBOJ9vW8=
X-Google-Smtp-Source: AGHT+IFCN3/82QbT1VacGPyrRYv9/F/PPZnJ8Gac/QiInZA+wk35khY28zaLI33nJg2szq2eps4NcA==
X-Received: by 2002:a17:902:e948:b0:242:3855:c77a with SMTP id d9443c01a7336-2446d8c6388mr12741515ad.34.1755234185896;
        Thu, 14 Aug 2025 22:03:05 -0700 (PDT)
Received: from toolbx.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d53c6e1sm5128645ad.115.2025.08.14.22.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 22:03:05 -0700 (PDT)
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
Subject: [PATCH 8/8] nvmet-tcp: Support KeyUpdate
Date: Fri, 15 Aug 2025 15:02:10 +1000
Message-ID: <20250815050210.1518439-9-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250815050210.1518439-1-alistair.francis@wdc.com>
References: <20250815050210.1518439-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250814_220306_698684_03D619D0 
X-CRM114-Status: GOOD (  21.83  )
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

If the nvmet_tcp_try_recv() function return EKEYEXPIRED or if we receive
a KeyUpdate handshake type then the underlying TLS keys need to be
updated.

If the NVMe Host (TLS client) initiates a KeyUpdate this patch will
allow the NVMe layer to process the KeyUpdate request and forward the
request to userspace. Userspace must then update the key to keep the
connection alive.

This patch allows us to handle the NVMe host sending a KeyUpdate
request without aborting the connection. At this time we don't support
initiating a KeyUpdate.

Link: https://datatracker.ietf.org/doc/html/rfc8446#section-4.6.3
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 drivers/nvme/target/tcp.c | 59 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 56 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 5eaab9c858be..1dc6fa28d08c 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -175,6 +175,7 @@ struct nvmet_tcp_queue {
 
 	/* TLS state */
 	key_serial_t		tls_pskid;
+	key_serial_t		user_key_serial;
 	struct delayed_work	tls_handshake_tmo_work;
 
 	unsigned long           poll_end;
@@ -836,6 +837,11 @@ static int nvmet_tcp_try_send_one(struct nvmet_tcp_queue *queue,
 	return 1;
 }
 
+#ifdef CONFIG_NVME_TARGET_TCP_TLS
+static int nvmet_tcp_try_peek_pdu(struct nvmet_tcp_queue *queue);
+static void nvmet_tcp_tls_handshake_timeout(struct work_struct *w);
+#endif
+
 static int nvmet_tcp_try_send(struct nvmet_tcp_queue *queue,
 		int budget, int *sends)
 {
@@ -1114,7 +1120,7 @@ static int nvmet_tcp_tls_record_ok(struct nvmet_tcp_queue *queue,
 		struct msghdr *msg, char *cbuf)
 {
 	struct cmsghdr *cmsg = (struct cmsghdr *)cbuf;
-	u8 ctype, level, description;
+	u8 ctype, htype, level, description;
 	int ret = 0;
 
 	ctype = tls_get_record_type(queue->sock->sk, cmsg);
@@ -1135,6 +1141,29 @@ static int nvmet_tcp_tls_record_ok(struct nvmet_tcp_queue *queue,
 			ret = -EAGAIN;
 		}
 		break;
+	case TLS_RECORD_TYPE_HANDSHAKE:
+		htype = tls_get_handshake_type(queue->sock->sk, cmsg);
+
+#ifdef CONFIG_NVME_TARGET_TCP_TLS
+		if (htype == TLS_HANDSHAKE_TYPE_KEY_UPDATE) {
+			tls_clear_err(queue->sock->sk);
+			handshake_req_cancel(queue->sock->sk);
+			handshake_sk_destruct_req(queue->sock->sk);
+			queue->state = NVMET_TCP_Q_TLS_HANDSHAKE;
+
+			/* Restore the default callbacks before starting upcall */
+			read_lock_bh(&queue->sock->sk->sk_callback_lock);
+			queue->sock->sk->sk_user_data = NULL;
+			queue->sock->sk->sk_data_ready = queue->data_ready;
+			read_unlock_bh(&queue->sock->sk->sk_callback_lock);
+
+			return nvmet_tcp_tls_handshake(queue, HANDSHAKE_KEY_UPDATE_TYPE_RECEIVED);
+		}
+#endif
+		pr_err("queue %d: TLS handshake %d unhandled\n",
+		       queue->idx, htype);
+		ret = -EAGAIN;
+		break;
 	default:
 		/* discard this record type */
 		pr_err("queue %d: TLS record %d unhandled\n",
@@ -1344,7 +1373,29 @@ static int nvmet_tcp_try_recv(struct nvmet_tcp_queue *queue,
 	for (i = 0; i < budget; i++) {
 		ret = nvmet_tcp_try_recv_one(queue);
 		if (unlikely(ret < 0)) {
-			nvmet_tcp_socket_error(queue, ret);
+			if (ret == -EKEYEXPIRED &&
+				queue->state != NVMET_TCP_Q_DISCONNECTING &&
+				queue->state != NVMET_TCP_Q_TLS_HANDSHAKE) {
+#ifdef CONFIG_NVME_TARGET_TCP_TLS
+				tls_clear_err(queue->sock->sk);
+				handshake_req_cancel(queue->sock->sk);
+				handshake_sk_destruct_req(queue->sock->sk);
+				queue->state = NVMET_TCP_Q_TLS_HANDSHAKE;
+
+				/* Restore the default callbacks before starting upcall */
+				read_lock_bh(&queue->sock->sk->sk_callback_lock);
+				queue->sock->sk->sk_user_data = NULL;
+				queue->sock->sk->sk_data_ready = queue->data_ready;
+				read_unlock_bh(&queue->sock->sk->sk_callback_lock);
+
+				ret = nvmet_tcp_tls_handshake(queue,
+							      HANDSHAKE_KEY_UPDATE_TYPE_RECEIVED);
+#else
+				nvmet_tcp_socket_error(queue, ret);
+#endif
+			} else {
+				nvmet_tcp_socket_error(queue, ret);
+			}
 			goto done;
 		} else if (ret == 0) {
 			break;
@@ -1798,6 +1849,7 @@ static void nvmet_tcp_tls_handshake_done(void *data, int status,
 	}
 	if (!status) {
 		queue->tls_pskid = peerid;
+		queue->user_key_serial = user_key_serial;
 		queue->state = NVMET_TCP_Q_CONNECTING;
 	} else
 		queue->state = NVMET_TCP_Q_FAILED;
@@ -1843,7 +1895,7 @@ static int nvmet_tcp_tls_handshake(struct nvmet_tcp_queue *queue,
 	int ret = -EOPNOTSUPP;
 	struct tls_handshake_args args;
 
-	if (queue->state != NVMET_TCP_Q_TLS_HANDSHAKE) {
+	if (queue->state != NVMET_TCP_Q_TLS_HANDSHAKE && !keyupdate) {
 		pr_warn("cannot start TLS in state %d\n", queue->state);
 		return -EINVAL;
 	}
@@ -1856,6 +1908,7 @@ static int nvmet_tcp_tls_handshake(struct nvmet_tcp_queue *queue,
 	args.ta_data = queue;
 	args.ta_keyring = key_serial(queue->port->nport->keyring);
 	args.ta_timeout_ms = tls_handshake_timeout * 1000;
+	args.user_key_serial = queue->user_key_serial;
 
 	ret = tls_server_hello_psk(&args, GFP_KERNEL, keyupdate);
 	if (ret) {
-- 
2.50.1



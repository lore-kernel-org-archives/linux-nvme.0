Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD9CACCA470
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Oct 2025 04:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=p/RhfwOg9G04zj7blr/LVSDCaR4a6pcdo5HXaRarZaQ=; b=Nk/SujQPJD/x8V9kU2EfaGgDOb
	aWbUS3PDltXKvkcUHtqx7LHjujCRNQu2ND0TfAWm5A9d4myCCTN3j77wyfNQoUy3zhXLvoYCLyjEB
	y6hUaiCBxHgSteZSl7hFaUNQ/sbSy437grHfvxTcHDH5YStiQvg6T1KNUcocXAXNE1rZaJM9weGuV
	3UclXV72JqgfDG8QkU74Di4lBtMCK8Gf/03kBjH69WOYtgY5BOiRh/0E9NadWJPL8QhNTATZ8xnLx
	ixS16l5wkAmUBqvLpRHnN/TnMmX3e4de8Z2ZlBbJK77hXykdW1Q7Qwlt8YCLdlXZBY/3+otEGiqul
	YDukOmIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v4XTQ-0000000BeCf-3Qne;
	Fri, 03 Oct 2025 04:32:52 +0000
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v4XTO-0000000BeAC-1Uj8
	for linux-nvme@lists.infradead.org;
	Fri, 03 Oct 2025 04:32:51 +0000
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-27c369f898fso18966865ad.3
        for <linux-nvme@lists.infradead.org>; Thu, 02 Oct 2025 21:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759465969; x=1760070769; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p/RhfwOg9G04zj7blr/LVSDCaR4a6pcdo5HXaRarZaQ=;
        b=QbU3hxX25/LefMDFhme1Oy1bYgN0errYnZAIstpoMBTA0YjoWRVm2J62Qt95n5g9bm
         5O3Jt7SV65nZCI/g90aAd7zE35P1TRSJpltr0Y3yQHj8CQqaUwoeznDvWlujxGiEMonx
         P4dSlizaXGwCDolNrAJBurkwTwgBnoeRxWalkz1pY/1ujgjve/9JjekkEwDYUyJSrgRM
         uO+cuacFOZ4TwFxvMsrjdXRLz/3sO0AN5ydISGlHYWRzZBRLACigjmebAeJXS2IfoRcz
         /u86i58q3OLhLCr1j61HKtFo6USjPk/790m5sMJUPhYEXNehDeoGtehmK7SkUI7MsXT3
         aQ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759465969; x=1760070769;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p/RhfwOg9G04zj7blr/LVSDCaR4a6pcdo5HXaRarZaQ=;
        b=Awu9h1fLvFW8VOhikxkq9NULnjLicZ3eULTfspNsYGIRrjRzckPPfRU7Ox2KmPNTrw
         KXBGcyvK3tmCqUrNAPP7JD6PZnqzHxYoVhLASbbtzVSrLkvJi7uYLmzVUYxHPCkHZz3r
         kguegfNg7L03XU0JaVBITquQIVV2Ci4cVdqybGgehIfBCI+G7yyWM3wNQj6HnyrKaK9W
         HXMrzMnhPiOzL6v2mIptQFWS4USW9QPAybIRGcR2PQlucl81CFuGmRQt0ZH7L68Q52Y5
         zY7VFgKTHJprq3Hs7lS0PdeztBXrDnX5PMVtp/MkU1M/0h7CnzBDiPxa9vd3NMB+yKt0
         lxXw==
X-Forwarded-Encrypted: i=1; AJvYcCUy5RSWgD2LOpYm+A9C8NfpAu6IbvGefZoL4kxt44j0MRpHfa/d10uuQW1CyaX9/TUhWp4iPgAXpDMC@lists.infradead.org
X-Gm-Message-State: AOJu0Yygn7SI4gYTsEvVdq4H9gnNHX1YrYTXOI1hLctpscOPY6cTqwSl
	640b9nV6hqygXGWtnmUyE5IvE4d21eRAvzXscBnRHcnslkfplpdk6h/T
X-Gm-Gg: ASbGncuVfuJ1uuTcSlYbmPAEuyIGiEjN5vxSPvIMbvK2O7jZSgTFRlZRft8uVfnC1yW
	vYVRcljgwThVefNVRQtC0A6kdceN1fHzh+LIdG1ERL0Q/P/1n3608BvY8XMIAD15KkmhSotX8d5
	J6YQ8zb7bMt4oSYM4AO2IAv5ZeyxrUpdLQ67TEn7HQv2/0vsyfZT1kbU7gptKyAntdGYg++T/i4
	A7vzedohVO48AIMAZV1LhKeV0Kn7Mgg0vYplKUNQcr5hJUacXHaO3pSOzfuVdAv7GW86v2zHBEM
	ttXCjAng0JogdDGxB9/3EZ1m4Xtjh0mGvGb8qubvvgGlxroZ9QRphEfafKbnlOV7lmBbwspyJDW
	NNzih65uYdD44Sv8Jn0/2DBYQ/k7IhVlHGCtGjKJNazvYvLYHwqNPUYHZx9qohPzoheQEKBZv/z
	0cYB2iHoi5HrNG0tYMYif66MFNX8mzC0Zh/vqqY5MFewrCfvjaqydf
X-Google-Smtp-Source: AGHT+IHqijcQ2mML6mQfax0bd7bg5pqc9YIkhbyYMavM8Tyb3Jp75ZIWGmYxOuPUT9g3dT0PGrahEA==
X-Received: by 2002:a17:903:fa6:b0:25f:45d9:6592 with SMTP id d9443c01a7336-28e9a65c0e9mr15641845ad.48.1759465969449;
        Thu, 02 Oct 2025 21:32:49 -0700 (PDT)
Received: from toolbx.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339a701c457sm6528233a91.23.2025.10.02.21.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 21:32:48 -0700 (PDT)
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
Subject: [PATCH v3 7/8] nvmet-tcp: Support KeyUpdate
Date: Fri,  3 Oct 2025 14:31:38 +1000
Message-ID: <20251003043140.1341958-8-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251003043140.1341958-1-alistair.francis@wdc.com>
References: <20251003043140.1341958-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251002_213250_402712_323AA8C0 
X-CRM114-Status: GOOD (  24.14  )
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
v3:
 - Use a write lock for sk_user_data
 - Fix build with CONFIG_NVME_TARGET_TCP_TLS disabled
 - Remove unused variable
v2:
 - Use a helper function for KeyUpdates
 - Ensure keep alive timer is stopped
 - Wait for TLS KeyUpdate to complete

 drivers/nvme/target/tcp.c | 90 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 85 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index bee0355195f5..fd59dd3ca632 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -175,6 +175,7 @@ struct nvmet_tcp_queue {
 
 	/* TLS state */
 	key_serial_t		tls_pskid;
+	key_serial_t		user_session_id;
 	struct delayed_work	tls_handshake_tmo_work;
 
 	unsigned long           poll_end;
@@ -186,6 +187,8 @@ struct nvmet_tcp_queue {
 	struct sockaddr_storage	sockaddr_peer;
 	struct work_struct	release_work;
 
+	struct completion       tls_complete;
+
 	int			idx;
 	struct list_head	queue_list;
 
@@ -836,6 +839,11 @@ static int nvmet_tcp_try_send_one(struct nvmet_tcp_queue *queue,
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
@@ -844,6 +852,13 @@ static int nvmet_tcp_try_send(struct nvmet_tcp_queue *queue,
 	for (i = 0; i < budget; i++) {
 		ret = nvmet_tcp_try_send_one(queue, i == budget - 1);
 		if (unlikely(ret < 0)) {
+#ifdef CONFIG_NVME_TARGET_TCP_TLS
+			if (ret == -EKEYEXPIRED &&
+				queue->state != NVMET_TCP_Q_DISCONNECTING &&
+				queue->state != NVMET_TCP_Q_TLS_HANDSHAKE) {
+					goto done;
+			}
+#endif
 			nvmet_tcp_socket_error(queue, ret);
 			goto done;
 		} else if (ret == 0) {
@@ -1110,6 +1125,45 @@ static inline bool nvmet_tcp_pdu_valid(u8 type)
 	return false;
 }
 
+#ifdef CONFIG_NVME_TARGET_TCP_TLS
+static int update_tls_keys(struct nvmet_tcp_queue *queue)
+{
+	int ret;
+
+	cancel_work(&queue->io_work);
+	queue->state = NVMET_TCP_Q_TLS_HANDSHAKE;
+
+	/* Restore the default callbacks before starting upcall */
+	write_lock_bh(&queue->sock->sk->sk_callback_lock);
+	queue->sock->sk->sk_data_ready =  queue->data_ready;
+	queue->sock->sk->sk_state_change = queue->state_change;
+	queue->sock->sk->sk_write_space = queue->write_space;
+	queue->sock->sk->sk_user_data = NULL;
+	write_unlock_bh(&queue->sock->sk->sk_callback_lock);
+
+	nvmet_stop_keep_alive_timer(queue->nvme_sq.ctrl);
+
+	INIT_DELAYED_WORK(&queue->tls_handshake_tmo_work,
+			  nvmet_tcp_tls_handshake_timeout);
+
+	ret = nvmet_tcp_tls_handshake(queue, HANDSHAKE_KEY_UPDATE_TYPE_RECEIVED);
+
+	if (ret < 0)
+		return ret;
+
+	ret = wait_for_completion_interruptible_timeout(&queue->tls_complete, 10 * HZ);
+
+	if (ret <= 0) {
+		tls_handshake_cancel(queue->sock->sk);
+		return ret;
+	}
+
+	queue->state = NVMET_TCP_Q_LIVE;
+
+	return ret;
+}
+#endif
+
 static int nvmet_tcp_tls_record_ok(struct nvmet_tcp_queue *queue,
 		struct msghdr *msg, char *cbuf)
 {
@@ -1135,6 +1189,9 @@ static int nvmet_tcp_tls_record_ok(struct nvmet_tcp_queue *queue,
 			ret = -EAGAIN;
 		}
 		break;
+	case TLS_RECORD_TYPE_HANDSHAKE:
+		ret = -EAGAIN;
+		break;
 	default:
 		/* discard this record type */
 		pr_err("queue %d: TLS record %d unhandled\n",
@@ -1344,6 +1401,13 @@ static int nvmet_tcp_try_recv(struct nvmet_tcp_queue *queue,
 	for (i = 0; i < budget; i++) {
 		ret = nvmet_tcp_try_recv_one(queue);
 		if (unlikely(ret < 0)) {
+#ifdef CONFIG_NVME_TARGET_TCP_TLS
+			if (ret == -EKEYEXPIRED &&
+				queue->state != NVMET_TCP_Q_DISCONNECTING &&
+				queue->state != NVMET_TCP_Q_TLS_HANDSHAKE) {
+					goto done;
+			}
+#endif
 			nvmet_tcp_socket_error(queue, ret);
 			goto done;
 		} else if (ret == 0) {
@@ -1408,14 +1472,26 @@ static void nvmet_tcp_io_work(struct work_struct *w)
 		ret = nvmet_tcp_try_recv(queue, NVMET_TCP_RECV_BUDGET, &ops);
 		if (ret > 0)
 			pending = true;
-		else if (ret < 0)
-			return;
+		else if (ret < 0) {
+#ifdef CONFIG_NVME_TARGET_TCP_TLS
+			if (ret == -EKEYEXPIRED)
+				update_tls_keys(queue);
+			else
+#endif
+				return;
+		}
 
 		ret = nvmet_tcp_try_send(queue, NVMET_TCP_SEND_BUDGET, &ops);
 		if (ret > 0)
 			pending = true;
-		else if (ret < 0)
-			return;
+		else if (ret < 0) {
+#ifdef CONFIG_NVME_TARGET_TCP_TLS
+			if (ret == -EKEYEXPIRED)
+				update_tls_keys(queue);
+			else
+#endif
+				return;
+		}
 
 	} while (pending && ops < NVMET_TCP_IO_WORK_BUDGET);
 
@@ -1798,6 +1874,7 @@ static void nvmet_tcp_tls_handshake_done(void *data, int status,
 	}
 	if (!status) {
 		queue->tls_pskid = peerid;
+		queue->user_session_id = user_session_id;
 		queue->state = NVMET_TCP_Q_CONNECTING;
 	} else
 		queue->state = NVMET_TCP_Q_FAILED;
@@ -1813,6 +1890,7 @@ static void nvmet_tcp_tls_handshake_done(void *data, int status,
 	else
 		nvmet_tcp_set_queue_sock(queue);
 	kref_put(&queue->kref, nvmet_tcp_release_queue);
+	complete(&queue->tls_complete);
 }
 
 static void nvmet_tcp_tls_handshake_timeout(struct work_struct *w)
@@ -1843,7 +1921,7 @@ static int nvmet_tcp_tls_handshake(struct nvmet_tcp_queue *queue,
 	int ret = -EOPNOTSUPP;
 	struct tls_handshake_args args;
 
-	if (queue->state != NVMET_TCP_Q_TLS_HANDSHAKE) {
+	if (queue->state != NVMET_TCP_Q_TLS_HANDSHAKE && !keyupdate) {
 		pr_warn("cannot start TLS in state %d\n", queue->state);
 		return -EINVAL;
 	}
@@ -1856,7 +1934,9 @@ static int nvmet_tcp_tls_handshake(struct nvmet_tcp_queue *queue,
 	args.ta_data = queue;
 	args.ta_keyring = key_serial(queue->port->nport->keyring);
 	args.ta_timeout_ms = tls_handshake_timeout * 1000;
+	args.user_session_id = queue->user_session_id;
 
+	init_completion(&queue->tls_complete);
 	ret = tls_server_hello_psk(&args, GFP_KERNEL, keyupdate);
 	if (ret) {
 		kref_put(&queue->kref, nvmet_tcp_release_queue);
-- 
2.51.0



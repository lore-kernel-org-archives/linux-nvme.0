Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CF15CA1002
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Sep 2025 02:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7rEfo5Vz+76MiWR+j+g+Bmag1ZppKv1/fWHQvDPMqDk=; b=DemNvc0AbL7lck01/LioriyzNi
	EGB8SaiGLwe9bTV+QnDFFEGWSlSUbraXgYcOhUq/pL30fU1TxjyWZkeBLqShNkzLLGRDkwCWp1z7q
	OUPkK0Qli+D9pbG8xlbM8NOD6RqVarPuTeZRxe3bVtQXffQLGrjoc0RjmYwCFjrfomFedw1NklQ3d
	/foTgUYUyTY0CGWGGKGhILFTpBFmuAIz5Sq+QkcW+sZ3y6UVbhbk1Chy/QkmdcVnIgfbL9RJ2vhm/
	WLvt3ukKp9dFqF1EIg1gN/yHV8+VKuBCyLOjyJk7m0kj2FYEWAyVj18hRKhixxziiaqoBpblIf9LJ
	ZA1LamYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uuMUY-0000000GEw4-2A0F;
	Fri, 05 Sep 2025 02:47:58 +0000
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uuMUQ-0000000GEq3-3YNU
	for linux-nvme@lists.infradead.org;
	Fri, 05 Sep 2025 02:47:52 +0000
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-77238a3101fso1168606b3a.0
        for <linux-nvme@lists.infradead.org>; Thu, 04 Sep 2025 19:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757040470; x=1757645270; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7rEfo5Vz+76MiWR+j+g+Bmag1ZppKv1/fWHQvDPMqDk=;
        b=IRxf8j5GIJ90ELeVSt1RYLjRrfKhpsbFNFnkuHNXfXcAhZpPbi1iFNo1TPIyXYgvnN
         YgG1J+YVTxs9GRQSQt96pWH9PLCZcHCthYg/tUKgZdPLhCIKzMo0MMUYXPAcRHq0NoMK
         53s/I3TVCvWmQBf4aXtdsBA+5JpK2bkpwKeKQoMnDnnlNZqHnG5BHI+YBQmhKalmciiw
         0ed61cX2Mz8uqiQR68fPi3hn90MZGeEErmmA9xcdAtSRkkHBXAgeKKAY8Vu5wSufazya
         HtIb16ibDBhK3GSUjTHy5e/h7ZP+O1A5Rwx8jCfwlYe96qZ4a3LanUd8OoQt0h5ri5q3
         hvUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757040470; x=1757645270;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7rEfo5Vz+76MiWR+j+g+Bmag1ZppKv1/fWHQvDPMqDk=;
        b=v2fHy80799FZ4TWOiJ0Yr3MOXDID3ZuYA8TEEwBntUMpbkTPsHiuSRSp92I1b3b0eS
         Fu4nMsYv0c1b/YAV3+zDooM/wI474bJO6Iceruv4EBonlrpjnBwQkqSBHVdKG9NxhtIP
         jr0Usz+5e8dsyTFalCSGaiiedHx2lZxV2DPP/ZVGTpwLFv7xbhlKmjWh5ui+PZX9XmEG
         yDsJCF48t0gcqKu5amu7H64Y2CIWfuJicx3hdlE0iu/7eAqvHgUsVtabF6SpyA57kZP7
         Qhee3K50GHXOtc6k/wMnGOYH/cBAK4uVOtE3sYxVxDiKrkCYFPZBJrk1GN9MM90yBgdp
         WegQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/bKv++xm5Fc+nbE3VlQ2maFrVWdhoS6vALNeaPiX4kQbgZH7ueoKK+XrYL2en1JvSPnOUgsyDC9af@lists.infradead.org
X-Gm-Message-State: AOJu0Yyc21nr2i+8ibj9BEamTIJVywXu6oEmj/NrSA/S3ik1YKshYfdm
	Pa1/mINhGJGf+NXbuhNe9WvotkSYYfakj3BjFQvtbIwo7zyPWpG+z0uG
X-Gm-Gg: ASbGncty7cK+/Uh7X9gdjNxAR9OmkTmsCe3NcklGNY6pGAR2W3KvDzt/8eQO1zX1Dat
	PNrw+3CMcLAdNBSqj4+d0NjcHmb6MvcvGOxSDf8mvr4mElALvgJ3MDQYcjQtWUe4RKEOpLiuB5r
	et3VI2zI809A2rjr51OjfOhQ9sHyXWabdNPELwcrjNoRqvdzJFfakdC9whU3zUk176x1wrlDw74
	Iq03Oxk2e7YzVAStlbaB2e0WGHIvK3n0kh2JlkSs3LPOUmZILXPfTw8RCEm5dehCZHoEy6NEeSo
	a2y9AL5W0psVpoRS41kgyi4B4bhHEv+DSl/kSKHQ5ZJoSZA4YLE3NyD4qDvZAn1zucxucJY59vK
	vZF8nB4HG2rhhkNbZTOOo+bS3402ZLam5qvMOtfuS8cJdZGRKTmDghBklkltFgz0+MKT61d4KoC
	A7ci7VfGJGiSb+CelDj1+yEJToyEUewVEnY03yEQ==
X-Google-Smtp-Source: AGHT+IEaNKuzLTgIXvOISFGk6+BMfacI6AL56ph6mdk5WD3/mbhyOZIeFDt+7RiswP0+LVqIQwP7Pw==
X-Received: by 2002:a05:6a00:2314:b0:772:bb4:a1c8 with SMTP id d2e1a72fcca58-7723e387c08mr22753435b3a.23.1757040469915;
        Thu, 04 Sep 2025 19:47:49 -0700 (PDT)
Received: from toolbx.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-772590e0519sm12991858b3a.84.2025.09.04.19.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 19:47:49 -0700 (PDT)
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
Subject: [PATCH v2 5/7] net/handshake: Support KeyUpdate message types
Date: Fri,  5 Sep 2025 12:46:57 +1000
Message-ID: <20250905024659.811386-6-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250905024659.811386-1-alistair.francis@wdc.com>
References: <20250905024659.811386-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250904_194750_896403_CFC480EB 
X-CRM114-Status: GOOD (  20.82  )
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

When reporting the msg-type to userspace let's also support reporting
KeyUpdate events. This supports reporting a client/server event and if
the other side requested a KeyUpdateRequest.

Link: https://datatracker.ietf.org/doc/html/rfc8446#section-4.6.3
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 Documentation/netlink/specs/handshake.yaml | 15 +++++++++-
 Documentation/networking/tls-handshake.rst |  4 +--
 drivers/nvme/host/tcp.c                    | 12 ++++++--
 drivers/nvme/target/tcp.c                  | 11 +++++--
 include/net/handshake.h                    | 11 +++++--
 include/uapi/linux/handshake.h             | 13 ++++++++
 net/handshake/tlshd.c                      | 35 ++++++++++++++++++----
 7 files changed, 84 insertions(+), 17 deletions(-)

diff --git a/Documentation/netlink/specs/handshake.yaml b/Documentation/netlink/specs/handshake.yaml
index a273bc74d26f..1a3312fad410 100644
--- a/Documentation/netlink/specs/handshake.yaml
+++ b/Documentation/netlink/specs/handshake.yaml
@@ -21,12 +21,17 @@ definitions:
     type: enum
     name: msg-type
     value-start: 0
-    entries: [unspec, clienthello, serverhello]
+    entries: [unspec, clienthello, serverhello, clientkeyupdate, clientkeyupdaterequest, serverkeyupdate, serverkeyupdaterequest]
   -
     type: enum
     name: auth
     value-start: 0
     entries: [unspec, unauth, psk, x509]
+  -
+    type: enum
+    name: key-update-type
+    value-start: 0
+    entries: [unspec, send, received, received_request_update]
 
 attribute-sets:
   -
@@ -74,6 +79,13 @@ attribute-sets:
       -
         name: keyring
         type: u32
+      -
+        name: key-update-request
+        type: u32
+        enum: key-update-type
+      -
+        name: key-serial
+        type: u32
   -
     name: done
     attributes:
@@ -116,6 +128,7 @@ operations:
             - certificate
             - peername
             - keyring
+            - key-serial
     -
       name: done
       doc: Handler reports handshake completion
diff --git a/Documentation/networking/tls-handshake.rst b/Documentation/networking/tls-handshake.rst
index 6f5ea1646a47..64a70847bd8b 100644
--- a/Documentation/networking/tls-handshake.rst
+++ b/Documentation/networking/tls-handshake.rst
@@ -108,7 +108,7 @@ To initiate a client-side TLS handshake with a pre-shared key, use:
 
 .. code-block:: c
 
-  ret = tls_client_hello_psk(args, gfp_flags);
+  ret = tls_client_hello_psk(args, gfp_flags, handshake_key_update_type);
 
 However, in this case, the consumer fills in the @ta_my_peerids array
 with serial numbers of keys containing the peer identities it wishes
@@ -138,7 +138,7 @@ or
 
 .. code-block:: c
 
-  ret = tls_server_hello_psk(args, gfp_flags);
+  ret = tls_server_hello_psk(args, gfp_flags, handshake_key_update_type);
 
 The argument structure is filled in as above.
 
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 2700ff3b8e85..776047a71436 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -19,6 +19,7 @@
 #include <linux/blk-mq.h>
 #include <net/busy_poll.h>
 #include <trace/events/sock.h>
+#include <uapi/linux/handshake.h>
 
 #include "nvme.h"
 #include "fabrics.h"
@@ -205,6 +206,10 @@ static struct workqueue_struct *nvme_tcp_wq;
 static const struct blk_mq_ops nvme_tcp_mq_ops;
 static const struct blk_mq_ops nvme_tcp_admin_mq_ops;
 static int nvme_tcp_try_send(struct nvme_tcp_queue *queue);
+static int nvme_tcp_start_tls(struct nvme_ctrl *nctrl,
+			      struct nvme_tcp_queue *queue,
+			      key_serial_t pskid,
+			      handshake_key_update_type keyupdate);
 
 static inline struct nvme_tcp_ctrl *to_tcp_ctrl(struct nvme_ctrl *ctrl)
 {
@@ -1708,7 +1713,8 @@ static void nvme_tcp_tls_done(void *data, int status, key_serial_t pskid,
 
 static int nvme_tcp_start_tls(struct nvme_ctrl *nctrl,
 			      struct nvme_tcp_queue *queue,
-			      key_serial_t pskid)
+			      key_serial_t pskid,
+			      handshake_key_update_type keyupdate)
 {
 	int qid = nvme_tcp_queue_id(queue);
 	int ret;
@@ -1730,7 +1736,7 @@ static int nvme_tcp_start_tls(struct nvme_ctrl *nctrl,
 	args.ta_timeout_ms = tls_handshake_timeout * 1000;
 	queue->tls_err = -EOPNOTSUPP;
 	init_completion(&queue->tls_complete);
-	ret = tls_client_hello_psk(&args, GFP_KERNEL);
+	ret = tls_client_hello_psk(&args, GFP_KERNEL, keyupdate);
 	if (ret) {
 		dev_err(nctrl->device, "queue %d: failed to start TLS: %d\n",
 			qid, ret);
@@ -1880,7 +1886,7 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 
 	/* If PSKs are configured try to start TLS */
 	if (nvme_tcp_tls_configured(nctrl) && pskid) {
-		ret = nvme_tcp_start_tls(nctrl, queue, pskid);
+		ret = nvme_tcp_start_tls(nctrl, queue, pskid, HANDSHAKE_KEY_UPDATE_TYPE_UNSPEC);
 		if (ret)
 			goto err_init_connect;
 	}
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 4ef4dd140ada..bee0355195f5 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -214,6 +214,10 @@ static struct workqueue_struct *nvmet_tcp_wq;
 static const struct nvmet_fabrics_ops nvmet_tcp_ops;
 static void nvmet_tcp_free_cmd(struct nvmet_tcp_cmd *c);
 static void nvmet_tcp_free_cmd_buffers(struct nvmet_tcp_cmd *cmd);
+#ifdef CONFIG_NVME_TARGET_TCP_TLS
+static int nvmet_tcp_tls_handshake(struct nvmet_tcp_queue *queue,
+				   handshake_key_update_type keyupdate);
+#endif
 
 static inline u16 nvmet_tcp_cmd_tag(struct nvmet_tcp_queue *queue,
 		struct nvmet_tcp_cmd *cmd)
@@ -1833,7 +1837,8 @@ static void nvmet_tcp_tls_handshake_timeout(struct work_struct *w)
 	kref_put(&queue->kref, nvmet_tcp_release_queue);
 }
 
-static int nvmet_tcp_tls_handshake(struct nvmet_tcp_queue *queue)
+static int nvmet_tcp_tls_handshake(struct nvmet_tcp_queue *queue,
+	handshake_key_update_type keyupdate)
 {
 	int ret = -EOPNOTSUPP;
 	struct tls_handshake_args args;
@@ -1852,7 +1857,7 @@ static int nvmet_tcp_tls_handshake(struct nvmet_tcp_queue *queue)
 	args.ta_keyring = key_serial(queue->port->nport->keyring);
 	args.ta_timeout_ms = tls_handshake_timeout * 1000;
 
-	ret = tls_server_hello_psk(&args, GFP_KERNEL);
+	ret = tls_server_hello_psk(&args, GFP_KERNEL, keyupdate);
 	if (ret) {
 		kref_put(&queue->kref, nvmet_tcp_release_queue);
 		pr_err("failed to start TLS, err=%d\n", ret);
@@ -1934,7 +1939,7 @@ static void nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
 		sk->sk_data_ready = port->data_ready;
 		write_unlock_bh(&sk->sk_callback_lock);
 		if (!nvmet_tcp_try_peek_pdu(queue)) {
-			if (!nvmet_tcp_tls_handshake(queue))
+			if (!nvmet_tcp_tls_handshake(queue, HANDSHAKE_KEY_UPDATE_TYPE_UNSPEC))
 				return;
 			/* TLS handshake failed, terminate the connection */
 			goto out_destroy_sq;
diff --git a/include/net/handshake.h b/include/net/handshake.h
index 89dc169eae89..52036993b2b8 100644
--- a/include/net/handshake.h
+++ b/include/net/handshake.h
@@ -10,6 +10,10 @@
 #ifndef _NET_HANDSHAKE_H
 #define _NET_HANDSHAKE_H
 
+#include <uapi/linux/handshake.h>
+
+#define handshake_key_update_type u32
+
 enum {
 	TLS_NO_KEYRING = 0,
 	TLS_NO_PEERID = 0,
@@ -32,13 +36,16 @@ struct tls_handshake_args {
 	key_serial_t		ta_my_privkey;
 	unsigned int		ta_num_peerids;
 	key_serial_t		ta_my_peerids[5];
+	key_serial_t		user_session_id;
 };
 
 int tls_client_hello_anon(const struct tls_handshake_args *args, gfp_t flags);
 int tls_client_hello_x509(const struct tls_handshake_args *args, gfp_t flags);
-int tls_client_hello_psk(const struct tls_handshake_args *args, gfp_t flags);
+int tls_client_hello_psk(const struct tls_handshake_args *args, gfp_t flags,
+			 handshake_key_update_type keyupdate);
 int tls_server_hello_x509(const struct tls_handshake_args *args, gfp_t flags);
-int tls_server_hello_psk(const struct tls_handshake_args *args, gfp_t flags);
+int tls_server_hello_psk(const struct tls_handshake_args *args, gfp_t flags,
+			 handshake_key_update_type keyupdate);
 
 bool tls_handshake_cancel(struct sock *sk);
 void tls_handshake_close(struct socket *sock);
diff --git a/include/uapi/linux/handshake.h b/include/uapi/linux/handshake.h
index b68ffbaa5f31..b691530073c6 100644
--- a/include/uapi/linux/handshake.h
+++ b/include/uapi/linux/handshake.h
@@ -19,6 +19,10 @@ enum handshake_msg_type {
 	HANDSHAKE_MSG_TYPE_UNSPEC,
 	HANDSHAKE_MSG_TYPE_CLIENTHELLO,
 	HANDSHAKE_MSG_TYPE_SERVERHELLO,
+	HANDSHAKE_MSG_TYPE_CLIENTKEYUPDATE,
+	HANDSHAKE_MSG_TYPE_CLIENTKEYUPDATEREQUEST,
+	HANDSHAKE_MSG_TYPE_SERVERKEYUPDATE,
+	HANDSHAKE_MSG_TYPE_SERVERKEYUPDATEREQUEST,
 };
 
 enum handshake_auth {
@@ -28,6 +32,13 @@ enum handshake_auth {
 	HANDSHAKE_AUTH_X509,
 };
 
+enum handshake_key_update_type {
+	HANDSHAKE_KEY_UPDATE_TYPE_UNSPEC,
+	HANDSHAKE_KEY_UPDATE_TYPE_SEND,
+	HANDSHAKE_KEY_UPDATE_TYPE_RECEIVED,
+	HANDSHAKE_KEY_UPDATE_TYPE_RECEIVED_REQUEST_UPDATE,
+};
+
 enum {
 	HANDSHAKE_A_X509_CERT = 1,
 	HANDSHAKE_A_X509_PRIVKEY,
@@ -46,6 +57,8 @@ enum {
 	HANDSHAKE_A_ACCEPT_CERTIFICATE,
 	HANDSHAKE_A_ACCEPT_PEERNAME,
 	HANDSHAKE_A_ACCEPT_KEYRING,
+	HANDSHAKE_A_ACCEPT_KEY_UPDATE_REQUEST,
+	HANDSHAKE_A_ACCEPT_KEY_SERIAL,
 
 	__HANDSHAKE_A_ACCEPT_MAX,
 	HANDSHAKE_A_ACCEPT_MAX = (__HANDSHAKE_A_ACCEPT_MAX - 1)
diff --git a/net/handshake/tlshd.c b/net/handshake/tlshd.c
index f78c3edd5e09..ebdf32c67f37 100644
--- a/net/handshake/tlshd.c
+++ b/net/handshake/tlshd.c
@@ -41,7 +41,9 @@ struct tls_handshake_req {
 	unsigned int		th_num_peerids;
 	key_serial_t		th_peerid[5];
 
-	key_serial_t		user_key_serial;
+	int			th_key_update_request;
+
+	key_serial_t		user_session_id;
 };
 
 static struct tls_handshake_req *
@@ -58,7 +60,8 @@ tls_handshake_req_init(struct handshake_req *req,
 	treq->th_num_peerids = 0;
 	treq->th_certificate = TLS_NO_CERT;
 	treq->th_privkey = TLS_NO_PRIVKEY;
-	treq->user_key_serial = TLS_NO_PRIVKEY;
+	treq->user_session_id = args->user_session_id;
+
 	return treq;
 }
 
@@ -265,6 +268,16 @@ static int tls_handshake_accept(struct handshake_req *req,
 		break;
 	}
 
+	ret = nla_put_u32(msg, HANDSHAKE_A_ACCEPT_KEY_SERIAL,
+			  treq->user_session_id);
+	if (ret < 0)
+		goto out_cancel;
+
+	ret = nla_put_u32(msg, HANDSHAKE_A_ACCEPT_KEY_UPDATE_REQUEST,
+			  treq->th_key_update_request);
+	if (ret < 0)
+		goto out_cancel;
+
 	genlmsg_end(msg, hdr);
 	return genlmsg_reply(msg, info);
 
@@ -348,7 +361,8 @@ EXPORT_SYMBOL(tls_client_hello_x509);
  *   %-ESRCH: No user agent is available
  *   %-ENOMEM: Memory allocation failed
  */
-int tls_client_hello_psk(const struct tls_handshake_args *args, gfp_t flags)
+int tls_client_hello_psk(const struct tls_handshake_args *args, gfp_t flags,
+			 handshake_key_update_type keyupdate)
 {
 	struct tls_handshake_req *treq;
 	struct handshake_req *req;
@@ -362,7 +376,11 @@ int tls_client_hello_psk(const struct tls_handshake_args *args, gfp_t flags)
 	if (!req)
 		return -ENOMEM;
 	treq = tls_handshake_req_init(req, args);
-	treq->th_type = HANDSHAKE_MSG_TYPE_CLIENTHELLO;
+	if (keyupdate != HANDSHAKE_KEY_UPDATE_TYPE_UNSPEC)
+		treq->th_type = HANDSHAKE_MSG_TYPE_CLIENTKEYUPDATE;
+	else
+		treq->th_type = HANDSHAKE_MSG_TYPE_CLIENTHELLO;
+	treq->th_key_update_request = keyupdate;
 	treq->th_auth_mode = HANDSHAKE_AUTH_PSK;
 	treq->th_num_peerids = args->ta_num_peerids;
 	for (i = 0; i < args->ta_num_peerids; i++)
@@ -410,7 +428,8 @@ EXPORT_SYMBOL(tls_server_hello_x509);
  *   %-ESRCH: No user agent is available
  *   %-ENOMEM: Memory allocation failed
  */
-int tls_server_hello_psk(const struct tls_handshake_args *args, gfp_t flags)
+int tls_server_hello_psk(const struct tls_handshake_args *args, gfp_t flags,
+			 handshake_key_update_type keyupdate)
 {
 	struct tls_handshake_req *treq;
 	struct handshake_req *req;
@@ -419,7 +438,11 @@ int tls_server_hello_psk(const struct tls_handshake_args *args, gfp_t flags)
 	if (!req)
 		return -ENOMEM;
 	treq = tls_handshake_req_init(req, args);
-	treq->th_type = HANDSHAKE_MSG_TYPE_SERVERHELLO;
+	if (keyupdate != HANDSHAKE_KEY_UPDATE_TYPE_UNSPEC)
+		treq->th_type = HANDSHAKE_MSG_TYPE_SERVERKEYUPDATE;
+	else
+		treq->th_type = HANDSHAKE_MSG_TYPE_SERVERHELLO;
+	treq->th_key_update_request = keyupdate;
 	treq->th_auth_mode = HANDSHAKE_AUTH_PSK;
 	treq->th_num_peerids = 1;
 	treq->th_peerid[0] = args->ta_my_peerids[0];
-- 
2.50.1



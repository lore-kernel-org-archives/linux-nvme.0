Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15C5DD116F3
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Dec 2025 01:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PkjdAHbsDFraRTlWyzh+N5LfJw+3oSTMhbqSeszwN7I=; b=XBeSvnayWTF1LBJ0nHSGrVVOcy
	hoRP84RHm/sf3OoYRiOUABnSNGQYYGz/cUYZ++f94OqR/2awjC3hfGzbz820UnOt853z5Li+c2W1m
	WD2YP84/LQJMF/zzxe2srw+JoJYUYuWE346cQjXptQ5eLAWT0bs5pcOC9vAHIgGdwyUdfqgqHIoRa
	9E8QkckqPCL2eGeR6OiSp0OC/RqIIjsLVo/xj4kAxTICmzcZs6jM03ho0+K59OzD8wuFC6t534D8q
	hNeE6XmkDEQe6czFtjLk3hnzb2Q4NUcQjEuOlfXpjpVtcR+MEOEXMWHYOg8kVTawYR5GuOFIahyFh
	P/3zsogw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQFId-00000004gKF-1Ezz;
	Tue, 02 Dec 2025 01:35:27 +0000
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQFIa-00000004gIW-1JuU
	for linux-nvme@lists.infradead.org;
	Tue, 02 Dec 2025 01:35:25 +0000
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-29586626fbeso61165165ad.0
        for <linux-nvme@lists.infradead.org>; Mon, 01 Dec 2025 17:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764639323; x=1765244123; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PkjdAHbsDFraRTlWyzh+N5LfJw+3oSTMhbqSeszwN7I=;
        b=bfhL4S3+/gdgjd1D50f88RYpN0Z41zmmbx5J1hSRTCt4LNE/+umEv4Fsd5YA1nXxkj
         ZBkHw7qoMBHrlQEJqEnjKPkCj/BP0lwDMzsVgn2LzrEZQQYSh+43rkmGOhlkpWn3ielv
         tR4Vz2G/+M6ZPCEudkfslKQ6cnllQZN+FF05VJJ8KjVpUZyi3IlDeKWXIieqmx9csuai
         jmGwSD7m9rFROAwN8ElJKykQ5NlWOzVWA3C5kLXc8w1nnjN7FPRnK9VtMb1Q2uSLcb+o
         JjGr//gZQ5cioHAAu/A6Xy4H5Wm22hPi/CIl2uNsl4tLuvXmE5XqEz+46Nkru1aKpMJR
         1bCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764639323; x=1765244123;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PkjdAHbsDFraRTlWyzh+N5LfJw+3oSTMhbqSeszwN7I=;
        b=LRB7X/TUpmNtorJFgCQ1i0hydKj/+kY+POx6q3Ixr8cgKLwAd/Luqun8NXUC9DXz1i
         2iucN0s0MLdFp/sF7NwVZO2PhsXFuGTMQA5EzFSy+s0mEZiySlYPhCDUPOqUxCpd2z1r
         6uouJ7cAn3Qqf/mWl27yxQ0wQSNPioTQDZYHbDQmOWIuxEyxgoABHgAU+z4xaO4/pOCo
         Pcty8tl28OA2UA+zngLWGFfm3Bm6irMlLCFhKDMNBFMdHhvFL5MYk4pkqfsw/w0SERFs
         NtSidylZkmDcnHhQ4NagLFRZC+y+DuAhgPf+WIESYKGZmoQWvg9NRmSvIs8+TrAJtiNH
         aJsQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOuxdR5Qm3tPYiM08+qZ46Mfy5iG04AXIxz7LIFsEnjiTj8qvV53yIdr7TA8JIWVAFFXYAyEZ92PcR@lists.infradead.org
X-Gm-Message-State: AOJu0YyU5tgO3rbyRHWA/ii880zD0f7IMNzd0niq3Q7flWQD8AHL/7wN
	ZRi4bqdh8GhgLiWx1Y06Rxl6RiFbAjYf+H9eA5myn9l8nOpRQSNjkZZM
X-Gm-Gg: ASbGncut4USeTDOx3YQSRj9cyxgRJBnP/D41KYwDVrxl5XtjxnjhZY247KzGU5TlBv5
	Jmu1gx77gxXqImDzbnOlHBcsRw1ExwH7urStG098m4IQkJPnTIaCm9vQX9Z6O6nqUHjzdch2Jsx
	4q1fpKUMYTmlFl+slcKwv1wraHMy4CR2JWdOFamZC3eiF6yME6Lz6kxt4QoYXH7Mfwv8hT/S8la
	1Fz+yp7Ludex67XZ8527YHSriLkcPCk30PPK7y7NE6OBRwT0N6/DJqDi1of34LORTWGik0ks+Ss
	O2i+5fg84tnsRmaDUeWVIkT6zHhpx2fmiW7PINdyqJTZ6CO+d5Qy+JorzrVKIAV7nRJVwH0nyvX
	0Sg2X4xK9M2zMuH7bfPeJWxJGyyxBtGuT6Utbx9IXvcMZriAmxg7US5WS31EWoLReP1deVEMjeH
	1utPV0mWe8hIoTQckO9ODurpWlXjQikmzGHpX/zJa16e2+czoPu2weHB/Pc/Ec+vMtBF7Q6CE6t
	65flvaSNMfjElRyrpk=
X-Google-Smtp-Source: AGHT+IE5hpf0B0tRrD3IJGSdevmhYDVDqHRJGb4vHo48RimN7HVmj0qDCGQ77PvktZ3De1OJGgWuYA==
X-Received: by 2002:a17:902:dac7:b0:296:1beb:6776 with SMTP id d9443c01a7336-29b6bf9232dmr434914535ad.58.1764639323286;
        Mon, 01 Dec 2025 17:35:23 -0800 (PST)
Received: from toolbx.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29bceb54563sm132378575ad.89.2025.12.01.17.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 17:35:22 -0800 (PST)
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
Subject: [PATCH v6 3/5] net/handshake: Support KeyUpdate message types
Date: Tue,  2 Dec 2025 11:34:27 +1000
Message-ID: <20251202013429.1199659-4-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251202013429.1199659-1-alistair.francis@wdc.com>
References: <20251202013429.1199659-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251201_173524_370525_86573F13 
X-CRM114-Status: GOOD (  22.59  )
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
Reviewed-by: Chuck Lever <chuck.lever@oracle.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
v6:
 - Init th_key_update_request field to 0
v5:
 - Drop clientkeyupdaterequest and serverkeyupdaterequest
v4:
 - Don't overload existing functions, instead create new ones
v3:
 - Fixup yamllint and kernel-doc failures

 Documentation/netlink/specs/handshake.yaml | 16 ++++-
 drivers/nvme/host/tcp.c                    | 15 +++-
 drivers/nvme/target/tcp.c                  | 10 ++-
 include/net/handshake.h                    |  6 ++
 include/uapi/linux/handshake.h             | 11 +++
 net/handshake/tlshd.c                      | 84 +++++++++++++++++++++-
 6 files changed, 134 insertions(+), 8 deletions(-)

diff --git a/Documentation/netlink/specs/handshake.yaml b/Documentation/netlink/specs/handshake.yaml
index a273bc74d26f..2f77216c8ddf 100644
--- a/Documentation/netlink/specs/handshake.yaml
+++ b/Documentation/netlink/specs/handshake.yaml
@@ -21,12 +21,18 @@ definitions:
     type: enum
     name: msg-type
     value-start: 0
-    entries: [unspec, clienthello, serverhello]
+    entries: [unspec, clienthello, serverhello, clientkeyupdate,
+              serverkeyupdate]
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
@@ -74,6 +80,13 @@ attribute-sets:
       -
         name: keyring
         type: u32
+      -
+        name: key-update-request
+        type: u32
+        enum: key-update-type
+      -
+        name: session-id
+        type: u32
   -
     name: done
     attributes:
@@ -116,6 +129,7 @@ operations:
             - certificate
             - peername
             - keyring
+            - session-id
     -
       name: done
       doc: Handler reports handshake completion
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 024d02248831..4797a4532b0d 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -20,6 +20,7 @@
 #include <linux/iov_iter.h>
 #include <net/busy_poll.h>
 #include <trace/events/sock.h>
+#include <uapi/linux/handshake.h>
 
 #include "nvme.h"
 #include "fabrics.h"
@@ -206,6 +207,10 @@ static struct workqueue_struct *nvme_tcp_wq;
 static const struct blk_mq_ops nvme_tcp_mq_ops;
 static const struct blk_mq_ops nvme_tcp_admin_mq_ops;
 static int nvme_tcp_try_send(struct nvme_tcp_queue *queue);
+static int nvme_tcp_start_tls(struct nvme_ctrl *nctrl,
+			      struct nvme_tcp_queue *queue,
+			      key_serial_t pskid,
+			      enum handshake_key_update_type keyupdate);
 
 static inline struct nvme_tcp_ctrl *to_tcp_ctrl(struct nvme_ctrl *ctrl)
 {
@@ -1729,7 +1734,8 @@ static void nvme_tcp_tls_done(void *data, int status, key_serial_t pskid,
 
 static int nvme_tcp_start_tls(struct nvme_ctrl *nctrl,
 			      struct nvme_tcp_queue *queue,
-			      key_serial_t pskid)
+			      key_serial_t pskid,
+			      enum handshake_key_update_type keyupdate)
 {
 	int qid = nvme_tcp_queue_id(queue);
 	int ret;
@@ -1751,7 +1757,10 @@ static int nvme_tcp_start_tls(struct nvme_ctrl *nctrl,
 	args.ta_timeout_ms = tls_handshake_timeout * 1000;
 	queue->tls_err = -EOPNOTSUPP;
 	init_completion(&queue->tls_complete);
-	ret = tls_client_hello_psk(&args, GFP_KERNEL);
+	if (keyupdate == HANDSHAKE_KEY_UPDATE_TYPE_UNSPEC)
+		ret = tls_client_hello_psk(&args, GFP_KERNEL);
+	else
+		ret = tls_client_keyupdate_psk(&args, GFP_KERNEL, keyupdate);
 	if (ret) {
 		dev_err(nctrl->device, "queue %d: failed to start TLS: %d\n",
 			qid, ret);
@@ -1901,7 +1910,7 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 
 	/* If PSKs are configured try to start TLS */
 	if (nvme_tcp_tls_configured(nctrl) && pskid) {
-		ret = nvme_tcp_start_tls(nctrl, queue, pskid);
+		ret = nvme_tcp_start_tls(nctrl, queue, pskid, HANDSHAKE_KEY_UPDATE_TYPE_UNSPEC);
 		if (ret)
 			goto err_init_connect;
 	}
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 7f8516892359..818efdeccef1 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1833,7 +1833,8 @@ static void nvmet_tcp_tls_handshake_timeout(struct work_struct *w)
 	kref_put(&queue->kref, nvmet_tcp_release_queue);
 }
 
-static int nvmet_tcp_tls_handshake(struct nvmet_tcp_queue *queue)
+static int nvmet_tcp_tls_handshake(struct nvmet_tcp_queue *queue,
+				   enum handshake_key_update_type keyupdate)
 {
 	int ret = -EOPNOTSUPP;
 	struct tls_handshake_args args;
@@ -1852,7 +1853,10 @@ static int nvmet_tcp_tls_handshake(struct nvmet_tcp_queue *queue)
 	args.ta_keyring = key_serial(queue->port->nport->keyring);
 	args.ta_timeout_ms = tls_handshake_timeout * 1000;
 
-	ret = tls_server_hello_psk(&args, GFP_KERNEL);
+	if (keyupdate == HANDSHAKE_KEY_UPDATE_TYPE_UNSPEC)
+		ret = tls_server_hello_psk(&args, GFP_KERNEL);
+	else
+		ret = tls_server_keyupdate_psk(&args, GFP_KERNEL, keyupdate);
 	if (ret) {
 		kref_put(&queue->kref, nvmet_tcp_release_queue);
 		pr_err("failed to start TLS, err=%d\n", ret);
@@ -1934,7 +1938,7 @@ static void nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
 		sk->sk_data_ready = port->data_ready;
 		write_unlock_bh(&sk->sk_callback_lock);
 		if (!nvmet_tcp_try_peek_pdu(queue)) {
-			if (!nvmet_tcp_tls_handshake(queue))
+			if (!nvmet_tcp_tls_handshake(queue, HANDSHAKE_KEY_UPDATE_TYPE_UNSPEC))
 				return;
 			/* TLS handshake failed, terminate the connection */
 			goto out_destroy_sq;
diff --git a/include/net/handshake.h b/include/net/handshake.h
index d9b2411d5523..54fb101202d2 100644
--- a/include/net/handshake.h
+++ b/include/net/handshake.h
@@ -10,6 +10,8 @@
 #ifndef _NET_HANDSHAKE_H
 #define _NET_HANDSHAKE_H
 
+#include <uapi/linux/handshake.h>
+
 enum {
 	TLS_NO_KEYRING = 0,
 	TLS_NO_PEERID = 0,
@@ -39,8 +41,12 @@ struct tls_handshake_args {
 int tls_client_hello_anon(const struct tls_handshake_args *args, gfp_t flags);
 int tls_client_hello_x509(const struct tls_handshake_args *args, gfp_t flags);
 int tls_client_hello_psk(const struct tls_handshake_args *args, gfp_t flags);
+int tls_client_keyupdate_psk(const struct tls_handshake_args *args, gfp_t flags,
+			     enum handshake_key_update_type keyupdate);
 int tls_server_hello_x509(const struct tls_handshake_args *args, gfp_t flags);
 int tls_server_hello_psk(const struct tls_handshake_args *args, gfp_t flags);
+int tls_server_keyupdate_psk(const struct tls_handshake_args *args, gfp_t flags,
+			     enum handshake_key_update_type keyupdate);
 
 bool tls_handshake_cancel(struct sock *sk);
 void tls_handshake_close(struct socket *sock);
diff --git a/include/uapi/linux/handshake.h b/include/uapi/linux/handshake.h
index b68ffbaa5f31..483815a064f0 100644
--- a/include/uapi/linux/handshake.h
+++ b/include/uapi/linux/handshake.h
@@ -19,6 +19,8 @@ enum handshake_msg_type {
 	HANDSHAKE_MSG_TYPE_UNSPEC,
 	HANDSHAKE_MSG_TYPE_CLIENTHELLO,
 	HANDSHAKE_MSG_TYPE_SERVERHELLO,
+	HANDSHAKE_MSG_TYPE_CLIENTKEYUPDATE,
+	HANDSHAKE_MSG_TYPE_SERVERKEYUPDATE,
 };
 
 enum handshake_auth {
@@ -28,6 +30,13 @@ enum handshake_auth {
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
@@ -46,6 +55,8 @@ enum {
 	HANDSHAKE_A_ACCEPT_CERTIFICATE,
 	HANDSHAKE_A_ACCEPT_PEERNAME,
 	HANDSHAKE_A_ACCEPT_KEYRING,
+	HANDSHAKE_A_ACCEPT_KEY_UPDATE_REQUEST,
+	HANDSHAKE_A_ACCEPT_SESSION_ID,
 
 	__HANDSHAKE_A_ACCEPT_MAX,
 	HANDSHAKE_A_ACCEPT_MAX = (__HANDSHAKE_A_ACCEPT_MAX - 1)
diff --git a/net/handshake/tlshd.c b/net/handshake/tlshd.c
index e72f45bdc226..d102211e9d77 100644
--- a/net/handshake/tlshd.c
+++ b/net/handshake/tlshd.c
@@ -41,6 +41,7 @@ struct tls_handshake_req {
 	unsigned int		th_num_peerids;
 	key_serial_t		th_peerid[5];
 
+	unsigned int		th_key_update_request;
 	key_serial_t		th_handshake_session_id;
 };
 
@@ -58,7 +59,9 @@ tls_handshake_req_init(struct handshake_req *req,
 	treq->th_num_peerids = 0;
 	treq->th_certificate = TLS_NO_CERT;
 	treq->th_privkey = TLS_NO_PRIVKEY;
-	treq->th_handshake_session_id = TLS_NO_SESSION_ID;
+	treq->th_key_update_request = 0;
+	treq->th_handshake_session_id = args->ta_handshake_session_id;
+
 	return treq;
 }
 
@@ -265,6 +268,16 @@ static int tls_handshake_accept(struct handshake_req *req,
 		break;
 	}
 
+	ret = nla_put_u32(msg, HANDSHAKE_A_ACCEPT_SESSION_ID,
+			  treq->th_handshake_session_id);
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
 
@@ -373,6 +386,44 @@ int tls_client_hello_psk(const struct tls_handshake_args *args, gfp_t flags)
 }
 EXPORT_SYMBOL(tls_client_hello_psk);
 
+/**
+ * tls_client_keyupdate_psk - request a PSK-based TLS handshake on a socket
+ * @args: socket and handshake parameters for this request
+ * @flags: memory allocation control flags
+ * @keyupdate: specifies the type of KeyUpdate operation
+ *
+ * Return values:
+ *   %0: Handshake request enqueue; ->done will be called when complete
+ *   %-EINVAL: Wrong number of local peer IDs
+ *   %-ESRCH: No user agent is available
+ *   %-ENOMEM: Memory allocation failed
+ */
+int tls_client_keyupdate_psk(const struct tls_handshake_args *args, gfp_t flags,
+			     enum handshake_key_update_type keyupdate)
+{
+	struct tls_handshake_req *treq;
+	struct handshake_req *req;
+	unsigned int i;
+
+	if (!args->ta_num_peerids ||
+	    args->ta_num_peerids > ARRAY_SIZE(treq->th_peerid))
+		return -EINVAL;
+
+	req = handshake_req_hash_lookup(args->ta_sock->sk);
+	if (!req)
+		return -ENOMEM;
+	treq = tls_handshake_req_init(req, args);
+	treq->th_type = HANDSHAKE_MSG_TYPE_CLIENTKEYUPDATE;
+	treq->th_key_update_request = keyupdate;
+	treq->th_auth_mode = HANDSHAKE_AUTH_PSK;
+	treq->th_num_peerids = args->ta_num_peerids;
+	for (i = 0; i < args->ta_num_peerids; i++)
+		treq->th_peerid[i] = args->ta_my_peerids[i];
+
+	return handshake_req_keyupdate(args->ta_sock, req, flags);
+}
+EXPORT_SYMBOL(tls_client_keyupdate_psk);
+
 /**
  * tls_server_hello_x509 - request a server TLS handshake on a socket
  * @args: socket and handshake parameters for this request
@@ -429,6 +480,37 @@ int tls_server_hello_psk(const struct tls_handshake_args *args, gfp_t flags)
 }
 EXPORT_SYMBOL(tls_server_hello_psk);
 
+/**
+ * tls_server_keyupdate_psk - request a server TLS KeyUpdate on a socket
+ * @args: socket and handshake parameters for this request
+ * @flags: memory allocation control flags
+ * @keyupdate: specifies the type of KeyUpdate operation
+ *
+ * Return values:
+ *   %0: Handshake request enqueue; ->done will be called when complete
+ *   %-ESRCH: No user agent is available
+ *   %-ENOMEM: Memory allocation failed
+ */
+int tls_server_keyupdate_psk(const struct tls_handshake_args *args, gfp_t flags,
+			     enum handshake_key_update_type keyupdate)
+{
+	struct tls_handshake_req *treq;
+	struct handshake_req *req;
+
+	req = handshake_req_hash_lookup(args->ta_sock->sk);
+	if (!req)
+		return -ENOMEM;
+	treq = tls_handshake_req_init(req, args);
+	treq->th_type = HANDSHAKE_MSG_TYPE_SERVERKEYUPDATE;
+	treq->th_key_update_request = keyupdate;
+	treq->th_auth_mode = HANDSHAKE_AUTH_PSK;
+	treq->th_num_peerids = 1;
+	treq->th_peerid[0] = args->ta_my_peerids[0];
+
+	return handshake_req_keyupdate(args->ta_sock, req, flags);
+}
+EXPORT_SYMBOL(tls_server_keyupdate_psk);
+
 /**
  * tls_handshake_cancel - cancel a pending handshake
  * @sk: socket on which there is an ongoing handshake
-- 
2.51.1



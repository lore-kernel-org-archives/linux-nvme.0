Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93525CCFA1A
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Nov 2025 04:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GwMH/feAbYG5hMxYbw3J+YyHR7bCjVFZQaW7MKJUtGI=; b=TcmFNyAY/xVJDhFq6LSBrs1CdR
	zk1ZXvx5pgORsWlwNPGd5jLnHCTdOlt7NbB3O3OMs4Xts2lFVlDegw0Pz+fQEtIsgwn8s8GVOdU03
	BHzVhF1sNMfeCHHLoFLfKOUlP5oINIPpM7HPH0taxOSmQfjjU80ZEUoma2gsIlcxBNic1MnOsaRaz
	rgO7lSiRBDSxoMG2r89dPpVEhEHToeZK+5IPcrZj9E3ltMvZS5Kcr7eCCw79IRKmQJhKprx1dnWQv
	afW1MhH0ABjevy6ApWGp7IvGhSqVWDFu8wemAriBk2dBphux5cZ3kFweodhjRKhH6OX3WKGcyds3y
	+0nT4VwA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJ2TB-000000086dJ-3EYe;
	Wed, 12 Nov 2025 04:28:33 +0000
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJ2T9-000000086bq-1C4p
	for linux-nvme@lists.infradead.org;
	Wed, 12 Nov 2025 04:28:32 +0000
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-3436d6aa66dso233156a91.1
        for <linux-nvme@lists.infradead.org>; Tue, 11 Nov 2025 20:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762921711; x=1763526511; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GwMH/feAbYG5hMxYbw3J+YyHR7bCjVFZQaW7MKJUtGI=;
        b=gu21swUCmbUMDcpXHcZF6VwYABGPoAk/E5cugqc1J7AUC4UIGgclw9LeLqE86J47jq
         wN530u2s+Phq+GS+C54Ru1DCaPUT+hGA83N6KshoZJgErlADPJYiiQ2MfgLCqOlOM4pP
         OYpnqKTA/XcOB0yMOwnFqf/5LhDcWmgXyvZeZXxswWtXbUprxXl3UYHQ83IlKMvLsUVW
         18LJV9Z/EMTq1ysblNgZKsCHct7GRDhodkwx+Sidi2UZKXoIg7WXgrpYi1tfRXCPrhbG
         JvRBS1/g3OXaxLwy5i/6pJZ2ASQLAplM7RKdADbTSgB9505MPKaWR7iri/AZ9nMKn6Pj
         5FRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762921711; x=1763526511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GwMH/feAbYG5hMxYbw3J+YyHR7bCjVFZQaW7MKJUtGI=;
        b=t8umzDsjYuPtHf3zmDm0WHe5bbCK8Q6E/4lIW3uollJv9ijScsLP+8tBcvNyIk0Qyi
         RTv6RERIJWgIB+eiLenzU78zHzZeAl5oYTOIZFsJtp4/W4z0O/IsGlcNRv3x2AZ/QWYH
         zwwFapA40VxLNY7hMW5P58hnRFlWGvivISqguQhfvbRHB5cT82C/sp0wnh9cKuHBSaFu
         r5g8ynmTU6/OPW9xuLr17MpYTnRm25otGeJH5aKJpcldgBHKiDVy7UUu4ZeeN/v/DUtQ
         0zr7Ea06vPRngfTrEsjX3N0HguzP4Yf665tyQ/ilujIXq5lIBX/inyJn0APC7JjckYFq
         LejA==
X-Forwarded-Encrypted: i=1; AJvYcCXoqAvHDKdMriSi3ySl2LiAzAQc4Tp0R1DviBt0RmjEG2VEZWzdWJYRU3e/yCyCNl0gcFubIAxzry0X@lists.infradead.org
X-Gm-Message-State: AOJu0YxI8ep5DVUIZYFK3rBfvM+73dKkhv+Or9y0YPt49mOJaGk29pAN
	Rb9nVdQAvnDYPzB0EoPET0jWQTMTRSlH8h8s/6Cseq5WGw9MINWf7Bdi
X-Gm-Gg: ASbGncvkC3CONnjhKbKRo06HjFmqQETH2WkclLX2xhJfZFlSu4bmuTER8mMmhNR6/GW
	TLPb/naHciYNAuPjqwGWaeiOd5vHXFP6+usydWIVTNFgfGdDSjXQEqnHm1w8eUneXNIzo+5n4lN
	+lmu2RRpKibYZVrkFkE33dY2iF4nOT34FtxSWU3JUDqAWIfwC6LNcBwQgYf2WBZkjyxZUHeREj2
	N1aLBqkU6vkqjV21bQJIXKMZFFK8xnjVA1ELB8YpigK51dfCubfJDKRzdPPIkfS45VPfK7aVXqR
	0lD0sTMnbj5SRniby48AsBl0RYPaRkDveJwR3FuFoXs171itjENKqMreD+YNA1d7FKB2DNKVXqN
	xIf71IgZmkTlirP4mMXeja9RXFrPNHDi0XoDBF1Pc7DoyOXNSVlJaYjvTZY+qR+4Q8bdCFJS7Qs
	MITjh8M7FUyJMaYgEj5wDJFwMKz+lRSDSNaHHanIQsxtOxJY/oylptiYX8WAp3lOgus++kFwD3l
	Cf0LLKxYA==
X-Google-Smtp-Source: AGHT+IHLsvrCYQlNmzagnHaIUAwzof2318bAn+2sz/wwmJG5Nv1JCItAUXzYrY+80FssVU6l5G3G/g==
X-Received: by 2002:a17:90b:3943:b0:343:78ed:8d19 with SMTP id 98e67ed59e1d1-343bf0bd417mr7600541a91.7.1762921710572;
        Tue, 11 Nov 2025 20:28:30 -0800 (PST)
Received: from toolbx.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-343e06fbc0dsm854681a91.2.2025.11.11.20.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 20:28:30 -0800 (PST)
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
Subject: [PATCH v5 4/6] net/handshake: Support KeyUpdate message types
Date: Wed, 12 Nov 2025 14:27:18 +1000
Message-ID: <20251112042720.3695972-5-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251112042720.3695972-1-alistair.francis@wdc.com>
References: <20251112042720.3695972-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251111_202831_339502_6CF8FF78 
X-CRM114-Status: GOOD (  22.29  )
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
 net/handshake/tlshd.c                      | 83 +++++++++++++++++++++-
 6 files changed, 133 insertions(+), 8 deletions(-)

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
index 68d7f89e431a..f5a249327bf6 100644
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
@@ -38,8 +40,12 @@ struct tls_handshake_args {
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
index 85c5fed690c0..91d2bb515b7d 100644
--- a/net/handshake/tlshd.c
+++ b/net/handshake/tlshd.c
@@ -41,6 +41,7 @@ struct tls_handshake_req {
 	unsigned int		th_num_peerids;
 	key_serial_t		th_peerid[5];
 
+	unsigned int		th_key_update_request;
 	key_serial_t		handshake_session_id;
 };
 
@@ -58,7 +59,8 @@ tls_handshake_req_init(struct handshake_req *req,
 	treq->th_num_peerids = 0;
 	treq->th_certificate = TLS_NO_CERT;
 	treq->th_privkey = TLS_NO_PRIVKEY;
-	treq->handshake_session_id = TLS_NO_PRIVKEY;
+	treq->handshake_session_id = args->handshake_session_id;
+
 	return treq;
 }
 
@@ -265,6 +267,16 @@ static int tls_handshake_accept(struct handshake_req *req,
 		break;
 	}
 
+	ret = nla_put_u32(msg, HANDSHAKE_A_ACCEPT_SESSION_ID,
+			  treq->handshake_session_id);
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
 
@@ -372,6 +384,44 @@ int tls_client_hello_psk(const struct tls_handshake_args *args, gfp_t flags)
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
+	req = handshake_req_alloc(&tls_handshake_proto, flags);
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
+	return handshake_req_submit(args->ta_sock, req, flags);
+}
+EXPORT_SYMBOL(tls_client_keyupdate_psk);
+
 /**
  * tls_server_hello_x509 - request a server TLS handshake on a socket
  * @args: socket and handshake parameters for this request
@@ -428,6 +478,37 @@ int tls_server_hello_psk(const struct tls_handshake_args *args, gfp_t flags)
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
+	req = handshake_req_alloc(&tls_handshake_proto, flags);
+	if (!req)
+		return -ENOMEM;
+	treq = tls_handshake_req_init(req, args);
+	treq->th_type = HANDSHAKE_MSG_TYPE_SERVERKEYUPDATE;
+	treq->th_key_update_request = keyupdate;
+	treq->th_auth_mode = HANDSHAKE_AUTH_PSK;
+	treq->th_num_peerids = 1;
+	treq->th_peerid[0] = args->ta_my_peerids[0];
+
+	return handshake_req_submit(args->ta_sock, req, flags);
+}
+EXPORT_SYMBOL(tls_server_keyupdate_psk);
+
 /**
  * tls_handshake_cancel - cancel a pending handshake
  * @sk: socket on which there is an ongoing handshake
-- 
2.51.1



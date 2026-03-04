Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C03D3EDEC11
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Mar 2026 05:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YBh3mRAyM98WdbFlOpQdr++fXfCeSb+WIiI2vsSeFJY=; b=woHFvzTO9MG1FY2mlcRbczqDGf
	I9yg/8/75jAI3zzdwY72ESXfUavFKgFUGvAherYpW9/wLP8pJMGX1kaOIvuSvZ4IzY3w8nbJLaGGx
	hZIS0GQnpChVw+A/gAoQ+9pNvVtNW72mLY43awrC80cUD5GlG8xssIvZ6v53buGUPiGrY0ivJ26Mm
	UuT0Y+QRqS2zZ22GWL2ygF/E00rB5ijDqXG1mrQG4Os/Rf/EjhzGsLaLSIUMM9LkznfWarDRBc0dp
	+jdXMjr91LXpp7hwdVQQLOuekh+UDxAjG39p9IAToXOX1IbfE2HhsMghETeLSaOJhE3gGnQQhoven
	b4dQkQDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxeue-0000000GTiF-0qx0;
	Wed, 04 Mar 2026 05:36:48 +0000
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxeub-0000000GTha-3KJT
	for linux-nvme@lists.infradead.org;
	Wed, 04 Mar 2026 05:36:47 +0000
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-3598581ed7bso1253791a91.2
        for <linux-nvme@lists.infradead.org>; Tue, 03 Mar 2026 21:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772602605; x=1773207405; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YBh3mRAyM98WdbFlOpQdr++fXfCeSb+WIiI2vsSeFJY=;
        b=ZKSMdCvCO7STVGOpHAtwDT42UBjGFV5gQXXLPrv1IIYrJxH5kSrmQlm5xKhsHo+SUS
         ay/bBYuHPdjtlR+oGNBoog90ZI4zE0Bw6lpW0AgKo3osR+CwKrJ1yWJYHKbcXgxKrlgq
         0Y/Lp2X2HpO733wturvjiKhIkxSsWgMTeeJGX4b/cFlt0YrTlHDAc3Wu8Ca9dslytp1y
         D9uL27lZkXahUP5WqmkhOt4GXIoJcJFhp0ymJXqDH9LcuzjkM3mjTDP8oMPdtgKhCrYK
         06HEJXWAPpD6IlBdn2ehvoKOF87teehkFLPxrbfmYK++LLfHvZR7LPf7sf25lcUT+9BL
         xymA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772602605; x=1773207405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YBh3mRAyM98WdbFlOpQdr++fXfCeSb+WIiI2vsSeFJY=;
        b=EE7i4NMAdeYMgCEjZWphc6B0+rzvokuyYSSHYu42Hm7Gfd8T2rN5h8Bh6dEJij61rA
         pNUF0vkzM38lCnkAvdkNADRf6r8kefXL6DuGvjSdAqbfrFE5T7HJvyiEYgVHYYr65zqe
         ksIjfWngOulW+57VZ7D1Ti7OMuIut8HueBQrd9TPAr4FDk0H9HbS0zSzWc4uA56ZPh7w
         mhWE1ejg+DRzoPTJ0tnDrB7LeoiY82D9ZNDKC6fIHTyaXxUmoy3wkzx9gfaSynHOSQFQ
         HvjeHU7WrBhWNYs43ZgFQJZxmJazKpzb6Wd2e7qc2BxrBkMTNVjZQHB+pPgHvyCI2TdH
         qb2g==
X-Forwarded-Encrypted: i=1; AJvYcCXgSfLAkKk2A/t8dT4r+QhSunWIxjd+JHqLy/M7xBhTBPHCGacSmBH9irGkP19Gl+732EXwEIBf1N29@lists.infradead.org
X-Gm-Message-State: AOJu0Yz/sEYvhJ7NS+LicfcIwBsLAomkxGXMseNDm9UjomWgcl9HVUk/
	fueSHH+QIDn6yR9czAdTSey+nxLuojvX1/yrCY534a/j3lOAs1aWinSe
X-Gm-Gg: ATEYQzxDyajCqW9fdLoP4v8VwZQjAQEK3xfN6bIlzFA+i3ZjpCr95L+elKrqafd3B2n
	HdZAhHWosDgWHsByBMmhS4+PwlVfAlmttsztNxwhrKs2d4SYqOg8Zk9hfcLQmFhIbeZlYzRI/6x
	cuyYlrMjJxpNkd3NVPeCaOFKKnan2ovmK4aAC2oKRcnqdmhEHGJ2q6Aex45eweCDDuoE8l00hj9
	+FugcqA4IBmauq6oapm/oFDKMPXVg/p/f455GlQKxEJp7t5JxZb/B+JKDrItzqXJxwQUIn8TH5d
	rmwg5yCYqN1ViimBpXorma4L25SOHCQQ/h4nNs5zVN2JrpjbDU3TB8xAe+BW/XYFdtdl7hDvcMT
	8qXao16QxfIJR5FxgJC8R3mPGaQrcadwpxbP8QTNU5GBzs+XLJhJoWuM5so8aefIfYSvG7BsDH2
	pDYXAM2nbVQLdG2gF+5qRmfDTqgjj2kpWvqt496XL4C9fWDenS2RPu
X-Received: by 2002:a17:90a:d44f:b0:354:a09a:1016 with SMTP id 98e67ed59e1d1-359a6a9f53dmr915696a91.30.1772602605048;
        Tue, 03 Mar 2026 21:36:45 -0800 (PST)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3599c090bfdsm4020057a91.8.2026.03.03.21.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 21:36:44 -0800 (PST)
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
Subject: [PATCH v7 3/5] net/handshake: Support KeyUpdate message types
Date: Wed,  4 Mar 2026 15:34:58 +1000
Message-ID: <20260304053500.590630-4-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260304053500.590630-1-alistair.francis@wdc.com>
References: <20260304053500.590630-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260303_213645_849558_23796990 
X-CRM114-Status: GOOD (  22.88  )
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
v7:
 - No change
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
index 204f45f791a3..8b6172dd1c0f 100644
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
+			      enum handshake_key_update_type keyupdate);
 
 static inline struct nvme_tcp_ctrl *to_tcp_ctrl(struct nvme_ctrl *ctrl)
 {
@@ -1711,7 +1716,8 @@ static void nvme_tcp_tls_done(void *data, int status, key_serial_t pskid,
 
 static int nvme_tcp_start_tls(struct nvme_ctrl *nctrl,
 			      struct nvme_tcp_queue *queue,
-			      key_serial_t pskid)
+			      key_serial_t pskid,
+			      enum handshake_key_update_type keyupdate)
 {
 	int qid = nvme_tcp_queue_id(queue);
 	int ret;
@@ -1733,7 +1739,10 @@ static int nvme_tcp_start_tls(struct nvme_ctrl *nctrl,
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
@@ -1883,7 +1892,7 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 
 	/* If PSKs are configured try to start TLS */
 	if (nvme_tcp_tls_configured(nctrl) && pskid) {
-		ret = nvme_tcp_start_tls(nctrl, queue, pskid);
+		ret = nvme_tcp_start_tls(nctrl, queue, pskid, HANDSHAKE_KEY_UPDATE_TYPE_UNSPEC);
 		if (ret)
 			goto err_init_connect;
 	}
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 63613e60f566..7f1c651a52a4 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1861,7 +1861,8 @@ static void nvmet_tcp_tls_handshake_timeout(struct work_struct *w)
 	kref_put(&queue->kref, nvmet_tcp_release_queue);
 }
 
-static int nvmet_tcp_tls_handshake(struct nvmet_tcp_queue *queue)
+static int nvmet_tcp_tls_handshake(struct nvmet_tcp_queue *queue,
+				   enum handshake_key_update_type keyupdate)
 {
 	int ret = -EOPNOTSUPP;
 	struct tls_handshake_args args;
@@ -1880,7 +1881,10 @@ static int nvmet_tcp_tls_handshake(struct nvmet_tcp_queue *queue)
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
@@ -1962,7 +1966,7 @@ static void nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
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
index 7fb3ef7f64df..ff8b423044ff 100644
--- a/include/uapi/linux/handshake.h
+++ b/include/uapi/linux/handshake.h
@@ -20,6 +20,8 @@ enum handshake_msg_type {
 	HANDSHAKE_MSG_TYPE_UNSPEC,
 	HANDSHAKE_MSG_TYPE_CLIENTHELLO,
 	HANDSHAKE_MSG_TYPE_SERVERHELLO,
+	HANDSHAKE_MSG_TYPE_CLIENTKEYUPDATE,
+	HANDSHAKE_MSG_TYPE_SERVERKEYUPDATE,
 };
 
 enum handshake_auth {
@@ -29,6 +31,13 @@ enum handshake_auth {
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
@@ -47,6 +56,8 @@ enum {
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
2.53.0



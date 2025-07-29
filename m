Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE813C83F26
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Jul 2025 07:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8ErzOLTg/uOQwoB1OOi0W/+D3AUEpPqbgJy4pCp+H1w=; b=IcEF9QlWAPQzQV3JA/fKOCYb/1
	6nMI5jV2FMaOIwcnFFNPtUh9HjoWcO8Wup8AhZ5fS21A6Rt0ljxDXDOei87czxTflpF1SPnGziV27
	FlxB3jDitYaj2QOWyv0fYhV0JGMOICYomdLDgcBnO4MesWY9qp9AE2LFrAU4f9adPKIMR+GVTZ4FY
	FS+2DJZdcp+OBL0EcJB3gU1JYEjKKDcQp2Yg348x9n3foHzDvOQpOV5CB16qJwayucCyFp7my6yOH
	VDOQTzoSBrigN3RJIdMpJts72uGCOzUKAsc9e3wrnEsYG76KN2+VPWmdeJdPzbLh0sTJ6ig5Kqx2N
	dtzwzfvg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ugezL-0000000G9Rz-47Lj;
	Tue, 29 Jul 2025 07:43:08 +0000
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ugaJE-0000000FmyH-2Q1e
	for linux-nvme@lists.infradead.org;
	Tue, 29 Jul 2025 02:43:21 +0000
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-24003ed822cso12730195ad.1
        for <linux-nvme@lists.infradead.org>; Mon, 28 Jul 2025 19:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753757000; x=1754361800; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ErzOLTg/uOQwoB1OOi0W/+D3AUEpPqbgJy4pCp+H1w=;
        b=aCz1oL263RV9L6Q9OV4u9VyyKXymZXPpjjhVW70MY+f69Megxf6YCtZH7fxDTUaUHv
         940oeFhLhjG4BWvOID9tf00iuPvXvqTS/W93qmPHxQD4rm6wNh5XH8gmliGNAugYtKDG
         IGt9MkBnGeuaUSJKw1i0rCyAgjCdyzgOP+1FkFhcyXvpYcLqCPoWGXjw1uBqpyMHqhcK
         nSbQnwDPxgB9xqVllOx5Evl77ZoFDeOQfAAfnvjHzObFidCFMUFanqTqt/oy3BB0M7/u
         khVqGDhC8/myX+IFxevkfAJ3xaxGqICGoynVKiXp6bGZI16+Vv17ymDpeCDRmHu7RXen
         yxqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753757000; x=1754361800;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8ErzOLTg/uOQwoB1OOi0W/+D3AUEpPqbgJy4pCp+H1w=;
        b=DG5ZkBzbFrQzqOMCb5l+ekdFvqCVPPsnaBEcarCgvSlxNgKXLJ7XrfX7lDysaAg5mt
         v9kUZ3urk7/YaPVKiPtG1MbDbx2oraXPrTYVEAKmlDLkDDU7HyhKa6C7dbLxlf6HqiAU
         oVZsaUe90AJqlVBT7i/p1j91dngM85WNagyqXKUSueiSK/fDLFRlOe8Jsx8JjpA1cdla
         89/WbXnJDFnlWzPvV82TvtamMNS0oIY+KnLUSzrQ2lq9q6SU8oszAtY0b+uIVuOLlWuW
         Njl9L2msULQwHFHKkIThByU4HTpPlDzEqG32pTDj41YaonjWggwZ+pYLQhvMOt7xfwb8
         xsCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJ8nxSeKGIXAAskAS7542KAQC3ngMUOhEtTbidjn1WDHK9hxJR6nIXZxpm1T2XPwkU8tKGuayA3wN2@lists.infradead.org
X-Gm-Message-State: AOJu0YyngfFUjHSICek2XibAwhkbxgHWzgWL/3gWCVLwI+lJSfNDOkbq
	+NTpcXLqnsuwkclc9AIuw2lPaAiwLhV8CpFECIwHXh6k0V5f02Mq+L7x
X-Gm-Gg: ASbGncuZxHtg3X7YB2yAbts8QbCo2mIT+jWMd2Xkar0g5VHSk23d7hYFWe2AnBGTdDv
	d4HVfb8jFeHRynDPyOTtcxpjRJWwIwm/9J/xjzv4bXo5yRU8+KOd6YnU17hCH6I8tU75qV5WxAd
	AKOIP9BGS2MCrkcqp9Bxvj6l3XnndSV+nEIwVua4dbJNcZzom3HRkpI0g+ZpUgBJ4op8hvrzyUi
	Ii/3vwn4P/adSdiwfwCwTHglnH/LZTYBIJ+ayU1I8xtP2fKNK+i9i64++J4CQbmtYP/6Bb5EqXU
	RKqSJNpPf26pym9Ef65XkdpCK4dUgh7moJNJ2/cMHjzjUvJejr+X0rRb9ga0chZdkOJoPpuOfHq
	a+3f7mtFd0pHOAApZfPAX750J7uJHUfk08HUE
X-Google-Smtp-Source: AGHT+IGm00/i/5Md9wIJ3Bm72q8ofeFJb07OGmSiJpdFtE+Ka6GuL9pJd9Sn0gk85BhTLtNCqZxtwA==
X-Received: by 2002:a17:902:d507:b0:240:2145:e51f with SMTP id d9443c01a7336-2402145e7cdmr84404155ad.3.1753756999714;
        Mon, 28 Jul 2025 19:43:19 -0700 (PDT)
Received: from fedora ([159.196.5.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fecd9ed12sm51327855ad.8.2025.07.28.19.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 19:43:19 -0700 (PDT)
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
To: alistair.francis@wdc.com,
	dlemoal@kernel.org,
	chuck.lever@oracle.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	donald.hunter@gmail.com,
	corbet@lwn.net,
	kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	borisp@nvidia.com,
	john.fastabend@gmail.com,
	jlayton@kernel.org,
	neil@brown.name,
	okorniev@redhat.com,
	Dai.Ngo@oracle.com,
	tom@talpey.com,
	trondmy@kernel.org,
	anna@kernel.org,
	kernel-tls-handshake@lists.linux.dev,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-nfs@vger.kernel.org,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: [RFC 1/4] net/handshake: get negotiated tls record size limit
Date: Tue, 29 Jul 2025 12:41:49 +1000
Message-ID: <20250729024150.222513-4-wilfred.opensource@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250729024150.222513-2-wilfred.opensource@gmail.com>
References: <20250729024150.222513-2-wilfred.opensource@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250728_194320_625094_0E1F4C50 
X-CRM114-Status: GOOD (  24.05  )
X-Mailman-Approved-At: Tue, 29 Jul 2025 00:43:06 -0700
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

From: Wilfred Mallawa <wilfred.mallawa@wdc.com>

During a handshake, an endpoint may specify a maximum record size limit.
Currently, this limit is not visble to the kernel particularly in the case
where userspace handles the handshake (tlshd/gnutls). This patch adds
support for retrieving the record size limit.

This is the first step in ensuring that the kernel can respect the record
size limit imposed by the endpoint.

Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
---
 Documentation/netlink/specs/handshake.yaml |  3 +++
 Documentation/networking/tls-handshake.rst |  8 +++++++-
 drivers/nvme/host/tcp.c                    |  3 ++-
 drivers/nvme/target/tcp.c                  |  3 ++-
 include/net/handshake.h                    |  4 +++-
 include/uapi/linux/handshake.h             |  1 +
 net/handshake/genl.c                       |  5 +++--
 net/handshake/tlshd.c                      | 15 +++++++++++++--
 net/sunrpc/svcsock.c                       |  4 +++-
 net/sunrpc/xprtsock.c                      |  4 +++-
 10 files changed, 40 insertions(+), 10 deletions(-)

diff --git a/Documentation/netlink/specs/handshake.yaml b/Documentation/netlink/specs/handshake.yaml
index b934cc513e3d..35d5eb91a3f9 100644
--- a/Documentation/netlink/specs/handshake.yaml
+++ b/Documentation/netlink/specs/handshake.yaml
@@ -84,6 +84,9 @@ attribute-sets:
         name: remote-auth
         type: u32
         multi-attr: true
+      -
+        name: record-size-limit
+        type: u32
 
 operations:
   list:
diff --git a/Documentation/networking/tls-handshake.rst b/Documentation/networking/tls-handshake.rst
index 6f5ea1646a47..cd984a137779 100644
--- a/Documentation/networking/tls-handshake.rst
+++ b/Documentation/networking/tls-handshake.rst
@@ -169,7 +169,8 @@ The synopsis of this function is:
 .. code-block:: c
 
   typedef void	(*tls_done_func_t)(void *data, int status,
-                                   key_serial_t peerid);
+                                   key_serial_t peerid,
+                                   size_t tls_record_size_limit);
 
 The consumer provides a cookie in the @ta_data field of the
 tls_handshake_args structure that is returned in the @data parameter of
@@ -200,6 +201,11 @@ The @peerid parameter contains the serial number of a key containing the
 remote peer's identity or the value TLS_NO_PEERID if the session is not
 authenticated.
 
+The @tls_record_size_limit parameter, if non-zero, exposes the tls max
+record size advertised by the endpoint. Record size must not exceed this amount.
+A negative value shall indicate that the endpoint did not advertise the
+maximum record size limit.
+
 A best practice is to close and destroy the socket immediately if the
 handshake failed.
 
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index d924008c3949..65ceadb4ffed 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1673,7 +1673,8 @@ static void nvme_tcp_set_queue_io_cpu(struct nvme_tcp_queue *queue)
 		qid, queue->io_cpu);
 }
 
-static void nvme_tcp_tls_done(void *data, int status, key_serial_t pskid)
+static void nvme_tcp_tls_done(void *data, int status, key_serial_t pskid,
+			      size_t tls_record_size_limit)
 {
 	struct nvme_tcp_queue *queue = data;
 	struct nvme_tcp_ctrl *ctrl = queue->ctrl;
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 470bf37e5a63..60e308401a54 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1780,7 +1780,8 @@ static int nvmet_tcp_tls_key_lookup(struct nvmet_tcp_queue *queue,
 }
 
 static void nvmet_tcp_tls_handshake_done(void *data, int status,
-					 key_serial_t peerid)
+					key_serial_t peerid,
+					size_t tls_record_size_limit)
 {
 	struct nvmet_tcp_queue *queue = data;
 
diff --git a/include/net/handshake.h b/include/net/handshake.h
index 8ebd4f9ed26e..c00b1aaa7aba 100644
--- a/include/net/handshake.h
+++ b/include/net/handshake.h
@@ -15,10 +15,12 @@ enum {
 	TLS_NO_PEERID = 0,
 	TLS_NO_CERT = 0,
 	TLS_NO_PRIVKEY = 0,
+	TLS_NO_RECORD_SIZE_LIMIT = 0,
 };
 
 typedef void	(*tls_done_func_t)(void *data, int status,
-				   key_serial_t peerid);
+				   key_serial_t peerid,
+				   size_t tls_record_size_limit);
 
 struct tls_handshake_args {
 	struct socket		*ta_sock;
diff --git a/include/uapi/linux/handshake.h b/include/uapi/linux/handshake.h
index 3d7ea58778c9..0768eb8eb415 100644
--- a/include/uapi/linux/handshake.h
+++ b/include/uapi/linux/handshake.h
@@ -54,6 +54,7 @@ enum {
 	HANDSHAKE_A_DONE_STATUS = 1,
 	HANDSHAKE_A_DONE_SOCKFD,
 	HANDSHAKE_A_DONE_REMOTE_AUTH,
+	HANDSHAKE_A_DONE_RECORD_SIZE_LIMIT,
 
 	__HANDSHAKE_A_DONE_MAX,
 	HANDSHAKE_A_DONE_MAX = (__HANDSHAKE_A_DONE_MAX - 1)
diff --git a/net/handshake/genl.c b/net/handshake/genl.c
index f55d14d7b726..44c43ce18361 100644
--- a/net/handshake/genl.c
+++ b/net/handshake/genl.c
@@ -16,10 +16,11 @@ static const struct nla_policy handshake_accept_nl_policy[HANDSHAKE_A_ACCEPT_HAN
 };
 
 /* HANDSHAKE_CMD_DONE - do */
-static const struct nla_policy handshake_done_nl_policy[HANDSHAKE_A_DONE_REMOTE_AUTH + 1] = {
+static const struct nla_policy handshake_done_nl_policy[HANDSHAKE_A_DONE_RECORD_SIZE_LIMIT + 1] = {
 	[HANDSHAKE_A_DONE_STATUS] = { .type = NLA_U32, },
 	[HANDSHAKE_A_DONE_SOCKFD] = { .type = NLA_S32, },
 	[HANDSHAKE_A_DONE_REMOTE_AUTH] = { .type = NLA_U32, },
+	[HANDSHAKE_A_DONE_RECORD_SIZE_LIMIT] = { .type = NLA_U32, },
 };
 
 /* Ops table for handshake */
@@ -35,7 +36,7 @@ static const struct genl_split_ops handshake_nl_ops[] = {
 		.cmd		= HANDSHAKE_CMD_DONE,
 		.doit		= handshake_nl_done_doit,
 		.policy		= handshake_done_nl_policy,
-		.maxattr	= HANDSHAKE_A_DONE_REMOTE_AUTH,
+		.maxattr	= HANDSHAKE_A_DONE_RECORD_SIZE_LIMIT,
 		.flags		= GENL_CMD_CAP_DO,
 	},
 };
diff --git a/net/handshake/tlshd.c b/net/handshake/tlshd.c
index d6f52839827e..7cafac6cff1f 100644
--- a/net/handshake/tlshd.c
+++ b/net/handshake/tlshd.c
@@ -26,7 +26,8 @@
 
 struct tls_handshake_req {
 	void			(*th_consumer_done)(void *data, int status,
-						    key_serial_t peerid);
+						    key_serial_t peerid,
+						    size_t tls_record_size_limit);
 	void			*th_consumer_data;
 
 	int			th_type;
@@ -39,6 +40,8 @@ struct tls_handshake_req {
 
 	unsigned int		th_num_peerids;
 	key_serial_t		th_peerid[5];
+
+	size_t			record_size_limit;
 };
 
 static struct tls_handshake_req *
@@ -55,6 +58,7 @@ tls_handshake_req_init(struct handshake_req *req,
 	treq->th_num_peerids = 0;
 	treq->th_certificate = TLS_NO_CERT;
 	treq->th_privkey = TLS_NO_PRIVKEY;
+	treq->record_size_limit = TLS_NO_RECORD_SIZE_LIMIT;
 	return treq;
 }
 
@@ -83,6 +87,13 @@ static void tls_handshake_remote_peerids(struct tls_handshake_req *treq,
 		if (i >= treq->th_num_peerids)
 			break;
 	}
+
+	nla_for_each_attr(nla, head, len, rem) {
+		if (nla_type(nla) == HANDSHAKE_A_DONE_RECORD_SIZE_LIMIT) {
+			treq->record_size_limit = nla_get_u32(nla);
+			break;
+		}
+	}
 }
 
 /**
@@ -105,7 +116,7 @@ static void tls_handshake_done(struct handshake_req *req,
 		set_bit(HANDSHAKE_F_REQ_SESSION, &req->hr_flags);
 
 	treq->th_consumer_done(treq->th_consumer_data, -status,
-			       treq->th_peerid[0]);
+			       treq->th_peerid[0], treq->record_size_limit);
 }
 
 #if IS_ENABLED(CONFIG_KEYS)
diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index e1c85123b445..2014d906ff06 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -417,13 +417,15 @@ static void svc_tcp_kill_temp_xprt(struct svc_xprt *xprt)
  * @data: address of xprt to wake
  * @status: status of handshake
  * @peerid: serial number of key containing the remote peer's identity
+ * @tls_record_size_limit: Max tls_record_size_limit of the endpoint
  *
  * If a security policy is specified as an export option, we don't
  * have a specific export here to check. So we set a "TLS session
  * is present" flag on the xprt and let an upper layer enforce local
  * security policy.
  */
-static void svc_tcp_handshake_done(void *data, int status, key_serial_t peerid)
+static void svc_tcp_handshake_done(void *data, int status, key_serial_t peerid,
+				   size_t tls_record_size_limit)
 {
 	struct svc_xprt *xprt = data;
 	struct svc_sock *svsk = container_of(xprt, struct svc_sock, sk_xprt);
diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index 04ff66758fc3..509aa6269b0a 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -2569,9 +2569,11 @@ static int xs_tcp_tls_finish_connecting(struct rpc_xprt *lower_xprt,
  * @data: address of xprt to wake
  * @status: status of handshake
  * @peerid: serial number of key containing the remote's identity
+ * @tls_record_size_limit: Max tls_record_size_limit of the endpoint
  *
  */
-static void xs_tls_handshake_done(void *data, int status, key_serial_t peerid)
+static void xs_tls_handshake_done(void *data, int status, key_serial_t peerid,
+				  size_t tls_record_size_limit)
 {
 	struct rpc_xprt *lower_xprt = data;
 	struct sock_xprt *lower_transport =
-- 
2.50.1



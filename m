Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4636CA0EE0
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Aug 2025 05:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YlvxtVVZ+6JmXq5VcgRfeOHjy0BKkaatlQTyuC34hMk=; b=ThFKIWgg/8PWDo2m3zdLnFibfy
	SKfGir37o0wnQoQfjm8VznyIrKRVBOLs1wCL8hamhWday8Ay3WaDMrXVwxuS3XRlg/ohi6eArFlcU
	QQ/Qcfu5dsS8Qpr0lKmZoQ54p83+sJezd2Km08vOIamK0OiQv1jIXGaXl+bo1n3FQ9d72A/tCi3sa
	fDQ/ZSAZ48B3MW0ARnU8WyvRtCZVrGDzw6p82uba178qb5Qdf0Ey5nCU/pkTmWOUsi8qMSlRliqGl
	K0w0F0nbg4o8EZ2QCsmKEs3HklYtf5hFTOQKCmjhFmDYdJlbavor8rGhU36tZLAQWCS5KWq/oYDYr
	VmM/f4Rg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ummaC-00000001ScV-2feP;
	Fri, 15 Aug 2025 05:02:28 +0000
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ummaA-00000001Sc2-3HFU
	for linux-nvme@lists.infradead.org;
	Fri, 15 Aug 2025 05:02:27 +0000
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-24457fe9704so13211415ad.0
        for <linux-nvme@lists.infradead.org>; Thu, 14 Aug 2025 22:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755234146; x=1755838946; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YlvxtVVZ+6JmXq5VcgRfeOHjy0BKkaatlQTyuC34hMk=;
        b=lmdwkhfr2T3GmvjgU36X3XK/f6TWnq7NmJ1md5Q57XJrbG0yflceA9HTMAHLkzPMRA
         92LNTUSmzeZsuFZqHI+MNXaaSoo9uu7bRB0Z0K1DVnGVeSGOnCflIFIwJwqmJgBf/OEc
         +SDGzu0U+zWAzpcK4omGEKtPC26Kcfa8NRvKsZlQoUSYXGDa9BFyzPpEYHLnL+jWDJNj
         EhM9enEyRYs0sBA7eXBnAPfRnfwaGNLVi7NLfBXto+wav+wlUkbrOG+3pRftd+fOV8zL
         HBQXqVqGwPixC0sR9/epgsQRhLznuvOcb0/BgLsduIz39R3Uz2iLHuv51Kx7M1FBGWGx
         6OCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755234146; x=1755838946;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YlvxtVVZ+6JmXq5VcgRfeOHjy0BKkaatlQTyuC34hMk=;
        b=T7REbkiPm6i5yWsVDRfC/1HWzIPgiMNoqJRQgz1sJOHhlFQ9MI0yuclYhyl1M0guCM
         aDWdXFdVHu9Jvs4cOUVHum2bpYQhhN2lP7aw3BJ6XddLIgvLaSepI8Nyqsr/EB9gmCv3
         gRm31jngG5IfKKxPop0GIEtvwDhd25ReizAEtrecqS+Y19u9ZZnY7ymsEPb0JVsu5Pjm
         3zerYTdI5tAjCO0ltTjQi/ZcBacbXcaEZI10Nl9hFGmt2m2XCrfmovZXYHPHJxvNASrm
         tfq9tb7lL1BlnUg9uwQfWHjhYTZAqRG7Wa1hdBWHZCjEz9JR+MssO29GnRwwFooSsOsi
         f4uw==
X-Forwarded-Encrypted: i=1; AJvYcCV9qIds7+MdibSVROvitd85DTVK7D1diSerxuSwHUrho2nfFK9p5MkrhrgeMVg2OSrUr8IntcV7Yn+m@lists.infradead.org
X-Gm-Message-State: AOJu0YwoIAqQSLYwTbS+TwJ284ZaPlwBMjiFqC2FJP+a57R+p8rcFtrm
	CzLrIVVHOeRk+Y/Gq6XLz3vzVOY4fZUBAEeojYGbjdi8EvydzQmPMQlC
X-Gm-Gg: ASbGnctiusJpY06H+p6II5F9azIc9cfTtt6zogWb8RatMsHvwfv23mr5WuN3cDNSjNv
	5U6GLkYWjtrYeJedsRTeAXwrPxD6Jak7+XAKWLHTpRQO8MQpsDPXVnWtL9quVYUd+pQdz8OS8Sp
	KuvpT1/ZGYCm2mWavKyOiF/+4mQTS5dFByM39pt1FRP2GcH1QPnj/73DrZjyZWATaAmiOTg+Mio
	4dPNRShxjwKAL1sTDmuWU++LW6GSHxoMp3ALBUokG8qeMDrDPmufop6opefQre4WYpzEu0QqEZi
	77YunF4leerqV4Un8is0PZEWqPw2MMMsGw2tPzVx+uv6b9IEYp5qxkz6oEF5ymplqFAcL+V4Cbv
	TgW3AB1azpOHySFe/s9yhrj5Tg1OO9s056kSanJsmVrhx0ypqkmjlaCP3sU1jQg+halr2BUEgDI
	oEKN+mhfj5p47ymmshBTTa75DP2rc=
X-Google-Smtp-Source: AGHT+IE8mGbvy+6sKOh0dqJXKQL4DmlgJQqF7LsglNO7FAjrbB5jTqDzNJkN8SaS/kgbM9ijcYzpCw==
X-Received: by 2002:a17:902:d2ca:b0:243:a50:14bc with SMTP id d9443c01a7336-2446d980ee7mr12066745ad.55.1755234145832;
        Thu, 14 Aug 2025 22:02:25 -0700 (PDT)
Received: from toolbx.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d53c6e1sm5128645ad.115.2025.08.14.22.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 22:02:25 -0700 (PDT)
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
Subject: [PATCH 1/8] net/handshake: Store the key serial number on completion
Date: Fri, 15 Aug 2025 15:02:03 +1000
Message-ID: <20250815050210.1518439-2-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250815050210.1518439-1-alistair.francis@wdc.com>
References: <20250815050210.1518439-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250814_220226_826461_65CA28EB 
X-CRM114-Status: GOOD (  18.89  )
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

Allow userspace to include a key serial number when completing a
handshake with the HANDSHAKE_CMD_DONE command.

We then store this serial number and will provide it back to userspace
in the future. This allows userspace to save data to the keyring and
then restore that data later.

This will be used to support the TLS KeyUpdate operation, as now
userspace can resume information about a established session.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 Documentation/netlink/specs/handshake.yaml |  4 ++++
 drivers/nvme/host/tcp.c                    |  3 ++-
 drivers/nvme/target/tcp.c                  |  3 ++-
 include/net/handshake.h                    |  3 ++-
 include/uapi/linux/handshake.h             |  1 +
 net/handshake/genl.c                       |  5 +++--
 net/handshake/tlshd.c                      | 15 +++++++++++++--
 net/sunrpc/svcsock.c                       |  3 ++-
 net/sunrpc/xprtsock.c                      |  3 ++-
 9 files changed, 31 insertions(+), 9 deletions(-)

diff --git a/Documentation/netlink/specs/handshake.yaml b/Documentation/netlink/specs/handshake.yaml
index 95c3fade7a8d..e76b10ef62f2 100644
--- a/Documentation/netlink/specs/handshake.yaml
+++ b/Documentation/netlink/specs/handshake.yaml
@@ -87,6 +87,9 @@ attribute-sets:
         name: remote-auth
         type: u32
         multi-attr: true
+      -
+        name: key-serial
+        type: u32
 
 operations:
   list:
@@ -123,6 +126,7 @@ operations:
             - status
             - sockfd
             - remote-auth
+            - key-serial
 
 mcast-groups:
   list:
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index c0fe8cfb7229..bb7317a3f1a9 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1673,7 +1673,8 @@ static void nvme_tcp_set_queue_io_cpu(struct nvme_tcp_queue *queue)
 		qid, queue->io_cpu);
 }
 
-static void nvme_tcp_tls_done(void *data, int status, key_serial_t pskid)
+static void nvme_tcp_tls_done(void *data, int status, key_serial_t pskid,
+	key_serial_t user_key_serial)
 {
 	struct nvme_tcp_queue *queue = data;
 	struct nvme_tcp_ctrl *ctrl = queue->ctrl;
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 470bf37e5a63..93fce316267d 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1780,7 +1780,8 @@ static int nvmet_tcp_tls_key_lookup(struct nvmet_tcp_queue *queue,
 }
 
 static void nvmet_tcp_tls_handshake_done(void *data, int status,
-					 key_serial_t peerid)
+					 key_serial_t peerid,
+					 key_serial_t user_key_serial)
 {
 	struct nvmet_tcp_queue *queue = data;
 
diff --git a/include/net/handshake.h b/include/net/handshake.h
index 8ebd4f9ed26e..449bed8c2557 100644
--- a/include/net/handshake.h
+++ b/include/net/handshake.h
@@ -18,7 +18,8 @@ enum {
 };
 
 typedef void	(*tls_done_func_t)(void *data, int status,
-				   key_serial_t peerid);
+				   key_serial_t peerid,
+				   key_serial_t user_key_serial);
 
 struct tls_handshake_args {
 	struct socket		*ta_sock;
diff --git a/include/uapi/linux/handshake.h b/include/uapi/linux/handshake.h
index 662e7de46c54..46753116ba43 100644
--- a/include/uapi/linux/handshake.h
+++ b/include/uapi/linux/handshake.h
@@ -55,6 +55,7 @@ enum {
 	HANDSHAKE_A_DONE_STATUS = 1,
 	HANDSHAKE_A_DONE_SOCKFD,
 	HANDSHAKE_A_DONE_REMOTE_AUTH,
+	HANDSHAKE_A_DONE_KEY_SERIAL,
 
 	__HANDSHAKE_A_DONE_MAX,
 	HANDSHAKE_A_DONE_MAX = (__HANDSHAKE_A_DONE_MAX - 1)
diff --git a/net/handshake/genl.c b/net/handshake/genl.c
index f55d14d7b726..bf64323bb5e1 100644
--- a/net/handshake/genl.c
+++ b/net/handshake/genl.c
@@ -16,10 +16,11 @@ static const struct nla_policy handshake_accept_nl_policy[HANDSHAKE_A_ACCEPT_HAN
 };
 
 /* HANDSHAKE_CMD_DONE - do */
-static const struct nla_policy handshake_done_nl_policy[HANDSHAKE_A_DONE_REMOTE_AUTH + 1] = {
+static const struct nla_policy handshake_done_nl_policy[HANDSHAKE_A_DONE_KEY_SERIAL + 1] = {
 	[HANDSHAKE_A_DONE_STATUS] = { .type = NLA_U32, },
 	[HANDSHAKE_A_DONE_SOCKFD] = { .type = NLA_S32, },
 	[HANDSHAKE_A_DONE_REMOTE_AUTH] = { .type = NLA_U32, },
+	[HANDSHAKE_A_DONE_KEY_SERIAL] = { .type = NLA_U32, },
 };
 
 /* Ops table for handshake */
@@ -35,7 +36,7 @@ static const struct genl_split_ops handshake_nl_ops[] = {
 		.cmd		= HANDSHAKE_CMD_DONE,
 		.doit		= handshake_nl_done_doit,
 		.policy		= handshake_done_nl_policy,
-		.maxattr	= HANDSHAKE_A_DONE_REMOTE_AUTH,
+		.maxattr	= HANDSHAKE_A_DONE_KEY_SERIAL,
 		.flags		= GENL_CMD_CAP_DO,
 	},
 };
diff --git a/net/handshake/tlshd.c b/net/handshake/tlshd.c
index 081093dfd553..cb1ee8ebf2ea 100644
--- a/net/handshake/tlshd.c
+++ b/net/handshake/tlshd.c
@@ -26,7 +26,8 @@
 
 struct tls_handshake_req {
 	void			(*th_consumer_done)(void *data, int status,
-						    key_serial_t peerid);
+						    key_serial_t peerid,
+						    key_serial_t user_key_serial);
 	void			*th_consumer_data;
 
 	int			th_type;
@@ -39,6 +40,8 @@ struct tls_handshake_req {
 
 	unsigned int		th_num_peerids;
 	key_serial_t		th_peerid[5];
+
+	key_serial_t		user_key_serial;
 };
 
 static struct tls_handshake_req *
@@ -55,6 +58,7 @@ tls_handshake_req_init(struct handshake_req *req,
 	treq->th_num_peerids = 0;
 	treq->th_certificate = TLS_NO_CERT;
 	treq->th_privkey = TLS_NO_PRIVKEY;
+	treq->user_key_serial = TLS_NO_PRIVKEY;
 	return treq;
 }
 
@@ -83,6 +87,13 @@ static void tls_handshake_remote_peerids(struct tls_handshake_req *treq,
 		if (i >= treq->th_num_peerids)
 			break;
 	}
+
+	nla_for_each_attr(nla, head, len, rem) {
+		if (nla_type(nla) == HANDSHAKE_A_DONE_KEY_SERIAL) {
+			treq->user_key_serial = nla_get_u32(nla);
+			break;
+		}
+	}
 }
 
 /**
@@ -105,7 +116,7 @@ static void tls_handshake_done(struct handshake_req *req,
 		set_bit(HANDSHAKE_F_REQ_SESSION, &req->hr_flags);
 
 	treq->th_consumer_done(treq->th_consumer_data, -status,
-			       treq->th_peerid[0]);
+			       treq->th_peerid[0], treq->user_key_serial);
 }
 
 #if IS_ENABLED(CONFIG_KEYS)
diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index 46c156b121db..3a325d7f2049 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -423,7 +423,8 @@ static void svc_tcp_kill_temp_xprt(struct svc_xprt *xprt)
  * is present" flag on the xprt and let an upper layer enforce local
  * security policy.
  */
-static void svc_tcp_handshake_done(void *data, int status, key_serial_t peerid)
+static void svc_tcp_handshake_done(void *data, int status, key_serial_t peerid,
+				   key_serial_t user_key_serial)
 {
 	struct svc_xprt *xprt = data;
 	struct svc_sock *svsk = container_of(xprt, struct svc_sock, sk_xprt);
diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index c5f7bbf5775f..8edd095b3a40 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -2591,7 +2591,8 @@ static int xs_tcp_tls_finish_connecting(struct rpc_xprt *lower_xprt,
  * @peerid: serial number of key containing the remote's identity
  *
  */
-static void xs_tls_handshake_done(void *data, int status, key_serial_t peerid)
+static void xs_tls_handshake_done(void *data, int status, key_serial_t peerid,
+				  key_serial_t user_key_serial)
 {
 	struct rpc_xprt *lower_xprt = data;
 	struct sock_xprt *lower_transport =
-- 
2.50.1



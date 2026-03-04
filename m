Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 614F8EDEBFB
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Mar 2026 05:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rNcMxZGmsNob2hi70jSfSua0A2NVCjnuBqG6KRIu95c=; b=ElaR9XXsj7xvC1El1i6QROSYNs
	PLWDE7dTP0q46ENjHi2aLqHhpZLHXlQ3ovP+sW7Mq/JozPKiCg+Fx8mg3ej4FvQWOFaepPEIH9Q62
	tNUWYmVhPsxdFKaR4o4uFvJWDddvtvQyYS5W9L4Pv26lVISDzJZ3ClHRx23HNNb9s8V4EHoNHhp4M
	CR1ZjpPAyVQPUIA/8eOWFNxLSoZSQzEPJ7vMGzfTtbatHiY/KD314RI5zZJ906temycV5i/i/p7KE
	QW5q+f2cZFVJ3UuoT6+3Q5ZsKos22bqFhp7tPyXthn9tUIamr5oBwoQPRhuDH4/HG3VR4L0/IxKY0
	BMIL0VJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxeuk-0000000GTkH-2DWF;
	Wed, 04 Mar 2026 05:36:54 +0000
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxeuh-0000000GTjG-2zwp
	for linux-nvme@lists.infradead.org;
	Wed, 04 Mar 2026 05:36:53 +0000
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-3598b95ad7dso2245858a91.2
        for <linux-nvme@lists.infradead.org>; Tue, 03 Mar 2026 21:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772602611; x=1773207411; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rNcMxZGmsNob2hi70jSfSua0A2NVCjnuBqG6KRIu95c=;
        b=Z+PR/aoOX4OrB2zTSvF7q4hsWaKZyPtTbUTS+sUuqO13HC4j8LHWH1/cR4cEj5sjiq
         X7+aWYFFDGN+mygiJAq71YWYg/Qsw49cWKzindSZZAeKxA34emivb8gMFOhu49wi83ji
         juqHGg3awThjRqmWcuVPKFJ5/vKm3WXHnWKUoe8HPu+DIX+b0go0wa/D3L9m/8kPJ9k2
         kyAK/JqqBlz/bgGIsRvjfF2f3gVGlGaOqA/7E93qcQLXX/wr+rdjJzMYm35gFWxgr2il
         IRdaHUemCHUTy6h3gMbf5XSH2oPuk3O3dFN5/roXWHRs7qWGf9KvZZtb50+DlAM5Q1zk
         9pmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772602611; x=1773207411;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rNcMxZGmsNob2hi70jSfSua0A2NVCjnuBqG6KRIu95c=;
        b=edw3acEtPY7BlStNDarMsUw8QbidkmkyEW+5hfJCRVycQLtqClGKAvJcJIMt2AyMfr
         fO74cp6fWKkcWSyACCXKOzbtWd4DrsbKQ6BjIMqkNcUid7ZF2H6cB4zlITmsccgC2I5+
         MXlrCEHEIVBIIMVu3gtAQxdUDT8MoH37k86wMdg7mSFGfj1/xqMjSe1WLsnXW/xnIa5X
         357RlE4/p4cymT1TkuHwhhPSdzh3OPkZBhiifaHUXtI3AZSB89nGqE3LbSc317l0xSDp
         wvESYuBBn6V0HHq5uYcURsRnDGNJsIvMwm75zrInx4qAhH9a4nNkb8/Mz5XhelrDqcFR
         0TjA==
X-Forwarded-Encrypted: i=1; AJvYcCUA4+ZMS8elyc/M/SZkw4MtixBFuJagyiYLbHmvsl//Qt2YjqqdbmkqJqAfRhf+aqs2xyfnW6iiDgs9@lists.infradead.org
X-Gm-Message-State: AOJu0YwYNktaqlEKEQ5YJlQgzmbzylNdgXeJTZTUSjKpdVL8POInbUsk
	XKbEmCdE0WrjuZHAx8BjWVFa2ZbBm6NtyiBOfGLSMV53fFMPy2i5SzSS
X-Gm-Gg: ATEYQzzE0mV248wEI/HpFtXsTu8uT3E1NAIorprGHqt8SxC0gkubVtws6g/JaO9R+f8
	dSZ2+1y5/EPI1GkBeLeJar2Mz4yK1RX0DGkS+DCNS5QuUja613/vYhnTXtZPczqw+53I8Mzdloi
	wIJlXjN68mfrUBpTllsTddhmd3E30k266BKzczYP2uPwt96w3e1wgZY8AdR8pss/xQeYf5i2Dj6
	ni5R+yhFMgOA8W/hbtY8V37mvOYYIGYBFQOYPkb2+YnDFQxFawTlYASWtqD0DCnZF20kgVAfl0q
	nw5gwMdQfKlh0E0pcL6JG6otdt5KYjOlg+Utong3TfeNr7Opkspvppx/a9omoa8wF4r4GsSq4qy
	hB/+ze7HyYttdG4H/yBYR/qc2nS/zGsf4cKl/wZdQ7z0Xh8clBN65Vf65YriZI02Lp+BkwjvV8V
	Q82ZFiDFfzsQic3A5pZN5oFzFqQ+yYwMPE3MmZ7g2nzJolh3L0wKmf
X-Received: by 2002:a17:90b:3d83:b0:354:c629:efb2 with SMTP id 98e67ed59e1d1-359a6a563ddmr1057766a91.24.1772602611058;
        Tue, 03 Mar 2026 21:36:51 -0800 (PST)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3599c090bfdsm4020057a91.8.2026.03.03.21.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 21:36:50 -0800 (PST)
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
Subject: [PATCH v7 4/5] nvme-tcp: Support KeyUpdate
Date: Wed,  4 Mar 2026 15:34:59 +1000
Message-ID: <20260304053500.590630-5-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260304053500.590630-1-alistair.francis@wdc.com>
References: <20260304053500.590630-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260303_213651_761150_507101A1 
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

If the nvme_tcp_try_send() or nvme_tcp_try_recv() functions return
EKEYEXPIRED then the underlying TLS keys need to be updated. This occurs
on an KeyUpdate event as described in RFC8446
https://datatracker.ietf.org/doc/html/rfc8446#section-4.6.3.

If the NVMe Target (TLS server) initiates a KeyUpdate this patch will
allow the NVMe layer to process the KeyUpdate request and forward the
request to userspace. Userspace must then update the key to keep the
connection alive.

This patch allows us to handle the NVMe target sending a KeyUpdate
request without aborting the connection. At this time we don't support
initiating a KeyUpdate.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
v7:
 - Use read_sock_cmsg instead of recvmsg() to handle KeyUpdate
v6:
 - Don't use `struct nvme_tcp_hdr` to determine TLS_HANDSHAKE_KEYUPDATE,
   instead look at the cmsg fields.
 - Don't flush async_event_work
v5:
 - Cleanup code flow
 - Check for MSG_CTRUNC in the msg_flags return from recvmsg
   and use that to determine if it's a control message
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

 drivers/nvme/host/tcp.c | 59 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 58 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 8b6172dd1c0f..ade11d2ac9ef 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -171,6 +171,7 @@ struct nvme_tcp_queue {
 	bool			tls_enabled;
 	u32			rcv_crc;
 	u32			snd_crc;
+	key_serial_t		handshake_session_id;
 	__le32			exp_ddgst;
 	__le32			recv_ddgst;
 	struct completion       tls_complete;
@@ -1361,6 +1362,59 @@ static int nvme_tcp_try_send(struct nvme_tcp_queue *queue)
 	return ret;
 }
 
+static void update_tls_keys(struct nvme_tcp_queue *queue)
+{
+	int qid = nvme_tcp_queue_id(queue);
+	int ret;
+
+	dev_dbg(queue->ctrl->ctrl.device,
+		"updating key for queue %d\n", qid);
+
+	ret = nvme_tcp_start_tls(&(queue->ctrl->ctrl),
+				 queue, queue->ctrl->ctrl.tls_pskid,
+				 HANDSHAKE_KEY_UPDATE_TYPE_RECEIVED);
+
+	if (ret < 0) {
+		dev_err(queue->ctrl->ctrl.device,
+			"failed to update the keys %d\n", ret);
+		nvme_tcp_fail_request(queue->request);
+	}
+}
+
+static int nvme_tcp_recv_cmsg(read_descriptor_t *desc,
+			      struct sk_buff *skb,
+			      unsigned int offset, size_t len,
+			      u8 content_type)
+{
+	struct nvme_tcp_queue *queue = desc->arg.data;
+	struct socket *sock = queue->sock;
+	struct sock *sk = sock->sk;
+
+	switch (content_type) {
+	case TLS_RECORD_TYPE_HANDSHAKE:
+		if (len == 5) {
+			u8 header[5];
+
+			if (!skb_copy_bits(skb, offset, header,
+					   sizeof(header))) {
+				if (header[0] == TLS_HANDSHAKE_KEYUPDATE) {
+					dev_err(queue->ctrl->ctrl.device, "KeyUpdate message\n");
+					release_sock(sk);
+					update_tls_keys(queue);
+					lock_sock(sk);
+					return 0;
+				}
+			}
+		}
+
+		break;
+	default:
+		break;
+	}
+
+	return -EAGAIN;
+}
+
 static int nvme_tcp_try_recv(struct nvme_tcp_queue *queue)
 {
 	struct socket *sock = queue->sock;
@@ -1372,7 +1426,8 @@ static int nvme_tcp_try_recv(struct nvme_tcp_queue *queue)
 	rd_desc.count = 1;
 	lock_sock(sk);
 	queue->nr_cqe = 0;
-	consumed = sock->ops->read_sock(sk, &rd_desc, nvme_tcp_recv_skb);
+	consumed = sock->ops->read_sock_cmsg(sk, &rd_desc, nvme_tcp_recv_skb,
+					     nvme_tcp_recv_cmsg);
 	release_sock(sk);
 	return consumed == -EAGAIN ? 0 : consumed;
 }
@@ -1708,6 +1763,7 @@ static void nvme_tcp_tls_done(void *data, int status, key_serial_t pskid,
 			ctrl->ctrl.tls_pskid = key_serial(tls_key);
 		key_put(tls_key);
 		queue->tls_err = 0;
+		queue->handshake_session_id = handshake_session_id;
 	}
 
 out_complete:
@@ -1737,6 +1793,7 @@ static int nvme_tcp_start_tls(struct nvme_ctrl *nctrl,
 		keyring = key_serial(nctrl->opts->keyring);
 	args.ta_keyring = keyring;
 	args.ta_timeout_ms = tls_handshake_timeout * 1000;
+	args.ta_handshake_session_id = queue->handshake_session_id;
 	queue->tls_err = -EOPNOTSUPP;
 	init_completion(&queue->tls_complete);
 	if (keyupdate == HANDSHAKE_KEY_UPDATE_TYPE_UNSPEC)
-- 
2.53.0


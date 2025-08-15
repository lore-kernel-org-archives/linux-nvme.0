Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED907CA0EE0
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Aug 2025 05:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=neDuK8ZnEoxPuomsrzouDeck0u2jESUqvyfxmr3mZPY=; b=tEkFiHbd0OnFYUdn81OibvvLOo
	b2WY9rM2aMeEu4NVIr63bj0S88X7pbAGjQOKREuqEucwL8OKWYmwgzEYUPMdwAsJkFWkmqcGTAKsh
	UyBXYb5xGBakvem/eMH6UwjjBtdHaOM1pgBweO7ntee6dw/+f2s1zEXN1Dv7mRKisLna0csR5pIap
	cxp4qdsxFKPObOlkoZz5Yp7vHR5XMcQ0O/Q3cvgmKxzZRxyC3teOmNPvjw3pDNVrZnjMia/Xy7f1h
	H7T6VnHlcqiEIDCG0ImU2pKyEnqCeVg0QGXvpLuucQZBGAf18tLZgfN77AC8yb651UaUuiIderR6g
	ADZBDRGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ummag-00000001Su6-0fXJ;
	Fri, 15 Aug 2025 05:02:58 +0000
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ummad-00000001Ss7-0sra
	for linux-nvme@lists.infradead.org;
	Fri, 15 Aug 2025 05:02:56 +0000
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-2445824dc27so15865245ad.3
        for <linux-nvme@lists.infradead.org>; Thu, 14 Aug 2025 22:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755234174; x=1755838974; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=neDuK8ZnEoxPuomsrzouDeck0u2jESUqvyfxmr3mZPY=;
        b=m/a+OVc5f78qX5v1erTzFQ2Yv6+eu05nPoAUTUzaAKdAWqU/yJS5h6qpA7Ubu5F1md
         OmYyC1FHob/6AAzA0rq7Ttfp7lsOauLbtpU7qt8DB7yuxEVaEl4ef8WWGqiOaXHUTaKh
         tuEBm9NQCHFhbPUP7PcmpT457o64YjCPSkQ1FCRNyklhBbY4vLTbe3zXTpFMINGU1KUA
         y0WJMt+rR1+xbB9FCcr2a8W7EgegI21wMgiRNL+6VwKJuBh6BthgAqKc5v4JZYh6pfWn
         X4n4EgqY6euPz8OyABsoCBlVGOVf+7xNKU1KnM6CV77oZpiJADS0Vnaqz0VxcLTynT/O
         58wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755234174; x=1755838974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=neDuK8ZnEoxPuomsrzouDeck0u2jESUqvyfxmr3mZPY=;
        b=OJXDL+G4m9L6ueUrFC0xOl7wgN8EK/8gxzV7p26ko/nusSyPtVPtWsjRV+BEAqjDpJ
         YBDSOzzH0V2jJxdtkUvIVpBe6H2MXZrawoYkftCxScMtj32a/Q1ZUKEkBK2jV1gvJhcQ
         7rPzGZF/Nzxg0vIsK7Cs+/FGT9bhzld3DUyn7nZAVKTrsltWRWAZAxCG8RAhkuBrmuNH
         kWGUBsUeGOPoUy8HAhwXc0yWMXTRXo8AiFVDNPpQV4yhgtFSmHyP/WDFbSCv11t4+NlY
         io/G9UPFyRg3BQkurux/givzNkVHU1cX0x/zbHLRQLd2dVwvNdZxd+d8arI9uupaFZU9
         CcEw==
X-Forwarded-Encrypted: i=1; AJvYcCXHYcoy0b8alz3krQ8vK9fLWfrBXKQWjqeK0Z/QGXNiGEEN3nPe6/meZh8Q4Y+hFa+xkzqBoRI4Si4x@lists.infradead.org
X-Gm-Message-State: AOJu0YyM7S9jYM4mnfbhi7bx1ulnmn1gYexr/6ewJsG9iJjgw4fb0AxF
	jzIw3ff5K2/I4/QglgwN0eOsIn+7+BvZVDZqTS9cziGIFiIHnpEkHV13
X-Gm-Gg: ASbGnct/N9oHzbDoJWyuy0flU/dMqKWD+5qXWY3r6RjKN9NrQnVPugpHaNgPz3iI6O9
	lcaJCTNg2wzF37cpd4R3DYy+N5p48wXMnTatSXN6FriGa7k2JCa0W48BW39dGC3TA6TbOHcplqN
	acGI5X+W9apAhDQFe0kSLf4EsQTLGdd4hTwx9uiqdEuhB9y2gIgw/p2DrbfrecU3Wnv8zVAm8As
	nfcgO185WbneisdmBRBj+JY2cEAZfFnnRjzHww2msQ7InM9YOvhGSnw/7t6KFPxlIBo0/bnEKZd
	rv7Wdl0AkeiEaU1Z8hzplIc8SPDcOCQrmqysGJ2cNzVJYsMmwi0c0d0Kqi9+GP0YvFErxM9Qf/G
	IqlXueXLGnYjpRHuDyaNaFzcFkjyw9YNCuVX8tHFn3mAvIXwGWe0DlNIeiKE0Ujam075k9V6kcb
	wLAhHxcXl9w2NH7QXnnH365Vl9HXY=
X-Google-Smtp-Source: AGHT+IG8imeIhOp6Kh+mvcy3i3tVkeltm9bQmEjxAgXG7n6od8szlHMMpip15QOuUZGKPgir+jkAGg==
X-Received: by 2002:a17:902:e74b:b0:240:70d4:85d9 with SMTP id d9443c01a7336-2446cba36cbmr13771535ad.0.1755234174437;
        Thu, 14 Aug 2025 22:02:54 -0700 (PDT)
Received: from toolbx.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d53c6e1sm5128645ad.115.2025.08.14.22.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 22:02:54 -0700 (PDT)
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
Subject: [PATCH 6/8] nvme-tcp: Support KeyUpdate
Date: Fri, 15 Aug 2025 15:02:08 +1000
Message-ID: <20250815050210.1518439-7-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250815050210.1518439-1-alistair.francis@wdc.com>
References: <20250815050210.1518439-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250814_220255_255653_90519807 
X-CRM114-Status: GOOD (  21.26  )
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
 drivers/nvme/host/tcp.c | 63 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 62 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index cc3332529355..0c14d3ad58af 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -171,6 +171,7 @@ struct nvme_tcp_queue {
 	bool			tls_enabled;
 	u32			rcv_crc;
 	u32			snd_crc;
+	key_serial_t		user_key_serial;
 	__le32			exp_ddgst;
 	__le32			recv_ddgst;
 	struct completion       tls_complete;
@@ -1313,6 +1314,7 @@ static int nvme_tcp_try_send(struct nvme_tcp_queue *queue)
 	struct nvme_tcp_request *req;
 	unsigned int noreclaim_flag;
 	int ret = 1;
+	enum nvme_ctrl_state state = nvme_ctrl_state(&(queue->ctrl->ctrl));
 
 	if (!queue->request) {
 		queue->request = nvme_tcp_fetch_request(queue);
@@ -1347,6 +1349,29 @@ static int nvme_tcp_try_send(struct nvme_tcp_queue *queue)
 done:
 	if (ret == -EAGAIN) {
 		ret = 0;
+	} else if (ret == -EKEYEXPIRED &&
+		state != NVME_CTRL_CONNECTING &&
+		state != NVME_CTRL_RESETTING) {
+		int qid = nvme_tcp_queue_id(queue);
+
+		dev_dbg(queue->ctrl->ctrl.device,
+			"updating key for queue %d\n", qid);
+
+		nvme_change_ctrl_state(&(queue->ctrl->ctrl), NVME_CTRL_RESETTING);
+		tls_clear_err(queue->sock->sk);
+		handshake_req_cancel(queue->sock->sk);
+		handshake_sk_destruct_req(queue->sock->sk);
+
+		ret = nvme_tcp_start_tls(&(queue->ctrl->ctrl),
+					 queue, queue->ctrl->ctrl.tls_pskid,
+					 HANDSHAKE_KEY_UPDATE_TYPE_RECEIVED);
+
+		if (ret < 0) {
+			dev_err(queue->ctrl->ctrl.device,
+				"failed to update the keys %d\n", ret);
+			nvme_tcp_fail_request(queue->request);
+			nvme_tcp_done_send_req(queue);
+		}
 	} else if (ret < 0) {
 		dev_err(queue->ctrl->ctrl.device,
 			"failed to send request %d\n", ret);
@@ -1383,6 +1408,7 @@ static void nvme_tcp_io_work(struct work_struct *w)
 	do {
 		bool pending = false;
 		int result;
+		enum nvme_ctrl_state state = nvme_ctrl_state(&(queue->ctrl->ctrl));
 
 		if (mutex_trylock(&queue->send_mutex)) {
 			result = nvme_tcp_try_send(queue);
@@ -1396,8 +1422,34 @@ static void nvme_tcp_io_work(struct work_struct *w)
 		result = nvme_tcp_try_recv(queue);
 		if (result > 0)
 			pending = true;
-		else if (unlikely(result < 0))
+		else if (unlikely(result < 0)) {
+			if (result == -EKEYEXPIRED &&
+				state != NVME_CTRL_CONNECTING &&
+				state != NVME_CTRL_RESETTING) {
+				int qid = nvme_tcp_queue_id(queue);
+
+				dev_dbg(queue->ctrl->ctrl.device,
+					"updating key for queue %d\n", qid);
+
+				nvme_change_ctrl_state(&(queue->ctrl->ctrl), NVME_CTRL_RESETTING);
+				tls_clear_err(queue->sock->sk);
+				handshake_req_cancel(queue->sock->sk);
+				handshake_sk_destruct_req(queue->sock->sk);
+
+				result = nvme_tcp_start_tls(&(queue->ctrl->ctrl),
+							queue, queue->ctrl->ctrl.tls_pskid,
+							HANDSHAKE_KEY_UPDATE_TYPE_RECEIVED);
+
+				if (result < 0) {
+					dev_err(queue->ctrl->ctrl.device,
+						"failed to update the keys %d\n", result);
+					nvme_tcp_fail_request(queue->request);
+					nvme_tcp_done_send_req(queue);
+				}
+			}
+
 			return;
+		}
 
 		/* did we get some space after spending time in recv? */
 		if (nvme_tcp_queue_has_pending(queue) &&
@@ -1705,6 +1757,7 @@ static void nvme_tcp_tls_done(void *data, int status, key_serial_t pskid,
 			ctrl->ctrl.tls_pskid = key_serial(tls_key);
 		key_put(tls_key);
 		queue->tls_err = 0;
+		queue->user_key_serial = user_key_serial;
 	}
 
 out_complete:
@@ -1734,6 +1787,7 @@ static int nvme_tcp_start_tls(struct nvme_ctrl *nctrl,
 		keyring = key_serial(nctrl->opts->keyring);
 	args.ta_keyring = keyring;
 	args.ta_timeout_ms = tls_handshake_timeout * 1000;
+	args.user_key_serial = queue->user_key_serial;
 	queue->tls_err = -EOPNOTSUPP;
 	init_completion(&queue->tls_complete);
 	ret = tls_client_hello_psk(&args, GFP_KERNEL, keyupdate);
@@ -1742,7 +1796,14 @@ static int nvme_tcp_start_tls(struct nvme_ctrl *nctrl,
 			qid, ret);
 		return ret;
 	}
+	if (keyupdate) {
+		dev_dbg(nctrl->device,
+			"queue %d: TLS keyupdate complete\n", qid);
+		return 0;
+	}
+
 	ret = wait_for_completion_interruptible_timeout(&queue->tls_complete, tmo);
+
 	if (ret <= 0) {
 		if (ret == 0)
 			ret = -ETIMEDOUT;
-- 
2.50.1



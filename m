Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16D17CCA470
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Oct 2025 04:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iUt0lx1wZ3OyjfIx3eBQc3LazcDXGlUQf7VsPfo32Ig=; b=fYkBdBFxWCB2BH+j9eK5scQ+iI
	T2mU8PWGqdnNuybTh4OWkH5CIRDLMJ9Eq+c8e46Sw5TlnxhHaOklZ9f6bJkTnGchLF3p7xCvNPqsz
	JAnpHjtJscwpH2d62ZnwYaC5KovQW85vXLloF+2Q+5MlMVHtrD/HJImjn38YUuck4wsfhVfYVPMua
	dfQNTlmBUm3yd8NwyXJqtfkQDGVDjBEsu2p3Nd1fnb1VU137wIy/TyFgtG8WDpCPefc4xgHAyxxnW
	SdMggnT/BIkiDaNeRA2MIA8HSGM0e/Jb2pExxFZMXPHIoKWeVQUBLFaTEm5rSlXCPxcQjrYucKq9V
	n8t2gXQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v4XTK-0000000Be76-0vDN;
	Fri, 03 Oct 2025 04:32:46 +0000
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v4XTH-0000000Be4h-3uok
	for linux-nvme@lists.infradead.org;
	Fri, 03 Oct 2025 04:32:45 +0000
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-32df5cae0b1so2484071a91.2
        for <linux-nvme@lists.infradead.org>; Thu, 02 Oct 2025 21:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759465963; x=1760070763; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iUt0lx1wZ3OyjfIx3eBQc3LazcDXGlUQf7VsPfo32Ig=;
        b=k5N8OCLx2UfKN34XQDaMGQ0QJPv7XpwA1IV8PhDvFLKYueif+OLC0USMrELLVRA+no
         XoxFe3Sn+XUXQ22n0+iVQLscV8A8AFtB09aUFDSm77FFnwPtNFQz5+S4cpFvInwn9o31
         8HRJ2afeBHbbxsmlJ6/gDHJjIb75v3igO0a5nkhERvWGNzyXJIWkF0k4z3S/VsZG4ge+
         hM9lj5YUmptNNJfjw2PzEkWv2znv1tZ5PNGPwjicXPrZZ1jZqhLOLKwbqM/L4dGp3gpX
         IuaRzJbjg7UQXZfqjIjKlZDsDgElkCtNBUJ/9zCRu7oa5dQuiBtMkcvg+oCXqtWqkAmw
         RJ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759465963; x=1760070763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iUt0lx1wZ3OyjfIx3eBQc3LazcDXGlUQf7VsPfo32Ig=;
        b=dkJ4rFgDBPKADvdL9YhQhCsNkBt8aMqFfiKvnkJ1lpQc/3sBD1xKf18DWzR9HFC7QX
         keJ357ksVJg0JgUittcvjahZRVfg0VbnM+41L/a2hkH0kymZtm7q3Fgm21rcvAu/JIAq
         bJGjAe9XzT0fHy4xZM+WlpBQYGWkPFbKHbRJ1dHcUUU/K/AsiJTbkv3aKi1jasJoHKYB
         0XpOkmKvtPTxkxEWPpIV5hqPBzApIZXqFmr0Y0DdHcS3OZirNE51WezfvfVqMx/YQX03
         ShnxL8Np408hLvK2ZftuVHCwCciLoDTDc4PT9B1MDdKbkeAFDVK9S67RpK4CfrWXLMX6
         pdKA==
X-Forwarded-Encrypted: i=1; AJvYcCVS/P8iwWGln9wjAnlpA2HDJlXX67WXkancRC866sgbNBEAc9+XLCofYQkRQBAgux3OEO9EIU7kPl4q@lists.infradead.org
X-Gm-Message-State: AOJu0Yx/iVgO0sCauT5ZTfZkxyRy6ITxN4/FYFJMYuPOYvylOUb5lgER
	KO8mQrI3+6Z3BOwNGfO/PMAVGtIqHp2u8Y8DQ3K8OkeHt0hJBkFrUwlk
X-Gm-Gg: ASbGncuOtC4iSmp4QNpmlOvgFVXcHYh17edtO/hfrAdNvb6r8WQAO6zC7jGsGWv2fJz
	//syLMeETq1RM+oAXTtwiY+qhdPnpf7qzoEEy2fXzxD4w8eyE3avYfZ68zYX1IpHCd8FKE2MkPY
	qs7QdzPv0tQkNOdhVa8fgiGgJGDHo0wvmWASFl1PSxnAuEVz32FPODIPlV5IW5l/emkphS1TjZ6
	nC0wbNYY68XiDr2Zz/cpQXEt9gCJxIhnMO+8Z+xxjxNlheWOdpZkaIRI0QYGnR98J6YGaZWRQQS
	UrZhZekyRu29zdHNZj8z1VACfQrre25DO6M5w97F7d926lRrxbV21uztfBdAC5Hrn4Yjm76mBB7
	SUfIZkyT20K8n/SWUdIzkT2Gf2oIVn3nBWBDnu1BIrx94vWgPriSwIMmVFfy6JL0u2UISJeI4J5
	FD+SBPlFI1XnOqjhYK6HF+RPlRgq60qwCPA71zQ13YbxMb1zwigxNg
X-Google-Smtp-Source: AGHT+IGhaBIUtKtuD6q+A3yD/rdltrPoLDs9xzkO82sKW85fbk3aQyiXoU7SizhTuE7KWD6NguZsNA==
X-Received: by 2002:a17:90b:17cf:b0:32e:d011:ea1c with SMTP id 98e67ed59e1d1-339c274fd63mr2279693a91.15.1759465963241;
        Thu, 02 Oct 2025 21:32:43 -0700 (PDT)
Received: from toolbx.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339a701c457sm6528233a91.23.2025.10.02.21.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 21:32:42 -0700 (PDT)
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
Subject: [PATCH v3 6/8] nvme-tcp: Support KeyUpdate
Date: Fri,  3 Oct 2025 14:31:37 +1000
Message-ID: <20251003043140.1341958-7-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251003043140.1341958-1-alistair.francis@wdc.com>
References: <20251003043140.1341958-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251002_213243_976989_620E1905 
X-CRM114-Status: GOOD (  22.31  )
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
v3:
 - Don't cancel existing handshake requests
v2:
 - Don't change the state
 - Use a helper function for KeyUpdates
 - Continue sending in nvme_tcp_send_all() after a KeyUpdate
 - Remove command message using recvmsg

 drivers/nvme/host/tcp.c | 60 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 54 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index b07401ad68eb..4f27319f0078 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -172,6 +172,7 @@ struct nvme_tcp_queue {
 	bool			tls_enabled;
 	u32			rcv_crc;
 	u32			snd_crc;
+	key_serial_t		user_session_id;
 	__le32			exp_ddgst;
 	__le32			recv_ddgst;
 	struct completion       tls_complete;
@@ -211,6 +212,7 @@ static int nvme_tcp_start_tls(struct nvme_ctrl *nctrl,
 			      struct nvme_tcp_queue *queue,
 			      key_serial_t pskid,
 			      handshake_key_update_type keyupdate);
+static void update_tls_keys(struct nvme_tcp_queue *queue);
 
 static inline struct nvme_tcp_ctrl *to_tcp_ctrl(struct nvme_ctrl *ctrl)
 {
@@ -394,6 +396,14 @@ static inline void nvme_tcp_send_all(struct nvme_tcp_queue *queue)
 	do {
 		ret = nvme_tcp_try_send(queue);
 	} while (ret > 0);
+
+	if (ret == -EKEYEXPIRED) {
+		update_tls_keys(queue);
+
+		do {
+			ret = nvme_tcp_try_send(queue);
+		} while (ret > 0);
+	}
 }
 
 static inline bool nvme_tcp_queue_has_pending(struct nvme_tcp_queue *queue)
@@ -1346,6 +1356,8 @@ static int nvme_tcp_try_send(struct nvme_tcp_queue *queue)
 done:
 	if (ret == -EAGAIN) {
 		ret = 0;
+	} else if (ret == -EKEYEXPIRED) {
+		goto out;
 	} else if (ret < 0) {
 		dev_err(queue->ctrl->ctrl.device,
 			"failed to send request %d\n", ret);
@@ -1381,17 +1393,45 @@ static int nvme_tcp_try_recvmsg(struct nvme_tcp_queue *queue)
 		}
 	} while (result >= 0);
 
-	if (result < 0 && result != -EAGAIN) {
+	if (result == -EKEYEXPIRED) {
+		return -EKEYEXPIRED;
+	} else if (result == -EAGAIN) {
+		result = 0;
+	} else if (result < 0) {
 		dev_err(queue->ctrl->ctrl.device,
 			"receive failed:  %d\n", result);
 		queue->rd_enabled = false;
 		nvme_tcp_error_recovery(&queue->ctrl->ctrl);
-	} else if (result == -EAGAIN)
-		result = 0;
+	}
 
 	return result < 0 ? result : (queue->nr_cqe = nr_cqe);
 }
 
+static void update_tls_keys(struct nvme_tcp_queue *queue)
+{
+	int qid = nvme_tcp_queue_id(queue);
+	int ret;
+
+	dev_dbg(queue->ctrl->ctrl.device,
+		"updating key for queue %d\n", qid);
+
+	cancel_work(&queue->io_work);
+
+	nvme_stop_keep_alive(&(queue->ctrl->ctrl));
+	flush_work(&(queue->ctrl->ctrl).async_event_work);
+
+	ret = nvme_tcp_start_tls(&(queue->ctrl->ctrl),
+				 queue, queue->ctrl->ctrl.tls_pskid,
+				 HANDSHAKE_KEY_UPDATE_TYPE_RECEIVED);
+
+	if (ret < 0) {
+		dev_err(queue->ctrl->ctrl.device,
+			"failed to update the keys %d\n", ret);
+		nvme_tcp_fail_request(queue->request);
+		nvme_tcp_done_send_req(queue);
+	}
+}
+
 static void nvme_tcp_io_work(struct work_struct *w)
 {
 	struct nvme_tcp_queue *queue =
@@ -1407,15 +1447,21 @@ static void nvme_tcp_io_work(struct work_struct *w)
 			mutex_unlock(&queue->send_mutex);
 			if (result > 0)
 				pending = true;
-			else if (unlikely(result < 0))
+			else if (unlikely(result < 0)) {
+				if (result == -EKEYEXPIRED)
+					update_tls_keys(queue);
 				break;
+			}
 		}
 
 		result = nvme_tcp_try_recvmsg(queue);
 		if (result > 0)
 			pending = true;
-		else if (unlikely(result < 0))
-			return;
+		else if (unlikely(result < 0)) {
+			if (result == -EKEYEXPIRED)
+				update_tls_keys(queue);
+			break;
+		}
 
 		/* did we get some space after spending time in recv? */
 		if (nvme_tcp_queue_has_pending(queue) &&
@@ -1723,6 +1769,7 @@ static void nvme_tcp_tls_done(void *data, int status, key_serial_t pskid,
 			ctrl->ctrl.tls_pskid = key_serial(tls_key);
 		key_put(tls_key);
 		queue->tls_err = 0;
+		queue->user_session_id = user_session_id;
 	}
 
 out_complete:
@@ -1752,6 +1799,7 @@ static int nvme_tcp_start_tls(struct nvme_ctrl *nctrl,
 		keyring = key_serial(nctrl->opts->keyring);
 	args.ta_keyring = keyring;
 	args.ta_timeout_ms = tls_handshake_timeout * 1000;
+	args.user_session_id = queue->user_session_id;
 	queue->tls_err = -EOPNOTSUPP;
 	init_completion(&queue->tls_complete);
 	ret = tls_client_hello_psk(&args, GFP_KERNEL, keyupdate);
-- 
2.51.0



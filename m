Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ABC1CCF9F8
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Nov 2025 04:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M80qUNZc1XHsNmFVJZkZr4sttr+ksd9CwMk6Xp4mOs8=; b=KOjk26aw7W2E0L4fvfNyEzpOuD
	zOASd+SAiuKRJfT8LWLGzyIvaFMFnHGf916LO1gntCfddsiOZ/O+XfSahgmQX+fRovYbYGVaiQNVZ
	+0EVfAD1UnkYlyo1aJTi9Hg06qdpw/jYtDqo47vlFk/XbJT8raUn2VxdtBB4YSIZQBdlkzuBD+To0
	Noxvh9t7nKayyUB6mfnsd1YZ2PjIeBiGuBQuqLjZ1RK8jEjFiw+grFZne3MtUXw+mr8esQmjjM6M+
	RqFnaJRBQHFjIyH/7XvJd5yGQlr3MJGHj9VRtNw+7NZxNl/njOvkJFDVzH8wNqPLUekmcfZE1pXbM
	sudCr4OA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJ2TH-000000086gm-2fBE;
	Wed, 12 Nov 2025 04:28:39 +0000
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJ2TF-000000086fH-1jtS
	for linux-nvme@lists.infradead.org;
	Wed, 12 Nov 2025 04:28:38 +0000
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-3438231df5fso489649a91.2
        for <linux-nvme@lists.infradead.org>; Tue, 11 Nov 2025 20:28:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762921717; x=1763526517; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M80qUNZc1XHsNmFVJZkZr4sttr+ksd9CwMk6Xp4mOs8=;
        b=NBhHVL2Afm7/6wjcmBxLmrqIzdFozuu+x72uiz0w6zG+/ocyWae8NYqSfU30XeY6yM
         PeHZFzLUdgYZ2UbvhHOUGzwuHXd+BoIY8Sk+QYeF1LsTVTn6yuAzlwrsYbTEwXojJbsH
         p6LpGwCex5UN90Yglj6yfJ0KGQxFSsK7mXnAnpkcWzsA+87VJ+AW+NNXBWyRzzuMoeST
         DC2eMF2ndreuQsjLe96ym3f9w4rOx6ox35qLxGZP4G8X5NX0s+GZCrWc7KwrCGLm4Cn3
         bs6rTy2Md88aL0RLbMOOqVoRV3ArOSxedAZ4P2bn5h/AH1FrHdMRd8Maw4m+cSB5/SA6
         5w6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762921717; x=1763526517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M80qUNZc1XHsNmFVJZkZr4sttr+ksd9CwMk6Xp4mOs8=;
        b=rxdASD/uloDlfNiT7lzIvOYLBNPR9hI6Y3PTaICSXsY/W0HqFWW3q9iJbWF6IJpj0c
         in4HbxP50szLUxFIuVIBF/2SW92qy/QZBuWuA9O0m8JaoSOT9/+03WZz2T1CcqrQkpc0
         YtA7VH/zkZHdS/lfeGwpglzkds7hka0QSMC76sKPUfV4PBNkJqB20YGr6oFGXwGhdHk+
         7Iz1PH4JWq93QUSyCP/JspAzeCvRZXix3cP8xNa+1eAztaH8Sl8eBXyvch3doHYA2U9x
         94MeFqSf/nltk9REsS7uXbDqImjZdep/+fw/5Iplk9p9nmVOwIEdRhUN8QAilu38Ut8K
         kp8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWV5VvQiofB7gBRLWzKu4PUhZh+JntDbrAckGg7lt+UuEvTZ0zldp98+SF+Rq9FChS/fRvgDp8ig33/@lists.infradead.org
X-Gm-Message-State: AOJu0Yy6p/Na0bRJGnzHenz6RC1rPa/mphvBG3J3pFcWMJEC0VXxtHZa
	nSQdM/W+WU0lgtGKDJl/aUWN9dA1v+Zu2Ha3SMnpft3qSSDCEs3sXz63
X-Gm-Gg: ASbGncuXWixcRe4xKXqw9ycEx8KJeMi9jAlKQ+StebKopwCeGKVSAxsFvsSmugImKab
	5aL7xINvnOoNwvrwwiYrYGqmjjvQmaIhBH5dTApOKxYUlcnJdyD8zvRD99o4i1lxySBugS3Skqk
	V0cl5OLPddqxvkc6Q5iR8lr52h4rnPkjYNMgPvONQV8DoKpmp2PkD5CcwvPCoqmePwTrcJdmYl4
	dmL5R1mjQ0yjdUdR9xWBTB+afPqGQCslSHLcrw3siy7w7AgFTO6DFyDdTGfpYAFFxS5vvoXiXA0
	QTwi1z9DEd0MrLFxRrk95r7zyazX/mSdsAX3OFSzkPj2yz8VVe0X8qKQ/al7UECg7IckifIyfET
	ogMtwHoPKuOw65P86QvkY8mhNXYjE0MV1EKYFUMOIy9ApK/VuI5aqFqUvwU0ArP3Lge6T9KdQQ8
	4dM0qwuY8ZwAZ26crhTGDUE44mq6VPlwcOpnwyWz66rNce2rvQUxwOwbWCY0zEdqzVUe6Au940i
	OkR+CfwCUsB9HBstuTp
X-Google-Smtp-Source: AGHT+IH+yGIMkP+5jLWuv7dmVXtMrTOjJ9if6zSq3lOjXH0ncDd2BGvxBgxvOWF7qaIpKkGatI+aRA==
X-Received: by 2002:a17:90b:4c44:b0:32b:65e6:ec48 with SMTP id 98e67ed59e1d1-343dde0d055mr2061728a91.8.1762921716677;
        Tue, 11 Nov 2025 20:28:36 -0800 (PST)
Received: from toolbx.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-343e06fbc0dsm854681a91.2.2025.11.11.20.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 20:28:36 -0800 (PST)
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
Subject: [PATCH v5 5/6] nvme-tcp: Support KeyUpdate
Date: Wed, 12 Nov 2025 14:27:19 +1000
Message-ID: <20251112042720.3695972-6-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251112042720.3695972-1-alistair.francis@wdc.com>
References: <20251112042720.3695972-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251111_202837_468151_6FCEFD57 
X-CRM114-Status: GOOD (  25.17  )
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

 drivers/nvme/host/tcp.c | 85 +++++++++++++++++++++++++++++++++--------
 1 file changed, 70 insertions(+), 15 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 4797a4532b0d..5cec5a974bbf 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -172,6 +172,7 @@ struct nvme_tcp_queue {
 	bool			tls_enabled;
 	u32			rcv_crc;
 	u32			snd_crc;
+	key_serial_t		handshake_session_id;
 	__le32			exp_ddgst;
 	__le32			recv_ddgst;
 	struct completion       tls_complete;
@@ -858,7 +859,10 @@ static void nvme_tcp_handle_c2h_term(struct nvme_tcp_queue *queue,
 static int nvme_tcp_recvmsg_pdu(struct nvme_tcp_queue *queue)
 {
 	char *pdu = queue->pdu;
+	char cbuf[CMSG_LEN(sizeof(char))] = {};
 	struct msghdr msg = {
+		.msg_control = cbuf,
+		.msg_controllen = sizeof(cbuf),
 		.msg_flags = MSG_DONTWAIT,
 	};
 	struct kvec iov = {
@@ -873,12 +877,17 @@ static int nvme_tcp_recvmsg_pdu(struct nvme_tcp_queue *queue)
 	if (ret <= 0)
 		return ret;
 
+	hdr = queue->pdu;
+	if (hdr->type == TLS_HANDSHAKE_KEYUPDATE) {
+		dev_err(queue->ctrl->ctrl.device, "KeyUpdate message\n");
+		return 1;
+	}
+
 	queue->pdu_remaining -= ret;
 	queue->pdu_offset += ret;
 	if (queue->pdu_remaining)
 		return 0;
 
-	hdr = queue->pdu;
 	if (unlikely(hdr->hlen != sizeof(struct nvme_tcp_rsp_pdu))) {
 		if (!nvme_tcp_recv_pdu_supported(hdr->type))
 			goto unsupported_pdu;
@@ -944,6 +953,7 @@ static int nvme_tcp_recvmsg_data(struct nvme_tcp_queue *queue)
 	struct request *rq =
 		nvme_cid_to_rq(nvme_tcp_tagset(queue), pdu->command_id);
 	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
+	char cbuf[CMSG_LEN(sizeof(char))] = {};
 
 	if (nvme_tcp_recv_state(queue) != NVME_TCP_RECV_DATA)
 		return 0;
@@ -976,10 +986,26 @@ static int nvme_tcp_recvmsg_data(struct nvme_tcp_queue *queue)
 
 		ret = sock_recvmsg(queue->sock, &msg, msg.msg_flags);
 		if (ret < 0) {
-			dev_err(queue->ctrl->ctrl.device,
-				"queue %d failed to receive request %#x data",
-				nvme_tcp_queue_id(queue), rq->tag);
-			return ret;
+			/* If MSG_CTRUNC is set, it's a control message,
+			 * so let's read the control message.
+			 */
+			if (msg.msg_flags & MSG_CTRUNC) {
+				memset(&msg, 0, sizeof(msg));
+				msg.msg_flags = MSG_DONTWAIT;
+				msg.msg_control = cbuf;
+				msg.msg_controllen = sizeof(cbuf);
+
+				ret = sock_recvmsg(queue->sock, &msg, msg.msg_flags);
+			}
+
+			if (ret < 0) {
+				dev_dbg(queue->ctrl->ctrl.device,
+					"queue %d failed to receive request %#x data, %d",
+					nvme_tcp_queue_id(queue), rq->tag, ret);
+				return ret;
+			}
+
+			return 0;
 		}
 		if (queue->data_digest)
 			nvme_tcp_ddgst_calc(req, &queue->rcv_crc, ret);
@@ -1384,15 +1410,39 @@ static int nvme_tcp_try_recvmsg(struct nvme_tcp_queue *queue)
 		}
 	} while (result >= 0);
 
-	if (result < 0 && result != -EAGAIN) {
-		dev_err(queue->ctrl->ctrl.device,
-			"receive failed:  %d\n", result);
-		queue->rd_enabled = false;
-		nvme_tcp_error_recovery(&queue->ctrl->ctrl);
-	} else if (result == -EAGAIN)
-		result = 0;
+	if (result < 0) {
+		if (result != -EKEYEXPIRED && result != -EAGAIN) {
+			dev_err(queue->ctrl->ctrl.device,
+				"receive failed:  %d\n", result);
+			queue->rd_enabled = false;
+			nvme_tcp_error_recovery(&queue->ctrl->ctrl);
+		}
+		return result;
+	}
+
+	queue->nr_cqe = nr_cqe;
+	return nr_cqe;
+}
+
+static void update_tls_keys(struct nvme_tcp_queue *queue)
+{
+	int qid = nvme_tcp_queue_id(queue);
+	int ret;
+
+	dev_dbg(queue->ctrl->ctrl.device,
+		"updating key for queue %d\n", qid);
 
-	return result < 0 ? result : (queue->nr_cqe = nr_cqe);
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
+	}
 }
 
 static void nvme_tcp_io_work(struct work_struct *w)
@@ -1417,8 +1467,11 @@ static void nvme_tcp_io_work(struct work_struct *w)
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
@@ -1726,6 +1779,7 @@ static void nvme_tcp_tls_done(void *data, int status, key_serial_t pskid,
 			ctrl->ctrl.tls_pskid = key_serial(tls_key);
 		key_put(tls_key);
 		queue->tls_err = 0;
+		queue->handshake_session_id = handshake_session_id;
 	}
 
 out_complete:
@@ -1755,6 +1809,7 @@ static int nvme_tcp_start_tls(struct nvme_ctrl *nctrl,
 		keyring = key_serial(nctrl->opts->keyring);
 	args.ta_keyring = keyring;
 	args.ta_timeout_ms = tls_handshake_timeout * 1000;
+	args.handshake_session_id = queue->handshake_session_id;
 	queue->tls_err = -EOPNOTSUPP;
 	init_completion(&queue->tls_complete);
 	if (keyupdate == HANDSHAKE_KEY_UPDATE_TYPE_UNSPEC)
-- 
2.51.1



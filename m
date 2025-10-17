Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D849CCD199
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Oct 2025 04:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=H/JQ/MpeHG5sNknRkM9q2VtRpwwB6bENwljP0w05Adc=; b=Vtt+ifIqvLCzN4Fn9vxRS0+Mea
	C8c3bANPHogh2ZykZeVlCzaMwghSORtsRfjIPzhN4iqrDI/ZvbzO8aO/00ZC/gtA95p9FZdSOi2sj
	+iMzkXeUbrjwd+LkZkmyFfc3gL7VEX3D/rGLTmPs9Rw+MvQcSovhJGmDci3CN32Bej0EHxp8JH6bp
	0AThyG4Yy+/KuobZ8xhK0KaLDIn1m4qnk53xzVSjPrT/woTHGW8IUDnN8zL2giKxyfELb6IakraJr
	MXgddAL6tSmyVGEWQlnNNBmtomu7sAp657g7THJLp3pNTuY6gGpJTodQBI7Gp13gknccadBy9+Abw
	Bl0SSrZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v9c1r-00000006Wo5-1pyM;
	Fri, 17 Oct 2025 04:25:23 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v9c1q-00000006Wlw-1Io8
	for linux-nvme@bombadil.infradead.org;
	Fri, 17 Oct 2025 04:25:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=H/JQ/MpeHG5sNknRkM9q2VtRpwwB6bENwljP0w05Adc=; b=R1LM7U2u8qQMD66ouBPd4Zw1mt
	809dG3ikmqwLHKjFiAD8yBns+xWrRD5+LIdRwjXdbRzPP+PP0vMwBvRoEIsN05qke9NIamTT0NUti
	Vr2LsZJzi1QxQFPtfngEhtfjt8gh/tO5egdLHbtSIiHU/po9d13WgD8FDPpBQzp0XjXoD5Dzs0Xa+
	oQdYNluim5KCJM48AzHxeqBxTKrtkw1bfTsJmbkckTk+SZf/qY1K0r0kHy45wU02q/l0s0uols4vC
	xCmRfIXuOSEnb4G/bjmV5Swgxmw9Pwa8UeJiPtDN5BBPDc3SIR6wHekeEspe4OSMfwEla8WzztC0g
	bK02dwyQ==;
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v9c0x-00000007Hcl-3Zsx
	for linux-nvme@lists.infradead.org;
	Fri, 17 Oct 2025 04:25:14 +0000
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-781db5068b8so1275143b3a.0
        for <linux-nvme@lists.infradead.org>; Thu, 16 Oct 2025 21:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760675055; x=1761279855; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H/JQ/MpeHG5sNknRkM9q2VtRpwwB6bENwljP0w05Adc=;
        b=UHXm1qEQByXMel0bwNbIyN++sD+B9XmPqOnuWLW6jVg+D6LWOk4p4p3pAe6rzRtg/0
         8tNlkIt/gNAj/o6sauott5AO9Vgm3sxhwjK5xjSz+KNLRDadFuZQ8X0bfGikW2c4PHCE
         p6TKi0DoE43giFfi3UbdpWzEsQf9TVXYCen2wFIcDphh8y8utMaxCYCFQ0OKbqIGadRE
         5VhcreJtwrFjyR7Ez2uE/UyERn8NQAHK1NradiJ0OfmFM3QWjeTZXQi2IJ123w8c3ZfK
         vSxHpgSkwNz7AAIHBaLFrRATKgfJyanfSwo+m7ed92WZwnYiKEBXE4t+lYCiWSSKDHSu
         CD0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760675055; x=1761279855;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H/JQ/MpeHG5sNknRkM9q2VtRpwwB6bENwljP0w05Adc=;
        b=h1qmo4eCWNEY49IaecPxUTynqs+gGmO5P85kG4zKn/ekFnfuJUFK919d+aOWMBvLwv
         T3yf8iotGxq20K6fA3O/7DrLcPUhUxCTAgiYT9TqH+ZQ28sTFlRqb3RiLlhiWSJYQ5Sz
         5Ddvk1xTLUnkYypKDzInE8UahIrY+76i2LxkgAT+Z7t9Jtf6OOM2olA3NZdLSpukpvqT
         4ApBpVLNmJfbC1YSo3Pq0wNGmWo2B2JskLH/edlMShNOO2Sny9sb6yfQZocFyJG1AEKJ
         hI9wW4ADSLvJqybykxySszAhgywbcnxDF3GzdH1JTT0Z9mqCGHzx88Vjb53XClo3p7YF
         HOcA==
X-Forwarded-Encrypted: i=1; AJvYcCX+9XW1eVtz0Z1t2xM6lY+XWvrl60cgdyfZyGagqJYhSAdQU04kri7FORH8lj0E+qamWP41yUjeqyos@lists.infradead.org
X-Gm-Message-State: AOJu0YzwjCoHJVoxRqgKNOj0AHkIkhgfIs9i1cftLAxgpXoN6uNVSZJs
	rcaSvJ4E2RH9zowr7QrDBWPWP7G67HYqFgMvZ2ipzh9k5bAN6anuish2
X-Gm-Gg: ASbGncscMpKsJHvCkleiTKTq1aw9bovFYc3+r9a4LkvdCok0I77Acgjdu81/s2SLClY
	FfnqvTMyA06UTj2IvL+9U7CXOAXbqkfuilK+C3A6iNfD/TABhnfnPqRWlNufEODA9AyACkRnJwH
	trSxww6Zxy2SToOKAzfEJ5q+asECIk16dt2yK+9XYYXy1KBX7urEUs46DZZGO69j+Hpoj1Hxxj9
	wrjIfU64fVT5H/+ANPOzrFnVKwqDSyo53X8WjX03FeP9oIViJu2IGjeAI1X1sH3CUkfZpdHhbzJ
	9wUgbBMrDjcBVzJs7O9VXdkAk9HppgbvNUBs7tKZvM0LkDyl6Sn9xJbHB57hAI4x2RRL30/Z1W8
	JOIvIUbUroX8g9FciCXfFRILqJgz2j7aGOa2njCbNXDQwLcEsGfe+yfL4N6N8W8A4vH6pK7DemV
	cEdbkIYOW8/9AlD3gMSh03KxokdFmZGWImPLYh8WF7fWONcG6t4bOsNsO4RVA2Jal4tm51k/g/y
	fGYcNP6t/MvydASJV/l
X-Google-Smtp-Source: AGHT+IHyaWxT0M6jcSDOPiAWWc/zLGVBhm66Pbmfou5gKKgW6rFVAYlwZs/wPGPlImKOfJEIkfaYVg==
X-Received: by 2002:a17:90b:1d88:b0:32e:a8b7:e9c with SMTP id 98e67ed59e1d1-33bcf90c003mr2038589a91.29.1760675054825;
        Thu, 16 Oct 2025 21:24:14 -0700 (PDT)
Received: from toolbx.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33be54cad3esm245557a91.12.2025.10.16.21.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 21:24:14 -0700 (PDT)
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
Subject: [PATCH v4 7/7] nvmet-tcp: Support KeyUpdate
Date: Fri, 17 Oct 2025 14:23:12 +1000
Message-ID: <20251017042312.1271322-8-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017042312.1271322-1-alistair.francis@wdc.com>
References: <20251017042312.1271322-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251017_052509_828344_6571CD10 
X-CRM114-Status: GOOD (  26.77  )
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

If the nvmet_tcp_try_recv() function return EKEYEXPIRED or if we receive
a KeyUpdate handshake type then the underlying TLS keys need to be
updated.

If the NVMe Host (TLS client) initiates a KeyUpdate this patch will
allow the NVMe layer to process the KeyUpdate request and forward the
request to userspace. Userspace must then update the key to keep the
connection alive.

This patch allows us to handle the NVMe host sending a KeyUpdate
request without aborting the connection. At this time we don't support
initiating a KeyUpdate.

Link: https://datatracker.ietf.org/doc/html/rfc8446#section-4.6.3
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
v4:
 - Restructure code to avoid #ifdefs and forward declarations
 - Use a helper function for checking -EKEYEXPIRED
 - Remove all support for initiating KeyUpdate
 - Use helper function for restoring callbacks
v3:
 - Use a write lock for sk_user_data
 - Fix build with CONFIG_NVME_TARGET_TCP_TLS disabled
 - Remove unused variable
v2:
 - Use a helper function for KeyUpdates
 - Ensure keep alive timer is stopped
 - Wait for TLS KeyUpdate to complete

 drivers/nvme/target/tcp.c | 205 ++++++++++++++++++++++++++------------
 1 file changed, 143 insertions(+), 62 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 8aeec4a7f136..4ef25df2791a 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -175,6 +175,7 @@ struct nvmet_tcp_queue {
 
 	/* TLS state */
 	key_serial_t		tls_pskid;
+	key_serial_t		user_session_id;
 	struct delayed_work	tls_handshake_tmo_work;
 
 	unsigned long           poll_end;
@@ -186,6 +187,8 @@ struct nvmet_tcp_queue {
 	struct sockaddr_storage	sockaddr_peer;
 	struct work_struct	release_work;
 
+	struct completion       tls_complete;
+
 	int			idx;
 	struct list_head	queue_list;
 
@@ -214,6 +217,10 @@ static struct workqueue_struct *nvmet_tcp_wq;
 static const struct nvmet_fabrics_ops nvmet_tcp_ops;
 static void nvmet_tcp_free_cmd(struct nvmet_tcp_cmd *c);
 static void nvmet_tcp_free_cmd_buffers(struct nvmet_tcp_cmd *cmd);
+#ifdef CONFIG_NVME_TARGET_TCP_TLS
+static int nvmet_tcp_tls_handshake(struct nvmet_tcp_queue *queue,
+				   handshake_key_update_type keyupdate);
+#endif
 
 static inline u16 nvmet_tcp_cmd_tag(struct nvmet_tcp_queue *queue,
 		struct nvmet_tcp_cmd *cmd)
@@ -832,6 +839,23 @@ static int nvmet_tcp_try_send_one(struct nvmet_tcp_queue *queue,
 	return 1;
 }
 
+#ifdef CONFIG_NVME_TARGET_TCP_TLS
+static bool nvmet_tls_key_expired(struct nvmet_tcp_queue *queue, int ret)
+{
+	if (ret == -EKEYEXPIRED &&
+	    queue->state != NVMET_TCP_Q_DISCONNECTING &&
+	    queue->state != NVMET_TCP_Q_TLS_HANDSHAKE)
+					return true;
+
+	return false;
+}
+#else
+static bool nvmet_tls_key_expired(struct nvmet_tcp_queue *queue, int ret)
+{
+	return false;
+}
+#endif
+
 static int nvmet_tcp_try_send(struct nvmet_tcp_queue *queue,
 		int budget, int *sends)
 {
@@ -1106,6 +1130,103 @@ static inline bool nvmet_tcp_pdu_valid(u8 type)
 	return false;
 }
 
+static void nvmet_tcp_release_queue(struct kref *kref)
+{
+	struct nvmet_tcp_queue *queue =
+		container_of(kref, struct nvmet_tcp_queue, kref);
+
+	WARN_ON(queue->state != NVMET_TCP_Q_DISCONNECTING);
+	queue_work(nvmet_wq, &queue->release_work);
+}
+
+static void nvmet_tcp_schedule_release_queue(struct nvmet_tcp_queue *queue)
+{
+	spin_lock_bh(&queue->state_lock);
+	if (queue->state == NVMET_TCP_Q_TLS_HANDSHAKE) {
+		/* Socket closed during handshake */
+		tls_handshake_cancel(queue->sock->sk);
+	}
+	if (queue->state != NVMET_TCP_Q_DISCONNECTING) {
+		queue->state = NVMET_TCP_Q_DISCONNECTING;
+		kref_put(&queue->kref, nvmet_tcp_release_queue);
+	}
+	spin_unlock_bh(&queue->state_lock);
+}
+
+static void nvmet_tcp_restore_socket_callbacks(struct nvmet_tcp_queue *queue)
+{
+	struct socket *sock = queue->sock;
+
+	if (!queue->state_change)
+		return;
+
+	write_lock_bh(&sock->sk->sk_callback_lock);
+	sock->sk->sk_data_ready =  queue->data_ready;
+	sock->sk->sk_state_change = queue->state_change;
+	sock->sk->sk_write_space = queue->write_space;
+	sock->sk->sk_user_data = NULL;
+	write_unlock_bh(&sock->sk->sk_callback_lock);
+}
+
+#ifdef CONFIG_NVME_TARGET_TCP_TLS
+static void nvmet_tcp_tls_handshake_timeout(struct work_struct *w)
+{
+	struct nvmet_tcp_queue *queue = container_of(to_delayed_work(w),
+			struct nvmet_tcp_queue, tls_handshake_tmo_work);
+
+	pr_warn("queue %d: TLS handshake timeout\n", queue->idx);
+	/*
+	 * If tls_handshake_cancel() fails we've lost the race with
+	 * nvmet_tcp_tls_handshake_done() */
+	if (!tls_handshake_cancel(queue->sock->sk))
+		return;
+	spin_lock_bh(&queue->state_lock);
+	if (WARN_ON(queue->state != NVMET_TCP_Q_TLS_HANDSHAKE)) {
+		spin_unlock_bh(&queue->state_lock);
+		return;
+	}
+	queue->state = NVMET_TCP_Q_FAILED;
+	spin_unlock_bh(&queue->state_lock);
+	nvmet_tcp_schedule_release_queue(queue);
+	kref_put(&queue->kref, nvmet_tcp_release_queue);
+}
+
+static int update_tls_keys(struct nvmet_tcp_queue *queue)
+{
+	int ret;
+
+	cancel_work(&queue->io_work);
+	queue->state = NVMET_TCP_Q_TLS_HANDSHAKE;
+
+	nvmet_tcp_restore_socket_callbacks(queue);
+
+	INIT_DELAYED_WORK(&queue->tls_handshake_tmo_work,
+			  nvmet_tcp_tls_handshake_timeout);
+
+	ret = nvmet_tcp_tls_handshake(queue, HANDSHAKE_KEY_UPDATE_TYPE_RECEIVED);
+
+	if (ret < 0)
+		return ret;
+
+	ret = wait_for_completion_interruptible_timeout(&queue->tls_complete,
+							10 * HZ);
+
+	if (ret <= 0) {
+		tls_handshake_cancel(queue->sock->sk);
+		return ret;
+	}
+
+	queue->state = NVMET_TCP_Q_LIVE;
+
+	return 0;
+}
+#else
+static int update_tls_keys(struct nvmet_tcp_queue *queue)
+{
+	return -EPFNOSUPPORT;
+}
+#endif
+
 static int nvmet_tcp_tls_record_ok(struct nvmet_tcp_queue *queue,
 		struct msghdr *msg, char *cbuf)
 {
@@ -1131,6 +1252,9 @@ static int nvmet_tcp_tls_record_ok(struct nvmet_tcp_queue *queue,
 			ret = -EAGAIN;
 		}
 		break;
+	case TLS_RECORD_TYPE_HANDSHAKE:
+		ret = -EAGAIN;
+		break;
 	default:
 		/* discard this record type */
 		pr_err("queue %d: TLS record %d unhandled\n",
@@ -1340,6 +1464,8 @@ static int nvmet_tcp_try_recv(struct nvmet_tcp_queue *queue,
 	for (i = 0; i < budget; i++) {
 		ret = nvmet_tcp_try_recv_one(queue);
 		if (unlikely(ret < 0)) {
+			if (nvmet_tls_key_expired(queue, ret))
+					goto done;
 			nvmet_tcp_socket_error(queue, ret);
 			goto done;
 		} else if (ret == 0) {
@@ -1351,29 +1477,6 @@ static int nvmet_tcp_try_recv(struct nvmet_tcp_queue *queue,
 	return ret;
 }
 
-static void nvmet_tcp_release_queue(struct kref *kref)
-{
-	struct nvmet_tcp_queue *queue =
-		container_of(kref, struct nvmet_tcp_queue, kref);
-
-	WARN_ON(queue->state != NVMET_TCP_Q_DISCONNECTING);
-	queue_work(nvmet_wq, &queue->release_work);
-}
-
-static void nvmet_tcp_schedule_release_queue(struct nvmet_tcp_queue *queue)
-{
-	spin_lock_bh(&queue->state_lock);
-	if (queue->state == NVMET_TCP_Q_TLS_HANDSHAKE) {
-		/* Socket closed during handshake */
-		tls_handshake_cancel(queue->sock->sk);
-	}
-	if (queue->state != NVMET_TCP_Q_DISCONNECTING) {
-		queue->state = NVMET_TCP_Q_DISCONNECTING;
-		kref_put(&queue->kref, nvmet_tcp_release_queue);
-	}
-	spin_unlock_bh(&queue->state_lock);
-}
-
 static inline void nvmet_tcp_arm_queue_deadline(struct nvmet_tcp_queue *queue)
 {
 	queue->poll_end = jiffies + usecs_to_jiffies(idle_poll_period_usecs);
@@ -1404,8 +1507,12 @@ static void nvmet_tcp_io_work(struct work_struct *w)
 		ret = nvmet_tcp_try_recv(queue, NVMET_TCP_RECV_BUDGET, &ops);
 		if (ret > 0)
 			pending = true;
-		else if (ret < 0)
+		else if (ret < 0) {
+			if (ret == -EKEYEXPIRED)
+				break;
+
 			return;
+		}
 
 		ret = nvmet_tcp_try_send(queue, NVMET_TCP_SEND_BUDGET, &ops);
 		if (ret > 0)
@@ -1415,6 +1522,11 @@ static void nvmet_tcp_io_work(struct work_struct *w)
 
 	} while (pending && ops < NVMET_TCP_IO_WORK_BUDGET);
 
+	if (ret == -EKEYEXPIRED) {
+		update_tls_keys(queue);
+		pending = true;
+	}
+
 	/*
 	 * Requeue the worker if idle deadline period is in progress or any
 	 * ops activity was recorded during the do-while loop above.
@@ -1517,21 +1629,6 @@ static void nvmet_tcp_free_cmds(struct nvmet_tcp_queue *queue)
 	kfree(cmds);
 }
 
-static void nvmet_tcp_restore_socket_callbacks(struct nvmet_tcp_queue *queue)
-{
-	struct socket *sock = queue->sock;
-
-	if (!queue->state_change)
-		return;
-
-	write_lock_bh(&sock->sk->sk_callback_lock);
-	sock->sk->sk_data_ready =  queue->data_ready;
-	sock->sk->sk_state_change = queue->state_change;
-	sock->sk->sk_write_space = queue->write_space;
-	sock->sk->sk_user_data = NULL;
-	write_unlock_bh(&sock->sk->sk_callback_lock);
-}
-
 static void nvmet_tcp_uninit_data_in_cmds(struct nvmet_tcp_queue *queue)
 {
 	struct nvmet_tcp_cmd *cmd = queue->cmds;
@@ -1794,6 +1891,7 @@ static void nvmet_tcp_tls_handshake_done(void *data, int status,
 	}
 	if (!status) {
 		queue->tls_pskid = peerid;
+		queue->user_session_id = user_session_id;
 		queue->state = NVMET_TCP_Q_CONNECTING;
 	} else
 		queue->state = NVMET_TCP_Q_FAILED;
@@ -1809,32 +1907,11 @@ static void nvmet_tcp_tls_handshake_done(void *data, int status,
 	else
 		nvmet_tcp_set_queue_sock(queue);
 	kref_put(&queue->kref, nvmet_tcp_release_queue);
-}
-
-static void nvmet_tcp_tls_handshake_timeout(struct work_struct *w)
-{
-	struct nvmet_tcp_queue *queue = container_of(to_delayed_work(w),
-			struct nvmet_tcp_queue, tls_handshake_tmo_work);
-
-	pr_warn("queue %d: TLS handshake timeout\n", queue->idx);
-	/*
-	 * If tls_handshake_cancel() fails we've lost the race with
-	 * nvmet_tcp_tls_handshake_done() */
-	if (!tls_handshake_cancel(queue->sock->sk))
-		return;
-	spin_lock_bh(&queue->state_lock);
-	if (WARN_ON(queue->state != NVMET_TCP_Q_TLS_HANDSHAKE)) {
-		spin_unlock_bh(&queue->state_lock);
-		return;
-	}
-	queue->state = NVMET_TCP_Q_FAILED;
-	spin_unlock_bh(&queue->state_lock);
-	nvmet_tcp_schedule_release_queue(queue);
-	kref_put(&queue->kref, nvmet_tcp_release_queue);
+	complete(&queue->tls_complete);
 }
 
 static int nvmet_tcp_tls_handshake(struct nvmet_tcp_queue *queue,
-	handshake_key_update_type keyupdate)
+				   handshake_key_update_type keyupdate)
 {
 	int ret = -EOPNOTSUPP;
 	struct tls_handshake_args args;
@@ -1852,11 +1929,15 @@ static int nvmet_tcp_tls_handshake(struct nvmet_tcp_queue *queue,
 	args.ta_data = queue;
 	args.ta_keyring = key_serial(queue->port->nport->keyring);
 	args.ta_timeout_ms = tls_handshake_timeout * 1000;
+	args.user_session_id = queue->user_session_id;
+
+	init_completion(&queue->tls_complete);
 
 	if (keyupdate == HANDSHAKE_KEY_UPDATE_TYPE_UNSPEC)
 		ret = tls_server_hello_psk(&args, GFP_KERNEL);
 	else
 		ret = tls_server_keyupdate_psk(&args, GFP_KERNEL, keyupdate);
+
 	if (ret) {
 		kref_put(&queue->kref, nvmet_tcp_release_queue);
 		pr_err("failed to start TLS, err=%d\n", ret);
-- 
2.51.0



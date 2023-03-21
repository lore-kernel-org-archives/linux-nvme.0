Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09DB8C76195
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Mar 2023 12:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zPkrDsJ3WC2tBejLMWGz7F0dKN3WaFfmO6AmVGL9ANw=; b=nJ+wKukyp62HWdMc8dPwyGgnKW
	5gl89OYOeRDzAPDA62DE/uhWfIdr1ADeIiBtKruAe/rxL/5QQLJ1LU0c/iSZBirztbNr1QozpTBI4
	LdRmUHEylvDOiNuLRtNXgz2CTmRy2McLZktx0hKMW6++ZKHBja8JFRUFKtOOz5iEL0/kPBaeYVM+9
	3jn54ERg1N4DsifuRnifuOzC/m+yw60tFCwNKTOdD490pvRzEN98fj3ph0v8JHoMwKjdaFkBFj53p
	W9kYW6z5bqVWO8oaP+OCW37e2j6Pyhau5QU6XPJ8sqtC25hehecGyAgtIO7JqtJ+oiCEoN/AmxC8z
	ENpO9E3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pebM8-00CNu4-1H;
	Tue, 21 Mar 2023 12:44:48 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pebLS-00CNSv-2k
	for linux-nvme@lists.infradead.org;
	Tue, 21 Mar 2023 12:44:11 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id 327002000C;
	Tue, 21 Mar 2023 12:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1679402638; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zPkrDsJ3WC2tBejLMWGz7F0dKN3WaFfmO6AmVGL9ANw=;
	b=R4RkLewVDus0EGRzBWdcEKAfPhlIHqRgjuqrcvf9FuCVoJmQrRybJgNuiHLivjLpCqA6mz
	pWaOkQUDMJK+mxBwuFdxciFve7VAYVVg3UDbDcKHiryOyKcxYM4Lxh8jJ4+kUGyQ41GGDG
	3KcwGMrNsaMG43vTt4BouS2gOLIS+e0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1679402638;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zPkrDsJ3WC2tBejLMWGz7F0dKN3WaFfmO6AmVGL9ANw=;
	b=M9xlnkd1LVBhZfCzk27CBFe2mSbaQMUokDtJxJlFntroE0J2KGMztFflFx6swJlp2y5Hb4
	E3Y05GCPcWB3nGDg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id 21E2D2C166;
	Tue, 21 Mar 2023 12:43:58 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 1E81951BEEB8; Tue, 21 Mar 2023 13:43:58 +0100 (CET)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Chuck Lever <cel@kernel.org>,
	kernel-tls-handshake@lists.linux.dev,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 18/18] nvmet-tcp: peek icreq before starting TLS
Date: Tue, 21 Mar 2023 13:43:25 +0100
Message-Id: <20230321124325.77385-19-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230321124325.77385-1-hare@suse.de>
References: <20230321124325.77385-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230321_054407_246578_422C010D 
X-CRM114-Status: GOOD (  13.93  )
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

Incoming connection might be either 'normal' NVMe-TCP connections
starting with icreq or TLS handshakes. To ensure that 'normal'
connections can still be handled we need to peek the first packet
and only start TLS handshake if it's not an icreq.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/target/tcp.c | 60 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 58 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index a69647fb2c81..a328a303c2be 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1105,6 +1105,61 @@ static inline bool nvmet_tcp_pdu_valid(u8 type)
 	return false;
 }
 
+static int nvmet_tcp_try_peek_pdu(struct nvmet_tcp_queue *queue)
+{
+	struct nvme_tcp_hdr *hdr = &queue->pdu.cmd.hdr;
+	int len;
+	struct kvec iov = {
+		.iov_base = (u8 *)&queue->pdu + queue->offset,
+		.iov_len = sizeof(struct nvme_tcp_hdr),
+	};
+	char cbuf[CMSG_LEN(sizeof(char))] = {};
+	unsigned char ctype;
+	struct cmsghdr *cmsg;
+	struct msghdr msg = {
+		.msg_control = cbuf,
+		.msg_controllen = sizeof(cbuf),
+		.msg_flags = MSG_PEEK,
+	};
+
+	len = kernel_recvmsg(queue->sock, &msg, &iov, 1,
+			iov.iov_len, msg.msg_flags);
+	if (unlikely(len < 0)) {
+		pr_debug("queue %d peek error %d\n",
+			 queue->idx, len);
+		return len;
+	}
+
+	cmsg = (struct cmsghdr *)cbuf;
+	if (CMSG_OK(&msg, cmsg) &&
+	    cmsg->cmsg_level == SOL_TLS &&
+	    cmsg->cmsg_type == TLS_GET_RECORD_TYPE) {
+		ctype = *((unsigned char *)CMSG_DATA(cmsg));
+		if (ctype != TLS_RECORD_TYPE_DATA) {
+			pr_err("queue %d unhandled TLS record %d\n",
+				queue->idx, ctype);
+			return -ENOTCONN;
+		}
+	}
+
+	if (len < sizeof(struct nvme_tcp_hdr)) {
+		pr_debug("queue %d short read, %d bytes missing\n",
+			 queue->idx, (int)iov.iov_len - len);
+		return -EAGAIN;
+	}
+	pr_debug("queue %d hdr type %d hlen %d plen %d size %d\n",
+		 queue->idx, hdr->type, hdr->hlen, hdr->plen,
+		 (int)sizeof(struct nvme_tcp_icreq_pdu));
+	if (hdr->type == nvme_tcp_icreq &&
+	    hdr->hlen == sizeof(struct nvme_tcp_icreq_pdu) &&
+	    hdr->plen == sizeof(struct nvme_tcp_icreq_pdu)) {
+		pr_debug("queue %d icreq detected\n",
+			 queue->idx);
+		return len;
+	}
+	return 0;
+}
+
 static int nvmet_tcp_try_recv_pdu(struct nvmet_tcp_queue *queue)
 {
 	struct nvme_tcp_hdr *hdr = &queue->pdu.cmd.hdr;
@@ -1879,8 +1934,9 @@ static void nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
 
 	if (queue->state == NVMET_TCP_Q_TLS_HANDSHAKE) {
 		nvmet_tcp_save_tls_callbacks(queue);
-		if (!nvmet_tcp_tls_handshake(queue))
-			return;
+		if (!nvmet_tcp_try_peek_pdu(queue))
+			if (!nvmet_tcp_tls_handshake(queue))
+				return;
 		nvmet_tcp_restore_tls_callbacks(queue);
 
 		/*
-- 
2.35.3



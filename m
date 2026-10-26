Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA1D606A324
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Oct 2026 18:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=yhM5p2sW;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Zsja6HjN
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=04ZAW9YYQFyNzmPB2rE27kvKEWlMN6ldEO2+3cJbpTw=; b=yhM5p2sWxtmEXigaO4sRFobqv1
	zlmlXVqmjbwYD36EJXEwgwpO+z/BxjYFzpzRVmHaI8BzmIbUFDGOjyW3CixPa+ydySH8O+/j8u1NS
	XXoKBu2OVAKmXXCjVcYHntHqbF/wZOBT6t8Yn8Onvc7M78qvmSo/wN6tSC4WPh2qIKpbJ3gLqdaDq
	R/El6QOhOeVw7QMzsh5JSd663M8v8oHbdaAmPR9KiJIygFK589NcjKWTrkOA+197QoZ+96kGwfa3W
	FOzW+m0WjkjOOqLopVBNBAyNikPa1paXDyvxx3xT6NSNFDjuD9HK/NL8243pbRSu1meIbWa5ikzo1
	6/1JKT7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLPjB-00000003678-0yHc;
	Mon, 26 Oct 2026 18:47:25 +0000
Received: from mail-ua1-x935.google.com ([2607:f8b0:4864:20::935])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLPj9-0000000366D-2Aj9
	for linux-nvme@lists.infradead.org;
	Mon, 26 Oct 2026 18:47:24 +0000
Received: by mail-ua1-x935.google.com with SMTP id a1e0cc1a2514c-980c4f5c921so994366241.2
        for <linux-nvme@lists.infradead.org>; Mon, 26 Oct 2026 11:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793040441; x=1793645241; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=04ZAW9YYQFyNzmPB2rE27kvKEWlMN6ldEO2+3cJbpTw=;
        b=Zsja6HjNItOdXnSGMIABS16ZC0k55bhyLmQ3SM5kdI+UFS2JyLp9toJa/04zWJIaDw
         FRCvGy+KkJDeFHDbWC6dilSH4UMqs/hYpu0LXuq4omzCIU1G+8UGPNCe9akUPAQFpqho
         O39LRaSewn5FN5Qfp7+9+BOgnElKEZo275ipNq1KOca1lVuJeJ7k8PBWbYgz0NScrYZQ
         aYfrXUX9vDNzo+GdiyYMFWlxVOOpOfzPU0cY/7Z1kx7uuqO5+lxIn8PXA23hqXaXaICH
         HrPMhMrp+6DslDGF4CmYedQNfgOFIVih8yzRTVW7frwjAIjEyq2LMzmM1xM1zgLbUnhl
         vxfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793040441; x=1793645241;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=04ZAW9YYQFyNzmPB2rE27kvKEWlMN6ldEO2+3cJbpTw=;
        b=b88yjgzXL6q8plOJpGR9MQG+Vo/GgnX9d8ZYJ/GBoQhZulzm2eRsOPyD4macIliHga
         9D8A8gsOvsFMt3cV7lm6dKsiRGUcq8gSuWQLpS1vSLiS5PF1kdD2tQ2coL5p0uPWUB8L
         IvELgBRK3VEkxDXM2g2vpR6muXQqDNh/ynHJLgw90p8sNMonoLmycIEOSdhVcr3n1KeB
         xcNph63a+5SUZ4OSB24PQH0dMOpL8YvIuv8n2FBv98zPjjFbFc/7Np671tTQXUw++1Nd
         DLIaGSEINzs6DhN9Xj4gN9nH+AOAoGwA7ebBnqW8i9yo21UudAmwTxmhnoiWv6QvE9IV
         02+g==
X-Gm-Message-State: AFq9FYInMembf+BajEp5dOcRKh1u01LDqv6rOeZkO1E6UXuc/GfFvjHW
	G3XrRm6Wqb8RjYwd97WZjkW3L/a1oJiksjr03ZMF97iDDxrh5sxFhl/iJ0u1wgOH0aI=
X-Gm-Gg: AYBFou3otd174NqjML3jX96lAkkW/uUZ8iXyLFk49gJFBk0eT+R2nZ7cd0oPF13hK3p
	hv2zfpxTUhRNEroTBCS1YiQrr8na2j3bBg3dLUzi4t8QG61TCycANBfCSpsN1rqltL7POWpOeMQ
	fS4dpsDxel7xXdDz5xeAkCje0r6NJmptMdpfYj4NmBTRcjtcXEHMCBhI01+XCpjX50V7AZ+Tlb2
	avr/Y+xml9zpR/nsLtSgPo2/wWY/uDZk/F8xQzuf1o7vAQxEYFoaq0TGu5NUKbN6WIB7XYYqplP
	r2pYRr4g+U4I4NzSRcyjqXDpT0EgXsvONdipAENx/ZW8O88VeyExbVIuyiKKMVbbldXsXPiBb7+
	fOhWQFMl67qHc4AtVymSojnfS6h8hZ+cf7QhO6lkXdtVaE5H0lrldrsyLHVw0vkf6rHuiaWGWj5
	GL8KjMhzBOg2glyORqCdKJHnhJP+G/civoM2kH2333Cdiju/jjUz6L6a2mBrcliK5mUXZsuXoLe
	eCYFDzEFThkWnofZ/qGgVKc0LZ6/TwmVs3w0vhO9OlK58H8Yy5QT1FkkSbv3xgL/Vk=
X-Received: by 2002:a05:6102:3e89:b0:7cc:2b48:cb1b with SMTP id ada2fe7eead31-7ce5ce76692mr2747252137.35.1793040441466;
        Mon, 26 Oct 2026 11:47:21 -0700 (PDT)
Received: from bridge.. ([2804:14d:ba6b:8339:9a5c:f039:9435:df2a])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-991259c3067sm101634241.5.2026.10.26.11.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 11:47:21 -0700 (PDT)
From: Christian Aurich Zanettini Martins <christian.aurichzm@gmail.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	hare@kernel.org,
	sgogte@purestorage.com,
	wagi@kernel.org,
	linux-kernel@vger.kernel.org,
	Christian Aurich Zanettini Martins <christian.aurichzm@gmail.com>
Subject: [PATCH] nvme-tcp: fix request PDU size when header digest is enabled
Date: Mon, 26 Oct 2026 15:46:21 -0300
Message-ID: <20261026184621.29276-1-christian.aurichzm@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261026_114723_568798_F11A041B 
X-CRM114-Status: GOOD (  14.73  )
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Since commit 61b0ed3be81b ("nvme-tcp: parallelize I/O queue allocation
and startup") the I/O tag set is allocated before the I/O queues.
nvme_tcp_init_request() sizes the PDU with nvme_tcp_hdgst_len(queue),
but queue->hdr_digest is only set later by nvme_tcp_alloc_queue(), so
every I/O PDU is allocated without room for the header digest.

With hdr_digest enabled, the digest is then written 4 bytes past the
PDU, over the header of the next PDU in the page_frag cache, and the
target drops the connection on the first I/O:

  nvmet_tcp: unexpected pdu type 159
  nvmet: ctrl 1 fatal error occurred!

Queues that a later reconnect adds for the first time have the same
problem.

Use the controller option, which is what nvme_tcp_alloc_queue() copies
into the queue.

Fixes: 61b0ed3be81b ("nvme-tcp: parallelize I/O queue allocation and startup")
Signed-off-by: Christian Aurich Zanettini Martins <christian.aurichzm@gmail.com>
---
Based on nvme-7.4 (aaedcff90148).

Tested in QEMU with nvmet-tcp over loopback and parallel I/O: with
hdr_digest the connection failed on the first I/O before the fix; after
it, no errors and the data matched, also with data_digest and with a
reconnect growing the queues from 2 to 4 (attr_qid_max).

 drivers/nvme/host/tcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index f876375dffd2..7733aa092544 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -566,7 +566,7 @@ static int nvme_tcp_init_request(struct blk_mq_tag_set *set,
 	struct nvme_tcp_cmd_pdu *pdu;
 	int queue_idx = (set == &ctrl->tag_set) ? hctx_idx + 1 : 0;
 	struct nvme_tcp_queue *queue = &ctrl->queues[queue_idx];
-	u8 hdgst = nvme_tcp_hdgst_len(queue);
+	u8 hdgst = ctrl->ctrl.opts->hdr_digest ? NVME_TCP_DIGEST_LENGTH : 0;
 
 	mutex_lock(&queue->pf_cache_lock);
 	req->pdu = page_frag_alloc(&queue->pf_cache,
-- 
2.43.0



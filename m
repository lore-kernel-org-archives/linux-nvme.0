Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98BC3E784AF
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Oct 2023 10:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Q8UxmNoADdixSXrpmTvwGp1/FZ+jpcEojVpru9cA5kg=; b=aIdg9M9rOgYl67U/Nk4GIs4Brd
	BA+ocYyAfMS8T58MKCUnbJd/iUbBdZ2ux08Xx4zGffS+JuzuFShDZc6urA35HeTl+M6crrwe0Cq8/
	k5RZwyMq2k3IRFsIlVn0G2f8bFtftl+1M6Q8wY7akdUHJ4oIgPJqReufiPEfcOF1AuPqWKfN9qdce
	y5Js2aO1eX8DntIQQkxArbWzz9Fmq4HNHTi5d4ZP/lCwf/sbMWzDnAiAR/lAPsBuQ8nAWJQUiPdGp
	vc+ZZVjtqo5CKgWb5Bpe4mMzrc2UwL5hkjVjcenWIUdfbSU91Yho2T+drx7fWdzC8MF4iT7zwpama
	fNIVMeTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qnGZW-00CUsu-0p;
	Mon, 02 Oct 2023 10:54:42 +0000
Received: from mail-wm1-f54.google.com ([209.85.128.54])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qnGZQ-00CUr5-26
	for linux-nvme@lists.infradead.org;
	Mon, 02 Oct 2023 10:54:40 +0000
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-405e48d8e72so23282545e9.0
        for <linux-nvme@lists.infradead.org>; Mon, 02 Oct 2023 03:54:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696244071; x=1696848871;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q8UxmNoADdixSXrpmTvwGp1/FZ+jpcEojVpru9cA5kg=;
        b=g/rfzj95dFvX4df/ucu8vve4QrK6Jddn5XVaXaG6mXhjiBtdy07hM+UA2MP2uxvQ4i
         MxxwoHWxuYH48Vnrsvkh5xfJsdwgxM88ZX+0lguKZWJbG9spMvje1W48/w5BHU5HPIPq
         61nvs2533vrYSYaQ4/EvM1urwvqU3akCNf+faqtwuvBZW+LMQ2kZ0ll9ZXIM8FqYW2ep
         fE/mHruoXyVWrkZpVvEHJ5u53YV0KeVOLmK+doc4+PvwGga6wuY+x5kElU5Kb7tMC/5+
         OjEC6Gp5AgNWVE0AJNlJUopdl4aKw4WZTmxVKoDdOvr9xFaGw5emTlrcZAMEocZAoYxo
         aVYw==
X-Gm-Message-State: AOJu0YxZTEhM2YTg8kPctepUgt+Gg6mROsHcGlh3B8OpQolg7kL+SBXq
	K8ntmPwY2cR4WHnWjAbupp0nip8RvV4=
X-Google-Smtp-Source: AGHT+IF9339oqwPbn5D3FCPTxINsXscotCrnr87BZvYgJGzPmh99WjGIRro9+VTzLRG0qXu3HXZDRQ==
X-Received: by 2002:adf:ed8e:0:b0:31a:e772:ddf9 with SMTP id c14-20020adfed8e000000b0031ae772ddf9mr8171297wro.4.1696244070515;
        Mon, 02 Oct 2023 03:54:30 -0700 (PDT)
Received: from localhost.localdomain (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id z17-20020adfd0d1000000b00317a04131c5sm27736148wrh.57.2023.10.02.03.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 03:54:29 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	zahavi.alon@gmail.com
Subject: [PATCH] nvmet-tcp: Fix a possible UAF in queue intialization setup
Date: Mon,  2 Oct 2023 13:54:28 +0300
Message-ID: <20231002105428.226515-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231002_035436_688588_D33A63F3 
X-CRM114-Status: GOOD (  16.67  )
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

From Alon:
"Due to a logical bug in the NVMe-oF/TCP subsystem in the Linux kernel,
a malicious user can cause a UAF and a double free, which may lead to
RCE (may also lead to an LPE in case the attacker already has local
privileges)."

Hence, when a queue initialization fails after the ahash requests are
allocated, it is guaranteed that the queue removal async work will be
called, hence leave the deallocation to the queue removal.

Also, be extra careful not to continue processing the socket, so set
queue rcv_state to NVMET_TCP_RECV_ERR upon a socket error.

Reported-by: Alon Zahavi <zahavi.alon@gmail.com>
Tested-by: Alon Zahavi <zahavi.alon@gmail.com>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/target/tcp.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 97d07488072d..d840f996eb82 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -372,6 +372,7 @@ static void nvmet_tcp_fatal_error(struct nvmet_tcp_queue *queue)
 
 static void nvmet_tcp_socket_error(struct nvmet_tcp_queue *queue, int status)
 {
+	queue->rcv_state = NVMET_TCP_RECV_ERR;
 	if (status == -EPIPE || status == -ECONNRESET)
 		kernel_sock_shutdown(queue->sock, SHUT_RDWR);
 	else
@@ -910,15 +911,11 @@ static int nvmet_tcp_handle_icreq(struct nvmet_tcp_queue *queue)
 	iov.iov_len = sizeof(*icresp);
 	ret = kernel_sendmsg(queue->sock, &msg, &iov, 1, iov.iov_len);
 	if (ret < 0)
-		goto free_crypto;
+		return ret; /* queue removal will cleanup */
 
 	queue->state = NVMET_TCP_Q_LIVE;
 	nvmet_prepare_receive_pdu(queue);
 	return 0;
-free_crypto:
-	if (queue->hdr_digest || queue->data_digest)
-		nvmet_tcp_free_crypto(queue);
-	return ret;
 }
 
 static void nvmet_tcp_handle_req_failure(struct nvmet_tcp_queue *queue,
-- 
2.41.0



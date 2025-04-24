Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F6ACC369AB
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Apr 2025 16:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:List-Owner;
	bh=R/7AYuRR+q7ueuQXa9Sr3f8IB4dxGhH9BIYTobpJ9no=; b=NMKxrPr6segEKaNENiHp46IaNZ
	6MuxFF5UIf8yA1Tf+sU80188+h3XDlltcw5C6pRpoa96V5QRMLQZsWty+8T9Scvo7Jyhexz8ODuYL
	PqrFRSmtweoM9YLP6tR+CsG9i/fSP/hVy5ipY5t3s/fiOp85KkUFKsIDkivYRPxEcUnIwdG6QAmSs
	JI6p9nqnU4oyr9RDvtb1JVT2P8fEqB6DvHUBLqXAtS09AKKk2Kcg0L1OfjYCSc+l8vVhrddJba0lu
	JVzemcM3WD+UdJLgdTb2VnrJg6OF/PQyBxzM8iBOPMDuTuEzlxLH8wJ33bHsQJ7CDvtq+3KC5eRqQ
	iz1r1Xtw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7zYC-0000000Elpy-2D8m;
	Thu, 24 Apr 2025 16:35:48 +0000
Received: from mail-io1-xd2a.google.com ([2607:f8b0:4864:20::d2a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7zGs-0000000EiBc-2u0D
	for linux-nvme@lists.infradead.org;
	Thu, 24 Apr 2025 16:17:56 +0000
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-86135ae2a29so110354739f.2
        for <linux-nvme@lists.infradead.org>; Thu, 24 Apr 2025 09:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1745511474; x=1746116274; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=R/7AYuRR+q7ueuQXa9Sr3f8IB4dxGhH9BIYTobpJ9no=;
        b=QlZqSux8Mm3h8Wkw5NYHHN/jMQpcfRLY0sXF5rwzlnc90D7aL1PSyuEOqLdWkyfksq
         pr31cQCgVzljQsS3MaLtUcRR9+rw/Obf57WlGEmAl+ZSpZhno6EM/Z2mWOqA9pqiRCOt
         INPo3G36dEdfAv0ig/g+/hFMG3s6hrLyX60l0A9FnR+MwlvoljniaBpAINPEhGNP3rIE
         vHZb2cy6qG4+dM+C9b9VEFtoqIlwXH07K4RXi7LUW7JjbWwpFQC2W0iBHBi22QFwPg2C
         G0wFLzL37GrwfJR7/c5sLUOGt0NDeb1l5+DhKU+eSsjeZ9e+nL4umaqc06jz3X/54cDG
         efmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745511474; x=1746116274;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R/7AYuRR+q7ueuQXa9Sr3f8IB4dxGhH9BIYTobpJ9no=;
        b=kkYeUxhDmL+T00tMKBXWnZdQgxnyhGiJGAiEMQ2VqnDM0fHP+MqHyQXRzvIVqahLzS
         z4mUcDvpmOXWkF41PrRbKGniyWr4Ws4gKAGqFcL3RXeRtLuQQ3SwjH0YvzkKKKyIa63x
         ga8GOfSXX07cbRctWd1GocHW9uzwExssg/O7UcdKl7s5dJU3h4iiEEeFE1oPxtQNPxCL
         zRgm0tW5EdMl73yGRsB0IrujB1XS6WgFFexkd2QhY3pnBiVpgsUEVVt6TbIpDgaCQCb7
         qUr5j5lMZs8HcKTF+uFgjyWnf+gdCNVpO0jsZRTimdxgioAeP9RMoQmWtcExOXX2eXpF
         Wjjg==
X-Forwarded-Encrypted: i=1; AJvYcCW7Ju86ovAoP6jWAjW5GQ5+cNgHrPf9ebP+/VkxbWJsxRWLSAiRkYAxF4ZYlee4BvXxWzuhhxtGf9bN@lists.infradead.org
X-Gm-Message-State: AOJu0YzvdPs/ATfFOBLOYdzbspZayMzK6FrT31/x3xmE2WdfKWM7oUap
	gBjCgmdGVqE0gdIyCTHpJGj30JOGDXXhelALGIGSS2ASY+POaJrgJmPoTqQqf8qy5aHhD4yEgMV
	GBTI=
X-Gm-Gg: ASbGnct/vyKVAkDBAQwwCB1VA9sPJNXf0wexkJV7LSebYT3qob5hisuFhytyIR4x3CM
	8QFyzo6NO2apsZj23CwTG0FqK804TEgsUe+7tu8lbQ6KCrQ+URsGpy6khXEVpJ2WrC5xQgz8fNK
	Zy0b2yof39p0waiwwG3HUclqdmocK+X5MumPDc17Jnna/Jht4HU0cn0DLvnNWlj1EUCcuyZ9uMB
	5IKlPPBWvCqC5kwCbG7mB8I56qNfPJrJlYkIfydQvBf6VcSB4tCQWt234v3b3BKOjVxk7sO+cwf
	EBmIRv55euwSUMAM1ESoiwFkxiirN0ixUreJ+I0DExOhuni+iE0ekGk2N3A=
X-Google-Smtp-Source: AGHT+IH5lFXS8TrXDVnponeZrwD3UcLQ62ckiic4gVobD0/PCNSTdxDkJvhE1do9gg+6+ORYPJX8Jw==
X-Received: by 2002:a05:6e02:1c02:b0:3d9:24a7:db17 with SMTP id e9e14a558f8ab-3d938e56cdfmr1558875ab.7.1745511473719;
        Thu, 24 Apr 2025 09:17:53 -0700 (PDT)
Received: from purestorage.com ([208.88.159.128])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f824bc4fa5sm327427173.136.2025.04.24.09.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 09:17:53 -0700 (PDT)
Date: Thu, 24 Apr 2025 10:17:50 -0600
From: Michael Liang <mliang@purestorage.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: Michael Liang <mliang@purestorage.com>,
	Mohamed Khalfella <mkhalfella@purestorage.com>,
	Randy Jennings <randyj@purestorage.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/1] nvme-tcp: wait socket wmem to drain in queue stop
Message-ID: <20250424161750.jwbdohybrqftuioe@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250424161438.g2fyo4ozvburf2rh@purestorage.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250424_091754_787383_5B6DCED6 
X-CRM114-Status: GOOD (  18.80  )
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

This patch addresses a data corruption issue observed in nvme-tcp during
testing.

Issue description:
In an NVMe native multipath setup, when an I/O timeout occurs, all inflight
I/Os are canceled almost immediately after the kernel socket is shut down.
These canceled I/Os are reported as host path errors, triggering a failover
that succeeds on a different path.

However, at this point, the original I/O may still be outstanding in the
host's network transmission path (e.g., the NIC’s TX queue). From the
user-space app's perspective, the buffer associated with the I/O is considered
completed since they're acked on the different path and may be reused for new
I/O requests.

Because nvme-tcp enables zero-copy by default in the transmission path,
this can lead to corrupted data being sent to the original target, ultimately
causing data corruption.

We can reproduce this data corruption by injecting delay on one path and
triggering i/o timeout.

To prevent this issue, this change ensures that all inflight transmissions are
fully completed from host's perspective before returning from queue
stop. To handle concurrent I/O timeout from multiple namespaces under
the same controller, always wait in queue stop regardless of queue's state.

This aligns with the behavior of queue stopping in other NVMe fabric transports.

Reviewed-by: Mohamed Khalfella <mkhalfella@purestorage.com>
Reviewed-by: Randy Jennings <randyj@purestorage.com>
Signed-off-by: Michael Liang <mliang@purestorage.com>
---
 drivers/nvme/host/tcp.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 26c459f0198d..8571bb7c029d 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1944,7 +1944,7 @@ static void __nvme_tcp_stop_queue(struct nvme_tcp_queue *queue)
 	cancel_work_sync(&queue->io_work);
 }
 
-static void nvme_tcp_stop_queue(struct nvme_ctrl *nctrl, int qid)
+static void nvme_tcp_stop_queue_nowait(struct nvme_ctrl *nctrl, int qid)
 {
 	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
 	struct nvme_tcp_queue *queue = &ctrl->queues[qid];
@@ -1963,6 +1963,31 @@ static void nvme_tcp_stop_queue(struct nvme_ctrl *nctrl, int qid)
 	mutex_unlock(&queue->queue_lock);
 }
 
+static void nvme_tcp_wait_queue(struct nvme_ctrl *nctrl, int qid)
+{
+	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
+	struct nvme_tcp_queue *queue = &ctrl->queues[qid];
+	int timeout = 100;
+
+	while (timeout > 0) {
+		if (!test_bit(NVME_TCP_Q_ALLOCATED, &queue->flags) ||
+		    !sk_wmem_alloc_get(queue->sock->sk))
+			return;
+		msleep(2);
+		timeout -= 2;
+	}
+	dev_warn(nctrl->device,
+		 "qid %d: timeout draining sock wmem allocation expired\n",
+		 qid);
+}
+
+static void nvme_tcp_stop_queue(struct nvme_ctrl *nctrl, int qid)
+{
+	nvme_tcp_stop_queue_nowait(nctrl, qid);
+	nvme_tcp_wait_queue(nctrl, qid);
+}
+
+
 static void nvme_tcp_setup_sock_ops(struct nvme_tcp_queue *queue)
 {
 	write_lock_bh(&queue->sock->sk->sk_callback_lock);
@@ -2030,7 +2055,9 @@ static void nvme_tcp_stop_io_queues(struct nvme_ctrl *ctrl)
 	int i;
 
 	for (i = 1; i < ctrl->queue_count; i++)
-		nvme_tcp_stop_queue(ctrl, i);
+		nvme_tcp_stop_queue_nowait(ctrl, i);
+	for (i = 1; i < ctrl->queue_count; i++)
+		nvme_tcp_wait_queue(ctrl, i);
 }
 
 static int nvme_tcp_start_io_queues(struct nvme_ctrl *ctrl,
-- 
2.34.1



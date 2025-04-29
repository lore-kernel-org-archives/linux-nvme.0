Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3A51C3ABA5
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Apr 2025 16:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:List-Owner;
	bh=pefWEaJR58I1DW6Re5R2IZ2WUpQtpoC66+IL5oaI87A=; b=IZGaSS01wji6N0Vcj74uGsqoqS
	wkcjaVbvRgB9O0SrzqurmaJ+eVseXynKjQEdejKjAkcrGQiwCncMjBHffNCXeZk6VC1ADl9dgtcp1
	lbai7tLGwwi0ucfaGR49tQI6lG2EjiH9n20yvHdJYjK9LKpgWoPxUUK+qhlsMPDapptFuxaJbC5rt
	XIp++PenEshbGglCbAjA1L5GdhLvqYR8FEkJy3ehNx9LfBrTP1efzbhzW3n8f7jVNvRnK84x0O1FF
	7WK/IVpsM9Oly5KkEZ9De9KopGk24f/X5YiJCPfzDxaRCvvRTrAnEh4w9/u+bpzucGyk4tTsRE9Ez
	50edYHKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9o6Z-0000000AIy3-0FLy;
	Tue, 29 Apr 2025 16:46:47 +0000
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9o21-0000000AI2i-09Fe
	for linux-nvme@lists.infradead.org;
	Tue, 29 Apr 2025 16:42:06 +0000
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-22c33e4fdb8so66906055ad.2
        for <linux-nvme@lists.infradead.org>; Tue, 29 Apr 2025 09:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1745944924; x=1746549724; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pefWEaJR58I1DW6Re5R2IZ2WUpQtpoC66+IL5oaI87A=;
        b=L4OmUE6fZ6OrLM/eHvbYQp+SNZApCLiEk5c6SxBeUrmEVE+4ei8W504UzbvPYnuENS
         nJtqWTCYMBjl2WPvf6hbg4/pQFAwT2uDudpIzBydIH1VZfyr0nq/7Zcrlt1oxoatNatr
         kLa/B0dSFnExYdaWdxgxdcqcAYEigqjByYwPTRWomxfcln+e5ZRrlZlR2Q4tVEKfFMh+
         JIHjQ8fg1IElNBP7oWXKb85oAXfjqWgY/lMwuyuE1ux+k0wz9pWD+Dn2P4U5Wg9IGBbn
         I+ge1JarpJPTDX/qXfT+SQwExrJBRI5FXPVH1YsYin3giS5q4AsIxyvEDu//1JHdqEon
         rYPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745944924; x=1746549724;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pefWEaJR58I1DW6Re5R2IZ2WUpQtpoC66+IL5oaI87A=;
        b=SeFfNPIYYsiF/SOZl21A3JtmI55YSbp6Vm0KEiUl//qh6xcUuzMM5PA/sLtlNCPLSL
         rtdKMJmaj4ao44LdKUdWcSK/FyVLeaXGnTe3cZvA+uVHS2Pro83fn0knwW14r/Lpdb/v
         p8Inx0fkocjZaXLtaix4olor1L101Q2+3LBTvJhE9UvfIOwzHaRIJQC0ZaTDl6ATN1WJ
         UuR7PPIs1ihGLpXdiOzP6czswxgcLyAP5WSfVu7H0yNdhII9SSC3zsX2fuOb8+PZHRTl
         Juk29gren+kscB4vsaSfclpIM1Qt+/So3+EDTJCL37LWU3Liw22YET6i7VvIY7FUD1Go
         tSnw==
X-Forwarded-Encrypted: i=1; AJvYcCWiWhYVGn9H7BpRC1qz/6oT6wu+WXF8qHSLulBsrqhJBWi+ErrrLiSILM4HUi1gctf75GRcf0xHIc0s@lists.infradead.org
X-Gm-Message-State: AOJu0YwDdR1ALr3cpW2NWPuAFV8iG1EZwlFf3QWWknTvV65ESU7vm7R3
	wV9CnqHGpjq5mKclukwL/9Rt8qObVB4+mOFnRgpFTMqutTrHq1RODS7jjNn2irDga6nu4/8UpU9
	QbNM=
X-Gm-Gg: ASbGncu/670a6lnE1zDOCEDAA3LmvTdxbDxXJlmhCG5KkTVYp1EPIg48odirZldV+Gp
	sW2ToD6Z8YTZR3pfHUf07Aj2nbTiHyfMy6yJW/tAFN3Xwq/RcDfwBr7JUH7NfGq3sdJUs3ccdAc
	nFtQ71W9q1PmgM22sQPDlnKrJ8+vkbPACVeVOGr2UGZ7j0mZAR6DmMxg2eBhJJ5hz7/ghP+KS72
	k+6BvIkeFIdDGKDePJOlsWSUqoDjYbnJla022GcZbNi0IwAOAC+D9+YWqvV0he4rP9UR53Dyudg
	kaY4O1bTHfZjPo9+a9abMgqENtG9/+XGKW0GDcFoy5MDK6wQC//ywSt1JI4=
X-Google-Smtp-Source: AGHT+IH5o/i8TupfS+vCAy3e6IA5VnC+eiF2cN/N7PwRE+z9CtiQxWbE4TRVt6/wO5YLJSkO1vmKSQ==
X-Received: by 2002:a17:902:ce10:b0:22d:e57a:27b9 with SMTP id d9443c01a7336-22df34ebcd8mr1106525ad.22.1745944924349;
        Tue, 29 Apr 2025 09:42:04 -0700 (PDT)
Received: from purestorage.com ([208.88.159.128])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db5216930sm105123485ad.236.2025.04.29.09.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 09:42:03 -0700 (PDT)
Date: Tue, 29 Apr 2025 10:42:01 -0600
From: Michael Liang <mliang@purestorage.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: Michael Liang <mliang@purestorage.com>,
	Mohamed Khalfella <mkhalfella@purestorage.com>,
	Randy Jennings <randyj@purestorage.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/1] nvme-tcp: fix possible data corruption caused by
 premature queue removal and I/O failover
Message-ID: <20250429164201.cmrhsz5p45q4ceca@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250429163944.tvyrxt7z6c55abk2@purestorage.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250429_094205_075142_E193FCA2 
X-CRM114-Status: GOOD (  19.70  )
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

Fixes: 3f2304f8c6d6 ("nvme-tcp: add NVMe over TCP host driver")

Reviewed-by: Mohamed Khalfella <mkhalfella@purestorage.com>
Reviewed-by: Randy Jennings <randyj@purestorage.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Michael Liang <mliang@purestorage.com>
---
 drivers/nvme/host/tcp.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 72d260201d8c..aba365f97cf6 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1946,7 +1946,7 @@ static void __nvme_tcp_stop_queue(struct nvme_tcp_queue *queue)
 	cancel_work_sync(&queue->io_work);
 }
 
-static void nvme_tcp_stop_queue(struct nvme_ctrl *nctrl, int qid)
+static void nvme_tcp_stop_queue_nowait(struct nvme_ctrl *nctrl, int qid)
 {
 	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
 	struct nvme_tcp_queue *queue = &ctrl->queues[qid];
@@ -1965,6 +1965,31 @@ static void nvme_tcp_stop_queue(struct nvme_ctrl *nctrl, int qid)
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
@@ -2032,7 +2057,9 @@ static void nvme_tcp_stop_io_queues(struct nvme_ctrl *ctrl)
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



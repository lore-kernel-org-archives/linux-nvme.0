Return-Path: <SRS0=/7z5=N7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FAFCC433EF
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Sep 2021 15:55:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EA8A61101
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Sep 2021 15:55:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1EA8A61101
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=6z7EFgGtraoKg36GoX5UW2ymwbVwRa1zSsPc4Gy6Yd8=; b=fO8vyK7AdXr7r6
	Hzmy16G0nw2KvfpVBsdA7NVKjoLdOqJCO+JeB5OqrPOoUR9gqtrS1WLVrLrzT45aw7/eq734uGuhs
	zSXkSOcBo3WwwcmfTMFEWl1R+63J2lf7v9NoRGjXNo6UBCu/fAjYiETrlVEiKIV3Udpe+ZxvFuuYo
	nqtyutEiNxP47oK5FPXNdf9eHSu5cot+MepeBLr+QCOFINVpQNmsOxa2r2GOyeazdSlzanC5r0kli
	ELaz7jtK53SPYQp1LI1iQugknqOs1WakPZ7a3zlOUzuOUlw81hOTzKIDILE44foxzKVS1bXuFTJtZ
	uY4+GJT0kNEHpShHgO4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mOMOI-00AIwG-Ii; Thu, 09 Sep 2021 15:55:06 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mOMOG-00AIvw-8T
 for linux-nvme@lists.infradead.org; Thu, 09 Sep 2021 15:55:05 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 730AB61101;
 Thu,  9 Sep 2021 15:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1631202903;
 bh=HBesbaNbpLjvossZE3SwzJpVVGyYXQqJMRS/fvdcTXw=;
 h=From:To:Cc:Subject:Date:From;
 b=XypJUSL/CTFMoHgcZhatBW9YCIFmDNrZUkWXcd7LsoomO7nG8PxU028W6pM8HIVny
 B2a1VWtzbnR054SlAK8euXPi4Ogmu9VACzkRqhBgu52V0VuRMiatcdoy39ZZ2Ufda1
 ndqjS7eTfL4x5cEHIa/gxNq4CSNwDaZuLI+TQxtuOhqCQ21px6GD4lmUfIVdlLeZKe
 ptnreVqQEHTgNVtIvd0GwK7AbWvyVHXiG/e8QgK766dwtX3938VRzsAlRfAArUN6fF
 G0rbC7P6iTI4pyJiZHYahvexy7Nhc9ioExSQORjeS6eaNsdOacNls3kvNdt+NR9TM/
 I5QTpUsnXxItA==
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org,
	sagi@grimberg.me
Cc: hch@lst.de, Keith Busch <kbusch@kernel.org>,
 Samuel Jones <sjones@kalrayinc.com>
Subject: [PATCH] nvme-tcp: Fix io_work priority inversion
Date: Thu,  9 Sep 2021 08:54:52 -0700
Message-Id: <20210909155452.2601605-1-kbusch@kernel.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210909_085504_361009_4DF7B960 
X-CRM114-Status: GOOD (  11.97  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Dispatching requests inline with the .queue_rq() call may block while
holding the send_mutex. If the tcp io_work also happens to schedule, it
may see the req_list is non-empty, leaving "pending" true and remaining
in TASK_RUNNING. Since io_work is of higher scheduling priority, the
.queue_rq task may not get a chance to run, blocking forward progress
and leading to io timeouts.

Instead of checking for pending requests within io_work, let the queueing
restart io_work outside the send_mutex lock if there is more work to be
done.

Fixes: a0fdd1418007f ("nvme-tcp: rerun io_work if req_list is not empty")
Reported-by: Samuel Jones <sjones@kalrayinc.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/tcp.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index e2ab12f3f51c..e4249b7dc056 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -274,6 +274,12 @@ static inline void nvme_tcp_send_all(struct nvme_tcp_queue *queue)
 	} while (ret > 0);
 }
 
+static inline bool nvme_tcp_queue_more(struct nvme_tcp_queue *queue)
+{
+	return !list_empty(&queue->send_list) ||
+		!llist_empty(&queue->req_list) || queue->more_requests;
+}
+
 static inline void nvme_tcp_queue_request(struct nvme_tcp_request *req,
 		bool sync, bool last)
 {
@@ -294,9 +300,10 @@ static inline void nvme_tcp_queue_request(struct nvme_tcp_request *req,
 		nvme_tcp_send_all(queue);
 		queue->more_requests = false;
 		mutex_unlock(&queue->send_mutex);
-	} else if (last) {
-		queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
 	}
+
+	if (last && nvme_tcp_queue_more(queue))
+		queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
 }
 
 static void nvme_tcp_process_req_list(struct nvme_tcp_queue *queue)
@@ -906,12 +913,6 @@ static void nvme_tcp_state_change(struct sock *sk)
 	read_unlock_bh(&sk->sk_callback_lock);
 }
 
-static inline bool nvme_tcp_queue_more(struct nvme_tcp_queue *queue)
-{
-	return !list_empty(&queue->send_list) ||
-		!llist_empty(&queue->req_list) || queue->more_requests;
-}
-
 static inline void nvme_tcp_done_send_req(struct nvme_tcp_queue *queue)
 {
 	queue->request = NULL;
@@ -1145,8 +1146,7 @@ static void nvme_tcp_io_work(struct work_struct *w)
 				pending = true;
 			else if (unlikely(result < 0))
 				break;
-		} else
-			pending = !llist_empty(&queue->req_list);
+		}
 
 		result = nvme_tcp_try_recv(queue);
 		if (result > 0)
-- 
2.25.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

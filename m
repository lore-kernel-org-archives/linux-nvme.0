Return-Path: <SRS0=VXwX=67=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED60BC433E0
	for <linux-nvme@archiver.kernel.org>; Sun, 17 May 2020 11:15:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFB092065F
	for <linux-nvme@archiver.kernel.org>; Sun, 17 May 2020 11:15:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XPpkeUla"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFB092065F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=EixAf8pZMnWnxowzM/MUgF/p5SHuspVdm849y4+Zjt0=; b=XPpkeUla9FO7dd
	9zaCLhn+ZCXWZx0smKZ+tacWcGIPN//uFQdg1vQ0O33nQxc6xpaivw4iRYRLJummVn4wGr0fMYRcu
	3ipHfhioeQDCnDeDA72SGAKFoaoeBnEQtbpMdNTRiJwIf99Ve4tOWFG47lWnNbwonj59NT71rJ+aO
	QeHAGGqNrFo/PsuRVi6anFBkuJwCXIM1mCt4rvBlUrmKHgVPzfUkHNkJaz5jIxKalSqIQ1K9xPjkd
	vWtVze9bEmr4txI3H1EvRX5rtEoq4lgY7AnJK/LhdjEwrNdDb2IBjCz6EU+bRjzN+W8/qfAVxq+16
	YO+Jt0JjHRGix/Y9ZsRg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jaHGQ-0002XD-D0; Sun, 17 May 2020 11:15:26 +0000
Received: from [2601:647:4802:9070:9584:7115:351c:7013]
 (helo=sagi-Latitude-7490.hsd1.ca.comcast.net)
 by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jaHGN-0002WU-R6; Sun, 17 May 2020 11:15:24 +0000
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH] nvmet-tcp: move send/recv error handling in the send/recv
 methods instead of call-sites
Date: Sun, 17 May 2020 04:15:22 -0700
Message-Id: <20200517111522.6105-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Have routines handle errors and just bail out of the poll loop. This simplifies
the code and will help as we may enhance the poll loop logic and these are somewhat
in the way.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/target/tcp.c | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index f8dd69f3b657..9527cdc19611 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -723,6 +723,13 @@ static int nvmet_tcp_try_send(struct nvmet_tcp_queue *queue,
 		(*sends)++;
 	}
 
+	if (ret < 0) {
+		if (ret == -EPIPE || ret == -ECONNRESET)
+			kernel_sock_shutdown(queue->sock, SHUT_RDWR);
+		else
+			nvmet_tcp_fatal_error(queue);
+	}
+
 	return ret;
 }
 
@@ -1164,6 +1171,13 @@ static int nvmet_tcp_try_recv(struct nvmet_tcp_queue *queue,
 		(*recvs)++;
 	}
 
+	if (ret < 0) {
+		if (ret == -EPIPE || ret == -ECONNRESET)
+			kernel_sock_shutdown(queue->sock, SHUT_RDWR);
+		else
+			nvmet_tcp_fatal_error(queue);
+	}
+
 	return ret;
 }
 
@@ -1188,27 +1202,16 @@ static void nvmet_tcp_io_work(struct work_struct *w)
 		pending = false;
 
 		ret = nvmet_tcp_try_recv(queue, NVMET_TCP_RECV_BUDGET, &ops);
-		if (ret > 0) {
+		if (ret > 0)
 			pending = true;
-		} else if (ret < 0) {
-			if (ret == -EPIPE || ret == -ECONNRESET)
-				kernel_sock_shutdown(queue->sock, SHUT_RDWR);
-			else
-				nvmet_tcp_fatal_error(queue);
+		else if (ret < 0)
 			return;
-		}
 
 		ret = nvmet_tcp_try_send(queue, NVMET_TCP_SEND_BUDGET, &ops);
-		if (ret > 0) {
-			/* transmitted message/data */
+		if (ret > 0)
 			pending = true;
-		} else if (ret < 0) {
-			if (ret == -EPIPE || ret == -ECONNRESET)
-				kernel_sock_shutdown(queue->sock, SHUT_RDWR);
-			else
-				nvmet_tcp_fatal_error(queue);
+		else if (ret < 0)
 			return;
-		}
 
 	} while (pending && ops < NVMET_TCP_IO_WORK_BUDGET);
 
-- 
2.25.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

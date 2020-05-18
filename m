Return-Path: <SRS0=Nwsb=7A=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B2CC433E0
	for <linux-nvme@archiver.kernel.org>; Mon, 18 May 2020 17:47:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03A3020829
	for <linux-nvme@archiver.kernel.org>; Mon, 18 May 2020 17:47:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ujgc9DNg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03A3020829
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=bHCO/LKeqG4Z7ofJ1a8NjVDpMHFQqL8HKU8R0fGmRm4=; b=ujgc9DNgjY7FQj
	RTEammI+0/lSxmRiOQaFuIX73gK4Er0FcpK3JhmgrGUiiMU1bOhaF1pnSbklC34JzOkGTIIKe2lze
	vZJi849cDAuVO5uAEfJVdR63j13hbhF7f3VdNuH5uFfkZvBUICcP1a0CIlCA9nmEvWshvunf4CB8k
	tlwA8Ch8vspUOP3jy08UENH6o6Qil2mF7jU+gXuqUiEnhB8PHZDnUToDWt3FR/hYJ/Qfaa84oaXZ8
	ytpAHbsjEKwvFoEkaN6KMZOhOScS8kdlD7KPt9Eos56bhkPXm3IJHxyCBo+TaTeqdlYnU8LtgBM5f
	iR/bQOkqbuZ/S8FgLwCA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jajrj-0008DT-RX; Mon, 18 May 2020 17:47:51 +0000
Received: from [2601:647:4802:9070:507e:6065:a37d:f691]
 (helo=sagi-Latitude-7490.hsd1.ca.comcast.net)
 by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jajri-0008D5-0I; Mon, 18 May 2020 17:47:50 +0000
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2] nvmet-tcp: move send/recv error handling in the send/recv
 methods instead of call-sites
Date: Mon, 18 May 2020 10:47:48 -0700
Message-Id: <20200518174748.63691-1-sagi@grimberg.me>
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

Have routines handle errors and just bail out of the poll loop.
This simplifies the code and will help as we may enhance the poll
loop logic and these are somewhat in the way.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
Changes from v1:
- consolidate error handling in helper
- adjust send/recv loops to be slightly more readable for the error case

 drivers/nvme/target/tcp.c | 43 ++++++++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 19 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index f8dd69f3b657..6f557db0320d 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -325,6 +325,14 @@ static void nvmet_tcp_fatal_error(struct nvmet_tcp_queue *queue)
 		kernel_sock_shutdown(queue->sock, SHUT_RDWR);
 }
 
+static void nvmet_tcp_socket_error(struct nvmet_tcp_queue *queue, int status)
+{
+	if (status == -EPIPE || status == -ECONNRESET)
+		kernel_sock_shutdown(queue->sock, SHUT_RDWR);
+	else
+		nvmet_tcp_fatal_error(queue);
+}
+
 static int nvmet_tcp_map_data(struct nvmet_tcp_cmd *cmd)
 {
 	struct nvme_sgl_desc *sgl = &cmd->req.cmd->common.dptr.sgl;
@@ -718,11 +726,15 @@ static int nvmet_tcp_try_send(struct nvmet_tcp_queue *queue,
 
 	for (i = 0; i < budget; i++) {
 		ret = nvmet_tcp_try_send_one(queue, i == budget - 1);
-		if (ret <= 0)
+		if (unlikely(ret < 0)) {
+			nvmet_tcp_socket_error(queue, ret);
+			goto done;
+		} else if (ret == 0) {
 			break;
+		}
 		(*sends)++;
 	}
-
+done:
 	return ret;
 }
 
@@ -1159,11 +1171,15 @@ static int nvmet_tcp_try_recv(struct nvmet_tcp_queue *queue,
 
 	for (i = 0; i < budget; i++) {
 		ret = nvmet_tcp_try_recv_one(queue);
-		if (ret <= 0)
+		if (unlikely(ret < 0)) {
+			nvmet_tcp_socket_error(queue, ret);
+			goto done;
+		} else if (ret == 0) {
 			break;
+		}
 		(*recvs)++;
 	}
-
+done:
 	return ret;
 }
 
@@ -1188,27 +1204,16 @@ static void nvmet_tcp_io_work(struct work_struct *w)
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

Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 135B5C4345F
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Apr 2024 10:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=oQaRw7Oj/C81Ej7sOz/Y5rzAMPqbJvlbeuQDNN5p9i8=; b=f2LVYy19uCzwL8oYFoM9xBVfoW
	8n+6VbTHEHcKWMMCAc/jM4xXtyviLN2EJb9eH0DMSwTSbLXmujvsu6i4IGkVhP5B/Ii+CXO03UpnK
	Q7fpZbB2lZmnvIIxdPSu26t58eC8iqRM1eIsO26jdxTLCgBXigrx1ysuhM3ADD+H+RG6wMsg/ldcM
	BRjvAD17nMOx2kv3wnt34VTUtAAaGng2QiqziIhi6MSihgLvtctG72t08QLm5aFnTawVdsuMHnk57
	orWtw+KwuHqYz70f1+FeQj5+ciRsrwwtDSTBK5co6mYA7Wss2/96PJV16PPstYlkXNqUn3vbePSH3
	5psDa8WA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxPBP-00000001qRb-1cfw;
	Thu, 18 Apr 2024 10:39:59 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxPBM-00000001qR4-2LRI
	for linux-nvme@lists.infradead.org;
	Thu, 18 Apr 2024 10:39:58 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 9E528617AA;
	Thu, 18 Apr 2024 10:39:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AC7AC113CC;
	Thu, 18 Apr 2024 10:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713436795;
	bh=MFsccl083Pj6KxU3p9VrsYSvBkSldVGgT9VhEp5OvqI=;
	h=From:To:Cc:Subject:Date:From;
	b=XAt2vSNpBmOWQFQ7FSl2KhpVWEiCT0U4dw+Do/nKG/LrQlCkBAygIyCeksFC8++b6
	 4onTRwRHCPgu+f4ZRVPYC+NcGfzWWFAObEv4bYHaHbIOxMMaHbLgILpbZK4rO8BANl
	 /B/Rec+WPhp402FeG/ungdyhap9yze1nnTfKEp4RsGGNNhDem2+c4Qh9/HBIZZYqnC
	 6EDX5+/SgPep52RL7RnBnwawY5p8FJcchSx0d3DK3zDACNFatZdPUaauHAELERvNFN
	 hwl0K55TJ0SfkbHgRYPLDdZ1HZgJrD9ZLezoUhAF2SqvcuCoLWeVCO3o9tp/rhoyrk
	 1jbGY2uh1l1Bw==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCHv3] nvme-tcp: strict pdu pacing to avoid send stalls on TLS
Date: Thu, 18 Apr 2024 12:39:45 +0200
Message-Id: <20240418103945.140664-1-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240418_033956_665101_8EDAA87B 
X-CRM114-Status: GOOD (  13.74  )
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

TLS requires a strict pdu pacing via MSG_EOR to signal the end
of a record and subsequent encryption. If we do not set MSG_EOR
at the end of a sequence the record won't be closed, encryption
doesn't start, and we end up with a send stall as the message
will never be passed on to the TCP layer.
So do not check for the queue status when TLS is enabled but
rather make the MSG_MORE setting dependent on the current
request only.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/host/tcp.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index fdbcdcedcee9..28bc2f373cfa 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -360,12 +360,18 @@ static inline void nvme_tcp_send_all(struct nvme_tcp_queue *queue)
 	} while (ret > 0);
 }
 
-static inline bool nvme_tcp_queue_more(struct nvme_tcp_queue *queue)
+static inline bool nvme_tcp_queue_has_pending(struct nvme_tcp_queue *queue)
 {
 	return !list_empty(&queue->send_list) ||
 		!llist_empty(&queue->req_list);
 }
 
+static inline bool nvme_tcp_queue_more(struct nvme_tcp_queue *queue)
+{
+	return !nvme_tcp_tls(&queue->ctrl->ctrl) &&
+		nvme_tcp_queue_has_pending(queue);
+}
+
 static inline void nvme_tcp_queue_request(struct nvme_tcp_request *req,
 		bool sync, bool last)
 {
@@ -386,7 +392,7 @@ static inline void nvme_tcp_queue_request(struct nvme_tcp_request *req,
 		mutex_unlock(&queue->send_mutex);
 	}
 
-	if (last && nvme_tcp_queue_more(queue))
+	if (last && nvme_tcp_queue_has_pending(queue))
 		queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
 }
 
-- 
2.35.3



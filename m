Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ADAEC77B60
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Mar 2023 14:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yc73cb87to5yOKPMT4Ee0wUEWUPkoF7QiuTu0kGyZmM=; b=APggtDvRt8aJGjbs7N8LAIeb+Q
	1eXipFeVE9CFdmnx5SaTSvo3gP5Xjfqh+HsTOzfkO79+rvruoWRH3/PBiRC+XbmrJjkDBwsLPCx9V
	SxZgPzQZRadhVX6zzkEG2ejy0DikWzp5fgakG9gQMtygiJhHONLuTWxmjlpZ0oPpAdIyRliHl6C5J
	e2FFFxQotbjjrmHJamwBeSPqEAktTE7zekqZ9mfaFl90oEHxDZxCXNI+MGN+K8/kfke+cpl+uasZC
	8Hj7P2teIhkozyBuGP0Vl+TNwt8tC2WgkF5mKKta7j14vPnfOuEnTpssZm/596EPOtkqRuSoFhpBG
	IYLDegtQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1phWLQ-000UtE-1l;
	Wed, 29 Mar 2023 14:00:08 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1phWLD-000Uh3-2X
	for linux-nvme@lists.infradead.org;
	Wed, 29 Mar 2023 13:59:58 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id C13D11FDE8;
	Wed, 29 Mar 2023 13:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1680098389; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yc73cb87to5yOKPMT4Ee0wUEWUPkoF7QiuTu0kGyZmM=;
	b=uhZNMbg4cVUO3cB6yCS1K6zqev5+Gst4TSCcQsDncZTQfMt48OSl9ExC7LWQP0L38QVOg3
	MUvitkh3jSPezitODVm6iTG7ABfYHNZGAaMQdZkavjkHQXyCU39+07lUG1aPpJl443EDpM
	16WdZlvmytdQkFqol6eYkrZUUm1jbQ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1680098389;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yc73cb87to5yOKPMT4Ee0wUEWUPkoF7QiuTu0kGyZmM=;
	b=Y0t3ou0iGfAF2jgc86URnr2dWV1kDDjyqOkltwPXTJWsqRB8rn4GjA8qvHccCT9djNWmkk
	3y1RZaRNtCNX5sCA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id A71312C175;
	Wed, 29 Mar 2023 13:59:49 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 9BC8751BF37E; Wed, 29 Mar 2023 15:59:49 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Chuck Lever <chuck.lever@oracle.com>,
	kernel-tls-handshake@lists.linux.dev,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 06/18] nvme/tcp: allocate socket file
Date: Wed, 29 Mar 2023 15:59:26 +0200
Message-Id: <20230329135938.46905-7-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230329135938.46905-1-hare@suse.de>
References: <20230329135938.46905-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230329_065955_985598_54506F38 
X-CRM114-Status: GOOD (  14.25  )
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

When using the TLS upcall we need to allocate a socket file such
that the userspace daemon is able to use the socket.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/tcp.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 42c0598c31f2..fddf785aba74 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -115,6 +115,7 @@ enum nvme_tcp_recv_state {
 struct nvme_tcp_ctrl;
 struct nvme_tcp_queue {
 	struct socket		*sock;
+	struct file		*sock_file;
 	struct work_struct	io_work;
 	int			io_cpu;
 
@@ -1330,7 +1331,10 @@ static void nvme_tcp_free_queue(struct nvme_ctrl *nctrl, int qid)
 	}
 
 	noreclaim_flag = memalloc_noreclaim_save();
-	sock_release(queue->sock);
+	/* ->sock will be released by fput() */
+	fput(queue->sock_file);
+	queue->sock_file = NULL;
+	queue->sock = NULL;
 	memalloc_noreclaim_restore(noreclaim_flag);
 
 	kfree(queue->pdu);
@@ -1526,6 +1530,13 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid)
 		goto err_destroy_mutex;
 	}
 
+	queue->sock_file = sock_alloc_file(queue->sock, O_CLOEXEC, NULL);
+	if (IS_ERR(queue->sock_file)) {
+		sock_release(queue->sock);
+		ret = PTR_ERR(queue->sock_file);
+		queue->sock_file = NULL;
+		goto err_sock;
+	}
 	nvme_tcp_reclassify_socket(queue->sock);
 
 	/* Single syn retry */
@@ -1647,7 +1658,9 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid)
 	if (queue->hdr_digest || queue->data_digest)
 		nvme_tcp_free_crypto(queue);
 err_sock:
-	sock_release(queue->sock);
+	/* ->sock will be released by fput() */
+	fput(queue->sock_file);
+	queue->sock_file = NULL;
 	queue->sock = NULL;
 err_destroy_mutex:
 	mutex_destroy(&queue->send_mutex);
-- 
2.35.3


